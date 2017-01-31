(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* experimental ... *)

type node

type scalar = Float of float | Node of node

type df =
  | FUNVEC of (scalar array -> scalar array)
  | FUN01X of (scalar -> scalar array)
  | FUN02X of (scalar -> scalar -> scalar array)
  | FUN03X of (scalar -> scalar -> scalar -> scalar array)
  | FUN04X of (scalar -> scalar -> scalar -> scalar -> scalar array)


(** {6 Derivative functions} *)

val forward : ?argnum:int -> (scalar array -> scalar array) -> (scalar array -> scalar array)

val grad : ?argnum:int -> df -> (scalar array -> float)


(** {6 Math functions} *)

val ( +. ) : scalar -> scalar -> scalar

val ( -. ) : scalar -> scalar -> scalar

val ( *. ) : scalar -> scalar -> scalar

val ( /. ) : scalar -> scalar -> scalar

val exp : scalar -> scalar

val sin : scalar -> scalar

val cos : scalar -> scalar

val log : scalar -> scalar
