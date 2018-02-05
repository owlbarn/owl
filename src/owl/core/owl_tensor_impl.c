#ifdef OWL_ENABLE_TEMPLATE

//CAMLprim
value FUN_2DF_NATIVE (
  value vInput_ptr, value vOutput_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows,
  value vRow_stride,  value vCol_stride,
  value vPadding, value vRow_in_stride, value vCol_in_stride
)
{
  /*
  CAMLparam2(vInput_ptr, vOutput_ptr);
  CAMLxparam4(vBatches, vInput_cols, vInput_rows, vIn_channel);
  CAMLxparam2(vKernel_cols, vKernel_rows);
  CAMLxparam2(vOutput_cols, vCol_stride);
  CAMLxparam3(vPadding, vRow_in_stride, vCol_in_stride);
  */

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

          TYPE acc = INITACC;
          int a, b;
          int c = 0;
          for (a = cstart; a < cend; ++a) {
            for (b = rstart; b < rend; ++b) {
              if (a >= 0 && a < input_cols &&
                  b >= 0 && b < input_rows) {
                int input_idx =
                  i * (input_cols * input_rows * in_channel) +
                  a * (input_rows * in_channel) +
                  b * in_channel +
                  l;
                TYPE t = *(input_ptr + input_idx);
                ACCFN(acc, t);
                c++;
              }
            }
          }

          int output_idx =
            i * (output_cols * output_rows * in_channel) +
            j * (output_rows * in_channel) +
            k * in_channel +
            l;

          *(output_ptr + output_idx) = UPDATEFN(acc, c);
        }
      }
    }
  }


  return Val_unit;
}

//CAMLprim
value FUN_2DF_BYTE(value * argv, int argn){
  return FUN_2DF_NATIVE(
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14]
  );
}


value FUN_2DB_NATIVE(
  value vInput, value vOutput_back, value vInput_back,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows,
  value vRow_stride,  value vCol_stride,
  value vPad_rows, value vPad_cols
){

  struct caml_ba_array *IN  = Caml_ba_array_val(vInput);
  struct caml_ba_array *OUB = Caml_ba_array_val(vOutput_back);
  struct caml_ba_array *INB = Caml_ba_array_val(vInput_back);
  TYPE *input_ptr = (TYPE *) IN->data;
  TYPE *output_backward_ptr = (TYPE *) OUB->data;
  TYPE *input_backward_ptr  = (TYPE *) INB->data;

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
  int pad_rows      = Long_val(vPad_rows);
  int pad_cols      = Long_val(vPad_cols);

  if (pad_cols < 0) pad_cols = 0;
  if (pad_rows < 0) pad_rows = 0;

  memset(input_backward_ptr, 0,
    batches * input_cols * input_rows * in_channel * sizeof(TYPE));

  const int ksize = kernel_cols * kernel_rows;

  int i, j, k, l;
  for (i = 0; i < batches; ++i) {
    for (j = 0; j < output_cols; ++j) {
      for (k = 0; k < output_rows; ++k) {

        //const int cstart = j * col_stride - floor(pc);
        //const int rstart = k * row_stride - floor(pr);
        const int cstart = j * col_stride - pad_cols;
        const int rstart = k * row_stride - pad_rows;
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (l = 0; l < in_channel; ++l) {
          TYPE m;
          int output_idx =
            i * (output_cols * output_rows * in_channel) +
            j * (output_rows * in_channel) +
            k * in_channel +
            l;
          m = *(output_backward_ptr + output_idx);

          TYPE acc = -INFINITY;
          int max_idx = 0;

          int c = 0;
          int idx[ksize];
          memset(idx, 0, ksize * sizeof(int)); // !not for complex

          for (int a = cstart; a < cend; ++a) {
            for (int b = rstart; b < rend; ++b) {
              if (a >= 0 && a < input_cols &&
                  b >= 0 && b < input_rows) {

                // Note the extra computation for avg
                int input_idx =
                  i * (input_cols * input_rows * in_channel) +
                  a * (input_rows * in_channel) +
                  b * in_channel +
                  l;
                idx[c] = input_idx;
                c++;

                #ifdef OWL_TENSOR_MAX
                TYPE t = *(input_ptr + input_idx);
                if (acc < t){
                  acc = t;
                  max_idx = input_idx;
                }
                #endif
              }
            }
          }

          #ifdef OWL_TENSOR_AVG
          for (int i = 0; i < c; i++) {
            *(input_backward_ptr + idx[i]) += UPDATEFN(m, c);
          }
          #else
          *(input_backward_ptr + max_idx) += UPDATEFN(m, c);
          #endif
        }
      }
    }
  }
}

value FUN_2DB_BYTE(value * argv, int argn){
  return FUN_2DB_NATIVE(
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14]
  );
}


#endif /* OWL_ENABLE_TEMPLATE */
