(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type node = {
  mutable value : float;
  mutable dual : float;
  func : float -> float;
  vjp : float -> float;
}

type scalar = Float of float | Node of node

type df =
  | FUNVEC of (scalar array -> scalar)
  | FUN01X of (scalar -> scalar)
  | FUN02X of (scalar -> scalar -> scalar)
  | FUN03X of (scalar -> scalar -> scalar -> scalar)
  | FUN04X of (scalar -> scalar -> scalar -> scalar -> scalar)

let identity x = x

let new_node value func args = {
  value;
  dual = 0.;
  func;
  vjp = identity;
}

let wrap_fun f f' args =
  let parent = ref [] in
  let argval = ref [||] in
  let dualval = ref [||] in
  List.iter (fun arg ->
    match arg with
    | Node x -> (
      parent := !parent @ [x];
      argval := Array.append !argval [|x.value|];
      dualval := Array.append !dualval [|x.dual|];
      )
    | Float x -> argval := Array.append !argval [|x|]
  ) args;
  let v = f !argval in
  match !parent with
  | [] -> Float v
  | _  -> (
    let n = new_node v identity [] in
    n.dual <- f' !dualval !argval;
    Node n
    )

let prepare_fun f =
  match f with
  | FUNVEC f -> f
  | FUN01X f -> fun x -> f x.(0)
  | FUN02X f -> fun x -> f x.(0) x.(1)
  | FUN03X f -> fun x -> f x.(0) x.(1) x.(2)
  | FUN04X f -> fun x -> f x.(0) x.(1) x.(2) x.(3)

(* USE GADT to fix *)
let grad ?(argnum=0) f =
  let f = prepare_fun f in
  let f' = fun args -> (
    let l = Array.mapi (fun i a ->
      let n = new_node a identity [] in
      if argnum = i then n.dual <- 1. else n.dual <- 0.;
      Node n
    ) args
    in
    f l
  )
  in
  f'

let sin x = wrap_fun Owl_autograd_maths.sin Owl_autograd_maths.sin' [x]
let cos x = wrap_fun Owl_autograd_maths.cos Owl_autograd_maths.cos' [x]
let log x = wrap_fun Owl_autograd_maths.log Owl_autograd_maths.log' [x]
let ( +. ) x0 x1 = wrap_fun Owl_autograd_maths.add Owl_autograd_maths.add' [x0; x1]
let ( -. ) x0 x1 = wrap_fun Owl_autograd_maths.sub Owl_autograd_maths.sub' [x0; x1]
let ( *. ) x0 x1 = wrap_fun Owl_autograd_maths.mul Owl_autograd_maths.mul' [x0; x1]
let ( /. ) x0 x1 = wrap_fun Owl_autograd_maths.div Owl_autograd_maths.div' [x0; x1]
