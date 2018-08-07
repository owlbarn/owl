/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


CAMLprim value FUNCTION (stub, repeat_native) (
  value vX, value vY, value vReps, value vShape_x
) {

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *x = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *y = (TYPE *) Y->data;

  struct caml_ba_array *Reps = Caml_ba_array_val(vReps);
  int64_t *reps = (int64_t *) Reps->data;

  struct caml_ba_array *Shape_x = Caml_ba_array_val(vShape_x);
  int64_t *shape_x = (int64_t *) Shape_x->data;

  int highest_dim = X->num_dims - 1;

  /* Special case : vector input */

  if (highest_dim == 0) {
    int xlen  = shape_x[0];
    int repsd = reps[0];
    int ofsy  = 0;
    for (int i = 0; i < xlen; ++i) {
      COPYFUN(repsd, x, i, 0, y, ofsy, 1);
      ofsy += repsd;
    }
    return Val_unit;
  }

  int stride_y[highest_dim + 1];
  c_ndarray_stride(Y, stride_y);

  int slice_x[highest_dim + 1];
  c_ndarray_slice(X, slice_x);

  int HD = highest_dim + 1; /* Highest non-one-repeat dimension */
  for (int i = highest_dim; i >= 0; --i) {
    if (reps[i] == 1) { HD--; } else { break; }
  }
  HD = (HD > highest_dim) ? highest_dim : HD;

  /* Copy the HD dimension from x to y */

  int block_num[HD];
  for (int i = 0; i < HD; ++i) {
    block_num[i] = slice_x[i] / slice_x[HD];
  }
  int counter[HD];
  memset(counter, 0, sizeof(counter));

  int ofsx = 0;
  int ofsy = 0;
  int block_sz = reps[HD];
  int num_hd = block_num[0];

  for (int i = 0; i < num_hd; ++i) {
    /* Copy the last-dim block */
    int ofsy_sub = ofsy;
    if (block_sz == 1) {
      COPYFUN(slice_x[HD], x, ofsx, 1, y, ofsy, 1);
    } else {
      for (int j = 0; j < slice_x[HD]; ++j) {
        COPYFUN(block_sz, x, ofsx + j, 0, y, ofsy_sub, 1);
        ofsy_sub += block_sz;
      }
    }
    /* Increase index */
    ofsx += slice_x[HD];
    ofsy += stride_y[HD - 1] * reps[HD - 1];
    for (int j = HD - 1; j > 0; --j) {
      int c = counter[j];
      if (c + 1 == block_num[j]) {
        ofsy += stride_y[j - 1] * (reps[j - 1] - 1);
      }
      counter[j] = (c + 1 == block_num[j] ? 0 : c + 1);
    }
  }

  /* Copy the lower dimensions within y */

  for (int d = HD - 1; d >= 0; --d) {
    for (int i = 0; i <= d; ++i) {
      block_num[i] = slice_x[i] / slice_x[d + 1];
    }

    int ofsy = 0;
    int block_sz = stride_y[d];
    memset(counter, 0, sizeof(counter));

    for (int i = 0; i < block_num[0]; ++i) {
      /* Block copy */
      int ofsy_sub = ofsy + block_sz;
      for (int j = 1; j < reps[d]; ++j) {
        COPYFUN(block_sz, y, ofsy, 1, y, ofsy_sub, 1);
        ofsy_sub += block_sz;
      }
      /* Increase index */
      ofsy += stride_y[d] * reps[d];
      for (int j = d - 1; j >= 0; --j) {
        int c = counter[j];
        if (c + 1 == block_num[j + 1]) {
          ofsy += stride_y[j] * (reps[j] - 1);
        }
        counter[j] = (c + 1 == block_num[j + 1] ? 0 : c + 1);
      }
    }
  }

  return Val_unit;
}


CAMLprim value FUNCTION (stub, repeat_axis_native) (
  value vX, value vY, value vAxis, value vRep
) {

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *x = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *y = (TYPE *) Y->data;

  int axis = Long_val(vAxis);
  int rep = Long_val(vRep);
  int highest_dim = X->num_dims - 1;
  int numel_x = c_ndarray_numel(X);

  /* Special case : repeat along highest_dim */

  if (axis == highest_dim) {
    int ofsy = 0;
    for (int i = 0; i < numel_x; ++i) {
      COPYFUN(rep, x, i, 0, y, ofsy, 1);
      ofsy += rep;
    }
    return Val_unit;
  }

  int slice_sz = c_ndarray_stride_dim(X, axis);
  int block_num = numel_x / slice_sz;

  int ofsx = 0;
  int ofsy = 0;
  for (int i = 0; i < block_num; ++i) {
    for (int j = 0; j < rep; ++j) {
      COPYFUN(slice_sz, x, ofsx, 1, y, ofsy, 1);
      ofsy += slice_sz;
    }
    ofsx += slice_sz;
  }

  return Val_unit;
}


CAMLprim value FUNCTION (stub, tile_native) (
  value vX, value vY, value vReps, value vShape_x
) {

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *x = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *y = (TYPE *) Y->data;

  struct caml_ba_array *Reps = Caml_ba_array_val(vReps);
  int64_t *reps = (int64_t *) Reps->data;

  struct caml_ba_array *Shape_x = Caml_ba_array_val(vShape_x);
  int64_t *shape_x = (int64_t *) Shape_x->data;

  int highest_dim = X->num_dims - 1;

  /* Special case : vector input */

  if (highest_dim == 0) {
    int xlen  = c_ndarray_numel(X);
    int repsd = reps[0];
    int ofsy  = 0;
    for (int i = 0; i < repsd; ++i) {
      COPYFUN(xlen, x, 0, 1, y, ofsy, 1);
      ofsy += xlen;
    }
    return Val_unit;
  }

  int slice_x[highest_dim + 1];
  c_ndarray_slice(X, slice_x);

  int block_idx[highest_dim + 1]; /* Block size for copy in each dimension */
  block_idx[highest_dim] = 1;
  for (int i = highest_dim - 1; i >= 0; --i) {
    block_idx[i] = block_idx[i+1] * reps[i + 1];
  }
  for (int i = 0; i <= highest_dim; ++i) {
    block_idx[i] = block_idx[i] * slice_x[i];
  }

  int HD = highest_dim + 1; /* Highest non-one-repeat dimension */
  for (int i = highest_dim; i >= 0; --i) {
    if (reps[i] == 1) { HD--; } else { break; }
  }
  HD = (HD > highest_dim) ? highest_dim : HD;

  /* Copy the HD dimension from x to y */

  int block_num[HD];
  for (int i = 0; i < HD; ++i) {
    block_num[i] = slice_x[i] / slice_x[HD];
  }
  int counter[HD];
  memset(counter, 0, sizeof(counter));

  int reps_hd = reps[HD];
  int slice_sz = slice_x[HD];
  int num_hd = block_num[0];
  int incr_hd = block_idx[HD] * reps_hd;

  int ofsx = 0;
  int ofsy = 0;
  for (int i = 0; i < num_hd; ++i) {
    /* Copy the last-dim block */
    int ofsy_sub = ofsy;
    for (int j = 0; j < reps_hd; ++j) {
      COPYFUN(slice_sz, x, ofsx, 1, y, ofsy_sub, 1);
      ofsy_sub += slice_sz;
    }
    /* Increase index */
    ofsx += slice_x[HD];
    ofsy += incr_hd;
    for (int j = HD - 1; j > 0; --j) {
      int c = counter[j];
      if (c + 1 == block_num[j]) {
        ofsy += block_idx[j] * (reps[j] - 1);
      }
      counter[j] = (c + 1 == block_num[j] ? 0 : c + 1);
    }
  }

  /* Copy the lower dimensions within y */

  for (int d = HD - 1; d >= 0; --d) {
    for (int i = 0; i <= d; ++i) {
      block_num[i] = slice_x[i] / slice_x[d];
    }

    int block_sz = block_idx[d];
    int incr_d = block_sz * reps[d];
    memset(counter, 0, sizeof(counter));

    int ofsy = 0;
    for (int i = 0; i < block_num[0]; ++i) {
      /* Block copy */
      int ofsy_sub = ofsy + block_sz;
      for (int j = 1; j < reps[d]; ++j) {
        COPYFUN(block_sz, y, ofsy, 1, y, ofsy_sub, 1);
        ofsy_sub += block_sz;
      }
      /* Increase index */
      ofsy += incr_d;
      for (int j = d - 1; j >= 0; --j) {
        int c = counter[j];
        if (c + 1 == block_num[j]) {
          ofsy += block_idx[j] * (reps[j] - 1);
        }
        counter[j] = (c + 1 == block_num[j] ? 0 : c + 1);
      }
    }
  }

  return Val_unit;
}


CAMLprim value FUNCTION (stub, tile_axis_native) (
  value vX, value vY, value vAxis, value vRep
) {

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *x = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *y = (TYPE *) Y->data;

  int axis = Long_val(vAxis);
  int rep = Long_val(vRep);
  int highest_dim = X->num_dims - 1;
  int numel_x = c_ndarray_numel(X);

  /* Special case : repeat along the first dimension */

  if (axis == 0) {
    int ofsy = 0;
    for (int i = 0; i < rep; ++i) {
      COPYFUN(numel_x, x, 0, 1, y, ofsy, 1);
      ofsy += numel_x;
    }
    return Val_unit;
  }

  int slice_sz = c_ndarray_slice_dim(X, axis);
  int block_num = numel_x / slice_sz;

  int ofsx = 0;
  int ofsy = 0;
  for (int i = 0; i < block_num; ++i) {
    for (int j = 0; j < rep; ++j) {
      COPYFUN(slice_sz, x, ofsx, 1, y, ofsy, 1);
      ofsy += slice_sz;
    }
    ofsx += slice_sz;
  }

  return Val_unit;
}


#endif /* OWL_ENABLE_TEMPLATE */
