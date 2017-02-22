(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module M = Owl_dense_real

(* global epsilon value used in numerical differentiation *)
let _eps = 0.00001
let _ep1 = 1.0 /. _eps
let _ep2 = 0.5 /. _eps

let diff f x = (f (x +. _eps) -. f (x -. _eps)) *. _ep2

let diff2 f x = (f (x +. _eps) +. f (x -. _eps) -. (2. *. f x)) /. (_eps *. _eps)

let diff' f x = f x, diff f x

let diff2' f x = f x, diff2 f x

let grad' f x =
  let _, n = M.shape x in
  let g = M.create 1 n (f x) in
  let gg = M.mapi (fun _ j xj ->
    let x' = M.clone x in
    x'.{0,j} <- xj +. _eps;
    f x'
  ) x in
  g, M.((gg -@ g) *$ _ep1)

let grad f x = grad' f x |> snd
