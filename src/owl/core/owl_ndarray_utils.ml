(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_ndarray_reshape : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "stub_ndarray_reshape"


let owl_ndarray_reshape x shape =
  let d = Array.length shape in
  let y = Array1.create Int64 c_layout d in
  Array.iteri (fun i v ->
    Array1.unsafe_set y i (Int64.of_int v)
  ) shape;
  let z = genarray_of_array1 y in
  owl_ndarray_reshape x z
