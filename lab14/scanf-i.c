/* scanf-i.c - example of an integer pointer argument */
#include <stdio.h>

int main() {
  int val;
  printf("Enter an integer: ");
  scanf("%d", &val);
  
  printf("3 times the value you entered is %d\n", 3*val);
  return 0;
}
