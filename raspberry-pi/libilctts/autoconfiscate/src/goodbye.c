#include "config.h"
#include <stdio.h>

int
goodbye (void)
{
  puts ("Goodbye World!");
  puts ("This is " PACKAGE_STRING ".");
  return 0;
}
