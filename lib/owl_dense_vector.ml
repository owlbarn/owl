(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type ('a, 'b) t = ('a, 'b, c_layout) Array1.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind


(* vector creation operations *)

let kind x = Array1.kind x

let size_in_bytes x = Array1.size_in_bytes x

let shape x = None

let numel x = Array1.dim x

let empty k m = Array1.create k c_layout m
