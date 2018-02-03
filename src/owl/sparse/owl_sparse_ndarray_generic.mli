(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Sparse N-dimensional array module *)


type ('a, 'b) kind = ('a, 'b) Bigarray.kind
(** TODO *)

type ('a, 'b) t
(** TODO *)


(** {6 Create sparse ndarray} *)

val zeros : ('a, 'b) kind -> int array -> ('a, 'b) t
(** TODO *)

val binary : ?density:float -> ('a, 'b) kind -> int array -> ('a, 'b) t
(** TODO *)

val uniform : ?scale:float -> ?density:float -> ('a, 'b) kind -> int array -> ('a, 'b) t
(** TODO *)


(** {6 Obtain basic properties} *)

val shape : ('a, 'b) t -> int array
(** TODO *)

val num_dims : ('a, 'b) t -> int
(** TODO *)

val nth_dim : ('a, 'b) t -> int -> int
(** TODO *)

val numel : ('a, 'b) t -> int
(** TODO *)

val nnz : ('a, 'b) t -> int
(** TODO *)

val density : ('a, 'b) t -> float
(** TODO *)

val same_shape : ('a, 'b) t -> ('a, 'b) t -> bool
(** TODO *)

val kind : ('a, 'b) t -> ('a, 'b) kind
(** TODO *)


(** {6 Manipulate a N-dimensional array} *)

val get : ('a, 'b) t -> int array -> 'a
(** TODO *)

val set : ('a, 'b) t -> int array -> 'a -> unit
(** TODO *)

val slice : int option array -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val copy : ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val flatten : ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val reshape : ('a, 'b) t -> int array -> ('a, 'b) t
(** TODO *)

val transpose : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val swap : int -> int -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)


(** {6 Iterate array elements} *)

val iteri : ?axis:int option array -> (int array -> 'a -> unit) -> ('a, 'b) t -> unit
(** TODO *)

val iter : ?axis:int option array -> ('a -> unit) -> ('a, 'b) t -> unit
(** TODO *)

val mapi : ?axis:int option array -> (int array -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val map : ?axis:int option array -> ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val filteri : ?axis:int option array -> (int array -> 'a -> bool) -> ('a, 'b) t -> int array array
(** TODO *)

val filter : ?axis:int option array -> ('a -> bool) -> ('a, 'b) t -> int array array
(** TODO *)

val foldi : ?axis:int option array -> (int array -> 'c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** TODO *)

val fold : ?axis:int option array -> ('c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** TODO *)

val iteri_nz : ?axis:int option array -> (int array -> 'a -> unit) -> ('a, 'b) t -> unit
(** TODO *)

val iter_nz : ?axis:int option array -> ('a -> unit) -> ('a, 'b) t -> unit
(** TODO *)

val mapi_nz : ?axis:int option array -> (int array -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val map_nz : ?axis:int option array -> ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val filteri_nz : ?axis:int option array -> (int array -> 'a -> bool) -> ('a, 'b) t -> int array array
(** TODO *)

val filter_nz : ?axis:int option array -> ('a -> bool) -> ('a, 'b) t -> int array array
(** TODO *)

val foldi_nz : ?axis:int option array -> (int array -> 'c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** TODO *)

val fold_nz : ?axis:int option array -> ('c -> 'a -> 'c) -> 'c -> ('a, 'b) t -> 'c
(** TODO *)


(** {6 Examine array elements or compare two arrays } *)

val exists : ('a -> bool) -> ('a, 'b) t -> bool
(** TODO *)

val not_exists : ('a -> bool) -> ('a, 'b) t -> bool
(** TODO *)

val for_all : ('a -> bool) -> ('a, 'b) t -> bool
(** TODO *)

val is_zero : ('a, 'b) t -> bool
(** TODO *)

val is_positive : ('a, 'b) t -> bool
(** TODO *)

val is_negative : ('a, 'b) t -> bool
(** TODO *)

val is_nonpositive : ('a, 'b) t -> bool
(** TODO *)

val is_nonnegative : ('a, 'b) t -> bool
(** TODO *)

val equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** TODO *)

val not_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** TODO *)

val greater : ('a, 'b) t -> ('a, 'b) t -> bool
(** TODO *)

val less : ('a, 'b) t -> ('a, 'b) t -> bool
(** TODO *)

val greater_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** TODO *)

val less_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(** TODO *)


(** {6 Input/Output and helper functions} *)

val to_array : ('a, 'b) t -> (int array * 'a) array
(** TODO *)

val of_array : ('a, 'b) kind -> int array -> (int array * 'a) array -> ('a, 'b) t
(** TODO *)

val print : ('a, 'b) t -> unit
(** TODO *)

val pp_spnda : ('a, 'b) t -> unit
(** TODO *)

val save : ('a, 'b) t -> string -> unit
(** TODO *)

val load : ('a, 'b) kind -> string -> ('a, 'b) t
(** TODO *)


(** {6 Unary mathematical operations } *)

val min : ('a, 'b) t -> 'a
(** TODO *)

val max : ('a, 'b) t -> 'a
(** TODO *)

val minmax : ('a, 'b) t -> 'a * 'a
(** TODO *)

val abs : ('a, 'b) t ->('a, 'b) t
(** TODO *)

val neg : ('a, 'b) t ->('a, 'b) t
(** TODO *)

val sum : ('a, 'b) t -> 'a
(** TODO *)

val mean : ('a, 'b) t -> 'a
(** TODO *)


(** {6 Binary mathematical operations } *)

val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val add_scalar : ('a, 'b) t -> 'a ->('a, 'b) t
(** TODO *)

val sub_scalar : ('a, 'b) t -> 'a ->('a, 'b) t
(** TODO *)

val mul_scalar : ('a, 'b) t -> 'a ->('a, 'b) t
(** TODO *)

val div_scalar : ('a, 'b) t -> 'a ->('a, 'b) t
(** TODO *)

val scalar_add : 'a -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val scalar_sub : 'a -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val scalar_mul : 'a -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)

val scalar_div : 'a -> ('a, 'b) t -> ('a, 'b) t
(** TODO *)


(* ends here *)
