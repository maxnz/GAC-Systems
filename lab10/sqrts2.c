/* print square roots in C language.  R. Brown, 9/2010 */

#include <stdio.h>
#include <math.h>

int main()  /* this is the main program */
{
  int n;
  printf("n  sqrt(n)\n----------\n");
  for (n=0;  n<=5;  n++)
    printf("%d  %f\n", n, sqrt(n));
  return 0;
}
