(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making a CPU-based engine to execute computation graphs. *)

module Make
  (Graph : Owl_computation_graph_sig.Sig)
  = struct

  module Graph = Graph

  open Graph.Optimiser.Operator.Symbol

  open Graph.Optimiser.Operator.Symbol.Shape.Type

  open Graph.Optimiser.Operator.Symbol.Shape.Type.Device


  (* module aliases *)

  module CG_Init = Owl_computation_cpu_init2.Make (Graph)

  module CG_Eval = Owl_computation_cpu_eval2.Make (Graph)


  (* core interface *)

  let eval_elt xs =
    let nodes = Array.map elt_to_node xs in
    Array.iter CG_Init._init_term nodes;
    Array.iter CG_Eval._eval_term nodes


  let eval_arr xs =
    let nodes = Array.map arr_to_node xs in
    Array.iter CG_Init._init_term nodes;
    Array.iter CG_Eval._eval_term nodes


  let eval_graph graph =
    Graph.invalidate_rvs graph;
    let nodes = Graph.get_outputs graph in
    Array.iter CG_Init._init_term nodes;
    Array.iter CG_Eval._eval_term nodes


end

(* Make functor ends *)
