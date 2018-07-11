(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making a CPU-based engine to execute computation graphs. *)

module Make_Embedded
  (Graph : Owl_computation_graph_sig.Sig)
  = struct

  module Graph = Graph

  open Graph.Optimiser.Operator.Symbol

  open Graph.Optimiser.Operator.Symbol.Shape.Type

  open Graph.Optimiser.Operator.Symbol.Shape.Type.Device


  (* module aliases *)

  module CG_Init = Owl_computation_opencl_init.Make (A)

  module CG_Eval = Owl_computation_opencl_eval.Make (A)


  (* core interface *)

  let eval_elt xs = ()


  let eval_arr xs = ()


  let eval_graph graph = ()


end


(* Functor of making CPU-based engine with unrolled module hierarchy *)

module Make
  (A : Ndarray_Mutable)
  = struct

  include
    Owl_computation_engine.Flatten (
      Make_Embedded (
        Owl_computation_engine.Make_Graph (
          Owl_opencl_device.Make (A)
        )
      )
    )

end


(* Make functor ends *)
