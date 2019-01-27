(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_converter_types

val get_node_attr : string -> (string * attrvalue) array option

val get_op_attr : string -> (argdef array * argdef array * opattr array) option
