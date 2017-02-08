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

let is_zero x =
  let rec _is_zero = function
    | Float a -> if a <> 0. then failwith "not zero"
    | Dual x -> (_is_zero x.v; _is_zero x.d)
  in
  try (_is_zero x; true)
  with exn -> false

let is_const x = is_zero (dual x)

let rec sign = function
  | Float a -> Float (if a = 0. then 0. else if a > 0. then 1. else -1.)
  | Dual x -> sign x.v

(* overload operators, module signature *)

module type MathsSig = sig
  val ( +. ) : t -> t -> t
  val ( -. ) : t -> t -> t
  val ( *. ) : t -> t -> t
  val ( /. ) : t -> t -> t
  val ( ** ) : t -> t -> t
  val abs : t -> t
  val neg : t -> t
  val exp : t -> t
  val exp2 : t -> t
  val expm1 : t -> t
  val log : t -> t
  val log2 : t -> t
  val log10 : t -> t
  val log1p : t -> t
  val sin : t -> t
  val cos : t -> t
  val tan : t -> t
  val asin : t -> t
  val acos : t -> t
  val atan : t -> t
  val sinh : t -> t
  val cosh : t -> t
  val tanh : t -> t
  val asinh : t -> t
  val acosh : t -> t
  val atanh : t -> t
  val square : t -> t
  val sqrt : t -> t
end

module type DerivativeSig = sig
  val abs' : t -> t
  val neg' : t -> t
  val exp' : t -> t
  val exp2' : t -> t
  val expm1' : t -> t
  val log' : t -> t
  val log2' : t -> t
  val log10' : t -> t
  val log1p' : t -> t
  val sin' : t -> t
  val cos' : t -> t
  val tan' : t -> t
  val asin' : t -> t
  val acos' : t -> t
  val atan' : t -> t
  val sinh' : t -> t
  val cosh' : t -> t
  val tanh' : t -> t
  val asinh' : t -> t
  val acosh' : t -> t
  val atanh' : t -> t
  val square' : t -> t
  val sqrt' : t -> t
end


(* overload operators, module implementation *)

module rec Maths : MathsSig = struct

  open Derivative

  (* define arithmetic on dual numbers *)

  let rec _add x0 x1 = match x0, x1 with
    | Float x0, Float x1 -> Float Pervasives.(x0 +. x1)
    | Float x0, Dual x1 -> make_dual (_add (Float x0) x1.v) x1.d
    | Dual x0, Float x1 -> make_dual (_add x0.v (Float x1)) x0.d
    | Dual x0, Dual x1 -> make_dual (_add x0.v x1.v) (_add x0.d x1.d)

  let rec _sub x0 x1 = match x0, x1 with
    | Float x0, Float x1 -> Float Pervasives.(x0 -. x1)
    | Float x0, Dual x1 -> make_dual (_sub (Float x0) x1.v) (_sub (Float 0.) x1.d)
    | Dual x0, Float x1 -> make_dual (_sub x0.v (Float x1)) x0.d
    | Dual x0, Dual x1 -> make_dual (_sub x0.v x1.v) (_sub x0.d x1.d)

  let rec _mul x0 x1 = match x0, x1 with
    | Float x0, Float x1 -> Float Pervasives.(x0 *. x1)
    | Float x0, Dual x1 -> make_dual (_mul (Float x0) x1.v) (_mul (Float x0) x1.d)
    | Dual x0, Float x1 -> make_dual (_mul x0.v (Float x1)) (_mul x0.d (Float x1))
    | Dual x0, Dual x1 -> make_dual (_mul x0.v x1.v) (_add (_mul x0.v x1.d) (_mul x0.d x1.v))

  let rec _div x0 x1 = match x0, x1 with
    | Float x0, Float x1 -> Float Pervasives.(x0 /. x1)
    | Float x0, Dual x1 -> let y = _div (Float x0) x1.v in make_dual y (_mul (Float (-1.)) (_mul (_div y x1.v) x1.d))
    | Dual x0, Float x1 -> make_dual (_div x0.v (Float x1)) (_div x0.d (Float x1))
    | Dual x0, Dual x1 -> make_dual (_div x0.v x1.v) (_sub (_div x0.d x1.v) (_div (_mul x0.v x1.d) (_mul x1.v x1.v)))

  let ( +. ) x0 x1 = _add x0 x1

  let ( -. ) x0 x1 = _sub x0 x1

  let ( *. ) x0 x1 = _mul x0 x1

  let ( /. ) x0 x1 = _div x0 x1

  let rec abs = function
    | Float x -> Float Pervasives.(abs_float x)
    | Dual x -> make_dual (abs x.v) ((abs' x.v) *. x.d)

  let rec neg = function
    | Float x -> Float Pervasives.(0. -. x)
    | Dual x -> make_dual (neg x.v) ((neg' x.v) *. x.d)

  let rec exp = function
    | Float x -> Float Pervasives.(exp x)
    | Dual x -> make_dual (exp x.v) ((exp' x.v) *. x.d)

  let rec exp2 = function
    | Float x -> Float Pervasives.(2. ** x)
    | Dual x -> make_dual (exp2 x.v) ((exp2' x.v) *. x.d)

  let rec expm1 = function
    | Float x -> Float Pervasives.(exp x -. 1.)
    | Dual x -> make_dual (expm1 x.v) ((expm1' x.v) *. x.d)

  let rec log =function
    | Float x -> Float Pervasives.(log x)
    | Dual x -> make_dual (log x.v) ((log' x.v) *. x.d)

  let rec log2 =function
    | Float x -> Float Owl_maths.(log2 x)
    | Dual x -> make_dual (log2 x.v) ((log2' x.v) *. x.d)

  let rec log10 =function
    | Float x -> Float Pervasives.(log10 x)
    | Dual x -> make_dual (log10 x.v) ((log10' x.v) *. x.d)

  let rec log1p =function
    | Float x -> Float Pervasives.(log1p x)
    | Dual x -> make_dual (log1p x.v) ((log1p' x.v) *. x.d)

  let rec sin = function
    | Float x -> Float Pervasives.(sin x)
    | Dual x -> make_dual (sin x.v) ((sin' x.v) *. x.d)

  let rec cos = function
    | Float x -> Float Pervasives.(cos x)
    | Dual x -> make_dual (cos x.v) ((cos' x.v) *. x.d)

  let rec tan = function
    | Float x -> Float Pervasives.(tan x)
    | Dual x -> make_dual (tan x.v) ((tan' x.v) *. x.d)

  let rec asin = function
    | Float x -> Float Pervasives.(asin x)
    | Dual x -> make_dual (asin x.v) ((asin' x.v) *. x.d)

  let rec acos = function
    | Float x -> Float Pervasives.(acos x)
    | Dual x -> make_dual (acos x.v) ((acos' x.v) *. x.d)

  let rec atan = function
    | Float x -> Float Pervasives.(atan x)
    | Dual x -> make_dual (atan x.v) ((atan' x.v) *. x.d)

  let rec sinh = function
    | Float x -> Float Pervasives.(sinh x)
    | Dual x -> make_dual (sinh x.v) ((sinh' x.v) *. x.d)

  let rec cosh = function
    | Float x -> Float Pervasives.(cosh x)
    | Dual x -> make_dual (cosh x.v) ((cosh' x.v) *. x.d)

  let rec tanh = function
    | Float x -> Float Pervasives.(tanh x)
    | Dual x -> make_dual (tanh x.v) ((tanh' x.v) *. x.d)

  let rec asinh = function
    | Float x -> Float Owl_maths.(asinh x)
    | Dual x -> make_dual (asinh x.v) ((asinh' x.v) *. x.d)

  let rec acosh = function
    | Float x -> Float Owl_maths.(acosh x)
    | Dual x -> make_dual (acosh x.v) ((acosh' x.v) *. x.d)

  let rec atanh = function
    | Float x -> Float Owl_maths.(atanh x)
    | Dual x -> make_dual (atanh x.v) ((atanh' x.v) *. x.d)

  let rec square = function
    | Float x -> Float Pervasives.(x *. x)
    | Dual x -> make_dual (square x.v) ((square' x.v) *. x.d)

  let rec pow x0 x1 = match x0, x1 with
    | Float x0, Float x1 -> Float Pervasives.(x0 ** x1)
    | Float x0, Dual x1 -> let y = pow (Float x0) x1.v in make_dual y (_mul (_mul (Float Pervasives.(log x0)) y) x1.d)
    | Dual x0, Float x1 -> make_dual (pow x0.v (Float x1)) (_mul(_mul (Float x1) (pow x0.v (Float Pervasives.(x1 -. 1.)))) x0.d)
    | Dual x0, Dual x1 -> (
      let y0 = pow x0.v x1.v in
      let y1 = _mul x1.v (pow x0.v (_sub x1.v (Float 1.))) in
      let y2 = if is_const (Dual x1) then one y0 else (_mul y0 (log x0.v)) in
      make_dual y0 (_add (_mul x0.d y1) (_mul x1.d y2))
      )

  let ( ** ) x0 x1 = pow x0 x1

  let rec sqrt = function
    | Float x -> Float Pervasives.(sqrt x)
    | Dual x -> make_dual (sqrt x.v) ((sqrt' x.v) *. x.d)

end and
Derivative : DerivativeSig = struct

  open Maths

  let abs' x = sign x

  let neg' x = Float (-1.)

  let exp' x = exp x

  let exp2' x = (exp2 x) *. log (Float 2.)

  let expm1' x = (exp x) +. (Float 1.)

  let log' x = Float 1. /. x

  let log2' x = Float 1. /. (x *. (log (Float 2.)))

  let log10' x = Float 1. /. (x *. (log (Float 10.)))

  let log1p' x = Float 1. /. (x +. (Float 1.))

  let sin' x = cos x

  let cos' x = Float (-1.) *. (sin x)

  let tan' x = (Float 1.) /. (square (cos x))

  let asin' x = (Float 1.) /. (sqrt ((Float 1.) -. (square x)))

  let acos' x = Float (-1.) /. (sqrt ((Float 1.) -. (square x)))

  let atan' x = (Float 1.) /. ((Float 1.) +. (square x))

  let sinh' x = cosh x

  let cosh' x = sinh x

  let tanh' x = square (cosh x)

  let asinh' x = (Float 1.) /. ((square x) +. (Float 1.))

  let acosh' x = (Float 1.) /. ((square x) -. (Float 1.))

  let atanh' x = (Float 1.) /. ((Float 1.) -. (square x))

  let square' x = Float 2. *. x

  let sqrt' x = Float 0.5 /. (sqrt x)

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
      r := Maths.(!r +. x.(i).(i))
    done;
    !r
  )
  in
  l

let pp_dual n =
  let rec _pp_dual = function
    | Float a -> Printf.printf "%g" a
    | Dual x -> (
      Printf.printf "(";
      let _ = match x.v with
      | Float a -> Printf.printf "%g," a
      | y -> _pp_dual y
      in
      let _ = match x.d with
      | Float a -> Printf.printf "%g" a
      | y -> _pp_dual y
      in
      Printf.printf ")";
      )
  in
  _pp_dual n; print_endline ""

let degree x =
  let rec _degree x i =
    match x with
    | Dual x -> _degree x.d (i + 1)
    | _ -> i
  in
  _degree x 0

(* ends here *)
