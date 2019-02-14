(* #!/usr/bin/env owl *)
#require "owl-tensorflow"

open Owl
open Owl_tensorflow
open Owl_converter

module N  = Dense.Ndarray.S
module G  = Owl_computation_cpu_engine.Make (N)
module T  = Owl_converter.Make (G)

include Owl_algodiff_generic.Make (G)


let f0 x = Maths.(tanh x)
let f1 = diff f0
let f2 = diff f1
(*let f3 = diff f2
let f4 = diff f3 *)

let x = G.var_arr ~shape:[|100|] "x" |> pack_arr

let y0 = f0 x
let y1 = f1 x
let y2 = f2 x

let output = [|
  unpack_arr y0 |> G.arr_to_node;
  unpack_arr y1 |> G.arr_to_node;
  unpack_arr y2 |> G.arr_to_node;
|]

let input  = [|
  unpack_arr x  |> G.arr_to_node
|]

let g = G.make_graph ~input ~output "graph_01"

let dot = G.graph_to_dot g
