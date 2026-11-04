/* example of using a global struct */

#include <stdio.h>

struct try {
  int val;
  char *str;
} dat;

char buff[] = "Hello";

int mod(struct try *dp) {
  dp->val++;
  dp->str[1] = 'X';
  return dp->val;
}

int main() {
  struct try *dp = &dat;
  dp->val = 10;
  dp->str = buff;
  printf("dat holds {%d, \"%s\"}\n", dp->val, dp->str);

  int ret = mod(dp);
  printf("mod(dp) returned %d\n", ret);

  printf("dat holds {%d, \"%s\"}\n", dp->val, dp->str);
}
