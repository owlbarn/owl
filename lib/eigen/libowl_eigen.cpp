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

inline spmat_d& c_to_eigen(eigen_spmat_d* ptr)
{
  return *reinterpret_cast<spmat_d*>(ptr);
}

inline eigen_spmat_d* eigen_to_c(spmat_d& ref)
{
  return reinterpret_cast<eigen_spmat_d*>(&ref);
}


/***************** SparseMatrix_D: c stubs for c++ functions *****************/

eigen_spmat_d* c_eigen_spmat_d_new(int rows, int cols)
{
  return eigen_to_c(*new spmat_d(rows,cols));
}

void c_eigen_spmat_d_delete(eigen_spmat_d *m)
{
  delete &c_to_eigen(m);
}

int c_eigen_spmat_d_rows(eigen_spmat_d *m)
{
  return c_to_eigen(m).rows();
}

int c_eigen_spmat_d_cols(eigen_spmat_d *m)
{
  return c_to_eigen(m).cols();
}

double c_eigen_spmat_d_get(eigen_spmat_d *m, int i, int j)
{
  return (c_to_eigen(m)).coeff(i,j);
}

void c_eigen_spmat_d_set(eigen_spmat_d *m, int i, int j, double x)
{
  (c_to_eigen(m)).coeffRef(i,j) = x;
}

void c_eigen_spmat_d_reset(eigen_spmat_d *m)
{
  (c_to_eigen(m)).setZero();
}

int c_eigen_spmat_d_is_compressed(eigen_spmat_d *m)
{
  return (c_to_eigen(m)).isCompressed();
}

void c_eigen_spmat_d_compress(eigen_spmat_d *m)
{
  (c_to_eigen(m)).makeCompressed();
}

void c_eigen_spmat_d_uncompress(eigen_spmat_d *m)
{
  (c_to_eigen(m)).uncompress();
}

void c_eigen_spmat_d_print(eigen_spmat_d *m)
{
  std::cout << c_to_eigen(m) << std::endl;
}
