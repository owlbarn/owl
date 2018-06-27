/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE

#include <time.h>
#include <assert.h>


CAMLprim value FUNCTION (stub, repeat_native) (
  value vX, value vY,
  value vReps, value vBlock,
  value vBlock_idx, value vSub_block_idx,
  value vStride_sub, value vSlice_sub,
  value vHighest_dim, value vBlock_num, value vSlice_sz
) {

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *x = (TYPE *) X->data;
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *y = (TYPE *) Y->data;

  int highest_dim = Long_val(vHighest_dim);
  int block_num   = Long_val(vBlock_num);
  int slice_sz    = Long_val(vSlice_sz);

  int rep_highest = Int_val(Field(vReps, highest_dim));

  int ofsx = 0;
  for (int i = 0; i < block_num; ++i) {
    int block_idx = Int_val(Field(vSub_block_idx, i));
    for (int j = 0; j < rep_highest; ++j) {
      int ofsy = block_idx + j;
      COPYFUN(slice_sz, x, ofsx, 1, y, ofsy, rep_highest);
    }
    ofsx += slice_sz;
  }

  for (int d = highest_dim - 1; d >= 0; d--) {
    int stepd = Int_val(Field(vStride_sub, d));
    int block_sz = Int_val(Field(vBlock, d));
    int repd = Int_val(Field(vReps, d));
    int sliced = Int_val(Field(vSlice_sub, d));

    int step = 0;
    for (int s = 0; s < sliced; s++) {
      int ofsx = Int_val(Field(vSub_block_idx, step));
      int ofsy = ofsx + block_sz;
      for (int j = 1; j < repd; j++) {
        COPYFUN(block_sz, y, ofsx, 1, y, ofsy, 1);
        ofsy += block_sz;
      }
      step += stepd;
    }
  }

  return Val_unit;
}


CAMLprim value FUNCTION (stub, repeat_byte) (value * argv, int argn) {
  return FUNCTION (stub, repeat_native) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10]
  );
}


CAMLprim value FUNCTION (stub, repeat2_native) (
  value vX, value vY,
  value vReps, value vShape_x,
  value vStride_x, value vBlock,
  value vBlock_idx
) {

  clock_t begin = clock();
  typedef struct _RDATA {
    int h;
    int d;
    int ofsx;
    int tag;
  } RDATA;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *x = (TYPE *) X->data;
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *y = (TYPE *) Y->data;

  int highest_dim = Wosize_val(vShape_x) - 1;

  int h = 0;
  int d = 0;
  int ofsx = 0;
  int tag = 1;

  int N = 1;
  for (int i = 0; i < Wosize_val(vShape_x) - 1; ++i) {
    N += Int_val(Field(vShape_x, i));
  }
  RDATA stack[N];
  int top = -1;

  while (((d != highest_dim) && tag) || (top != -1)) {

    while ((d != highest_dim) && tag) {
      int shaped = Int_val(Field(vShape_x,   d));
      int idxd   = Int_val(Field(vBlock_idx, d));
      int strid  = Int_val(Field(vStride_x,  d));

      int h_new = h + (shaped - 1) * idxd;
      int o_new = ofsx + (shaped - 1) * strid;
      for (int i = shaped - 1; i >= 0; i--) {
        int flag = 1;
        if (i == 0) { flag = 0; }
        RDATA r = {h_new, d + 1, o_new, flag};
        //printf("Pushed: (%d, %d, %d, %d)\n", h_new, d + 1, o_new, flag);
        stack[++top] = r;
        h_new -= idxd;
        o_new -= strid;
      }
      d++;
    }

    if (top != -1) {
      RDATA r = stack[top--];
      h = r.h; d = r.d; ofsx = r.ofsx; tag = r.tag;
      //printf("Popped: %d, %d, %d, %d\n", r.h, r.d, r.ofsx, r.tag);

      if ((r.tag == 1) && (d < highest_dim)) {
        r.tag = 0;
        stack[++top] = r;
        //printf("Re-Pushed: (%d, %d, %d, 0)\n", h, d, ofsx);
      }
      else {
        //printf("Used: %d, %d, %d, %d\n", h, d, ofsx, tag);
        int block_sz, repsd, ofsy;

        if (d == highest_dim) {
          block_sz = Int_val(Field(vShape_x, d));
          repsd    = Int_val(Field(vReps,    d));

          ofsy = h;
          for (int j = 0; j < block_sz; ++j) {
            COPYFUN(repsd, x, ofsx+j, 0, y, ofsy, 1);
            //printf("COPY Last-dim: %d -- %d, (%d)\n", ofsx+j, ofsy, repsd);
            ofsy += repsd;
          }
        }

        block_sz = Int_val(Field(vBlock, d - 1));
        repsd    = Int_val(Field(vReps,  d - 1));
        ofsy = h + block_sz;
        for (int j = 1; j < repsd; j++) {
          COPYFUN(block_sz, y, h, 1, y, ofsy, 1);
          //printf("Pure COPY: %d -- %d, (%d)\n", h, ofsy, block_sz);
          ofsy += block_sz;
        }
      }
    }
  }
  clock_t end = clock();
  double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
  fprintf(stderr, "Time in C%f\n", time_spent);

  return Val_unit;
}


CAMLprim value FUNCTION (stub, repeat2_byte) (value * argv, int argn) {
  return FUNCTION (stub, repeat2_native) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]
  );
}


CAMLprim value FUNCTION (stub, repeat3_native) (
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

  int stride_x[highest_dim + 1];
  stride_x[highest_dim] = 1;
  for (int i = highest_dim - 1; i >= 0; --i) {
    stride_x[i] = Int_val(Field(vShape_x, i + 1)) * stride_x[i + 1];
  }

  int slice_y[highest_dim + 1];
  slice_y[highest_dim] = Int_val(Field(vShape_y, highest_dim));
  for (int i = highest_dim - 1; i >= 0; --i) {
    slice_y[i] = Int_val(Field(vShape_y, i)) * slice_y[i + 1];
  }

  int r, flag_one;
  int HD = highest_dim + 1; //highest non-one-repeat dimension
  int block_idx[highest_dim + 2]; //block size in counting indices
  block_idx[highest_dim + 1] = 1;
  for (int i = highest_dim; i >= 0; --i) {
    r = Int_val(Field(vReps, i));
    block_idx[i] = r * block_idx[i + 1];
    if (r != 1) { flag_one = 0; }
    if (flag_one && r == 1) { HD--; }
  }
  for (int i = 0; i <= highest_dim; ++i) {
    block_idx[i] *= stride_x[i];
  }
  if (HD > highest_dim) { HD = highest_dim; }

  /* Initialize Stack */
  typedef struct _RDATA {
    int h;
    int d;
    int ofsx;
    int tag;
  } RDATA;

  int h = 0;
  int d = 0;
  int ofsx = 0;
  int tag = 1;

  int N = 1;
  for (int i = 0; i < HD; ++i) {
    N += Int_val(Field(vShape_x, i));
  }
  RDATA stack[N];
  int top = -1;

  /* Begin recursive-to-iterative prosedure */
  while (((d != HD) && tag) || (top != -1)) {
    // If the current job has not reached the highest dim and not yet explored,
    // push its children to the stack.
    while ((d != HD) && tag) {
      int shaped = Int_val(Field(vShape_x, d));
      int idxd   = block_idx[d];
      int strid  = stride_x[d];

      int h_new = h    + (shaped - 1) * idxd;
      int o_new = ofsx + (shaped - 1) * strid;
      for (int i = shaped - 1; i >= 0; i--) {
        int flag = 1;
        if (i == 0) { flag = 0; }
        RDATA r = {h_new, d + 1, o_new, flag};
        stack[++top] = r;
        h_new -= idxd;
        o_new -= strid;
      }
      d++;
    }

    // If the stack is not empty
    if (top != -1) {

      RDATA r = stack[top--];
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
          repsd = Int_val(Field(vReps, d));
          // different copy strategies
          if (repsd == 1) {
            COPYFUN(slice_y[d], x, ofsx, 1, y, h, 1);
          }
          else {
            block_sz = Int_val(Field(vShape_x, d));
            ofsy = h;
            for (int j = 0; j < block_sz; ++j) {
              COPYFUN(repsd, x, ofsx+j, 0, y, ofsy, 1);
              ofsy += repsd;
            }
          }
        }
        // then, block-copy content within y
        block_sz = slice_y[d];
        repsd = Int_val(Field(vReps,  d - 1));
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

CAMLprim value FUNCTION (stub, repeat3_byte) (value * argv, int argn) {
  return FUNCTION (stub, repeat3_native) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]
  );
}


#endif /* OWL_ENABLE_TEMPLATE */
