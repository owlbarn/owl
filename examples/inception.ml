#!/usr/bin/env owl

open Owl
open Owl_neural
open Algodiff.S
open Owl_neural_neuron

let channel_last = true (* The same in Keras Conv layer *)
let include_top = true  (* if false, no final Dense layer *)
let img_size = 299      (* include_top = true means img_size does NOT have to be exact 299 *)
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

  let mix_typ1 in_shape bp_size nn = 
    
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
    let nn = concatenate 2 [|branch1x1; branch5x5; branch3x3dbl; branch_pool|] in (* all of shape: (35, 35, * ) --> 256 *)
    nn
  
  in
  (* mix 0, 1, 2 *)
  (* 35 x 35 x 192 --> 35 x 35 x 256 --> 35 x 35 x 288 --> 35 x 35 x 288 *)
  let nn = nn |> mix_typ1 192 32 |> mix_typ1 256 64  |> mix_typ1 288 64 in

  (* mix 3 *)
  let mix_typ3 nn = 
    let branch3x3 = nn 
      |> conv2d_bn [|3;3;288;384|] [|2;2|]  ~padding:Owl_dense_ndarray_generic.VALID 
    in
    let branch3x3dbl = nn 
      |> conv2d_bn [|1;1;288;64|] [|1;1|]
      |> conv2d_bn [|3;3;64;96|]  [|1;1|]
      |> conv2d_bn [|3;3;96;96|] [|2;2|]  ~padding:Owl_dense_ndarray_generic.VALID 
    in 
    let branch_pool = nn 
      (* the padding type is not specified in keras structure *)
      |> max_pool2d [|3;3|] [|2;2|] ~padding:Owl_dense_ndarray_generic.VALID 
    in
    concatenate 2 [|branch3x3; branch3x3dbl; branch_pool|] 
  in
  (* 35 x 35 x 288 --> 17 x 17 x 768 *)
  let nn = nn |> mix_typ3 in 

  (* mix 4, 5, 6, 7 *)
  let mix_typ4 size nn = 
    let branch1x1 = nn
      |> conv2d_bn [|1;1;768;192|] [|1;1|] 
    in 
    let branch7x7 = nn 
      |> conv2d_bn [|1;1;768;size|] [|1;1|]
      |> conv2d_bn [|1;7;size;size|] [|1;1|]
      |> conv2d_bn [|7;1;size;192|] [|1;1|]
    in 
    let branch7x7dbl = nn
      |> conv2d_bn [|1;1;768;size|] [|1;1|]
      |> conv2d_bn [|7;1;size;size|] [|1;1|]
      |> conv2d_bn [|1;7;size;size|] [|1;1|]
      |> conv2d_bn [|7;1;size;size|] [|1;1|]
      |> conv2d_bn [|1;7;size;192|] [|1;1|]
    in
    let branch_pool = nn
      |> avg_pool2d [|3;3|] [|1;1|] (*padding = 'SAME'*)
      |> conv2d_bn [|1;1; 768; 192|] [|1;1|]
    in
    concatenate 2 [|branch1x1; branch7x7; branch7x7dbl; branch_pool|] 
  in 
  (* 17 x 17 x 768 --> 17 x 17 x 768 --> 17 x 17 x 768 
    --> 17 x 17 x 768 --> 17 x 17 x 768 *)
  let nn = nn |> mix_typ4 128 |> mix_typ4 160 
              |> mix_typ4 160 |> mix_typ4 192 in 


  (* mix 8 *)
  let mix_typ8 nn = 
    let branch3x3 = nn
      |> conv2d_bn [|1;1;768;192|] [|1;1|] 
      |> conv2d_bn [|3;3;192;320|] [|2;2|] ~padding:Owl_dense_ndarray_generic.VALID
    in 
    let branch7x7x3 = nn 
      |> conv2d_bn [|1;1;768;192|] [|1;1|]
      |> conv2d_bn [|1;7;192;192|] [|1;1|]
      |> conv2d_bn [|7;1;192;192|] [|1;1|]
      |> conv2d_bn [|3;3;192;192|] [|2;2|] ~padding:Owl_dense_ndarray_generic.VALID
    in 
    let branch_pool = nn
      |> max_pool2d [|3;3|] [|2;2|] ~padding:Owl_dense_ndarray_generic.VALID
    in
    concatenate 2 [|branch3x3; branch7x7x3; branch_pool|]
  in
  (* 17 x 17 x 768 --> 8 x 8 x 1280 *)
  let nn = nn |> mix_typ8 in 

  (* mix 9, 10*)
  let mix_typ9 input nn = 

    let branch1x1 = nn 
      |> conv2d_bn [|1;1;input;320|] [|1;1|]
    in

    let branch3x3 = nn 
      |> conv2d_bn [|1;1;input;384|] [|1;1|]
    in
    let branch3x3_1 = branch3x3 |> conv2d_bn [|1;3;384;384|] [|1;1|] in 
    let branch3x3_2 = branch3x3 |> conv2d_bn [|3;1;384;384|] [|1;1|] in 
    let branch3x3 = concatenate 2 [| branch3x3_1; branch3x3_2 |]
    in

    let branch3x3dbl = nn 
      |> conv2d_bn [|1;1;input;448|] [|1;1|]
      |> conv2d_bn [|3;3;448;384|]   [|1;1|]
    in 
    let branch3x3dbl_1 = branch3x3dbl |> conv2d_bn [|1;3;384;384|] [|1;1|]  in 
    let branch3x3dbl_2 = branch3x3dbl |> conv2d_bn [|3;1;384;384|] [|1;1|]  in 
    let branch3x3dbl = concatenate 2 [|branch3x3dbl_1; branch3x3dbl_2|] 
    in 

    let branch_pool = nn
      |> avg_pool2d [|3;3|] [|1;1|]
      |> conv2d_bn  [|1;1;input;192|] [|1;1|]
    in

    concatenate 2 [|branch1x1; branch3x3; branch3x3dbl; branch_pool|]
  
  in 
  (*  8 x 8 x 1280 -->  8 x 8 x 2048 -->  8 x 8 x 2048 *)
  let nn = nn |> mix_typ9 1280 |> mix_typ9 2048 in 

  let nn = nn 
    (* GlobalAveragePooling2D or GlobalMaxPooling2D ? *)
    |> avg_pool2d [|3;3|] [|1;1|]
    (* no FC layer and its parameters in Keras impl. *)
    |> fully_connected 2048 ~act_typ:Activation.Relu 
    |> linear 1000 ~act_typ:Activation.Softmax
    |> get_network
  in print nn;
  nn


(* obviously we need ImageNet data rather than CIFAR *)
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