(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray

type ('a, 'b) owl_arr = ('a, 'b, c_layout) Genarray.t
