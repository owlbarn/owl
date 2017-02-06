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
      Printf.printf "(";
      let _ = match x.v with
      | Float a -> Printf.printf "%g," a
      | y -> _print_dual y
      in
      let _ = match x.d with
      | Float a -> Printf.printf "%g" a
      | y -> _print_dual y
      in
      Printf.printf ")";
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

let rec _add x0 x1 = match x0, x1 with
  | Float x0, Float x1 -> Float (x0 +. x1)
  | Float x0, Dual x1 -> make_dual (_add (Float x0) x1.v) x1.d
  | Dual x0, Float x1 -> make_dual (_add x0.v (Float x1)) x0.d
  | Dual x0, Dual x1 -> make_dual (_add x0.v x1.v) (_add x0.d x1.d)

let rec _sub x0 x1 = match x0, x1 with
  | Float x0, Float x1 -> Float (x0 -. x1)
  | Float x0, Dual x1 -> make_dual (_sub (Float x0) x1.v) x1.d
  | Dual x0, Float x1 -> make_dual (_sub x0.v (Float x1)) x0.d
  | Dual x0, Dual x1 -> make_dual (_sub x0.v x1.v) (_sub x0.d x1.d)

let rec _mul x0 x1 = match x0, x1 with
  | Float x0, Float x1 -> Float (x0 *. x1)
  | Float x0, Dual x1 -> make_dual (_mul (Float x0) x1.v) (_mul (Float x0) x1.d)
  | Dual x0, Float x1 -> make_dual (_mul x0.v (Float x1)) (_mul x0.d (Float x1))
  | Dual x0, Dual x1 -> make_dual (_mul x0.v x1.v) (_add (_mul x0.v x1.d) (_mul x0.d x1.v))

module type MathsSig = sig
  val ( +. ) : t -> t -> t
  val ( -. ) : t -> t -> t
  val ( *. ) : t -> t -> t
  val sin : t -> t
  val cos : t -> t
end

module type DerivativeSig = sig
  val sin' : t -> t
  val cos' : t -> t
end

module rec Maths : MathsSig = struct

  open Derivative

  let wrap_fun fn f f' args =
    let argsval = Array.map value args in
    let v = f argsval in
    let dualval = Array.map dual args in
    let d = f' dualval argsval in
    make_dual v d

  let ( +. ) x0 x1 = _add x0 x1

  let ( -. ) x0 x1 = _sub x0 x1

  let ( *. ) x0 x1 = _mul x0 x1

  let rec sin = function
    | Float x -> Float (Pervasives.sin x)
    | x -> let v = value x in
      make_dual (sin v) ((sin' v) *. (dual x))

  let rec cos = function
    | Float x -> Float (Pervasives.cos x)
    | x -> let v = value x in
      make_dual (cos v) ((cos' v) *. (dual x))

end and
Derivative : DerivativeSig = struct

  open Maths

  let sin' x = cos x

  let cos' x = Float (-1.) *. (sin x)

end
