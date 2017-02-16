(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module M = Owl_dense_real

type mat = Owl_dense_real.mat

type t = Float of float | Matrix of mat | Dual of dual
and adjt = {
  v : t;       (* primal value *)
  d : t;       (* tangent value *)
}
