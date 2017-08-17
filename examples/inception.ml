#!/usr/bin/env owl

open Owl
open Owl_neural
open Algodiff.S
open Owl_neural_neuron

let img_size = 299

let obtain_input_shape () = None 

let conv2d_bn ?(padding=Owl_dense_ndarray_generic.SAME) kernel stride x =  
  let open Owl_neural_graph in
  x |>conv2d ~act_typ:Activation.Relu ~padding kernel stride 
    |> normalisation ~axis:3 (* color channel on 3rd dim*)


let model () = 
  let open Owl_neural_graph in
  let nn = input [|img_size;img_size;3|]
    |> conv2d_bn [|3;3;3;32|] [|2;2|]  ~padding:Owl_dense_ndarray_generic.VALID
    |> conv2d_bn [|3;3;32;32|] [|1;1|] ~padding:Owl_dense_ndarray_generic.VALID
    |> conv2d_bn [|3;3;32;64|] [|1;1|] 
    |> max_pool2d [|3;3|] [|2;2|] ~padding:Owl_dense_ndarray_generic.VALID (*this parameter is not specified in keras*)

    |> conv2d_bn [|1;1;64;80|] [|1;1|]  ~padding:Owl_dense_ndarray_generic.VALID
    |> conv2d_bn [|3;3;80;192|] [|1;1|]  ~padding:Owl_dense_ndarray_generic.VALID
    |> max_pool2d [|3;3|] [|2;2|] ~padding:Owl_dense_ndarray_generic.VALID
  in

  let mix_typ1 in_shape bp_size node = 
    
    let branch1x1 = nn 
      |> conv2d_bn [|1;1;in_shape;64|] [|1;1|] 
    in 
    let branch5x5 = nn
      |> conv2d_bn [|1;1;in_shape;48|] [|1;1|] 
      |> conv2d_bn [|5;5;48;64|]  [|1;1|]
    in
    let branch3x3dbl = nn 
      |> conv2d_bn [|1;1;in_shape;64|] [|1;1|] 
      |> conv2d_bn [|3;3;64;96|]  [|1;1|] 
      |> conv2d_bn [|3;3;96;96|]  [|1;1|] 
    in 
    let branch_pool = nn 
      |> avg_pool2d [|3;3|] [|1;1|] 
      |> conv2d_bn [|1;1;in_shape; bp_size |] [|1;1|]  (* the 192 doesn't change *)
    in 
    concatenate 2 [|branch1x1; branch5x5; branch3x3dbl; branch_pool|] (* all of shape: (35, 35, * ) --> 256 *)
  
  in
  (* mix 0, 1, 2 *)
  (* mix 0: 35 x 35 x 192 *)
  let nn = nn |> mix_typ1 192 32 in  (*|> mix_typ1 256 64  |> mix_typ1 288  --> shape inconsistant error at first conv layer *) 

  (* mix 1 : 35 x 35 x 256 *)
  (* let nn = mix_typ1 256 64 nn in *)
  let branch1x1 = nn 
      |> conv2d_bn [|1;1;256;64|] [|1;1|] 
  in 
  let branch5x5 = nn
    |> conv2d_bn [|1;1;256;48|] [|1;1|] 
    |> conv2d_bn [|5;5;48;64|]  [|1;1|]
  in
  let branch3x3dbl = nn 
      |> conv2d_bn [|1;1;256;64|] [|1;1|] 
      |> conv2d_bn [|3;3;64;96|]  [|1;1|] 
      |> conv2d_bn [|3;3;96;96|]  [|1;1|] 
  in
  let branch_pool = nn 
      |> avg_pool2d [|3;3|] [|1;1|] 
      |> conv2d_bn [|1;1;256;64|] [|1;1|]  (* the 192 doesn't change *)
  in 
  let nn = concatenate 2 [|branch1x1; branch5x5; branch3x3dbl; branch_pool |] in 

  (* mix 2 : 35 x 35 x 288 *)
  (* let nn = mix_typ1 288 64 nn in *)
  let branch1x1 = nn 
      |> conv2d_bn [|1;1;288;64|] [|1;1|] 
  in 
  let branch5x5 = nn
    |> conv2d_bn [|1;1;288;48|] [|1;1|] 
    |> conv2d_bn [|5;5;48;64|]  [|1;1|]
  in
  let branch3x3dbl = nn 
      |> conv2d_bn [|1;1;288;64|] [|1;1|] 
      |> conv2d_bn [|3;3;64;96|]  [|1;1|] 
      |> conv2d_bn [|3;3;96;96|]  [|1;1|] 
  in
  let branch_pool = nn 
      |> avg_pool2d [|3;3|] [|1;1|] 
      |> conv2d_bn [|1;1;288;64|] [|1;1|]  (* the 192 doesn't change *)
  in 
  let nn = concatenate 2 [|branch1x1; branch5x5; branch3x3dbl; branch_pool |] in 

  let nn = nn 
    |> dropout 0.25
    |> fully_connected 1024 ~act_typ:Activation.Relu
    |> linear 10 ~act_typ:Activation.Softmax
    |> get_network
  in print nn;
  nn

let prepare_training_data () = 

  let datasets = Array.make 5 (Dense.Matrix.S.zeros 1 1) in 
  let labels   = Array.make 5 (Dense.Matrix.S.zeros 1 1) in 
  for i = 1 to 5 do 
      let x, y = Dataset.load_cifar_train_data i in 
      Array.set datasets (i-1) x;
      Array.set labels (i-1) y;
  done;

  let x = Dense.Matrix.S.concatenate datasets in 
  let y = Dense.Matrix.S.concatenate labels in 
  let m = Dense.Matrix.S.row_num x in 
  let x = Dense.Matrix.S.to_ndarray x in 
  let x = Dense.Ndarray.S.reshape x [|m;32;32;3|] in 
  (* let x = Dense.Ndarray.S.slice [[];[];[];[0]] x in *)
  let classes = 10 in 
  let y' = Dense.Matrix.S.zeros m classes in 
  for i = 0 to m - 1 do 
    Dense.Matrix.S.set y' i (int_of_float y.{i,0}) 1.
  done;
  let [|s1;s2;s3;s4|] = Dense.Ndarray.S.shape x in 
  let wy, hy = Dense.Matrix.S.shape y' in 
  Printf.printf "data shape: (%d, %d, %d, %d)\nlabels shape: (%d, %d).\n" s1 s2 s3 s4 wy hy;
  Dense.Ndarray.S.save x "cifar10_data";
  Dense.Matrix.S.save y' "cifar10_labels";
  ()

let train_cifar10_keras_graph () =

  let nn = model () in 
  (* let x, y = prepare_training_data () in *)
  let x = Dense.Ndarray.S.load "cifar10_data" in 
  let y = Dense.Matrix.S.load "cifar10_labels" in
  let x = Dense.Ndarray.S.div_scalar x 255. in 
  let params = Params.config
    ~batch:(Batch.Mini 32) ~learning_rate:(Learning_Rate.RMSprop (0.0001, 0.9)) 1. in  (*0.0001*)
  Graph.train_cnn ~params nn x y
  
let _ = 
  (* prepare_training_data () *)
  train_cifar10_keras_graph ()