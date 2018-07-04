(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making a CPU-based engine to execute computation graphs. *)

module Make (A : Ndarray_Mutable) = struct

  module A = A

  module CPU_Device = Owl_computation_cpu_device

  module CGraph = Owl_computation_graph.Make (A) (CPU_Device)

  module CG_Init = Owl_computation_cpu_init.Make (A) (CPU_Device)

  module CG_Eval = Owl_computation_cpu_eval.Make (A) (CPU_Device)

  include CGraph


  (* core interface *)

  let eval_elt xs =
    let nodes = Array.map CGraph.elt_to_node xs in
    Array.iter CG_Init._init_term nodes;
    Array.iter CG_Eval._eval_term nodes


  let eval_arr xs =
    let nodes = Array.map CGraph.arr_to_node xs in
    Array.iter CG_Init._init_term nodes;
    Array.iter CG_Eval._eval_term nodes


  let eval_graph graph =
    CGraph.invalidate_rvs graph;
    let nodes = CGraph.get_outputs graph in
    Array.iter CG_Init._init_term nodes;
    Array.iter CG_Eval._eval_term nodes


end

(* Make functor ends *)
