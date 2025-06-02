#include <lib.h>
#include <stdio.h>
#include <stdarg.h>

void fprintf(FILE *file, _CONST char *fmt, ...)
{
  va_list ap;
  va_start(ap, fmt);
  _doprintf(file, fmt, ap);
  va_end(ap);
  if (testflag(file, PERPRINTF)) fflush(file);
}


void printf(_CONST char *fmt, ...)
{
  va_list ap;
  va_start(ap, fmt);
  _doprintf(stdout, fmt, ap);
  va_end(ap);
  if (testflag(stdout, PERPRINTF)) fflush(stdout);
}
