(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type t =
  | Cosine
  | Euclidean
  | KL_D

let to_string = function
  | Cosine    -> "Cosine"
  | Euclidean -> "Euclidean"
  | KL_D      -> "Kullback–Leibler divergence"


let kl_distance x y = 0.


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
  Hashtbl.iter (fun k v -> z := !z +. v *. v) h;
  sqrt !z


let distance = function
  | Cosine    -> cosine_distance
  | Euclidean -> euclidean_distance
  | KL_D      -> kl_distance



(* ends here *)
