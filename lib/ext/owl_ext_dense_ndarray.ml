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


end



(* matrix modules of four types *)

module S = Owl_ext_dense_ndarray_s

module D = Owl_ext_dense_ndarray_d

module C = Owl_ext_dense_ndarray_c

module Z = Owl_ext_dense_ndarray_z
