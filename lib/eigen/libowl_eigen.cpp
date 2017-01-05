/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <iostream>
#include "libowl_eigen.h"

#include <Eigen/Core>
#include <Eigen/Sparse>

using namespace Eigen;

/******************** SparseMatrix_D: pointer conversion  ********************/

typedef SparseMatrix<double, Eigen::RowMajor> spmat_d;

inline spmat_d& c_to_eigen(c_spmat_d* ptr)
{
  return *reinterpret_cast<spmat_d*>(ptr);
}

inline c_spmat_d* eigen_to_c(spmat_d& ref)
{
  return reinterpret_cast<c_spmat_d*>(&ref);
}


/***************** SparseMatrix_D: c stubs for c++ functions *****************/

c_spmat_d* c_eigen_spmat_d_new(int rows, int cols)
{
  return eigen_to_c(*new spmat_d(rows, cols));
}

void c_eigen_spmat_d_delete(c_spmat_d *m)
{
  delete &c_to_eigen(m);
}
// FIXME
c_spmat_d* c_eigen_spmat_d_eye(int m)
{
  spmat_d* x = new spmat_d(m, m);
  (*x).setIdentity();
  return (eigen_to_c(*x));
}

int c_eigen_spmat_d_rows(c_spmat_d *m)
{
  return c_to_eigen(m).rows();
}

int c_eigen_spmat_d_cols(c_spmat_d *m)
{
  return c_to_eigen(m).cols();
}

int c_eigen_spmat_d_nnz(c_spmat_d *m)
{
  return (c_to_eigen(m)).nonZeros();
}

double c_eigen_spmat_d_get(c_spmat_d *m, int i, int j)
{
  return (c_to_eigen(m)).coeff(i,j);
}

void c_eigen_spmat_d_set(c_spmat_d *m, int i, int j, double x)
{
  (c_to_eigen(m)).coeffRef(i,j) = x;
}

void c_eigen_spmat_d_reset(c_spmat_d *m)
{
  (c_to_eigen(m)).setZero();
}

int c_eigen_spmat_d_is_compressed(c_spmat_d *m)
{
  return (c_to_eigen(m)).isCompressed();
}

void c_eigen_spmat_d_compress(c_spmat_d *m)
{
  (c_to_eigen(m)).makeCompressed();
}

void c_eigen_spmat_d_uncompress(c_spmat_d *m)
{
  (c_to_eigen(m)).uncompress();
}

void c_eigen_spmat_d_reshape(c_spmat_d *m, int rows, int cols)
{
  (c_to_eigen(m)).conservativeResize(rows, cols);
}

c_spmat_d* c_eigen_spmat_d_clone(c_spmat_d *m)
{
  spmat_d x = c_to_eigen(m);
  return eigen_to_c(*new spmat_d(x));
}

c_spmat_d* c_eigen_spmat_d_row(c_spmat_d *m, int i)
{
  spmat_d x = (c_to_eigen(m)).row(i);
  return eigen_to_c(*new spmat_d(x));
}

c_spmat_d* c_eigen_spmat_d_col(c_spmat_d *m, int i)
{
  spmat_d x = (c_to_eigen(m)).col(i);
  return eigen_to_c(*new spmat_d(x));
}

c_spmat_d* c_eigen_spmat_d_transpose(c_spmat_d *m)
{
  spmat_d x = (c_to_eigen(m)).transpose();
  return eigen_to_c(*new spmat_d(x));
}

c_spmat_d* c_eigen_spmat_d_adjoint(c_spmat_d *m)
{
  spmat_d x = (c_to_eigen(m)).adjoint();
  return eigen_to_c(*new spmat_d(x));
}

c_spmat_d* c_eigen_spmat_d_add(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x0 = c_to_eigen(m0);
  spmat_d x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0 + x1));
}

c_spmat_d* c_eigen_spmat_d_sub(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x0 = c_to_eigen(m0);
  spmat_d x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0 - x1));
}

c_spmat_d* c_eigen_spmat_d_mul(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x0 = c_to_eigen(m0);
  spmat_d x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0.cwiseProduct(x1)));
}

c_spmat_d* c_eigen_spmat_d_div(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x0 = c_to_eigen(m0);
  spmat_d x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0.cwiseQuotient(x1)));
}

c_spmat_d* c_eigen_spmat_d_dot(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x0 = c_to_eigen(m0);
  spmat_d x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0 * x1));
}

c_spmat_d* c_eigen_spmat_d_mul_scalar(c_spmat_d *m, double a)
{
  spmat_d x = c_to_eigen(m);
  return eigen_to_c(*new spmat_d(x * a));
}

c_spmat_d* c_eigen_spmat_d_div_scalar(c_spmat_d *m, double a)
{
  // FIXME : div (-1)
  spmat_d x = c_to_eigen(m);
  return eigen_to_c(*new spmat_d(x / a));
}

c_spmat_d* c_eigen_spmat_d_min2(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x0 = c_to_eigen(m0);
  spmat_d x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0.cwiseMin(x1)));
}

c_spmat_d* c_eigen_spmat_d_max2(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x0 = c_to_eigen(m0);
  spmat_d x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0.cwiseMax(x1)));
}

double c_eigen_spmat_d_sum(c_spmat_d *m)
{
  return (c_to_eigen(m)).sum();
}

c_spmat_d* c_eigen_spmat_d_abs(c_spmat_d *m)
{
  spmat_d x = (c_to_eigen(m)).cwiseAbs();
  return eigen_to_c(*new spmat_d(x));
}

c_spmat_d* c_eigen_spmat_d_sqrt(c_spmat_d *m)
{
  spmat_d x = (c_to_eigen(m)).cwiseSqrt();
  return eigen_to_c(*new spmat_d(x));
}

void c_eigen_spmat_d_print(c_spmat_d *m)
{
  std::cout << c_to_eigen(m) << std::endl;
}
