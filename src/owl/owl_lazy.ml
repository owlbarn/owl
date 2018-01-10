(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Owl_graph


(* Functor of making Lazy module of different number types *)

module Make (A : InpureSig) = struct

  (* type definitions *)

  type state = Valid | Invalid

  type value =
    | Elt of A.elt
    | Arr of A.arr

  type t = attr node
  and attr = {
    mutable op    : op;             (* function in the node *)
    mutable state : state;          (* indicate the validity *)
    mutable value : value array;    (* save the calculated value *)
  }
  and op =
    | Var
    | Const
    | Fun00 of (A.arr -> A.arr)
    | Fun01 of (A.arr -> unit)
    | Fun02 of (A.arr -> A.arr -> unit) * (A.arr -> A.arr -> A.arr)
    | Fun03 of (A.arr -> A.elt -> unit)
    | Fun04 of (A.elt -> A.arr -> unit)
    | Fun05 of (A.arr array -> A.arr)
    | Fun06 of (A.arr -> A.arr array)
    | Fun07 of (A.arr -> A.elt)
    | Fun08 of (t array -> t)
    | ItemI of int (* get the ith output value *)


  (* core functions to manipulate computation graphs *)

  let node ?(name="") ?(state=Invalid) ?(value=[||]) op =
    Owl_graph.node ~name ~prev:[||] ~next:[||] { op; state; value }

  let refnum x = Owl_graph.outdegree x

  let unpack_arr = function Arr x -> x | _ -> failwith "owl_lazy: unpack_arr"

  let unpack_elt = function Elt x -> x | _ -> failwith "owl_lazy: unpack_elt"

  let shall_eval x =
    let a = attr x in
    Array.length a.value = 0 || a.state = Invalid

  let is_var x = (attr x).op = Var

  let is_const x = (attr x).op = Const

  let is_assigned x = assert (Array.length (attr x).value > 0)

  let is_valid x = (attr x).state = Valid

  let validate x = (attr x).state <- Valid

  let invalidate x =
    let a = attr x in
    a.state <- Invalid;
    a.value <- [||]

  let invalidate_graph x = iter_descendants DFS invalidate [|x|]

  let variable () = node ~name:"variable" ~value:[||] Var

  let assign x x_val =
    let a = attr x in
    assert (a.op = Var);
    invalidate_graph x;
    a.value <- [|x_val|]

  let assign_arr x x_val = assign x (Arr x_val)

  let assign_elt x x_val = assign x (Elt x_val)

  let to_arr x = unpack_arr (attr x).value.(0)

  let to_elt x = unpack_elt (attr x).value.(0)

  let of_arr x = node ~name:"const" ~value:[|Arr x|] Const

  let of_elt x = node ~name:"const" ~value:[|Elt x|] Const


  (* pretty printing and print out computation graph *)

  let op_to_str = function
    | Fun00 _ -> "arr"
    | Fun01 _ -> "arr"
    | Fun02 _ -> "arr"
    | Fun03 _ -> "arr"
    | Fun04 _ -> "arr"
    | Fun05 _ -> "arr"
    | Fun06 _ -> "arr array"
    | Fun07 _ -> "elt"
    | Fun08 _ -> "t array"
    | _       -> ""

  let type_to_str = function Elt _ -> "elt" | Arr _ -> "arr"

  let state_to_str = function Valid -> "valid" | Invalid -> "invalid"

  let node_to_str show_id x =
    let id = if show_id then Printf.sprintf " #%i" (id x) else "" in
    Printf.sprintf "[%s name:%s state:%s ]"
    id (name x) (state_to_str (attr x).state)

  let pp_lazy formatter x =
    Format.open_box 0;
    Format.fprintf formatter "%s\n" (node_to_str false x);
    Format.close_box ()

  let to_trace x = Owl_graph.to_string false (node_to_str true) x

  let to_dot x =
    let x = Array.of_list x in
    let topo_s = ref "" in
    let attr_s = ref "" in
    iter_ancestors DFS (fun n ->
      Array.iter (fun p -> topo_s := !topo_s ^ Printf.sprintf "%i -> %i;\n" (id p) (id n)) (parents n);
      attr_s := !attr_s ^ Printf.sprintf "%i [ label=\"#%i | { %s | %s }\" ];\n" (id n) (id n) (name n) (op_to_str (attr n).op);
    ) x;
    Printf.sprintf "digraph CG {\nnode [shape=record];\n%s}" (!topo_s ^ !attr_s)


  (* allocate memory and evaluate experssions *)

  let allocate_1 x =
    let x_val = unpack_arr (attr x).value.(0) in
    if refnum x = 1 && is_var x = false then (
      invalidate x;
      x_val
    )
    else A.copy x_val


  let allocate_2 x y =
    let x_val = unpack_arr (attr x).value.(0) in
    let y_val = unpack_arr (attr y).value.(0) in
    let x_shp = A.shape x_val in
    let y_shp = A.shape y_val in
    if x_shp = y_shp then (
      if refnum x = 1 && is_var x = false then (
        invalidate x;
        Some (x_val, y_val)
      )
      else if refnum y = 1 && is_var y = false then (
        invalidate y;
        Some (y_val, x_val)
      )
      else if refnum x = 2 && x == y && is_var x = false then (
        invalidate x;
        Some (x_val, y_val)
      )
      else Some (A.copy x_val, y_val)
    )
    else if Owl_utils.array_greater_eqaul x_shp y_shp && refnum x = 1 && is_var x = false then (
      invalidate x;
      Some (x_val, y_val)
    )
    else if Owl_utils.array_greater_eqaul y_shp x_shp && refnum y = 1 && is_var y = false then (
      invalidate y;
      Some (y_val, x_val)
    )
    else None


  let rec _eval_term x =
    if shall_eval x then (
      let _ = match (attr x).op with
        | Var          -> is_assigned x
        | Fun00 f      -> _eval_map0 x f
        | Fun01 f      -> _eval_map1 x f
        | Fun02 (f, g) -> _eval_map2 x f g
        | Fun03 f      -> _eval_map3 x f
        | Fun04 f      -> _eval_map4 x f
        | Fun05 f      -> _eval_map5 x f
        | Fun06 f      -> ()
        | Fun07 f      -> _eval_map7 x f
        | Fun08 f      -> _eval_map8 x f
        | ItemI i      -> _item_i x i
        | _            -> ()
      in
      validate x
    )

  (* [f] is pure, shape changes so always allocate mem, for [arr -> arr] *)
  and _eval_map0 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = (attr x_parent).value.(0) |> unpack_arr |> f in
    (attr x).value <- [|Arr a|]

  (* [f] is inpure, for [arr -> arr] *)
  and _eval_map1 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = allocate_1 x_parent in
    f a;
    (attr x).value <- [|Arr a|]

  (* [f] is inpure and [g] is pure, for [arr -> arr -> arr] *)
  and _eval_map2 x f g =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = unpack_arr (attr x_parent_0).value.(0) in
    let b = unpack_arr (attr x_parent_1).value.(0) in
    let c = match allocate_2 x_parent_0 x_parent_1 with
      | Some (p, q) -> f p q; p    (* in-place function, p will be written *)
      | None        -> g a b       (* pure function without touching a and b *)
    in
    (attr x).value <- [|Arr c|]

  (* [f] is inpure, for [arr -> elt -> arr] *)
  and _eval_map3 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = allocate_1 x_parent_0 in
    let b = unpack_elt (attr x_parent_1).value.(0) in
    f a b;
    (attr x).value <- [|Arr a|]

  (* [f] is inpure, for [elt -> arr -> arr] *)
  and _eval_map4 x f =
    let x_parent_0 = (parents x).(0) in
    let x_parent_1 = (parents x).(1) in
    _eval_term x_parent_0;
    _eval_term x_parent_1;
    let a = unpack_elt (attr x_parent_0).value.(0) in
    let b = allocate_1 x_parent_1 in
    f a b;
    (attr x).value <- [|Arr b|]

  (* [f] is pure, shape changes so always allocate mem, for [arr array -> arr] *)
  and _eval_map5 x f =
    let a = Array.map (fun x ->
      _eval_term x;
      unpack_arr (attr x).value.(0)
    ) (parents x) |> f
    in
    (attr x).value <- [|Arr a|]

  (* [f] is pure, for [arr -> elt] *)
  and _eval_map7 x f =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    let a = (attr x_parent).value.(0) |> unpack_arr |> f in
    (attr x).value <- [|Elt a|]

  (* [f] is pure and always allocates mem, for [node array -> node] *)
  and _eval_map8 x f =
    let x_parents = parents x in
    Array.iter _eval_term x_parents;
    let y = f x_parents in
    assert (is_const y = true);
    (attr x).value <- (attr y).value

  (* get the ith output value of [x] *)
  and _item_i x i =
    let x_parent = (parents x).(0) in
    _eval_term x_parent;
    assert (i < Array.length (attr x_parent).value);
    (attr x).value <- [|(attr x_parent).value.(i)|]


  let eval x = _eval_term x


  let _make_node name op x =
    let y = node ~name op in
    connect x [|y|];
    y


  (* properties and manipulations *)

  let map ?(name="map") f x = _make_node name (Fun08 f) x

  let tile x reps = _make_node "tile" (Fun00 (fun x -> A.tile x reps)) [|x|]

  let repeat ?axis x reps = _make_node "repeat" (Fun00 (fun x -> A.repeat ?axis x reps)) [|x|]

  let concatenate ?axis x = _make_node "concatenate" (Fun05 (A.concatenate ?axis)) x


  (* unary and binary math functions *)

  let add x y = _make_node "add" (Fun02 (A.add_, A.add)) [|x; y|]

  let sub x y = _make_node "sub" (Fun02 (A.sub_, A.sub)) [|x; y|]

  let mul x y = _make_node "mul" (Fun02 (A.mul_, A.mul)) [|x; y|]

  let div x y = _make_node "div" (Fun02 (A.div_, A.div)) [|x; y|]

  let pow x y = _make_node "pow" (Fun02 (A.pow_, A.pow)) [|x; y|]

  let atan2 x y = _make_node "atan2" (Fun02 (A.atan2_, A.atan2)) [|x; y|]

  let hypot x y = _make_node "hypot" (Fun02 (A.hypot_, A.hypot)) [|x; y|]

  let fmod x y = _make_node "fmod" (Fun02 (A.fmod_, A.fmod)) [|x; y|]

  let min2 x y = _make_node "min2" (Fun02 (A.min2_, A.min2)) [|x; y|]

  let max2 x y = _make_node "max2" (Fun02 (A.max2_, A.max2)) [|x; y|]

  let dot x y = _make_node "dot" (Fun05 (fun x -> A.dot x.(0) x.(1))) [|x; y|]

  let add_scalar x a = _make_node "add_scalar" (Fun03 A.add_scalar_) [|x; a|]

  let sub_scalar x a = _make_node "sub_scalar" (Fun03 A.sub_scalar_) [|x; a|]

  let mul_scalar x a = _make_node "mul_scalar" (Fun03 A.mul_scalar_) [|x; a|]

  let div_scalar x a = _make_node "div_scalar" (Fun03 A.div_scalar_) [|x; a|]

  let pow_scalar x a = _make_node "pow_scalar" (Fun03 A.pow_scalar_) [|x; a|]

  let atan2_scalar x a = _make_node "atan2_scalar" (Fun03 A.atan2_scalar_) [|x; a|]

  let fmod_scalar x a = _make_node "fmod_scalar" (Fun03 A.fmod_scalar_) [|x; a|]

  let scalar_add a x = _make_node "scalar_add" (Fun04 A.scalar_add_) [|a; x|]

  let scalar_sub a x = _make_node "scalar_sub" (Fun04 A.scalar_sub_) [|a; x|]

  let scalar_mul a x = _make_node "scalar_mul" (Fun04 A.scalar_mul_) [|a; x|]

  let scalar_div a x = _make_node "scalar_div" (Fun04 A.scalar_div_) [|a; x|]

  let scalar_pow a x = _make_node "scalar_pow" (Fun04 A.scalar_pow_) [|a; x|]

  let scalar_atan2 a x = _make_node "scalar_atan2" (Fun04 A.scalar_atan2_) [|a; x|]

  let scalar_fmod a x = _make_node "scalar_fmod" (Fun04 A.scalar_fmod_) [|a; x|]

  let abs x = _make_node "abs" (Fun01 A.abs_) [|x|]

  let neg x = _make_node "neg" (Fun01 A.neg_) [|x|]

  let conj x = _make_node "conj" (Fun01 A.conj_) [|x|]

  let reci x = _make_node "reci" (Fun01 A.reci_) [|x|]

  let signum x = _make_node "signum" (Fun01 A.signum_) [|x|]

  let sqr x = _make_node "sqr" (Fun01 A.sqr_) [|x|]

  let sqrt x = _make_node "sqrt" (Fun01 A.sqrt_) [|x|]

  let cbrt x = _make_node "cbrt" (Fun01 A.cbrt_) [|x|]

  let exp x = _make_node "exp" (Fun01 A.exp_) [|x|]

  let exp2 x = _make_node "exp2" (Fun01 A.exp2_) [|x|]

  let exp10 x = _make_node "exp10" (Fun01 A.exp10_) [|x|]

  let expm1 x = _make_node "expm1" (Fun01 A.expm1_) [|x|]

  let log x = _make_node "log" (Fun01 A.log_) [|x|]

  let log2 x = _make_node "log2" (Fun01 A.log2_) [|x|]

  let log10 x = _make_node "log10" (Fun01 A.log10_) [|x|]

  let log1p x = _make_node "log1p" (Fun01 A.log1p_) [|x|]

  let sin x = _make_node "sin" (Fun01 A.sin_) [|x|]

  let cos x = _make_node "cos" (Fun01 A.cos_) [|x|]

  let tan x = _make_node "tan" (Fun01 A.tan_) [|x|]

  let asin x = _make_node "asin" (Fun01 A.asin_) [|x|]

  let acos x = _make_node "acos" (Fun01 A.acos_) [|x|]

  let atan x = _make_node "atan" (Fun01 A.atan_) [|x|]

  let sinh x = _make_node "sinh" (Fun01 A.sinh_) [|x|]

  let cosh x = _make_node "cosh" (Fun01 A.cosh_) [|x|]

  let tanh x = _make_node "tanh" (Fun01 A.tanh_) [|x|]

  let asinh x = _make_node "asinh" (Fun01 A.asinh_) [|x|]

  let acosh x = _make_node "acosh" (Fun01 A.acosh_) [|x|]

  let atanh x = _make_node "atanh" (Fun01 A.atanh_) [|x|]

  let floor x = _make_node "floor" (Fun01 A.floor_) [|x|]

  let ceil x = _make_node "ceil" (Fun01 A.ceil_) [|x|]

  let round x = _make_node "round" (Fun01 A.round_) [|x|]

  let trunc x = _make_node "trunc" (Fun01 A.trunc_) [|x|]

  let fix x = _make_node "fix" (Fun01 A.fix_) [|x|]

  let erf x = _make_node "erf" (Fun01 A.erf_) [|x|]

  let erfc x = _make_node "erfc" (Fun01 A.erfc_) [|x|]

  let relu x = _make_node "relu" (Fun01 A.relu_) [|x|]

  let softplus x = _make_node "softplus" (Fun01 A.softplus_) [|x|]

  let softsign x = _make_node "softsign" (Fun01 A.softsign_) [|x|]

  let softmax x = _make_node "softmax" (Fun01 A.softmax_) [|x|]

  let sigmoid x = _make_node "sigmoid" (Fun01 A.sigmoid_) [|x|]

  let sum ?axis x = _make_node "sum" (Fun00 (A.sum ?axis)) [|x|]

  let prod ?axis x = _make_node "prod" (Fun00 (A.prod ?axis)) [|x|]

  let min ?axis x = _make_node "min" (Fun00 (A.min ?axis)) [|x|]

  let max ?axis x = _make_node "max" (Fun00 (A.max ?axis)) [|x|]

  let mean ?axis x = _make_node "mean" (Fun00 (A.mean ?axis)) [|x|]

  let var ?axis x = _make_node "var" (Fun00 (A.var ?axis)) [|x|]

  let std ?axis x = _make_node "std" (Fun00 (A.std ?axis)) [|x|]

  let l1norm ?axis x = _make_node "l1norm" (Fun00 (A.l1norm ?axis)) [|x|]

  let l2norm ?axis x = _make_node "l2norm" (Fun00 (A.l2norm ?axis)) [|x|]

  let cumsum ?axis x = _make_node "cumsum" (Fun01 (A.cumsum_ ?axis)) [|x|]

  let cumprod ?axis x = _make_node "cumprod" (Fun01 (A.cumprod_ ?axis)) [|x|]

  let cummin ?axis x = _make_node "cummin" (Fun01 (A.cummin_ ?axis)) [|x|]

  let cummax ?axis x = _make_node "cummax" (Fun01 (A.cummax_ ?axis)) [|x|]

  let conv1d ?padding input kernel stride = _make_node "conv1d" (Fun05 (fun x -> A.conv1d ?padding x.(0) x.(1) stride)) [|input; kernel|]

  let conv2d ?padding input kernel stride = _make_node "conv2d" (Fun05 (fun x -> A.conv2d ?padding x.(0) x.(1) stride)) [|input; kernel|]

  let conv3d ?padding input kernel stride = _make_node "conv3d" (Fun05 (fun x -> A.conv3d ?padding x.(0) x.(1) stride)) [|input; kernel|]

  let max_pool1d ?padding input kernel stride = _make_node "max_pool1d" (Fun00 (fun x -> A.max_pool1d ?padding x kernel stride)) [|input|]

  let max_pool2d ?padding input kernel stride = _make_node "max_pool2d" (Fun00 (fun x -> A.max_pool2d ?padding x kernel stride)) [|input|]

  let max_pool3d ?padding input kernel stride = _make_node "max_pool3d" (Fun00 (fun x -> A.max_pool3d ?padding x kernel stride)) [|input|]

  let avg_pool1d ?padding input kernel stride = _make_node "avg_pool1d" (Fun00 (fun x -> A.avg_pool1d ?padding x kernel stride)) [|input|]

  let avg_pool2d ?padding input kernel stride = _make_node "avg_pool2d" (Fun00 (fun x -> A.avg_pool2d ?padding x kernel stride)) [|input|]

  let avg_pool3d ?padding input kernel stride = _make_node "avg_pool3d" (Fun00 (fun x -> A.avg_pool3d ?padding x kernel stride)) [|input|]

  let conv1d_backward_input input kernel stride output' = _make_node "conv1d_backward_input" (Fun05 (fun x -> A.conv1d_backward_input x.(0) x.(1) stride x.(2))) [|input; kernel; output'|]

  let conv1d_backward_kernel input kernel stride output' = _make_node "conv1d_backward_kernel" (Fun05 (fun x -> A.conv1d_backward_kernel x.(0) x.(1) stride x.(2))) [|input; kernel; output'|]

  let conv2d_backward_input input kernel stride output' = _make_node "conv2d_backward_input" (Fun05 (fun x -> A.conv2d_backward_input x.(0) x.(1) stride x.(2))) [|input; kernel; output'|]

  let conv2d_backward_kernel input kernel stride output' = _make_node "conv2d_backward_kernel" (Fun05 (fun x -> A.conv2d_backward_kernel x.(0) x.(1) stride x.(2))) [|input; kernel; output'|]

  let conv3d_backward_input input kernel stride output' = _make_node "conv3d_backward_input" (Fun05 (fun x -> A.conv3d_backward_input x.(0) x.(1) stride x.(2))) [|input; kernel; output'|]

  let conv3d_backward_kernel input kernel stride output' = _make_node "conv3d_backward_kernel" (Fun05 (fun x -> A.conv3d_backward_kernel x.(0) x.(1) stride x.(2))) [|input; kernel; output'|]

  let max_pool1d_backward padding input kernel stride output' = _make_node "max_pool1d_backward" (Fun05 (fun x -> A.max_pool1d_backward padding x.(0) kernel stride x.(1))) [|input; output'|]

  let max_pool2d_backward padding input kernel stride output' = _make_node "max_pool2d_backward" (Fun05 (fun x -> A.max_pool2d_backward padding x.(0) kernel stride x.(1))) [|input; output'|]

  let avg_pool1d_backward padding input kernel stride output' = _make_node "avg_pool1d_backward" (Fun05 (fun x -> A.avg_pool1d_backward padding x.(0) kernel stride x.(1))) [|input; output'|]

  let avg_pool2d_backward padding input kernel stride output' = _make_node "avg_pool2d_backward" (Fun05 (fun x -> A.avg_pool2d_backward padding x.(0) kernel stride x.(1))) [|input; output'|]


  (* reduce to scalar *)

  let sum' x = _make_node "sum'" (Fun07 A.sum') [|x|]

  let prod' x = _make_node "prod'" (Fun07 A.prod') [|x|]

  let min' x = _make_node "min'" (Fun07 A.min') [|x|]

  let max' x = _make_node "max'" (Fun07 A.max') [|x|]

  let mean' x = _make_node "mean'" (Fun07 A.mean') [|x|]

  let var' x = _make_node "var'" (Fun07 A.var') [|x|]

  let std' x = _make_node "std'" (Fun07 A.std') [|x|]

  let l1norm' x = _make_node "l1norm'" (Fun07 A.l1norm') [|x|]

  let l2norm' x = _make_node "l2norm'" (Fun07 A.l2norm') [|x|]

  let l2norm_sqr' x = _make_node "l2norm_sqr'" (Fun07 A.l2norm_sqr') [|x|]


  (* comparion functions *)

  let elt_equal x y = _make_node "elt_equal" (Fun02 (A.elt_equal_, A.elt_equal)) [|x; y|]

  let elt_not_equal x y = _make_node "elt_not_equal" (Fun02 (A.elt_not_equal_, A.elt_not_equal)) [|x; y|]

  let elt_less x y = _make_node "elt_less" (Fun02 (A.elt_less_, A.elt_less)) [|x; y|]

  let elt_greater x y = _make_node "elt_greater" (Fun02 (A.elt_greater_, A.elt_greater)) [|x; y|]

  let elt_less_equal x y = _make_node "elt_less_equal" (Fun02 (A.elt_less_equal_, A.elt_less_equal)) [|x; y|]

  let elt_greater_equal x y = _make_node "elt_greater_equal" (Fun02 (A.elt_greater_equal_, A.elt_greater_equal)) [|x; y|]

  let elt_equal_scalar x a = _make_node "elt_equal_scalar" (Fun03 A.elt_equal_scalar_) [|x; a|]

  let elt_not_equal_scalar x a = _make_node "elt_not_equal_scalar" (Fun03 A.elt_not_equal_scalar_) [|x; a|]

  let elt_less_scalar x a = _make_node "elt_less_scalar" (Fun03 A.elt_less_scalar_) [|x; a|]

  let elt_greater_scalar x a = _make_node "elt_greater_scalar" (Fun03 A.elt_greater_scalar_) [|x; a|]

  let elt_less_equal_scalar x a = _make_node "elt_less_equal_scalar" (Fun03 A.elt_less_equal_scalar_) [|x; a|]

  let elt_greater_equal_scalar x a = _make_node "elt_greater_equal_scalar" (Fun03 A.elt_greater_equal_scalar_) [|x; a|]


end
