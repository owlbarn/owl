(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Root finding algorithms *)

val bisec : ?max_iter:int -> ?xtol:float -> (float -> float) -> float -> float -> float
(** TODO *)

val false_pos : ?max_iter:int -> ?xtol:float -> (float -> float) -> float -> float -> float
(** TODO *)

val ridder : ?max_iter:int -> ?xtol:float -> (float -> float) -> float -> float -> float
(** TODO *)

val brent : ?max_iter:int -> ?xtol:float -> (float -> float) -> float -> float -> float
(** TODO *)
