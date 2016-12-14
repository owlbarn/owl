(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_common

type ('a, 'b) mat = ('a, 'b, c_layout) Array2.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

(* transform between different format *)

let to_ndarray x = Obj.magic (Bigarray.genarray_of_array2 x)

let of_ndarray x = Bigarray.array2_of_genarray (Obj.magic x)

(* c_layout -> fortran_layout *)
let c2fortran_matrix x =
  let y = Bigarray.genarray_of_array2 x in
  let y = Genarray.change_layout y fortran_layout in
  Bigarray.array2_of_genarray y

(* fortran_layout -> c_layout *)
let fortran2c_matrix x =
  let y = Bigarray.genarray_of_array2 x in
  let y = Genarray.change_layout y c_layout in
  Bigarray.array2_of_genarray y

(* matrix creation operations *)

let size_in_bytes x = Array2.size_in_bytes x

let shape x = (Array2.dim1 x, Array2.dim2 x)

let row_num x = Array2.dim1 x

let col_num x = Array2.dim2 x

let numel x = (row_num x) * (col_num x)

let fill x a = Array2.fill x a

let empty k m n = Array2.create k c_layout m n

let zeros k m n = (_make0 k) m n |> fortran2c_matrix

let create k m n a =
  let x = empty k m n in
  fill x a;
  x

let ones k m n = create k m n (_one k)
