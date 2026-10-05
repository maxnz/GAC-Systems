#include <stdio.h>

long prod(long a) {
  return a*10;
}

long power(long n) {
  long p = 1;
  while (n > 0) {
    p = prod(p);
    n--;
  }
  return p;
}

int main() {
  int n;
  long p=1;
  printf("Enter a positive integer:  ");
  scanf("%d", &n);
  
  printf("the power 10^n is %ld\n", power(n));
  return 0;
}
