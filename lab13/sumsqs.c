/* sumsqs.c - example of iteration in C language.  Richard Brown 9/2010 */

#include <stdio.h>

int main() {
  int n;
  int result = 0;
  int i;

  printf("Enter a positive integer:  ");
  scanf("%d", &n);

  i = 0;
  while (i <= n) {
    result = result + i*i;
    i++;
  }

  printf("The sum of the first %d squares is %d.\n", n, result);
  return 0;
}
