/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_CONTRACT_H
#define OWL_CONTRACT_H


/* Define structure for contracting indices of a tensor. */

struct contract_pair {
  long dim;         // number of dimensions, x and y must be the same.
  long dep;         // the depth of current recursion.
  long drt;         // number of outer loops.
  long *n;          // number of iteration in each dimension, i.e. y's shape
  void *x;          // x, operand.
  long posx;        // current offest of x.
  long *ofsx;       // offset of x in each dimension.
  long *incx;       // stride size of x in each dimension.
  void *y;          // y, operand.
  long posy;        // current offest of y.
  long *ofsy;       // offset of y in each dimension.
  long *incy;       // stride size of y in each dimension.
  void *z;          // z, operand.
  long posz;        // current offest of z.
  long *ofsz;       // offset of z in each dimension.
  long *incz;       // stride size of z in each dimension.
};


#endif  /* OWL_CONTRACT_H */
