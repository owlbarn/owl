(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module PRNG = struct

  type state

  external seed : int -> unit = "owl_sfmt_seed"

  external rand_int : unit -> int = "owl_sfmt_rand_int"

end


(* init the state of PRNG *)
let _ =
  Random.self_init ();
  PRNG.seed (Random.int 65535)
