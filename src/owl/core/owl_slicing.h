/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_SLICING_H
#define OWL_SLICING_H


/* Define structure for copying plan from x to y. */

struct slice_pair {
  int dim;
  int dep;
  long *n;
  void *x;
  int posx;
  int *ofsx;
  int *incx;
  void *y;
  int posy;
  int *ofsy;
  int *incy;
};


#endif  /* OWL_SLICING_H */
