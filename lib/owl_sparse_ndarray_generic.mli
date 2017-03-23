(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) t


(** {6 Create sparse ndarray} *)

val zeros : ('a, 'b) kind -> int array -> ('a, 'b) t

val binary : ?density:float -> ('a, 'b) kind -> int array -> ('a, 'b) t

val uniform : ?scale:float -> ?density:float -> ('a, 'b) kind -> int array -> ('a, 'b) t


(** {6 Obtain basic properties} *)

val shape : ('a, 'b) t -> int array

val num_dims : ('a, 'b) t -> int

val nth_dim : ('a, 'b) t -> int -> int

val numel : ('a, 'b) t -> int

val nnz : ('a, 'b) t -> int

val density : ('a, 'b) t -> float

val same_shape : ('a, 'b) t -> ('a, 'b) t -> bool

val kind : ('a, 'b) t -> ('a, 'b) kind


(** {6 Manipulate a N-dimensional array} *)

val get : ('a, 'b) t -> int array -> 'a

val set : ('a, 'b) t -> int array -> 'a -> unit

val slice : int option array -> ('a, 'b) t -> ('a, 'b) t

val clone : ('a, 'b) t -> ('a, 'b) t

val flatten : ('a, 'b) t -> ('a, 'b) t

val reshape : ('a, 'b) t -> int array -> ('a, 'b) t

val transpose : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t

val swap : int -> int -> ('a, 'b) t -> ('a, 'b) t


(** {6 Iterate array elements} *)

val iteri : ?axis:int option array -> (int array -> 'a -> unit) -> ('a, 'b) t -> unit

val iter : ?axis:int option array -> ('a -> unit) -> ('a, 'b) t -> unit

val mapi : ?axis:int option array -> (int array -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val map : ?axis:int option array -> ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val filteri : ?axis:int option array -> (int array -> 'a -> bool) -> ('a, 'b) t -> int array array

val filter : ?axis:int option array -> ('a -> bool) -> ('a, 'b) t -> int array array

val foldi : ?axis:int option array -> (int array -> 'c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c

val fold : ?axis:int option array -> ('c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c

val iteri_nz : ?axis:int option array -> (int array -> 'a -> unit) -> ('a, 'b) t -> unit

val iter_nz : ?axis:int option array -> ('a -> unit) -> ('a, 'b) t -> unit

val mapi_nz : ?axis:int option array -> (int array -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val map_nz : ?axis:int option array -> ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val filteri_nz : ?axis:int option array -> (int array -> 'a -> bool) -> ('a, 'b) t -> int array array

val filter_nz : ?axis:int option array -> ('a -> bool) -> ('a, 'b) t -> int array array

val foldi_nz : ?axis:int option array -> (int array -> 'c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c

val fold_nz : ?axis:int option array -> ('c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c


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


(** {6 Input/Output and helper functions} *)

val to_array : ('a, 'b) t -> (int array * 'a) array

val of_array : ('a, 'b) kind -> int array -> (int array * 'a) array -> ('a, 'b) t

val print : ('a, 'b) t -> unit

val pp_spnda : ('a, 'b) t -> unit

val save : ('a, 'b) t -> string -> unit

val load : ('a, 'b) kind -> string -> ('a, 'b) t


(** {6 Unary mathematical operations } *)

val min : ('a, 'b) t -> 'a

val max : ('a, 'b) t -> 'a

val minmax : ('a, 'b) t -> 'a * 'a

val abs : ('a, 'b) t ->('a, 'b) t

val neg : ('a, 'b) t ->('a, 'b) t

val sum : ('a, 'b) t -> 'a

val average : ('a, 'b) t -> 'a


(** {6 Binary mathematical operations } *)

val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val add_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

val sub_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

val mul_scalar : ('a, 'b) t -> 'a ->('a, 'b) t

val div_scalar : ('a, 'b) t -> 'a ->('a, 'b) t



(* ends here *)
