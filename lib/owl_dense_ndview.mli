(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** N-dimensional view module *)

type ('a, 'b) t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind


(** {6 Create N-dimensional view} *)

val of_ndarray : ('a, 'b) Owl_dense_ndarray.t -> ('a, 'b) t

val to_ndarray : ('a, 'b) t -> ('a, 'b) Owl_dense_ndarray.t

val collapse : ('a, 'b) t -> ('a, 'b) t


(** {6 Obtain basic properties of an view} *)

val shape : ('a, 'b) t -> int array

val num_dims : ('a, 'b) t -> int

val nth_dim : ('a, 'b) t -> int -> int

val numel : ('a, 'b) t -> int

val kind : ('a, 'b) t -> ('a, 'b) kind


(** {6 Manipulate a N-dimensional view} *)

val get : ('a, 'b) t -> int array -> 'a

val set : ('a, 'b) t -> int array -> 'a -> ('a, 'b) t

val slice : int option array -> ('a, 'b) t -> ('a, 'b) t

val transpose : ('a, 'b) t -> ('a, 'b) t

val swap : int -> int -> ('a, 'b) t -> ('a, 'b) t


(** {6 Iterate array elements} *)

val iteri : (int array -> 'a -> 'b) -> ('a, 'c) t -> unit

val iter : ('a -> 'b) -> ('a, 'c) t -> unit

val mapi : (int array -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val map : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t

val iteri_slice : int array -> (int option array -> ('a, 'b) t -> unit) -> ('a, 'b) t -> unit

val iter_slice : int array -> (('a, 'b) t -> unit) -> ('a, 'b) t -> unit


(** {6 Basic mathematical operations } *)

val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

val abs : ('a, 'b) t -> ('a, 'b) t

val neg : ('a, 'b) t -> ('a, 'b) t


(** {6 Input and output functions } *)

val print : ('a, 'b) t -> unit
