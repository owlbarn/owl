(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Eigen_types
open Owl_types

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) eigen_mat = ('a, 'b) spmat


(* interface to eigen functions *)

let _eigen_create : type a b . (a, b) kind -> int -> int -> (a, b) eigen_mat =
  fun k m n -> match k with
  | Float32   -> SPMAT_S (Eigen.Sparse.S.create m n)
  | Float64   -> SPMAT_D (Eigen.Sparse.D.create m n)
  | Complex32 -> SPMAT_C (Eigen.Sparse.C.create m n)
  | Complex64 -> SPMAT_Z (Eigen.Sparse.Z.create m n)
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
  | SPMAT_S x -> Eigen.Sparse.S.(prune x (_zero Float32) 0.; nnz x)
  | SPMAT_D x -> Eigen.Sparse.D.(prune x (_zero Float64) 0.; nnz x)
  | SPMAT_C x -> Eigen.Sparse.C.(prune x (_zero Complex32) 0.; nnz x)
  | SPMAT_Z x -> Eigen.Sparse.Z.(prune x (_zero Complex64) 0.; nnz x)

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

let _eigen_reset : type a b . (a, b) eigen_mat -> unit =
  fun x -> match x with
  | SPMAT_S x -> Eigen.Sparse.S.reset x
  | SPMAT_D x -> Eigen.Sparse.D.reset x
  | SPMAT_C x -> Eigen.Sparse.C.reset x
  | SPMAT_Z x -> Eigen.Sparse.Z.reset x

let _eigen_clone : type a b . (a, b) eigen_mat -> (a, b) eigen_mat =
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


(* ends here *)
