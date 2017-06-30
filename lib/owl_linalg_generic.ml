(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

open Bigarray

type ('a, 'b) t = ('a, 'b) Owl_dense.Matrix.Generic.t

module M = Owl_dense.Matrix.Generic


let _to_complex
  : type a b c d. (a, b) kind -> (c, d) kind -> (a, b) t -> (a, b) t -> (c, d) t
  = fun in_kind out_kind wr wi ->
  match in_kind with
  | Float32   -> M.complex in_kind out_kind wr wi
  | Float64   -> M.complex in_kind out_kind wr wi
  | Complex32 -> Obj.magic wr
  | Complex64 -> Obj.magic wr
  | _         -> failwith "owl_linalg_generic:_to_complex"


let schur
  : type a b c d. (a, b) kind -> (c, d) kind -> (a, b) t -> (a, b) t * (a, b) t * (c, d) t
  = fun in_kind out_kind x ->
  let x = M.clone x in
  let t, z, wr, wi = Owl_lapacke.gees ~jobvs:'V' ~a:x in
  let w = _to_complex in_kind out_kind wr wi in
  t, z, w
