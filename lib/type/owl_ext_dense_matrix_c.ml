(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_ext_types

module M = Owl_dense_matrix


(* module specific functions *)

let _elt = Complex32

let pack_elt x = C x
let unpack_elt = function C x -> x | _ -> failwith "error: unknown type"

let pack_box x = DMC x
let unpack_box = function DMC x -> x | _ -> failwith "error: unknown type"


(* wrappers to original functions *)

let empty m n = M.empty _elt m n |> pack_box

let zeros m n = M.zeros _elt m n |> pack_box

let ones m n = M.ones _elt m n |> pack_box

let eye m = M.eye _elt m |> pack_box

let sequential m n = M.sequential _elt m n |> pack_box

let uniform ?(scale=1.) m n = M.uniform ~scale _elt m n |> pack_box

let gaussian ?(sigma=1.) m n = M.gaussian ~sigma _elt m n |> pack_box

let linspace a b n = M.linspace _elt a b n |> pack_box

let meshgrid xa xb ya yb xn yn = let u, v = M.meshgrid _elt xa xb ya yb xn yn in (pack_box u, pack_box v)

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

let reverse x = M.reverse (unpack_box x) |> pack_box

let sort ?cmp ?inc x = M.sort ?cmp ?inc (unpack_box x)

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

let swap_rows x i i' = M.swap_rows (unpack_box x) i i' |> pack_box

let swap_cols x j j' = M.swap_cols (unpack_box x) j j' |> pack_box

let tile x reps = M.tile (unpack_box x) reps |> pack_box

let repeat ?axis x reps = M.repeat ?axis (unpack_box x) reps |> pack_box



let neg x = M.neg (unpack_box x) |> pack_box

let reci x = M.reci (unpack_box x) |> pack_box



let add x y = M.add (unpack_box x) (unpack_box y) |> pack_box

let sub x y = M.sub (unpack_box x) (unpack_box y) |> pack_box

let mul x y = M.mul (unpack_box x) (unpack_box y) |> pack_box

let div x y = M.div (unpack_box x) (unpack_box y) |> pack_box

let add_scalar x a = M.add_scalar (unpack_box x) (unpack_elt a) |> pack_box

let sub_scalar x a = M.sub_scalar (unpack_box x) (unpack_elt a) |> pack_box

let mul_scalar x a = M.mul_scalar (unpack_box x) (unpack_elt a) |> pack_box

let div_scalar x a = M.div_scalar (unpack_box x) (unpack_elt a) |> pack_box



(* ends here *)
