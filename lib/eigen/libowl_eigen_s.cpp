/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


/******************** SparseMatrix_S: pointer conversion  ********************/

typedef float elt_s;
typedef SparseMatrix<elt_s, Eigen::RowMajor, INDEX> spmat_s;
const elt_s zero_s = 0.;

inline spmat_s& c_to_eigen(c_spmat_s* ptr)
{
  return *reinterpret_cast<spmat_s*>(ptr);
}

inline c_spmat_s* eigen_to_c(spmat_s& ref)
{
  return reinterpret_cast<c_spmat_s*>(&ref);
}


/***************** SparseMatrix_S: c stubs for c++ functions *****************/

c_spmat_s* c_eigen_spmat_s_new(INDEX rows, INDEX cols)
{
  return eigen_to_c(*new spmat_s(rows, cols));
}

void c_eigen_spmat_s_delete(c_spmat_s *m)
{
  delete &c_to_eigen(m);
}

c_spmat_s* c_eigen_spmat_s_eye(INDEX m)
{
  spmat_s* x = new spmat_s(m, m);
  (*x).setIdentity();
  return eigen_to_c(*x);
}

INDEX c_eigen_spmat_s_rows(c_spmat_s *m)
{
  return c_to_eigen(m).rows();
}

INDEX c_eigen_spmat_s_cols(c_spmat_s *m)
{
  return c_to_eigen(m).cols();
}

INDEX c_eigen_spmat_s_nnz(c_spmat_s *m)
{
  return (c_to_eigen(m)).nonZeros();
}

elt_s c_eigen_spmat_s_get(c_spmat_s *m, INDEX i, INDEX j)
{
  return (c_to_eigen(m)).coeff(i,j);
}

void c_eigen_spmat_s_set(c_spmat_s *m, INDEX i, INDEX j, elt_s x)
{
  (c_to_eigen(m)).coeffRef(i,j) = x;
}

void c_eigen_spmat_s_reset(c_spmat_s *m)
{
  (c_to_eigen(m)).setZero();
}

int c_eigen_spmat_s_is_compressed(c_spmat_s *m)
{
  return (c_to_eigen(m)).isCompressed();
}

void c_eigen_spmat_s_compress(c_spmat_s *m)
{
  (c_to_eigen(m)).makeCompressed();
}

void c_eigen_spmat_s_uncompress(c_spmat_s *m)
{
  (c_to_eigen(m)).uncompress();
}

void c_eigen_spmat_s_reshape(c_spmat_s *m, INDEX rows, INDEX cols)
{
  // FIXME: keep old data
  (c_to_eigen(m)).resize(rows, cols);
}

void c_eigen_spmat_s_prune(c_spmat_s *m, elt_s ref, elt_s eps)
{
  (c_to_eigen(m)).prune(ref, eps);
}

elt_s* c_eigen_spmat_s_valueptr(c_spmat_s *m, INDEX *l)
{
  spmat_s& x = c_to_eigen(m);
  x.makeCompressed();
  *l = x.data().size();
  return x.valuePtr();
}

INDEX* c_eigen_spmat_s_innerindexptr(c_spmat_s *m)
{
  spmat_s& x = c_to_eigen(m);
  x.makeCompressed();
  return x.innerIndexPtr();
}

INDEX* c_eigen_spmat_s_outerindexptr(c_spmat_s *m)
{
  spmat_s& x = c_to_eigen(m);
  x.makeCompressed();
  return x.outerIndexPtr();
}

c_spmat_s* c_eigen_spmat_s_clone(c_spmat_s *m)
{
  spmat_s& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_s(x));
}

c_spmat_s* c_eigen_spmat_s_row(c_spmat_s *m, INDEX i)
{
  spmat_s* x = new spmat_s((c_to_eigen(m)).row(i));
  return eigen_to_c(*x);
}

c_spmat_s* c_eigen_spmat_s_col(c_spmat_s *m, INDEX i)
{
  spmat_s* x = new spmat_s((c_to_eigen(m)).col(i));
  return eigen_to_c(*x);
}

c_spmat_s* c_eigen_spmat_s_transpose(c_spmat_s *m)
{
  spmat_s* x = new spmat_s((c_to_eigen(m)).transpose());
  return eigen_to_c(*x);
}

c_spmat_s* c_eigen_spmat_s_adjoint(c_spmat_s *m)
{
  spmat_s* x = new spmat_s((c_to_eigen(m)).adjoint());
  return eigen_to_c(*x);
}

c_spmat_s* c_eigen_spmat_s_diagonal(c_spmat_s *m)
{
  spmat_s& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_s(x.diagonal().sparseView()));
}

elt_s c_eigen_spmat_s_trace(c_spmat_s *m)
{
  return c_to_eigen(m).diagonal().sparseView().sum();
}

int c_eigen_spmat_s_is_zero(c_spmat_s *m)
{
  spmat_s& x = c_to_eigen(m);
  if (x.nonZeros() == 0)
    return 1;

  elt_s* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k] != 0) {
      b = 0;
      break;
    }
  }
  return b;
}

int c_eigen_spmat_s_is_positive(c_spmat_s *m)
{
  spmat_s& x = c_to_eigen(m);
  x.makeCompressed();
  if (x.nonZeros() < (x.rows() * x.cols()))
    return 0;

  elt_s* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k] <= 0) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_s_is_negative(c_spmat_s *m)
{
  spmat_s& x = c_to_eigen(m);
  x.makeCompressed();
  if (x.nonZeros() < (x.rows() * x.cols()))
    return 0;

  elt_s* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k] >= 0) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_s_is_nonpositive(c_spmat_s *m)
{
  spmat_s& x = c_to_eigen(m);
  x.makeCompressed();
  elt_s* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k] > 0) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_s_is_nonnegative(c_spmat_s *m)
{
  spmat_s& x = c_to_eigen(m);
  x.makeCompressed();
  elt_s* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k] < 0) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_s_is_equal(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s x = c_to_eigen(m0) - c_to_eigen(m1);
  x.prune(0., 0.);
  return (x.nonZeros() == 0);
}

int c_eigen_spmat_s_is_unequal(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s x = c_to_eigen(m0) - c_to_eigen(m1);
  x.prune(0., 0.);
  return (x.nonZeros() != 0);
}

int c_eigen_spmat_s_is_greater(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_s_is_positive(eigen_to_c(x));
}

int c_eigen_spmat_s_is_smaller(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_s_is_negative(eigen_to_c(x));
}

int c_eigen_spmat_s_equal_or_greater(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_s_is_nonnegative(eigen_to_c(x));
}

int c_eigen_spmat_s_equal_or_smaller(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_s_is_nonpositive(eigen_to_c(x));
}

c_spmat_s* c_eigen_spmat_s_add(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s& x0 = c_to_eigen(m0);
  spmat_s& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_s(x0 + x1));
}

c_spmat_s* c_eigen_spmat_s_sub(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s& x0 = c_to_eigen(m0);
  spmat_s& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_s(x0 - x1));
}

c_spmat_s* c_eigen_spmat_s_mul(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s& x0 = c_to_eigen(m0);
  spmat_s& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_s(x0.cwiseProduct(x1)));
}

c_spmat_s* c_eigen_spmat_s_div(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s& x0 = c_to_eigen(m0);
  spmat_s& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_s(x0.cwiseQuotient(x1)));
}

c_spmat_s* c_eigen_spmat_s_dot(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s& x0 = c_to_eigen(m0);
  spmat_s& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_s(x0 * x1));
}

c_spmat_s* c_eigen_spmat_s_add_scalar(c_spmat_s *m, elt_s a)
{
  spmat_s* x = new spmat_s(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_s::InnerIterator it(*x,k); it; ++it)
      it.valueRef() += a;
  return eigen_to_c(*x);
}

c_spmat_s* c_eigen_spmat_s_sub_scalar(c_spmat_s *m, elt_s a)
{
  spmat_s* x = new spmat_s(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_s::InnerIterator it(*x,k); it; ++it)
      it.valueRef() -= a;
  return eigen_to_c(*x);
}

c_spmat_s* c_eigen_spmat_s_mul_scalar(c_spmat_s *m, elt_s a)
{
  spmat_s& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_s(x * a));
}

c_spmat_s* c_eigen_spmat_s_div_scalar(c_spmat_s *m, elt_s a)
{
  spmat_s* x = new spmat_s(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_s::InnerIterator it(*x,k); it; ++it)
      it.valueRef() /= a;
  return eigen_to_c(*x);
}

c_spmat_s* c_eigen_spmat_s_min2(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s& x0 = c_to_eigen(m0);
  spmat_s& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_s(x0.cwiseMin(x1)));
}

c_spmat_s* c_eigen_spmat_s_max2(c_spmat_s *m0, c_spmat_s *m1)
{
  spmat_s& x0 = c_to_eigen(m0);
  spmat_s& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_s(x0.cwiseMax(x1)));
}

elt_s c_eigen_spmat_s_sum(c_spmat_s *m)
{
  return (c_to_eigen(m)).sum();
}

elt_s c_eigen_spmat_s_min(c_spmat_s *m)
{
  elt_s a = std::numeric_limits<elt_s>::infinity();
  spmat_s& x = c_to_eigen(m);
  for (INDEX k = 0; k < x.outerSize(); ++k)
    for (spmat_s::InnerIterator it(x,k); it; ++it)
    {
      if (it.value() < a)
        a = it.value();
    }
  if ((x.nonZeros() < (x.rows() * x.cols())) && (a > 0))
    a = 0;
  return a;
}

elt_s c_eigen_spmat_s_max(c_spmat_s *m)
{
  elt_s a = -std::numeric_limits<elt_s>::infinity();
  spmat_s& x = c_to_eigen(m);
  for (INDEX k = 0; k < x.outerSize(); ++k)
    for (spmat_s::InnerIterator it(x,k); it; ++it)
    {
      if (it.value() > a)
        a = it.value();
    }
  if ((x.nonZeros() < (x.rows() * x.cols())) && (a < 0))
    a = 0;
  return a;
}

c_spmat_s* c_eigen_spmat_s_abs(c_spmat_s *m)
{
  spmat_s* x = new spmat_s((c_to_eigen(m)).cwiseAbs());
  return eigen_to_c(*x);
}

c_spmat_s* c_eigen_spmat_s_neg(c_spmat_s *m)
{
  spmat_s* x = new spmat_s(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_s::InnerIterator it(*x,k); it; ++it)
      it.valueRef() = -it.value();
  return eigen_to_c(*x);
}

c_spmat_s* c_eigen_spmat_s_sqrt(c_spmat_s *m)
{
  spmat_s* x = new spmat_s((c_to_eigen(m)).cwiseSqrt());
  return eigen_to_c(*x);
}

void c_eigen_spmat_s_print(c_spmat_s *m)
{
  std::cout << c_to_eigen(m) << std::endl;
}
