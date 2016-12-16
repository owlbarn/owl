/* File: utils_c.h

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

/* Store two doubles in an OCaml-block (complex number) */

#ifndef UTILS_C
#define UTILS_C

#include <stdbool.h>
#include <stdio.h>
#include <caml/mlvalues.h>

/* Compiler pragmas and inlining */

/* Forget any previous definition of inlining, it may not be what we mean */
#ifdef inline
# undef inline
#endif

/* The semantics of "inline" in C99 is not what we intend so just drop it */
#if defined(__STDC__) && __STDC__ && \
    defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
# define inline
#endif

#if defined(__GNUC__) && __GNUC__ >= 3
# ifndef inline
#   define inline inline __attribute__ ((always_inline))
# endif
# ifndef __pure
#   define __pure __attribute__ ((pure))
# endif
# ifndef __const
#   define __const __attribute__ ((const))
# endif
# ifndef __malloc
#   define __malloc __attribute__ ((malloc))
# endif
# ifndef __unused
#   define __unused __attribute__ ((unused))
# endif
# ifndef __likely
#   define likely(x) __builtin_expect (!!(x), 1)
# endif
# ifndef __unlikely
#   define unlikely(x) __builtin_expect (!!(x), 0)
# endif
#else
  /* Non-GNU compilers should always ignore "inline" no matter the C-standard */
# ifndef inline
#   define inline
# endif
# ifndef __pure
#   define __pure
# endif
# ifndef  __const
#   define __const
# endif
# ifndef  __malloc
#   define __malloc
# endif
# ifndef  __unused
#   define __unused
# endif
# ifndef  __likely
#   define likely(x) (x)
# endif
# ifndef  __unlikely
#   define unlikely(x) (x)
# endif
#endif

/* Create an OCaml record of two floats */
value copy_two_doubles(double d0, double d1);

/* Tries to sleep the given number of milliseconds.
 * Returns 0 on success. */
int portable_sleep(int milliseconds);

#endif /* UTILS_C */
