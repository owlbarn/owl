(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Numerical Integration *)


val trapzd : (float -> float) -> float -> float -> int -> float
(** TODO *)

val trapz : ?n:int -> ?eps:float -> (float -> float) -> float -> float -> float
(** TODO *)

val simpson : ?n:int -> ?eps:float -> (float -> float) -> float -> float -> float
(** TODO *)

val romberg : ?n:int -> ?eps:float -> (float -> float) -> float -> float -> float
(** TODO *)
