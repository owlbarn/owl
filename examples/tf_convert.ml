#!/usr/bin/env owl

open Owl
open Owl_converter

module N = Dense.Ndarray.S
module G = Owl_computation_cpu_engine.Make (N)
module T = Owl_converter.Make (G)

include Owl_algodiff_generic.Make (G)


(* construct computation in AD *)

let f x y =
  let weight = Mat.ones 3 3 in
  Maths.( (pack_flt 2.) * (x *@ weight + y) - (pack_flt 1.))

let x = G.var_arr "x" |> pack_arr
let y = G.var_elt "y" |> pack_elt
let z = f x y

(* build computation graph *)

let output = [| unpack_arr z |> G.arr_to_node |]
let input  = [|
  unpack_arr x |> G.arr_to_node;
  unpack_elt y |> G.elt_to_node
|]
let g = G.make_graph ~input ~output "graph_01"

(* evaluate graph *)
let x_val = N.ones [|3; 3|]
let y_val = 3.
let _ = G.assign_arr (unpack_arr x) x_val
let _ = G.assign_elt (unpack_elt y) y_val
let _ = G.eval_graph g
let v = G.get_value output.(0)
let _ = N.print (G.value_to_arr v.(0))

(* output to dot *)
let _dot = G.graph_to_dot g

(* output to tensorflow pbtxt *)
let pbtxt = T.convert g
(* let _ = T.Utils.pbtxt_to_pb "test_cgraph.meta" s *)
