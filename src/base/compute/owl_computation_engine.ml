(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(**
  This functor takes a device as its input, then it generates the computation
  graph module without flattening the module hierarchy.
 *)

module Make_Graph
  (Device : Owl_types_computation_device.Sig)
  = struct

  include
    Owl_computation_graph.Make (
      Owl_computation_optimiser.Make (
        Owl_computation_operator.Make (
          Owl_computation_symbol.Make (
            Owl_computation_shape.Make (
              Owl_computation_type.Make (Device)
            )
          )
        )
      )
    )

end


(**
  This functor takes an engine as its input, flattens all its embedded modules
  into the same level. Therefore the generated module has all the functions
  sit at the top level, then can be passed to other functors like Algodiff.
 *)

module Flatten
  (Engine : Owl_types_computation_engine.Sig)
  = struct

  include Engine

  include Graph

  include Optimiser

  include Operator

  include Symbol

  include Shape

  include Type

  include Device

  let number = A.number

end
