(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let init seed = Random.init seed


let self_init () = Random.self_init ()


let get_state = Random.get_state


let set_state = Random.set_state
