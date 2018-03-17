/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_CONTRACT_H
#define OWL_CONTRACT_H


/* Define structure for contracting indices of a tensor. */

struct contract_pair {
  int64_t dim;          // number of dimensions, x and y must be the same.
  int64_t dep;          // the depth of current recursion.
  int64_t drt;          // number of dimensions in the contracted tensor.
  int64_t *n;           // number of iteration in each dimension, i.e. y's shape
  void *x;              // x, source if operation is get, destination if set.
  int64_t posx;         // current offest of x.
  int64_t *ofsx;        // offset of x in each dimension.
  int64_t *incx;        // stride size of x in each dimension.
  void *y;              // y, destination if operation is get, source if set.
  int64_t posy;         // current offest of y.
  int64_t *ofsy;        // offset of y in each dimension.
  int64_t *incy;        // stride size of y in each dimension.
};


#endif  /* OWL_SLICING_H */
