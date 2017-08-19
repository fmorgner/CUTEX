include("ExternalDependency")

set(${${PROJECT_NAME}_UPPER}_DEPS)

if(${${PROJECT_NAME}_UPPER}_DEPS_VIA STREQUAL "conan")
  if(${${PROJECT_NAME}_UPPER}_ENABLE_TESTS)
    include("ConanPackages")
    install_conan_packages(SYSTEM_HEADERS
      PKGOPTS ${CONAN_OPTIONS}
      )
    list(APPEND ${${PROJECT_NAME}_UPPER}_DEPS
      CONAN_PKG::CUTE
      )
  endif()
elseif(${${PROJECT_NAME}_UPPER}_DEPS_VIA STREQUAL "git")
  set(${${PROJECT_NAME}_UPPER}_DEPENDENCIES_DIR "${CMAKE_SOURCE_DIR}/external"
    CACHE PATH
    "External depencies source path"
    FORCE
    )

  if(${${PROJECT_NAME}_UPPER}_ENABLE_TESTS)
    external_dependency(
      NAME "CUTE"
      REPO "https://github.com/PeterSommerlad/CUTE"
      INCLUDE_DIRECTORIES "${${${PROJECT_NAME}_UPPER}_DEPENDENCIES_DIR}/CUTE"
      )
  endif()
else()
  message(FATAL_ERROR "Unknown dependency resolution mechanism '${${${PROJECT_NAME}_UPPER}_DEPS_VIA}'")
endif()
