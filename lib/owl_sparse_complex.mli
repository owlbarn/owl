(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex sparse matrix ] *)

type spmat

type elt = Complex.t

val zeros : int -> int -> spmat

val shape : spmat -> int * int

val row_num : spmat -> int

val col_num : spmat -> int

val numel : spmat -> int

val get : spmat -> int -> int -> elt

val set : spmat -> int -> int -> elt -> unit

val reset : spmat -> unit
