(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


include Complex


let abs = norm


let abs2 = norm2


let exp2 x = pow {re = 2.; im = 0.} x


let exp10 x = pow {re = 10.; im = 0.} x


let expm1 x = sub (exp x) one


let logabs x =
  let r = abs_float x.re in
  let i = abs_float x.im in
  let m, u =
    if r >= i then r, i /. r
    else i, r /. i
  in
  Pervasives.(log m) +. 0.5 *. (log1p (u *. u))


let log2 x = div (log x) (log {re = 2.; im = 0.})


let log10 x = div (log x) (log {re = 10.; im = 0.})


let log1p x = log (add x one)


let add_re x a = { re = x.re +. a; im = x.im }


let add_im x a = { re = x.re; im = x.im +. a }


let sub_re x a = { re = x.re -. a; im = x.im }


let sub_im x a = { re = x.re; im = x.im -. a }


let mul_re x a = { re = x.re *. a; im = x.im *. a }


let mul_im x a = { re = -.a *. x.im; im = a *. x.re }


let div_re x a = { re = x.re /. a; im = x.im /. a }


let div_im x a = { re = x.im /. a; im = -.x.re /. a }


let sin x =
  if x.im = 0. then { re = sin x.re; im = 0. }
  else { re = (sin x.re) *. (cosh x.im) ; im = (cos x.re) *. (sinh x.im) }


let cos x =
  let open Pervasives in
  if x.im = 0. then { re = cos x.re; im = 0. }
  else { re = (cos x.re) *. (cosh x.im) ; im = (sin x.re) *. (sinh (-.x.im)) }


let tan x =
  let open Pervasives in
  if abs_float x.im < 1. then (
    let d = ((cos x.re) ** 2.) +. ((sinh x.im) ** 2.) in
    { re = 0.5 *. (sin (2. *. x.re)) /. d; im = 0.5 *. (sinh (2. *. x.im)) /. d }
  )
  else (
    let d = ((cos x.re) ** 2.) +. ((sinh x.im) ** 2.) in
    let f = 1. +. (((cos x.re) /. (sinh x.im)) ** 2.) in
    { re = 0.5 *. (sin (2. *. x.re)) /. d; im = 1. /. ((tanh x.im) *. f) }
  )


let cot x = inv (tan x)


let sec x = inv (cos x)


let csc x = inv (sin x)


let sinh x =
  let open Pervasives in
  { re = (sinh x.re) *. (cos x.im); im = (cosh x.re) *. (sin x.im) }


let cosh x =
  let open Pervasives in
  { re = (cosh x.re) *. (cos x.im); im = (sinh x.re) *. (sin x.im) }


let tanh x =
  let open Pervasives in
  if abs_float x.re < 1. then (
    let d = ((cos x.im) ** 2.) +. ((sinh x.re) ** 2.) in
    { re = (sinh x.re) *. (cosh x.re) /. d; im = 0.5 *. (sin (2. *. x.im)) /. d }
  )
  else (
    let d = ((cos x.im) ** 2.) +. ((sinh x.re) ** 2.) in
    let f = 1. +. (((cos x.re) /. (sinh x.im)) ** 2.) in
    { re = 1. /. ((tanh x.re) *. f); im = 0.5 *. (sin (2. *. x.im)) /. d }
  )


let sech x = inv (cosh x)


let csch x = inv (sinh x)


let coth x = inv (tanh x)


let asin x =
  let open Pervasives in
  if x.im = 0. then { re = asin x.re; im = 0. }
  else (
    let x0 = abs_float x.re in
    let y0 = abs_float x.im in
    let r = hypot (x0 +. 1.) y0 in
    let s = hypot (x0 -. 1.) y0 in
    let a = 0.5 *. (r +. s) in
    let b = x0 /. a in
    let y2 = y0 *. y0 in

    let a_crossover = 1.5000 in
    let b_crossover = 0.6417 in
    let re = ref 0. in
    let im = ref 0. in

    if b <= b_crossover then re := asin b
    else (
      if x0 <= 1. then (
        let d = 0.5 *. (a +. x0) *. (y2 /. (r +. x0 +. 1.) +. (s +. (1. -. x0))) in
        re := atan (x0 /. sqrt d)
      )
      else (
        let apx = a +. x0 in
        let d = 0.5 *. (apx /. (r +. x0 +. 1.) +. apx /. (s +. (x0 -. 1.))) in
        re := atan (x0 /. (y0 *. sqrt d));
      )
    );

    if a <= a_crossover then (
      let am1 =
        if x0 < 1. then
          0.5 *. (y2 /. (r +. (x0 +. 1.)) +. y2 /. (s +. (1. -. x0)))
        else
          0.5 *. (y2 /. (r +. (x0 +. 1.)) +. (s +. (x0 -. 1.)))
      in
      im := log1p (am1 +. sqrt (am1 *. (a +. 1.)))
    )
    else (
      im := log (a +. sqrt (a *. a -. 1.))
    );

    let re = if x.re >= 0. then !re else -.(!re) in
    let im = if x.im >= 0. then !im else -.(!im) in
    { re; im }
  )


let acos x =
  let open Pervasives in
  if x.im = 0. then { re = acos x.re; im = 0. }
  else (
    let x0 = abs_float x.re in
    let y0 = abs_float x.im in
    let r = hypot (x0 +. 1.) y0 in
    let s = hypot (x0 -. 1.) y0 in
    let a = 0.5 *. (r +. s) in
    let b = x0 /. a in
    let y2 = y0 *. y0 in

    let a_crossover = 1.5000 in
    let b_crossover = 0.6417 in
    let re = ref 0. in
    let im = ref 0. in

    if b <= b_crossover then re := acos b
    else (
      if x0 <= 1. then (
        let d = 0.5 *. (a +. x0) *. (y2 /. (r +. x0 +. 1.) +. (s +. (1. -. x0))) in
        re := atan (sqrt d /. x0)
      )
      else (
        let apx = a +. x0 in
        let d = 0.5 *. (apx /. (r +. x0 +. 1.) +. apx /. (s +. (x0 -. 1.))) in
        re := atan ((y0 *. sqrt d) /. x0)
      )
    );

    if a <= a_crossover then (
      let am1 =
        if x0 < 1. then
          0.5 *. (y2 /. (r +. (x0 +. 1.)) +. y2 /. (s +. (1. -. x0)))
        else
          0.5 *. (y2 /. (r +. (x0 +. 1.)) +. (s +. (x0 -. 1.)))
      in
      im := log1p (am1 +. sqrt (am1 *. (a +. 1.)))
    )
    else (
      im := log (a +. sqrt (a *. a -. 1.))
    );

    let re = if x.re >= 0. then !re else Owl_const.pi -. !re in
    let im = if x.im >= 0. then -.(!im) else !im in
    { re; im }
  )


let atan x =
  let open Pervasives in
  if x.im = 0. then { re = atan x.re; im = 0. }
  else (
    let r = hypot x.re x.im in
    let u = 2. *. x.im /. (1. +. r *. r) in
    let im = ref 0. in

    if abs_float u < 0.1 then
      im := 0.25 *. ((log1p u) -. (log1p (-.u)))
    else (
      let a = hypot x.re (x.im +. 1.) in
      let b = hypot x.re (x.im -. 1.) in
      im := 0.5 *. log (a /. b)
    );

    if x.re = 0. then (
      if x.im > 1. then { re = Owl_const.pi_2; im = !im }
      else if x.im < -1. then { re = -.Owl_const.pi_2; im = !im }
      else { re = 0.; im = !im }
    )
    else { re = 0.5 *. (atan2 (2. *. r) ((1. +. r) *. (1. -. r))); im = !im }
  )


let asec x = acos (inv x)


let acsc x = asin (inv x)


let acot x =
  if x.re = 0. && x.im = 0. then { re = Owl_const.pi_2; im = 0. }
  else atan (inv x)


let asinh x = mul_im (mul_im x 1. |> asin) (-1.)


let acosh x =
  let y = acos x in
  let a = if y.im > 0. then (-1.) else 1. in
  mul_im y a


let atanh x =
  if x.im = 0. then { re = Owl_base_maths.atanh x.re; im = 0. }
  else (
    let y = mul_im x 1. in
    mul_im (atan y) (-1.)
  )


let asech x = acosh (inv x)


let acsch x = asinh (inv x)


let acoth x = atanh (inv x)


let phase x = atan2 x.im x.re


let rect r phi =
  let re = r *. Pervasives.cos phi in
  let im = r *. Pervasives.sin phi in
  { re; im }


(* Comparison functions *)

let equal x y = (x.re = y.re) && (x.im = y.im)


let not_equal x y = (x.re <> y.re) || (x.im <> y.im)


let less x y =
  let abs_x = abs x in
  let abs_y = abs y in
  if abs_x < abs_y then true
  else if abs_x > abs_y then false
  else arg x < arg y


let greater x y =
  let abs_x = abs x in
  let abs_y = abs y in
  if abs_x > abs_y then true
  else if abs_x < abs_y then false
  else arg x > arg y


let less_equal x y = not (greater x y)


let greater_equal x y = not (less x y)


(* Helper functions *)

let complex re im = { re; im }


let of_tuple x =
  let re, im = x in
  {re; im}


let to_tuple x = x.re, x.im


let is_nan x = x.re = nan || x.im = nan


let is_inf x =
  x.re = infinity || x.re = neg_infinity ||
  x.im = infinity || x.im = neg_infinity



(* ends here *)
