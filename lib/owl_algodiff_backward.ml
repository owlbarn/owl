(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module M = Owl_dense_real

type mat = Owl_dense_real.mat

type t = Float of float | Matrix of mat | Adjt of adjt
and adjt = {
  v : t;       (* primal value *)
  d : t;       (* tangent value *)
}
and trace_op =
  | Add of t * t
  | Sub of t * t
  | Mul of t * t
  | Div of t * t
  | Sin of t
  | Cos of t
