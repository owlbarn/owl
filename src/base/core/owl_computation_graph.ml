(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_graph


type value =
  | F   of float
  | F32 of (float, float32_elt, c_layout) Genarray.t
  | F64 of (float, float64_elt, c_layout) Genarray.t


type t = attr node

and attr = {
  op    : op;
  shape : (int array option) array;
  value : value array;
}

and op =
  | Var
  | Const
  | Sin
  | Cos
  | Add
  | Sub
  | Mul
  | Div


let _shape = function
  | F _   -> [||]
  | F32 x -> Genarray.dims x
  | F64 x -> Genarray.dims x


let _infer_shape_1 input_shapes =
  match input_shapes.(0).(0) with
  | Some s -> [| Some Array.(copy s) |]
  | None   -> [| None |]


let _infer_shape_2 input_shapes =
  let s0 = input_shapes.(0).(0) in
  let s1 = input_shapes.(1).(0) in
  match s0, s1 with
  | Some s0, Some s1 -> [| Some s0 |]
  | _, _             -> [| None |]


let infer_shape operator args =
  let input_shapes = Array.map (fun a -> (attr a).shape) args in
  match operator with
  | Var   -> _infer_shape_1 input_shapes
  | Const -> _infer_shape_1 input_shapes
  | Sin   -> _infer_shape_1 input_shapes
  | Cos   -> _infer_shape_1 input_shapes
  | Add   -> _infer_shape_2 input_shapes
  | Sub   -> _infer_shape_2 input_shapes
  | Mul   -> _infer_shape_2 input_shapes
  | Div   -> _infer_shape_2 input_shapes


let make_node ?value ?shape op =
  let value = match value with Some v -> v | None -> [||] in
  let shape =
    if Array.length value > 0 then
      Array.map (fun v -> Some (_shape v)) value
    else
      match shape with Some s -> s | None -> [||]
  in
  Owl_graph.node { op; shape; value }


let refnum x = Owl_graph.outdegree x


let make_then_connect op x =
  let shape = infer_shape op x in
  let y = make_node ~shape op in
  connect x [|y|];
  y


let variable shape = make_node ~shape:[|shape|] Var

let sin x = make_then_connect Sin [|x|]

let cos x = make_then_connect Cos [|x|]

let add x y = make_then_connect Add [|x; y|]

let sub x y = make_then_connect Sub [|x; y|]

let mul x y = make_then_connect Mul [|x; y|]

let div x y = make_then_connect Div [|x; y|]
