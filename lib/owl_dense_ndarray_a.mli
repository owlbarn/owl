(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

type 'a arr = {
  mutable shape  : int array;
  mutable stride : int array;
  mutable data   : 'a array;
}


(** {6 Create N-dimensional array} *)

val create : int array -> 'a -> 'a arr

val init : int array -> (int -> 'a) -> 'a arr

val init_nd : int array -> (int array -> 'a) -> 'a arr

val sequential : ?a:float -> ?step:float -> int array -> float arr

val zeros: int array -> float arr

val ones: int array -> float arr


(** {6 Obtain basic properties} *)

val shape : 'a arr -> int array

val num_dims : 'a arr -> int

val nth_dim : 'a arr -> int -> int

val numel : 'a arr -> int

val same_shape : 'a arr -> 'a arr -> bool

val strides : 'a arr -> int array

val slice_size : 'a arr -> int array

val index_1d_nd : int -> int array -> int array

val index_nd_1d : int array -> int array -> int


(** {6 Manipulate a N-dimensional array} *)

val get : 'a arr -> int array -> 'a

val set : 'a arr -> int array -> 'a -> unit

val get_slice : index list -> 'a arr -> 'a arr

val set_slice : index list -> 'a arr -> 'a arr -> unit

val get_slice_simple : int list list -> 'a arr -> 'a arr

val set_slice_simple : int list list -> 'a arr -> 'a arr -> unit

val fill : 'a arr -> 'a -> unit

val copy : 'a arr -> 'a arr -> unit

val clone : 'a arr -> 'a arr

val reshape : 'a arr -> int array -> 'a arr

val flatten : 'a arr -> 'a arr

val sub_left : 'a arr -> int array -> 'a arr

val squeeze : ?axis:int array -> 'a arr -> 'a arr

val expand : 'a arr -> int -> 'a arr

val reverse : 'a arr -> 'a arr

val transpose : ?axis:int array -> 'a arr -> 'a arr

val swap : int -> int -> 'a arr -> 'a arr

val repeat : ?axis:int -> 'a arr -> int -> 'a arr

val tile : 'a arr -> int array -> 'a arr

val concatenate : ?axis:int -> 'a arr array -> 'a arr

val pad : 'a -> int list list -> 'a arr -> 'a arr


(** {6 Iterate array elements} *)

val iter : ('a -> unit) -> 'a arr -> unit

val iteri : (int -> 'a -> unit) -> 'a arr -> unit

val map : ('a -> 'b) -> 'a arr -> 'b arr

val mapi : (int -> 'a -> 'b) -> 'a arr -> 'b arr

val filter : ('a -> bool) -> 'a arr -> int array

val filteri : (int -> 'a -> bool) -> 'a arr -> int array

val fold : ('a -> 'b -> 'a) -> 'a -> 'b arr -> 'a

val foldi : (int -> 'a -> 'b -> 'a) -> 'a -> 'b arr -> 'a

val iter2 : ('a -> 'b -> unit) -> 'a arr -> 'b arr -> unit

val iter2i : (int -> 'a -> 'b -> unit) -> 'a arr -> 'b arr -> unit

val map2 : ('a -> 'b -> 'c) -> 'a arr -> 'b arr -> 'c arr

val map2i : (int -> 'a -> 'b -> 'c) -> 'a arr -> 'b arr -> 'c arr


(** {6 Examine array elements or compare two arrays } *)

val exists : ('a -> bool) -> 'a arr -> bool

val not_exists : ('a -> bool) -> 'a arr -> bool

val for_all : ('a -> bool) -> 'a arr -> bool

val is_equal : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool

val not_equal : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool

val greater : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool

val less : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool

val greater_equal : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool

val less_equal : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool

val elt_equal : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool arr

val elt_not_equal : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool arr

val elt_greater : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool arr

val elt_less : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool arr

val elt_greater_equal : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool arr

val elt_less_equal : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a arr -> bool arr

val elt_equal_scalar : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a -> bool arr

val elt_not_equal_scalar : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a -> bool arr

val elt_greater_scalar : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a -> bool arr

val elt_less_scalar : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a -> bool arr

val elt_greater_equal_scalar : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a -> bool arr

val elt_less_equal_scalar : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a -> bool arr

val sort : ?cmp:('a -> 'a -> int) -> 'a arr -> unit

val min : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a

val max : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a

val min_i : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a * int

val max_i : ?cmp:('a -> 'a -> int) -> 'a arr -> 'a * int


(** {6 Input/Output functions} *)

val of_array : 'a array -> int array -> 'a arr

val to_array : 'a arr -> 'a array
