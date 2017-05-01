(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_ext_types

(* modules for packing and unpacking *)

module type PackSig = sig

  type arr
  type elt
  type cast_arr

  val pack_box      : arr -> ext_typ
  val unpack_box    : ext_typ -> arr
  val pack_elt      : elt -> ext_typ
  val unpack_elt    : ext_typ -> elt
  val pack_cast_box : arr -> ext_typ

end


module Pack_DAS = struct

  type arr = das
  type elt = float
  type cast_arr = das

  let pack_box x = DAS x
  let unpack_box = function DAS x -> x | _ -> failwith "unpack_das: unknown type."
  let pack_elt x = F x
  let unpack_elt = function F x -> x | _ -> failwith "unpack_elt: unknown type."
  let pack_cast_box x = DAS x

end


module Pack_DAD = struct

  type arr = dad
  type elt = float
  type cast_arr = dad

  let pack_box x = DAD x
  let unpack_box = function DAD x -> x | _ -> failwith "unpack_dad: unknown type."
  let pack_elt x = F x
  let unpack_elt = function F x -> x | _ -> failwith "unpack_elt: unknown type."
  let pack_cast_box x = DAD x

end


module Pack_DAC = struct

  type arr = dac
  type elt = Complex.t
  type cast_arr = das

  let pack_box x = DAC x
  let unpack_box = function DAC x -> x | _ -> failwith "unpack_dac: unknown type."
  let pack_elt x = C x
  let unpack_elt = function C x -> x | _ -> failwith "unpack_elt: unknown type."
  let pack_cast_box x = DAC x

end


module Pack_DAZ = struct

  type arr = daz
  type elt = Complex.t
  type cast_arr = dad

  let pack_box x = DAZ x
  let unpack_box = function DAZ x -> x | _ -> failwith "unpack_daz: unknown type."
  let pack_elt x = C x
  let unpack_elt = function C x -> x | _ -> failwith "unpack_elt: unknown type."
  let pack_cast_box x = DAZ x

end


(* module for basic matrix operations *)

module type BasicSig = sig

  type arr
  type elt

  val empty : int array -> arr

  val empty : int array -> arr

  val create : int array -> elt -> arr

  val zeros : int array -> arr

  val ones : int array -> arr

  val uniform : ?scale:float -> int array -> arr

  val sequential : int array -> arr

  val linspace : elt -> elt -> int -> arr

  val logspace : ?base:float -> elt -> elt -> int -> arr


  val shape : arr -> int array

  val num_dims : arr -> int

  val nth_dim : arr -> int -> int

  val numel : arr -> int

  val nnz : arr -> int

  val density : arr -> float

  val size_in_bytes : arr -> int

  val same_shape : arr -> arr -> bool


  val get : arr -> int array -> elt

  val set : arr -> int array -> elt -> unit

  val sub_left : arr -> int -> int -> arr

  val slice_left : arr -> int array -> arr

  val slice : int list list -> arr -> arr

  val copy : arr -> arr -> unit

  val reset : arr -> unit

  val fill : arr -> elt -> unit

  val clone : arr -> arr

  val reshape : arr -> int array -> arr

  val flatten : arr -> arr

  val reverse : arr -> arr

  val transpose : ?axis:int array -> arr -> arr

  val swap : int -> int -> arr -> arr

  val tile : arr -> int array -> arr

  val repeat : ?axis:int -> arr -> int -> arr

  val squeeze : ?axis:int array -> arr -> arr


  val iteri : ?axis:int option array -> (int array -> elt -> unit) -> arr -> unit

  val iter : ?axis:int option array -> (elt -> unit) -> arr -> unit

  val mapi : ?axis:int option array -> (int array -> elt -> elt) -> arr -> arr

  val map : ?axis:int option array -> (elt -> elt) -> arr -> arr

  val map2i : ?axis:int option array -> (int array -> elt -> elt -> elt) -> arr -> arr -> arr

  val map2 : ?axis:int option array -> (elt -> elt -> elt) -> arr -> arr -> arr

  val filteri : ?axis:int option array -> (int array -> elt -> bool) -> arr -> int array array

  val filter : ?axis:int option array -> (elt -> bool) -> arr -> int array array

  val foldi : ?axis:int option array -> (int array -> 'c -> elt -> 'c) -> 'c -> arr -> 'c

  val fold : ?axis:int option array -> ('a -> elt -> 'a) -> 'a -> arr -> 'a

  val iteri_slice : int array -> (int array array -> arr -> unit) -> arr -> unit

  val iter_slice : int array -> (arr -> unit) -> arr -> unit

  val iter2i : (int array -> elt -> elt -> unit) -> arr -> arr -> unit

  val iter2 : (elt -> elt -> unit) -> arr -> arr -> unit


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

  val elt_equal : arr -> arr -> arr

  val elt_not_equal : arr -> arr -> arr

  val elt_less : arr -> arr -> arr

  val elt_greater : arr -> arr -> arr

  val elt_less_equal : arr -> arr -> arr

  val elt_greater_equal : arr -> arr -> arr


  val print : arr -> unit

  val save : arr -> string -> unit

  val load : string -> arr


  val add : arr -> arr -> arr

  val sub : arr -> arr -> arr

  val mul : arr -> arr -> arr

  val div : arr -> arr -> arr

  val add_scalar : arr -> elt -> arr

  val sub_scalar : arr -> elt -> arr

  val mul_scalar : arr -> elt -> arr

  val div_scalar : arr -> elt -> arr

  val add_scalar0 : elt -> arr -> arr

  val sub_scalar0 : elt -> arr -> arr

  val mul_scalar0 : elt -> arr -> arr

  val div_scalar0 : elt -> arr -> arr

end


module Make_Basic
  (P : PackSig)
  (M : BasicSig with type arr := P.arr and type elt := P.elt)
  = struct

  open P

  let empty i = M.empty i |> pack_box

  let create i a = M.create i (unpack_elt a) |> pack_box

  let zeros i = M.zeros i |> pack_box

  let ones i = M.ones i |> pack_box

  let uniform ?scale i = M.uniform ?scale i |> pack_box

  let sequential i = M.sequential i |> pack_box

  let linspace a b n = M.linspace a b n |> pack_box

  let logspace ?base a b n = M.logspace a b n |> pack_box


  let shape x = M.shape (unpack_box x)

  let num_dims x = M.num_dims (unpack_box x)

  let nth_dim x = M.nth_dim (unpack_box x)

  let numel x = M.numel (unpack_box x)

  let nnz x = M.nnz (unpack_box x)

  let density x = M.density (unpack_box x)

  let size_in_bytes x = M.size_in_bytes (unpack_box x)

  let same_shape x = M.same_shape (unpack_box x)


  let get x i = M.get (unpack_box x) i |> pack_elt

  let set x i a = M.set (unpack_box x) i (unpack_elt a)

  let sub_left x s l = M.sub_left (unpack_box x) s l |> pack_box

  let slice_left x i = M.slice_left (unpack_box x) i |> pack_box

  let slice axis x = M.slice axis (unpack_box x) |> pack_box

  let copy src dst = M.copy (unpack_box src) (unpack_box dst)

  let fill x a = M.fill (unpack_box x) (unpack_elt a)

  let clone x = M.clone (unpack_box x) |> pack_box

  let reshape x s = M.reshape (unpack_box x) s |> pack_box

  let flatten x = M.flatten (unpack_box x) |> pack_box

  let reverse x = M.reverse (unpack_box x) |> pack_box

  let transpose ?axis x = M.transpose ?axis (unpack_box x) |> pack_box

  let swap a0 a1 x = M.swap a0 a1 (unpack_box x) |> pack_box

  let tile x reps = M.tile (unpack_box x) reps

  let repeat ?axis x reps = M.repeat ?axis (unpack_box x) reps

  let squeeze ?(axis=[||]) x = M.squeeze ~axis (unpack_box x) |> pack_box


  let iteri ?axis f x = M.iteri ?axis f (unpack_box x)

  let iter ?axis f x = M.iter ?axis f (unpack_box x)

  let mapi ?axis f x = M.mapi ?axis f (unpack_box x) |> pack_box

  let map f x = M.map f (unpack_box x) |> pack_box

  let map2i ?axis f x y = M.map2i ?axis f (unpack_box x) (unpack_box y) |> pack_box

  let map2 f x y = M.map2i f (unpack_box x) (unpack_box y) |> pack_box

  let filteri ?axis f x = M.filteri ?axis f (unpack_box x)

  let filter f x = M.filter f (unpack_box x)

  let foldi ?axis f a x = M.foldi ?axis f a (unpack_box x)

  let fold f a x = M.fold f a (unpack_box x)

  let iteri_slice axis f x = M.iteri_slice axis f (unpack_box x)

  let iter_slice axis f x = M.iter_slice axis f (unpack_box x)

  let iter2i f x y = M.iter2i f (unpack_box x) (unpack_box y)

  let iter2 f x y = M.iter2 f (unpack_box x) (unpack_box y)


  let exists f x = M.exists f (unpack_box x)

  let not_exists f x = M.not_exists f (unpack_box x)

  let for_all f x = M.for_all f (unpack_box x)

  let is_zero x = M.is_zero (unpack_box x)

  let is_positive x = M.is_positive (unpack_box x)

  let is_negative x = M.is_negative (unpack_box x)

  let is_nonpositive x = M.is_nonpositive (unpack_box x)

  let is_nonnegative x = M.is_nonnegative (unpack_box x)


  let equal x y = M.equal (unpack_box x) (unpack_box y)

  let not_equal x y = M.not_equal (unpack_box x) (unpack_box y)

  let greater x y = M.greater (unpack_box x) (unpack_box y)

  let less x y = M.less (unpack_box x) (unpack_box y)

  let greater_equal x y = M.greater_equal (unpack_box x) (unpack_box y)

  let less_equal x y = M.less_equal (unpack_box x) (unpack_box y)

  let elt_equal x y = M.elt_equal (unpack_box x) (unpack_box y) |> pack_box

  let elt_not_equal x y = M.elt_not_equal (unpack_box x) (unpack_box y) |> pack_box

  let elt_less x y = M.elt_less (unpack_box x) (unpack_box y) |> pack_box

  let elt_greater x y = M.elt_greater (unpack_box x) (unpack_box y) |> pack_box

  let elt_less_equal x y = M.elt_less_equal (unpack_box x) (unpack_box y) |> pack_box

  let elt_greater_equal x y = M.elt_greater_equal (unpack_box x) (unpack_box y) |> pack_box


  let print x = M.print (unpack_box x)

  let save x f = M.save (unpack_box x) f

  let load f = M.load f |> pack_box


  let add x y = M.add (unpack_box x) (unpack_box y) |> pack_box

  let sub x y = M.sub (unpack_box x) (unpack_box y) |> pack_box

  let mul x y = M.mul (unpack_box x) (unpack_box y) |> pack_box

  let div x y = M.div (unpack_box x) (unpack_box y) |> pack_box

  let add_scalar x a = M.add_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let sub_scalar x a = M.sub_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let mul_scalar x a = M.mul_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let div_scalar x a = M.div_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let add_scalar0 a x = M.add_scalar0 (unpack_elt a) (unpack_box x) |> pack_box

  let sub_scalar0 a x = M.sub_scalar0 (unpack_elt a) (unpack_box x) |> pack_box

  let mul_scalar0 a x = M.mul_scalar0 (unpack_elt a) (unpack_box x) |> pack_box

  let div_scalar0 a x = M.div_scalar0 (unpack_elt a) (unpack_box x) |> pack_box

end



(* matrix modules of four types *)

module S = Owl_ext_dense_ndarray_s

module D = Owl_ext_dense_ndarray_d

module C = Owl_ext_dense_ndarray_c

module Z = Owl_ext_dense_ndarray_z
