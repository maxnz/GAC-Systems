/* addints.c - add input integers */

#include <stdio.h>

int main() {
  printf("Enter input integers below - enter 0 to finish\n");
  
  int val = 1;  /* holds an input value */
  int sum = 0;  /* accumulator - sum of integers entered so far */

  while (val != 0) {
    scanf("%d", &val);
    sum = sum + val;
  }

  printf("The sum of those integers is %d\n", sum);
  return 0;
}
