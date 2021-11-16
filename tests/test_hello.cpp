#include <gtest/gtest.h>
#include "hello.h"

TEST(Greeting, MatchesBuildType) {
#ifdef NDEBUG
    EXPECT_EQ(greeting(), "Hello World Release!");
#else
    EXPECT_EQ(greeting(), "Hello World Debug!");
#endif
}
