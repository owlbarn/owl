(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type ('a, 'b) mat = ('a, 'b, Bigarray.c_layout) Bigarray.Array2.t
type ('a, 'b) kind = ('a, 'b) Bigarray.kind
type mat_d = (float, Bigarray.float64_elt) mat

(** {6 Create dense matrices} *)

val empty : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val create : ('a, 'b) kind -> int -> int -> 'a -> ('a, 'b) mat

val zeros : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val ones : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val eye : ('a, 'b) kind -> int -> ('a, 'b) mat

val sequential : ('a, 'b) kind -> int -> int -> ('a, 'b) mat

val uniform : ?scale:float -> (float, 'b) kind -> int -> int -> (float, 'b) mat

val gaussian : ?sigma:float -> (float, 'b) kind -> int -> int -> (float, 'b) mat

(* val semidef : (float, 'b) kind -> int -> (float, 'b) mat *)


(** {7 Dense vectors and meshgrids} *)

val vector : ('a, 'b) kind -> int -> ('a, 'b) mat

val vector_zeros : ('a, 'b) kind -> int -> ('a, 'b) mat

val vector_ones : ('a, 'b) kind -> int -> ('a, 'b) mat

val vector_uniform : (float, 'b) kind -> int -> (float, 'b) mat

val linspace : float -> float -> int -> mat_d

val meshgrid : float -> float -> float -> float -> int -> int -> mat_d * mat_d

val meshup : mat_d -> mat_d -> mat_d * mat_d


(** {6 Obtain the basic properties of a matrix} *)

val shape : ('a, 'b) mat -> int * int

val row_num : ('a, 'b) mat -> int

val col_num : ('a, 'b) mat -> int

val numel : ('a, 'b) mat -> int

val same_shape : ('a, 'b) mat -> ('a, 'b) mat -> bool

val reshape : int -> int -> ('a, 'b) mat -> ('a, 'b) mat


(** {6 Manipulate a matrix} *)

val get : ('a, 'b) mat -> int -> int -> 'a

val set : ('a, 'b) mat -> int -> int -> 'a -> unit

val row : ('a, 'b) mat -> int -> ('a, 'b) mat

val col : ('a, 'b) mat -> int -> ('a, 'b) mat

val rows : ('a, 'b) mat -> int array -> ('a, 'b) mat

val cols : ('a, 'b) mat -> int array -> ('a, 'b) mat

val clone : ('a, 'b) mat -> ('a, 'b) mat

val copy_to : ('a, 'b) mat -> ('a, 'b) mat -> unit

val copy_row_to : ('a, 'b) mat -> ('a, 'b) mat -> int -> unit

val copy_col_to : ('a, 'b) mat -> ('a, 'b) mat -> int -> unit

val concat_vertical : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat

val concat_horizontal : ('a, 'b) mat -> ('a, 'b) mat -> ('a, 'b) mat

val transpose : ('a, 'b) mat -> ('a, 'b) mat

val diag : ('a, 'b) mat -> ('a, 'b) mat

val trace : ('a, 'b) mat -> 'a

val add_diag : ('a, 'b) mat -> 'a -> ('a, 'b) mat

val replace_row : ('a, 'b) mat -> ('a, 'b) mat -> int -> ('a, 'b) mat

val replace_col : ('a, 'b) mat -> ('a, 'b) mat -> int -> ('a, 'b) mat

val swap_rows : ('a, 'b) mat -> int -> int -> ('a, 'b) mat

val swap_cols : ('a, 'b) mat -> int -> int -> ('a, 'b) mat
