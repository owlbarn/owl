/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


CAMLprim value FUN_NATIVE (spatial_backward) (
  value vInput_ptr, value vOutput_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vOutput_cols, value vOutput_rows,
  value vCol_scale, value vRow_scale
) {
  struct caml_ba_array *IN = Caml_ba_array_val(vInput_ptr);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput_ptr);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches     = Long_val(vBatches);
  int input_cols  = Long_val(vInput_cols);
  int input_rows  = Long_val(vInput_rows);
  int in_channel  = Long_val(vIn_channel);
  int output_cols = Long_val(vOutput_cols);
  int output_rows = Long_val(vOutput_rows);
  int row_scale   = Long_val(vRow_scale);
  int col_scale   = Long_val(vCol_scale);

  const int input_cri  = in_channel * input_rows  * input_cols;
  const int input_ri   = in_channel * input_rows;
  const int output_cri = in_channel * output_rows * output_cols;
  const int output_ri  = in_channel * output_rows;

  memset(input_ptr, 0, batches * input_cri * sizeof(TYPE));

  INIT;

  for (int b = 0; b < batches; b++) {
    for (int c = 0; c < output_cols; c++) {
      int in_c = c / col_scale;
      in_c = in_c < (input_cols - 1) ? in_c : input_cols - 1;
      for (int r = 0; r < output_rows; r++) {
        int in_r = r / row_scale;
        in_r = in_r < (input_rows - 1) ? in_r : input_rows - 1;
        for (int i = 0; i < in_channel; i++) {
          int input_idx = b * input_cri + in_c * input_ri +
            in_r * in_channel + i;
          int output_idx = b * output_cri + c * output_ri +
            r * in_channel + i;
          *(input_ptr + input_idx) += *(output_ptr + output_idx);
        }
      }
    }
  }

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_backward) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9]
  );
}


#endif /* OWL_ENABLE_TEMPLATE */
