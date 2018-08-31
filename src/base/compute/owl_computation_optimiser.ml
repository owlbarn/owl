(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_graph


(* Functor of making a Lazy engine to execute a computation graph. *)

module Make
  (Operator : Owl_computation_operator_sig.Sig)
  = struct

  module Operator = Operator

  open Operator.Symbol

  open Operator.Symbol.Shape.Type

  open Operator.Symbol.Shape.Type.Device


  let rec _optimise_term x =
    Owl_log.debug "optimise %s ..." (node_to_str x);

    if is_valid x = false then (
      (
        match (get_operator x) with
        | Noop                                           -> pattern_003 x
        | Var                                            -> ()
        | Const                                          -> pattern_000 x
        | Empty _shape                                   -> pattern_000 x
        | Zeros _shape                                   -> pattern_000 x
        | Ones _shape                                    -> pattern_000 x
        | Create _shape                                  -> pattern_000 x
        | Sequential _shape                              -> pattern_000 x
        | Uniform _shape                                 -> pattern_000 x
        | Gaussian _shape                                -> pattern_000 x
        | Bernoulli _shape                               -> pattern_000 x
        | Init (_shape, _f)                              -> pattern_000 x
        | Get _i                                         -> pattern_000 x
        | Set _i                                         -> pattern_000 x
        | GetSlice _slice                                -> pattern_000 x
        | SetSlice _slice                                -> pattern_000 x
        | Copy                                           -> pattern_018 x
        | Reset                                          -> pattern_000 x
        | Reshape _shape                                 -> pattern_022 x
        | Reverse                                        -> pattern_000 x
        | Tile _repeats                                  -> pattern_000 x
        | Repeat _repeats                                -> pattern_023 x
        | Concatenate _axis                              -> pattern_000 x
        | Split (_axis, _parts)                          -> pattern_000 x
        | Draw (_axis, _n)                               -> pattern_000 x
        | Map _f                                         -> pattern_000 x
        | Fold (_axis,_f)                                -> pattern_000 x
        | Scan (_axis,_f)                                -> pattern_000 x
        | OneHot _depth                                  -> pattern_000 x
        | Abs                                            -> pattern_000 x
        | Neg                                            -> pattern_000 x
        | Floor                                          -> pattern_000 x
        | Ceil                                           -> pattern_000 x
        | Round                                          -> pattern_000 x
        | Sqr                                            -> pattern_000 x
        | Sqrt                                           -> pattern_000 x
        | Log                                            -> pattern_000 x
        | Log2                                           -> pattern_000 x
        | Log10                                          -> pattern_000 x
        | Exp                                            -> pattern_000 x
        | Sin                                            -> pattern_000 x
        | Cos                                            -> pattern_000 x
        | Tan                                            -> pattern_000 x
        | Sinh                                           -> pattern_000 x
        | Cosh                                           -> pattern_000 x
        | Tanh                                           -> pattern_000 x
        | Asin                                           -> pattern_000 x
        | Acos                                           -> pattern_000 x
        | Atan                                           -> pattern_000 x
        | Asinh                                          -> pattern_000 x
        | Acosh                                          -> pattern_000 x
        | Atanh                                          -> pattern_000 x
        | Min _axis                                      -> pattern_000 x
        | Max _axis                                      -> pattern_000 x
        | Sum _axis                                      -> pattern_000 x
        | SumReduce _axis                                -> pattern_024 x
        | Signum                                         -> pattern_000 x
        | Sigmoid                                        -> pattern_000 x
        | Relu                                           -> pattern_000 x
        | Min'                                           -> pattern_000 x
        | Max'                                           -> pattern_000 x
        | Sum'                                           -> pattern_000 x
        | L1norm'                                        -> pattern_000 x
        | L2norm'                                        -> pattern_000 x
        | L2NormSqr'                                     -> pattern_000 x
        | ClipByValue                                    -> pattern_000 x
        | ClipByL2norm                                   -> pattern_000 x
        | Pow                                            -> pattern_000 x
        | ScalarPow                                      -> pattern_000 x
        | PowScalar                                      -> pattern_000 x
        | Atan2                                          -> pattern_000 x
        | ScalarAtan2                                    -> pattern_000 x
        | Atan2Scalar                                    -> pattern_000 x
        | Add                                            -> pattern_001 x
        | Sub                                            -> pattern_000 x
        | Mul                                            -> pattern_019 x
        | Div                                            -> pattern_007 x
        | AddScalar                                      -> pattern_015 x
        | SubScalar                                      -> pattern_000 x
        | MulScalar                                      -> pattern_000 x
        | DivScalar                                      -> pattern_000 x
        | ScalarAdd                                      -> pattern_000 x
        | ScalarSub                                      -> pattern_000 x
        | ScalarMul                                      -> pattern_014 x
        | ScalarDiv                                      -> pattern_017 x
        | EltEqual                                       -> pattern_000 x
        | EltNotEqual                                    -> pattern_000 x
        | EltLess                                        -> pattern_000 x
        | EltGreater                                     -> pattern_000 x
        | EltLessEqual                                   -> pattern_000 x
        | EltGreaterEqual                                -> pattern_000 x
        | EltEqualScalar                                 -> pattern_000 x
        | EltNotEqualScalar                              -> pattern_000 x
        | EltLessScalar                                  -> pattern_000 x
        | EltGreaterScalar                               -> pattern_000 x
        | EltLessEqualScalar                             -> pattern_000 x
        | EltGreaterEqualScalar                          -> pattern_000 x
        | Conv1d (_padding, _stride)                     -> pattern_000 x
        | Conv2d (_padding, _stride)                     -> pattern_000 x
        | Conv3d (_padding, _stride)                     -> pattern_000 x
        | TransposeConv1d (_padding, _stride)            -> pattern_000 x
        | TransposeConv2d (_padding, _stride)            -> pattern_000 x
        | TransposeConv3d (_padding, _stride)            -> pattern_000 x
        | DilatedConv1d (_padding, _stride, _rate)       -> pattern_000 x
        | DilatedConv2d (_padding, _stride, _rate)       -> pattern_000 x
        | DilatedConv3d (_padding, _stride, _rate)       -> pattern_000 x
        | MaxPool1d (_padding, _kernel, _stride)         -> pattern_000 x
        | MaxPool2d (_padding, _kernel, _stride)         -> pattern_000 x
        | MaxPool3d (_padding, _kernel, _stride)         -> pattern_000 x
        | AvgPool1d (_padding, _kernel, _stride)         -> pattern_000 x
        | AvgPool2d (_padding, _kernel, _stride)         -> pattern_000 x
        | AvgPool3d (_padding, _kernel, _stride)         -> pattern_000 x
        | UpSampling2d (_size)                           -> pattern_000 x
        | Conv1dBackwardInput _stride                    -> pattern_000 x
        | Conv1dBackwardKernel _stride                   -> pattern_000 x
        | Conv2dBackwardInput _stride                    -> pattern_000 x
        | Conv2dBackwardKernel _stride                   -> pattern_000 x
        | Conv3dBackwardInput _stride                    -> pattern_000 x
        | Conv3dBackwardKernel _stride                   -> pattern_000 x
        | TransposeConv1dBackwardInput _stride           -> pattern_000 x
        | TransposeConv1dBackwardKernel _stride          -> pattern_000 x
        | TransposeConv2dBackwardInput _stride           -> pattern_000 x
        | TransposeConv2dBackwardKernel _stride          -> pattern_000 x
        | TransposeConv3dBackwardInput _stride           -> pattern_000 x
        | TransposeConv3dBackwardKernel _stride          -> pattern_000 x
        | DilatedConv1dBackwardInput (_stride, _rate)    -> pattern_000 x
        | DilatedConv1dBackwardKernel (_stride, _rate)   -> pattern_000 x
        | DilatedConv2dBackwardInput (_stride, _rate)    -> pattern_000 x
        | DilatedConv2dBackwardKernel (_stride, _rate)   -> pattern_000 x
        | DilatedConv3dBackwardInput (_stride, _rate)    -> pattern_000 x
        | DilatedConv3dBackwardKernel (_stride, _rate)   -> pattern_000 x
        | MaxPool1dBackward (_padding, _kernel, _stride) -> pattern_000 x
        | MaxPool2dBackward (_padding, _kernel, _stride) -> pattern_000 x
        | MaxPool3dBackward (_padding, _kernel, _stride) -> pattern_000 x
        | AvgPool1dBackward (_padding, _kernel, _stride) -> pattern_000 x
        | AvgPool2dBackward (_padding, _kernel, _stride) -> pattern_000 x
        | AvgPool3dBackward (_padding, _kernel, _stride) -> pattern_000 x
        | UpSampling2dBackward (_size)                   -> pattern_000 x
        | Row                                            -> pattern_000 x
        | Rows _i                                        -> pattern_000 x
        | CopyRowTo                                      -> pattern_000 x
        | CopyColTo                                      -> pattern_000 x
        | Dot (_transa, _transb, _alpha, _beta)          -> pattern_005 x
        | Inv                                            -> pattern_000 x
        | Trace                                          -> pattern_000 x
        | Transpose _axis                                -> pattern_000 x
        | ToRows                                         -> pattern_000 x
        | OfRows                                         -> pattern_000 x
        | Scalar_Add                                     -> pattern_010 x
        | Scalar_Sub                                     -> pattern_010 x
        | Scalar_Mul                                     -> pattern_010 x
        | Scalar_Div                                     -> pattern_010 x
        | Scalar_Pow                                     -> pattern_010 x
        | Scalar_Atan2                                   -> pattern_010 x
        | Scalar_Abs                                     -> pattern_012 x
        | Scalar_Neg                                     -> pattern_012 x
        | Scalar_Sqr                                     -> pattern_012 x
        | Scalar_Sqrt                                    -> pattern_012 x
        | Scalar_Exp                                     -> pattern_012 x
        | Scalar_Log                                     -> pattern_012 x
        | Scalar_Log2                                    -> pattern_012 x
        | Scalar_Log10                                   -> pattern_012 x
        | Scalar_Signum                                  -> pattern_012 x
        | Scalar_Floor                                   -> pattern_012 x
        | Scalar_Ceil                                    -> pattern_012 x
        | Scalar_Round                                   -> pattern_012 x
        | Scalar_Sin                                     -> pattern_012 x
        | Scalar_Cos                                     -> pattern_012 x
        | Scalar_Tan                                     -> pattern_012 x
        | Scalar_Sinh                                    -> pattern_012 x
        | Scalar_Cosh                                    -> pattern_012 x
        | Scalar_Tanh                                    -> pattern_012 x
        | Scalar_Asin                                    -> pattern_012 x
        | Scalar_Acos                                    -> pattern_012 x
        | Scalar_Atan                                    -> pattern_012 x
        | Scalar_Asinh                                   -> pattern_012 x
        | Scalar_Acosh                                   -> pattern_012 x
        | Scalar_Atanh                                   -> pattern_012 x
        | Scalar_Relu                                    -> pattern_012 x
        | Scalar_Sigmoid                                 -> pattern_012 x
        | Fused_Adagrad (_rate, _eps)                    -> pattern_000 x
        | _                                              -> failwith "Owl_computation_optimiser:_optimise_term"
      );
      validate x
    )


  (* dummy pattern *)
  and pattern_000 x =
    Array.iter _optimise_term (parents x)


  (* Add ndarray pattern *)
  and pattern_001 x =
    let parents = parents x in
    let a = parents.(0) in
    let b = parents.(1) in
    _optimise_term a;
    _optimise_term b;
    pattern_002 x;
    pattern_004 x


  (* Add ndarray pattern: x + 0 or 0 + x *)
  and pattern_002 x =
    let x_parents = parents x in
    let a = x_parents.(0) in
    let b = x_parents.(1) in
    if get_operator x = Add then (
      match (get_operator a, get_operator b) with
      | Zeros _, _ -> (
          set_operator x Noop;
          remove_edge a x;
          _optimise_term x
        )
      | _, Zeros _ -> (
          set_operator x Noop;
          remove_edge b x;
          _optimise_term x
        )
      | _, _       -> ()
    )


  (* Noop pattern *)
  and pattern_003 x =
    let parent = (parents x).(0) in
    _optimise_term parent;
    let op = get_operator x in
    let resuable = get_reuse x in
    if op = Noop && resuable then (
      let x_children = children x in
      let parent_children = children parent in
      let merged_children = Owl_utils_array.merge x_children parent_children in
      set_children parent merged_children;
      replace_parent x parent;
      remove_node x
    )


  (* Add ndarray pattern: FMA x * y + z *)
  and pattern_004 x =
    if get_operator x = Add then (
      let x_parents = parents x in
      let a = x_parents.(0) in
      let b = x_parents.(1) in
      if get_operator a = Mul && refnum a = 1 then (
        let new_parents = Owl_utils_array.((parents a) @ [|b|]) in
        set_parents x new_parents;
        replace_child a x;
        set_operator x FMA;
        remove_node a;
      )
      else if get_operator b = Mul && refnum b = 1 then (
        let new_parents = Owl_utils_array.((parents b) @ [|a|]) in
        set_parents x new_parents;
        replace_child b x;
        set_operator x FMA;
        remove_node b;
      )
    )


  (* Gemm pattern :  alpha * x *@ y + beta * z *)
  and pattern_005 x =
    let x_parents = parents x in
    let a = x_parents.(0) in
    let b = x_parents.(1) in
    _optimise_term a;
    _optimise_term b;
    pattern_006 x


  (* Gemm pattern: transpose *)
  and pattern_006 x =
    match get_operator x with
    | Dot (transa, transb, alpha, beta) -> (
        let x_parents = parents x in
        let a = x_parents.(0) in
        let b = x_parents.(1) in
        (
          match get_operator a with
          | Transpose _i -> (
              if refnum a = 1 then (
                let op = Dot (not transa, transb, alpha, beta) in
                set_operator x op;
                let a_parent = (parents a).(0) in
                replace_child a x;
                replace_parent a a_parent;
              )
            )
          | _           -> ()
        );
        (
          match get_operator b with
          | Transpose _i -> (
              if refnum b = 1 then (
                let op = Dot (transa, not transb, alpha, beta) in
                set_operator x op;
                let b_parent = (parents b).(0) in
                replace_child b x;
                replace_parent b b_parent;
              )
            )
          | _           -> ()
        );
      )
    | _                                 -> ()


  (* Div pattern *)
  and pattern_007 x =
    let x_parents = parents x in
    let a = x_parents.(0) in
    let b = x_parents.(1) in
    _optimise_term a;
    _optimise_term b;
    pattern_008 x


  (* Div pattern: 0 / x *)
  and pattern_008 x =
    if get_operator x = Div then (
      let x_parents = parents x in
      let a = x_parents.(0) in
      let b = x_parents.(1) in
      let x_shp = node_shape x in
      match get_operator a with
      | Zeros _ -> (
          remove_edge a x;
          remove_edge b x;
          set_operator x (Zeros x_shp)
        )
      | _       -> ()
    )


  (* div pattern: x / 1 *)
  and pattern_009 x =
    if get_operator x = Div then (
      let x_parents = parents x in
      let b = x_parents.(1) in
      let x_shp = node_shape x in
      match get_operator b with
      | Ones b_shp -> (
          if x_shp = b_shp then (
            remove_edge b x;
            set_operator x Noop;
            _optimise_term x
          )
        )
      | _       -> ()
    )



  (* Binary operator pattern for const scalar *)
  and pattern_010 x =
    let parents = parents x in
    let a = parents.(0) in
    let b = parents.(1) in
    _optimise_term a;
    _optimise_term b;
    match (get_operator a, get_operator b) with
    | Const, Const -> (
        let a_val = node_to_elt a |> elt_to_float in
        let b_val = node_to_elt b |> elt_to_float in
        let c_val = pattern_011 (get_operator x) a_val b_val in
        set_parents x [||];
        set_reuse x false;
        set_operator x Const;
        freeze x;
        (* FIXME: OMG, I need to fix this ... to many conversions *)
        set_value x [| float_to_elt c_val |> unpack_elt |> elt_to_value |];
      )
    | _            -> ()


  (* Binary operator pattern: evaluation function for pattern_010 *)
  and pattern_011 op a b =
    match op with
    | Scalar_Add   -> a +. b
    | Scalar_Sub   -> a -. b
    | Scalar_Mul   -> a *. b
    | Scalar_Div   -> a /. b
    | Scalar_Pow   -> a ** b
    | Scalar_Atan2 -> Pervasives.atan2 a b
    | _            -> failwith "pattern_011: not supported"


  (* Unary operator pattern for const scalar *)
  and pattern_012 x =
    let parents = parents x in
    let a = parents.(0) in
    _optimise_term a;
    match get_operator a with
    | Const -> (
        let a_val = node_to_elt a |> elt_to_float in
        let b_val = pattern_013 (get_operator x) a_val in
        set_parents x [||];
        set_reuse x false;
        set_operator x Const;
        freeze x;
        (* FIXME: OMG, I need to fix this ... to many conversions *)
        set_value x [| float_to_elt b_val |> unpack_elt |> elt_to_value |];
      )
    | _            -> ()


  (* Unary operator pattern: evaluation function for pattern_012 *)
  and pattern_013 op x =
    let open Owl_base_maths in
    match op with
    | Scalar_Abs     -> abs x
    | Scalar_Neg     -> neg x
    | Scalar_Sqr     -> x *. x
    | Scalar_Sqrt    -> sqrt x
    | Scalar_Exp     -> exp x
    | Scalar_Log     -> log x
    | Scalar_Log2    -> log2 x
    | Scalar_Log10   -> log10 x
    | Scalar_Signum  -> signum x
    | Scalar_Floor   -> floor x
    | Scalar_Ceil    -> ceil x
    | Scalar_Round   -> round x
    | Scalar_Sin     -> sin x
    | Scalar_Cos     -> cos x
    | Scalar_Tan     -> tan x
    | Scalar_Sinh    -> sinh x
    | Scalar_Cosh    -> cosh x
    | Scalar_Tanh    -> tanh x
    | Scalar_Asin    -> asin x
    | Scalar_Acos    -> acos x
    | Scalar_Atan    -> atan x
    | Scalar_Asinh   -> asinh x
    | Scalar_Acosh   -> acosh x
    | Scalar_Atanh   -> atanh x
    | Scalar_Relu    -> relu x
    | Scalar_Sigmoid -> sigmoid x
    | _            -> failwith "pattern_013: not supported"


  (* ScalarMul pattern : a $* 0, a $* 1 *)
  and pattern_014 x =
    let x_parents = parents x in
    let a = x_parents.(0) in
    let b = x_parents.(1) in
    _optimise_term a;
    _optimise_term b;
    match (get_operator a, get_operator b) with
    | _, Zeros shp -> (
        set_operator x (Zeros shp);
        set_parents x [||];
        remove_edge a x;
        remove_edge b x;
      )
    | _, Ones shp  -> (
        set_parents x [|a|];
        set_operator x (Create shp);
        remove_edge b x;
      )
    | _            -> ()


  (* ScalarDiv pattern *)
  and pattern_016 x =
    let x_parents = parents x in
    let a = x_parents.(0) in
    let b = x_parents.(1) in
    _optimise_term a;
    _optimise_term b;
    pattern_017 x


  (* ScalarDiv pattern: Adagrad pattern *)
  and pattern_017 x =
    if get_operator x = ScalarDiv then (
      let x_parents = parents x in
      let a = x_parents.(0) in
      let b = x_parents.(1) in
      if get_operator a = Const && get_operator b = Sqrt && refnum b = 1 then (
        let b_parents = parents b in
        let b_a = b_parents.(0) in
        if get_operator b_a = AddScalar && refnum b_a = 1 then (
          let b_a_parents = parents b_a in
          let b_a_a = b_a_parents.(0) in
          let b_a_b = b_a_parents.(1) in
          if get_operator b_a_b = Const then (
            let b_a_b_val = node_to_elt b_a_b |> elt_to_float in
            if b_a_b_val = 1e-32 then (
              let a_val = node_to_elt a |> elt_to_float in
              set_parents x [| b_a_a |];
              replace_child b_a x;
              set_operator x (Fused_Adagrad (a_val, b_a_b_val))
            )
          )
        )
      )
    )


  (* AddScalar pattern : a +$ 0 *)
  and pattern_015 x =
    let x_parents = parents x in
    let a = x_parents.(0) in
    let b = x_parents.(1) in
    _optimise_term a;
    _optimise_term b;
    match (get_operator a, get_operator b) with
    | Zeros shp, _ -> (
        set_parents x [|b|];
        set_operator x (Create shp);
        remove_edge a x;
      )
    | _            -> ()


  (* Copy pattern *)
  and pattern_018 x =
    let a = (parents x).(0) in
    _optimise_term a;
    if refnum a = 1 then (
      set_operator x Noop;
      pattern_003 x
    )


  (* Mul pattern *)
  and pattern_019 x =
    let x_parents = parents x in
    let a = x_parents.(0) in
    let b = x_parents.(1) in
    _optimise_term a;
    _optimise_term b;
    pattern_020 x


  (* Mul pattern : a * 0 or 0 * a *)
  and pattern_020 x =
    if get_operator x = Mul then (
      let x_parents = parents x in
      let a = x_parents.(0) in
      let b = x_parents.(1) in
      let x_shp = node_shape x in
      match (get_operator a, get_operator b) with
      | Zeros _, _ | _, Zeros _ -> (
          set_operator x (Zeros x_shp);
          remove_edge a x;
          remove_edge b x;
        )
      | _, _                    -> ()
    )


  (* Mul pattern : a * 1 or 1 * a *)
  and pattern_021 _x = failwith "pattern_021: not implemented"


  (* Reshape pattern *)
  and pattern_022 x =
    let a = (parents x).(0) in
    _optimise_term a;
    if refnum a = 1 then (
      let x_shp = node_shape x in
      match get_operator a with
      | Zeros _ -> (
          set_operator x (Zeros x_shp);
          remove_edge a x
        )
      | Ones _  -> (
          set_operator x (Ones x_shp);
          remove_edge a x
        )
      | _       -> ()
    )


  (* Repeat pattern *)
  and pattern_023 x =
    let a = (parents x).(0) in
    _optimise_term a;
    if refnum x = 1 then (
      let x_parent = (parents x).(0) in
      let x_children = children x in
      match get_operator x_children.(0) with
      | Add | Sub | Mul | Div | Pow | Min2 | Max2 | Hypot | Atan2 -> (
          let reps =
            match get_operator x with
            | Repeat reps -> reps
            | _           -> failwith "optimiser:pattern_023"
          in
          let optimisable = ref true in
          Array.iter2 (fun d r ->
            if r <> 1 && d <> 1 then optimisable := false
          ) (node_shape x_parent) reps;
          if !optimisable = true then (
            let parent_children = children x_parent in
            let merged_children = Owl_utils_array.merge x_children parent_children in
            set_children x_parent merged_children;
            replace_parent x x_parent;
            remove_node x
          )
        )
      | _                                                         -> ()
    )


  (* SumReduce pattern *)
  and pattern_024 x =
    let x_parents = parents x in
    let a = x_parents.(0) in
    _optimise_term a;
    (* if only reduce along one dimension, change to sum *)
    match get_operator x with
    | SumReduce axis -> (
        if Array.length axis = 1 then (
          set_operator x (Sum axis.(0));
          _optimise_term x
        )
      )
    | _              -> ()


  (* core optimise functions *)

  let estimate_complexity graph =
    let nodes = ref 0 in
    Owl_graph.iter_ancestors (fun _ -> nodes := !nodes + 1) graph;
    let edges = ref 0 in
    Owl_graph.iter_in_edges (fun _ _ -> edges := !edges + 1) graph;
    !nodes, !edges


  let optimise_nodes xs =
    let nodes, edges = estimate_complexity xs in
    Owl_log.info "unoptimised graph: %i nodes, %i edges ..." nodes edges;

    Array.iter _optimise_term xs;
    (* NOTE: invalidate ancestors *)
    iter_ancestors (fun v -> invalidate v) xs;

    let nodes, edges = estimate_complexity xs in
    Owl_log.info "optimised graph: %i nodes, %i edges ..." nodes edges


end

(* Make functor ends *)
