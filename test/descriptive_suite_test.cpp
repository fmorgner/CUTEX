#include <cutex/descriptive_suite.h>

#include <cute/cute.h>
#include <cute/cute_runner.h>
#include <cute/cute_suite.h>
#include <cute/ostream_listener.h>

#include <iostream>
#include <type_traits>

CUTE_DESCRIPTIVE_STRUCT(descriptive_struct)
  {

  static cute::suite suite()
    {
    return {
      CUTE_SMEMFUN(descriptive_struct, suite_description_is_Descriptive_Struct),
      CUTE_SMEMFUN(descriptive_suite_type, suite_has_3_tests),
      CUTE_DESCRIPTIVE_SMEMFUN(descriptive_suite_type_is_the_same_as_the_struct_itself),
    };
    }

  void suite_description_is_Descriptive_Struct()
    {
    ASSERT_EQUAL("Descriptive Struct", descriptive_struct::description());
    }

  void suite_has_3_tests()
    {
    ASSERT_EQUAL(3, descriptive_struct::suite().size());
    }

  void descriptive_suite_type_is_the_same_as_the_struct_itself()
    {
    ASSERT((std::is_same<descriptive_suite_type, descriptive_struct>{}));
    }

  };

CUTE_DESCRIPTIVE_CLASS(descriptive_class)
  {
  public:
    static cute::suite suite()
      {
      return {
      CUTE_SMEMFUN(descriptive_class, suite_description_is_Descriptive_Class),
      CUTE_SMEMFUN(descriptive_suite_type, suite_has_3_tests),
      CUTE_DESCRIPTIVE_SMEMFUN(descriptive_suite_type_is_the_same_as_the_class_itself),
      };
      }

    void suite_description_is_Descriptive_Class()
      {
      ASSERT_EQUAL("Descriptive Class", descriptive_class::description());
      }

    void suite_has_3_tests()
      {
      ASSERT_EQUAL(3, descriptive_class::suite().size());
      }

  void descriptive_suite_type_is_the_same_as_the_class_itself()
    {
    ASSERT((std::is_same<descriptive_suite_type, descriptive_class>{}));
    }

  };

int main(int argc, char * * argv)
  {
  auto listener = cute::ostream_listener<>{std::clog};
  auto runner = cute::makeRunner(listener, argc, argv);

  auto success = true;

  success &= CUTE_DESCRIPTIVE_RUN(descriptive_struct, runner);
  success &= cute::extensions::runSelfDescriptive<descriptive_class>(runner);

  return !success;
  }
