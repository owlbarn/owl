(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Owl_lazy_generic


module Dummy_Attr = struct

  type attr

end


module Lazy (A : InpureSig) = Owl_lazy_generic.Make (A) (Dummy_Attr)
