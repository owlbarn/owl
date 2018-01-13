/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <caml/alloc.h>
#include <caml/memory.h>

#include "owl_macros.h"
#include "owl_stats.h"


CAMLprim value owl_stats_stub_shuffle(value vX) {
  if(Tag_val(vX) == Double_array_tag)
    owl_stats_shuffle((double *) vX, Double_array_length(vX), sizeof(double));
  else
    owl_stats_shuffle((value *) vX, Array_length(vX), sizeof(value));
  return Val_unit;
}
