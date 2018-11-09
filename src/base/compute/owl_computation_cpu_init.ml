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

  open Graph.Optimiser.Operator.Symbol.Shape.Type

  module MultiMap = Owl_utils_multimap.Make(
                      struct
                        type t = int
                        let compare : int -> int -> int = compare
                      end)


  (* utility functions *)

  (* cannot overwrite parents *)
  let split_00 p = [||], p


  (* can overwrite parents *)
  let split_01 p = p, [||]


  (* broadcasting nodes can overwrite their parents iff they have the same
   * shape *)
  let split_02 x p =
    let shape_x = node_shape x in
    Owl_utils.Array.filter (fun p -> node_shape p = shape_x) p,
    Owl_utils.Array.filter (fun p -> node_shape p <> shape_x) p


  (* concatenate: can overwrite first parent if axis = 0 *)
  let split_03 p axis =
    if axis = 0 then [|p.(0)|], Array.sub p 1 (Array.length p - 1)
    else split_00 p


  (* return a partition of the parents in two arrays: the parents that the node
   * can safely overwrite during its computation and the others.
   * Written to be safe, but can probably make it more fine-grained for some
   * operations. *)
  let split_parents x =
    let p = Owl_utils.Array.unique (parents x) in
    match get_operator x with
    | Noop                                           -> split_01 p
    | Var                                            -> split_01 p
    | Const                                          -> split_01 p
    | Empty _shape                                   -> split_01 p
    | Zeros _shape                                   -> split_01 p
    | Ones _shape                                    -> split_01 p
    | Create _shape                                  -> split_00 p
    | Sequential _shape                              -> split_00 p
    | Uniform _shape                                 -> split_00 p
    | Gaussian _shape                                -> split_00 p
    | Bernoulli _shape                               -> split_00 p
    | Init (_shape, _f)                              -> split_01 p
    | Get _i                                         -> split_01 p
    | Set _i                                         -> split_01 p
    | GetSlice _slice                                -> split_00 p (* ? *)
    | SetSlice _slice                                -> split_00 p (* ? *)
    | Copy                                           -> split_01 p
    | Reset                                          -> split_01 p
    | Reshape _shape                                 -> split_01 p
    | Reverse                                        -> split_00 p
    | Tile _repeats                                  -> split_00 p
    | Repeat _repeats                                -> split_00 p (* ? *)
    | Pad (_v, _padding)                             -> split_00 p
    | Concatenate axis                               -> split_03 p axis
    | Split (_axis, _parts)                          -> failwith "Split"
    | Draw (_axis, _n)                               -> failwith "Draw"
    | Map _f                                         -> split_01 p
    | Fold (_axis, _f)                               -> split_00 p (* ? *)
    | Scan (_axis, _f)                               -> split_00 p (* ? *)
    | OneHot _depth                                  -> split_00 p (* ? *)
    | Delay _f                                       -> split_01 p
    | DelayArray (_shape, _f)                        -> split_01 p
    | LazyPrint (_max_row, _max_col, _header, _fmt)  -> split_01 p
    | Abs                                            -> split_01 p
    | Neg                                            -> split_01 p
    | Floor                                          -> split_01 p
    | Ceil                                           -> split_01 p
    | Round                                          -> split_01 p
    | Sqr                                            -> split_01 p
    | Sqrt                                           -> split_01 p
    | Log                                            -> split_01 p
    | Log2                                           -> split_01 p
    | Log10                                          -> split_01 p
    | Exp                                            -> split_01 p
    | Sin                                            -> split_01 p
    | Cos                                            -> split_01 p
    | Tan                                            -> split_01 p
    | Sinh                                           -> split_01 p
    | Cosh                                           -> split_01 p
    | Tanh                                           -> split_01 p
    | Asin                                           -> split_01 p
    | Acos                                           -> split_01 p
    | Atan                                           -> split_01 p
    | Asinh                                          -> split_01 p
    | Acosh                                          -> split_01 p
    | Atanh                                          -> split_01 p
    | Min _axis                                      -> split_00 p (* ? *)
    | Max _axis                                      -> split_00 p (* ? *)
    | Sum _axis                                      -> split_00 p (* ? *)
    | SumReduce _axis                                -> split_00 p (* ? *)
    | Signum                                         -> split_01 p
    | Sigmoid                                        -> split_01 p
    | Relu                                           -> split_01 p
    | Min'                                           -> split_01 p
    | Max'                                           -> split_01 p
    | Sum'                                           -> split_01 p
    | L1norm'                                        -> split_01 p
    | L2norm'                                        -> split_01 p
    | L2NormSqr'                                     -> split_01 p
    | ClipByValue                                    -> split_01 p
    | ClipByL2norm                                   -> split_01 p
    | Pow                                            -> split_02 x p
    | ScalarPow                                      -> split_01 p
    | PowScalar                                      -> split_01 p
    | Atan2                                          -> split_02 x p
    | ScalarAtan2                                    -> split_01 p
    | Atan2Scalar                                    -> split_01 p
    | Hypot                                          -> split_02 x p
    | Min2                                           -> split_02 x p
    | Max2                                           -> split_02 x p
    | Add                                            -> split_02 x p
    | Sub                                            -> split_02 x p
    | Mul                                            -> split_02 x p
    | Div                                            -> split_02 x p
    | AddScalar                                      -> split_01 p
    | SubScalar                                      -> split_01 p
    | MulScalar                                      -> split_01 p
    | DivScalar                                      -> split_01 p
    | ScalarAdd                                      -> split_01 p
    | ScalarSub                                      -> split_01 p
    | ScalarMul                                      -> split_01 p
    | ScalarDiv                                      -> split_01 p
    | FMA                                            -> split_02 x p
    | EltEqual                                       -> split_02 x p
    | EltNotEqual                                    -> split_02 x p
    | EltLess                                        -> split_02 x p
    | EltGreater                                     -> split_02 x p
    | EltLessEqual                                   -> split_02 x p
    | EltGreaterEqual                                -> split_02 x p
    | EltEqualScalar                                 -> split_01 p
    | EltNotEqualScalar                              -> split_01 p
    | EltLessScalar                                  -> split_01 p
    | EltGreaterScalar                               -> split_01 p
    | EltLessEqualScalar                             -> split_01 p
    | EltGreaterEqualScalar                          -> split_01 p
    | Conv1d (_padding, _stride)                     -> split_00 p (* condition on pad, ker and str for conv ops? *)
    | Conv2d (_padding, _stride)                     -> split_00 p
    | Conv3d (_padding, _stride)                     -> split_00 p
    | TransposeConv1d (_padding, _stride)            -> split_00 p
    | TransposeConv2d (_padding, _stride)            -> split_00 p
    | TransposeConv3d (_padding, _stride)            -> split_00 p
    | DilatedConv1d (_padding, _stride, _rate)       -> split_00 p
    | DilatedConv2d (_padding, _stride, _rate)       -> split_00 p
    | DilatedConv3d (_padding, _stride, _rate)       -> split_00 p
    | MaxPool1d (_padding, _kernel, _stride)         -> split_00 p (* pool ops? depends on pad? *)
    | MaxPool2d (_padding, _kernel, _stride)         -> split_00 p
    | MaxPool3d (_padding, _kernel, _stride)         -> split_00 p
    | AvgPool1d (_padding, _kernel, _stride)         -> split_00 p
    | AvgPool2d (_padding, _kernel, _stride)         -> split_00 p
    | AvgPool3d (_padding, _kernel, _stride)         -> split_00 p
    | UpSampling2d _size                             -> split_00 p
    | Conv1dBackwardInput _stride                    -> split_00 p
    | Conv1dBackwardKernel _stride                   -> split_00 p
    | Conv2dBackwardInput _stride                    -> split_00 p
    | Conv2dBackwardKernel _stride                   -> split_00 p
    | Conv3dBackwardInput _stride                    -> split_00 p
    | Conv3dBackwardKernel _stride                   -> split_00 p
    | TransposeConv1dBackwardInput _stride           -> split_00 p
    | TransposeConv1dBackwardKernel _stride          -> split_00 p
    | TransposeConv2dBackwardInput _stride           -> split_00 p
    | TransposeConv2dBackwardKernel _stride          -> split_00 p
    | TransposeConv3dBackwardInput _stride           -> split_00 p
    | TransposeConv3dBackwardKernel _stride          -> split_00 p
    | DilatedConv1dBackwardInput (_stride, _rate)    -> split_00 p
    | DilatedConv1dBackwardKernel (_stride, _rate)   -> split_00 p
    | DilatedConv2dBackwardInput (_stride, _rate)    -> split_00 p
    | DilatedConv2dBackwardKernel (_stride, _rate)   -> split_00 p
    | DilatedConv3dBackwardInput (_stride, _rate)    -> split_00 p
    | DilatedConv3dBackwardKernel (_stride, _rate)   -> split_00 p
    | MaxPool1dBackward (_padding, _kernel, _stride) -> split_00 p
    | MaxPool2dBackward (_padding, _kernel, _stride) -> split_00 p
    | MaxPool3dBackward (_padding, _kernel, _stride) -> split_00 p
    | AvgPool1dBackward (_padding, _kernel, _stride) -> split_00 p
    | AvgPool2dBackward (_padding, _kernel, _stride) -> split_00 p
    | AvgPool3dBackward (_padding, _kernel, _stride) -> split_00 p
    | UpSampling2dBackward _size                     -> split_00 p
    | RowNum                                         -> split_01 p
    | ColNum                                         -> split_01 p
    | Row                                            -> failwith "Row"
    | Rows _i                                        -> failwith "Rows"
    | CopyRowTo                                      -> failwith "CopyRowTo"
    | CopyColTo                                      -> failwith "CopyColTo"
    | Dot (_transa, _transb, _alpha, _beta)          -> split_00 p
    | Inv                                            -> split_00 p
    | Trace                                          -> split_01 p
    | Transpose _axis                                -> split_00 p
    | ToRows                                         -> failwith "ToRows"
    | OfRows                                         -> failwith "OfRows"
    | Scalar_Add                                     -> split_01 p
    | Scalar_Sub                                     -> split_01 p
    | Scalar_Mul                                     -> split_01 p
    | Scalar_Div                                     -> split_01 p
    | Scalar_Pow                                     -> split_01 p
    | Scalar_Atan2                                   -> split_01 p
    | Scalar_Abs                                     -> split_01 p
    | Scalar_Neg                                     -> split_01 p
    | Scalar_Sqr                                     -> split_01 p
    | Scalar_Sqrt                                    -> split_01 p
    | Scalar_Exp                                     -> split_01 p
    | Scalar_Log                                     -> split_01 p
    | Scalar_Log2                                    -> split_01 p
    | Scalar_Log10                                   -> split_01 p
    | Scalar_Signum                                  -> split_01 p
    | Scalar_Floor                                   -> split_01 p
    | Scalar_Ceil                                    -> split_01 p
    | Scalar_Round                                   -> split_01 p
    | Scalar_Sin                                     -> split_01 p
    | Scalar_Cos                                     -> split_01 p
    | Scalar_Tan                                     -> split_01 p
    | Scalar_Sinh                                    -> split_01 p
    | Scalar_Cosh                                    -> split_01 p
    | Scalar_Tanh                                    -> split_01 p
    | Scalar_Asin                                    -> split_01 p
    | Scalar_Acos                                    -> split_01 p
    | Scalar_Atan                                    -> split_01 p
    | Scalar_Asinh                                   -> split_01 p
    | Scalar_Acosh                                   -> split_01 p
    | Scalar_Atanh                                   -> split_01 p
    | Scalar_Relu                                    -> split_01 p
    | Scalar_Sigmoid                                 -> split_01 p
    | Fused_Adagrad (_rate, _eps)                    -> split_00 p (* ? *)


  (* Core initialisation function. Inspired by
   * https://mxnet.incubator.apache.org/architecture/note_memory.html. *)
  let _init_terms nodes =
    (* hashtable: node -> its number of references left to use *)
    let refs = Hashtbl.create 256 in
    (* number of elements -> id of a reusable block of corresponding size *)
    let reusable = ref MultiMap.empty in
    (* node id -> id of a block that was assigned to it *)
    let node_to_block = Hashtbl.create 256 in
    (* block id -> its size *)
    let block_to_size = Hashtbl.create 16 in
    (* node id -> the corresponding node *)
    let id_to_node = Hashtbl.create 256 in

    (* already has a block or is already associated to a block id during the
     * execution of the algorithm *)
    let is_initialised x =
      is_assigned x || Hashtbl.mem node_to_block (id x)
    in

    (* Notifies a node that it has been used by one of its children.
     * If no more children have to use the node, assumes that the memory of the
     * node can be reused by another node. *)
    let update_parent p =
      let id_p = id p in
      if not (is_assigned p) && Hashtbl.mem refs id_p then (
        let num = Hashtbl.find refs id_p in
        assert (num > 0);
        if num - 1 = 0 then (* can be reused *) (
          Hashtbl.remove refs id_p;
          let block_id = Hashtbl.find node_to_block id_p in
          let block_size = Hashtbl.find block_to_size block_id in
          reusable := MultiMap.add block_size block_id !reusable
        )
        else Hashtbl.replace refs id_p (num - 1)
      )
    in

    (* Heuristic: return the smallest block that is greater than [numel].
     * If no such block exists, return the biggest one and make it bigger.
     * Time complexity: [O(log b)] where [b] is the size of [reusable]. *)
    let best_block_to_reuse numel =
      if MultiMap.is_empty !reusable then None
      else (
        let to_reuse = MultiMap.find_first_opt (fun k -> k >= numel) !reusable in
        let size, b_id = match to_reuse with
          | Some x -> x
          | None   -> MultiMap.max_binding !reusable
        in
        reusable := MultiMap.remove size !reusable;
        if size < numel then (
          Hashtbl.replace block_to_size b_id numel
        );
        Some b_id
      )
    in

    (* Links node [x] to a new block. *)
    let allocate_new x =
      let numel_x = node_numel x in
      let b_id = new_block_id () in
      Hashtbl.add node_to_block (id x) b_id;
      Hashtbl.add block_to_size b_id numel_x
    in

    (* Links the node [x] to the best reusable block if such a block exists.
     * Otherwise, links [x] to a new block. *)
    let allocate x =
      let numel_x = node_numel x in
      let block_id_to_reuse = best_block_to_reuse numel_x in
      match block_id_to_reuse with
      | Some b_id -> Hashtbl.add node_to_block (id x) b_id
      | None      -> allocate_new x
    in

    (* assume the parents of an initialised node are always initialised *)
    let rec init x =
      Owl_log.debug "init %s ..." (node_to_str x);

      if not (is_initialised x) then (
        Hashtbl.add id_to_node (id x) x;
        Array.iter init (parents x);
        let pre_par, post_par = split_parents x in
        Array.iter update_parent pre_par;
        (* do not bother sharing the memory of single elements *)
        if get_reuse x && not (is_node_elt x) then (
          Hashtbl.add refs (id x) (refnum x);
          allocate x
        )
        else (
          (* a node that cannot be reused cannot reuse either *)
          allocate_new x
        );
        Array.iter update_parent post_par;
      )
    in
    (* link all the nodes to a block id and all the blocks to a size *)
    Array.iter init nodes;

    (* create the blocks and initialise the relevant attributes of the nodes *)
    let id_to_block = Hashtbl.create 16 in
    Hashtbl.iter
      (fun x_id b_id ->
        let x = Hashtbl.find id_to_node x_id in
        if Hashtbl.mem id_to_block b_id then (
          let block = Hashtbl.find id_to_block b_id in
          add_node_to_block x block
        )
        else (
          let size = Hashtbl.find block_to_size b_id in
          let block = make_empty_block ~block_id:b_id size in
          Hashtbl.add id_to_block b_id block;
          add_node_to_block x block
        )
      ) node_to_block


  (* display some statistics about the number of blocks and the number of
   * allocated elements *)
  let init_stats nodes =
    let total_elt = ref 0 in
    let shared_elt = ref 0 in
    let non_shared_elt = ref 0 in
    let total_nodes = ref 0 in
    let reusable_nodes = ref 0 in
    let non_reusable_nodes = ref 0 in
    let blocks_seen = Hashtbl.create 256 in
    let reusable_blocks = ref 0 in
    let alloc_reusable = ref 0 in
    let update_stats x =
      let numel_x = node_numel x in
      total_nodes := !total_nodes + 1;
      total_elt := !total_elt + numel_x;
      if get_reuse x then (
        reusable_nodes := !reusable_nodes + 1;
        shared_elt := !shared_elt + numel_x
      )
      else (
        non_reusable_nodes := !non_reusable_nodes + 1;
        non_shared_elt := !non_shared_elt + numel_x
      );

      let block_x = (get_block x).(0) in

      if not (Hashtbl.mem blocks_seen block_x) then (
        Hashtbl.add blocks_seen block_x None;
        if get_reuse x then (
          reusable_blocks := !reusable_blocks + 1;
          alloc_reusable := !alloc_reusable + block_x.size
        )
      )
    in

    Owl_graph.iter_ancestors update_stats nodes;

    let b = Buffer.create 170 in
    Buffer.add_string b "*** INITIALISATION STATISTICS ***\n";
    Buffer.add_string b
      (Printf.sprintf "  %d nodes, %d elements\n" !total_nodes !total_elt);
    Buffer.add_string b
      (Printf.sprintf "  %d reusable nodes, %d elements\n"
        !reusable_nodes !shared_elt);
    Buffer.add_string b
      (Printf.sprintf "  %d non-reusable nodes, %d elements\n"
        !non_reusable_nodes !non_shared_elt);
    Buffer.add_string b
      (Printf.sprintf "  %d shared blocks, %d elements\n"
        !reusable_blocks !alloc_reusable);
    Buffer.add_string b
      (Printf.sprintf "  TOTAL NUMBER OF ALLOCATED ELEMENTS: %d\n"
        (!alloc_reusable + !non_shared_elt));
    Owl_log.info "%s" (Buffer.contents b)


end


(* Make functor ends *)
