#!/usr/bin/env owl


module G = Owl_computation_graph
module A = Owl_algodiff_generic.Make (G)
include Owl_neural_generic.Make (G)
open Graph
open Owl


let make_network input_shape =
  input input_shape
  |> normalisation ~decay:0.9
  |> conv2d [|3;3;3;32|] [|1;1|] ~act_typ:Activation.Relu
  |> conv2d [|3;3;32;32|] [|1;1|] ~act_typ:Activation.Relu ~padding:VALID
  |> max_pool2d [|2;2|] [|2;2|] ~padding:VALID
  |> dropout 0.1
  |> conv2d [|3;3;32;64|] [|1;1|] ~act_typ:Activation.Relu
  |> conv2d [|3;3;64;64|] [|1;1|] ~act_typ:Activation.Relu ~padding:VALID
  |> max_pool2d [|2;2|] [|2;2|] ~padding:VALID
  |> dropout 0.1
  |> fully_connected 512 ~act_typ:Activation.Relu
  |> linear 10 ~act_typ:Activation.(Softmax 1)
  |> get_network


let visualise_04 () =
  let network = make_network [|32;32;3|] in
  let xt = G.var_arr ~name:"xt" (Some [|100;32;32;3|]) |> A.pack_arr in
  let yt = G.var_arr ~name:"yt" (Some [|100;10|]) |> A.pack_arr in
  let yt', _ = Graph.(init network; forward network xt) in
  let loss = A.(Maths.((cross_entropy yt yt') / (pack_flt (Mat.row_num yt |> float_of_int)))) in
  let _, adj0 = Graph.(backward network loss) in

  let s0 = G.to_dot [loss |> A.unpack_elt |> G.unpack_elt] in
  Owl_io.write_file "cgraph_04_loss.dot" s0;
  Sys.command "dot -Tpdf cgraph_04_loss.dot -o cgraph_04_loss.pdf" |> ignore;

  let s1 = adj0
    |> Utils.Array.flatten
    |> Array.map (fun a -> A.unpack_arr a |> G.unpack_arr)
    |> Array.to_list
    |> G.to_dot
  in
  Owl_io.write_file "cgraph_04_grad.dot" s1;
  Sys.command "dot -Tpdf cgraph_04_grad.dot -o cgraph_04_grad.pdf" |> ignore


let _ =
  visualise_04 ()
