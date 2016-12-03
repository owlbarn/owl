(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** N-dimensional array module *)

type ('a, 'b) t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind


(** {6 Create N-dimensional array} *)

val empty : ('a, 'b) kind -> int array -> ('a, 'b) t

val create : ('a, 'b) kind -> int array -> 'a -> ('a, 'b) t

val zeros : ('a, 'b) kind -> int array -> ('a, 'b) t

val ones : ('a, 'b) kind -> int array -> ('a, 'b) t


(** {6 Obtain basic properties of an array} *)

val shape : ('a, 'b) t -> int array

val num_dims : ('a, 'b) t -> int

val nth_dim : ('a, 'b) t -> int -> int

val numel : ('a, 'b) t -> int

val nnz : ('a, 'b) t -> int

val density : ('a, 'b) t -> float

val kind : ('a, 'b) t -> ('a, 'b) kind


(** {6 Manipulate a N-dimensional array} *)

val get : ('a, 'b) t -> int array -> 'a

val set : ('a, 'b) t -> int array -> 'a -> unit

val sub_left : ('a, 'b) t -> int -> int -> ('a, 'b) t

val slice_left : ('a, 'b) t -> int array -> ('a, 'b) t

val slice : int option array -> ('a, 'b) t -> ('a, 'b) t

val copy_slice : int option array -> ('a, 'b) t -> ('a, 'b) t -> unit

val copy : ('a, 'b) t -> ('a, 'b) t -> unit

val fill : ('a, 'b) t -> 'a -> unit

val clone : ('a, 'b) t -> ('a, 'b) t

val flatten : ('a, 'b) t -> ('a, 'b) t

val reshape : ('a, 'b) t -> int array -> ('a, 'b) t

val same_shape : ('a, 'b) t -> ('a, 'b) t -> bool

val transpose : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t

val swap : int -> int -> ('a, 'b) t -> ('a, 'b) t

(* TODO: mmap *)


(** {6 Iterate array elements} *)

val iteri : ?axis:int option array -> (int array -> 'a -> unit) -> ('a, 'c) t -> unit

val iter : ?axis:int option array -> ('a -> unit) -> ('a, 'b) t -> unit

val mapi : ?axis:int option array -> (int array -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val map : ?axis:int option array -> ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val filteri : ?axis:int option array -> (int array -> 'a -> bool) -> ('a, 'b) t -> int array array

val filter : ?axis:int option array -> ('a -> bool) -> ('a, 'b) t -> int array array

val foldi : ?axis:int option array -> (int array -> 'a -> 'b -> 'b) -> 'b -> ('a, 'c) t -> 'b

val fold : ?axis:int option array -> ('a -> 'b -> 'b) -> 'b -> ('a, 'c) t -> 'b

val iteri_slice : int array -> (int option array -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iter_slice : int array -> (('a, 'b) t -> unit) -> ('a, 'b) t -> unit


(** {6 Basic mathematical operations } *)

val re : (Complex.t, 'a) t -> (float, Bigarray.float64_elt) t

val im : (Complex.t, 'a) t -> (float, Bigarray.float64_elt) t

(*val max : ?axis:int option array -> ('a, 'b) t -> 'a * (int array*)

val min : ('a, 'b) t -> 'a

val max : ('a, 'b) t -> 'a

val minmax : ?axis:int option array -> ('a, 'b) t -> ('a * (int array) * 'a * (int array))

val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val abs : ('a, 'b) t -> ('a, 'b) t

val neg : ('a, 'b) t -> ('a, 'b) t

val sum : ('a, 'b) t -> 'a

(* val conj : (Complex.t, 'a) t -> (Complex.t, 'a) t *)

val add_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t

val sub_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t


(** {6 Examine array elements or compare two arrays } *)

val exists : ('a -> bool) -> ('a, 'b) t -> bool

val not_exists : ('a -> bool) -> ('a, 'b) t -> bool

val for_all : ('a -> bool) -> ('a, 'b) t -> bool

val is_zero : ('a, 'b) t -> bool

val is_positive : ('a, 'b) t -> bool

val is_negative : ('a, 'b) t -> bool

val is_nonpositive : ('a, 'b) t -> bool

val is_nonnegative : ('a, 'b) t -> bool

val is_equal : ('a, 'b) t -> ('a, 'b) t -> bool

val is_unequal : ('a, 'b) t -> ('a, 'b) t -> bool

val is_greater : ('a, 'b) t -> ('a, 'b) t -> bool

val is_smaller : ('a, 'b) t -> ('a, 'b) t -> bool

val equal_or_greater : ('a, 'b) t -> ('a, 'b) t -> bool

val equal_or_smaller : ('a, 'b) t -> ('a, 'b) t -> bool


(** {6 Input and output functions } *)

val save : ('a, 'b) t -> string -> unit

val load : string -> ('a, 'b) t

val print : ('a, 'b) t -> unit


(** {6 Some helper functions } *)

val print_element : ('a, 'b) kind -> 'a -> unit

val print_index : int array -> unit

val _check_transpose_axis : int array -> int -> unit

val _check_slice_axis : int option array -> int array -> unit
