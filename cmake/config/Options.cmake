set(${${PROJECT_NAME}_UPPER}_DEPS_VIA "git"
  CACHE STRING
  "The dependency resolution mechanism to use for ${PROJECT_NAME}"
  )

set_property(CACHE ${${PROJECT_NAME}_UPPER}_DEPS_VIA
  PROPERTY
  STRINGS
  "git"
  "conan"
  )

option(${${PROJECT_NAME}_UPPER}_ENABLE_TESTS
  "Build and run the ${PROJECT_NAME} unit tests."
  OFF
  )
