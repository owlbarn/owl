#!/usr/bin/env owl

#require "owl-tensorflow"

open Owl
open Owl_tensorflow
open Owl_converter

module G = Owl_computation_cpu_engine.Make (Dense.Ndarray.S)
module CGCompiler = Owl_neural_compiler.Make (G)
module T = Owl_converter.Make (G)

open CGCompiler.Neural
open CGCompiler.Neural.Graph
open CGCompiler.Neural.Algodiff


let make_mnist_network input_shape =
  input input_shape
  |> lambda (fun x -> Maths.(x / pack_flt 256.))
  |> conv2d [|5;5;1;32|] [|1;1|] ~act_typ:Activation.Relu
  |> max_pool2d [|2;2|] [|2;2|]
  |> fully_connected 1024 ~act_typ:Activation.Relu
  |> linear 10
  |> get_network


let make_cgraph () =
  let network = make_mnist_network [|28;28;1|] in
  let xt = G.var_arr "xt" ~shape:[|100;28;28;1|] |> Algodiff.pack_arr in
  let yt', _ = Graph.(init network; forward network xt) in
  let input_nodes  = [| xt  |> Algodiff.unpack_arr |> G.arr_to_node |] in
  let output_nodes = [| yt' |> Algodiff.unpack_arr |> G.arr_to_node |] in
  G.make_graph ~input:input_nodes ~output:output_nodes "cgraph_forward"


let visualise_mnist () =
  let cgraph_forward = make_cgraph () in
  let s0 = G.graph_to_dot cgraph_forward in
  Owl_io.write_file "cgraph_mnist_forward.dot" s0;
  Sys.command "dot -Tpdf cgraph_mnist_forward.dot -o cgraph_mnist_forward.pdf" |> ignore


let to_pbtxt fname =
  let cgraph_forward = make_cgraph () in
  let pbtxt = T.convert cgraph_forward in
  Owl_io.write_file fname pbtxt


let _ =
  to_pbtxt "test_cgraph_cnn.pbtxt"
