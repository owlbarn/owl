(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex sparse matrix ] *)

type spmat

type elt = Complex.t


(** {6 Create sparse matrices} *)

val zeros : int -> int -> spmat

val eye : int -> spmat

val binary : int -> int -> spmat

val uniform : ?scale:float -> int -> int -> spmat

val uniform_int : ?a:int -> ?b:int -> int -> int -> spmat


(** {6 Obtain the basic properties of a matrix} *)

val shape : spmat -> int * int

val row_num : spmat -> int

val col_num : spmat -> int

val numel : spmat -> int

val density : spmat -> float


(** {6 Manipulate a matrix} *)

val set : spmat -> int -> int -> elt -> unit

val get : spmat -> int -> int -> elt

val reset : spmat -> unit

val row : spmat -> int -> spmat

val col : spmat -> int -> spmat

val rows : spmat -> int array -> spmat

val cols : spmat -> int array -> spmat


(** {6 Input/Output and helper functions} *)

val to_dense : spmat -> Owl_dense_complex.mat

val pp_spmat : spmat -> unit


val _triplet2crs : spmat -> unit
