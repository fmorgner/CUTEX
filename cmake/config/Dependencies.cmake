include("ExternalDependency")
set(${${PROJECT_NAME}_UPPER}_DEPS)

if(EXTERNAL_DEPS_VIA STREQUAL "conan")
  include("ConanPackages")
  if(${${${PROJECT_NAME}_UPPER}_ENABLE_TESTS})
    list(APPEND CONAN_OPTIONS ${CONAN_OPTIONS} CUTEX:test=True)
  endif()
  install_conan_packages(SYSTEM_HEADERS
    PKGOPTS ${CONAN_OPTIONS}
    )
  list(APPEND ${${PROJECT_NAME}_UPPER}_DEPS
    CONAN_PKG::CUTE
    )
elseif(EXTERNAL_DEPS_VIA STREQUAL "git")
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
  message(FATAL_ERROR "Unknown dependency resolution mechanism '${EXTERNAL_DEPS_VIA}'")
endif()
