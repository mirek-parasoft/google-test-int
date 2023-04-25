#include <gtest/gtest.h>
#include "goo.h"


TEST(GooTest, TestGetValueWithABNegative) {
  EXPECT_EQ(getValue(-3, -1), -1);
}

TEST(GooTest, TestGetValueWithABNegative_2) {
  EXPECT_EQ(getValue(-3, 5), -15);
}

TEST(GooTest, TestGetValueWithABNegative_1) {
  EXPECT_EQ(getValue(-3, -5), -3);
}

TEST(GooTest, TestFind_GCD_1) {
  EXPECT_EQ(findGCD(25, 5), 5);
}

TEST(GooTest, TestFind_GCD_2) {
  EXPECT_EQ(findGCD(7, 49), 7);
}

TEST(GooTest, TestFind_GCD_3) {
  EXPECT_EQ(findGCD(10, 10), 10);
}

TEST(GooTest, TestFind_GCD_4) {
  EXPECT_EQ(findGCD(12, 11), 0);
}




