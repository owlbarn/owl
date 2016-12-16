/* File: utils_c.c

   Copyright (C) 2005-

     Markus Mottl
     email: markus.mottl@gmail.com
     WWW: http://www.ocaml.info

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

// Enable POSIX.1-2001 for use of `struct timespec' and `nanosleep'
#define _POSIX_C_SOURCE 200112L

#include "owl_utils_c.h"
#include <caml/alloc.h>

#ifdef WIN32
  #include <windows.h>
#else
  #include <time.h>
#endif // WIN32

value copy_two_doubles(double d0, double d1)
{
  value res = caml_alloc_small(2 * Double_wosize, Double_array_tag);
  Store_double_field(res, 0, d0);
  Store_double_field(res, 1, d1);
  return res;
}

int portable_sleep(int milliseconds)
{
#ifdef WIN32
  Sleep(milliseconds);
  return 0;
#else
  struct timespec tim, tim2;
  tim.tv_sec = 0;
  tim.tv_nsec = milliseconds * 1000000;

  return nanosleep(&tim , &tim2);
#endif // WIN32
}
