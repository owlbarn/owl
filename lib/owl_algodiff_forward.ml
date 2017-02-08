(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type t = Float of float | Dual of dual
and dual = {
  v : t;
  d : t;
}


(* operate on dual numbers *)

let make_dual v d = Dual { v; d }

let value = function
  | Float a -> Float a
  | Dual n -> n.v

let dual = function
  | Float a -> Float 0.
  | Dual n -> n.d

let rec zero = function
  | Float _ -> Float 0.
  | Dual x -> make_dual (zero x.v) (zero x.d)

let rec one = function
  | Float _ -> Float 1.
  | Dual x -> make_dual (one x.v) (zero x.d)


(* define arithmetic on dual numbers *)

let rec _add x0 x1 = match x0, x1 with
  | Float x0, Float x1 -> Float (x0 +. x1)
  | Float x0, Dual x1 -> make_dual (_add (Float x0) x1.v) x1.d
  | Dual x0, Float x1 -> make_dual (_add x0.v (Float x1)) x0.d
  | Dual x0, Dual x1 -> make_dual (_add x0.v x1.v) (_add x0.d x1.d)

let rec _sub x0 x1 = match x0, x1 with
  | Float x0, Float x1 -> Float (x0 -. x1)
  | Float x0, Dual x1 -> make_dual (_sub (Float x0) x1.v) (_sub (Float 0.) x1.d)
  | Dual x0, Float x1 -> make_dual (_sub x0.v (Float x1)) x0.d
  | Dual x0, Dual x1 -> make_dual (_sub x0.v x1.v) (_sub x0.d x1.d)

let rec _mul x0 x1 = match x0, x1 with
  | Float x0, Float x1 -> Float (x0 *. x1)
  | Float x0, Dual x1 -> make_dual (_mul (Float x0) x1.v) (_mul (Float x0) x1.d)
  | Dual x0, Float x1 -> make_dual (_mul x0.v (Float x1)) (_mul x0.d (Float x1))
  | Dual x0, Dual x1 -> make_dual (_mul x0.v x1.v) (_add (_mul x0.v x1.d) (_mul x0.d x1.v))

let rec _div x0 x1 = match x0, x1 with
  | Float x0, Float x1 -> Float (x0 /. x1)
  | Float x0, Dual x1 -> let y = _div (Float x0) x1.v in make_dual y (_mul (Float (-1.)) (_mul (_div y x1.v) x1.d))
  | Dual x0, Float x1 -> make_dual (_div x0.v (Float x1)) (_div x0.d (Float x1))
  | Dual x0, Dual x1 -> make_dual (_div x0.v x1.v) (_sub (_div x0.d x1.v) (_div (_mul x0.v x1.d) (_mul x1.v x1.v)))

(*
let rec _pow x0 x1 = match x0, x1 with
  | Float x0, Float x1 -> Float (x0 ** x1)
  | Float x0, Dual x1 ->
  | Dual x0, Float x1 ->
  | Dual x0, Dual x1 ->
*)

(* overload operators *)

module type MathsSig = sig
  val ( +. ) : t -> t -> t
  val ( -. ) : t -> t -> t
  val ( *. ) : t -> t -> t
  val ( /. ) : t -> t -> t
  val exp : t -> t
  val log : t -> t
  val sin : t -> t
  val cos : t -> t
  val tan : t -> t
  val sinh : t -> t
  val cosh : t -> t
  val tanh : t -> t
  val square : t -> t
end

module type DerivativeSig = sig
  val exp' : t -> t
  val log' : t -> t
  val sin' : t -> t
  val cos' : t -> t
  val tan' : t -> t
  val sinh' : t -> t
  val cosh' : t -> t
  val tanh' : t -> t
  val square' : t -> t
end

module rec Maths : MathsSig = struct

  open Derivative

  let ( +. ) x0 x1 = _add x0 x1

  let ( -. ) x0 x1 = _sub x0 x1

  let ( *. ) x0 x1 = _mul x0 x1

  let ( /. ) x0 x1 = _div x0 x1

  let rec exp = function
    | Float x -> Float (Pervasives.exp x)
    | Dual x -> make_dual (exp x.v) ((exp' x.v) *. x.d)

  let rec log =function
    | Float x -> Float (Pervasives.log x)
    | Dual x -> make_dual (log x.v) ((log' x.v) *. x.d)

  let rec sin = function
    | Float x -> Float (Pervasives.sin x)
    | Dual x -> make_dual (sin x.v) ((sin' x.v) *. x.d)

  let rec cos = function
    | Float x -> Float (Pervasives.cos x)
    | Dual x -> make_dual (cos x.v) ((cos' x.v) *. x.d)

  let rec tan = function
    | Float x -> Float (Pervasives.tan x)
    | Dual x -> make_dual (tan x.v) ((tan' x.v) *. x.d)

  let rec sinh = function
    | Float x -> Float (Pervasives.sinh x)
    | Dual x -> make_dual (sinh x.v) ((sinh' x.v) *. x.d)

  let rec tanh = function
    | Float x -> Float (Pervasives.tanh x)
    | Dual x -> make_dual (tanh x.v) ((tanh' x.v) *. x.d)

  let rec cosh = function
    | Float x -> Float (Pervasives.cosh x)
    | Dual x -> make_dual (cosh x.v) ((cosh' x.v) *. x.d)

  let rec square = function
    | Float x -> Float Pervasives.(x *. x)
    | Dual x -> make_dual (square x.v) ((square' x.v) *. x.d)

end and
Derivative : DerivativeSig = struct

  open Maths

  let exp' x = exp x

  let log' x = Float 1. /. x

  let sin' x = cos x

  let cos' x = Float (-1.) *. (sin x)

  let tan' x = square (cos x)

  let sinh' x = cosh x

  let cosh' x = sinh x

  let tanh' x = square (cosh x)

  let square' x = Float 2. *. x

end


(* helper functions and wrappers *)

let derivative ?(argnum=0) f =
  let f' = fun args -> (
    let args = Array.mapi (fun i x ->
      match i = argnum with
      | true  -> make_dual x (one x)
      | false -> make_dual x (zero x)
    ) args
    in
    f args |> dual
  )
  in
  f'

let gradient f =
  let g = fun args -> (
    Array.mapi (fun i _ -> (derivative ~argnum:i f) args) args
  )
  in
  g

let jacobian f =
  let f' = fun argnum args -> (
    let args = Array.mapi (fun i x ->
      match i = argnum with
      | true  -> make_dual x (one x)
      | false -> make_dual x (zero x)
    ) args
    in
    Array.map dual (f args)
  )
  in
  let j = fun args -> (
    Array.mapi (fun i _ -> f' i args) args
  )
  in
  j

let hessian f = jacobian (gradient f)

let laplacian f =
  let l = fun args -> (
    let x = (hessian f) args in
    let m = Array.length args in
    let r = ref (Float 0.) in
    for i = 0 to (m - 1) do
      r := _add !r x.(i).(i)
    done;
    !r
  )
  in
  l

let print_dual n =
  let rec _print_dual = function
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

(* ends here *)
