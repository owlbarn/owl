#ifdef OWL_ENABLE_TEMPLATE

CAMLprim
value stub_tensor_spatial_max_pooling_native(
  value vInput_ptr, value vOutput_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows,
  value vRow_stride,  value vCol_stride,
  value vPadding, value vRow_in_stride, value vCol_in_stride
)
{

  CAMLparam2(vInput_ptr, vOutput_ptr);
  CAMLxparam4(vBatches, vInput_cols, vInput_rows, vIn_channel);
  CAMLxparam2(vKernel_cols, vKernel_rows);
  CAMLxparam2(vOutput_cols, vCol_stride);
  CAMLxparam3(vPadding, vRow_in_stride, vCol_in_stride);


  struct caml_ba_array *IN = Caml_ba_array_val(vInput_ptr);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput_ptr);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches       = Long_val(vBatches);
  int input_cols    = Long_val(vInput_cols);
  int input_rows    = Long_val(vInput_rows);
  int in_channel    = Long_val(vIn_channel);
  int kernel_cols   = Long_val(vKernel_cols);
  int kernel_rows   = Long_val(vKernel_rows);
  int output_cols   = Long_val(vOutput_cols);
  int output_rows   = Long_val(vOutput_rows);
  int row_stride    = Long_val(vRow_stride);
  int col_stride    = Long_val(vCol_stride);
  int padding       = Long_val(vPadding);
  int row_in_stride = Long_val(vRow_in_stride);
  int col_in_stride = Long_val(vCol_in_stride);


  TYPE pr, pc;
  if (padding == 1){
    pr = 0.; pc = 0.;
  } else {
    pr = (row_stride * ( output_rows - 1) +
      kernel_rows - input_rows) / 2.;
    pc = (col_stride * ( output_cols - 1) +
      kernel_cols - input_cols) / 2.;
    if (pr < 0) pr = 0.;
    if (pc < 0) pc = 0.;
  }

  int i, j, k, l;
  for (i = 0; i < batches; ++i) {
    for (j = 0; j < output_cols; ++j) {
      for (k = 0; k < output_rows; ++k) {

        const int cstart = j * col_stride - floor(pc);
        const int rstart = k * row_stride - floor(pr);
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (l = 0; l < in_channel; ++l) {
          TYPE max = -INFINITY;
          int a, b;
          for (a = cstart; a < cend; ++a) {
            for (b = rstart; b < rend; ++b) {
              if (a >= 0 && a < input_cols &&
                  b >= 0 && b < input_rows) {
                int input_idx =
                  i * (input_cols * input_rows * in_channel) +
                  a * (input_rows * in_channel) +
                  b * in_channel +
                  l;
                if (max < *(input_ptr + input_idx)){
                  max = *(input_ptr + input_idx);
                }
              }
            }
          }

          int output_idx =
            i * (output_cols * output_rows * in_channel) +
            j * (output_rows * in_channel) +
            k * in_channel +
            l;
          *(output_ptr + output_idx) = max;
        }
      }
    }
  }


  return Val_unit;
}


CAMLprim
value stub_tensor_spatial_max_pooling_bytecode(value * argv, int argn){
  return stub_tensor_spatial_max_pooling_native(
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14]
  );
}

/*
//CAMLprim
value c_tensor_op(value vX, value vY) {
  //CAMLparam2(vX, vY);
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  float *X_data = (float *) X->data;
  int y = Long_val(vY);
  return Val_unit;
}

value bar(value vX, value vY) {
  //CAMLparam2(vX, vY);
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  float *X_data = (float *) X->data;
  int y = Long_val(vY);
  return Val_unit;
}

value bar1(value vInput_ptr, value vBatches) {
  //CAMLparam2(vX, vY);
  struct caml_ba_array *X = Caml_ba_array_val(vInput_ptr);
  float *X_data = (float *) X->data;
  int y = Long_val(vBatches);
  return Val_unit;
}

value bar2(value vInput_ptr, value vBatches, value vInput_cols) {
  //CAMLparam2(vX, vY);
  struct caml_ba_array *X = Caml_ba_array_val(vInput_ptr);
  float *X_data = (float *) X->data;
  int y = Long_val(vBatches);
  return Val_unit;
}

value bar3(value vInput_ptr, value vBatches, value vInput_cols) {
  //CAMLparam2(vX, vY);
  struct caml_ba_array *I = Caml_ba_array_val(vInput_ptr);
  float *X_data = (float *) I->data;
  int y = Long_val(vBatches);
  return Val_unit;
}
*/

/*
value foo(
  value vInput_ptr, value vBatches, value vInput_cols
){

  struct caml_ba_array *I = Caml_ba_array_val(vInput_ptr);
  float *input_ptr  = (float *) I->data;
  int batches      = Long_val(vBatches);
  return Val_unit;
}
*/

#endif /* OWL_ENABLE_TEMPLATE */
