(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

let init seed = Random.init seed

let self_init () = Random.self_init ()

let get_state = Random.get_state

let set_state = Random.set_state
