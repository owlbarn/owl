(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Owl_types

module Make (A : Stats_Dist) = struct
  module Dist = Owl_distribution.Make (A)
  module Lazy = Owl_lazy.Make (A)

  type t =
    { mutable dist : Dist.dist
    ; mutable expr : Lazy.value
    }

  let uniform ~a ~b = () [@@warning "-27"]
end
