(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module Make (A : Stats_Dist) = struct

  module Dist = Owl_distribution.Make (A)

  module Lazy = Owl_lazy.Make (A)

  type t = {
    mutable dist : Dist.dist;
    mutable expr : Lazy.value;
  }


  let uniform ~a ~b = ()


end
