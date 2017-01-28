(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type op = Forward | Backward | Calculate

type node = {
  mutable value : float;
  mutable dual : float;
  func : float -> float;
  vjp : float -> float;
  mutable parent : node list;
  mutable progenitor : node list; (* FIXME: use set *)
}

type scalar = Float of float | Node of node

let identity x = x

let new_node value func args parent progenitor = {
  value;
  dual = 0.;
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

let wrap_fun f g args =
  let progenitor = ref [] in
  let parent = ref [] in
  let argval = ref [] in
  List.iter (fun arg ->
    match arg with
    | Node x -> (
      print_endline "+++";
      progenitor := !progenitor @ x.progenitor; (* FIXME *)
      parent := !parent @ [x];
      argval := !argval @ [x.value];
      )
    | Float x -> argval := !argval @ [x]
  ) args;
  let v = f (List.nth !argval 0) in
  (* FIXME *)
  match !parent with
  | [] -> Float v
  | _  -> (
    let n = new_node v identity [] !parent !progenitor in
    n.dual <- g (List.nth !argval 0);
    Node n
    )

let grad f =
  let f' = fun a -> (
    let n = new_node a identity [] [] [] in
    n.dual <- 1.0;
    f (Node n)
  )
  in
  f'

let sin x = wrap_fun sin cos [x]

let log x = wrap_fun log (fun x -> 1. /. x) [x]
