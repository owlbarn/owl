(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Owl_graph


(* Functor of making the symbols of a computation graph. *)

module Make
  (A : Ndarray_Algodiff)
  (D : Computation_Device)
  = struct

  include Owl_computation_shape.Make (A) (D)


  (* convert symbols to strings *)

  let op_to_str = function
    | Noop                                        -> "Noop"
    | Var                                         -> "Var"
    | Const                                       -> "Const"
    | Empty shape                                 -> "Empty"
    | Zeros shape                                 -> "Zeros"
    | Ones shape                                  -> "Ones"
    | Create shape                                -> "Create"
    | Sequential                                  -> "Sequential"
    | Uniform shape                               -> "Uniform"
    | Gaussian                                    -> "Gaussian"
    | Bernoulli (p, shape)                        -> Printf.sprintf "Bernoulli p:%g" p
    | Init (shape, f)                             -> "Init"
    | Get i                                       -> "Get"
    | Set i                                       -> "Set"
    | GetSlice slice                              -> "GetSlice"
    | SetSlice slice                              -> "SetSlice"
    | Copy                                        -> "Copy"
    | Reset                                       -> "Reset"
    | Reshape shape                               -> "Reshape"
    | Reverse                                     -> "Reverse"
    | Tile repeats                                -> "Tile"
    | Repeat (axis, repeats)                      -> "Repeat"
    | Concatenate axis                            -> "Concatenate"
    | Split (axis, parts)                         -> "Split"
    | Draw (axis, n)                              -> "Draw"
    | Map f                                       -> "Map"
    | Fold (axis, f)                              -> "Fold"
    | Scan (axis, f)                              -> "Scan"
    | OneHot depth                                -> Printf.sprintf "OneHot d:%i" depth
    | Abs                                         -> "Abs"
    | Neg                                         -> "Neg"
    | Floor                                       -> "Floor"
    | Ceil                                        -> "Ceil"
    | Round                                       -> "Round"
    | Sqr                                         -> "Sqr"
    | Sqrt                                        -> "Sqrt"
    | Log                                         -> "Log"
    | Log2                                        -> "Log2"
    | Log10                                       -> "Log10"
    | Exp                                         -> "Exp"
    | Sin                                         -> "Sin"
    | Cos                                         -> "Cos"
    | Tan                                         -> "Tan"
    | Sinh                                        -> "Sinh"
    | Cosh                                        -> "Cosh"
    | Tanh                                        -> "Tanh"
    | Asin                                        -> "Asin"
    | Acos                                        -> "Acos"
    | Atan                                        -> "Atan"
    | Asinh                                       -> "Asinh"
    | Acosh                                       -> "Acosh"
    | Atanh                                       -> "Atanh"
    | Min axis                                    -> Printf.sprintf "Min axis:%i" axis
    | Max axis                                    -> Printf.sprintf "Max axis:%i" axis
    | Sum axis                                    -> Printf.sprintf "Sum axis:%i" axis
    | SumReduce axis                              -> "SumReduce"
    | Signum                                      -> "Signum"
    | Sigmoid                                     -> "Sigmoid"
    | Relu                                        -> "Relu"
    | Min'                                        -> "Min'"
    | Max'                                        -> "Max'"
    | Sum'                                        -> "Sum'"
    | L1norm'                                     -> "L1norm'"
    | L2norm'                                     -> "L2norm'"
    | L2NormSqr'                                  -> "L2NormSqr'"
    | ClipByValue                                 -> "ClipByValue"
    | ClipByL2norm                                -> "ClipByL2norm"
    | Pow                                         -> "Pow"
    | ScalarPow                                   -> "ScalarPow"
    | PowScalar                                   -> "PowScalar"
    | Atan2                                       -> "Atan2"
    | ScalarAtan2                                 -> "ScalarAtan2"
    | Atan2Scalar                                 -> "Atan2Scalar"
    | Hypot                                       -> "Hypot"
    | Min2                                        -> "Min2"
    | Max2                                        -> "Max2"
    | Add                                         -> "Add"
    | Sub                                         -> "Sub"
    | Mul                                         -> "Mul"
    | Div                                         -> "Div"
    | AddScalar                                   -> "AddScalar"
    | SubScalar                                   -> "SubScalar"
    | MulScalar                                   -> "MulScalar"
    | DivScalar                                   -> "DivScalar"
    | ScalarAdd                                   -> "ScalarAdd"
    | ScalarSub                                   -> "ScalarSub"
    | ScalarMul                                   -> "ScalarMul"
    | ScalarDiv                                   -> "ScalarDiv"
    | FMA                                         -> "FMA"
    | EltEqual                                    -> "EltEqual"
    | EltNotEqual                                 -> "EltNotEqual"
    | EltLess                                     -> "EltLess"
    | EltGreater                                  -> "EltGreater"
    | EltLessEqual                                -> "EltLessEqual"
    | EltGreaterEqual                             -> "EltGreaterEqual"
    | EltEqualScalar                              -> "EltEqualScalar"
    | EltNotEqualScalar                           -> "EltNotEqualScalar"
    | EltLessScalar                               -> "EltLessScalar"
    | EltGreaterScalar                            -> "EltGreaterScalar"
    | EltLessEqualScalar                          -> "EltLessEqualScalar"
    | EltGreaterEqualScalar                       -> "EltGreaterEqualScalar"
    | Conv1d (padding, stride)                    -> "Conv1d"
    | Conv2d (padding, stride)                    -> "Conv2d"
    | Conv3d (padding, stride)                    -> "Conv3d"
    | TransposeConv1d (padding, stride)           -> "TransposeConv1d"
    | TransposeConv2d (padding, stride)           -> "TransposeConv2d"
    | TransposeConv3d (padding, stride)           -> "TransposeConv3d"
    | DilatedConv1d (padding, stride, rate)       -> "DilatedConv1d"
    | DilatedConv2d (padding, stride, rate)       -> "DilatedConv2d"
    | DilatedConv3d (padding, stride, rate)       -> "DilatedConv3d"
    | MaxPool1d (padding, kernel, stride)         -> "MaxPool1d"
    | MaxPool2d (padding, kernel, stride)         -> "MaxPool2d"
    | MaxPool3d (padding, kernel, stride)         -> "MaxPool3d"
    | AvgPool1d (padding, kernel, stride)         -> "AvgPool1d"
    | AvgPool2d (padding, kernel, stride)         -> "AvgPool2d"
    | AvgPool3d (padding, kernel, stride)         -> "AvgPool3d"
    | Conv1dBackwardInput stride                  -> "Conv1dBackwardInput"
    | Conv1dBackwardKernel stride                 -> "Conv1dBackwardKernel"
    | Conv2dBackwardInput stride                  -> "Conv2dBackwardInput"
    | Conv2dBackwardKernel stride                 -> "Conv2dBackwardKernel"
    | Conv3dBackwardInput stride                  -> "Conv3dBackwardInput"
    | Conv3dBackwardKernel stride                 -> "Conv3dBackwardKernel"
    | TransposeConv1dBackwardInput stride         -> "TransposeConv1dBackwardInput"
    | TransposeConv1dBackwardKernel stride        -> "TransposeConv1dBackwardKernel"
    | TransposeConv2dBackwardInput stride         -> "TransposeConv2dBackwardInput"
    | TransposeConv2dBackwardKernel stride        -> "TransposeConv2dBackwardKernel"
    | TransposeConv3dBackwardInput stride         -> "TransposeConv3dBackwardInput"
    | TransposeConv3dBackwardKernel stride        -> "TransposeConv3dBackwardKernel"
    | DilatedConv1dBackwardInput (stride, rate)   -> "DilatedConv1dBackwardInput"
    | DilatedConv1dBackwardKernel (stride, rate)  -> "DilatedConv1dBackwardKernel"
    | DilatedConv2dBackwardInput (stride, rate)   -> "DilatedConv2dBackwardInput"
    | DilatedConv2dBackwardKernel (stride, rate)  -> "DilatedConv2dBackwardKernel"
    | DilatedConv3dBackwardInput (stride, rate)   -> "DilatedConv3dBackwardInput"
    | DilatedConv3dBackwardKernel (stride, rate)  -> "DilatedConv3dBackwardKernel"
    | MaxPool1dBackward (padding, kernel, stride) -> "MaxPool1dBackward"
    | MaxPool2dBackward (padding, kernel, stride) -> "MaxPool2dBackward"
    | MaxPool3dBackward (padding, kernel, stride) -> "MaxPool3dBackward"
    | AvgPool1dBackward (padding, kernel, stride) -> "AvgPool1dBackward"
    | AvgPool2dBackward (padding, kernel, stride) -> "AvgPool2dBackward"
    | AvgPool3dBackward (padding, kernel, stride) -> "AvgPool3dBackward"
    | RowNum                                      -> "RowNum"
    | ColNum                                      -> "ColNum"
    | Row                                         -> "Row"
    | Rows i                                      -> "Rows"
    | CopyRowTo                                   -> "CopyRowTo"
    | CopyColTo                                   -> "CopyColTo"
    | Dot (transa, transb, alpha, beta)           -> "Dot"
    | Inv                                         -> "Inv"
    | Trace                                       -> "Trace"
    | Transpose i                                 -> "Transpose"
    | ToRows                                      -> "ToRows"
    | OfRows                                      -> "OfRows"
    | Scalar_Add                                  -> "Scalar Add"
    | Scalar_Sub                                  -> "Scalar Sub"
    | Scalar_Mul                                  -> "Scalar Mul"
    | Scalar_Div                                  -> "Scalar Div"
    | Scalar_Pow                                  -> "Scalar Pow"
    | Scalar_Atan2                                -> "Scalar Atan2"
    | Scalar_Abs                                  -> "Scalar Abs"
    | Scalar_Neg                                  -> "Scalar Neg"
    | Scalar_Sqr                                  -> "Scalar Sqr"
    | Scalar_Sqrt                                 -> "Scalar Sqrt"
    | Scalar_Exp                                  -> "Scalar Exp"
    | Scalar_Log                                  -> "Scalar Log"
    | Scalar_Log2                                 -> "Scalar Log2"
    | Scalar_Log10                                -> "Scalar Log10"
    | Scalar_Signum                               -> "Scalar Signum"
    | Scalar_Floor                                -> "Scalar Floor"
    | Scalar_Ceil                                 -> "Scalar Ceil"
    | Scalar_Round                                -> "Scalar Round"
    | Scalar_Sin                                  -> "Scalar Sin"
    | Scalar_Cos                                  -> "Scalar Cos"
    | Scalar_Tan                                  -> "Scalar Tan"
    | Scalar_Sinh                                 -> "Scalar Sinh"
    | Scalar_Cosh                                 -> "Scalar Cosh"
    | Scalar_Tanh                                 -> "Scalar Tanh"
    | Scalar_Asin                                 -> "Scalar Asin"
    | Scalar_Acos                                 -> "Scalar Acos"
    | Scalar_Atan                                 -> "Scalar Atan"
    | Scalar_Asinh                                -> "Scalar Asinh"
    | Scalar_Acosh                                -> "Scalar Acosh"
    | Scalar_Atanh                                -> "Scalar Atanh"
    | Scalar_Relu                                 -> "Scalar Relu"
    | Scalar_Sigmoid                              -> "Scalar Sigmoid"
    | Fused_Adagrad (rate, eps)                   -> "Fused_Adagrad"


  (* Helper functions *)

  let refnum x = Owl_graph.outdegree x


  let is_shape_unkown x =
    let x_shape = (attr x).shape in
    match x_shape.(0) with
    | Some _ -> true
    | None   -> false


  let infer_shape_graph xs =
    iter_descendants (fun x ->
      if is_shape_unkown x = false then (
        let x_attr = attr x in
        let x_parents = parents x in
        x_attr.shape <- infer_shape x_attr.op x_parents
      )
    ) xs


  let shape_to_str shp =
    assert (Array.length shp > 0);
    let s = match shp.(0) with
      | Some s -> Owl_utils_array.to_string string_of_int s
      | None   -> "unkown"
    in
    Printf.sprintf "[%s]" s


  let node_to_str n =
    let attr = attr n in
    let shape_s = shape_to_str attr.shape in
    let state_s = if attr.state = Valid then "valid" else "invalid" in
    Printf.sprintf "[ #%i | name:%s | op:%s | state:%s | r:%i | s:%s ]"
      (id n) (name n) (op_to_str attr.op) state_s (refnum n) shape_s


  (* core manipulation functions *)

  let node_to_arr x = Arr x


  let arr_to_node = function Arr x -> x


  let node_to_elt x = Elt x


  let elt_to_node = function Elt x -> x


  let make_node ?name ?value ?shape ?freeze ?reuse ?state op =
    let value = match value with Some v -> v | None -> [| |] in
    let shape = match shape with Some s -> s | None -> [| None |] in
    let state = match state with Some s -> s | None -> Invalid in
    let reuse = match reuse with Some s -> s | None -> true in
    let freeze = match freeze with Some s -> s | None -> false in
    let vnode = [| (* used by the computation engine *) |] in
    Owl_graph.node ?name { op; freeze; reuse; state; shape; value; vnode }


  let make_then_connect ?shape op parents =
    let shape = match shape with
      | Some s -> s
      | None   -> infer_shape op parents
    in
    let child = make_node ~shape op in
    Array.iter (fun parent ->
      if (attr parent).freeze = true then
        connect_ancestors [|parent|] [|child|]
      else
        connect [|parent|] [|child|]
    ) parents;
    (* connect parents [|child|]; *)
    child


  let var_arr ?shape name =
    make_node ~name ~shape:[| shape |] ~reuse:false Var
    |> node_to_arr


  let var_elt name =
    make_node ~name ~shape:[| Some [||] |] ~reuse:false Var
    |> node_to_elt


  let const_arr name v =
    let value = [| arr_to_value v |] in
    let shape = [| Some A.(shape v) |] in
    make_node ~name ~value ~shape ~freeze:true ~reuse:false ~state:Valid Const
    |> node_to_arr


  let const_elt name v =
    let value = [| elt_to_value v |] in
    let shape = [| Some [||] |] in
    make_node ~name ~value ~shape ~freeze:true ~reuse:false ~state:Valid Const
    |> node_to_elt


  let set_value x v = (attr x).value <- v


  let get_value x = (attr x).value


  let set_operator x op = (attr x).op <- op


  let get_operator x = (attr x).op


  let set_reuse x reuse =
    let op = (attr x).op in
    if op = Var && op = Const then
      Owl_log.warn "set_reuse: ignored, %s" (node_to_str x)
    else
      (attr x).reuse <- reuse


  let get_reuse x = (attr x).reuse


  let set_vnode x v = (attr x).vnode <- v


  let get_vnode x = (attr x).vnode


  let is_inherited x = Array.length (get_vnode x) > 0


  let is_var x = (attr x).op = Var


  let is_const x = (attr x).op = Const


  let is_arr x =
    match (attr x).shape.(0) with
    | Some [||] -> false
    | Some _    -> true
    | _         -> failwith "Owl_computation_symbol:is_arr"


  let is_elt x =
    match (attr x).shape.(0) with
    | Some [||] -> true
    | Some _    -> false
    | _         -> failwith "Owl_computation_symbol:is_elt"


  let is_assigned x =
    let value = (attr x).value in
    let valen = Array.length value in
    valen > 0


  let check_assigned x =
    let value = (attr x).value in
    let valen = Array.length value in
    if valen = 0 then (
      Owl_log.error "value not assigned: %s" (node_to_str x);
      assert (valen > 0)
    )


  let is_valid x = (attr x).state = Valid


  let validate x = (attr x).state <- Valid


  let invalidate x = (attr x).state <- Invalid


  let invalidate_graph x = iter_descendants invalidate [|x|]


  let is_freeze x = (attr x).freeze


  let freeze x = (attr x).freeze <- true


  let freeze_descendants x = iter_descendants freeze x


  let freeze_ancestors x = iter_ancestors freeze x


  let pack_arr arr = const_arr "" arr


  let unpack_arr x =
    let value = (arr_to_node x |> attr).value in
    let valen = Array.length value in
    if valen = 0 then (
      Owl_log.error "value not assigned: %s" (arr_to_node x |> node_to_str);
      assert (valen > 0)
    );
    value_to_arr value.(0)


  let pack_elt elt = const_elt "" elt


  let unpack_elt x =
    let value = (elt_to_node x |> attr).value in
    let valen = Array.length value in
    if valen = 0 then (
      Owl_log.error "value not assigned: %s" (elt_to_node x |> node_to_str);
      assert (valen > 0)
    );
    value_to_elt value.(0)


  let unsafe_assign_arr x arr =
    let node = arr_to_node x in
    if is_var node then (
      if is_assigned node = false then (
        (attr node).shape <- [| Some A.(shape arr) |];
        infer_shape_graph [| node |]
      );
      set_value node [| arr_to_value arr |];
      invalidate_graph node
    )
    else
      let info = node_to_str node in
      Printf.sprintf "unsafe_assign_arr: const cannot be assigned, %s" info
      |> failwith


  let assign_arr x arr =
    let node = arr_to_node x in
    if is_var node then (
      if is_assigned node then (
        let dst = unpack_arr x in
        A.copy_to arr dst
      )
      else (
        let dst = A.copy arr in
        set_value node [| arr_to_value dst |];
        (* propagate the shape information *)
        (attr node).shape <- [| Some A.(shape dst) |];
        infer_shape_graph [| node |]
      );
      invalidate_graph node
    )
    else
      let info = node_to_str node in
      Printf.sprintf "assign_arr: const cannot be assigned, %s" info
      |> failwith


  let assign_elt x elt =
    let node = elt_to_node x in
    if is_var node then (
      set_value node [| elt_to_value elt |];
      invalidate_graph node
    )
    else
      let info = node_to_str node in
      Printf.sprintf "assign_elt: const cannot be assigned, %s" info
      |> failwith


  (* TODO: should move to symbolic ... *)
  let arr_to_var x =
    let attr   = arr_to_node x |> attr in
    let op     = attr.op in
    let freeze = attr.freeze in
    let reuse  = false in
    let state  = attr.state in
    let shape  = attr.shape in
    let value  = attr.value in
    let vnode  = attr.vnode in
    Owl_graph.node ~name:"" { op; state; reuse; freeze; shape; value; vnode }
    |> node_to_arr


  let float_to_elt x = const_elt "" (A.float_to_elt x)


  let elt_to_float x = unpack_elt x |> A.elt_to_float


  (* print shape for ndarrays, whilst value for scalars *)
  let shape_or_value x =
    let shape = (attr x).shape in
    if is_assigned x = true then (
      match shape.(0) with
      | Some s -> (
          if Array.length s = 0 then
            Printf.sprintf "v:%g" (node_to_elt x |> elt_to_float)
          else
            Printf.sprintf "s:%s" (shape_to_str shape)
        )
      | None   -> Printf.sprintf "s:%s" (shape_to_str shape)
    )
    else
      Printf.sprintf "s:%s" (shape_to_str shape)


  let nodes_to_dot x =
    let edge_s = fold_in_edges (fun a u v -> Printf.sprintf "%s%i -> %i;\n" a (id u) (id v)) "" x in
    let node_s = fold_ancestors (fun a n ->
      let svs = shape_or_value n in
      Printf.sprintf "%s%i [ label=\"{{#%i | { %s | %s }} | r:%i; %s }\" ];\n"
        a (id n) (id n) (name n) (op_to_str (attr n).op) (refnum n) svs
    ) "" x
    in
    Printf.sprintf "digraph CG {\nnode [shape=record];\n%s%s}" edge_s node_s


  let to_trace x = "to_trace: not implemented yet"


end
