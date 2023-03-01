#include <gtest/gtest.h>
#include "goo.h"

// 
TEST(GooTest, TestGetValueWithABNegative) {
  EXPECT_EQ(getValue(-3, -1), -1);
}

// 
TEST(GooTest, TestGetValueWithABNegative_1) {
  EXPECT_EQ(getValue(-3, -5), 0);
}

// 
TEST(GooTest, TestGetValueWithPositive) {
  EXPECT_EQ(getValue(5, 5), 25);
}


