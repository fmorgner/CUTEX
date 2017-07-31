if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/conanfile.txt" OR EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/conanfile.py")
  message(STATUS "Current conanfile.txt directory: ${CMAKE_CURRENT_SOURCE_DIR}")
  if(NOT EXISTS "${CMAKE_BINARY_DIR}/conanbuildinfo.cmake")
    if(${CMAKE_CXX_COMPILER_ID} MATCHES "GNU")
      set(CONAN_COMPILER "gcc")
    elseif(${CMAKE_CXX_COMPILER_ID} MATCHES "Clang")
      set(CONAN_COMPILER "clang")
    else()
      message(FATAL_ERROR "ConanPackages: Unknown compiler ${CMAKE_CXX_COMPILER_ID}")
    endif()

    message(STATUS "Collecting conan packages")
    string(SUBSTRING ${CMAKE_CXX_COMPILER_VERSION} 0 3 CONAN_COMPILER_VERSION)

    execute_process(
      COMMAND
      conan install --build=missing --generator cmake ${CMAKE_CURRENT_SOURCE_DIR} -s compiler=${CONAN_COMPILER} -s compiler.version=${CONAN_COMPILER_VERSION} -s compiler.libcxx=libstdc++
      OUTPUT_QUIET
      )
  endif()
else()
  message(FATAL_ERROR "No conanfile found at '${CMAKE_CURRENT_SOURCE_DIR}/conanfile.txt'")
endif()

include("${CMAKE_BINARY_DIR}/conanbuildinfo.cmake")

set(CONAN_SYSTEM_INCLUDES ON)
conan_basic_setup()
