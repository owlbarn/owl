(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making a Lazy engine, just an alias of CPU engine. *)

module Make (A : Ndarray_Mutable) = struct

  module CG_Device = Owl_computation_cpu_device.Make (A)

  module CG_Type = Owl_computation_type2.Make (CG_Device)

  module CG_Shape = Owl_computation_shape2.Make (CG_Type)

  module CG_Symbol = Owl_computation_symbol2.Make (CG_Shape)

  module CG_Operator = Owl_computation_operator2.Make (CG_Symbol)

  module CG_Optimiser = Owl_computation_optimiser2.Make (CG_Operator)

  module CG_Graph = Owl_computation_graph2.Make (CG_Optimiser)

  module CG_Engine = Owl_computation_cpu_engine2.Make (CG_Graph)


  include CG_Type

  include CG_Symbol

  include CG_Operator

  include CG_Graph

  include CG_Engine

end

(* Make functor ends *)
