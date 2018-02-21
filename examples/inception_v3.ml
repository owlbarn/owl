#!/usr/bin/env owl
(* This example demonstrates how to use Owl to implement Google's Inception V3 (https://arxiv.org/abs/1512.00567).
  Note that only the network structure of Inception is defined.

  If you want to use Google Inception for inference, please use Zoo system to
  pull in the gist: 9428a62a31dbea75511882ab8218076f which includes both the
  definition of network structure and pre-trained weights.
 *)

open Owl
open Neural.S
open Neural.S.Graph

let conv2d_bn ?(padding=SAME) kernel stride nn =
  conv2d ~padding kernel stride nn
  |> normalisation ~training:false ~axis:3
  |> activation Activation.Relu

let mix_typ1 in_shape bp_size nn =
  let branch1x1 = conv2d_bn [|1;1;in_shape;64|] [|1;1|] nn in
  let branch5x5 = nn
    |> conv2d_bn [|1;1;in_shape;48|] [|1;1|]
    |> conv2d_bn [|5;5;48;64|] [|1;1|]
  in
  let branch3x3dbl = nn
    |> conv2d_bn [|1;1;in_shape;64|] [|1;1|]
    |> conv2d_bn [|3;3;64;96|]  [|1;1|]
    |> conv2d_bn [|3;3;96;96|]  [|1;1|]
  in
  let branch_pool = nn
    |> avg_pool2d [|3;3|] [|1;1|]
    |> conv2d_bn [|1;1;in_shape; bp_size |] [|1;1|]
  in
  concatenate 3 [|branch1x1; branch5x5; branch3x3dbl; branch_pool|]

let mix_typ3 nn =
  let branch3x3 = conv2d_bn [|3;3;288;384|] [|2;2|] ~padding:VALID nn in
  let branch3x3dbl = nn
    |> conv2d_bn [|1;1;288;64|] [|1;1|]
    |> conv2d_bn [|3;3;64;96|] [|1;1|]
    |> conv2d_bn [|3;3;96;96|] [|2;2|] ~padding:VALID
  in
  let branch_pool = max_pool2d [|3;3|] [|2;2|] ~padding:VALID nn in
  concatenate 3 [|branch3x3; branch3x3dbl; branch_pool|]

let mix_typ4 size nn =
  let branch1x1 = conv2d_bn [|1;1;768;192|] [|1;1|] nn in
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
    |> avg_pool2d [|3;3|] [|1;1|] (* padding = SAME *)
    |> conv2d_bn [|1;1; 768; 192|] [|1;1|]
  in
  concatenate 3 [|branch1x1; branch7x7; branch7x7dbl; branch_pool|]

let mix_typ8 nn =
  let branch3x3 = nn
    |> conv2d_bn [|1;1;768;192|] [|1;1|]
    |> conv2d_bn [|3;3;192;320|] [|2;2|] ~padding:VALID
  in
  let branch7x7x3 = nn
    |> conv2d_bn [|1;1;768;192|] [|1;1|]
    |> conv2d_bn [|1;7;192;192|] [|1;1|]
    |> conv2d_bn [|7;1;192;192|] [|1;1|]
    |> conv2d_bn [|3;3;192;192|] [|2;2|] ~padding:VALID
  in
  let branch_pool = max_pool2d [|3;3|] [|2;2|] ~padding:VALID nn in
  concatenate 3 [|branch3x3; branch7x7x3; branch_pool|]

let mix_typ9 input nn =
  let branch1x1 = conv2d_bn [|1;1;input;320|] [|1;1|] nn in
  let branch3x3 = conv2d_bn [|1;1;input;384|] [|1;1|] nn in
  let branch3x3_1 = branch3x3 |> conv2d_bn [|1;3;384;384|] [|1;1|] in
  let branch3x3_2 = branch3x3 |> conv2d_bn [|3;1;384;384|] [|1;1|] in
  let branch3x3 = concatenate 3 [| branch3x3_1; branch3x3_2 |] in
  let branch3x3dbl = nn |> conv2d_bn [|1;1;input;448|] [|1;1|] |> conv2d_bn [|3;3;448;384|] [|1;1|] in
  let branch3x3dbl_1 = branch3x3dbl |> conv2d_bn [|1;3;384;384|] [|1;1|]  in
  let branch3x3dbl_2 = branch3x3dbl |> conv2d_bn [|3;1;384;384|] [|1;1|]  in
  let branch3x3dbl = concatenate 3 [|branch3x3dbl_1; branch3x3dbl_2|] in
  let branch_pool = nn |> avg_pool2d [|3;3|] [|1;1|] |> conv2d_bn [|1;1;input;192|] [|1;1|] in
  concatenate 3 [|branch1x1; branch3x3; branch3x3dbl; branch_pool|]

let make_network img_size =
  input [|img_size;img_size;3|]
  |> conv2d_bn [|3;3;3;32|] [|2;2|] ~padding:VALID
  |> conv2d_bn [|3;3;32;32|] [|1;1|] ~padding:VALID
  |> conv2d_bn [|3;3;32;64|] [|1;1|]
  |> max_pool2d [|3;3|] [|2;2|] ~padding:VALID
  |> conv2d_bn [|1;1;64;80|] [|1;1|] ~padding:VALID
  |> conv2d_bn [|3;3;80;192|] [|1;1|] ~padding:VALID
  |> max_pool2d [|3;3|] [|2;2|] ~padding:VALID
  |> mix_typ1 192 32 |> mix_typ1 256 64 |> mix_typ1 288 64
  |> mix_typ3
  |> mix_typ4 128 |> mix_typ4 160 |> mix_typ4 160 |> mix_typ4 192
  |> mix_typ8
  |> mix_typ9 1280 |> mix_typ9 2048
  |> global_avg_pool2d
  |> linear 1000 ~act_typ:Activation.Softmax
  |> get_network

let _ = make_network 299 |> print
