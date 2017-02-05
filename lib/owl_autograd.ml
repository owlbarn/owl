(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type t = Float of float | Dual of dual
and dual = {
  v : t;
  d : t;
}

let make_dual v d = Dual { v; d }

let print_dual n =
  let rec _print_dual x =
    match x with
    | Float a -> Printf.printf "%g" a
    | Dual x -> (
      let _ = match x.v with
      | Float a -> Printf.printf "(%g," a
      | _ -> failwith "error in print_node 1"
      in
      let _ = match x.d with
      | Float a -> Printf.printf "%g)" a
      | y -> _print_dual y; Printf.printf ")"
      in ()
      )
  in
  _print_dual n; print_endline ""

let degree x =
  let rec _degree x i =
    match x with
    | Dual x -> _degree x.d (i + 1)
    | _ -> i
  in
  _degree x 0

let value = function
  | Float a -> Float a
  | Dual n -> n.v

let dual = function
  | Float a -> Float 0.
  | Dual n -> n.d

let rec add x0 x1 = match x0, x1 with
  | Float x0, Float x1 -> Float (x0 +. x1)
  | Dual x0, Dual x1 -> make_dual (add x0.v x1.v) (add x0.d x1.d)
  | Float x0, Dual x1 -> make_dual (add (Float x0) x1.v) x1.d
  | Dual x0, Float x1 -> make_dual (add x0.v (Float x1)) x0.d

let rec sub x0 x1 = match x0, x1 with
  | Float x0, Float x1 -> Float (x0 -. x1)
  | Dual x0, Dual x1 -> make_dual (sub x0.v x1.v) (sub x0.d x1.d)
  | Float x0, Dual x1 -> make_dual (sub (Float x0) x1.v) x1.d
  | Dual x0, Float x1 -> make_dual (sub x0.v (Float x1)) x0.d
