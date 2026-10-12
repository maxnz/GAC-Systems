#include <stdio.h>

int prod(int a) {
  return a*10;
}

int main() {
  int n, p=1;
  printf("Enter a positive integer:  ");
  scanf("%d", &n);
  
  while (n > 0) {
    p = prod(p);
    n--;
  }
  printf("the power 10^n is %d\n", p);
  return 0;
}
