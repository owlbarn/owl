(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_core_types


external owl_ndarray_same_data : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "stub_ndarray_same_data"

let _owl_ndarray_same_data x y = owl_ndarray_same_data x y = 1
