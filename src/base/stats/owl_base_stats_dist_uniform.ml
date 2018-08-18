(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* return [0, n - 1] *)
let uniform_int_rvs n = Random.int n


let std_uniform_rvs () = Random.float 1.


let uniform_rvs ~a ~b =
  a +. (b -. a) *. (Random.float 1.)
