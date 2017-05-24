(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_neural_layer

type layer =
  | Input          of Input.layer
  | Linear         of Linear.layer
  | LinearNoBias   of LinearNoBias.layer


type node = {
  mutable id   : int;
  mutable func : layer;
  mutable prec : node array;
}


let attach prev next =
  assert (Array.mem prev next.prec = false);
  next.prec <- Array.append next.prec [|prev|]


let linear ?(init_typ = Init.Standard) ?inputs outputs =
  let func = Linear (Linear.create ?inputs outputs init_typ) in
  let output = {
    id = 0;
    func = func;
    prec = [||];
  }
  in
  output
