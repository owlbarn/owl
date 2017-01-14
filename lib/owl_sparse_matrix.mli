(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) t


(** {6 Create sparse matrices} *)

val zeros : ('a, 'b) kind -> int -> int -> ('a, 'b) t

(* val ones : ('a, 'b) kind -> int -> int -> ('a, 'b) t *)

(* val sequential : ('a, 'b) kind -> int -> int -> ('a, 'b) t *)

val eye : ('a, 'b) kind -> int -> ('a, 'b) t

(* val binary : ('a, 'b) kind -> int -> int -> ('a, 'b) t *)

(* val uniform : ?scale:float -> ('a, 'b) kind -> int -> int -> ('a, 'b) t *)


(** {6 Obtain the basic properties} *)

val shape : ('a, 'b) t -> int * int

val row_num : ('a, 'b) t -> int

val col_num : ('a, 'b) t -> int

(* val row_num_nz : ('a, 'b) t -> int *)

(* val col_num_nz : ('a, 'b) t -> int *)

val numel : ('a, 'b) t -> int

val nnz : ('a, 'b) t -> int

(* val nnz_rows : ('a, 'b) t -> int array *)

(* val nnz_cols : ('a, 'b) t -> int array *)

val density : ('a, 'b) t -> float

val kind : ('a, 'b) t -> ('a, 'b) kind


(** {6 Manipulate a matrix} *)

val set : ('a, 'b) t -> int -> int -> 'a -> unit

val get : ('a, 'b) t -> int -> int -> 'a

val reset : ('a, 'b) t -> unit

(* val fill : ('a, 'b) t -> 'a -> unit *)

val clone : ('a, 'b) t -> ('a, 'b) t

val transpose : ('a, 'b) t -> ('a, 'b) t

val diag : ('a, 'b) t -> ('a, 'b) t

val trace : ('a, 'b) t -> 'a

val row : ('a, 'b) t -> int -> ('a, 'b) t

val col : ('a, 'b) t -> int -> ('a, 'b) t
(*
val rows : ('a, 'b) t -> int array -> ('a, 'b) t

val cols : ('a, 'b) t -> int array -> ('a, 'b) t
*)


(** {6 Input/Output and helper functions} *)

(*
val to_array : ('a, 'b) t -> (int array * 'a) array

val of_array : ('a, 'b) kind -> int -> int -> (int array * 'a) array -> ('a, 'b) t

val to_dense : ('a, 'b) t -> ('a, 'b) Owl_dense_matrix.t

val of_dense : ('a, 'b) Owl_dense_matrix.t -> ('a, 'b) t

val print : ('a, 'b) t -> unit

val pp_spmat : ('a, 'b) t -> unit

val save : ('a, 'b) t -> string -> unit

val load : ('a, 'b) kind -> string -> ('a, 'b) t
*)



(* ends here *)
