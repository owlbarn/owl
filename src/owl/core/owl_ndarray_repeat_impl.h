/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


CAMLprim value FUNCTION (stub, repeat_native) (
  value vX, value vY, value vHighest_dim,
  value vReps, value vShape_x, value vShape_y
) {

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *x = (TYPE *) X->data;
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *y = (TYPE *) Y->data;
  int highest_dim = Long_val(vHighest_dim);

  /* Special Case : Vector */
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

  /* Required stride & slice arrays */

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

  int r, flag_one;
  int HD = highest_dim + 1; //highest non-one-repeat dimension
  int block_idx[highest_dim + 2]; //block size in counting indices
  block_idx[highest_dim + 1] = 1;
  for (int i = highest_dim; i >= 0; --i) {
    r = reps[i];
    block_idx[i] = r * block_idx[i + 1];
    flag_one = (r != 1) ? 0 : 1;
    if (flag_one && r == 1) { HD--; }
  }
  for (int i = 0; i <= highest_dim; ++i) {
    block_idx[i] *= stride_x[i];
  }
  HD = (HD > highest_dim) ? highest_dim : HD;

  /* Initialize Stack */
  typedef struct _BLOCK {
    int h;
    int d;
    int ofsx;
    int tag;
  } BLOCK;

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

  /* Begin recursive-to-iterative prosedure */
  while (((d != HD) && tag) || (top != -1)) {
    // If the current job has not reached the highest dim and not yet explored,
    // push its children to the stack.
    while ((d != HD) && tag) {
      int shaped = shape_x[d];
      int idxd   = block_idx[d];
      int strid  = stride_x[d];

      int h_new = h    + (shaped - 1) * idxd;
      int o_new = ofsx + (shaped - 1) * strid;
      for (int i = shaped - 1; i >= 0; i--) {
        int flag = 1;
        if (i == 0) { flag = 0; }
        BLOCK r = {h_new, d + 1, o_new, flag};
        stack[++top] = r;
        h_new -= idxd;
        o_new -= strid;
      }
      d++;
    }

    // If the stack is not empty
    if (top != -1) {

      BLOCK r = stack[top--];
      h = r.h; d = r.d; ofsx = r.ofsx; tag = r.tag;
      // If a node still contains unexplored children, push it back
      if ((tag == 1) && (d < HD)) {
        r.tag = 0;
        stack[++top] = r;
      }
      else {
        int block_sz, repsd, ofsy;
        // first, copy content from x to y for the highest dimension
        if (d == HD) {
          repsd = reps[d];
          // different copy strategies
          if (repsd == 1) {
            COPYFUN(slice_y[d], x, ofsx, 1, y, h, 1);
          }
          else {
            block_sz = shape_x[d];
            ofsy = h;
            for (int j = 0; j < block_sz; ++j) {
              COPYFUN(repsd, x, ofsx+j, 0, y, ofsy, 1);
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
          ofsy += block_sz;
        }
      }
    }
  }
  return Val_unit;
}

CAMLprim value FUNCTION (stub, repeat_byte) (value * argv, int argn) {
  return FUNCTION (stub, repeat_native) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]
  );
}


#endif /* OWL_ENABLE_TEMPLATE */
