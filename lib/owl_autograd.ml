(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type node = {
  value : float;
  func : float -> float;
  vjp : float -> float;
  mutable parent : node list;
  mutable progenitor : node list; (* FIXME: use set *)
}

type scalar = Float of float | Node of node

let wrap_fun f g args =
  let v, p = match args with
  | Float v -> v, []
  | Node p -> p.value, [p]
  in
  let x = {
    value = f v;
    func = f;
    vjp = g;
    parent = p;
    progenitor = [];
  }
  in
  match x.progenitor with
  | [] -> Float x.value
  | _  -> Node x

let identity x = x

let sin x = wrap_fun sin cos x

let log x = wrap_fun log (fun x -> 1. /. x) x

let new_node value func args parent progenitor = {
  value;
  func;
  vjp = identity;
  parent;
  progenitor;
}

let new_progenitor x =
  let n = match x with
    | Float y -> new_node y identity [y] [] []
    | Node y  -> new_node y.value identity [y] [y] y.progenitor
  in
  n.progenitor <- n.progenitor @ [n];
  n

let wrap_fun' f g args =
  let progenitor = ref [] in
  let parent = ref [] in
  List.iter (fun arg ->
    match arg with
    | Node x -> (
      parent := !parent @ x.parent;
      progenitor := !progenitor @ x.progenitor; (* FIXME *)
      )
    | _ -> ()
  ) args
  (* FIXME
  match x.progenitor with
  | [] -> Float x.value
  | _  -> Node x
*)
let grad f =
  let f' = fun a -> (
    let x = new_node a identity [] [] [] in
    f (Node x)
  )
  in
  f'
