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

let kind x = Array2.kind x

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
  fill x a; x

let ones k m n = create k m n (_one k)

let eye k n =
  let x = zeros k n n in
  let a = Owl_dense_common._one k in
  for i = 0 to n - 1 do
    Array2.unsafe_set x i i a
  done; x

let sequential k m n =
  let x = empty k m n in
  let c = ref (Owl_dense_common._zero k) in
  let a = Owl_dense_common._one k in
  let _op = Owl_dense_common._add_elt k in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      c := _op !c a;
      Array2.unsafe_set x i j !c
    done
  done; x

let vector k n = empty k 1 n

let vector_ones k n = ones k 1 n

let vector_zeros k n = zeros k 1 n

(* FIXME *)
let linspace a b n =
  let x = empty Float64 1 n in
  let c = ((b -. a) /. (float_of_int (n - 1))) in
  for i = 0 to n - 1 do
    x.{0,i} <- a +. c *. (float_of_int i)
  done; x
