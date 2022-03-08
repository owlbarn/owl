(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

let gumbel1_rvs ~a ~b =
  let x = Random.float 1. in
  (log b -. log (-.log x)) /. a
