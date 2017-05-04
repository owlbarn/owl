(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_ext_types

(* modules for packing and unpacking *)

module type PackSig = sig

  type mat
  type elt
  type cast_mat

  val pack_box      : mat -> ext_typ
  val unpack_box    : ext_typ -> mat
  val pack_elt      : elt -> ext_typ
  val unpack_elt    : ext_typ -> elt
  val pack_cast_box : cast_mat -> ext_typ

end


module Pack_DMS = struct

  type mat = dms
  type elt = float
  type cast_mat = dms

  let pack_box x = DMS x
  let unpack_box = function DMS x -> x | _ -> failwith "Pack_DMS:unpack_box"
  let pack_elt x = F x
  let unpack_elt = function F x -> x | _ -> failwith "Pack_DMS:unpack_elt"
  let pack_cast_box x = DMS x

end


module Pack_DMD = struct

  type mat = dmd
  type elt = float
  type cast_mat = dmd

  let pack_box x = DMD x
  let unpack_box = function DMD x -> x | _ -> failwith "Pack_DMD:unpack_dmd:"
  let pack_elt x = F x
  let unpack_elt = function F x -> x | _ -> failwith "Pack_DMD:unpack_elt"
  let pack_cast_box x = DMD x

end


module Pack_DMC = struct

  type mat = dmc
  type elt = Complex.t
  type cast_mat = dms

  let pack_box x = DMC x
  let unpack_box = function DMC x -> x | _ -> failwith "Pack_DMC:unpack_dmc"
  let pack_elt x = C x
  let unpack_elt = function C x -> x | _ -> failwith "Pack_DMC:unpack_elt"
  let pack_cast_box x = DMS x

end


module Pack_DMZ = struct

  type mat = dmz
  type elt = Complex.t
  type cast_mat = dmd

  let pack_box x = DMZ x
  let unpack_box = function DMZ x -> x | _ -> failwith "Pack_DMZ:unpack_dmz"
  let pack_elt x = C x
  let unpack_elt = function C x -> x | _ -> failwith "Pack_DMZ:unpack_elt"
  let pack_cast_box x = DMD x

end


(* module for basic matrix operations *)

module type BasicSig = sig

  type mat
  type elt

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

  val shape : mat -> int * int

  val row_num : mat -> int

  val col_num : mat -> int

  val numel : mat -> int

  val nnz : mat -> int

  val density : mat -> float

  val size_in_bytes : mat -> int

  val same_shape : mat -> mat -> bool

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


  val draw_rows : ?replacement:bool -> mat -> int -> mat * int array

  val draw_cols : ?replacement:bool -> mat -> int -> mat * int array

  val draw_rows2 : ?replacement:bool -> mat -> mat -> int -> mat * mat * int array

  val draw_cols2 : ?replacement:bool -> mat -> mat -> int -> mat * mat * int array

  val shuffle_rows : mat -> mat

  val shuffle_cols : mat -> mat

  val shuffle: mat -> mat


  val to_array : mat -> elt array

  val of_array : elt array -> int -> int -> mat

  val to_arrays : mat -> elt array array

  val of_arrays : elt array array -> mat

  val to_rows : mat -> mat array

  val of_rows : mat array -> mat

  val to_cols : mat -> mat array

  val of_cols : mat array -> mat

  val print : mat -> unit

  val pp_dsmat : mat -> unit

  val save : mat -> string -> unit

  val load : string -> mat


  val trace : mat -> elt

  val sum : mat -> elt

  val prod : mat -> elt

  val average : mat -> elt

  val sum_rows : mat -> mat

  val sum_cols : mat -> mat

  val average_rows : mat -> mat

  val average_cols : mat -> mat


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

end


module Make_Basic
  (P : PackSig)
  (M : BasicSig with type mat := P.mat and type elt := P.elt)
  = struct

  open P

  let empty m n = M.empty m n |> pack_box

  let zeros m n = M.zeros m n |> pack_box

  let ones m n = M.ones m n |> pack_box

  let eye m = M.eye m |> pack_box

  let sequential m n = M.sequential m n |> pack_box

  let uniform ?(scale=1.) m n = M.uniform ~scale m n |> pack_box

  let gaussian ?(sigma=1.) m n = M.gaussian ~sigma m n |> pack_box

  let linspace a b n = M.linspace a b n |> pack_box

  let meshgrid xa xb ya yb xn yn = let u, v = M.meshgrid xa xb ya yb xn yn in (pack_box u, pack_box v)

  let meshup x y = let u, v = M.meshup (unpack_box x) (unpack_box y) in (pack_box u, pack_box v)


  let shape x = M.shape (unpack_box x)

  let row_num x = M.row_num (unpack_box x)

  let col_num x = M.col_num (unpack_box x)

  let numel x = M.numel (unpack_box x)

  let nnz x = M.nnz (unpack_box x)

  let density x = M.density (unpack_box x)

  let size_in_bytes x = M.size_in_bytes (unpack_box x)

  let same_shape x y = M.same_shape (unpack_box x) (unpack_box y)


  let get x i j = M.get (unpack_box x) i j |> pack_elt

  let set x i j a = M.set (unpack_box x) i j (unpack_elt a)

  let row x i = M.row (unpack_box x) i |> pack_box

  let col x j = M.col (unpack_box x) j |> pack_box

  let rows x l = M.rows (unpack_box x) l |> pack_box

  let cols x l = M.cols (unpack_box x) l |> pack_box

  let reshape m n x = M.reshape m n (unpack_box x) |> pack_box

  let flatten x = M.flatten (unpack_box x) |> pack_box

  let slice axis x = M.slice axis (unpack_box x) |> pack_box

  let reverse x = M.reverse (unpack_box x) |> pack_box

  let fill x a = M.fill (unpack_box x) (unpack_elt a)

  let clone x = M.clone (unpack_box x) |> pack_box

  let copy_to src dst = M.copy_to (unpack_box src) (unpack_box dst)

  let copy_row_to v x i = M.copy_row_to (unpack_box v) (unpack_box x) i

  let copy_col_to v x i = M.copy_col_to (unpack_box v) (unpack_box x) i

  let concat_vertical x y = M.concat_vertical (unpack_box x) (unpack_box y) |> pack_box

  let concat_horizontal x y = M.concat_horizontal (unpack_box x) (unpack_box y) |> pack_box

  let transpose x = M.transpose (unpack_box x) |> pack_box

  let diag x = M.diag (unpack_box x) |> pack_box

  let replace_row v x i = M.replace_row (unpack_box v) (unpack_box x) i |> pack_box

  let replace_col v x i = M.replace_col (unpack_box v) (unpack_box x) i |> pack_box

  let swap_rows x i i' = M.swap_rows (unpack_box x) i i'

  let swap_cols x j j' = M.swap_cols (unpack_box x) j j'

  let tile x reps = M.tile (unpack_box x) reps |> pack_box

  let repeat ?axis x reps = M.repeat ?axis (unpack_box x) reps |> pack_box


  let iteri f x = M.iteri f (unpack_box x)

  let iter f x = M.iter f (unpack_box x)

  let mapi f x = M.mapi f (unpack_box x) |> pack_box

  let map f x = M.mapi f (unpack_box x) |> pack_box

  let map2i f x y = M.map2i f (unpack_box x) (unpack_box y) |> pack_box

  let map2 f x y = M.map2 f (unpack_box x) (unpack_box y) |> pack_box

  let foldi f a x = M.foldi f a (unpack_box x)

  let fold f a x = M.fold f a (unpack_box x)

  let filteri f x = M.filteri f (unpack_box x)

  let filter f x = M.filter f (unpack_box x)

  let iteri_rows f x = M.iteri_rows f (unpack_box x)

  let iter_rows f x = M.iter_rows f (unpack_box x)

  let iteri_cols f x = M.iteri_cols f (unpack_box x)

  let iter_cols f x = M.iter_cols f (unpack_box x)

  let filteri_rows f x = M.filteri_rows f (unpack_box x)

  let filter_rows f x = M.filter_rows f (unpack_box x)

  let filteri_cols f x = M.filteri_cols f (unpack_box x)

  let filter_cols f x = M.filter_cols f (unpack_box x)

  let fold_rows f a x = M.fold_rows f a (unpack_box x)

  let fold_cols f a x = M.fold_cols f a (unpack_box x)

  let mapi_rows f x = M.mapi_rows f (unpack_box x)

  let map_rows f x = M.map_rows f (unpack_box x)

  let mapi_cols f x = M.mapi_cols f (unpack_box x)

  let map_cols f x = M.map_cols f (unpack_box x)

  let mapi_by_row d f x = M.mapi_by_row d f (unpack_box x) |> pack_box

  let map_by_row d f x = M.map_by_row d f (unpack_box x) |> pack_box

  let mapi_by_col d f x = M.mapi_by_col d f (unpack_box x) |> pack_box

  let map_by_col d f x = M.map_by_col d f (unpack_box x) |> pack_box

  let mapi_at_row f x i = M.mapi_at_row f (unpack_box x) i |> pack_box

  let map_at_row f x i = M.map_at_row f (unpack_box x) i |> pack_box

  let mapi_at_col f x j = M.mapi_at_col f (unpack_box x) j |> pack_box

  let map_at_col f x j = M.map_at_col f (unpack_box x) j |> pack_box


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


  let draw_rows ?(replacement=true) x c = let r, i = M.draw_rows ~replacement (unpack_box x) c in (pack_box r), i

  let draw_cols ?(replacement=true) x c = let r, i = M.draw_cols ~replacement (unpack_box x) c in (pack_box r), i

  let shuffle_rows x = M.shuffle_rows (unpack_box x)

  let shuffle_cols x = M.shuffle_cols (unpack_box x)

  let shuffle x = M.shuffle (unpack_box x)


  let to_array x = M.to_array (unpack_box x)

  let of_array x m n = M.of_array x m n |> pack_box

  let to_arrays x = M.to_arrays (unpack_box x)

  let of_arrays x = M.of_arrays x |> pack_box

  let print x = M.print (unpack_box x)

  let pp_dsmat x = M.pp_dsmat (unpack_box x)

  let save x f = M.save (unpack_box x) f

  let load f = M.load f |> pack_box


  let trace x = M.trace (unpack_box x) |> pack_elt

  let sum x = M.sum (unpack_box x) |> pack_elt

  let prod x = M.prod (unpack_box x) |> pack_elt

  let average x = M.average (unpack_box x) |> pack_elt

  let sum_rows x = M.sum_rows (unpack_box x) |> pack_box

  let sum_cols x = M.sum_rows (unpack_box x) |> pack_box

  let average_rows x = M.sum_rows (unpack_box x) |> pack_box

  let average_cols x = M.sum_rows (unpack_box x) |> pack_box


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

  let dot x y = M.dot (unpack_box x) (unpack_box y) |> pack_box

end


(* module for float32 and float64 matrices *)

module type SD_Sig = sig

  type mat
  type elt

  val min : mat -> elt

  val min : mat -> elt

  val max : mat -> elt

  val minmax : mat -> elt * elt

  val min_i : mat -> elt * int * int

  val max_i : mat -> elt * int * int

  val minmax_i : mat -> (elt * int * int) * (elt * int * int)

  val abs : mat -> mat

  val abs2 : mat -> mat

  val neg : mat -> mat

  val reci : mat -> mat

  val signum : mat -> mat

  val sqr : mat -> mat

  val sqrt : mat -> mat

  val cbrt : mat -> mat

  val exp : mat -> mat

  val exp2 : mat -> mat

  val expm1 : mat -> mat

  val log : mat -> mat

  val log10 : mat -> mat

  val log2 : mat -> mat

  val log1p : mat -> mat

  val sin : mat -> mat

  val cos : mat -> mat

  val tan : mat -> mat

  val asin : mat -> mat

  val acos : mat -> mat

  val atan : mat -> mat

  val sinh : mat -> mat

  val cosh : mat -> mat

  val tanh : mat -> mat

  val asinh : mat -> mat

  val acosh : mat -> mat

  val atanh : mat -> mat

  val floor : mat -> mat

  val ceil : mat -> mat

  val round : mat -> mat

  val trunc : mat -> mat

  val erf : mat -> mat

  val erfc : mat -> mat

  val logistic : mat -> mat

  val relu : mat -> mat

  val softplus : mat -> mat

  val softsign : mat -> mat

  val softmax : mat -> mat

  val sigmoid : mat -> mat

  val log_sum_exp : mat -> elt

  val l1norm : mat -> elt

  val l2norm : mat -> elt

  val l2norm_sqr : mat -> elt

  val pow : mat -> mat -> mat

  val pow0 : elt -> mat -> mat

  val pow1 : mat -> elt -> mat

  val atan2 : mat -> mat -> mat

  val atan20 : elt -> mat -> mat

  val atan21 : mat -> elt -> mat

  val hypot : mat -> mat -> mat

  val min2 : mat -> mat -> mat

  val max2 : mat -> mat -> mat

  val fmod : mat -> mat -> mat

  val fmod_scalar : mat -> elt -> mat

  val scalar_fmod : elt -> mat -> mat

  val ssqr : mat -> elt -> elt

  val ssqr_diff : mat -> mat -> elt

end


module Make_SD
  (P : PackSig)
  (M : SD_Sig with type mat := P.mat and type elt := P.elt)
  = struct

  open P

  let min x = M.min (unpack_box x) |> pack_elt

  let max x = M.max (unpack_box x) |> pack_elt

  let minmax x = let (a, b) = M.minmax (unpack_box x) in (pack_elt a, pack_elt b)

  let min_i x = let (a, i, j) = M.min_i (unpack_box x) in (pack_elt a, [|i;j|])

  let max_i x = let (a, i, j) = M.max_i (unpack_box x) in (pack_elt a, [|i;j|])

  let minmax_i x = let (a, i, j), (b, p, q) = M.minmax_i (unpack_box x) in (pack_elt a, [|i;j|]), (pack_elt b, [|p;q|])

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

  let log_sum_exp x = M.log_sum_exp (unpack_box x) |> pack_elt

  let l1norm x = M.l1norm (unpack_box x) |> pack_elt

  let l2norm x = M.l2norm (unpack_box x) |> pack_elt

  let l2norm_sqr x = M.l2norm_sqr (unpack_box x) |> pack_elt

  let pow x y = M.pow (unpack_box x) (unpack_box y) |> pack_box

  let pow0 a x = M.pow0 (unpack_elt a) (unpack_box x) |> pack_box

  let pow1 x a = M.pow1 (unpack_box x) (unpack_elt a) |> pack_box


  let atan2 x y = M.atan2 (unpack_box x) (unpack_box y) |> pack_box

  let atan20 a x = M.atan20 (unpack_elt a) (unpack_box x) |> pack_box

  let atan21 x a = M.atan21 (unpack_box x) (unpack_elt a) |> pack_box

  let hypot x y = M.hypot (unpack_box x) (unpack_box y) |> pack_box

  let min2 x y = M.min2 (unpack_box x) (unpack_box y) |> pack_box

  let max2 x y = M.max2 (unpack_box x) (unpack_box y) |> pack_box

  let fmod x y = M.fmod (unpack_box x) (unpack_box y) |> pack_box

  let fmod_scalar x a = M.fmod_scalar (unpack_box x) (unpack_elt a) |> pack_box

  let scalar_fmod a x = M.scalar_fmod (unpack_elt a) (unpack_box x) |> pack_box

  let ssqr x a = M.ssqr (unpack_box x) (unpack_elt a) |> pack_elt

  let ssqr_diff x y = M.ssqr_diff (unpack_box x) (unpack_box y) |> pack_elt

end


(* module for complex32 and complex64 matrices *)

module type CZ_Sig = sig

  type mat
  type elt
  type cast_mat

  val re : mat -> cast_mat

  val im : mat -> cast_mat

  val abs : mat -> cast_mat

  val abs2 : mat -> cast_mat

  val conj : mat -> mat

  val neg : mat -> mat

  val reci : mat -> mat

  val l1norm : mat -> float

  val l2norm : mat -> float

  val l2norm_sqr : mat -> float

  val ssqr : mat -> elt -> elt

  val ssqr_diff : mat -> mat -> elt

end


module Make_CZ
  (P : PackSig)
  (M : CZ_Sig with type mat := P.mat and type elt := P.elt and type cast_mat := P.cast_mat)
  = struct

  open P

  let pack_cast_elt x = F x

  let re x = M.re (unpack_box x) |> pack_cast_box

  let im x = M.im (unpack_box x) |> pack_cast_box

  let abs x = M.abs (unpack_box x) |> pack_cast_box

  let abs2 x = M.abs2 (unpack_box x) |> pack_cast_box

  let conj x = M.conj (unpack_box x) |> pack_box

  let neg x = M.neg (unpack_box x) |> pack_box

  let reci x = M.reci (unpack_box x) |> pack_box

  let l1norm x = M.l1norm (unpack_box x) |> pack_cast_elt

  let l2norm x = M.l2norm (unpack_box x) |> pack_cast_elt

  let l2norm_sqr x = M.l2norm_sqr (unpack_box x) |> pack_cast_elt

  let ssqr x a = M.ssqr (unpack_box x) (unpack_elt a) |> pack_elt

  let ssqr_diff x y = M.ssqr_diff (unpack_box x) (unpack_box y) |> pack_elt

end


(* matrix modules of four types *)

module S = struct
  include Make_Basic (Pack_DMS) (Owl_dense_matrix.S)
  include Make_SD (Pack_DMS) (Owl_dense_matrix.S)
end


module D = struct
  include Make_Basic (Pack_DMD) (Owl_dense_matrix.D)
  include Make_SD (Pack_DMD) (Owl_dense_matrix.D)
end


module C = struct
  include Make_Basic (Pack_DMC) (Owl_dense_matrix.C)
  include Make_CZ (Pack_DMC) (Owl_dense_matrix.C)
end


module Z = struct
  include Make_Basic (Pack_DMZ) (Owl_dense_matrix.Z)
  include Make_CZ (Pack_DMZ) (Owl_dense_matrix.Z)
end
