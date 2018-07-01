/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE

/*
CAMLprim value FUNCTION (stub, repeat_native) (
  value vX, value vY, value vHighest_dim,
  value vReps, value vShape_x
) {

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *x = (TYPE *) X->data;
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *y = (TYPE *) Y->data;
  int highest_dim = Long_val(vHighest_dim);

  /* Special case : vector input

  if (highest_dim == 0) {
    int xlen  = Int_val(Field(vShape_x, 0));
    int repsd = Int_val(Field(vReps,    0));
    int ofsy  = 0;
    for (int i = 0; i < xlen; ++i) {
      COPYFUN(repsd, x, i, 0, y, ofsy, 1);
      ofsy += repsd;
    }
    return Val_unit;
  }

  /* Necessary stride & slice arrays

  int reps[highest_dim + 1];
  int shape_x[highest_dim + 1];
  for (int i = 0; i <= highest_dim; ++i) {
    reps[i]    = Int_val(Field(vReps, i));
    shape_x[i] = Int_val(Field(vShape_x, i));
  }

  int stride_x[highest_dim + 1];
  stride_x[highest_dim] = 1;
  for (int i = highest_dim - 1; i >= 0; --i) {
    stride_x[i] = shape_x[i + 1] * stride_x[i + 1];
  }

  int slice_y[highest_dim + 1];
  slice_y[highest_dim] = shape_x[highest_dim] * reps[highest_dim];
  for (int i = highest_dim - 1; i >= 0; --i) {
    slice_y[i] = shape_x[i] * reps[i] * slice_y[i + 1];
  }

  int block_idx[highest_dim + 1]; // block size in counting indices
  block_idx[highest_dim] = reps[highest_dim];
  for (int i = highest_dim - 1; i >= 0; --i) {
    block_idx[i] = reps[i] * block_idx[i + 1];
  }
  for (int i = 0; i <= highest_dim; ++i) {
    block_idx[i] *= stride_x[i];
  }

  int HD = highest_dim + 1; // highest non-one-repeat dimension
  for (int i = highest_dim; i >= 0; --i) {
    if (reps[i] == 1) { HD--; } else { break; }
  }
  HD = (HD > highest_dim) ? highest_dim : HD;

  /* Initialise stack

  int h = 0;
  int d = 0;
  int ofsx = 0;
  int tag = 1;

  int N = 1;
  for (int i = 0; i < HD; ++i) {
    N += shape_x[i];
  }
  BLOCK stack[N];
  int top = -1;

  /* Begin recursive-to-iterative procedure

  while (((d != HD) && tag) || (top != -1)) {
    // If the current job has not reached the highest dim and not yet explored,
    // push its children to the stack.
    while ((d != HD) && tag) {
      int shaped = shape_x[d];
      int idxd   = block_idx[d];
      int strid  = stride_x[d];

      int h_new = h    + (shaped - 1) * idxd;
      int o_new = ofsx + (shaped - 1) * strid;
      for (int i = shaped - 1; i > 0; i--) {
        BLOCK r = {h_new, d + 1, o_new, 1};
        fprintf(stderr, "Pushed: (%d, %d, %d, 1)\n", h_new, d + 1, o_new);
        stack[++top] = r;
        h_new -= idxd;
        o_new -= strid;
      }
      BLOCK r = {h_new, d + 1, o_new, 0};
      fprintf(stderr, "Pushed: (%d, %d, %d, 0)\n", h_new, d + 1, o_new);
      stack[++top] = r;
      d++;
    }

    // If the stack is not empty
    if (top != -1) {
      BLOCK r = stack[top--];
      h = r.head; d = r.dim; ofsx = r.ofsx; tag = r.tag;
      fprintf(stderr, "Popped: %d, %d, %d, %d\n", r.head, r.dim, r.ofsx, r.tag);
      // If a node still contains unexplored children, push it back
      if (tag && (d < HD)) {
        r.tag = 0;
        stack[++top] = r;
        fprintf(stderr, "Re-Pushed: (%d, %d, %d, 0)\n", h, d, ofsx);
      }
      else {
        fprintf(stderr, "Used: %d, %d, %d, %d\n", h, d, ofsx, tag);
        int block_sz, repsd, ofsy;
        // first, copy content from x to y for the highest dimension
        if (d == HD) {
          repsd = reps[d];
          // different copy strategies
          if (repsd == 1) {
            COPYFUN(slice_y[d], x, ofsx, 1, y, h, 1);
            fprintf(stderr, "COPY Last-dim1: %d -- %d, (%d)\n", ofsx, h, slice_y[d]);
          }
          else {
            block_sz = shape_x[d];
            ofsy = h;
            for (int j = 0; j < block_sz; ++j) {
              COPYFUN(repsd, x, ofsx + j, 0, y, ofsy, 1);
              fprintf(stderr, "COPY Last-dim2: %d -- %d, (%d)\n", ofsx+j, ofsy, repsd);
              ofsy += repsd;
            }
          }
        }
        // then, block-copy content within y
        block_sz = slice_y[d];
        repsd = reps[d - 1];
        ofsy = h + block_sz;
        for (int j = 1; j < repsd; j++) {
          COPYFUN(block_sz, y, h, 1, y, ofsy, 1);
          fprintf(stderr, "Pure COPY: %d -- %d, (%d)\n", h, ofsy, block_sz);
          ofsy += block_sz;
        }
      }
    }
  }
  return Val_unit;
}
*/


CAMLprim value FUNCTION (stub, repeat_native) (
  value vX, value vY, value vHighest_dim,
  value vReps, value vShape_x
) {

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *x = (TYPE *) X->data;
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *y = (TYPE *) Y->data;
  int highest_dim = X->num_dims - 1;

  /* Special case : vector input */

  if (highest_dim == 0) {
    int xlen  = Int_val(Field(vShape_x, 0));
    int repsd = Int_val(Field(vReps,    0));
    int ofsy  = 0;
    for (int i = 0; i < xlen; ++i) {
      COPYFUN(repsd, x, i, 0, y, ofsy, 1);
      ofsy += repsd;
    }
    return Val_unit;
  }

  /* Necessary stride & slice arrays */

  int reps[highest_dim + 1];
  int shape_x[highest_dim + 1];
  for (int i = 0; i <= highest_dim; ++i) {
    reps[i]    = Int_val(Field(vReps, i));
    shape_x[i] = Int_val(Field(vShape_x, i));
  }

  int stride_x[highest_dim + 1];
  c_ndarray_stride(X, stride_x);

  for (int i = 0; i <= highest_dim; i++) {
    fprintf(stderr, "%d ", stride_x[i]);
  }
  fprintf(stderr, " End of stride_x\n");

  int stride_y[highest_dim + 1];
  c_ndarray_stride(Y, stride_y);
  for (int i = 0; i <= highest_dim; i++) {
    fprintf(stderr, "%d ", stride_y[i]);
  }
  fprintf(stderr, " End of stride_y\n");


  int slice_y[highest_dim + 1];
  c_ndarray_slice(Y, slice_y);

  int slice_x[highest_dim + 1];
  c_ndarray_slice(X, slice_x);

  slice_y[highest_dim] = shape_x[highest_dim] * reps[highest_dim];
  for (int i = highest_dim - 1; i >= 0; --i) {
    slice_y[i] = shape_x[i] * reps[i] * slice_y[i + 1];
  }

  int block_idx[highest_dim + 1]; // block size in counting indices
  block_idx[highest_dim] = reps[highest_dim];
  for (int i = highest_dim - 1; i >= 0; --i) {
    block_idx[i] = reps[i] * block_idx[i + 1];
  }
  for (int i = 0; i <= highest_dim; ++i) {
    block_idx[i] *= stride_x[i];
    fprintf(stderr, "%d ", block_idx[i]);
  }
  fprintf(stderr, "\n");

  int HD = highest_dim + 1; // highest non-one-repeat dimension
  for (int i = highest_dim; i >= 0; --i) {
    if (reps[i] == 1) { HD--; } else { break; }
  }
  HD = (HD > highest_dim) ? highest_dim : HD;
  fprintf(stderr, "HD: %d\n", HD);

  /*  Copy the HD dimension from x to y */

  int num_hd = slice_x[0] / slice_x[HD];
  int ofsx = 0;
  int ofsy = 0;
  int block_sz = reps[HD];

  int counter[HD];
  for (int i = 0; i < HD; i++) {
    counter[i] = slice_x[i] / slice_x[HD];
    fprintf(stderr, "%d ", counter[i]);
  }
  fprintf(stderr, "End of counter\n");

  for (int i = 0; i < num_hd; ++i) {
    fprintf(stderr, "ofsx, ofsy: %d, %d\n", ofsx, ofsy);
    // Copy the last block
    int ofsy_sub = ofsy;
    for (int j = 0; j < shape_x[HD]; ++j) {
      COPYFUN(block_sz, x, ofsx + j, 0, y, ofsy_sub, 1);
      fprintf(stderr, "COPY Last-dim2: %d -- %d, (%d)\n", ofsx+j, ofsy_sub, block_sz);
      ofsy_sub += block_sz;
    }
    // Increase index
    ofsx += shape_x[HD];
    ofsy += stride_y[HD - 1] * reps[HD - 1];
    for (int j = HD - 1; j > 0; --j) {
      if ((i + 1) % counter[j] == 0) {
        fprintf(stderr, "Add to ofsy: %d * %d\n", stride_y[j - 1], (reps[j - 1] - 1));
        ofsy += stride_y[j - 1] * (reps[j - 1] - 1);
      }
    }
  }

  for (int d = HD - 1; d >= 0; --d) {

    int num_d = slice_x[0] / slice_x[d + 1];
    int ofsy = 0;
    int block_sz = stride_y[d];
    int ofsy_sub = 0;

    fprintf(stderr, "Dim: %d\n", d);
    for (int i = 0; i <= d; i++) {
      counter[i] = slice_x[i] / slice_x[d + 1];
      fprintf(stderr, "%d ", counter[i]);
    }
    fprintf(stderr, "End of inner counter\n");

    for (int i = 0; i < num_d; ++i) {
      ofsy_sub = ofsy + block_sz;
      for (int j = 1; j < reps[d]; j++) {
        COPYFUN(block_sz, y, ofsy, 1, y, ofsy_sub, 1);
        fprintf(stderr, "Pure COPY: %d -- %d, (%d)\n", ofsy, ofsy_sub, block_sz);
        ofsy_sub += block_sz;
      }

      ofsy += stride_y[d] * reps[d];

      for (int j = d; j > 0; --j) {
        if ((i + 1) % counter[j] == 0) {
          fprintf(stderr, "Add to ofsy: %d * %d\n", stride_y[j - 1], (reps[j - 1] - 1));
          ofsy += stride_y[j - 1] * (reps[j - 1] - 1);
        }
      }
    }

  }

  return Val_unit;
}


#endif /* OWL_ENABLE_TEMPLATE */
