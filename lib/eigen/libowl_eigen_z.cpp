/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


/******************** SparseMatrix_Z: pointer conversion  ********************/

typedef std::complex<double> elt_z;
typedef SparseMatrix<elt_z, Eigen::RowMajor, INDEX> spmat_z;
const elt_z zero_z = 0.;

inline spmat_z& c_to_eigen(c_spmat_z* ptr)
{
  return *reinterpret_cast<spmat_z*>(ptr);
}

inline c_spmat_z* eigen_to_c(spmat_z& ref)
{
  return reinterpret_cast<c_spmat_z*>(&ref);
}

inline CELT_Z eigen_to_c(elt_z& ref)
{
  return *reinterpret_cast<CELT_Z*>(&ref);
}
inline elt_z c_to_eigen(CELT_Z c)
{
  return elt_z(c.r, c.i);
}

inline CELT_Z* eigen_to_c_ptr(elt_z* ref)
{
  return reinterpret_cast<CELT_Z*>(ref);
}

/***************** SparseMatrix_Z: c stubs for c++ functions *****************/

c_spmat_z* c_eigen_spmat_z_new(INDEX rows, INDEX cols)
{
  return eigen_to_c(*new spmat_z(rows, cols));
}

void c_eigen_spmat_z_delete(c_spmat_z *m)
{
  delete &c_to_eigen(m);
}

c_spmat_z* c_eigen_spmat_z_eye(INDEX m)
{
  spmat_z* x = new spmat_z(m, m);
  (*x).setIdentity();
  return eigen_to_c(*x);
}

INDEX c_eigen_spmat_z_rows(c_spmat_z *m)
{
  return c_to_eigen(m).rows();
}

INDEX c_eigen_spmat_z_cols(c_spmat_z *m)
{
  return c_to_eigen(m).cols();
}

INDEX c_eigen_spmat_z_nnz(c_spmat_z *m)
{
  return (c_to_eigen(m)).nonZeros();
}

CELT_Z c_eigen_spmat_z_get(c_spmat_z *m, INDEX i, INDEX j)
{
  elt_z a = (c_to_eigen(m)).coeff(i,j);
  return eigen_to_c(a);
}

void c_eigen_spmat_z_set(c_spmat_z *m, INDEX i, INDEX j, CELT_Z x)
{
  (c_to_eigen(m)).coeffRef(i,j) = c_to_eigen(x);
}

void c_eigen_spmat_z_reset(c_spmat_z *m)
{
  (c_to_eigen(m)).setZero();
}

int c_eigen_spmat_z_is_compressed(c_spmat_z *m)
{
  return (c_to_eigen(m)).isCompressed();
}

void c_eigen_spmat_z_compress(c_spmat_z *m)
{
  (c_to_eigen(m)).makeCompressed();
}

void c_eigen_spmat_z_uncompress(c_spmat_z *m)
{
  (c_to_eigen(m)).uncompress();
}

void c_eigen_spmat_z_reshape(c_spmat_z *m, INDEX rows, INDEX cols)
{
  // FIXME: keep old data
  (c_to_eigen(m)).resize(rows, cols);
}

void c_eigen_spmat_z_prune(c_spmat_z *m, elt_z ref, float eps)
{
  (c_to_eigen(m)).prune(ref, eps);
}

CELT_Z* c_eigen_spmat_z_valueptr(c_spmat_z *m, INDEX *l)
{
  spmat_z& x = c_to_eigen(m);
  x.makeCompressed();
  *l = x.data().size();
  return eigen_to_c_ptr(x.valuePtr());
}

INDEX* c_eigen_spmat_z_innerindexptr(c_spmat_z *m)
{
  spmat_z& x = c_to_eigen(m);
  x.makeCompressed();
  return x.innerIndexPtr();
}

INDEX* c_eigen_spmat_z_outerindexptr(c_spmat_z *m)
{
  spmat_z& x = c_to_eigen(m);
  x.makeCompressed();
  return x.outerIndexPtr();
}

c_spmat_z* c_eigen_spmat_z_clone(c_spmat_z *m)
{
  spmat_z& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_z(x));
}

c_spmat_z* c_eigen_spmat_z_row(c_spmat_z *m, INDEX i)
{
  spmat_z* x = new spmat_z((c_to_eigen(m)).row(i));
  return eigen_to_c(*x);
}

c_spmat_z* c_eigen_spmat_z_col(c_spmat_z *m, INDEX i)
{
  spmat_z* x = new spmat_z((c_to_eigen(m)).col(i));
  return eigen_to_c(*x);
}

c_spmat_z* c_eigen_spmat_z_transpose(c_spmat_z *m)
{
  spmat_z* x = new spmat_z((c_to_eigen(m)).transpose());
  return eigen_to_c(*x);
}

c_spmat_z* c_eigen_spmat_z_adjoint(c_spmat_z *m)
{
  spmat_z* x = new spmat_z((c_to_eigen(m)).adjoint());
  return eigen_to_c(*x);
}

c_spmat_z* c_eigen_spmat_z_diagonal(c_spmat_z *m)
{
  spmat_z& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_z(x.diagonal().sparseView()));
}

CELT_Z c_eigen_spmat_z_trace(c_spmat_z *m)
{
  elt_z a = c_to_eigen(m).diagonal().sparseView().sum();
  return eigen_to_c(a);
}

int c_eigen_spmat_z_is_zero(c_spmat_z *m)
{
  spmat_z& x = c_to_eigen(m);
  if (x.nonZeros() == 0)
    return 1;

  elt_z* a = x.valuePtr();
  int b = 1;
  for (INDEX k = 0; k < x.data().size(); ++k)
  {
    if (a[k] != zero_z) {
      b = 0;
      break;
    }
  }
  return b;
}

int c_eigen_spmat_z_is_positive(c_spmat_z *m)
{
  spmat_z& x = c_to_eigen(m);
  x.makeCompressed();
  if (x.nonZeros() < (x.rows() * x.cols()))
    return 0;

  elt_z* a = x.valuePtr();
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

int c_eigen_spmat_z_is_negative(c_spmat_z *m)
{
  spmat_z& x = c_to_eigen(m);
  x.makeCompressed();
  if (x.nonZeros() < (x.rows() * x.cols()))
    return 0;

  elt_z* a = x.valuePtr();
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

int c_eigen_spmat_z_is_nonpositive(c_spmat_z *m)
{
  spmat_z& x = c_to_eigen(m);
  x.makeCompressed();
  elt_z* a = x.valuePtr();
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

int c_eigen_spmat_z_is_nonnegative(c_spmat_z *m)
{
  spmat_z& x = c_to_eigen(m);
  x.makeCompressed();
  elt_z* a = x.valuePtr();
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

int c_eigen_spmat_z_is_equal(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z x = c_to_eigen(m0) - c_to_eigen(m1);
  x.prune(zero_z, 0.);
  return (x.nonZeros() == 0);
}

int c_eigen_spmat_z_is_unequal(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z x = c_to_eigen(m0) - c_to_eigen(m1);
  x.prune(zero_z, 0.);
  return (x.nonZeros() != 0);
}

int c_eigen_spmat_z_is_greater(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_z_is_positive(eigen_to_c(x));
}

int c_eigen_spmat_z_is_smaller(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_z_is_negative(eigen_to_c(x));
}

int c_eigen_spmat_z_equal_or_greater(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_z_is_nonnegative(eigen_to_c(x));
}

int c_eigen_spmat_z_equal_or_smaller(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z x = c_to_eigen(m0) - c_to_eigen(m1);
  return c_eigen_spmat_z_is_nonpositive(eigen_to_c(x));
}

c_spmat_z* c_eigen_spmat_z_add(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z& x0 = c_to_eigen(m0);
  spmat_z& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_z(x0 + x1));
}

c_spmat_z* c_eigen_spmat_z_sub(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z& x0 = c_to_eigen(m0);
  spmat_z& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_z(x0 - x1));
}

c_spmat_z* c_eigen_spmat_z_mul(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z& x0 = c_to_eigen(m0);
  spmat_z& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_z(x0.cwiseProduct(x1)));
}

c_spmat_z* c_eigen_spmat_z_div(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z& x0 = c_to_eigen(m0);
  spmat_z& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_z(x0.cwiseQuotient(x1)));
}

c_spmat_z* c_eigen_spmat_z_dot(c_spmat_z *m0, c_spmat_z *m1)
{
  spmat_z& x0 = c_to_eigen(m0);
  spmat_z& x1 = c_to_eigen(m1);
  return eigen_to_c(*new spmat_z(x0 * x1));
}

c_spmat_z* c_eigen_spmat_z_add_scalar(c_spmat_z *m, CELT_Z a)
{
  elt_z b = c_to_eigen(a);
  spmat_z* x = new spmat_z(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_z::InnerIterator it(*x,k); it; ++it)
      it.valueRef() += b;
  return eigen_to_c(*x);
}

c_spmat_z* c_eigen_spmat_z_sub_scalar(c_spmat_z *m, CELT_Z a)
{
  elt_z b = c_to_eigen(a);
  spmat_z* x = new spmat_z(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_z::InnerIterator it(*x,k); it; ++it)
      it.valueRef() -= b;
  return eigen_to_c(*x);
}

c_spmat_z* c_eigen_spmat_z_mul_scalar(c_spmat_z *m, CELT_Z a)
{
  elt_z b = c_to_eigen(a);
  spmat_z& x = c_to_eigen(m);
  return eigen_to_c(*new spmat_z(x * b));
}

c_spmat_z* c_eigen_spmat_z_div_scalar(c_spmat_z *m, CELT_Z a)
{
  elt_z b = c_to_eigen(a);
  spmat_z* x = new spmat_z(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_z::InnerIterator it(*x,k); it; ++it)
      it.valueRef() /= b;
  return eigen_to_c(*x);
}

CELT_Z c_eigen_spmat_z_sum(c_spmat_z *m)
{
  elt_z a = (c_to_eigen(m)).sum();
  return eigen_to_c(a);
}
/*
elt_z c_eigen_spmat_z_min(c_spmat_z *m)
{
  elt_z a = std::numeric_limits<elt_z>::infinity();
  spmat_z& x = c_to_eigen(m);
  for (INDEX k = 0; k < x.outerSize(); ++k)
    for (spmat_z::InnerIterator it(x,k); it; ++it)
    {
      if (it.value() < a)
        a = it.value();
    }
  if ((x.nonZeros() < (x.rows() * x.cols())) && (a > 0))
    a = 0;
  return a;
}

elt_z c_eigen_spmat_z_max(c_spmat_z *m)
{
  elt_z a = -std::numeric_limits<elt_z>::infinity();
  spmat_z& x = c_to_eigen(m);
  for (INDEX k = 0; k < x.outerSize(); ++k)
    for (spmat_z::InnerIterator it(x,k); it; ++it)
    {
      if (it.value() > a)
        a = it.value();
    }
  if ((x.nonZeros() < (x.rows() * x.cols())) && (a < 0))
    a = 0;
  return a;
}

c_spmat_z* c_eigen_spmat_z_abs(c_spmat_z *m)
{
  spmat_z* x = new spmat_z((c_to_eigen(m)).cwiseAbs());
  return eigen_to_c(*x);
}
*/
c_spmat_z* c_eigen_spmat_z_neg(c_spmat_z *m)
{
  spmat_z* x = new spmat_z(c_to_eigen(m));
  for (INDEX k = 0; k < (*x).outerSize(); ++k)
    for (spmat_z::InnerIterator it(*x,k); it; ++it)
      it.valueRef() = -it.value();
  return eigen_to_c(*x);
}

c_spmat_z* c_eigen_spmat_z_sqrt(c_spmat_z *m)
{
  spmat_z* x = new spmat_z((c_to_eigen(m)).cwiseSqrt());
  return eigen_to_c(*x);
}

void c_eigen_spmat_z_print(c_spmat_z *m)
{
  std::cout << c_to_eigen(m) << std::endl;
}
