#!/usr/bin/env owl
(* This example demonstrates using lazy functor to train a model on mnist. *)

open Owl
module L = Owl_lazyy.Make (Dense.Ndarray.S)
include Owl_algodiff_generic.Make (L)
include Owl_neural_generic.Make (L)
open Graph


let make_network input_shape =
  input input_shape
  |> lambda (fun x -> Maths.(x / pack_flt 256.))
  |> conv2d [|5;5;1;32|] [|1;1|] ~act_typ:Activation.Relu
  |> max_pool2d [|2;2|] [|2;2|]
  |> dropout 0.1
  |> fully_connected 1024 ~act_typ:Activation.Relu
  |> linear 10 ~act_typ:Activation.(Softmax 1)
  |> get_network


let train () =
  let x, _, y = Dataset.load_mnist_train_data_arr () in
  let network = make_network [|28;28;1|] in
  Graph.print network;
  let params = Params.config
    ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.005) 0.1
  in
  Graph.train ~params network (L.pack_arr x) (L.pack_arr y) |> ignore;
  network


let compile network =
  let x = L.var_arr ~name:"x" [|100;28;28;1|] |> pack_arr in
  let y = L.var_arr ~name:"y" [|100;10|] |> pack_arr in

  Graph.init network;
  Owl_utils.aarr_map (fun v -> L.var_arr ~name: "" (unpack_arr v |> L.shape) |> pack_arr) (mkpar network)
  |> Graph.update network;

  let y', _ = Graph.forward network x in
  let loss = Maths.((cross_entropy y y') / (pack_flt (Mat.row_num y |> float_of_int))) in
  let pri0, adj0 = Graph.(backward network loss) in

  (* assign loss var name *)
  Owl_graph.set_name (unpack_elt loss |> L.elt_to_node) "loss";

  (* assign input names *)
  Array.iteri (fun i a ->
    let b = unpack_arr a |> L.arr_to_node in
    let s = Printf.sprintf "DNN_var_%i_i" i in
    Owl_graph.set_name b s
  ) (mkpri network |> Utils.Array.flatten);

  (* assign output names *)
  Array.iteri (fun i a ->
    let b = unpack_arr a |> L.arr_to_node in
    let s = Printf.sprintf "DNN_var_%i_o" i in
    Owl_graph.set_name b s
  ) (mkadj network |> Utils.Array.flatten);

  (* write to dot files *)
  let s0 = L.to_dot [| loss |> unpack_elt |> L.elt_to_node |] in
  Owl_io.write_file "lazy_forward.dot" s0;
  Sys.command "dot -Tpdf lazy_forward.dot -o lazy_forward.pdf" |> ignore;

  let s1 = adj0
    |> Utils.Array.flatten
    |> Array.map (fun a -> unpack_arr a |> L.arr_to_node)
    |> Array.append [| unpack_elt loss |> L.elt_to_node |]
    |> L.to_dot
  in
  Owl_io.write_file "lazy_backward.dot" s1;
  Sys.command "dot -Tpdf lazy_backward.dot -o lazy_backward.pdf" |> ignore;

  let x = unpack_arr x in
  let y = unpack_arr y in
  let pri = Array.map unpack_arr (Utils.Array.flatten pri0) in
  let adj = Array.map unpack_arr (Utils.Array.flatten adj0) in
  x, y, pri, adj


let run xt yt var adj =
  let x, _, y = Dataset.load_mnist_train_data_arr () in

  Array.iter (fun u ->
    let s = L.shape u in
    let v = Dense.Ndarray.S.uniform s in
    L.assign_arr u v
  ) var;

  for i = 1 to 60 do
    Owl_log.info "iter#%i ..." i;
    let xs, idx = Dense.Ndarray.S.draw ~axis:0 x 100 in
    let ys = Dense.Ndarray.S.rows y idx in
    Owl_log.debug "=== %i start assign ..." i;
    L.assign_arr xt xs;
    L.assign_arr yt ys;
    Array.iter (fun u -> L.arr_to_node u |> L.invalidate) var;
    Owl_log.debug "=== %i stop assign ..." i;
    L.eval_arr adj;

    Gc.minor ()
  done


let _ =
  Owl_log.(set_level DEBUG);
  let network = make_network [|28;28;1|] in
  let xt, yt, var, adj = compile network in
  run xt yt var adj
