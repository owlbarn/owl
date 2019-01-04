(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let add x y = x +. y


let sub x y = x -. y


let mul x y = x *. y


let div x y = x /. y


let pow x y = x ** y


let fmod x y = Pervasives.mod_float x y


let atan2 x y = Pervasives.atan2 x y


let hypot x y = Pervasives.hypot x y


let abs x = Pervasives.abs_float x


let neg x = ~-. x


let reci x = 1. /. x


let softsign x = x /. (1. +. abs x)


let softplus x = log (1. +. exp x)


let sqr x = x *. x


let sqrt x = Pervasives.sqrt x


let cbrt x = x ** 0.33333333333333333333


let exp x = Pervasives.exp x


let exp2 x = 2. ** x


let exp10 x = 10. ** x


let expm1 x = Pervasives.expm1 x


let log x = Pervasives.log x


let log2 x = (log x) /. Owl_const.loge2


let log10 x = Pervasives.log10 x


let log1p x = Pervasives.log1p x


let signum x =
  if FP_nan = classify_float x then nan
  else (
    if x > 0. then 1.
    else (
      if x < 0. then (~-. 1.) else 0.
    )
  )


let floor x = Pervasives.floor x


let ceil x = Pervasives.ceil x


let round x = floor (x +. 0.5)


let trunc x = modf x |> snd


let fix x = if x < 0. then ceil x else floor x


let sin x = Pervasives.sin x


let cos x = Pervasives.cos x


let tan x = Pervasives.tan x


let cot x = 1. /. (tan x)


let sec x = 1. /. (cos x)


let csc x = 1. /. (sin x)


let sinh x = Pervasives.sinh x


let cosh x = Pervasives.cosh x


let tanh x = Pervasives.tanh x


let asin x = Pervasives.asin x


let acos x = Pervasives.acos x


let atan x = Pervasives.atan x


let acot x = (Owl_const.pi /. 2.) -. (atan x)


let asec x = Pervasives.acos (1. /. x)


let acsc x = Pervasives.asin (1. /. x)


let asinh x = log (x +. (sqrt ((x *. x) +. 1.)))


let acosh x = log (x +. (sqrt ((x *. x) -. 1.)))


let atanh x = 0.5 *. (log ((1. +. x) /. (1. -. x)))


let acoth x = atanh (1. /. x)


let asech x = acosh (1. /. x)


let acsch x = asinh (1. /. x)


let relu x = Pervasives.max 0. x


let sigmoid x = 1. /. (1. +. (log (~-. x)) )


let xlogy x y =
  if x = 0. && classify_float y <> FP_nan then 0.
  else x *. (log y)


let xlog1py x y =
  if x = 0. && classify_float y <> FP_nan then 0.
  else x *. (log1p y)


let logit x = log (x /. (1. -. x))


let expit x = 1. /. (1. +. exp(-.x))


let log1mexp x =
  if -.x > log 2. then log1p (-.(exp x))
  else log (-.(expm1 x))


let log1pexp x =
  if x <= -37. then
    exp x
  else if x <= 18. then
    log1p (exp x)
  else if x <= 33.3 then
    x +. exp(-.x)
  else
    x


let erf x =
  let a =  0.254829592 in
  let b = -0.284496736 in
  let c =  1.421413741 in
  let d = -1.453152027 in
  let e =  1.061405429 in
  let p =  0.327591100 in

  let sign = signum x in
  let x = abs x in

  let t = 1. /. (1. +. p *. x) in
  let y = 1. -. (((((e *. t +. d) *. t) +. c) *. t +. b) *. t +. a) *.t *. (exp (-.x *. x)) in
  sign *. y


let erfc x = 1. -. erf x


let erfcx x = (exp (x *. x)) *. (erfc x)


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
    with _exn -> ()
  );
  let df = abs_float (1. -. !acc) in
  if df > Owl_const.eps then chk := false;
  !chk


let is_int x = modf x |> fst |> ( = ) 0.


let is_sqr x = float_of_int x |> sqrt |> is_int


let _binary_exp a b m f id =
  let r = ref id in
  let a = ref a in
  let b = ref b in
  while !a > 0 do
    if !a land 1 = 1 then
      r := f !r !b m;
    a := !a lsr 1;
    if !a > 0 then
      b := f !b !b m;
  done;
  !r


let mulmod a b m =
  assert (a >= 0);
  assert (b >= 0);
  assert (m >= 1);

  let a = a mod m in
  let b = b mod m in

  if a = 0 || b = 0 then
    0
  else if b < max_int / a then
    (a * b) mod m
  else (
    let _muladd a b m =
      let c = m - b in
      if a >= c then a - c
      else m - c + a
    in
    _binary_exp a b m _muladd 0
  )


let powmod a b m =
  assert (a >= 0);
  assert (b >= 0);
  assert (m >= 1);

  if m = 1 && b = 0 then 0
  else _binary_exp b (a mod m) m mulmod 1


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


let is_prime x =
  let _possible_prime s d n a =
    let p = ref (powmod a d n) in
    if !p = 1 || !p = n - 1 then true
    else (
      let r = ref false in
      let _ =
        try (
          for _ = 0 to s - 1 do
            p := mulmod !p !p n;
            if !p = n - 1 then raise Owl_exception.FOUND
          done
        )
        with _ -> r := true
      in
      !r
    )
  in
  let _factor_powtwo n =
    let i, r = ref 0, ref n in
    while !r land 1 = 0 do
      r := !r lsr 1;
      i := !i + 1;
    done;
    !i, !r
  in
  if x < 30 then
    Array.mem x [|2; 3; 5; 7; 11; 13; 17; 19; 23; 29|]
  else if x mod 2 = 0 || x mod 3 = 0 then
    false
  else (
    let bases =
      (* bases from https://miller-rabin.appspot.com *)
      if x <= 1073741823 then (* 2^30 - 1 *)
        [|2; 7; 61|]
      else
        [|2; 325; 9375; 28178; 450775; 9780504; 6 * 299210837|]
    in
    let s, d = _factor_powtwo (x - 1) in
    Array.for_all (fun b ->
      b mod x = 0 || _possible_prime s d x (b mod x)
    ) bases
  )
