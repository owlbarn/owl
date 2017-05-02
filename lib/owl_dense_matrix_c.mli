(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Complex dense matrix module: this module supports operations on dense
  matrices of complex numbers. The complex number has a record type of
  [{re = float; im = float}].

  This page only contains detailed explanations for the operations specific to
  Dense.Complex module. Most of the other operations are the same to those in
  Dense.Real module, therefore please refer to the documentation of Dense.Real
  for more information.
 *)

open Bigarray

type elt = Complex.t
type mat = (Complex.t, complex32_elt) Owl_dense_matrix_generic.t
type cast_mat = (float, float32_elt) Owl_dense_matrix_generic.t


(** {6 Create dense matrices} *)

val empty : int -> int -> mat

val create : int -> int -> elt -> mat

val zeros : int -> int -> mat

val ones : int -> int -> mat

val eye : int -> mat

val sequential : int -> int -> mat

val uniform_int : ?a:int -> ?b:int -> int -> int -> mat

val uniform : ?scale:float -> int -> int -> mat

val gaussian : ?sigma:float -> int -> int -> mat

val linspace : elt -> elt -> int -> mat

val meshgrid : elt -> elt -> elt -> elt -> int -> int -> mat * mat

val meshup : mat -> mat -> mat * mat


(** {7 Dense row vectors and meshgrids} *)

val vector : int -> mat

val vector_zeros : int -> mat

val vector_ones : int -> mat

val vector_uniform : int -> mat

val linspace : elt -> elt -> int -> mat

val logspace : ?base:float -> elt -> elt -> int -> mat

val meshgrid : elt -> elt -> elt -> elt -> int -> int -> mat * mat

val meshup : mat -> mat -> mat * mat


(** {6 Obtain the basic properties of a matrix} *)

val shape : mat -> int * int

val row_num : mat -> int

val col_num : mat -> int

val numel : mat -> int

val nnz : mat -> int

val density : mat -> float

val size_in_bytes : mat -> int

val same_shape : mat -> mat -> bool


(** {6 Manipulate a matrix} *)

val get : mat -> int -> int -> elt

val set : mat -> int -> int -> elt -> unit

val row : mat -> int -> mat

val col : mat -> int -> mat

val rows : mat -> int array -> mat

val cols : mat -> int array -> mat

val reshape : int -> int -> mat -> mat

val flatten : mat -> mat

val slice : int list list -> mat -> mat

val reverse : mat -> mat

val reset : mat -> unit

val fill : mat -> elt -> unit

val clone : mat -> mat

val copy_to : mat -> mat -> unit

val copy_row_to : mat -> mat -> int -> unit

val copy_col_to : mat -> mat -> int -> unit

val concat_vertical : mat -> mat -> mat

val concat_horizontal : mat -> mat -> mat

val transpose : mat -> mat

val diag : mat -> mat

val replace_row : mat -> mat -> int -> mat

val replace_col : mat -> mat -> int -> mat

val swap_rows : mat -> int -> int -> unit

val swap_cols : mat -> int -> int -> unit

val tile : mat -> int array -> mat

val repeat : ?axis:int -> mat -> int -> mat


(** {6 Iterate elements, columns, and rows.} *)

val iteri : (int -> int -> elt -> unit) -> mat -> unit

val iter : (elt -> unit) -> mat -> unit

val mapi : (int -> int -> elt -> elt) -> mat -> mat

val map : (elt -> elt) -> mat -> mat

val map2i : (int -> int -> elt -> elt -> elt) -> mat -> mat -> mat

val map2 : (elt -> elt -> elt) -> mat -> mat -> mat

val foldi : (int -> int -> 'a -> elt -> 'a) -> 'a -> mat -> 'a

val fold : ('a -> elt -> 'a) -> 'a -> mat -> 'a

val filteri : (int -> int -> elt -> bool) -> mat -> (int * int) array

val filter : (elt -> bool) -> mat -> (int * int) array

val iteri_rows : (int -> mat -> unit) -> mat -> unit

val iter_rows : (mat -> unit) -> mat -> unit

val iter2i_rows : (int -> mat -> mat -> unit) -> mat -> mat -> unit

val iter2_rows : (mat -> mat -> unit) -> mat -> mat -> unit

val iteri_cols : (int -> mat -> unit) -> mat -> unit

val iter_cols : (mat -> unit) -> mat -> unit

val filteri_rows : (int -> mat -> bool) -> mat -> int array

val filter_rows : (mat -> bool) -> mat -> int array

val filteri_cols : (int -> mat -> bool) -> mat -> int array

val filter_cols : (mat -> bool) -> mat -> int array

val fold_rows : ('a -> mat -> 'a) -> 'a -> mat -> 'a

val fold_cols : ('a -> mat -> 'a) -> 'a -> mat -> 'a

val mapi_rows : (int -> mat -> 'a) -> mat -> 'a array

val map_rows : (mat -> 'a) -> mat -> 'a array

val mapi_cols : (int -> mat -> 'a) -> mat -> 'a array

val map_cols : (mat -> 'a) -> mat -> 'a array

val mapi_by_row : int -> (int -> mat -> mat) -> mat -> mat

val map_by_row : int -> (mat -> mat) -> mat -> mat

val mapi_by_col : int -> (int -> mat -> mat) -> mat -> mat

val map_by_col : int -> (mat -> mat) -> mat -> mat

val mapi_at_row : (int -> int -> elt -> elt) -> mat -> int -> mat

val map_at_row : (elt -> elt) -> mat -> int -> mat

val mapi_at_col : (int -> int -> elt -> elt) -> mat -> int -> mat

val map_at_col : (elt -> elt) -> mat -> int -> mat


(** {6 Examin elements and compare two matrices} *)

val exists : (elt -> bool) -> mat -> bool

val not_exists : (elt -> bool) -> mat -> bool

val for_all : (elt -> bool) -> mat -> bool

val is_zero : mat -> bool

val is_positive : mat -> bool

val is_negative : mat -> bool

val is_nonpositive : mat -> bool

val is_nonnegative : mat -> bool

val equal : mat -> mat -> bool

val not_equal : mat -> mat -> bool

val greater : mat -> mat -> bool

val less : mat -> mat -> bool

val greater_equal : mat -> mat -> bool

val less_equal : mat -> mat -> bool

val elt_equal : mat -> mat -> mat

val elt_not_equal : mat -> mat -> mat

val elt_less : mat -> mat -> mat

val elt_greater : mat -> mat -> mat

val elt_less_equal : mat -> mat -> mat

val elt_greater_equal : mat -> mat -> mat

val equal_scalar : mat -> elt -> bool

val not_equal_scalar : mat -> elt -> bool

val less_scalar : mat -> elt -> bool

val greater_scalar : mat -> elt -> bool

val less_equal_scalar : mat -> elt -> bool

val greater_equal_scalar : mat -> elt -> bool

val elt_equal_scalar : mat -> elt -> mat

val elt_not_equal_scalar : mat -> elt -> mat

val elt_less_scalar : mat -> elt -> mat

val elt_greater_scalar : mat -> elt -> mat

val elt_less_equal_scalar : mat -> elt -> mat

val elt_greater_equal_scalar : mat -> elt -> mat


(** {6 Randomisation functions} *)

val draw_rows : ?replacement:bool -> mat -> int -> mat * int array

val draw_cols : ?replacement:bool -> mat -> int -> mat * int array

val draw_rows2 : ?replacement:bool -> mat -> mat -> int -> mat * mat * int array

val draw_cols2 : ?replacement:bool -> mat -> mat -> int -> mat * mat * int array

val shuffle_rows : mat -> mat

val shuffle_cols : mat -> mat

val shuffle: mat -> mat


(** {6 Input/Output and helper functions} *)

val to_array : mat -> elt array

val of_array : elt array -> int -> int -> mat

val to_arrays : mat -> elt array array

val of_arrays : elt array array -> mat

val to_ndarray : mat -> (Complex.t, complex32_elt) Owl_dense_ndarray_generic.t

val of_ndarray : (Complex.t, complex32_elt) Owl_dense_ndarray_generic.t -> mat

val to_rows : mat -> mat array

val of_rows : mat array -> mat

val to_cols : mat -> mat array

val of_cols : mat array -> mat

val print : mat -> unit

val pp_dsmat : mat -> unit

val save : mat -> string -> unit

val load : string -> mat


(** {6 Unary mathematical operations } *)

val re : mat -> cast_mat

val im : mat -> cast_mat

val trace : mat -> elt

val sum : mat -> elt

val prod : mat -> elt

val average : mat -> elt

val sum_rows : mat -> mat

val sum_cols : mat -> mat

val average_rows : mat -> mat

val average_cols : mat -> mat

val abs : mat -> cast_mat

val abs2 : mat -> cast_mat

val conj : mat -> mat

val neg : mat -> mat

val reci : mat -> mat

val l1norm : mat -> float

val l2norm : mat -> float

val l2norm_sqr : mat -> float


(** {6 Binary mathematical operations } *)

val add : mat -> mat -> mat

val sub : mat -> mat -> mat

val mul : mat -> mat -> mat

val div : mat -> mat -> mat

val add_scalar : mat -> elt -> mat

val sub_scalar : mat -> elt -> mat

val mul_scalar : mat -> elt -> mat

val div_scalar : mat -> elt -> mat

val scalar_add : elt -> mat -> mat

val scalar_sub : elt -> mat -> mat

val scalar_mul : elt -> mat -> mat

val scalar_div : elt -> mat -> mat

val dot : mat -> mat -> mat

val add_diag : mat -> elt -> mat

val ssqr : mat -> elt -> elt

val ssqr_diff : mat -> mat -> elt
