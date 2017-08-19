include(CMakeParseArguments)

macro(EXTERNAL_DEPENDENCY)
  set(OPTS   CMAKE)
  set(SVARGS NAME LIBNAME REPO)
  set(MVARGS INCLUDE_DIRECTORIES DEPENDENCIES)

  cmake_parse_arguments(DEP
    "${OPTS}"
    "${SVARGS}"
    "${MVARGS}"
    ${ARGN}
    )

  if(NOT GIT_FOUND)
    find_package(Git REQUIRED)
  endif()

  file(MAKE_DIRECTORY ${${${PROJECT_NAME}_UPPER}_DEPENDENCIES_DIR})
  if(NOT EXISTS ${${${PROJECT_NAME}_UPPER}_DEPENDENCIES_DIR}/${DEP_NAME})
    execute_process(COMMAND ${GIT_EXECUTABLE}
      clone ${DEP_REPO} ${DEP_NAME}
      WORKING_DIRECTORY ${${${PROJECT_NAME}_UPPER}_DEPENDENCIES_DIR}
      )
  endif()

  if(DEP_CMAKE)
    add_subdirectory(${${${PROJECT_NAME}_UPPER}_DEPENDENCIES_DIR}/${DEP_NAME})
    list(APPEND ${${PROJECT_NAME}_UPPER}_DEPS
      ${DEP_LIBNAME}
      )
  else()
    include_directories(SYSTEM ${DEP_INCLUDE_DIRECTORIES})
    add_library(${DEP_LIBNAME} INTERFACE)
    target_link_libraries(${DEP_LIBNAME} INTERFACE
      ${DEP_DEPENDENCIES}
      )
    target_include_directories(${DEP_LIBNAME} SYSTEM INTERFACE
      ${DEP_INCLUDE_DIRECTORIES}
      )
  endif()
endmacro()

set(${${PROJECT_NAME}_UPPER}_DEPS)

if(${${PROJECT_NAME}_UPPER}_DEPS_VIA STREQUAL "conan")
  include("ConanPackages")
  install_conan_packages(SYSTEM_HEADERS
    PKGOPTS ${CONAN_OPTIONS}
    )
  list(APPEND ${${PROJECT_NAME}_UPPER}_DEPS
    CONAN_PKG::CUTE
    )
elseif(${${PROJECT_NAME}_UPPER}_DEPS_VIA STREQUAL "git")
  set(${${PROJECT_NAME}_UPPER}_DEPENDENCIES_DIR "${CMAKE_SOURCE_DIR}/external"
    CACHE PATH
    "External depencies source path"
    FORCE
    )

  external_dependency(
    NAME "CUTE"
    REPO "https://github.com/PeterSommerlad/CUTE"
    INCLUDE_DIRECTORIES "${${${PROJECT_NAME}_UPPER}_DEPENDENCIES_DIR}/CUTE"
    LIBNAME "CUTE"
    )
else()
  message(FATAL_ERROR "Unknown dependency resolution mechanism '${${${PROJECT_NAME}_UPPER}_DEPS_VIA}'")
endif()
