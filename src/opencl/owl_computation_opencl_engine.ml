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

  let eval_elt xs = failwith "not implemented yet"


  let eval_arr xs = failwith "not implemented yet"

(*
  let eval_arr ?(dev_id=0) xs =
    let ctx = Owl_opencl_context.(get_opencl_ctx default) in
    let dev = Owl_opencl_context.(get_dev default dev_id) in
    let cmdq = Owl_opencl_context.(get_cmdq default dev) in
    let prog = Owl_opencl_context.(get_program default) in
    let param = (ctx, cmdq, prog) in

    (* initialise the computation graph *)
    let nodes = Array.map arr_to_node xs in
    CG_Init.init_nodes (Obj.magic nodes) param;

    Array.iter (fun y ->
      CG_Eval._eval_term (Obj.magic y) param;
      (* read the results from buffer *)
      let y_val = (get_value y).(0) in
      CG_Eval.gpu_to_cpu_copy param y_val |> ignore
    ) nodes;

    Owl_opencl_base.CommandQueue.finish cmdq
*)

  let eval_graph graph = failwith "not implemented yet"


end


(* Functor of making CPU-based engine with unrolled module hierarchy *)

module Make
  (A : Ndarray_Mutable)
  = struct

  include
    Owl_computation_engine.Flatten (
      Make_Embedded (
        Owl_computation_engine.Make_Graph (
          Owl_computation_opencl_device.Make (A)
        )
      )
    )

end


(* Make functor ends *)
