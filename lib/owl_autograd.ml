(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type node = {
  value : float;
  func : float -> float;
  vjp : float -> float;
  parent : node list;
  progenitor : node list ref;
}

type scalar = Float of float | Node of node

let wrap_fun f g arg =
  let v, p = match arg with
  | Float v -> v, []
  | Node p -> p.value, [p]
  in
  let x = {
    value = f v;
    func = f;
    vjp = g;
    parent = p;
    progenitor = ref [];
  }
  in
  match !(x.progenitor) with
  | [] -> Float x.value
  | _  -> Node x

let sin x = wrap_fun sin cos x

let log x = wrap_fun log (fun x -> 1. /. x) x

let new_progenitor x = None

let new_node v =
let f = fun a -> a in
let g = fun a -> a in
{
  value = v;
  func = f;
  vjp = g;
  parent = [];
  progenitor = ref [];
}

let grad f =
  let f' = fun a -> (
    let x = new_node a in
    let _ = x.value = a in
    f (Node x)
  )
  in
  f'
