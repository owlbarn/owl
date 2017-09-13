(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module M = Owl_dense.Matrix.D
type mat = Owl_dense.Matrix.D.mat

module V = Owl_dense.Vector.D
type vec = Owl_dense.Vector.D.vec

(* global epsilon value used in numerical differentiation *)
let _eps = 0.00001

let _ep1 = 1.0 /. _eps

let _ep2 = 0.5 /. _eps

(* derivative of f : scalar -> scalar *)
let diff f x = (f (x +. _eps) -. f (x -. _eps)) *. _ep2

(* derivative of f : scalar -> scalar, return both function value and derivative *)
let diff' f x = f x, diff f x

(* second order derivative of f : float -> float, return both function value and derivative *)
let diff2 f x = (f (x +. _eps) +. f (x -. _eps) -. (2. *. f x)) /. (_eps *. _eps)

(* second order derivative of f : scalar -> scalar *)
let diff2' f x = f x, diff2 f x

(* gradient of f : vector -> scalar, return both function value and gradient *)
let grad' f x =
  Owl_utils.check_row_vector x;
  let n = V.numel x in
  let g = V.create n (f x) in
  let gg = V.mapi (fun i xi ->
    let x' = V.clone x in
    M.set x' 0 i (xi +. _eps);
    f x'
  ) x
  in
  g, M.((gg - g) *$ _ep1)

(* gradient of f : vector -> scalar *)
let grad f x = grad' f x |> snd

(* transposed jacobian of f : vector -> vector, return both function value and jacobian *)
let jacobianT' f x =
  Owl_utils.check_row_vector x;
  let y = f x in
  let m, n = V.numel x, V.numel y in
  let j = M.tile y [|m; 1|] in
  let jj = M.mapi_by_row n (fun i yi ->
    let x' = M.clone x in
    M.set x' 0 i ((M.get x 0 i) +. _eps);
    f x'
  ) j
  in
  y, M.((jj - j) *$ _ep1)

(* transposed jacobian of f : vector -> vector *)
let jacobianT f x = jacobianT' f x |> snd

(* jacobian of f : vector -> vector, return both function value and jacobian *)
let jacobian' f x =
  let y, j = jacobianT' f x in
  y, M.transpose j

(* jacobian of f : vector -> vector *)
let jacobian f x = jacobian' f x |> snd



(* ends here *)
