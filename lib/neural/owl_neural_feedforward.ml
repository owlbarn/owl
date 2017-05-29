(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff.S
open Owl_neural_neuron

(* Simple Feedforward neural network module *)

type network = {
  mutable layers : neuron array;
}


let create () = { layers = [||]; }

let layer_num nn = Array.length nn.layers

let get_layer nn i =
  let c = layer_num nn in
  match i < 0 with
  | true  -> nn.layers.(c + i)
  | false -> nn.layers.(i)

let connect_layer prev_l next_l =
  let out_shape = get_out_shape prev_l in
  connect out_shape next_l

let rec add_layer ?act_typ nn l =
  (* check whether it is input layer *)
  let not_input_layer =
    function Input _ -> false | _ -> true
  in
  (* insert input layer as the first one given an empty nn *)
  if layer_num nn = 0 then (
    let in_shape = get_in_shape l in
    assert (Array.length in_shape > 0);
    assert (Array.exists ((<>)0) in_shape);
    nn.layers <- [|Input Input.(create in_shape)|];
  );
  (* retrieve the previous layer and attach the new one *)
  if not_input_layer l then (
    let prev_l = get_layer nn (-1) in
    connect_layer prev_l l;
    nn.layers <- Array.append nn.layers [|l|];
  );
  (* if activation is specified, recursively add_layer *)
  match act_typ with
  | Some act -> add_layer nn (Activation (Activation.create act))
  | None     -> ()

let init nn = Array.iter init nn.layers

let reset nn = Array.iter reset nn.layers

let mktag t nn = Array.iter (mktag t) nn.layers

let mkpar nn = Array.map mkpar nn.layers

let mkpri nn = Array.map mkpri nn.layers

let mkadj nn = Array.map mkadj nn.layers

let update nn us = Array.iter2 update nn.layers us

let run x nn = Array.fold_left run x nn.layers

let forward nn x = mktag (tag ()) nn; run x nn, mkpar nn

let backward nn y = reverse_prop (F 1.) y; mkpri nn, mkadj nn

let to_string nn =
  let s = ref "Feedforward network\n\n" in
  for i = 0 to Array.length nn.layers - 1 do
    let t = to_string nn.layers.(i) in
    s := !s ^ (Printf.sprintf "(%i): %s\n" i t)
  done; !s

(*
let train nn loss_fun x =
  mktag (tag ()) nn;
  let loss = loss_fun (run x nn) in
  reverse_prop (F 1.) loss;
  loss
*)



(* ends here *)
