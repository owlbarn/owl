(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Signal processing helpers *)

open Owl_dense

let hamming m =
  let open Ndarray in
  let range = (D.sequential [|m|] |> D.mul_scalar) (Owl_const.pi *. 2.0 /. (Int.to_float (m - 1))) in
  let inter = D.cos range in
  let mulv = D.mul_scalar inter (-0.46) in
    D.add_scalar mulv 0.54;;
