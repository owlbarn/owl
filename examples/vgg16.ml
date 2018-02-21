#!/usr/bin/env owl
(* This example demonstrates how to use Owl to implement VGG16.
  Note that only the network structure of VGG16 is defined.

  If you want to use VGG16 for inference, please use Zoo system to
  pull in the gist: f5409c44d6444921a8ceec00e33c42c4 which includes both the
  definition of network structure and URL of pre-trained weights.
 *)

open Owl
open Neural.S
open Neural.S.Graph

let make_network img_size =
  input [|img_size;img_size;3|]
  (* block 1 *)
  |> conv2d [|3;3;3;64|]  [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> conv2d [|3;3;64;64|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> max_pool2d [|2;2|] [|2;2|] ~padding:VALID
  (* block 2 *)
  |> conv2d [|3;3;64;128|]  [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> conv2d [|3;3;128;128|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> max_pool2d [|2;2|] [|2;2|] ~padding:VALID
  (* block 3 *)
  |> conv2d [|3;3;128;256|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> conv2d [|3;3;256;256|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> conv2d [|3;3;256;256|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> max_pool2d [|2;2|] [|2;2|] ~padding:VALID
  (* block 4 *)
  |> conv2d [|3;3;256;512|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> conv2d [|3;3;512;512|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> conv2d [|3;3;512;512|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> max_pool2d [|2;2|] [|2;2|] ~padding:VALID
  (* block 5 *)
  |> conv2d [|3;3;512;512|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> conv2d [|3;3;512;512|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> conv2d [|3;3;512;512|] [|1;1|] ~act_typ:Activation.Relu ~padding:SAME
  |> max_pool2d [|2;2|] [|2;2|] ~padding:VALID
  (* classification block *)
  |> flatten
  |> fully_connected ~act_typ:Activation.Relu 4096
  |> fully_connected ~act_typ:Activation.Relu 4096
  |> fully_connected ~act_typ:Activation.Softmax classes
  |> get_network

let _ = make_network 224 |> print
