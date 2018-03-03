(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Numerical Integration *)


let trapzd f a b n =
  assert (n > 0 && a <= b);

  if n = 1 then (
    0.5 *. (b -. a) *. (f a +. f b)
  )
  else (
    let m = 2. ** float_of_int (n - 1) in
    let d = (b -. a) /. m in
    let x = ref (a +. 0.5 *. d) in
    let s = ref 0. in

    for i = 1 to (int_of_float m) do
      x := !x +. d;
      s := !s +. f !x;
    done;

    0.5 *. d *. (f a +. f b) +. !s *. d
  )


let trapz ?(n=20) ?(eps=1e-6) f a b =
  let s_new = ref 0. in
  let s_old = ref 0. in
  (
    try
      for i = 1 to n do
        s_new := trapzd f a b i;
        if (i > 5) then (
          let d = abs_float (!s_new -. !s_old) in
          let e = eps *. abs_float !s_old in
          assert (not( (d < e) || (!s_new = 0. && !s_old = 0.) ));
          s_old := !s_new;
        )
      done
    with _ -> ()
  );
  !s_new


let simpson ?(n=20) ?(eps=1e-6) f a b =
  let s_new = ref 0. in
  let s_old = ref 0. in
  let o_new = ref 0. in
  let o_old = ref 0. in
  (
    try
      for i = 1 to n do
        s_new := trapzd f a b i;
        s_old := (4. *. !s_new -. !o_new) /. 3.;
        if (i > 5) then (
          let d = abs_float (!s_old -. !o_old) in
          let e = eps *. abs_float !o_old in
          assert (not( (d < e) || (!s_old = 0. && !o_old = 0.) ));
          o_old := !s_old;
          o_new := !s_new;
        )
      done
    with _ -> ()
  );
  !s_new


let romberg ?(n=20) ?(eps=1e-6) f a b =
  let s = Array.make (n + 1) 0. in
  let h = Array.make (n + 2) 1. in
  let rss = ref 0. in
  let k = 5 in
  (
    try
      for i = 0 to n - 1 do
        s.(i) <- trapzd f a b (i + 1);
        if i >= k then (
          let s' = Array.sub s (i - k) k in
          let h' = Array.sub h (i - k) k in
          let ss, dss = Owl_maths_interpolate.polint h' s' 0. in
          rss := ss;
          assert ( (abs_float dss) > (eps *. abs_float ss) );
        );
        h.(i + 1) <- 0.25 *. h.(i);
      done
    with _ -> ()
  );
  !rss


(* ends here *)
