/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// function to accumulate all the elements in x
#ifdef FUN5

CAMLprim value FUN5(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;
  INIT;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  while (start_x != stop_x) {
    ACCFN(r, (*start_x));
    start_x += 1;
  };

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(COPYNUM(r));
}

#endif /* FUN5 */


// function to scan all the elements in x then return index
#ifdef FUN6

CAMLprim value FUN6(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;

  NUMBER x = *start_x;
  int r = 0;

  for(int i = 0; i < N; i++) {
    if (CHECKFN(x, *start_x)) {
      x = *start_x;
      r = i;
    };
    start_x += 1;
  };

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_int(r));
}

#endif /* FUN6 */


// function to calculate log_sum_exp specifically
#ifdef FUN8

CAMLprim value FUN8(value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x, *max_start, max_x;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  max_start = start_x;
  max_x = *max_start;

  for (max_start = start_x; max_start != stop_x; max_start += 1)
      max_x = fmax(max_x, *max_start);

  NUMBER1 r = 0.;

  while (start_x != stop_x) {
    r += exp((*start_x) - max_x);
    start_x += 1;
  };

  r = log(r) + max_x;

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(caml_copy_double(r));
}

#endif /* FUN8 */


// function to calculate ssqr
#ifdef FUN9

CAMLprim value FUN9(value vN, value vC, value vX)
{
  CAMLparam3(vN, vC, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  NUMBER *start_x, *stop_x;
  INIT;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;

  while (start_x != stop_x) {
    ACCFN(r, (*start_x));
    start_x += 1;
  };

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(COPYNUM(r));
}

#endif /* FUN9 */


// function to fold two vectors x and y to a scalar value r
#ifdef FUN11

CAMLprim value FUN11(value vN, value vX, value vY)
{
  CAMLparam3(vN, vX, vY);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  NUMBER *start_x, *stop_x;
  NUMBER1 *start_y;
  INIT;

  caml_release_runtime_system();  /* Allow other threads */

  start_x = X_data;
  stop_x = start_x + N;
  start_y = Y_data;

  while (start_x != stop_x) {
    ACCFN(r, (*start_x), (*start_y));
    start_x += 1;
    start_y += 1;
  };

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(COPYNUM(r));
}

#endif /* FUN11 */


// function to fold all the elements in x with extra paramaters A and B
#ifdef FUN23

CAMLprim value FUN23(value vN, value vX, value vA, vB)
{
  CAMLparam4(vN, vX, vA, vB);
  int N = Long_val(vN);
  INIT;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  caml_release_runtime_system();  /* Allow other threads */

  NUMBER *start_x;
  start_x = X_data;

  for(int i = 0; i < N; i++) {
    BFCHKFN;
    if (CHECKFN) {
      AFCHKFN;
    };
    start_x += 1;
  };

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN23 */


// function specifically for folding along a specified axis, aka reduction.
// M: number of slices; N: x's slice size; O: x' strides, also y's slice size;
// X: source; Y: destination. Note that O <= N
#ifdef FUN26

CAMLprim value FUN26(value vM, value vN, value vO, value vX, value vY)
{
  CAMLparam5(vM, vN, vO, vX, vY);
  int M = Long_val(vM);
  int N = Long_val(vN);
  int O = Long_val(vO);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *X_data = (NUMBER *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *Y_data = (NUMBER1 *) Y->data;

  caml_release_runtime_system();  /* Allow other threads */

  NUMBER  *start_x = X_data;
  NUMBER1 *start_y = Y_data;
  NUMBER  *start_x0 = start_x;
  NUMBER1 *start_y0 = start_y;
  int incy = 0;

  // case 1: optimisation
  if (N == O) {
    for (int i = 0; i < M * N; i++) {
      ACCFN((start_x + i), (start_y + i));
    }
  }
  // case 2: optimisation
  else if (O == 1) {
    for (int i = 0; i < M; i++) {
      for (int j = 0; j < N; j++) {
        ACCFN((start_x + j), start_y);
      }
      start_x += N;
      start_y += 1;
    }
  }
  // case 3: common reduction
  else {
    for (int i = 0; i < M; i++) {
      for (int j = 0; j < N; j++) {
        ACCFN((start_x + j), (start_y + incy));
        incy = incy + 1 == O ? 0 : incy + 1;
      }
      start_x += N;
      start_y += O;
    }
  }

  /*** another solution, similar performance
   * int incx = 0;
   * for (int i = 0; i < M * N; i++) {
   *   ACCFN((start_x + i), (start_y + incy));
   *   start_y += (incx + 1 == N ? O : 0);
   *   incx = incx + 1 == N ? 0 : incx + 1;
   *   incy = incy + 1 == O ? 0 : incy + 1;
   * }
   ***/

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}

#endif /* FUN26 */

#ifdef FUN30

CAMLprim value FUN30(value vX, value vY, value vN, value vXshape, value vFrd)
{
  CAMLparam5(vX, vY, vN, vXshape, vFrd);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  NUMBER *x = (NUMBER *) X->data;
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  NUMBER1 *y = (NUMBER1 *) Y->data;

  struct caml_ba_array *Xshape = Caml_ba_array_val(vXshape);
  int64_t *x_shape = (int64_t *) Xshape->data;

  int N = Long_val(vN);
  int ndim = Y->num_dims;
  int frd = Long_val(vFrd);

  int strides[ndim];
  c_ndarray_stride(Y, strides);
  for (int i = frd; i < ndim; i+=2) {
    strides[i] = 0;
  }

  int innersize = x_shape[ndim-1];
  int loopsize  = x_shape[ndim-2];
  int outersize = 1;
  for (int i = 0; i < ndim - 1; i++) {
    outersize *= x_shape[i];
  }

  int y_step = 0;
  if ((ndim % 2 == 0 && frd == 1) ||
      (ndim % 2 == 1 && frd == 0)) {
    y_step = 1;
  }

  caml_release_runtime_system();

  int iy = 0;
  int cnt = 0;

  for (int ix = 0; ix < N; ) {
    if (y_step == 0) {
      /* Case 1: last dimension not to be reduced */
      for (int k = 0; k < innersize; k++) {
        ACCFN((x + ix + k), (y + iy + k));
      }
    }
    else {
      /* Case 2: last dimension to be reduced */
      INIT;
      for (int k = 0; k < innersize; k++) {
        ACCVAL(acc, x[ix + k]);
      }
      ACCVAL(y[iy], acc);
    }

    ix += innersize;
    iy += y_step;
    cnt++;

    if (cnt == loopsize) {
      iy  = 0;
      cnt = 0;
      int residual;
      int iterindex   = ix;
      int pre_iteridx = ix;

      for (int i = ndim - 1; i >= 0; i--) {
        iterindex /= x_shape[i];
        residual = pre_iteridx - iterindex * x_shape[i];
        iy += residual * strides[i];
        pre_iteridx = iterindex;
      }
    }
  }

  caml_acquire_runtime_system();

  CAMLreturn(Val_unit);
}

#endif /* FUN30 */

#undef NUMBER
#undef NUMBER1
#undef CHECKFN
#undef BFCHKFN
#undef AFCHKFN
#undef COPYNUM
#undef ACCFN
#undef ACCVAL
#undef INIT
#undef FUN5
#undef FUN6
#undef FUN8
#undef FUN9
#undef FUN11
#undef FUN23
#undef FUN26
#undef FUN30


#endif /* OWL_ENABLE_TEMPLATE */
