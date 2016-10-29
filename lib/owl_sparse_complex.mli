(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex sparse matrix ] *)

type spmat

type elt = Complex.t


(** {6 Create sparse matrices} *)

val zeros : int -> int -> spmat

val set : spmat -> int -> int -> elt -> unit

val get : spmat -> int -> int -> elt

val pp_spmat : spmat -> unit
