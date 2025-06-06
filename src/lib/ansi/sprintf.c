#include <lib.h>
#include <stdio.h>
#include <stdarg.h>

char *sprintf(char *buf, _CONST char *format, ...)
{
  FILE _tempfile;
  va_list ap;

  _tempfile._fd = -1;
  _tempfile._flags = WRITEMODE + STRINGS;
  _tempfile._buf = buf;
  _tempfile._ptr = buf;

  va_start(ap, format);
  _doprintf(&_tempfile, format, ap);
  va_end(ap);
  putc('\0', &_tempfile);

  return(buf);
}
