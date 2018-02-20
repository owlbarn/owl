(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Root finding algorithms *)


(* Bisection algorithm *)

let bisec ?(max_iter=1000) ?(xtol=1e-6) f a b =
  let fa = f a in
  let fb = f b in
  assert (fa *. fb < 0.);

  if fa = 0. then a
  else if fb = 0. then b
  else (
    let x, d = match fa < 0. with
      | true  -> ref a, ref (b -. a)
      | false -> ref b, ref (a -. b)
    in
    try
      for i = 1 to max_iter do
        d := !d *. 0.5;
        let c = !x +. !d in
        let fc = f c in
        if fc <= 0. then x := c;
        assert ((abs_float !d >= xtol) && fc != 0.)
      done;
      !x
    with _ -> !x;
  )


(* False Position algorithm *)

let false_pos ?(max_iter=1000) ?(xtol=1e-6) f a b =
  let fa = f a in
  let fb = f b in
  assert (fa *. fb < 0.);

  if fa = 0. then a
  else if fb = 0. then b
  else (
    let xa, xb, fa, fb = match fa < 0. with
      | true  -> ref a, ref b, ref fa, ref fb
      | false -> ref b, ref a, ref fb, ref fa
    in
    let x = ref infinity in
    let e = ref infinity in
    try
      for i = 1 to max_iter do
        let d = !xb -. !xa in
        x := !xa +. d *. !fa /. (!fa -. !fb);
        let fc = f !x in
        if fc < 0. then (
          e := !xa -. !x;
          xa := !x;
          fa := fc;
        )
        else (
          e := !xb -. !x;
          xb := !x;
          fb := fc;
        );
        assert ((abs_float !e >= xtol) && fc != 0.)
      done;
      !x
    with _ -> !x;
  )


(* Ridder's algorithm *)

let ridder ?(max_iter=1000) ?(xtol=1e-6) f a b =
  let fa = f a in
  let fb = f b in
  assert (fa *. fb < 0.);

  if fa = 0. then a
  else if fb = 0. then b
  else (
    let xa = ref a in
    let xb = ref b in
    let fa = ref fa in
    let fb = ref fb in
    let x = ref infinity in

    try
      for i = 1 to max_iter do
        let dm = 0.5 *. (!xb -. !xa) in
        let xm = !xa +. dm in
        let fm = f xm in
        let s = sqrt(fm *. fm -. !fa *. !fb) in
        assert (s <> 0.);
        let sgn = if !fa < !fb then -1. else 1. in
        x := xm +. sgn *. dm *. fm /. s;
        let fn = f !x in

        if Owl_maths.same_sign fn fm = false then (
          xa := !x;
          xb := xm;
          fa := fn;
          fb := fm;
        )
        else if Owl_maths.same_sign fn !fa = false then (
          xb := !x;
          fb := fn;
        )
        else (
          xa := !x;
          fa := fn;
        );

        assert ((abs_float (!xb -. !xa) >= xtol) && fn != 0.)
      done;
      !x
    with _ -> !x;
  )
