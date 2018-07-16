(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making a CPU-based engine to execute computation graphs. *)

module Make_Nested
  (Device : Owl_types_computation_opencl_device.Sig)
  = struct

  module Graph = Owl_computation_engine.Make_Graph (Device)

  open Graph.Optimiser.Operator.Symbol


  (* module aliases *)

  module CG_Init = Owl_computation_opencl_init.Make (Device)

  module CG_Eval = Owl_computation_opencl_eval.Make (Device)


  (* core interface *)

  let eval_elt xs = failwith "not implemented yet"


  let eval_arr xs = failwith "not implemented yet"


  let eval_arr ?(dev_id=0) xs =
    let ctx = Owl_opencl_context.(get_opencl_ctx default) in
    let dev = Owl_opencl_context.(get_dev default dev_id) in
    let cmdq = Owl_opencl_context.(get_cmdq default dev) in
    let prog = Owl_opencl_context.(get_program default) in
    let param = (ctx, cmdq, prog) in

    (* initialise the computation graph *)
    let nodes = Array.map arr_to_node xs in
    CG_Init.init_nodes nodes param;

    Array.iter (fun y ->
      CG_Eval._eval_term y param;
      (* read the results from buffer *)
      let y_val = (get_value y).(0) in
      CG_Eval.gpu_to_cpu_copy param y_val |> ignore
    ) nodes;

    Owl_opencl_base.CommandQueue.finish cmdq


  let eval_graph graph = failwith "not implemented yet"


end


(* Functor of making CPU-based engine with unrolled module hierarchy *)

module Make
  (A : Ndarray_Mutable)
  = struct

  include
    Make_Nested (
      Owl_computation_opencl_device.Make (A)
    )

  include Graph

  include Optimiser

  include Operator

  include Symbol

  include Shape

  include Type

  include Device

  let number = A.number

end


(* Make functor ends *)
