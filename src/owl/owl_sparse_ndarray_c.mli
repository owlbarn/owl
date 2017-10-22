(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type elt = Complex.t
type arr = (Complex.t, Bigarray.complex32_elt) Owl_sparse_ndarray_generic.t


(** {6 Create sparse ndarray} *)

val zeros : int array -> arr

val binary : ?density:float -> int array -> arr

val uniform : ?scale:float -> ?density:float -> int array -> arr


(** {6 Obtain basic properties} *)

val shape : arr -> int array

val num_dims : arr -> int

val nth_dim : arr -> int -> int

val numel : arr -> int

val nnz : arr -> int

val density : arr -> float

val same_shape : arr -> arr -> bool

val kind : arr -> (elt, Bigarray.complex32_elt) Bigarray.kind


(** {6 Manipulate a N-dimensional array} *)

val get : arr -> int array -> elt

val set : arr -> int array -> elt -> unit

val slice : int option array -> arr -> arr

val clone : arr -> arr

val flatten : arr -> arr

val reshape : arr -> int array -> arr

val transpose : ?axis:int array -> arr -> arr

val swap : int -> int -> arr -> arr


(** {6 Iterate array elements} *)

val iteri : ?axis:int option array -> (int array -> elt -> unit) -> arr -> unit

val iter : ?axis:int option array -> (elt -> unit) -> arr -> unit

val mapi : ?axis:int option array -> (int array -> elt -> elt) -> arr -> arr

val map : ?axis:int option array -> (elt -> elt) -> arr -> arr

val filteri : ?axis:int option array -> (int array -> elt -> bool) -> arr -> int array array

val filter : ?axis:int option array -> (elt -> bool) -> arr -> int array array

val foldi : ?axis:int option array -> (int array -> 'c -> elt -> 'c) -> 'c -> arr -> 'c

val fold : ?axis:int option array -> ('c -> elt -> 'c) -> 'c -> arr -> 'c

val iteri_nz : ?axis:int option array -> (int array -> elt -> unit) -> arr -> unit

val iter_nz : ?axis:int option array -> (elt -> unit) -> arr -> unit

val mapi_nz : ?axis:int option array -> (int array -> elt -> elt) -> arr -> arr

val map_nz : ?axis:int option array -> (elt -> elt) -> arr -> arr

val filteri_nz : ?axis:int option array -> (int array -> elt -> bool) -> arr -> int array array

val filter_nz : ?axis:int option array -> (elt -> bool) -> arr -> int array array

val foldi_nz : ?axis:int option array -> (int array -> 'c -> elt -> 'c) -> 'c -> arr -> 'c

val fold_nz : ?axis:int option array -> ('c -> elt -> 'c) -> 'c -> arr -> 'c


(** {6 Examine array elements or compare two arrays } *)

val exists : (elt -> bool) -> arr -> bool

val not_exists : (elt -> bool) -> arr -> bool

val for_all : (elt -> bool) -> arr -> bool

val is_zero : arr -> bool

val is_positive : arr -> bool

val is_negative : arr -> bool

val is_nonpositive : arr -> bool

val is_nonnegative : arr -> bool

val equal : arr -> arr -> bool

val not_equal : arr -> arr -> bool

val greater : arr -> arr -> bool

val less : arr -> arr -> bool

val greater_equal : arr -> arr -> bool

val less_equal : arr -> arr -> bool


(** {6 Input/Output and helper functions} *)

val to_array : arr -> (int array * elt) array

val of_array : int array -> (int array * elt) array -> arr

val print : arr -> unit

val save : arr -> string -> unit

val load : string -> arr


(** {6 Unary mathematical operations } *)

val neg : arr -> arr

val sum : arr -> elt

val mean : arr -> elt


(** {6 Binary mathematical operations } *)

val add : arr -> arr -> arr

val sub : arr -> arr -> arr

val mul : arr -> arr -> arr

val div : arr -> arr -> arr

val add_scalar : arr -> elt -> arr

val sub_scalar : arr -> elt -> arr

val mul_scalar : arr -> elt -> arr

val div_scalar : arr -> elt -> arr

val scalar_add : elt -> arr -> arr

val scalar_sub : elt -> arr -> arr

val scalar_mul : elt -> arr -> arr

val scalar_div : elt -> arr -> arr

(* ends here *)
