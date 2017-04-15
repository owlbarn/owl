(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module Vec = Owl_dense_vector_d

type t =
  | Cosine
  | Euclidean
  | KL_D

let to_string = function
  | Cosine    -> "Cosine"
  | Euclidean -> "Euclidean"
  | KL_D      -> "Kullback–Leibler divergence"

let cosine_distance x y =
  (* TODO: need to implement inner and cross prod *)
  let x = Vec.(div_scalar x (l2norm x)) in
  let y = Vec.(div_scalar y (l2norm y)) in
  let z = Vec.(dot x (transpose y)) in
  -.(Vec.get z 0)

let euclidean_distance x y = Vec.(sub x y |> l2norm_sqr)

let kl_distance x y = 0.

let distance = function
  | Cosine    -> cosine_distance
  | Euclidean -> euclidean_distance
  | KL_D      -> kl_distance



(* ends here *)
