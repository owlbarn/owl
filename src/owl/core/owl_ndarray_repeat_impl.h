/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


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

  return Val_unit;
}


CAMLprim value FUNCTION (stub, repeat2_native) (
  value vX, value vY,
  value vReps, value vShape_x,
  value vStride_x, value vBlock,
  value vBlock_idx
) {

  typedef struct _RDATA {
    int h;
    int d;
    int b;
    int ofsx;
    int tag;
  } RDATA;

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *x = (TYPE *) X->data;
  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *y = (TYPE *) Y->data;

  int highest_dim = Wosize_val(vShape_x) - 1;
  /*
  printf("highest_dim: %d\n", highest_dim);

  printf("Reps:");
  for (int i = 0; i < Wosize_val(vReps); ++i) {
    printf("%d", Int_val(Field(vReps, i)));
  }
  printf("\n"); */

  int h = 0;
  int d = 0;
  int b = 0;
  int ofsx = 0;
  int tag = 1;

  int top = -1;

  int N = 1;
  for (int i = 0; i < Wosize_val(vShape_x); ++i) {
    N += Int_val(Field(vShape_x, i));
  }

  RDATA stack[N];

  while (((d != highest_dim + 1) && tag) || (top != -1)) {

    while ((d != highest_dim + 1) && tag) {
      for (int i = Int_val(Field(vShape_x, d)) - 1; i >= 0; i--) {
        int flag = 1;
        if (i == 0) { flag = 0; }
        RDATA r;
        r.h = h + i * Int_val(Field(vBlock_idx, d));
        r.d = d + 1;
        r.b = i;
        r.ofsx = ofsx + i * Int_val(Field(vStride_x, d));
        r.tag = flag;
        //printf("Pushed: %d, %d, %d, %d, %d\n", r.h, r.d, r.b, r.ofsx, r.tag);
        stack[++top] = r;
      }
      d++;
    }

    if (top != -1) {
      RDATA r = stack[top--];
      h = r.h; d = r.d; b = r.b; ofsx = r.ofsx; tag = r.tag;
      //printf("Popped: %d, %d, %d, %d, %d\n", r.h, r.d, r.b, r.ofsx, r.tag);
      if ((tag == 1) && d != highest_dim + 1) {
        r.tag = 0;
        stack[++top] = r;
        //printf("Pushed again: %d, %d, %d, %d, %d\n", r.h, r.d, r.b, r.ofsx, r.tag);
      } else {
        COPYFUN(Int_val(Field(vBlock, highest_dim)), x, ofsx, 0, y, h, 1);
        //printf("small copy: %d: %d -- %d\n", Int_val(Field(vBlock, highest_dim)), ofsx, h);
        for (int j = 1; j < Int_val(Field(vReps, d - 1)); j++) {
          int ofsy = h + j * Int_val(Field(vBlock, d - 1));
          COPYFUN(Int_val(Field(vBlock, d - 1)), y, h, 1, y, ofsy, 1);
          //printf("large copy: %d: %d -- %d\n", Int_val(Field(vBlock, d - 1)), ofsx, ofsy);
        }
      }
    }
  }
}

#endif /* OWL_ENABLE_TEMPLATE */


CAMLprim value FUNCTION (stub, repeat2_byte) (value * argv, int argn) {
  return FUNCTION (stub, repeat2_native) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]
  );

  return Val_unit;
}
