/*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 */

#ifdef Treal

#ifdef CAML_COMPATIBILITY_H
#undef invalid_argument /* For version < 5.0 of the OCaml compiler, allowing std::invalid_argument to be used */
#endif

#include "pocketfft_hdronly.h"

#ifdef CAML_COMPATIBILITY_H
#define invalid_argument caml_invalid_argument
#endif

/** Owl's interface function to pocketfft **/
/** Adapted from scipy's pypocketfft.cxx **/

using namespace pocketfft::detail;

using ldbl_t = typename std::conditional<
    sizeof(long double) == sizeof(double), double, long double>::type;

template <typename T>
T norm_fct(int inorm, size_t N)
{
  if (inorm == 0)
    return T(1);
  if (inorm == 2)
    return T(1 / ldbl_t(N));
  if (inorm == 1)
    return T(1 / sqrt(ldbl_t(N)));
  caml_failwith("invalid value for norm (must be 0, 1, or 2)"); // could make use of caml exections
  // This will never be reached
  return T(0);
}

template <typename T>
T norm_fct(int inorm, const shape_t &shape,
           const shape_t &axes, size_t fct = 1, int delta = 0)
{
  if (inorm == 0)
    return T(1);

  size_t N = 1;
  for (auto a : axes)
    N *= fct * size_t(int64_t(shape[a]) + delta);

  return norm_fct<T>(inorm, N);
}

/** Owl's stub functions **/

/**
 * Complex-to-complex FFT
 * @param forward: true for forward transform, false for backward transform
 * @param X: input array
 * @param Y: output array
 * @param d: dimension along which to perform the transform
 * @param norm: normalization factor
 * @param nthreads: number of threads to use
 *
 * @return unit
 */
value STUB_CFFT(value vForward, value vX, value vY, value vD, value vNorm, value vNthreads)
{
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  std::complex<Treal> *X_data = reinterpret_cast<std::complex<Treal> *>(X->data);

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  std::complex<Treal> *Y_data = reinterpret_cast<std::complex<Treal> *>(Y->data);

  int d = Long_val(vD);
  int n = X->dim[d];
  int norm = Long_val(vNorm);
  int nthreads = Long_val(vNthreads);
  int forward = Bool_val(vForward);

  shape_t dims;
  stride_t stride_in, stride_out;

  for (int i = 0; i < X->num_dims; ++i)
  {
    dims.push_back(static_cast<size_t>(X->dim[i]));
  }

  size_t multiplier = sizeof(std::complex<Treal>);
  for (int i = 0; i < X->num_dims; ++i)
  {
    stride_in.push_back(c_ndarray_stride_dim(X, i) * multiplier);
    stride_out.push_back(c_ndarray_stride_dim(Y, i) * multiplier);
  }

  shape_t axes{static_cast<size_t>(d)};
  {
    Treal norm_factor = norm_fct<Treal>(norm, dims, axes);
    try
    {
      pocketfft::c2c(dims, stride_in, stride_out, axes, forward,
                     X_data, Y_data, norm_factor, nthreads);
    }
    catch (const std::exception &e)
    {
      caml_failwith(e.what()); // maybe raise an OCaml exception here ??
    }
  }

  return Val_unit;
}

/**
 * Complex-to-complex FFT
 * @param argv: array of arguments
 * @param argn: number of arguments
 * @see STUB_CFFT, https://ocaml.org/manual/5.2/intfc.html#ss:c-prim-impl
 */
value STUB_CFFT_bytecode(value *argv, int argn)
{
  return STUB_CFFT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

/**
 * Forward Real-to-complex FFT
 * @param X: input array (real data)
 * @param Y: output array (complex data)
 * @param d: dimension along which to perform the transform
 * @param norm: normalization factor
 * @param nthreads: number of threads to use
 *
 * @return unit
 */
value STUB_RFFTF(value vX, value vY, value vD, value vNorm, value vNthreads)
{
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  Treal *X_data = reinterpret_cast<Treal *>(X->data);

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  std::complex<Treal> *Y_data = reinterpret_cast<std::complex<Treal> *>(Y->data);

  int d = Long_val(vD);
  int n = X->dim[d];
  int norm = Long_val(vNorm);
  int nthreads = Long_val(vNthreads);

  shape_t dims;
  stride_t stride_in, stride_out;

  for (int i = 0; i < X->num_dims; ++i)
  {
    dims.push_back(static_cast<size_t>(X->dim[i]));
  }

  size_t multiplier = sizeof(Treal);
  for (int i = 0; i < X->num_dims; ++i)
  {
    stride_in.push_back(c_ndarray_stride_dim(X, i) * multiplier);
  }

  multiplier = sizeof(std::complex<Treal>);
  for (int i = 0; i < Y->num_dims; ++i)
  {
    stride_out.push_back(c_ndarray_stride_dim(Y, i) * multiplier);
  }

  shape_t axes{static_cast<size_t>(d)};
  {
    Treal norm_factor = norm_fct<Treal>(norm, dims, axes);
    try
    {
      pocketfft::r2c(dims, stride_in, stride_out, axes, pocketfft::FORWARD,
                     X_data, Y_data, norm_factor, nthreads);
    }
    catch (const std::exception &e)
    {
      caml_failwith(e.what()); // maybe raise an OCaml exception here ??
    }
  }

  return Val_unit;
}

/**
 * Backward Real-to-complex FFT
 * @param X: input array (complex data)
 * @param Y: output array (real data)
 * @param d: dimension along which to perform the transform
 * @param norm: normalization factor
 * @param nthreads: number of threads to use
 *
 * @return unit
 */
value STUB_RFFTB(value vX, value vY, value vD, value vNorm, value vNthreads)
{
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  std::complex<Treal> *X_data = reinterpret_cast<std::complex<Treal> *>(X->data);

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  Treal *Y_data = reinterpret_cast<Treal *>(Y->data);

  int d = Long_val(vD);
  int n = X->dim[d];
  int norm = Long_val(vNorm);
  int nthreads = Long_val(vNthreads);

  if (Y->dim[d] != (X->dim[d] - 1) * 2)
    caml_failwith("Invalid output dimension for inverse real FFT");

  shape_t dims;
  stride_t stride_in, stride_out;

  int ncomplex = X->dim[d];
  int nreal = Y->dim[d];

  for (int i = 0; i < X->num_dims; ++i)
  {
    if (i == d)
    {
      dims.push_back(static_cast<size_t>(nreal));
    }
    else
    {
      dims.push_back(static_cast<size_t>(X->dim[i]));
    }
  }

  size_t multiplier = sizeof(std::complex<Treal>);
  for (int i = 0; i < X->num_dims; ++i)
  {
    stride_in.push_back(c_ndarray_stride_dim(X, i) * multiplier);
  }

  multiplier = sizeof(Treal);
  for (int i = 0; i < Y->num_dims; ++i)
  {
    stride_out.push_back(c_ndarray_stride_dim(Y, i) * multiplier);
  }

  shape_t axes{static_cast<size_t>(d)};
  {
    Treal norm_factor = norm_fct<Treal>(norm, dims, axes);
    try
    {
      pocketfft::c2r(dims, stride_in, stride_out, axes, pocketfft::BACKWARD,
                     X_data, Y_data, norm_factor, nthreads);
    }
    catch (const std::exception &e)
    {
      caml_failwith(e.what()); // maybe raise an OCaml exception here ??
    }
  }

  return Val_unit;
}

/**
 * Discrete Cosine Transform
 * @param X: input array
 * @param Y: output array
 * @param d: dimension along which to perform the transform
 * @param type: type of DCT (1, 2, 3, or 4)
 * @param norm: normalization factor
 * @param nthreads: number of threads to use
 *
 * @return unit
 */
value STUB_RDCT(value vX, value vY, value vD, value vType, value vNorm, value vOrtho, value vNthreads)
{
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  Treal *X_data = reinterpret_cast<Treal *>(X->data);

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  Treal *Y_data = reinterpret_cast<Treal *>(Y->data);

  int d = Long_val(vD);
  int n = X->dim[d];
  int type = Long_val(vType);
  if (type < 1 || type > 4) // should not happen as it's checked on the OCaml side
    caml_failwith("invalid value for type (must be 1, 2, 3, or 4)");
  int norm = Long_val(vNorm);
  bool ortho = Bool_val(vOrtho);
  int nthreads = Long_val(vNthreads);

  shape_t dims;
  stride_t stride_in, stride_out;

  for (int i = 0; i < X->num_dims; ++i)
  {
    dims.push_back(static_cast<size_t>(X->dim[i]));
  }

  size_t multiplier = sizeof(Treal);
  for (int i = 0; i < X->num_dims; ++i)
  {
    stride_in.push_back(c_ndarray_stride_dim(X, i) * multiplier);
    stride_out.push_back(c_ndarray_stride_dim(Y, i) * multiplier);
  }

  shape_t axes{static_cast<size_t>(d)};
  {
    Treal norm_factor = (type == 1) ? norm_fct<Treal>(norm, dims, axes, 2, -1)
                                    : norm_fct<Treal>(norm, dims, axes, 2);
    try
    {
      pocketfft::dct(dims, stride_in, stride_out, axes, type,
                     X_data, Y_data, norm_factor, ortho, nthreads);
    }
    catch (const std::exception &e)
    {
      caml_failwith(e.what()); // maybe raise an OCaml exception here ??
    }
  }

  return Val_unit;
}

value STUB_RDCT_bytecode(value *argv, int argn)
{
  return STUB_RDCT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

/**
 * Discrete Sine Transform
 * @param X: input array
 * @param Y: output array
 * @param d: dimension along which to perform the transform
 * @param type: type of DST (1, 2, 3, or 4)
 * @param norm: normalization factor
 * @param nthreads: number of threads to use
 *
 * @return unit
 */
value STUB_RDST(value vX, value vY, value vD, value vType, value vNorm, value vOrtho, value vNthreads)
{
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  Treal *X_data = reinterpret_cast<Treal *>(X->data);

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  Treal *Y_data = reinterpret_cast<Treal *>(Y->data);

  int d = Long_val(vD);
  int n = X->dim[d];
  int type = Long_val(vType);
  if (type < 1 || type > 4) // should not happen as it's checked on the OCaml side
    caml_failwith("invalid value for type (must be 1, 2, 3, or 4)");
  int norm = Long_val(vNorm);
  bool ortho = Bool_val(vOrtho);
  int nthreads = Long_val(vNthreads);

  shape_t dims;
  stride_t stride_in, stride_out;

  for (int i = 0; i < X->num_dims; ++i)
  {
    dims.push_back(static_cast<size_t>(X->dim[i]));
  }

  size_t multiplier = sizeof(Treal);
  for (int i = 0; i < X->num_dims; ++i)
  {
    stride_in.push_back(c_ndarray_stride_dim(X, i) * multiplier);
    stride_out.push_back(c_ndarray_stride_dim(Y, i) * multiplier);
  }

  shape_t axes{static_cast<size_t>(d)};
  {
    Treal norm_factor = (type == 1) ? norm_fct<Treal>(norm, dims, axes, 2, 1)
                                    : norm_fct<Treal>(norm, dims, axes, 2);
    try
    {
      pocketfft::dst(dims, stride_in, stride_out, axes, type,
                     X_data, Y_data, norm_factor, ortho, nthreads);
    }
    catch (const std::exception &e)
    {
      caml_failwith(e.what()); // maybe raise an OCaml exception here ??
    }
  }

  return Val_unit;
}

value STUB_RDST_bytecode(value *argv, int argn)
{
  return STUB_RDST(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}
#endif // Treal
