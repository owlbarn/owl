/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <caml/alloc.h>
#include <caml/memory.h>

#include "owl_macros.h"
#include "owl_stats.h"


// Internal state of SFMT PRNG
sfmt_t sfmt_state;


/***** owl_stats_extend_shuffle.c ******/


CAMLprim value owl_stats_stub_shuffle(value vX) {
  if(Tag_val(vX) == Double_array_tag)
    owl_stats_shuffle((double *) vX, Double_array_length(vX), sizeof(double));
  else
    owl_stats_shuffle((value *) vX, Array_length(vX), sizeof(value));

  return Val_unit;
}


CAMLprim value owl_stats_stub_choose(value src, value dst) {
  if(Tag_val(src) == Double_array_tag)
    owl_stats_choose(
       Double_array_val(dst), Double_array_length(dst),
       Double_array_val(src), Double_array_length(src),
       sizeof(double));
  else
    owl_stats_choose(
       (value*) dst, Array_length(dst),
       (value*) src, Array_length(src),
       sizeof(value));

  return Val_unit;
}


CAMLprim value owl_stats_stub_sample(value src, value dst) {
  if(Tag_val(src) == Double_array_tag)
    owl_stats_sample(
       Double_array_val(dst), Double_array_length(dst),
       Double_array_val(src), Double_array_length(src),
       sizeof(double));
  else
    owl_stats_sample(
       (value*) dst, Array_length(dst),
       (value*) src, Array_length(src),
       sizeof(value));

  return Val_unit;
}


/***** owl_stats_extend_misc.c ******/


CAMLprim value owl_stats_stub_sum(value vX) {
  double y = owl_stats_sum((double *) vX, Double_array_length(vX));
  return caml_copy_double(y);
}


CAMLprim value owl_stats_stub_mean(value vX) {
  double y = owl_stats_mean((double *) vX, Double_array_length(vX));
  return caml_copy_double(y);
}


CAMLprim value owl_stats_stub_var(value vX, value vA) {
  double y = owl_stats_var((double *) vX, Double_val(vA), Double_array_length(vX));
  return caml_copy_double(y);
}


CAMLprim value owl_stats_stub_std(value vX, value vA) {
  double y = owl_stats_std((double *) vX, Double_val(vA), Double_array_length(vX));
  return caml_copy_double(y);
}


CAMLprim value owl_stats_stub_absdev(value vX, value vA) {
  double y = owl_stats_absdev((double *) vX, Double_val(vA), Double_array_length(vX));
  return caml_copy_double(y);
}


CAMLprim value owl_stats_stub_skew(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = owl_stats_skew((double *) vX, a, b, Double_array_length(vX));
  return caml_copy_double(y);
}


CAMLprim value owl_stats_stub_kurtosis(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = owl_stats_kurtosis((double *) vX, a, b, Double_array_length(vX));
  return caml_copy_double(y);
}


CAMLprim value owl_stats_stub_cov(value vX, value vY, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double z = owl_stats_cov((double *) vX, (double *) vY, a, b, Double_array_length(vX));
  return caml_copy_double(z);
}


CAMLprim value owl_stats_stub_corrcoef(value vX, value vY) {
  double z = owl_stats_corrcoef((double *) vX, (double *) vY, Double_array_length(vX));
  return caml_copy_double(z);
}


CAMLprim value owl_stats_stub_quantile(value vX, value vA) {
  double y = owl_stats_quantile((double *) vX, Double_val(vA), Double_array_length(vX));
  return caml_copy_double(y);
}
