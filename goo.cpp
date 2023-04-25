#include "goo.h"

int getValue(int a, int b)
{
    if ((a > 0) || (b > 0)) {
        return a * b;
    }

    if (a > b) {
        return a;
    } else {
        return b;
    }

    return 0;     //parasoft-cov-suppress ALL "Legacy code - accepted"
} 

int findGCD(int n1, int n2) {
  int hcf = 0;
  
  if ( n2 > n1) {   
    int temp = n2;
    n2 = n1;
    n1 = temp;
  }
    
  for (int i = 1; i <=  n2; ++i) {
    if (n1 % i == 0 && n2 % i ==0) {
      
      hcf = i;
    }
  }

  return hcf;
}
