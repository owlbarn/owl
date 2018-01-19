(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

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
  val pack_cast_box : cast_arr -> ext_typ

end


module Pack_DAS = struct

  type arr = das
  type elt = float
  type cast_arr = das

  let pack_box x = DAS x
  let unpack_box = function DAS x -> x | _ -> failwith "Pack_DAS:unpack_das"
  let pack_elt x = F x
  let unpack_elt = function F x -> x | _ -> failwith "Pack_DAS:unpack_elt"
  let pack_cast_box x = DAS x

end


module Pack_DAD = struct

  type arr = dad
  type elt = float
  type cast_arr = dad

  let pack_box x = DAD x
  let unpack_box = function DAD x -> x | _ -> failwith "Pack_DAD:unpack_dad"
  let pack_elt x = F x
  let unpack_elt = function F x -> x | _ -> failwith "Pack_DAD:unpack_elt"
  let pack_cast_box x = DAD x

end


module Pack_DAC = struct

  type arr = dac
  type elt = Complex.t
  type cast_arr = das

  let pack_box x = DAC x
  let unpack_box = function DAC x -> x | _ -> failwith "Pack_DAC:unpack_dac"
  let pack_elt x = C x
  let unpack_elt = function C x -> x | _ -> failwith "Pack_DAC:unpack_elt"
  let pack_cast_box x = DAS x

end


module Pack_DAZ = struct

  type arr = daz
  type elt = Complex.t
  type cast_arr = dad

  let pack_box x = DAZ x
  let unpack_box = function DAZ x -> x | _ -> failwith "Pack_DAZ:unpack_daz"
  let pack_elt x = C x
  let unpack_elt = function C x -> x | _ -> failwith "Pack_DAZ:unpack_elt"
  let pack_cast_box x = DAD x

end


(* module for basic ndarray operations *)

module type BasicSig = sig

  type arr
  type elt

  val empty : int array -> arr

  val empty : int array -> arr

  val create : int array -> elt -> arr

  val zeros : int array -> arr

  val ones : int array -> arr

  val uniform : ?a:elt -> ?b:elt -> int array -> arr

  val sequential : ?a:elt -> ?step:elt -> int array -> arr

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

  val get_slice : index list -> arr -> arr

  val set_slice : index list -> arr -> arr -> unit

  val sub_left : arr -> int -> int -> arr

  val slice_left : arr -> int array -> arr

  val copy_to : arr -> arr -> unit

  val reset : arr -> unit

  val fill : arr -> elt -> unit

  val copy : arr -> arr

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

  val equal_scalar : arr -> elt -> bool

  val not_equal_scalar : arr -> elt -> bool

  val less_scalar : arr -> elt -> bool

  val greater_scalar : arr -> elt -> bool

  val less_equal_scalar : arr -> elt -> bool

  val greater_equal_scalar : arr -> elt -> bool

  val elt_equal_scalar : arr -> elt -> arr

  val elt_not_equal_scalar : arr -> elt -> arr

  val elt_less_scalar : arr -> elt -> arr

  val elt_greater_scalar : arr -> elt -> arr

  val elt_less_equal_scalar : arr -> elt -> arr

  val elt_greater_equal_scalar : arr -> elt -> arr


  val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:(elt -> string) -> arr -> unit

  val save : arr -> string -> unit

  val load : string -> arr


  val sum' : arr -> elt

  val prod' : arr -> elt

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

  let uniform ?a ?b i = M.uniform ?a ?b i |> pack_box

  let sequential ?a ?step i = M.sequential ?a ?step i |> pack_box

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

  let get_slice axis x = M.get_slice axis (unpack_box x) |> pack_box

  let set_slice axis x y = M.set_slice axis (unpack_box x) (unpack_box y)

  let sub_left x s l = M.sub_left (unpack_box x) s l |> pack_box

  let slice_left x i = M.slice_left (unpack_box x) i |> pack_box

  let copy_to src dst = M.copy_to (unpack_box src) (unpack_box dst)

  let fill x a = M.fill (unpack_box x) (unpack_elt a)

  let copy x = M.copy (unpack_box x) |> pack_box

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

  let equal_scalar x a = M.equal_scalar (unpack_box x) (unpack_elt a)

  let not_equal_scalar x a = M.not_equal_scalar (unpack_box x) (unpack_elt a)

  let less_scalar x a = M.less_scalar (unpack_box x) (unpack_elt a)

  let greater_scalar x a = M.greater_scalar (unpack_box x) (unpack_elt a)

  let less_equal_scalar x a = M.less_equal_scalar (unpack_box x) (unpack_elt a)

  let greater_equal_scalar x a = M.greater_equal_scalar (unpack_box x) (unpack_elt a)

  let elt_equal_scalar x a = M.elt_equal_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let elt_not_equal_scalar x a = M.elt_not_equal_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let elt_less_scalar x a = M.elt_less_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let elt_greater_scalar x a = M.elt_greater_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let elt_less_equal_scalar x a = M.elt_less_equal_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let elt_greater_equal_scalar x a = M.elt_greater_equal_scalar (unpack_box x) (unpack_elt a) |> pack_box


  let print x = M.print (unpack_box x)

  let save x f = M.save (unpack_box x) f

  let load f = M.load f |> pack_box


  let sum' x = M.sum' (unpack_box x) |> pack_elt

  let prod' x = M.prod' (unpack_box x) |> pack_elt

  let add x y = M.add (unpack_box x) (unpack_box y) |> pack_box

  let sub x y = M.sub (unpack_box x) (unpack_box y) |> pack_box

  let mul x y = M.mul (unpack_box x) (unpack_box y) |> pack_box

  let div x y = M.div (unpack_box x) (unpack_box y) |> pack_box

  let add_scalar x a = M.add_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let sub_scalar x a = M.sub_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let mul_scalar x a = M.mul_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let div_scalar x a = M.div_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let scalar_add a x = M.scalar_add (unpack_elt a) (unpack_box x) |> pack_box

  let scalar_sub a x = M.scalar_sub (unpack_elt a) (unpack_box x) |> pack_box

  let scalar_mul a x = M.scalar_mul (unpack_elt a) (unpack_box x) |> pack_box

  let scalar_div a x = M.scalar_div (unpack_elt a) (unpack_box x) |> pack_box

end


(* module for float32 and float64 ndarray *)

module type SD_Sig = sig

  type arr
  type elt

  val min' : arr -> elt

  val max' : arr -> elt

  val minmax' : arr -> elt * elt

  val min_i : arr -> elt * int array

  val max_i : arr -> elt * int array

  val minmax_i : arr -> (elt * (int array)) * (elt * (int array))

  val abs : arr -> arr

  val abs2 : arr -> arr

  val neg : arr -> arr

  val reci : arr -> arr

  val signum : arr -> arr

  val sqr : arr -> arr

  val sqrt : arr -> arr

  val cbrt : arr -> arr

  val exp : arr -> arr

  val exp2 : arr -> arr

  val expm1 : arr -> arr

  val log : arr -> arr

  val log10 : arr -> arr

  val log2 : arr -> arr

  val log1p : arr -> arr

  val sin : arr -> arr

  val cos : arr -> arr

  val tan : arr -> arr

  val asin : arr -> arr

  val acos : arr -> arr

  val atan : arr -> arr

  val sinh : arr -> arr

  val cosh : arr -> arr

  val tanh : arr -> arr

  val asinh : arr -> arr

  val acosh : arr -> arr

  val atanh : arr -> arr

  val floor : arr -> arr

  val ceil : arr -> arr

  val round : arr -> arr

  val trunc : arr -> arr

  val erf : arr -> arr

  val erfc : arr -> arr

  val logistic : arr -> arr

  val relu : arr -> arr

  val softplus : arr -> arr

  val softsign : arr -> arr

  val softmax : arr -> arr

  val sigmoid : arr -> arr

  val log_sum_exp' : arr -> elt

  val l1norm' : arr -> elt

  val l2norm' : arr -> elt

  val l2norm_sqr' : arr -> elt

  val pow : arr -> arr -> arr

  val scalar_pow : elt -> arr -> arr

  val pow_scalar : arr -> elt -> arr

  val atan2 : arr -> arr -> arr

  val scalar_atan2 : elt -> arr -> arr

  val atan2_scalar : arr -> elt -> arr

  val hypot : arr -> arr -> arr

  val min2 : arr -> arr -> arr

  val max2 : arr -> arr -> arr

  val fmod : arr -> arr -> arr

  val fmod_scalar : arr -> elt -> arr

  val scalar_fmod : elt -> arr -> arr

  val ssqr' : arr -> elt -> elt

  val ssqr_diff' : arr -> arr -> elt

  val cross_entropy' : arr -> arr -> elt

end


module Make_SD
  (P : PackSig)
  (M : SD_Sig with type arr := P.arr and type elt := P.elt)
  = struct

  open P

  let min' x = M.min' (unpack_box x) |> pack_elt

  let max' x = M.max' (unpack_box x) |> pack_elt

  let minmax' x = let a, b = M.minmax' (unpack_box x) in (pack_elt a, pack_elt b)

  let min_i x = let a, i = M.min_i (unpack_box x) in (pack_elt a, i)

  let max_i x = let a, i = M.max_i (unpack_box x) in (pack_elt a, i)

  let minmax_i x = let (a,i), (b,j) = M.minmax_i (unpack_box x) in (pack_elt a,i), (pack_elt b, i)

  let abs x = M.abs (unpack_box x) |> pack_box

  let abs2 x = M.abs2 (unpack_box x) |> pack_box

  let neg x = M.neg (unpack_box x) |> pack_box

  let reci x = M.reci (unpack_box x) |> pack_box

  let signum x = M.signum (unpack_box x) |> pack_box

  let sqr x = M.sqr (unpack_box x) |> pack_box

  let sqrt x = M.sqrt (unpack_box x) |> pack_box

  let cbrt x = M.cbrt (unpack_box x) |> pack_box

  let exp x = M.exp (unpack_box x) |> pack_box

  let exp2 x = M.exp2 (unpack_box x) |> pack_box

  let expm1 x = M.expm1 (unpack_box x) |> pack_box

  let log x = M.log (unpack_box x) |> pack_box

  let log10 x = M.log10 (unpack_box x) |> pack_box

  let log2 x = M.log2 (unpack_box x) |> pack_box

  let log1p x = M.log1p (unpack_box x) |> pack_box

  let sin x = M.sin (unpack_box x) |> pack_box

  let cos x = M.cos (unpack_box x) |> pack_box

  let tan x = M.tan (unpack_box x) |> pack_box

  let asin x = M.asin (unpack_box x) |> pack_box

  let acos x = M.acos (unpack_box x) |> pack_box

  let atan x = M.atan (unpack_box x) |> pack_box

  let sinh x = M.sinh (unpack_box x) |> pack_box

  let cosh x = M.cosh (unpack_box x) |> pack_box

  let tanh x = M.tanh (unpack_box x) |> pack_box

  let asinh x = M.asinh (unpack_box x) |> pack_box

  let acosh x = M.acosh (unpack_box x) |> pack_box

  let atanh x = M.atanh (unpack_box x) |> pack_box

  let floor x = M.floor (unpack_box x) |> pack_box

  let ceil x = M.ceil (unpack_box x) |> pack_box

  let round x = M.round (unpack_box x) |> pack_box

  let trunc x = M.trunc (unpack_box x) |> pack_box

  let erf x = M.erf (unpack_box x) |> pack_box

  let erfc x = M.erfc (unpack_box x) |> pack_box

  let logistic x = M.logistic (unpack_box x) |> pack_box

  let relu x = M.relu (unpack_box x) |> pack_box

  let softplus x = M.softplus (unpack_box x) |> pack_box

  let softsign x = M.softsign (unpack_box x) |> pack_box

  let softmax x = M.softmax (unpack_box x) |> pack_box

  let sigmoid x = M.sigmoid (unpack_box x) |> pack_box

  let log_sum_exp' x = M.log_sum_exp' (unpack_box x) |> pack_elt

  let l1norm' x = M.l1norm' (unpack_box x) |> pack_elt

  let l2norm' x = M.l2norm' (unpack_box x) |> pack_elt

  let l2norm_sqr' x = M.l2norm_sqr' (unpack_box x) |> pack_elt


  let pow x y = M.pow (unpack_box x) (unpack_box y) |> pack_box

  let scalar_pow a x = M.scalar_pow (unpack_elt a) (unpack_box x) |> pack_box

  let pow_scalar x a = M.pow_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let atan2 x y = M.atan2 (unpack_box x) (unpack_box y) |> pack_box

  let scalar_atan2 a x = M.scalar_atan2 (unpack_elt a) (unpack_box x) |> pack_box

  let atan2_scalar x a = M.atan2_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let hypot x y = M.hypot (unpack_box x) (unpack_box y) |> pack_box

  let min2 x y = M.min2 (unpack_box x) (unpack_box y) |> pack_box

  let max2 x y = M.max2 (unpack_box x) (unpack_box y) |> pack_box

  let fmod x y = M.fmod (unpack_box x) (unpack_box y) |> pack_box

  let fmod_scalar x a = M.fmod_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let scalar_fmod a x = M.scalar_fmod (unpack_elt a) (unpack_box x) |> pack_box

  let ssqr' x a = M.ssqr' (unpack_box x) (unpack_elt a) |> pack_elt

  let ssqr_diff' x y = M.ssqr_diff' (unpack_box x) (unpack_box y) |> pack_elt

  let cross_entropy' x y = M.cross_entropy' (unpack_box x) (unpack_box y) |> pack_elt

end


(* module for complex32 and complex64 ndarray *)

module type CZ_Sig = sig

  type arr
  type elt
  type cast_arr

  val re : arr -> cast_arr

  val im : arr -> cast_arr

  val sum' : arr -> elt

  val prod' : arr -> elt

  val abs : arr -> arr

  val abs2 : arr -> arr

  val conj : arr -> arr

  val neg : arr -> arr

  val reci : arr -> arr

  val l1norm' : arr -> elt

  val l2norm' : arr -> elt

  val l2norm_sqr' : arr -> elt

  val ssqr' : arr -> elt -> elt

  val ssqr_diff' : arr -> arr -> elt

end


module Make_CZ
  (P : PackSig)
  (M : CZ_Sig with type arr := P.arr and type elt := P.elt and type cast_arr := P.cast_arr)
  = struct

  open P

  let re x = M.re (unpack_box x) |> pack_cast_box

  let im x = M.im (unpack_box x) |> pack_cast_box

  let abs x = M.abs (unpack_box x) |> pack_box

  let abs2 x = M.abs2 (unpack_box x) |> pack_box

  let conj x = M.conj (unpack_box x) |> pack_box

  let sum' x = M.sum' (unpack_box x) |> pack_elt

  let prod' x = M.prod' (unpack_box x) |> pack_elt

  let neg x = M.neg (unpack_box x) |> pack_box

  let reci x = M.reci (unpack_box x) |> pack_box

  let l1norm' x = M.l1norm' (unpack_box x) |> pack_elt

  let l2norm' x = M.l2norm' (unpack_box x) |> pack_elt

  let l2norm_sqr' x = M.l2norm_sqr' (unpack_box x) |> pack_elt

  let ssqr' x a = M.ssqr' (unpack_box x) (unpack_elt a) |> pack_elt

  let ssqr_diff' x y = M.ssqr_diff' (unpack_box x) (unpack_box y) |> pack_elt

end


(* ndarray modules of four types *)

module S = struct
  include Make_Basic (Pack_DAS) (Owl_dense_ndarray.S)
  include Make_SD (Pack_DAS) (Owl_dense_ndarray.S)
end


module D = struct
  include Make_Basic (Pack_DAD) (Owl_dense_ndarray.D)
  include Make_SD (Pack_DAD) (Owl_dense_ndarray.D)
end


module C = struct
  include Make_Basic (Pack_DAC) (Owl_dense_ndarray.C)
  include Make_CZ (Pack_DAC) (Owl_dense_ndarray.C)
end


module Z = struct
  include Make_Basic (Pack_DAZ) (Owl_dense_ndarray.Z)
  include Make_CZ (Pack_DAZ) (Owl_dense_ndarray.Z)
end
