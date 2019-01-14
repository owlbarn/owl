/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


static OWL_INLINE void
FUNCTION (c, fma_broadcast) (
  int d,
  struct caml_ba_array *W, int64_t *stride_w, int ofs_w,
  struct caml_ba_array *X, int64_t *stride_x, int ofs_x,
  struct caml_ba_array *Y, int64_t *stride_y, int ofs_y,
  struct caml_ba_array *Z, int64_t *stride_z, int ofs_z
)
{
  int inc_w = W->dim[d] == Z->dim[d] ? stride_w[d] : 0;
  int inc_x = X->dim[d] == Z->dim[d] ? stride_x[d] : 0;
  int inc_y = Y->dim[d] == Z->dim[d] ? stride_y[d] : 0;
  int inc_z = stride_z[d];
  const int n = Z->dim[d];

  if (d == X->num_dims - 1) {
    TYPE *w = (TYPE *) W->data + ofs_w;
    TYPE *x = (TYPE *) X->data + ofs_x;
    TYPE *y = (TYPE *) Y->data + ofs_y;
    TYPE *z = (TYPE *) Z->data + ofs_z;

    for (int i = 0; i < n; i++) {
      MAPFUN(w, x, y, z);
      w += inc_w;
      x += inc_x;
      y += inc_y;
      z += inc_z;
    }
  }
  else {
    for (int i = 0; i < n; i++) {
      FUNCTION (c, fma_broadcast) (d+1, W, stride_w, ofs_w, X, stride_x, ofs_x, Y, stride_y, ofs_y, Z, stride_z, ofs_z);
      ofs_w += inc_w;
      ofs_x += inc_x;
      ofs_y += inc_y;
      ofs_z += inc_z;
    }
  }

  return;
}


CAMLprim value
FUNCTION (stub, fma_broadcast_native) (
  value vW, value vSTRIDE_W,
  value vX, value vSTRIDE_X,
  value vY, value vSTRIDE_Y,
  value vZ, value vSTRIDE_Z
)
{
  CAMLparam4(vW, vSTRIDE_W, vX, vSTRIDE_X);
  CAMLxparam4(vY, vSTRIDE_Y, vZ, vSTRIDE_Z);

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

  FUNCTION (c, fma_broadcast) (0, W, stride_w, 0, X, stride_x, 0, Y, stride_y, 0, Z, stride_z, 0);

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}


CAMLprim value FUNCTION (stub, fma_broadcast_byte) (value *argv, int __unused_argn)
{
  return FUNCTION (stub, fma_broadcast_native) (argv[0], argv[1], argv[2],
    argv[3], argv[4], argv[5], argv[6], argv[7]);
}


void FUNCTION (stub, fma) (value vN, value vW, value vX, value vY, value vZ) {
  int N = Long_val(vN);

  struct caml_ba_array *W = Caml_ba_array_val(vW);
  TYPE *W_data = (TYPE *) W->data;
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;
  struct caml_ba_array *Z = Caml_ba_array_val(vZ);
  TYPE *Z_data = (TYPE *) Z->data;

  for (int i = 0; i < N; i++) {
    MAPFUN((W_data + i), (X_data + i), (Y_data + i), (Z_data + i));
  }

}


#endif /* OWL_ENABLE_TEMPLATE */
