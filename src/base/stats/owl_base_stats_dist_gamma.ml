(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_base_stats_dist_exponential

open Owl_base_stats_dist_gaussian


let std_gamma_rvs ~shape =
  let x = ref infinity in

  if shape = 1. then (
    x := std_exponential_rvs ()
  )
  else if shape < 1. then (
    try while true do
      let u = Random.float 1. in
      let v = std_exponential_rvs () in
      if u <= 1. -. shape then (
        x := u ** (1. /. shape);
        if !x <= v then raise Owl_exception.FOUND
      )
      else (
        let y = -.(log ((1. -. u) /. shape)) in
        x := (1. -. shape +. shape *. y) ** (1. /. shape);
        if !x <= v +. y then raise Owl_exception.FOUND
      )
    done with _ -> ()
  )
  else (
    let b = shape -. 1. /. 3. in
    let c = 1. /. sqrt (9. *. b) in
    while true do
      let v = ref neg_infinity in

      while !v <= 0. do
        x := std_gaussian_rvs ();
        v := 1. +. c *. !x
      done;

      let v = !v *. !v *. !v in
      let u = Random.float 1. in
      if (u < 1. -. 0.0331 *. !x *. !x *. !x *. !x) then (
        x := b *. v;
        raise Owl_exception.FOUND
      );
      if (log u) < 0.5 *. !x *. !x +. b *. (1. -. v +. log v) then (
        x := b *. v;
        raise Owl_exception.FOUND
      )
    done
  );
  !x


let gamma_rvs ~shape ~scale = scale *. (std_gamma_rvs ~shape)
