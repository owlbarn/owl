(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module Make (A : InpureSig) = struct

  module D = Owl_distribution.Make (A)

  module L = Owl_lazy.Make (A)

  type t = {
    mutable dist : D.dist;
    mutable expr : L.t;
  }


end
