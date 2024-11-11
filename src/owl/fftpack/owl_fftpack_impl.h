/*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 */

#ifdef Treal

#include "pocketfft_hdronly.h"

/** Owl's interface function to pocketfft **/
/** Adapted from scipy's pypocketfft.cxx **/

using namespace pocketfft::detail;

template <typename T>
T norm_fct(int inorm, size_t N)
{
  switch (inorm)
  {
  case 0: // "backward" - no normalization for forward transform
    return T(1);
  case 1: // "forward" - 1/n normalization for forward transform
    return T(1) / T(N);
  case 2: // "ortho" - 1/sqrt(n) normalization for both directions
    return T(1) / std::sqrt(T(N));
  default:
    caml_failwith("invalid value for inorm (must be 0, 1, or 2)");
    // This will never be reached
    return T(0);
  }
}

template <typename T>
T compute_norm_factor(const shape_t &dims, const shape_t &axes, int inorm, size_t fct = 1, int delta = 0)
{
  if (inorm == 0)
    return T(1);
  size_t N = 1;
  for (auto a : axes)
  {
    N *= fct * size_t(int64_t(dims[a]) + delta);
  }
  return norm_fct<T>(inorm, N);
}

extern "C"
{

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
      Treal norm_factor = compute_norm_factor<Treal>(dims, axes, norm);
      try
      {
        pocketfft::detail::c2c(dims, stride_in, stride_out, axes, forward,
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
      Treal norm_factor = compute_norm_factor<Treal>(dims, axes, norm);
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
      Treal norm_factor = compute_norm_factor<Treal>(dims, axes, norm);
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
      Treal norm_factor = (type == 1) ? compute_norm_factor<Treal>(dims, axes, norm, 2, 1)
                                      : compute_norm_factor<Treal>(dims, axes, norm, 2);
      try
      {
        pocketfft::detail::dct(dims, stride_in, stride_out, axes, type,
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
      Treal norm_factor = (type == 1) ? compute_norm_factor<Treal>(dims, axes, norm, 2, 1)
                                      : compute_norm_factor<Treal>(dims, axes, norm, 2);
      try
      {
        pocketfft::detail::dst(dims, stride_in, stride_out, axes, type,
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
} // extern "C"
#endif // Treal
