(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

open Bigarray

type ('a, 'b) t = ('a, 'b) Owl_dense.Matrix.Generic.t

module M = Owl_dense.Matrix.Generic


let schur
  : type a b c d. (a, b) kind -> (c, d) kind -> (a, b) t -> (a, b) t * (a, b) t * (c, d) t
  = fun real_kind complex_kind x ->
  let x = M.clone x in
  let t, z, wr, wi = Owl_lapacke.gees ~jobvs:'V' ~a:x in
  let w = Array2.create complex_kind c_layout 4 4 in
  t, z, w
