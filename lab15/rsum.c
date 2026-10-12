/* recursive summation example.  Richard Brown 10/21/2019 */

#include <stdio.h>

/* sum() computes the sum of positive integers from 1 to n, inclusive*/
int sum(int n) {
  if (n <= 0)
    return 0;
  return n + sum(n-1);
}

int main() {
  int val;
  printf("Enter a non-negative integer: ");
  scanf("%d", &val);

  int s = sum(val);
  printf("The sum of the first %d positive integers is %d\n", val, s);

  return 0;
}
