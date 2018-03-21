/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_CONTRACT_H
#define OWL_CONTRACT_H


/* Define structure for contracting indices of a tensor. */

struct contract_pair {
  int dim;          // number of dimensions, x and y must be the same.
  int dep;          // the depth of current recursion.
  int drt;          // number of outer loops.
  long *n;          // number of iteration in each dimension, i.e. y's shape
  void *x;          // x, operand.
  int posx;         // current offest of x.
  int *ofsx;        // offset of x in each dimension.
  int *incx;        // stride size of x in each dimension.
  void *y;          // y, operand.
  int posy;         // current offest of y.
  int *ofsy;        // offset of y in each dimension.
  int *incy;        // stride size of y in each dimension.
  void *z;          // z, operand.
  int posz;         // current offest of z.
  int *ofsz;        // offset of z in each dimension.
  int *incz;        // stride size of z in each dimension.
};


#endif  /* OWL_CONTRACT_H */
