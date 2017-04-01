(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff_ad


module Batch = struct

  type typ =
    | Fullbatch
    | Minibatch of int
    | Stochastic

end


module Params = struct

  type typ = {
    mutable pochs : int;
    mutable batch : Batch.typ;
  }

  let default () = None

end
