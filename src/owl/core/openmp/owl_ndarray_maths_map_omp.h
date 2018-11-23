/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE

#ifndef INIT // Because some functions do not really utilise this,
#define INIT // so define an empty string as default.
#endif

#include "owl_core_engine.h"
#include "owl_omp_parameters.h"

// function to perform mapping of elements from x to y
#ifdef FUN4

#undef OWL_OMP_THRESHOLD
#define OWL_OMP_THRESHOLD OWL_OMP_THRESHOLD_FUN(FUN4)

CAMLprim value FUN4(value vN, value vX, value vY)
{
  CAMLparam3(vN, vX, vY);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;

  caml_release_runtime_system();  /* Allow other threads */
  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;


//#if FUN4 == F32SIN
//#if float32_sin == float32_cos
/* #if MAPFN(10) == sinf(10)
  fprintf(stderr, "CNM!\n");
  int OWL_OMP_THRESHOLD_FUCK = 10;
#else
  fprintf(stderr, "cao!\n");
  int OWL_OMP_THRESHOLD_FUCK = 1000;
#endif
  fprintf(stderr, "THRD is %d\n", OWL_OMP_THRESHOLD_FUCK); */

  if (N >= OWL_OMP_THRESHOLD) {
    fprintf(stderr, "shit! omp sin32!\n");
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < N; i++) {
      NUMBER x = *(start_x + i);
      *(start_y + i) = (MAPFN(x));
    }
  }
  else {
    fprintf(stderr, "fuck you non-omp sin32!\n");
    while (start_x != stop_x) {
      NUMBER x = *start_x;
      *start_y = (MAPFN(x));

      start_x += 1;
      start_y += 1;
    };
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN4 */


// function to map elements in [x] w.r.t scalar values, linspace and etc.
#ifdef FUN12

CAMLprim value FUN12(value vN, value vA, value vB, value vX)
{
  CAMLparam1(vX);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  caml_release_runtime_system();  /* Allow other threads */

  if (N >= OWL_OMP_THRESHOLD_DEFAULT) {
    #pragma omp parallel for schedule(static)
    for (int i = 1; i <= N; i++) {
      MAPFN(*(X_data + i - 1));
    }
  }
  else {
    for (int i = 1; i <= N; i++) {
      MAPFN(*X_data);
      X_data++;
    }
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN12 */


// function to calculate logspace_base function
#ifdef FUN13

CAMLprim value FUN13(value vN, value vBase, value vA, value vB, value vX)
{
  CAMLparam1(vX);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  caml_release_runtime_system();  /* Allow other threads */

  for (int i = 1; i <= N; i++) {
    MAPFN(X_data);
    X_data++;
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN13 */


// TODO: this needs to be unified with FUN4 in future
// similar to FUN4, but mostly for complex numbers
#ifdef FUN14

CAMLprim value FUN14(value vN, value vX, value vY)
{
  CAMLparam3(vN, vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  NUMBER *start_x;
  NUMBER1 *start_y;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  start_y = Y_data;

  if (N >= OWL_OMP_THRESHOLD_DEFAULT) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < N; i++) {
      MAPFN((start_x + i), (start_y + i));
    }
  }
  else {
    for (int i = 0; i < N; i++) {
      MAPFN(start_x, start_y);
      start_x += 1;
      start_y += 1;
    }
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN14 */


// function to map pairwise elements in x and y then save results to z
#ifdef FUN15

CAMLprim value FUN15(value vN, value vX, value vY, value vZ)
{
  CAMLparam4(vN, vX, vY, vZ);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  struct caml_ba_array *Z = Caml_ba_array_val(vZ);
  NUMBER2 *Z_data = (NUMBER2 *) Z->data;

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;
  NUMBER2 *start_z;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;
  start_z = Z_data;

  if (N >= OWL_OMP_THRESHOLD_DEFAULT) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < N; i++) {
      MAPFN((start_x + i), (start_y + i), (start_z + i));
    }
  }
  else {
    while (start_x != stop_x) {
      MAPFN(start_x, start_y, start_z);
      start_x += 1;
      start_y += 1;
      start_z += 1;
    }
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN15 */


// function to map all elements in [x] w.r.t to [a] then save results to [y]
#ifdef FUN17

CAMLprim value FUN17(value vN, value vX, value vY, value vA)
{
  CAMLparam4(vN, vX, vY, vA);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  NUMBER *start_x;
  NUMBER1 *start_y;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  start_y = Y_data;

  if (N >= OWL_OMP_THRESHOLD_DEFAULT) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < N; i++) {
      MAPFN((start_x + i), (start_y + i));
    }
  }
  else {
    for (int i = 0; i < N; i++) {
      MAPFN(start_x, start_y);
      start_x += 1;
      start_y += 1;
    }
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN17 */


// function to map elements in [x] w.r.t [a] and [b] then save results to [x]
#ifdef FUN18

CAMLprim value FUN18(value vN, value vX, value vA, value vB)
{
  CAMLparam4(vN, vX, vA, vB);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  while (start_x != stop_x) {
    MAPFN(start_x);
    start_x += 1;
  };

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN18 */


// function to map x to y with explicit offset, step size, number of ops
#ifdef FUN19

CAMLprim value FUN19_IMPL(
  value vN,
  value vX, value vOFSX, value vINCX,
  value vY, value vOFSY, value vINCY
)
{
  CAMLparam5(vN, vX, vOFSX, vINCX, vY);
  CAMLxparam2(vOFSY, vINCY);
  int N = Long_val(vN);
  int ofsx = Long_val(vOFSX);
  int incx = Long_val(vINCX);
  int ofsy = Long_val(vOFSY);
  int incy = Long_val(vINCY);

  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  NUMBER  *start_x;
  NUMBER1 *start_y;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data + ofsx;
  start_y = Y_data + ofsy;

  if (N >= OWL_OMP_THRESHOLD_DEFAULT) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < N; i++) {
      MAPFN((start_x + i * incx), (start_y + i * incy));
    }
  }
  else {
    for (int i = 0; i < N; i++) {
      MAPFN(start_x, start_y);
      start_x += incx;
      start_y += incy;
    }
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value FUN19(value *argv, int __unused_argn)
{
  return FUN19_IMPL(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

#endif /* FUN19 */


// function to map x to y with explicit offset, step size, number of ops
// more general version of FUN19, so more control over the access pattern to
// the data with two embedded loops.
#ifdef FUN20

CAMLprim value FUN20_IMPL(
  value vM, value vN,
  value vX, value vOFSX, value vINCX_M, value vINCX_N,
  value vY, value vOFSY, value vINCY_M, value vINCY_N
)
{
  CAMLparam2(vM, vN);
  CAMLxparam4(vX, vOFSX, vINCX_M, vINCX_N);
  CAMLxparam4(vY, vOFSY, vINCY_M, vINCY_N);
  int M = Long_val(vM);
  int N = Long_val(vN);
  int ofsx = Long_val(vOFSX);
  int incx_m = Long_val(vINCX_M);
  int incx_n = Long_val(vINCX_N);
  int ofsy = Long_val(vOFSY);
  int incy_m = Long_val(vINCY_M);
  int incy_n = Long_val(vINCY_N);

  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  NUMBER  *start_x_m;
  NUMBER  *start_x_n;
  NUMBER1 *start_y_m;
  NUMBER1 *start_y_n;

  caml_release_runtime_system();  /* Allow other threads */

  start_x_m = X_data + ofsx;
  start_y_m = Y_data + ofsy;

  if (N >= OWL_OMP_THRESHOLD_DEFAULT) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < M; i++) {
      start_x_n = start_x_m + i * incx_m;
      start_y_n = start_y_m + i * incy_m;

      for (int j = 0; j < N; j++) {
        MAPFN(start_x_n, start_y_n);
        start_x_n += incx_n;
        start_y_n += incy_n;
      }
    }
  }
  else {
    for (int i = 0; i < M; i++) {
      start_x_n = start_x_m;
      start_y_n = start_y_m;

      for (int j = 0; j < N; j++) {
        MAPFN(start_x_n, start_y_n);
        start_x_n += incx_n;
        start_y_n += incy_n;
      }

      start_x_m += incx_m;
      start_y_m += incy_m;
    }
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value FUN20(value *argv, int __unused_argn)
{
  return FUN20_IMPL(
    argv[0], argv[1], argv[2], argv[3], argv[4],
    argv[5], argv[6], argv[7], argv[8], argv[9]
  );
}

#endif /* FUN20 */


// broadcast function of x and y then save the result to z
#ifdef FUN24

static OWL_INLINE void FUN24_CODE (
  int d,
  struct caml_ba_array *X, int64_t *stride_x, int ofs_x,
  struct caml_ba_array *Y, int64_t *stride_y, int ofs_y,
  struct caml_ba_array *Z, int64_t *stride_z, int ofs_z
)
{
  int inc_x = X->dim[d] == Z->dim[d] ? stride_x[d] : 0;
  int inc_y = Y->dim[d] == Z->dim[d] ? stride_y[d] : 0;
  int inc_z = stride_z[d];
  const int n = Z->dim[d];

  if (d == X->num_dims - 1) {
    NUMBER *x = (NUMBER *) X->data + ofs_x;
    NUMBER *y = (NUMBER *) Y->data + ofs_y;
    NUMBER *z = (NUMBER *) Z->data + ofs_z;

    for (int i = 0; i < n; i++) {
      MAPFN(x, y, z);
      x += inc_x;
      y += inc_y;
      z += inc_z;
    }
  }
  else {
    for (int i = 0; i < n; i++) {
      FUN24_CODE (d+1, X, stride_x, ofs_x, Y, stride_y, ofs_y, Z, stride_z, ofs_z);
      ofs_x += inc_x;
      ofs_y += inc_y;
      ofs_z += inc_z;
    }
  }

  return;
}

CAMLprim value FUN24_IMPL(
  value vX, value vSTRIDE_X,
  value vY, value vSTRIDE_Y,
  value vZ, value vSTRIDE_Z
)
{
  CAMLparam4(vX, vSTRIDE_X, vY, vSTRIDE_Y);
  CAMLxparam2(vZ, vSTRIDE_Z);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  struct caml_ba_array *Z = Caml_ba_array_val(vZ);

  struct caml_ba_array *stride_X = Caml_ba_array_val(vSTRIDE_X);
  int64_t *stride_x = (int64_t *) stride_X->data;
  struct caml_ba_array *stride_Y = Caml_ba_array_val(vSTRIDE_Y);
  int64_t *stride_y = (int64_t *) stride_Y->data;
  struct caml_ba_array *stride_Z = Caml_ba_array_val(vSTRIDE_Z);
  int64_t *stride_z = (int64_t *) stride_Z->data;

  caml_release_runtime_system();  /* Allow other threads */

  FUN24_CODE (0, X, stride_x, 0, Y, stride_y, 0, Z, stride_z, 0);

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value FUN24(value *argv, int __unused_argn)
{
  return FUN24_IMPL(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

#endif /* FUN24 */


// broadcast function of x and y then save the result to z. Compared to FUN24,
// the difference of FUN25 is z has one extra dimension than max(dim_x, dim_y).
// This function is used in owl's distribution module and extra dimension is
// used as sample dimension.
#ifdef FUN25

static OWL_INLINE void FUN25_CODE (
  int d,
  struct caml_ba_array *X, int64_t *stride_x, int ofs_x,
  struct caml_ba_array *Y, int64_t *stride_y, int ofs_y,
  struct caml_ba_array *Z, int64_t *stride_z, int ofs_z
)
{
  int inc_x = X->dim[d] == Z->dim[d+1] ? stride_x[d] : 0;
  int inc_y = Y->dim[d] == Z->dim[d+1] ? stride_y[d] : 0;
  int inc_z = stride_z[d+1];
  const int n = Z->dim[d+1];


  if (d == X->num_dims - 1) {
    NUMBER *x = (NUMBER *) X->data + ofs_x;
    NUMBER *y = (NUMBER *) Y->data + ofs_y;
    NUMBER *z = (NUMBER *) Z->data + ofs_z;


    for (int i = 0; i < n; i++) {
      MAPFN(x, y, z);
      x += inc_x;
      y += inc_y;
      z += inc_z;
    }
  }
  else {
    for (int i = 0; i < n; i++) {
      FUN25_CODE (d+1, X, stride_x, ofs_x, Y, stride_y, ofs_y, Z, stride_z, ofs_z);
      ofs_x += inc_x;
      ofs_y += inc_y;
      ofs_z += inc_z;
    }
  }

  return;
}

CAMLprim value FUN25_IMPL(
  value vX, value vSTRIDE_X,
  value vY, value vSTRIDE_Y,
  value vZ, value vSTRIDE_Z
)
{
  CAMLparam4(vX, vSTRIDE_X, vY, vSTRIDE_Y);
  CAMLxparam2(vZ, vSTRIDE_Z);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  struct caml_ba_array *Z = Caml_ba_array_val(vZ);

  struct caml_ba_array *stride_X = Caml_ba_array_val(vSTRIDE_X);
  int64_t *stride_x = (int64_t *) stride_X->data;
  struct caml_ba_array *stride_Y = Caml_ba_array_val(vSTRIDE_Y);
  int64_t *stride_y = (int64_t *) stride_Y->data;
  struct caml_ba_array *stride_Z = Caml_ba_array_val(vSTRIDE_Z);
  int64_t *stride_z = (int64_t *) stride_Z->data;

  caml_release_runtime_system();  /* Allow other threads */

  int ofs_z = 0;

  for (int i = 0; i < Z->dim[0]; i++) {
    FUN25_CODE (0, X, stride_x, 0, Y, stride_y, 0, Z, stride_z, ofs_z);
    ofs_z += stride_z[0];
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value FUN25(value *argv, int __unused_argn)
{
  return FUN25_IMPL(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

#endif /* FUN25 */


// Similar to FUN25, but broadcast between w, x, y, then save the result to z
#ifdef FUN27

static OWL_INLINE void FUN27_CODE (
  int d,
  struct caml_ba_array *W, int64_t *stride_w, int ofs_w,
  struct caml_ba_array *X, int64_t *stride_x, int ofs_x,
  struct caml_ba_array *Y, int64_t *stride_y, int ofs_y,
  struct caml_ba_array *Z, int64_t *stride_z, int ofs_z
)
{
  int inc_w = W->dim[d] == Z->dim[d+1] ? stride_w[d] : 0;
  int inc_x = X->dim[d] == Z->dim[d+1] ? stride_x[d] : 0;
  int inc_y = Y->dim[d] == Z->dim[d+1] ? stride_y[d] : 0;
  int inc_z = stride_z[d+1];
  const int n = Z->dim[d+1];


  if (d == X->num_dims - 1) {
    NUMBER *w = (NUMBER *) W->data + ofs_w;
    NUMBER *x = (NUMBER *) X->data + ofs_x;
    NUMBER *y = (NUMBER *) Y->data + ofs_y;
    NUMBER *z = (NUMBER *) Z->data + ofs_z;

    for (int i = 0; i < n; i++) {
      MAPFN(w, x, y, z);
      w += inc_w;
      x += inc_x;
      y += inc_y;
      z += inc_z;
    }
  }
  else {
    for (int i = 0; i < n; i++) {
      FUN27_CODE (d+1, W, stride_w, ofs_w, X, stride_x, ofs_x, Y, stride_y, ofs_y, Z, stride_z, ofs_z);
      ofs_w += inc_w;
      ofs_x += inc_x;
      ofs_y += inc_y;
      ofs_z += inc_z;
    }
  }

  return;
}

CAMLprim value FUN27_IMPL(
  value vW, value vSTRIDE_W,
  value vX, value vSTRIDE_X,
  value vY, value vSTRIDE_Y,
  value vZ, value vSTRIDE_Z
)
{
  CAMLparam4(vW, vSTRIDE_W, vX, vSTRIDE_X);
  CAMLparam4(vY, vSTRIDE_Y, vZ, vSTRIDE_Z);

  struct caml_ba_array *W = Caml_ba_array_val(vW);
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  struct caml_ba_array *Z = Caml_ba_array_val(vZ);

  struct caml_ba_array *stride_W = Caml_ba_array_val(vSTRIDE_W);
  int64_t *stride_w = (int64_t *) stride_W->data;
  struct caml_ba_array *stride_X = Caml_ba_array_val(vSTRIDE_X);
  int64_t *stride_x = (int64_t *) stride_X->data;
  struct caml_ba_array *stride_Y = Caml_ba_array_val(vSTRIDE_Y);
  int64_t *stride_y = (int64_t *) stride_Y->data;
  struct caml_ba_array *stride_Z = Caml_ba_array_val(vSTRIDE_Z);
  int64_t *stride_z = (int64_t *) stride_Z->data;

  caml_release_runtime_system();  /* Allow other threads */

  int ofs_z = 0;

  for (int i = 0; i < Z->dim[0]; i++) {
    FUN27_CODE (0, W, stride_w, 0, X, stride_x, 0, Y, stride_y, 0, Z, stride_z, ofs_z);
    ofs_z += stride_z[0];
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value FUN27(value *argv, int __unused_argn)
{
  return FUN27_IMPL(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

#endif /* FUN27 */


// function to map x to y with explicit offset, step size, number of ops
// more general version of FUN20, so more control over the access pattern to
// the data with three embedded loops.
#ifdef FUN28

CAMLprim value FUN28_IMPL(
  value vM, value vN, value vO,
  value vX, value vOFSX, value vINCX_M, value vINCX_N, value vINCX_O,
  value vY, value vOFSY, value vINCY_M, value vINCY_N, value vINCY_O
)
{
  CAMLparam3(vM, vN, vO);
  CAMLxparam5(vX, vOFSX, vINCX_M, vINCX_N, vINCX_O);
  CAMLxparam5(vY, vOFSY, vINCY_M, vINCY_N, vINCY_O);
  int M = Long_val(vM);
  int N = Long_val(vN);
  int O = Long_val(vO);
  int ofsx = Long_val(vOFSX);
  int incx_m = Long_val(vINCX_M);
  int incx_n = Long_val(vINCX_N);
  int incx_o = Long_val(vINCX_O);
  int ofsy = Long_val(vOFSY);
  int incy_m = Long_val(vINCY_M);
  int incy_n = Long_val(vINCY_N);
  int incy_o = Long_val(vINCY_O);

  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  NUMBER  *start_x_m;
  NUMBER  *start_x_n;
  NUMBER  *start_x_o;
  NUMBER1 *start_y_m;
  NUMBER1 *start_y_n;
  NUMBER1 *start_y_o;

  caml_release_runtime_system();  /* Allow other threads */

  start_x_m = X_data + ofsx;
  start_y_m = Y_data + ofsy;

  for (int i = 0; i < M; i++) {
    start_x_n = start_x_m;
    start_y_n = start_y_m;

    for (int j = 0; j < N; j++) {
      start_x_o = start_x_n;
      start_y_o = start_y_n;

      for (int k = 0; k < O; k++) {
        MAPFN(start_x_o, start_y_o);
        start_x_o += incx_o;
        start_y_o += incy_o;
      }

      start_x_n += incx_n;
      start_y_n += incy_n;
    }

    start_x_m += incx_m;
    start_y_m += incy_m;
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

CAMLprim value FUN28(value *argv, int __unused_argn)
{
  return FUN28_IMPL(
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6],
    argv[7], argv[8], argv[9], argv[10], argv[11], argv[12]
  );
}

#endif /* FUN28 */


// function to map [x] w.r.t scalar values, similar to FUN12 but saves to Y
#ifdef FUN29

CAMLprim value FUN29(value vN, value vA, value vB, value vX, value vY)
{
  CAMLparam5(vN, vA, vB, vX, vY);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER *Y_data = (NUMBER *) Y->data;

  caml_release_runtime_system();  /* Allow other threads */

  if (N >= OWL_OMP_THRESHOLD_DEFAULT) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < N; i++) {
      MAPFN(*(X_data + i), *(Y_data + i));
    }
  }
  else {
    for (int i = 0; i < N; i++) {
      MAPFN(*(X_data + i), *(Y_data + i));
    }
  }

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN29 */


#undef NUMBER
#undef NUMBER1
#undef NUMBER2
#undef MAPFN
#undef MAPFN1
#undef MAPFN2
#undef MAPFN3
#undef INIT
#undef FUN4
#undef FUN12
#undef FUN13
#undef FUN14
#undef FUN15
#undef FUN17
#undef FUN18
#undef FUN19
#undef FUN19_IMPL
#undef FUN20
#undef FUN20_IMPL
#undef FUN24
#undef FUN24_IMPL
#undef FUN24_CODE
#undef FUN25
#undef FUN25_IMPL
#undef FUN25_CODE
#undef FUN27
#undef FUN27_IMPL
#undef FUN27_CODE
#undef FUN28
#undef FUN28_IMPL
#undef FUN29
#undef OWL_OMP_THRESHOLD

#endif /* OWL_ENABLE_TEMPLATE */
