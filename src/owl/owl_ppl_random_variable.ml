(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module Make (A : StatsSig) = struct

  module D = Owl_distribution.Make (A)

  module L = Owl_lazy.Make (A)

  type t = {
    mutable dist : D.dist;
    mutable expr : L.t;
  }


  let uniform ~a ~b = ()


end
