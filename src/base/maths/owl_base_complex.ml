(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


include Complex


let abs = norm


let abs2 = norm2


let logabs x =
  let r = abs_float x.re in
  let i = abs_float x.im in
  let m, u =
    if r >= i then r, i /. r
    else i, r /. i
  in
  Pervasives.(log m) +. 0.5 *. (log1p (u *. u))


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


(* ends here *)
