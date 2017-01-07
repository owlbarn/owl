/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


/******************** SparseMatrix_D: pointer conversion  ********************/

typedef double elt_d;
typedef SparseMatrix<elt_d, Eigen::RowMajor, long long> spmat_d;

inline spmat_d& c_to_eigen(c_spmat_d* ptr)
{
  return *reinterpret_cast<spmat_d*>(ptr);
}

inline c_spmat_d* eigen_to_c(spmat_d& ref)
{
  return reinterpret_cast<c_spmat_d*>(&ref);
}


/***************** SparseMatrix_D: c stubs for c++ functions *****************/

c_spmat_d* c_eigen_spmat_d_new(long long rows, long long cols)
{
  return eigen_to_c(*new spmat_d(rows, cols));
}

void c_eigen_spmat_d_delete(c_spmat_d *m)
{
  delete &c_to_eigen(m);
}

c_spmat_d* c_eigen_spmat_d_eye(long long m)
{
  spmat_d* x = new spmat_d(m, m);
  (*x).setIdentity();
  return eigen_to_c(*x);
}

long long c_eigen_spmat_d_rows(c_spmat_d *m)
{
  return c_to_eigen(m).rows();
}

long long c_eigen_spmat_d_cols(c_spmat_d *m)
{
  return c_to_eigen(m).cols();
}

long long c_eigen_spmat_d_nnz(c_spmat_d *m)
{
  return (c_to_eigen(m)).nonZeros();
}

elt_d c_eigen_spmat_d_get(c_spmat_d *m, long long i, long long j)
{
  return (c_to_eigen(m)).coeff(i,j);
}

void c_eigen_spmat_d_set(c_spmat_d *m, long long i, long long j, elt_d x)
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

void c_eigen_spmat_d_reshape(c_spmat_d *m, long long rows, long long cols)
{
  // FIXME: keep old data
  (c_to_eigen(m)).resize(rows, cols);
}

void c_eigen_spmat_d_prune(c_spmat_d *m, elt_d ref, elt_d eps)
{
  (c_to_eigen(m)).prune(ref, eps);
}

elt_d* c_eigen_spmat_d_valueptr(c_spmat_d *m, long long *l)
{
  spmat_d& x = c_to_eigen(m);
  x.makeCompressed();
  *l = x.data().size();
  return x.valuePtr();
}

long long* c_eigen_spmat_d_innerindexptr(c_spmat_d *m)
{
  spmat_d& x = c_to_eigen(m);
  x.makeCompressed();
  return x.innerIndexPtr();
}

long long* c_eigen_spmat_d_outerindexptr(c_spmat_d *m)
{
  spmat_d& x = c_to_eigen(m);
  x.makeCompressed();
  return x.outerIndexPtr();
}

c_spmat_d* c_eigen_spmat_d_clone(c_spmat_d *m)
{
  spmat_d& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_d(x));
}

c_spmat_d* c_eigen_spmat_d_row(c_spmat_d *m, long long i)
{
  spmat_d* x = new spmat_d((c_to_eigen(m)).row(i));
  return eigen_to_c(*x);
}

c_spmat_d* c_eigen_spmat_d_col(c_spmat_d *m, long long i)
{
  spmat_d* x = new spmat_d((c_to_eigen(m)).col(i));
  return eigen_to_c(*x);
}

c_spmat_d* c_eigen_spmat_d_transpose(c_spmat_d *m)
{
  spmat_d* x = new spmat_d((c_to_eigen(m)).transpose());
  return eigen_to_c(*x);
}

c_spmat_d* c_eigen_spmat_d_adjoint(c_spmat_d *m)
{
  spmat_d* x = new spmat_d((c_to_eigen(m)).adjoint());
  return eigen_to_c(*x);
}

c_spmat_d* c_eigen_spmat_d_diagonal(c_spmat_d *m)
{
  spmat_d& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_d(x.diagonal().sparseView()));
}

elt_d c_eigen_spmat_d_trace(c_spmat_d *m)
{
  return c_to_eigen(m).diagonal().sparseView().sum();
}

int c_eigen_spmat_d_is_zero(c_spmat_d *m)
{
  spmat_d& x = c_to_eigen(m);
  if (x.nonZeros() == 0)
    return 1;

  elt_d* a = x.valuePtr();
  int b = 1;
  for (long long k = 0; k < x.data().size(); ++k)
  {
    if (a[k] != 0) {
      b = 0;
      break;
    }
  }
  return b;
}

int c_eigen_spmat_d_is_positive(c_spmat_d *m)
{
  spmat_d& x = c_to_eigen(m);
  x.makeCompressed();
  if (x.nonZeros() < (x.rows() * x.cols()))
    return 0;

  elt_d* a = x.valuePtr();
  int b = 1;
  for (long long k = 0; k < x.data().size(); ++k)
  {
    if (a[k] <= 0) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_d_is_negative(c_spmat_d *m)
{
  spmat_d& x = c_to_eigen(m);
  x.makeCompressed();
  if (x.nonZeros() < (x.rows() * x.cols()))
    return 0;

  elt_d* a = x.valuePtr();
  int b = 1;
  for (long long k = 0; k < x.data().size(); ++k)
  {
    if (a[k] >= 0) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_d_is_nonpositive(c_spmat_d *m)
{
  spmat_d& x = c_to_eigen(m);
  x.makeCompressed();
  elt_d* a = x.valuePtr();
  int b = 1;
  for (long long k = 0; k < x.data().size(); ++k)
  {
    if (a[k] > 0) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_d_is_nonnegative(c_spmat_d *m)
{
  spmat_d& x = c_to_eigen(m);
  x.makeCompressed();
  elt_d* a = x.valuePtr();
  int b = 1;
  for (long long k = 0; k < x.data().size(); ++k)
  {
    if (a[k] < 0) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_d_is_equal(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x = c_to_eigen(m0) - c_to_eigen(m1);
  x.prune(0, 0);
  return (x.nonZeros() == 0);
}

int c_eigen_spmat_d_is_unequal(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x = c_to_eigen(m0) - c_to_eigen(m1);
  x.prune(0, 0);
  return (x.nonZeros() != 0);
}

int c_eigen_spmat_d_is_greater(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_d_is_positive(eigen_to_c(x));
}

int c_eigen_spmat_d_is_smaller(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_d_is_negative(eigen_to_c(x));
}

int c_eigen_spmat_d_equal_or_greater(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_d_is_nonnegative(eigen_to_c(x));
}

int c_eigen_spmat_d_equal_or_smaller(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_d_is_nonpositive(eigen_to_c(x));
}

c_spmat_d* c_eigen_spmat_d_add(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d& x0 = c_to_eigen(m0);
  spmat_d& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0 + x1));
}

c_spmat_d* c_eigen_spmat_d_sub(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d& x0 = c_to_eigen(m0);
  spmat_d& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0 - x1));
}

c_spmat_d* c_eigen_spmat_d_mul(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d& x0 = c_to_eigen(m0);
  spmat_d& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0.cwiseProduct(x1)));
}

c_spmat_d* c_eigen_spmat_d_div(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d& x0 = c_to_eigen(m0);
  spmat_d& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0.cwiseQuotient(x1)));
}

c_spmat_d* c_eigen_spmat_d_dot(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d& x0 = c_to_eigen(m0);
  spmat_d& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0 * x1));
}

c_spmat_d* c_eigen_spmat_d_add_scalar(c_spmat_d *m, elt_d a)
{
  spmat_d* x = new spmat_d(c_to_eigen(m));
  for (long long k = 0; k < (*x).outerSize(); ++k)
    for (spmat_d::InnerIterator it(*x,k); it; ++it)
      it.valueRef() += a;
  return eigen_to_c(*x);
}

c_spmat_d* c_eigen_spmat_d_sub_scalar(c_spmat_d *m, elt_d a)
{
  spmat_d* x = new spmat_d(c_to_eigen(m));
  for (long long k = 0; k < (*x).outerSize(); ++k)
    for (spmat_d::InnerIterator it(*x,k); it; ++it)
      it.valueRef() -= a;
  return eigen_to_c(*x);
}

c_spmat_d* c_eigen_spmat_d_mul_scalar(c_spmat_d *m, elt_d a)
{
  spmat_d& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_d(x * a));
}

c_spmat_d* c_eigen_spmat_d_div_scalar(c_spmat_d *m, elt_d a)
{
  spmat_d* x = new spmat_d(c_to_eigen(m));
  for (long long k = 0; k < (*x).outerSize(); ++k)
    for (spmat_d::InnerIterator it(*x,k); it; ++it)
      it.valueRef() /= a;
  return eigen_to_c(*x);
}

c_spmat_d* c_eigen_spmat_d_min2(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d& x0 = c_to_eigen(m0);
  spmat_d& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0.cwiseMin(x1)));
}

c_spmat_d* c_eigen_spmat_d_max2(c_spmat_d *m0, c_spmat_d *m1)
{
  spmat_d& x0 = c_to_eigen(m0);
  spmat_d& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_d(x0.cwiseMax(x1)));
}

elt_d c_eigen_spmat_d_sum(c_spmat_d *m)
{
  return (c_to_eigen(m)).sum();
}

elt_d c_eigen_spmat_d_min(c_spmat_d *m)
{
  elt_d a = std::numeric_limits<elt_d>::infinity();
  spmat_d& x = c_to_eigen(m);
  for (long long k = 0; k < x.outerSize(); ++k)
    for (spmat_d::InnerIterator it(x,k); it; ++it)
    {
      if (it.value() < a)
        a = it.value();
    }
  if ((x.nonZeros() < (x.rows() * x.cols())) && (a > 0))
    a = 0;
  return a;
}

elt_d c_eigen_spmat_d_max(c_spmat_d *m)
{
  elt_d a = -std::numeric_limits<elt_d>::infinity();
  spmat_d& x = c_to_eigen(m);
  for (long long k = 0; k < x.outerSize(); ++k)
    for (spmat_d::InnerIterator it(x,k); it; ++it)
    {
      if (it.value() > a)
        a = it.value();
    }
  if ((x.nonZeros() < (x.rows() * x.cols())) && (a < 0))
    a = 0;
  return a;
}

c_spmat_d* c_eigen_spmat_d_abs(c_spmat_d *m)
{
  spmat_d* x = new spmat_d((c_to_eigen(m)).cwiseAbs());
  return eigen_to_c(*x);
}

c_spmat_d* c_eigen_spmat_d_neg(c_spmat_d *m)
{
  spmat_d* x = new spmat_d(c_to_eigen(m));
  for (long long k = 0; k < (*x).outerSize(); ++k)
    for (spmat_d::InnerIterator it(*x,k); it; ++it)
      it.valueRef() = -it.value();
  return eigen_to_c(*x);
}

c_spmat_d* c_eigen_spmat_d_sqrt(c_spmat_d *m)
{
  spmat_d* x = new spmat_d((c_to_eigen(m)).cwiseSqrt());
  return eigen_to_c(*x);
}

void c_eigen_spmat_d_print(c_spmat_d *m)
{
  std::cout << c_to_eigen(m) << std::endl;
}
