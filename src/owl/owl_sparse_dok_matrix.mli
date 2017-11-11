(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type ('a, 'b) t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind


(** {6 Create sparse matrices} *)

val zeros : ?density:float -> ('a, 'b) kind -> int -> int -> ('a, 'b) t


(** {6 Obtain the basic properties} *)

val shape : ('a, 'b) t -> int * int

val row_num : ('a, 'b) t -> int

val col_num : ('a, 'b) t -> int

val numel : ('a, 'b) t -> int

val nnz : ('a, 'b) t -> int

val density : ('a, 'b) t -> float

val kind : ('a, 'b) t -> ('a, 'b) kind


(** {6 Manipulate a matrix} *)

val set : ('a, 'b) t -> int -> int -> 'a -> unit

val get : ('a, 'b) t -> int -> int -> 'a

val reset : ('a, 'b) t -> unit

val copy : ('a, 'b) t -> ('a, 'b) t


(** {6 Iterate elements, columns, and rows} *)

val iteri_nz : (int -> int -> 'a -> unit) -> ('a, 'b) t -> unit


(** {6 Input/Output and helper functions} *)

val save : ('a, 'b) t -> string -> unit

val load : ('a, 'b) kind -> string -> ('a, 'b) t
