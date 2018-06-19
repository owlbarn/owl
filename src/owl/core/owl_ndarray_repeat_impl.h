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

  for (int i = 0; i < block_num; ++i) {
    int ofsx = i * slice_sz;
    int block_idx = Int_val(Field(vSub_block_idx, i));
    for (int j = 0; j < rep_highest; ++j) {
      int ofsy = block_idx + j;
      COPYFUN(slice_sz, x, ofsx, 1, y, ofsy, rep_highest);
    }
  }

  for (int d = highest_dim - 1; d >= 0; d--) {
    int step = Int_val(Field(vStride_sub, d));
    int block_sz = Int_val(Field(vBlock, d));
    int repd = Int_val(Field(vReps, d));
    int sliced = Int_val(Field(vSlice_sub, d));

    for (int s = 0; s < sliced; s++) {
      int ofsx = Int_val(Field(vSub_block_idx, s * step));
      for (int j = 1; j < repd; j++) {
        int ofsy = ofsx + j * block_sz;
        COPYFUN(block_sz, y, ofsx, 1, y, ofsy, 1);
      }
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


#endif /* OWL_ENABLE_TEMPLATE */
