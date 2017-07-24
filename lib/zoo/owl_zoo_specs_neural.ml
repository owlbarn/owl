(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* Module aliases *)

module NN = Owl_neural_neuron
module FN = Owl_neural_feedforward
module GN = Owl_neural_graph
module SJ = Owl_zoo_specs_neural_j


(* Enhanced Specs T module *)

module ST = struct

  include Owl_zoo_specs_neural_t

  let make_param
    ?in_shape
    ?out_shape
    ?init_typ
    ?activation_typ
    ?hidden_units
    ()
    = {
      in_shape;
      out_shape;
      init_typ;
      activation_typ;
      hidden_units;
    }

  let get_param_in_shape x =
    match x.in_shape with
    | Some a -> a
    | None   -> failwith "owl_zoo_specs_neural:get_param_in_shape"

  let get_param_out_shape x =
    match x.out_shape with
    | Some a -> a
    | None   -> failwith "owl_zoo_specs_neural:get_param_out_shape"

  let get_param_init_typ x =
    match x.init_typ with
    | Some a -> a
    | None   -> failwith "owl_zoo_specs_neural:get_param_init_typ"

  let get_param_activation_typ x =
    match x.activation_typ with
    | Some a -> a
    | None   -> failwith "owl_zoo_specs_neural:get_param_activation_typ"

  let get_param_hidden_units x =
    match x.hidden_units with
    | Some a -> a
    | None   -> failwith "owl_zoo_specs_neural:get_param_hidden_units"

end


(* Modules to convert between Owl's and Spec's types *)

module Init = struct

  let to_specs x =
    let open NN.Init in
    match x with
    | Uniform (a, b)       -> ST.(`Uniform (a, b))
    | Gaussian (mu, sigma) -> ST.(`Gaussian (mu, sigma))
    | Standard             -> ST.(`Standard)
    | Tanh                 -> ST.(`Tanh)
    | _                    -> failwith "owl_zoo_specs_neural:init:to_specs"

  let of_specs x =
    let open ST in
    match x with
    | `Uniform (a, b)       -> NN.Init.(Uniform (a, b))
    | `Gaussian (mu, sigma) -> NN.Init.(Gaussian (mu, sigma))
    | `Standard             -> NN.Init.(Standard)
    | `Tanh                 -> NN.Init.(Tanh)
    | _                     -> failwith "owl_zoo_specs_neural:of_specs"

end


module Input = struct

  let to_specs x =
    let typ = ST.(`Input) in
    let in_shape = NN.Input.(x.in_shape) |> Array.to_list in
    let param = ST.make_param ~in_shape in
    typ, param ()

  let of_specs x =
    let in_shape = ST.get_param_in_shape x |> Array.of_list in
    let neuron = NN.Input.create in_shape in
    NN.(Input neuron)

end


module Activation = struct

  let to_specs x =
    let open NN.Activation in
    let typ = ST.(`Activation) in
    let in_shape = x.in_shape |> Array.to_list in
    let out_shape = x.out_shape |> Array.to_list in
    let param = match x.activation with
      | Relu    -> ST.(make_param ~in_shape ~out_shape ~activation_typ:`Relu)
      | Sigmoid -> ST.(make_param ~in_shape ~out_shape ~activation_typ:`Sigmoid)
      | Softmax -> ST.(make_param ~in_shape ~out_shape ~activation_typ:`Softmax)
      | Tanh    -> ST.(make_param ~in_shape ~out_shape ~activation_typ:`Tanh)
      | None    -> ST.(make_param ~in_shape ~out_shape ~activation_typ:`None)
      | _       -> failwith "owl_zoo_specs_neural:activation:to_specs"
    in
    typ, param ()

  let of_specs x =
    let open ST in
    let activation_typ = ST.get_param_activation_typ x in
    let activation = match activation_typ with
      | `Relu    -> NN.Activation.Relu
      | `Sigmoid -> NN.Activation.Sigmoid
      | `Softmax -> NN.Activation.Softmax
      | `Tanh    -> NN.Activation.Tanh
      | `None    -> NN.Activation.None
    in
    let neuron = NN.Activation.create activation in
    NN.(Activation neuron)

end


module Linear = struct

  let to_specs x =
    let typ = ST.(`Linear) in
    let in_shape = NN.Linear.(x.in_shape) |> Array.to_list in
    let out_shape = NN.Linear.(x.out_shape) |> Array.to_list in
    let init_typ = NN.Linear.(x.init_typ) |> Init.to_specs in
    let param = ST.make_param ~in_shape ~out_shape ~init_typ in
    typ, param ()

  let of_specs x =
    let out_shape = ST.get_param_out_shape x |> Array.of_list in
    let init_typ = ST.get_param_init_typ x |> Init.of_specs in
    let neuron = NN.Linear.create out_shape.(0) init_typ in
    NN.(Linear neuron)

end


module LinearNoBias = struct

  let to_specs x =
    let typ = ST.(`LinearNoBias) in
    let in_shape = NN.LinearNoBias.(x.in_shape) |> Array.to_list in
    let out_shape = NN.LinearNoBias.(x.out_shape) |> Array.to_list in
    let init_typ = NN.LinearNoBias.(x.init_typ) |> Init.to_specs in
    let param = ST.make_param ~in_shape ~out_shape ~init_typ in
    typ, param ()

  let of_specs x =
    let out_shape = ST.get_param_out_shape x |> Array.of_list in
    let init_typ = ST.get_param_init_typ x |> Init.of_specs in
    let neuron = NN.LinearNoBias.create out_shape.(0) init_typ in
    NN.(LinearNoBias neuron)

end

(*
module Recurrent = struct

  let to_specs x =
    let typ = ST.(`Recurrent) in
    let in_shape = NN.Recurrent.(x.in_shape) |> Array.to_list in
    let out_shape = NN.Recurrent.(x.out_shape) |> Array.to_list in
    let init_typ = NN.Recurrent.(x.init_typ) |> Init.to_specs in
    let param = ST.make_param ~in_shape ~out_shape ~init_typ in
    typ, param ()

  let of_specs x =
    let out_shape = ST.get_param_out_shape x |> Array.of_list in
    let init_typ = ST.get_param_init_typ x |> Init.of_specs in
    let neuron = NN.Recurrent.create out_shape.(0) init_typ in
    NN.(Recurrent neuron)

end
*)

module Neuron = struct

  let to_specs = function
    | NN.Input x      -> Input.to_specs x
    | NN.Activation x -> Activation.to_specs x
    | NN.Linear x     -> Linear.to_specs x
    | _               -> failwith "owl_zoo_specs_neural:neuron:to_specs"

  let of_specs x =
    let open ST in
    match x.neuron with
    | `Input      -> Input.of_specs x.param
    | `Activation -> Activation.of_specs x.param
    | `Linear     -> Linear.of_specs x.param
    | _           -> failwith "owl_zoo_specs_neural:neuron:of_specs"

  let to_string = function
    | NN.Input x      -> "input"
    | NN.Activation x -> "activation"
    | NN.Linear x     -> "linear"
    | _               -> failwith "owl_zoo_specs_neural:neuron:to_string"

end


module Feedforward = struct

  let to_specs x =
    let layers = FN.(x.layers)
      |> Array.to_list
      |> List.mapi (fun i l ->
          let neuron, param = Neuron.to_specs l in
          let name = Printf.sprintf "%s_%i" (Neuron.to_string l) i in
          ST.({ name; neuron; param })
        )
    in
    ST.({ name = "Feedforward"; layers })

  let of_specs x =
    let network = FN.create () in
    ST.(x.layers)
    |> Array.of_list
    |> Array.iter (fun l ->
        let l' = Neuron.of_specs l in
        FN.add_layer network l'
      );
    network

  let to_json x = x
    |> to_specs
    |> SJ.string_of_feedforward
    |> Yojson.Safe.prettify

  let of_json x = x
    |> SJ.feedforward_of_string
    |> of_specs

end


(* FIXME: for debug purpose *)
let make_example_network () =
  let open Owl_neural in
  let open Feedforward in
  let nn = input [|784|]
    |> linear 300 ~act_typ:Activation.Tanh
    |> linear 10  ~act_typ:Activation.Softmax
  in
  nn


let _ =
  let nn = make_example_network () in
  let s = Feedforward.to_json nn in
  print_endline s;
  let nn = Feedforward.of_json s in
  FN.print nn
