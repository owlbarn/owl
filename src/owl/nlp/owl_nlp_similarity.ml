(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type t =
  | Cosine
  | Euclidean
  | KL_D

let to_string = function
  | Cosine    -> "Cosine"
  | Euclidean -> "Euclidean"
  | KL_D      -> "Kullback–Leibler divergence"


let kl_distance _ _ = 0.


let cosine_distance x y =
  let hy = Hashtbl.create (Array.length y) in
  Array.iter (fun (k, v) -> Hashtbl.add hy k v) y;
  let z = ref 0. in
  Array.iter (fun (k,v) ->
    match Hashtbl.mem hy k with
    | true  -> z := !z +. v *. (Hashtbl.find hy k)
    | false -> ()
  ) x;
  (* return the negative since high similarity indicates small distance *)
  -.(!z)


let inner_product x y =
  let hy = Hashtbl.create (Array.length y) in
  Array.iter (fun (k, v) -> Hashtbl.add hy k v) y;
  let z = ref 0. in
  Array.iter (fun (k,v) ->
    match Hashtbl.mem hy k with
    | true  -> z := !z +. v *. (Hashtbl.find hy k)
    | false -> ()
  ) x;
  !z


(* this function aussmes that the elements' ids have been sorted in increasing
  order, then perform inner product operation of both passed in vectors.
 *)
let inner_product_fast x y =
  (*
  Array.sort (fun a b -> Pervasives.compare (fst a) (fst b)) x;
  Array.sort (fun a b -> Pervasives.compare (fst a) (fst b)) y;
  *)
  let xi = ref 0 in
  let yi = ref 0 in
  let xn = Array.length x in
  let yn = Array.length y in
  let z = ref 0. in
  while !xi < xn && !yi < yn do
    let xk, xv = x.(!xi) in
    let yk, yv = y.(!yi) in
    if xk = yk then (
      z := !z +. xv *. yv;
      xi := !xi + 1;
      yi := !yi + 1;
    )
    else if xk < yk then
      xi := !xi + 1
    else if xk > yk then
      yi := !yi + 1
  done;
  !z

let euclidean_distance x y =
  let h = Hashtbl.create (Array.length x) in
  Array.iter (fun (k, a) -> Hashtbl.add h k a) x;
  Array.iter (fun (k, b) ->
    match Hashtbl.mem h k with
    | true  ->
        let a = Hashtbl.find h k in
        Hashtbl.replace h k (a -. b)
    | false -> Hashtbl.add h k b
  ) y;
  let z = ref 0. in
  Hashtbl.iter (fun _ v -> z := !z +. v *. v) h;
  sqrt !z


let distance = function
  | Cosine    -> cosine_distance
  | Euclidean -> euclidean_distance
  | KL_D      -> kl_distance



(* ends here *)
