cmake_minimum_required(VERSION 3.1.2)
project("CUTEX"
  LANGUAGES CXX
  VERSION 1.0.1
  )

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/modules")

string(TOUPPER ${PROJECT_NAME} ${PROJECT_NAME}_UPPER)
string(TOLOWER ${PROJECT_NAME} ${PROJECT_NAME}_LOWER)

include("Base")
include("Options")
include("Dependencies")

option(${${PROJECT_NAME}_UPPER}_ENABLE_TESTS
  "Build and run the ${PROJECT_NAME} unit tests."
  ON
)

add_subdirectory("include")

if(${${PROJECT_NAME}_UPPER}_ENABLE_TESTS AND NOT BUILD_DOCUMENTATION_ONLY)
  include("CUTE")
  add_subdirectory(test)
endif()

install(EXPORT ${PROJECT_NAME}
  DESTINATION "share/${PROJECT_NAME}/cmake"
  )

export(EXPORT ${PROJECT_NAME})
