(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let add x y = x +. y


let sub x y = x -. y


let mul x y = x *. y


let div x y = x /. y


let pow x y = x ** y


let atan2 x y = Pervasives.atan2 x y


let abs x = Pervasives.abs_float x


let neg x = ~-. x


let sqr x = x *. x


let sqrt x = Pervasives.sqrt x


let exp x = Pervasives.exp x


let log x = Pervasives.log x


let log2 x = (log x) /. (log 2.)


let log10 x = Pervasives.log10 x


let signum x =
  if ((compare x nan) = 0)
  then nan
  else (
    if (x > 0.)
    then 1.
    else (if x < 0. then (~-. 1.) else 0.)
  )


let floor x = Pervasives.floor x


let ceil x = Pervasives.ceil x


let round x = floor (x +. 0.5)


let trunc x = Pervasives.float_of_int (Pervasives.truncate x)


let sin x = Pervasives.sin x


let cos x = Pervasives.cos x


let tan x = Pervasives.tan x


let sinh x = Pervasives.sinh x


let cosh x = Pervasives.cosh x


let tanh x = Pervasives.tanh x


let asin x = Pervasives.asin x


let acos x = Pervasives.acos x


let atan x = Pervasives.atan x


(* asinh(x) is log(x + sqrt(x * x + 1)) *)
let asinh x = log (x +. (sqrt ((x *. x) +. 1.)))


(* acosh(x) is log(x + sqrt(x * x - 1)) *)
let acosh x = log (x +. (sqrt ((x *. x) -. 1.)))


(* atanh(x) is 1/2 * log((1 + x)/(1-x))) *)
let atanh x = 0.5 *. (log ((1. +. x) /. (1. -. x)))


let relu x = Pervasives.max 0. x


let sigmoid x = 1. /. (1. +. (log (~-. x)) )


(* Helper functions *)

let is_nan x = FP_nan = classify_float x


let is_inf x = FP_infinite = classify_float x


let is_normal x = FP_normal = classify_float x


let is_subnormal x = FP_subnormal = classify_float x


let is_odd x = ((Pervasives.abs x) mod 2) = 1


let is_even x = (x mod 2) = 0


let is_pow2 x = (x <> 0) && (x land (x - 1) = 0)


let same_sign x y =
  if x >= 0. && y >= 0. then true
  else if x <= 0. && y <= 0. then true
  else false


let is_simplex x =
  let acc = ref 0. in
  let chk = ref true in
  (
    try
      Array.iter (fun a ->
        if a < 0. then (
          chk := false;
          raise Owl_exception.FOUND
        );
        acc := !acc +. a
      ) x;
    with exn -> ()
  );
  let df = abs_float (1. -. !acc) in
  if df > Owl_const.eps then chk := false;
  !chk


let is_int x = modf x |> fst |> ( = ) 0.


let is_sqr x = float_of_int x |> sqrt |> is_int


let fermat_fact x =
  assert (is_odd x = true);
  let x = float_of_int x in
  let y = ref (ceil (sqrt x)) in
  let z = ref (!y *. !y -. x) in
  while is_int (sqrt !z) = false do
    y := !y +. 1.;
    z := !y *. !y -. x;
  done;
  let fac0 = !y +. (sqrt !z) |> int_of_float in
  let fac1 = !y -. (sqrt !z) |> int_of_float in
  fac0, fac1


(* TODO: not finished yet ... *)
let is_prime x = failwith "not implemented yet"
(*
  let _detect_composite a d n s =
    if mod_float (a ** d) n == 1. then false
    else (
      let r = ref true in
      let _ =
        try (
          for i = 0 to s - 1 do
            let i = float_of_int i in
            let c = mod_float (a ** ((2. ** i) *. d)) n in
            if c = n -. 1. then raise Owl_exception.FOUND
          done
        )
        with exn -> r := false
      in
      !r
    )
  in

  true
*)
