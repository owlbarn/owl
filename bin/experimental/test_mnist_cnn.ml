
module NdarrayS = Owl_base_dense_ndarray.NdarrayPureSingle
module NeuralS = Owl_neural_generic.Make (NdarrayS)
module NeuralSGraph = NeuralS.Graph
module AlgodiffS = Owl_base_dense_ndarray.PureS

open AlgodiffS
open NeuralSGraph
open NeuralS


let make_network input_shape =
  input input_shape
  |> lambda (fun x -> Maths.(x / F 256.))
  |> conv2d [|5;5;1;32|] [|1;1|] ~act_typ:Activation.Relu
  |> max_pool2d [|2;2|] [|2;2|]
  |> dropout 0.1
  |> fully_connected 1024 ~act_typ:Activation.Relu
  |> linear 10 ~act_typ:Activation.Softmax
  |> get_network


let train () =
  let x, _, y = Owl_base_dataset.load_mnist_train_data_arr () in
  let network = make_network [|28;28;1|] in
  Graph.print network;
  let params = Params.config
      ~batch:(Batch.Mini 100) ~learning_rate:(Learning_Rate.Adagrad 0.005) 0.1
  in
  Graph.train ~params network x y |> ignore;
  network


let test network =
  let imgs, _, labels = Owl_base_dataset.load_mnist_test_data () in
  let m = NdarrayS.row_num imgs in
  let imgs = NdarrayS.reshape imgs [|m;28;28;1|] in

  let mat2num x = NdarrayS.of_array (
      x |> NdarrayS.max_rows
      |> Array.map (fun (_,_,num) -> float_of_int num)
    ) [|1; m|]
  in

  let pred = mat2num (Graph.model network imgs) in
  let fact = mat2num labels in
  let accu = NdarrayS.(elt_equal pred fact |> sum') in
  Owl_log.info "Accuracy on test set: %f" (accu /. (float_of_int m))


let _ = train () |> test
