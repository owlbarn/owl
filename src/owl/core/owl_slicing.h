/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


struct slice_pair {
  int dim;
  int dep;
  int *n;
  void *x;
  int posx;
  int *ofsx;
  int *incx;
  void *y;
  int posy;
  int *ofsy;
  int *incy;
};
