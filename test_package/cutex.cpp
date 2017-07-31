#include "cute/cute.h"
#include "cute/cute_runner.h"
#include "cute/ostream_listener.h"
#include "cutex/descriptive_suite.h"

CUTE_DESCRIPTIVE_STRUCT(cutex_package_test)
  {
  static cute::suite suite()
    {
    return {CUTE_DESCRIPTIVE_SMEMFUN(test_conan_package)};
    }

  void test_conan_package()
    {
    ASSERTM("Conan package test failed!", true);
    }
  };

int main(int argc, char * * argv)
  {
  auto listener = cute::ostream_listener<>{};
  auto runner = cute::makeRunner(listener, argc, argv);

  return !CUTE_DESCRIPTIVE_RUN(cutex_package_test, runner);
  }
