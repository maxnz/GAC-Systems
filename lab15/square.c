#include <stdio.h>

int square(int x) {
  return x*x;
}

int main() {
  int n, sq;
  printf("Enter a positive integer:  ");
  scanf("%d", &n);
  sq = square(n);
  printf("The square of %d is %d\n", n, sq);
  return 0;  
}
