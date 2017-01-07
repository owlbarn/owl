/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


/******************** SparseMatrix_C: pointer conversion  ********************/

typedef std::complex< float > elt_c;
typedef SparseMatrix<elt_c, Eigen::RowMajor, INDEX> spmat_c;
const elt_c zero_c = 0.;

inline spmat_c& c_to_eigen(c_spmat_c* ptr)
{
  return *reinterpret_cast<spmat_c*>(ptr);
}

inline c_spmat_c* eigen_to_c(spmat_c& ref)
{
  return reinterpret_cast<c_spmat_c*>(&ref);
}


/***************** SparseMatrix_C: c stubs for c++ functions *****************/

c_spmat_c* c_eigen_spmat_c_new(INDEX rows, INDEX cols)
{
  return eigen_to_c(*new spmat_c(rows, cols));
}

void c_eigen_spmat_c_delete(c_spmat_c *m)
{
  delete &c_to_eigen(m);
}

c_spmat_c* c_eigen_spmat_c_eye(INDEX m)
{
  spmat_c* x = new spmat_c(m, m);
  (*x).setIdentity();
  return eigen_to_c(*x);
}

INDEX c_eigen_spmat_c_rows(c_spmat_c *m)
{
  return c_to_eigen(m).rows();
}

INDEX c_eigen_spmat_c_cols(c_spmat_c *m)
{
  return c_to_eigen(m).cols();
}

INDEX c_eigen_spmat_c_nnz(c_spmat_c *m)
{
  return (c_to_eigen(m)).nonZeros();
}

elt_c c_eigen_spmat_c_get(c_spmat_c *m, INDEX i, INDEX j)
{
  return (c_to_eigen(m)).coeff(i,j);
}

void c_eigen_spmat_c_set(c_spmat_c *m, INDEX i, INDEX j, elt_c x)
{
  (c_to_eigen(m)).coeffRef(i,j) = x;
}

void c_eigen_spmat_c_reset(c_spmat_c *m)
{
  (c_to_eigen(m)).setZero();
}

int c_eigen_spmat_c_is_compressed(c_spmat_c *m)
{
  return (c_to_eigen(m)).isCompressed();
}

void c_eigen_spmat_c_compress(c_spmat_c *m)
{
  (c_to_eigen(m)).makeCompressed();
}

void c_eigen_spmat_c_uncompress(c_spmat_c *m)
{
  (c_to_eigen(m)).uncompress();
}

void c_eigen_spmat_c_reshape(c_spmat_c *m, INDEX rows, INDEX cols)
{
  // FIXME: keep old data
  (c_to_eigen(m)).resize(rows, cols);
}

void c_eigen_spmat_c_prune(c_spmat_c *m, elt_c ref, float eps)
{
  (c_to_eigen(m)).prune(ref, eps);
}

elt_c* c_eigen_spmat_c_valueptr(c_spmat_c *m, INDEX *l)
{
  spmat_c& x = c_to_eigen(m);
  x.makeCompressed();
  *l = x.data().size();
  return x.valuePtr();
}

INDEX* c_eigen_spmat_c_innerindexptr(c_spmat_c *m)
{
  spmat_c& x = c_to_eigen(m);
  x.makeCompressed();
  return x.innerIndexPtr();
}

INDEX* c_eigen_spmat_c_outerindexptr(c_spmat_c *m)
{
  spmat_c& x = c_to_eigen(m);
  x.makeCompressed();
  return x.outerIndexPtr();
}

c_spmat_c* c_eigen_spmat_c_clone(c_spmat_c *m)
{
  spmat_c& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_c(x));
}

c_spmat_c* c_eigen_spmat_c_row(c_spmat_c *m, INDEX i)
{
  spmat_c* x = new spmat_c((c_to_eigen(m)).row(i));
  return eigen_to_c(*x);
}

c_spmat_c* c_eigen_spmat_c_col(c_spmat_c *m, INDEX i)
{
  spmat_c* x = new spmat_c((c_to_eigen(m)).col(i));
  return eigen_to_c(*x);
}

c_spmat_c* c_eigen_spmat_c_transpose(c_spmat_c *m)
{
  spmat_c* x = new spmat_c((c_to_eigen(m)).transpose());
  return eigen_to_c(*x);
}

c_spmat_c* c_eigen_spmat_c_adjoint(c_spmat_c *m)
{
  spmat_c* x = new spmat_c((c_to_eigen(m)).adjoint());
  return eigen_to_c(*x);
}

c_spmat_c* c_eigen_spmat_c_diagonal(c_spmat_c *m)
{
  spmat_c& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_c(x.diagonal().sparseView()));
}

elt_c c_eigen_spmat_c_trace(c_spmat_c *m)
{
  return c_to_eigen(m).diagonal().sparseView().sum();
}

int c_eigen_spmat_c_is_zero(c_spmat_c *m)
{
  spmat_c& x = c_to_eigen(m);
  if (x.nonZeros() == 0)
    return 1;

  elt_c* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k] != zero_c) {
      b = 0;
      break;
    }
  }
  return b;
}

int c_eigen_spmat_c_is_positive(c_spmat_c *m)
{
  spmat_c& x = c_to_eigen(m);
  x.makeCompressed();
  if (x.nonZeros() < (x.rows() * x.cols()))
    return 0;

  elt_c* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k].real() <= 0. || a[k].imag() <= 0.) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_c_is_negative(c_spmat_c *m)
{
  spmat_c& x = c_to_eigen(m);
  x.makeCompressed();
  if (x.nonZeros() < (x.rows() * x.cols()))
    return 0;

  elt_c* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k].real() >= 0. || a[k].imag() >= 0.) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_c_is_nonpositive(c_spmat_c *m)
{
  spmat_c& x = c_to_eigen(m);
  x.makeCompressed();
  elt_c* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k].real() > 0. || a[k].imag() > 0.) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_c_is_nonnegative(c_spmat_c *m)
{
  spmat_c& x = c_to_eigen(m);
  x.makeCompressed();
  elt_c* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k].real() < 0. || a[k].imag() < 0.) {
      b = 0;
      break;
    }
  }

  return b;
}

int c_eigen_spmat_c_is_equal(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c x = c_to_eigen(m0) - c_to_eigen(m1);
  x.prune(zero_c, 0.);
  return (x.nonZeros() == 0);
}

int c_eigen_spmat_c_is_unequal(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c x = c_to_eigen(m0) - c_to_eigen(m1);
  x.prune(zero_c, 0.);
  return (x.nonZeros() != 0);
}

int c_eigen_spmat_c_is_greater(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_c_is_positive(eigen_to_c(x));
}

int c_eigen_spmat_c_is_smaller(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_c_is_negative(eigen_to_c(x));
}

int c_eigen_spmat_c_equal_or_greater(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_c_is_nonnegative(eigen_to_c(x));
}

int c_eigen_spmat_c_equal_or_smaller(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_c_is_nonpositive(eigen_to_c(x));
}

c_spmat_c* c_eigen_spmat_c_add(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c& x0 = c_to_eigen(m0);
  spmat_c& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_c(x0 + x1));
}

c_spmat_c* c_eigen_spmat_c_sub(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c& x0 = c_to_eigen(m0);
  spmat_c& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_c(x0 - x1));
}

c_spmat_c* c_eigen_spmat_c_mul(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c& x0 = c_to_eigen(m0);
  spmat_c& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_c(x0.cwiseProduct(x1)));
}

c_spmat_c* c_eigen_spmat_c_div(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c& x0 = c_to_eigen(m0);
  spmat_c& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_c(x0.cwiseQuotient(x1)));
}

c_spmat_c* c_eigen_spmat_c_dot(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c& x0 = c_to_eigen(m0);
  spmat_c& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_c(x0 * x1));
}

c_spmat_c* c_eigen_spmat_c_add_scalar(c_spmat_c *m, elt_c a)
{
  spmat_c* x = new spmat_c(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_c::InnerIterator it(*x,k); it; ++it)
      it.valueRef() += a;
  return eigen_to_c(*x);
}

c_spmat_c* c_eigen_spmat_c_sub_scalar(c_spmat_c *m, elt_c a)
{
  spmat_c* x = new spmat_c(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_c::InnerIterator it(*x,k); it; ++it)
      it.valueRef() -= a;
  return eigen_to_c(*x);
}

c_spmat_c* c_eigen_spmat_c_mul_scalar(c_spmat_c *m, elt_c a)
{
  spmat_c& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_c(x * a));
}

c_spmat_c* c_eigen_spmat_c_div_scalar(c_spmat_c *m, elt_c a)
{
  spmat_c* x = new spmat_c(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_c::InnerIterator it(*x,k); it; ++it)
      it.valueRef() /= a;
  return eigen_to_c(*x);
}
/*
c_spmat_c* c_eigen_spmat_c_min2(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c& x0 = c_to_eigen(m0);
  spmat_c& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_c(x0.cwiseMin(x1)));
}

c_spmat_c* c_eigen_spmat_c_max2(c_spmat_c *m0, c_spmat_c *m1)
{
  spmat_c& x0 = c_to_eigen(m0);
  spmat_c& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_c(x0.cwiseMax(x1)));
}
*/
elt_c c_eigen_spmat_c_sum(c_spmat_c *m)
{
  return (c_to_eigen(m)).sum();
}
/*
elt_c c_eigen_spmat_c_min(c_spmat_c *m)
{
  elt_c a = std::numeric_limits<elt_c>::infinity();
  spmat_c& x = c_to_eigen(m);
  for (INDEX k = 0; k < x.outerSize(); ++k)
    for (spmat_c::InnerIterator it(x,k); it; ++it)
    {
      if (it.value() < a)
        a = it.value();
    }
  if ((x.nonZeros() < (x.rows() * x.cols())) && (a > 0))
    a = 0;
  return a;
}

elt_c c_eigen_spmat_c_max(c_spmat_c *m)
{
  elt_c a = -std::numeric_limits<elt_c>::infinity();
  spmat_c& x = c_to_eigen(m);
  for (INDEX k = 0; k < x.outerSize(); ++k)
    for (spmat_c::InnerIterator it(x,k); it; ++it)
    {
      if (it.value() > a)
        a = it.value();
    }
  if ((x.nonZeros() < (x.rows() * x.cols())) && (a < 0))
    a = 0;
  return a;
}

c_spmat_c* c_eigen_spmat_c_abs(c_spmat_c *m)
{
  spmat_c* x = new spmat_c((c_to_eigen(m)).cwiseAbs());
  return eigen_to_c(*x);
}
*/
c_spmat_c* c_eigen_spmat_c_neg(c_spmat_c *m)
{
  spmat_c* x = new spmat_c(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_c::InnerIterator it(*x,k); it; ++it)
      it.valueRef() = -it.value();
  return eigen_to_c(*x);
}

c_spmat_c* c_eigen_spmat_c_sqrt(c_spmat_c *m)
{
  spmat_c* x = new spmat_c((c_to_eigen(m)).cwiseSqrt());
  return eigen_to_c(*x);
}

void c_eigen_spmat_c_print(c_spmat_c *m)
{
  std::cout << c_to_eigen(m) << std::endl;
}
