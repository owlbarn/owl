/*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 */

#ifndef OWL_CONTRACT_H
#define OWL_CONTRACT_H


/* Define structure for contracting indices of a tensor. */

struct contract_pair {
  int64_t dim;         // number of dimensions, x and y must be the same.
  int64_t dep;         // the depth of current recursion.
  int64_t drt;         // number of outer loops.
  int64_t *n;       // number of iteration in each dimension, i.e. y's shape
  void *x;          // x, operand.
  int64_t posx;        // current offset of x.
  int64_t *ofsx;       // offset of x in each dimension.
  int64_t *incx;       // stride size of x in each dimension.
  void *y;          // y, operand.
  int64_t posy;        // current offset of y.
  int64_t *ofsy;       // offset of y in each dimension.
  int64_t *incy;       // stride size of y in each dimension.
  void *z;          // z, operand.
  int64_t posz;        // current offset of z.
  int64_t *ofsz;       // offset of z in each dimension.
  int64_t *incz;       // stride size of z in each dimension.
};


#endif  /* OWL_CONTRACT_H */
