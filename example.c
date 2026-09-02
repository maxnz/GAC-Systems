#include <stdio.h>
#include <math.h>

int gl = 5;

int main() {
  printf("Example C program\n");
  printf("gl=%d\n", gl);
  
  int i = 7;
  float f;
  f = 3.28;
  printf("i=%d  f=%f\n", i, f);

  i = i * gl;
  f = f * gl;
  printf("i=%d  f=%f\n", i, f);

  printf("The square root of %d is %f\n", i, sqrt(i));

  if (i < 10) 
    printf("%d is small\n", i);
  else
    printf("%d is not small\n", i);

  if (i < 0) 
    printf("%d is negative\n", i);
  else {
    printf("%d is non-negative ", i);
    printf("and the square root of %d is %f\n", i, sqrt(i));
  }

  if (i < 10) 
    printf("%d is small\n", i);
  else if (i < 100)
    printf("%d is medium\n", i);
  else /* assert:  i >= 100 */
    printf("%d is large\n", i);

  return i;

}
