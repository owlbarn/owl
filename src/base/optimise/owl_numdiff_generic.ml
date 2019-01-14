(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making numerical differentiation module of different precisions *)

module Make
  (A : Ndarray_Numdiff with type elt = float)
  = struct

  type arr = A.arr
  type elt = A.elt


  (* global epsilon value used in numerical differentiation *)
  let _eps = 0.00001

  let _ep1 = 1.0 /. _eps

  let _ep2 = 0.5 /. _eps


  (* derivative of f : scalar -> scalar *)
  let diff f x = (f (x +. _eps) -. f (x -. _eps)) *. _ep2


  (* derivative of f : scalar -> scalar, return both function value and derivative *)
  let diff' f x = f x, diff f x


  (* second order derivative of f : scalar -> scalar *)
  let diff2 f x = (f (x +. _eps) +. f (x -. _eps) -. (2. *. f x)) /. (_eps *. _eps)


  (* second order derivative of f : float -> float, return both function value and derivative *)
  let diff2' f x = f x, diff2 f x


  (* gradient of f : vector -> scalar, return both function value and gradient *)
  let grad' f x =
    let n = A.numel x in
    let g = A.create [|n|] (f x) in
    let gg = A.mapi (fun i xi ->
      let x' = A.copy x in
      A.set x' [|i|] ((A.elt_to_float xi) +. _eps);
      f x'
    ) x
    in
    g, A.((gg - g) *$ _ep1)


  (* gradient of f : vector -> scalar *)
  let grad f x = grad' f x |> snd


  (* transposed jacobian of f : vector -> vector, return both function value and jacobian *)
  let jacobianT' f x =
    let y = f x in
    let m, n = A.numel x, A.numel y in
    let j = A.tile y [|m; 1|] in
    let jj = A.copy j in

    for i = 0 to m - 1 do
      let x' = A.copy x in
      let a = A.elt_to_float (A.get x [|i|]) in
      A.set x' [|i|] (a +. _eps);
      let y' = A.reshape (f x') [|1; n|] in
      A.set_slice [[i];[]] jj y'
    done;

    y, A.((jj - j) *$ _ep1)


  (* transposed jacobian of f : vector -> vector *)
  let jacobianT f x = jacobianT' f x |> snd


  (* jacobian of f : vector -> vector, return both function value and jacobian *)
  let jacobian' f x =
    let y, j = jacobianT' f x in
    y, A.transpose ~axis:[|1;0|] j


  (* jacobian of f : vector -> vector *)
  let jacobian f x = jacobian' f x |> snd


end


(* ends here *)
