(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Root finding algorithms for nonlinear functions *)


(** type definition *)

type solver =
  | Bisec
  | FalsePos
  | Ridder
  | Brent


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
      for _i = 1 to max_iter do
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
      for _i = 1 to max_iter do
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
      for _i = 1 to max_iter do
        let dm = 0.5 *. (!xb -. !xa) in
        let xm = !xa +. dm in
        let fm = f xm in
        let s = sqrt(fm *. fm -. !fa *. !fb) in
        assert (s <> 0.);
        let sgn = if !fa < !fb then -1. else 1. in
        x := xm +. sgn *. dm *. fm /. s;
        let fn = f !x in

        if Owl_base_maths.same_sign fn fm = false then (
          xa := !x;
          xb := xm;
          fa := fn;
          fb := fm;
        )
        else if Owl_base_maths.same_sign fn !fa = false then (
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


(* Brent's algorithm *)

let brent ?(max_iter=1000) ?(xtol=1e-6) f a b =
  let fa = f a in
  let fb = f b in
  assert (fa *. fb < 0.);

  if fa = 0. then a
  else if fb = 0. then b
  else (
    let xa = ref a in
    let xb = ref b in
    let xc = ref b in
    let fc = ref fb in
    let fa = ref fa in
    let fb = ref fb in
    let d = ref infinity in
    let e = ref infinity in
    let p = ref infinity in
    let q = ref infinity in
    let r = ref infinity in
    let eps = 3e-16 in

    try
      for _i = 1 to max_iter do

        if (!fb > 0. && !fc > 0.) || (!fb < 0. && !fc < 0.) then (
          xc := !xa;
          fc := !fa;
          d := !xb -. !xa;
          e := !d;
        );

        if (abs_float !fc < abs_float !fb) then (
          xa := !xb;
          xb := !xc;
          xc := !xa;
          fa := !fb;
          fb := !fc;
          fc := !fa;
        );

        let tol = 2. *. eps *. (abs_float !xb) +. 0.5 *. xtol in
        let xm = 0.5 *. (!xc -. !xb) in
        assert ((abs_float xm >= tol) && !fb != 0.);

        (* 1st strategy: inverse quadratic interpolation *)
        if (abs_float !e >= tol) && (abs_float !fa > abs_float !fb) then (
          let s = !fb /. !fa in
          if !xa = !xc then (
            p := 2. *. xm *. s;
            q := 1. -. s;
          )
          else (
            q := !fa /. !fc;
            r := !fb /. !fc;
            p := s *. (2. *. xm *. !q *. (!q -. !r) -. (!xb -. !xa) *. (!r -. 1.));
            q := (!q -. 1.) *. (!r -. 1.) *. (s -. 1.);
          );

          if !p > 0. then q := -.(!q);
          p := abs_float !p;
          let min1 = 3. *. xm *. !q -. abs_float (tol *. !q) in
          let min2 = abs_float (!e *. !q) in

          if (2. *. !p) < (min min1 min2) then (
            e := !d;
            d := !p /. !q;
          )
          else (
            d := xm;
            e := !d;
          )
        )
        (* 2nd strategy: bisection method *)
        else (
          d := xm;
          e := !d;
        );

        (* adjust the position *)
        xa := !xb;
        fa := !fb;
        if (abs_float !d) > tol then xb := !xb +. !d
        else xb := !xb +. (if tol > 0. then xm else -.xm);
        fb := f !xb;

      done;
      !xb
    with _ -> !xb;
  )


let fzero ?(solver=Brent) ?(max_iter=1000) ?(xtol=1e-6) f a b =
  match solver with
  | Bisec    -> bisec ~max_iter ~xtol f a b
  | FalsePos -> false_pos ~max_iter ~xtol f a b
  | Ridder   -> ridder ~max_iter ~xtol f a b
  | Brent    -> brent ~max_iter ~xtol f a b


let bracket_expand ?(rate=1.6) ?(max_iter=100) f a b =
  assert (a < b);
  let xa = ref a in
  let xb = ref b in
  let fa = ref (f a) in
  let fb = ref (f b) in
  (
    try
      for _i = 1 to max_iter do
        assert (Owl_base_maths.same_sign !fa !fb);
        let d = (!xb -. !xa) *. rate in
        xa := !xa -. d;
        xb := !xb +. d;
        fa := f !xa;
        fb := f !xb;
      done
    with _ -> ()
  );

  if Owl_base_maths.same_sign !fa !fb then None
  else Some (!xa, !xb)



(* ends here *)
