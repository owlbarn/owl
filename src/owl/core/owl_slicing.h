/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_SLICING_H
#define OWL_SLICING_H


/* Define structure for copying a slice from x to y. */

struct slice_pair {
  int dim;      // number of dimensions, x and y must be the same
  int dep;      // the depth of current recursion.
  long *n;      // number of iteration in each dimension, i.e. y's shape
  void *x;      // x, source if operation is get, destination if set.
  int posx;     // current offest of x.
  int *ofsx;    // offset of x in each dimension.
  int *incx;    // stride size of x in each dimension.
  void *y;      // y, destination if operation is get, source if set.
  int posy;     // current offest of y.
  int *ofsy;    // offset of y in each dimension.
  int *incy;    // stride size of y in each dimension.
};


/* Define structure for copying a fancy slice from x to y. */

struct fancy_pair {
  int dim;      // number of dimensions, x and y must be the same
  int dep;      // the depth of current recursion.
  long *slice;  //
  long *index;  //
  void *x;      // x, source if operation is get, destination if set.
  int posx;     // current offest of x.
  int *ofsx;    // offset of x in each dimension.
  int *incx;    // stride size of x in each dimension.
  void *y;      // y, destination if operation is get, source if set.
  int posy;     // current offest of y.
  int *ofsy;    // offset of y in each dimension.
  int *incy;    // stride size of y in each dimension.
};


#endif  /* OWL_SLICING_H */
