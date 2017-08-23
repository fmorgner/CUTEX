include("ExternalDependency")
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
