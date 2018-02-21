(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

type ('a, 'b) t = ('a, 'b) Owl_base_dense_ndarray_generic.t

module M = Owl_base_dense_ndarray_generic


(* Check matrix properties *)

let is_triu x =
  let shp = M.shape x in
  let m, n = shp.(0), shp.(1) in
  let k = Pervasives.min m n in
  let _a0 = Owl_const.zero (M.kind x) in
  try
    for i = 0 to k - 1 do
      for j = 0 to i - 1 do
        assert (M.get x [|i; j|] = _a0)
      done
    done;
    true
  with exn -> false


let is_tril x =
  let shp = M.shape x in
  let m, n = shp.(0), shp.(1) in
  let k = Pervasives.min m n in
  let _a0 = Owl_const.zero (M.kind x) in
  try
    for i = 0 to k - 1 do
      for j = i + 1 to k - 1 do
        assert (M.get x [|i; j|] = _a0)
      done
    done;
    true
  with exn -> false


let is_symmetric x =
  let shp = M.shape x in
  let m, n = shp.(0), shp.(1) in
  if m <> n then false
  else (
    try
      for i = 0 to n - 1 do
        for j = i + 1 to n - 1 do
          let a = M.get x [|j; i|] in
          let b = M.get x [|i; j|] in
          assert (a = b)
        done
      done;
      true
    with exn -> false
  )


let is_hermitian x =
  let shp = M.shape x in
  let m, n = shp.(0), shp.(1) in
  if m <> n then false
  else (
    try
      for i = 0 to n - 1 do
        for j = i to n - 1 do
          let a = M.get x [|j; i|] in
          let b = Complex.conj (M.get x [|i; j|]) in
          assert (a = b)
        done
      done;
      true
    with exn -> false
  )


let is_diag x = is_triu x && is_tril x


(* ends here *)
