(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_graph


(* Functor of making initialisor of a CPU-based engine. *)

module Make
  (Graph : Owl_computation_graph_sig.Sig)
  = struct

  open Graph.Optimiser.Operator.Symbol

  open Graph.Optimiser.Operator.Symbol.Shape.Type.Device


  (* utility functions *)

  let is_initialised x =
    let x_val = get_value x in
    if is_elt x then false
    else Array.length x_val > 0


  let make_value_from src dst =
    let dst_shp = node_shape dst in
    match src with
    | Some src -> (
        (* inherit memory from the src node *)
        let src_val = value_to_arr (get_value src).(0) in
        let dst_val = arr_to_value (A.reshape src_val dst_shp) in
        set_value dst [| dst_val |];
        set_vnode dst [| src |]
      )
    | None     -> (
        (* allocate new memory for dst node *)
        let dst_val = arr_to_value (A.zeros dst_shp) in
        set_value dst [| dst_val |];
        set_vnode dst [| |]
      )


  (* functions of allocating memory space *)

  let allocate_from_parent_0 x = make_value_from None x


  let allocate_from_parent_1 x parent =
    if refnum parent = 1 && get_reuse parent then
      make_value_from (Some parent) x
    else
      make_value_from None x


  let allocate_from_parent_2 x parent_0 parent_1 =
    let parent_0_val = value_to_arr (get_value parent_0).(0) in
    let parent_1_val = value_to_arr (get_value parent_1).(0) in

    let shp_0 = A.shape parent_0_val in
    let shp_1 = A.shape parent_1_val in
    let shp_0, shp_1 = Owl_utils_array.align `Left 1 shp_0 shp_1 in
    let shp_x = Owl_utils_infer_shape.broadcast1 shp_0 shp_1 in

    if shp_0 = shp_x && refnum parent_0 = 1 && get_reuse parent_0 then
      make_value_from (Some parent_0) x
    else if shp_1 = shp_x && refnum parent_1 = 1 && get_reuse parent_1 then
      make_value_from (Some parent_1) x
    else
      make_value_from None x


  let allocate_from_parent_3 x parent_0 parent_1 parent_2 =
    let parent_0_val = value_to_arr (get_value parent_0).(0) in
    let parent_1_val = value_to_arr (get_value parent_1).(0) in
    let parent_2_val = value_to_arr (get_value parent_2).(0) in

    let shp_0 = A.shape parent_0_val in
    let shp_1 = A.shape parent_1_val in
    let shp_2 = A.shape parent_2_val in
    let shp_0, shp_1, shp_2 = Owl_utils_array.align3 `Left 1 shp_0 shp_1 shp_2 in
    let shp_x = Owl_utils_infer_shape.broadcast2 shp_0 shp_1 shp_2 in

    if shp_0 = shp_x && refnum parent_0 = 1 && get_reuse parent_0 then
      make_value_from (Some parent_0) x
    else if shp_1 = shp_x && refnum parent_1 = 1 && get_reuse parent_1 then
      make_value_from (Some parent_1) x
    else if shp_2 = shp_x && refnum parent_2 = 1 && get_reuse parent_2 then
      make_value_from (Some parent_2) x
    else
      make_value_from None x

  let allocate_from_parent_arr x parents =
    let parents_val = Array.map
                        (fun par -> value_to_arr (get_value par).(0)) parents in
    let shp_x = node_shape x in
    (* an imperative version could be slightly more efficient? *)
    let id_shaped_par, _ = Owl_utils.Array.filter2_split
                             (fun par par_val -> A.shape par_val = shp_x
                                                 && refnum par = 1
                                                 && get_reuse par)
                             parents parents_val in
    if Array.length id_shaped_par > 0 then
      make_value_from (Some id_shaped_par.(0)) x
    else
      make_value_from None x

  (* core initialisation function *)

  let rec _init_term x =
    Owl_log.debug "init %s ..." (node_to_str x);

    if is_initialised x = false then
      try
        match (get_operator x) with
        | Noop                                           -> _init_05 x
        | Var                                            -> _init_05 x
        | Const                                          -> _init_05 x
        | Empty _shape                                   -> _init_00 x
        | Zeros _shape                                   -> _init_00 x
        | Ones _shape                                    -> _init_00 x
        | Create _shape                                  -> _init_00 x
        | Sequential _shape                              -> _init_00 x
        | Uniform _shape                                 -> _init_00 x
        | Gaussian _shape                                -> _init_00 x
        | Bernoulli _shape                               -> _init_00 x
        | Init (_shape, _f)                              -> _init_00 x
        | Get _i                                         -> _init_05 x
        | Set _i                                         -> failwith "Set"
        | GetSlice _slice                                -> _init_00 x
        | SetSlice _slice                                -> _init_01 x
        | Copy                                           -> _init_01 x
        | Reset                                          -> _init_01 x
        | Reshape _shape                                 -> _init_01 x
        | Reverse                                        -> _init_01 x
        | Tile _repeats                                  -> _init_00 x
        | Repeat _repeats                                -> _init_00 x
        | Pad (_v, _padding)                             -> _init_00 x
        | Concatenate _axis                              -> _init_00 x
        | Split (_axis, _parts)                          -> failwith "Split"
        | Draw (_axis, _n)                               -> failwith "Draw"
        | Map _f                                         -> _init_00 x
        | Fold (_axis, _f)                               -> _init_00 x
        | Scan (_axis, _f)                               -> _init_00 x
        | OneHot _depth                                  -> _init_00 x
        | Delay _f                                       -> _init_01 x
        | DelayArray (_shape, _f)                        -> _init_06 x
        | Abs                                            -> _init_01 x
        | Neg                                            -> _init_01 x
        | Floor                                          -> _init_01 x
        | Ceil                                           -> _init_01 x
        | Round                                          -> _init_01 x
        | Sqr                                            -> _init_01 x
        | Sqrt                                           -> _init_01 x
        | Log                                            -> _init_01 x
        | Log2                                           -> _init_01 x
        | Log10                                          -> _init_01 x
        | Exp                                            -> _init_01 x
        | Sin                                            -> _init_01 x
        | Cos                                            -> _init_01 x
        | Tan                                            -> _init_01 x
        | Sinh                                           -> _init_01 x
        | Cosh                                           -> _init_01 x
        | Tanh                                           -> _init_01 x
        | Asin                                           -> _init_01 x
        | Acos                                           -> _init_01 x
        | Atan                                           -> _init_01 x
        | Asinh                                          -> _init_01 x
        | Acosh                                          -> _init_01 x
        | Atanh                                          -> _init_01 x
        | Min _axis                                      -> _init_00 x
        | Max _axis                                      -> _init_00 x
        | Sum _axis                                      -> _init_00 x
        | SumReduce _axis                                -> _init_00 x
        | Signum                                         -> _init_01 x
        | Sigmoid                                        -> _init_01 x
        | Relu                                           -> _init_01 x
        | Min'                                           -> _init_05 x
        | Max'                                           -> _init_05 x
        | Sum'                                           -> _init_05 x
        | L1norm'                                        -> _init_05 x
        | L2norm'                                        -> _init_05 x
        | L2NormSqr'                                     -> _init_05 x
        | ClipByValue                                    -> _init_01 x
        | ClipByL2norm                                   -> _init_01 x
        | Pow                                            -> _init_02 x
        | ScalarPow                                      -> _init_04 x
        | PowScalar                                      -> _init_01 x
        | Atan2                                          -> _init_02 x
        | ScalarAtan2                                    -> _init_04 x
        | Atan2Scalar                                    -> _init_01 x
        | Hypot                                          -> _init_02 x
        | Min2                                           -> _init_02 x
        | Max2                                           -> _init_02 x
        | Add                                            -> _init_02 x
        | Sub                                            -> _init_02 x
        | Mul                                            -> _init_02 x
        | Div                                            -> _init_02 x
        | AddScalar                                      -> _init_01 x
        | SubScalar                                      -> _init_01 x
        | MulScalar                                      -> _init_01 x
        | DivScalar                                      -> _init_01 x
        | ScalarAdd                                      -> _init_04 x
        | ScalarSub                                      -> _init_04 x
        | ScalarMul                                      -> _init_04 x
        | ScalarDiv                                      -> _init_04 x
        | FMA                                            -> _init_03 x
        | EltEqual                                       -> _init_02 x
        | EltNotEqual                                    -> _init_02 x
        | EltLess                                        -> _init_02 x
        | EltGreater                                     -> _init_02 x
        | EltLessEqual                                   -> _init_02 x
        | EltGreaterEqual                                -> _init_02 x
        | EltEqualScalar                                 -> _init_01 x
        | EltNotEqualScalar                              -> _init_01 x
        | EltLessScalar                                  -> _init_01 x
        | EltGreaterScalar                               -> _init_01 x
        | EltLessEqualScalar                             -> _init_01 x
        | EltGreaterEqualScalar                          -> _init_01 x
        | Conv1d (_padding, _stride)                     -> _init_00 x
        | Conv2d (_padding, _stride)                     -> _init_00 x
        | Conv3d (_padding, _stride)                     -> _init_00 x
        | TransposeConv2d (_padding, _stride)            -> _init_00 x
        | MaxPool1d (_padding, _kernel, _stride)         -> _init_00 x
        | MaxPool2d (_padding, _kernel, _stride)         -> _init_00 x
        | MaxPool3d (_padding, _kernel, _stride)         -> _init_00 x
        | AvgPool1d (_padding, _kernel, _stride)         -> _init_00 x
        | AvgPool2d (_padding, _kernel, _stride)         -> _init_00 x
        | AvgPool3d (_padding, _kernel, _stride)         -> _init_00 x
        | UpSampling2d _size                             -> _init_00 x
        | Conv1dBackwardInput _stride                    -> _init_00 x
        | Conv1dBackwardKernel _stride                   -> _init_00 x
        | Conv2dBackwardInput _stride                    -> _init_00 x
        | Conv2dBackwardKernel _stride                   -> _init_00 x
        | Conv3dBackwardInput _stride                    -> _init_00 x
        | Conv3dBackwardKernel _stride                   -> _init_00 x
        | TransposeConv2dBackwardInput _stride           -> _init_00 x
        | TransposeConv2dBackwardKernel _stride          -> _init_00 x
        | MaxPool1dBackward (_padding, _kernel, _stride) -> _init_00 x
        | MaxPool2dBackward (_padding, _kernel, _stride) -> _init_00 x
        | MaxPool3dBackward (_padding, _kernel, _stride) -> _init_00 x
        | AvgPool1dBackward (_padding, _kernel, _stride) -> _init_00 x
        | AvgPool2dBackward (_padding, _kernel, _stride) -> _init_00 x
        | AvgPool3dBackward (_padding, _kernel, _stride) -> _init_00 x
        | UpSampling2dBackward _size                     -> _init_00 x
        | Row                                            -> failwith "Row"
        | Rows _i                                        -> failwith "Rows"
        | CopyRowTo                                      -> failwith "CopyRowTo"
        | CopyColTo                                      -> failwith "CopyColTo"
        | Dot (_transa, _transb, _alpha, _beta)          -> _init_00 x
        | Inv                                            -> _init_00 x
        | Trace                                          -> _init_05 x
        | Transpose _axis                                -> _init_00 x
        | ToRows                                         -> failwith "ToRows"
        | OfRows                                         -> failwith "OfRows"
        | Scalar_Add                                     -> _init_05 x
        | Scalar_Sub                                     -> _init_05 x
        | Scalar_Mul                                     -> _init_05 x
        | Scalar_Div                                     -> _init_05 x
        | Scalar_Pow                                     -> _init_05 x
        | Scalar_Atan2                                   -> _init_05 x
        | Scalar_Abs                                     -> _init_05 x
        | Scalar_Neg                                     -> _init_05 x
        | Scalar_Sqr                                     -> _init_05 x
        | Scalar_Sqrt                                    -> _init_05 x
        | Scalar_Exp                                     -> _init_05 x
        | Scalar_Log                                     -> _init_05 x
        | Scalar_Log2                                    -> _init_05 x
        | Scalar_Log10                                   -> _init_05 x
        | Scalar_Signum                                  -> _init_05 x
        | Scalar_Floor                                   -> _init_05 x
        | Scalar_Ceil                                    -> _init_05 x
        | Scalar_Round                                   -> _init_05 x
        | Scalar_Sin                                     -> _init_05 x
        | Scalar_Cos                                     -> _init_05 x
        | Scalar_Tan                                     -> _init_05 x
        | Scalar_Sinh                                    -> _init_05 x
        | Scalar_Cosh                                    -> _init_05 x
        | Scalar_Tanh                                    -> _init_05 x
        | Scalar_Asin                                    -> _init_05 x
        | Scalar_Acos                                    -> _init_05 x
        | Scalar_Atan                                    -> _init_05 x
        | Scalar_Asinh                                   -> _init_05 x
        | Scalar_Acosh                                   -> _init_05 x
        | Scalar_Atanh                                   -> _init_05 x
        | Scalar_Relu                                    -> _init_05 x
        | Scalar_Sigmoid                                 -> _init_05 x
        | Fused_Adagrad (_rate, _eps)                    -> _init_01 x
        | _                                              -> failwith "owl_computation_init:"

        with exn -> (
          Owl_log.error "initialising %s" (node_to_str x);
          raise exn
        )


  and _init_00 x =
    Array.iter _init_term (parents x);
    allocate_from_parent_0 x


  and _init_01 x =
    let par = Array.map (fun p -> _init_term p; p) (parents x) in
    allocate_from_parent_1 x par.(0)


  and _init_02 x =
    let par = Array.map (fun p -> _init_term p; p) (parents x) in
    allocate_from_parent_2 x par.(0) par.(1)


  and _init_03 x =
    let par = Array.map (fun p -> _init_term p; p) (parents x) in
    allocate_from_parent_3 x par.(0) par.(1) par.(2)


  and _init_04 x =
    let par = Array.map (fun p -> _init_term p; p) (parents x) in
    allocate_from_parent_1 x par.(1)


  and _init_05 x = Array.iter _init_term (parents x)


  and _init_06 x =
    let par = Array.map (fun p -> _init_term p; p) (parents x) in
    allocate_from_parent_arr x par

end


(* Make functor ends *)
