(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Numerical Integration *)


let trapz f a b n =
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


let qtrap ?(n=16) ?(eps=1e-6) f a b =
  let s_new = ref 0. in
  let s_old = ref 0. in

  (
    try
      for i = 1 to n do
        s_new := trapz f a b i;
        if (i > 5) then (
          let d = abs_float (!s_new -. !s_old) in
          let e = eps *. abs_float !s_old in
          assert (not( (d < e) || (!s_new = 0. && !s_old = 0.) ));
          s_old := !s_new;
          Owl_log.info "iter: %i, d=%g e=%g" i d e;
        )
      done
    with _ -> ()
  );

  !s_new


(* ends here *)
