cmake_minimum_required(VERSION 3.1.2)
project("CUTEX"
  LANGUAGES CXX
  VERSION 1.0.1
  )

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")

include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/config/Base.cmake")
include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/config/Options.cmake")
include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/config/Dependencies.cmake")

add_subdirectory("include")

if(${${PROJECT_NAME}_UPPER}_ENABLE_TESTS AND NOT BUILD_DOCUMENTATION_ONLY)
  include("CUTE")
  add_subdirectory(test)
endif()

install(EXPORT ${PROJECT_NAME}
  DESTINATION "share/${PROJECT_NAME}/cmake"
  )

export(EXPORT ${PROJECT_NAME})
