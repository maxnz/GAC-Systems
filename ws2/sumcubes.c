/* example of iteration in C language.  RAB 9/10/2019 */

#include <stdio.h>

int cube(int x) {

  int val = x*x*x;
  return val;
}

int main() {
  int n;
  int result = 0;  
  int i;

  printf("Enter a non-negative integer:  ");
  scanf("%d", &n);

  i = 1;
  while (i <= n) {
    result = result + cube(i); 
    i++;
  }

  printf("The sum of the first %d cubes is %d.\n", n, result);
  return 0;  
}
