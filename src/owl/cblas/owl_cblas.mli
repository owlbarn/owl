(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t


val gemm : ?transa:bool -> ?transb:bool -> ?alpha:'a -> ?beta:'a -> a:('a, 'b) t -> b:('a, 'b) t -> c:('a, 'b) t -> unit
