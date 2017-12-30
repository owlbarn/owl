(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module PRNG = struct

  type state

  external sfmt_seed : int -> unit = "owl_sfmt_seed"

  external rand_int : unit -> int = "owl_sfmt_rand_int"

  external ziggurat_init : unit -> unit = "owl_ziggurat_init"

  external rand_exp : unit -> float = "owl_ziggurat_exp"

  external rand_gaussian : unit -> float = "owl_ziggurat_gaussian"

  let init () =
    Random.self_init ();
    let seed = Random.int 65535 in
    sfmt_seed seed;
    ziggurat_init ()

end
