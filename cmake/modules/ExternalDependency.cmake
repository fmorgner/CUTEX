include(CMakeParseArguments)

macro(EXTERNAL_DEPENDENCY)
  set(OPTS   CMAKE)
  set(SVARGS NAME LIBNAME REPO)
  set(MVARGS INCLUDE_DIRECTORIES)

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
  endif()
endmacro()
