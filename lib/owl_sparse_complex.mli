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

val shape : spmat -> int * int

val row_num : spmat -> int

val col_num : spmat -> int

val to_dense : spmat -> Owl_dense_complex.mat

val pp_spmat : spmat -> unit

val _triplet2crs : spmat -> unit
