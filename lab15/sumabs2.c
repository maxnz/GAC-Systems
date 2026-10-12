#include <stdio.h>

int abs2(int x) {
  if (x < 0)
    return -x;
  return x;
}

int main() {
  int min, max;
  int sum = 0;

  printf("Enter minimum and maximum integer values:  ");
  scanf("%d %d", &min, &max);

  int i = min;
  while (i <= max) {
    sum = sum + abs2(i);
    i++;
  }

  printf("The sum of absolute values is %d\n", sum);
  return 0;
}
