/* bytearray_stubs.c : C routines for bytearray.ml */
/* Copyright Jérôme Vouillon 1999-2010 (see LICENCE for distribution conditions) */

#include <string.h>
#include <unistd.h>

#include "caml/intext.h"
#include "caml/bigarray.h"

#define Array_data(a, i) (((char *) a->data) + Long_val(i))
#define Floatarray_data(a, i) (((char *) a->data) + 8 * Long_val(i))

CAMLprim value numcores(value unit) {
  int numcores = sysconf( _SC_NPROCESSORS_ONLN );
  return Val_int(numcores);
}

CAMLprim value ml_marshal_to_bigarray(value v, value flags)
{
  char *buf;
  long len;
  output_value_to_malloc(v, flags, &buf, &len);
  return alloc_bigarray(BIGARRAY_UINT8 | BIGARRAY_C_LAYOUT | BIGARRAY_MANAGED,
                        1, buf, &len);
}

CAMLprim value ml_marshal_to_bigarray_buffer(value b, value ofs,
                                             value v, value flags)
{
  struct caml_bigarray *b_arr = Bigarray_val(b);
  return Val_long(caml_output_value_to_block(v, flags, Array_data (b_arr, ofs),
					     b_arr->dim[0] - Long_val(ofs)));
}


CAMLprim value ml_unmarshal_from_bigarray(value b, value ofs)
{
  struct caml_bigarray *b_arr = Bigarray_val(b);
  return input_value_from_block (Array_data (b_arr, ofs),
                                 b_arr->dim[0] - Long_val(ofs));
}

CAMLprim value ml_blit_string_to_bigarray
(value s, value i, value a, value j, value l)
{
  char *src = String_val(s) + Int_val(i);
  char *dest = Array_data(Bigarray_val(a), j);
  memcpy(dest, src, Long_val(l));
  return Val_unit;
}

CAMLprim value ml_blit_bigarray_to_string
(value a, value i, value s, value j, value l)
{
  char *src = Array_data(Bigarray_val(a), i);
  char *dest = String_val(s) + Long_val(j);
  memcpy(dest, src, Long_val(l));
  return Val_unit;
}

CAMLprim value ml_blit_floatarray_to_bigarray
(value fa, value i, value a, value j, value l)
{
  int w = 8;
  char *src = Bp_val(fa) + Long_val(i)*w;
  char *dest = Floatarray_data(Bigarray_val(a), j);
  memcpy(dest, src, Long_val(l)*w);
  return Val_unit;
}

CAMLprim value ml_blit_bigarray_to_floatarray
(value a, value i, value fa, value j, value l)
{
  int w = 8;
  char *src = Floatarray_data(Bigarray_val(a), i);
  char *dest = Bp_val(fa) + Long_val(j)*w;
  memcpy(dest, src, Long_val(l)*w);
  return Val_unit;
}
