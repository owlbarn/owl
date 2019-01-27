(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_converter_types

val make_tensordef : string -> int array -> tensordef

val make_argdef : string -> string -> argdef

val make_opattr : string -> string -> opattr

val attrvalue_to_string : attrvalue -> string
