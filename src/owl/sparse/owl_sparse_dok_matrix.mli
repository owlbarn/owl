(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

type ('a, 'b) t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

(** {5 Create sparse matrices} *)

val zeros : ?density:float -> ('a, 'b) kind -> int -> int -> ('a, 'b) t

(** {5 Obtain the basic properties} *)

val shape : ('a, 'b) t -> int * int

val row_num : ('a, 'b) t -> int

val col_num : ('a, 'b) t -> int

val numel : ('a, 'b) t -> int

val nnz : ('a, 'b) t -> int

val density : ('a, 'b) t -> float

val kind : ('a, 'b) t -> ('a, 'b) kind

(** {5 Manipulate a matrix} *)

val set : ('a, 'b) t -> int -> int -> 'a -> unit

val get : ('a, 'b) t -> int -> int -> 'a

val reset : ('a, 'b) t -> unit

val copy : ('a, 'b) t -> ('a, 'b) t

(** {5 Iterate elements, columns, and rows} *)

val iteri_nz : (int -> int -> 'a -> unit) -> ('a, 'b) t -> unit

(** {5 Input/Output and helper functions} *)

val save : ('a, 'b) t -> string -> unit

val load : ('a, 'b) kind -> string -> ('a, 'b) t
