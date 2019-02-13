(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Eigen_types

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) eigen_mat = ('a, 'b) spmat


(* interface to eigen functions *)

let _eigen_create : type a b . float -> (a, b) kind -> int -> int -> (a, b) eigen_mat =
  fun reserve k m n -> match k with
  | Float32   -> SPMAT_S (Eigen.Sparse.S.create ~reserve m n)
  | Float64   -> SPMAT_D (Eigen.Sparse.D.create ~reserve m n)
  | Complex32 -> SPMAT_C (Eigen.Sparse.C.create ~reserve m n)
  | Complex64 -> SPMAT_Z (Eigen.Sparse.Z.create ~reserve m n)
  | _         -> failwith "_eigen_create: unsupported operation"

let _eigen_eye : type a b . (a, b) kind -> int -> (a, b) eigen_mat =
  fun k m -> match k with
  | Float32   -> SPMAT_S (Eigen.Sparse.S.eye m)
  | Float64   -> SPMAT_D (Eigen.Sparse.D.eye m)
  | Complex32 -> SPMAT_C (Eigen.Sparse.C.eye m)
  | Complex64 -> SPMAT_Z (Eigen.Sparse.Z.eye m)
  | _         -> failwith "_eigen_create: unsupported operation"

let _eigen_nnz : type a b . (a, b) eigen_mat -> int =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.(prune x (Owl_const.zero Float32) 0.; nnz x)
  | SPMAT_D x -> Eigen.Sparse.D.(prune x (Owl_const.zero Float64) 0.; nnz x)
  | SPMAT_C x -> Eigen.Sparse.C.(prune x (Owl_const.zero Complex32) 0.; nnz x)
  | SPMAT_Z x -> Eigen.Sparse.Z.(prune x (Owl_const.zero Complex64) 0.; nnz x)

let _eigen_set : type a b . (a, b) eigen_mat -> int -> int -> a -> unit =
  fun x i j a -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.set x i j a
  | SPMAT_D x -> Eigen.Sparse.D.set x i j a
  | SPMAT_C x -> Eigen.Sparse.C.set x i j a
  | SPMAT_Z x -> Eigen.Sparse.Z.set x i j a

let _eigen_get : type a b . (a, b) eigen_mat -> int -> int -> a =
  fun x i j -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.get x i j
  | SPMAT_D x -> Eigen.Sparse.D.get x i j
  | SPMAT_C x -> Eigen.Sparse.C.get x i j
  | SPMAT_Z x -> Eigen.Sparse.Z.get x i j

let _eigen_insert : type a b . (a, b) eigen_mat -> int -> int -> a -> unit =
  fun x i j a -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.insert x i j a
  | SPMAT_D x -> Eigen.Sparse.D.insert x i j a
  | SPMAT_C x -> Eigen.Sparse.C.insert x i j a
  | SPMAT_Z x -> Eigen.Sparse.Z.insert x i j a

let _eigen_reset : type a b . (a, b) eigen_mat -> unit =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.reset x
  | SPMAT_D x -> Eigen.Sparse.D.reset x
  | SPMAT_C x -> Eigen.Sparse.C.reset x
  | SPMAT_Z x -> Eigen.Sparse.Z.reset x

let _eigen_copy : type a b . (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.clone x)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.clone x)
  | SPMAT_C x -> SPMAT_C (Eigen.Sparse.C.clone x)
  | SPMAT_Z x -> SPMAT_Z (Eigen.Sparse.Z.clone x)

let _eigen_transpose : type a b . (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.transpose x)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.transpose x)
  | SPMAT_C x -> SPMAT_C (Eigen.Sparse.C.transpose x)
  | SPMAT_Z x -> SPMAT_Z (Eigen.Sparse.Z.transpose x)

let _eigen_diagonal : type a b . (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.diagonal x)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.diagonal x)
  | SPMAT_C x -> SPMAT_C (Eigen.Sparse.C.diagonal x)
  | SPMAT_Z x -> SPMAT_Z (Eigen.Sparse.Z.diagonal x)

let _eigen_trace : type a b . (a, b) eigen_mat -> a =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.trace x
  | SPMAT_D x -> Eigen.Sparse.D.trace x
  | SPMAT_C x -> Eigen.Sparse.C.trace x
  | SPMAT_Z x -> Eigen.Sparse.Z.trace x

let _eigen_row : type a b . (a, b) eigen_mat -> int -> (a, b) eigen_mat =
  fun x i -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.row x i)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.row x i)
  | SPMAT_C x -> SPMAT_C (Eigen.Sparse.C.row x i)
  | SPMAT_Z x -> SPMAT_Z (Eigen.Sparse.Z.row x i)

let _eigen_col : type a b . (a, b) eigen_mat -> int -> (a, b) eigen_mat =
  fun x j -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.col x j)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.col x j)
  | SPMAT_C x -> SPMAT_C (Eigen.Sparse.C.col x j)
  | SPMAT_Z x -> SPMAT_Z (Eigen.Sparse.Z.col x j)

let _eigen_is_compressed : type a b . (a, b) eigen_mat -> bool =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.is_compressed x
  | SPMAT_D x -> Eigen.Sparse.D.is_compressed x
  | SPMAT_C x -> Eigen.Sparse.C.is_compressed x
  | SPMAT_Z x -> Eigen.Sparse.Z.is_compressed x

let _eigen_compress : type a b . (a, b) eigen_mat -> unit =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.compress x
  | SPMAT_D x -> Eigen.Sparse.D.compress x
  | SPMAT_C x -> Eigen.Sparse.C.compress x
  | SPMAT_Z x -> Eigen.Sparse.Z.compress x

let _eigen_uncompress : type a b . (a, b) eigen_mat -> unit =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.uncompress x
  | SPMAT_D x -> Eigen.Sparse.D.uncompress x
  | SPMAT_C x -> Eigen.Sparse.C.uncompress x
  | SPMAT_Z x -> Eigen.Sparse.Z.uncompress x

let _eigen_valueptr : type a b . (a, b) eigen_mat -> (a, b, c_layout) Array1.t =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.valueptr x
  | SPMAT_D x -> Eigen.Sparse.D.valueptr x
  | SPMAT_C x -> Eigen.Sparse.C.valueptr x
  | SPMAT_Z x -> Eigen.Sparse.Z.valueptr x

let _eigen_innerindexptr : type a b . (a, b) eigen_mat -> (int64, int64_elt, c_layout) Array1.t =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.innerindexptr x
  | SPMAT_D x -> Eigen.Sparse.D.innerindexptr x
  | SPMAT_C x -> Eigen.Sparse.C.innerindexptr x
  | SPMAT_Z x -> Eigen.Sparse.Z.innerindexptr x

let _eigen_outerindexptr : type a b . (a, b) eigen_mat -> (int64, int64_elt, c_layout) Array1.t =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.outerindexptr x
  | SPMAT_D x -> Eigen.Sparse.D.outerindexptr x
  | SPMAT_C x -> Eigen.Sparse.C.outerindexptr x
  | SPMAT_Z x -> Eigen.Sparse.Z.outerindexptr x

let _eigen_print : type a b . (a, b) eigen_mat -> unit =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.print x
  | SPMAT_D x -> Eigen.Sparse.D.print x
  | SPMAT_C x -> Eigen.Sparse.C.print x
  | SPMAT_Z x -> Eigen.Sparse.Z.print x

let _eigen_prune : type a b . (a, b) eigen_mat -> a -> float -> unit =
  fun x a b -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.prune x a b
  | SPMAT_D x -> Eigen.Sparse.D.prune x a b
  | SPMAT_C x -> Eigen.Sparse.C.prune x a b
  | SPMAT_Z x -> Eigen.Sparse.Z.prune x a b

let _eigen_is_zero : type a b . (a, b) eigen_mat -> bool =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.is_zero x
  | SPMAT_D x -> Eigen.Sparse.D.is_zero x
  | SPMAT_C x -> Eigen.Sparse.C.is_zero x
  | SPMAT_Z x -> Eigen.Sparse.Z.is_zero x

let _eigen_is_positive : type a b . (a, b) eigen_mat -> bool =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.is_positive x
  | SPMAT_D x -> Eigen.Sparse.D.is_positive x
  | SPMAT_C x -> Eigen.Sparse.C.is_positive x
  | SPMAT_Z x -> Eigen.Sparse.Z.is_positive x

let _eigen_is_negative : type a b . (a, b) eigen_mat -> bool =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.is_negative x
  | SPMAT_D x -> Eigen.Sparse.D.is_negative x
  | SPMAT_C x -> Eigen.Sparse.C.is_negative x
  | SPMAT_Z x -> Eigen.Sparse.Z.is_negative x

let _eigen_is_nonpositive : type a b . (a, b) eigen_mat -> bool =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.is_nonpositive x
  | SPMAT_D x -> Eigen.Sparse.D.is_nonpositive x
  | SPMAT_C x -> Eigen.Sparse.C.is_nonpositive x
  | SPMAT_Z x -> Eigen.Sparse.Z.is_nonpositive x

let _eigen_is_nonnegative : type a b . (a, b) eigen_mat -> bool =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.is_nonnegative x
  | SPMAT_D x -> Eigen.Sparse.D.is_nonnegative x
  | SPMAT_C x -> Eigen.Sparse.C.is_nonnegative x
  | SPMAT_Z x -> Eigen.Sparse.Z.is_nonnegative x

let _eigen_equal : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> bool =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> Eigen.Sparse.S.is_equal x y
  | SPMAT_D x, SPMAT_D y -> Eigen.Sparse.D.is_equal x y
  | SPMAT_C x, SPMAT_C y -> Eigen.Sparse.C.is_equal x y
  | SPMAT_Z x, SPMAT_Z y -> Eigen.Sparse.Z.is_equal x y

let _eigen_not_equal : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> bool =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> Eigen.Sparse.S.is_unequal x y
  | SPMAT_D x, SPMAT_D y -> Eigen.Sparse.D.is_unequal x y
  | SPMAT_C x, SPMAT_C y -> Eigen.Sparse.C.is_unequal x y
  | SPMAT_Z x, SPMAT_Z y -> Eigen.Sparse.Z.is_unequal x y

let _eigen_greater : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> bool =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> Eigen.Sparse.S.is_greater x y
  | SPMAT_D x, SPMAT_D y -> Eigen.Sparse.D.is_greater x y
  | SPMAT_C x, SPMAT_C y -> Eigen.Sparse.C.is_greater x y
  | SPMAT_Z x, SPMAT_Z y -> Eigen.Sparse.Z.is_greater x y

let _eigen_less : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> bool =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> Eigen.Sparse.S.is_smaller x y
  | SPMAT_D x, SPMAT_D y -> Eigen.Sparse.D.is_smaller x y
  | SPMAT_C x, SPMAT_C y -> Eigen.Sparse.C.is_smaller x y
  | SPMAT_Z x, SPMAT_Z y -> Eigen.Sparse.Z.is_smaller x y

let _eigen_greater_equal : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> bool =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> Eigen.Sparse.S.equal_or_greater x y
  | SPMAT_D x, SPMAT_D y -> Eigen.Sparse.D.equal_or_greater x y
  | SPMAT_C x, SPMAT_C y -> Eigen.Sparse.C.equal_or_greater x y
  | SPMAT_Z x, SPMAT_Z y -> Eigen.Sparse.Z.equal_or_greater x y

let _eigen_less_equal : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> bool =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> Eigen.Sparse.S.equal_or_smaller x y
  | SPMAT_D x, SPMAT_D y -> Eigen.Sparse.D.equal_or_smaller x y
  | SPMAT_C x, SPMAT_C y -> Eigen.Sparse.C.equal_or_smaller x y
  | SPMAT_Z x, SPMAT_Z y -> Eigen.Sparse.Z.equal_or_smaller x y

let _eigen_add : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> SPMAT_S (Eigen.Sparse.S.add x y)
  | SPMAT_D x, SPMAT_D y -> SPMAT_D (Eigen.Sparse.D.add x y)
  | SPMAT_C x, SPMAT_C y -> SPMAT_C (Eigen.Sparse.C.add x y)
  | SPMAT_Z x, SPMAT_Z y -> SPMAT_Z (Eigen.Sparse.Z.add x y)

let _eigen_sub : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> SPMAT_S (Eigen.Sparse.S.sub x y)
  | SPMAT_D x, SPMAT_D y -> SPMAT_D (Eigen.Sparse.D.sub x y)
  | SPMAT_C x, SPMAT_C y -> SPMAT_C (Eigen.Sparse.C.sub x y)
  | SPMAT_Z x, SPMAT_Z y -> SPMAT_Z (Eigen.Sparse.Z.sub x y)

let _eigen_mul : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> SPMAT_S (Eigen.Sparse.S.mul x y)
  | SPMAT_D x, SPMAT_D y -> SPMAT_D (Eigen.Sparse.D.mul x y)
  | SPMAT_C x, SPMAT_C y -> SPMAT_C (Eigen.Sparse.C.mul x y)
  | SPMAT_Z x, SPMAT_Z y -> SPMAT_Z (Eigen.Sparse.Z.mul x y)

let _eigen_div : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> SPMAT_S (Eigen.Sparse.S.div x y)
  | SPMAT_D x, SPMAT_D y -> SPMAT_D (Eigen.Sparse.D.div x y)
  | SPMAT_C x, SPMAT_C y -> SPMAT_C (Eigen.Sparse.C.div x y)
  | SPMAT_Z x, SPMAT_Z y -> SPMAT_Z (Eigen.Sparse.Z.div x y)

let _eigen_gemm : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> SPMAT_S (Eigen.Sparse.S.gemm x y)
  | SPMAT_D x, SPMAT_D y -> SPMAT_D (Eigen.Sparse.D.gemm x y)
  | SPMAT_C x, SPMAT_C y -> SPMAT_C (Eigen.Sparse.C.gemm x y)
  | SPMAT_Z x, SPMAT_Z y -> SPMAT_Z (Eigen.Sparse.Z.gemm x y)

let _eigen_add_scalar : type a b . (a, b) eigen_mat -> a -> (a, b) eigen_mat =
  fun x a -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.add_scalar x a)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.add_scalar x a)
  | SPMAT_C x -> SPMAT_C (Eigen.Sparse.C.add_scalar x a)
  | SPMAT_Z x -> SPMAT_Z (Eigen.Sparse.Z.add_scalar x a)

let _eigen_sub_scalar : type a b . (a, b) eigen_mat -> a -> (a, b) eigen_mat =
  fun x a -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.sub_scalar x a)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.sub_scalar x a)
  | SPMAT_C x -> SPMAT_C (Eigen.Sparse.C.sub_scalar x a)
  | SPMAT_Z x -> SPMAT_Z (Eigen.Sparse.Z.sub_scalar x a)

let _eigen_mul_scalar : type a b . (a, b) eigen_mat -> a -> (a, b) eigen_mat =
  fun x a -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.mul_scalar x a)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.mul_scalar x a)
  | SPMAT_C x -> SPMAT_C (Eigen.Sparse.C.mul_scalar x a)
  | SPMAT_Z x -> SPMAT_Z (Eigen.Sparse.Z.mul_scalar x a)

let _eigen_div_scalar : type a b . (a, b) eigen_mat -> a -> (a, b) eigen_mat =
  fun x a -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.div_scalar x a)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.div_scalar x a)
  | SPMAT_C x -> SPMAT_C (Eigen.Sparse.C.div_scalar x a)
  | SPMAT_Z x -> SPMAT_Z (Eigen.Sparse.Z.div_scalar x a)

let _eigen_min : type a b . (a, b) eigen_mat -> a =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.min x
  | SPMAT_D x -> Eigen.Sparse.D.min x
  | _         -> failwith "_eigen_min: unsupported operation"

let _eigen_max : type a b . (a, b) eigen_mat -> a =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.max x
  | SPMAT_D x -> Eigen.Sparse.D.max x
  | _         -> failwith "_eigen_max: unsupported operation"

let _eigen_min2 : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> SPMAT_S (Eigen.Sparse.S.min2 x y)
  | SPMAT_D x, SPMAT_D y -> SPMAT_D (Eigen.Sparse.D.min2 x y)
  | _         -> failwith "_eigen_min2: unsupported operation"

let _eigen_max2 : type a b . (a, b) eigen_mat -> (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x y -> match x, y with
  | SPMAT_S x, SPMAT_S y -> SPMAT_S (Eigen.Sparse.S.max2 x y)
  | SPMAT_D x, SPMAT_D y -> SPMAT_D (Eigen.Sparse.D.max2 x y)
  | _         -> failwith "_eigen_max2: unsupported operation"

let _eigen_sum : type a b . (a, b) eigen_mat -> a =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.sum x
  | SPMAT_D x -> Eigen.Sparse.D.sum x
  | SPMAT_C x -> Eigen.Sparse.C.sum x
  | SPMAT_Z x -> Eigen.Sparse.Z.sum x

let _eigen_abs : type a b . (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.abs x)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.abs x)
  | _         -> failwith "_eigen_abs: unsupported operation"

let _eigen_neg : type a b . (a, b) eigen_mat -> (a, b) eigen_mat =
  fun x -> match x with
  | SPMAT_S x -> SPMAT_S (Eigen.Sparse.S.neg x)
  | SPMAT_D x -> SPMAT_D (Eigen.Sparse.D.neg x)
  | SPMAT_C x -> SPMAT_C (Eigen.Sparse.C.neg x)
  | SPMAT_Z x -> SPMAT_Z (Eigen.Sparse.Z.neg x)



(* ends here *)
