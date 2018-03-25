(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let _u1 = ref 0.
let _u2 = ref 0.
let _case = ref false
let _z0 = ref 0.
let _z1 = ref 1.


(* TODO: use the polar, is more efficient *)
let gaussian_rvs ~mu ~sigma =
  if !_case
  then (_case := false; mu +. sigma *. !_z1)
  else (
    _case := true;
    _u1 := Random.float 1.;
    _u2 := Random.float 1.;
    _z0 := (sqrt ((~-. 2.) *. (log (!_u1)))) *.
           (cos (2. *. Owl_const.pi *. (!_u2)));
    _z1 := (sqrt ((~-. 2.) *. (log (!_u1)))) *.
           (sin (2. *. Owl_const.pi *. (!_u2)));
    mu +. sigma *. !_z0
  )
