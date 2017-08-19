(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* Module aliases *)

module NN = Owl_neural_neuron
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
    ?hiddens
    ?padding
    ?kernel
    ?stride
    ?rate
    ()
    = {
      in_shape;
      out_shape;
      init_typ;
      activation_typ;
      hiddens;
      padding;
      kernel;
      stride;
      rate;
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

  let get_param_hiddens x =
    match x.hiddens with
    | Some a -> a
    | None   -> failwith "owl_zoo_specs_neural:get_param_hiddens"

  let get_param_padding x =
    match x.padding with
    | Some a -> a
    | None   -> failwith "owl_zoo_specs_neural:get_param_padding"

  let get_param_kernel x =
    match x.kernel with
    | Some a -> a
    | None   -> failwith "owl_zoo_specs_neural:get_param_kernel"

  let get_param_stride x =
    match x.stride with
    | Some a -> a
    | None   -> failwith "owl_zoo_specs_neural:get_param_stride"

  let get_param_rate x =
    match x.rate with
    | Some a -> a
    | None   -> failwith "owl_zoo_specs_neural:get_param_rate"

end


(* Modules to convert between Owl's and Spec's types *)


module Padding = struct

  let to_specs x =
    let open Owl_dense.Ndarray.Generic in
    match x with
    | SAME   -> ST.(`SAME)
    | VALID -> ST.(`VALID)


  let of_specs x =
    let open Owl_dense.Ndarray.Generic in
    match x with
    | ST.(`SAME)  -> SAME
    | ST.(`VALID) -> VALID
    | _           -> failwith "owl_zoo_specs_neural:padding:of_specs"

end


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
    let hiddens = NN.Recurrent.(x.hiddens) in
    let param = ST.make_param ~in_shape ~out_shape ~init_typ ~hiddens in
    typ, param ()

  let of_specs x =
    let out_shape = ST.get_param_out_shape x |> Array.of_list in
    let init_typ = ST.get_param_init_typ x |> Init.of_specs in
    let hiddens = ST.get_param_hiddens x in
    let activation_typ = ST.get_param_activation_typ x in
    let neuron = NN.Recurrent.create hiddens out_shape.(0) activation_typ init_typ in
    NN.(Recurrent neuron)

end
*)

module LSTM = struct

  let to_specs x =
    let typ = ST.(`LSTM) in
    let in_shape = NN.LSTM.(x.in_shape) |> Array.to_list in
    let out_shape = NN.LSTM.(x.out_shape) |> Array.to_list in
    let init_typ = NN.LSTM.(x.init_typ) |> Init.to_specs in
    let param = ST.make_param ~in_shape ~out_shape ~init_typ in
    typ, param ()

  let of_specs x =
    let out_shape = ST.get_param_out_shape x |> Array.of_list in
    let init_typ = ST.get_param_init_typ x |> Init.of_specs in
    let neuron = NN.LSTM.create out_shape.(0) init_typ in
    NN.(LSTM neuron)

end


module GRU = struct

  let to_specs x =
    let typ = ST.(`GRU) in
    let in_shape = NN.GRU.(x.in_shape) |> Array.to_list in
    let out_shape = NN.GRU.(x.out_shape) |> Array.to_list in
    let init_typ = NN.GRU.(x.init_typ) |> Init.to_specs in
    let param = ST.make_param ~in_shape ~out_shape ~init_typ in
    typ, param ()

  let of_specs x =
    let out_shape = ST.get_param_out_shape x |> Array.of_list in
    let init_typ = ST.get_param_init_typ x |> Init.of_specs in
    let neuron = NN.GRU.create out_shape.(0) init_typ in
    NN.(GRU neuron)

end


module Conv2D = struct

  let to_specs x =
    let typ = ST.(`Conv2D) in
    let init_typ = NN.Conv2D.(x.init_typ) |> Init.to_specs in
    let in_shape = NN.Conv2D.(x.in_shape) |> Array.to_list in
    let out_shape = NN.Conv2D.(x.out_shape) |> Array.to_list in
    let padding = NN.Conv2D.(x.padding) |> Padding.to_specs in
    let kernel = NN.Conv2D.(x.kernel) |> Array.to_list in
    let stride = NN.Conv2D.(x.stride) |> Array.to_list in
    let param = ST.make_param ~init_typ ~in_shape ~out_shape ~padding ~kernel ~stride in
    typ, param ()

  let of_specs x =
    let padding = ST.get_param_padding x |> Padding.of_specs in
    let kernel = ST.get_param_kernel x |> Array.of_list in
    let stride = ST.get_param_stride x |> Array.of_list in
    let init_typ = ST.get_param_init_typ x |> Init.of_specs in
    let neuron = NN.Conv2D.create padding kernel stride init_typ in
    NN.(Conv2D neuron)

end


module Conv3D = struct

  let to_specs x =
    let typ = ST.(`Conv3D) in
    let init_typ = NN.Conv3D.(x.init_typ) |> Init.to_specs in
    let in_shape = NN.Conv3D.(x.in_shape) |> Array.to_list in
    let out_shape = NN.Conv3D.(x.out_shape) |> Array.to_list in
    let padding = NN.Conv3D.(x.padding) |> Padding.to_specs in
    let kernel = NN.Conv3D.(x.kernel) |> Array.to_list in
    let stride = NN.Conv3D.(x.stride) |> Array.to_list in
    let param = ST.make_param ~init_typ ~in_shape ~out_shape ~padding ~kernel ~stride in
    typ, param ()

  let of_specs x =
    let padding = ST.get_param_padding x |> Padding.of_specs in
    let kernel = ST.get_param_kernel x |> Array.of_list in
    let stride = ST.get_param_stride x |> Array.of_list in
    let init_typ = ST.get_param_init_typ x |> Init.of_specs in
    let neuron = NN.Conv3D.create padding kernel stride init_typ in
    NN.(Conv3D neuron)

end


module FullyConnected = struct

  let to_specs x =
    let typ = ST.(`FullyConnected) in
    let init_typ = NN.FullyConnected.(x.init_typ) |> Init.to_specs in
    let in_shape = NN.FullyConnected.(x.in_shape) |> Array.to_list in
    let out_shape = NN.FullyConnected.(x.out_shape) |> Array.to_list in
    let param = ST.make_param ~init_typ ~in_shape ~out_shape in
    typ, param ()

  let of_specs x =
    let out_shape = ST.get_param_out_shape x |> Array.of_list in
    let init_typ = ST.get_param_init_typ x |> Init.of_specs in
    let neuron = NN.FullyConnected.create out_shape.(0) init_typ in
    NN.(FullyConnected neuron)

end


module MaxPool2D = struct

  let to_specs x =
    let typ = ST.(`MaxPool2D) in
    let in_shape = NN.MaxPool2D.(x.in_shape) |> Array.to_list in
    let out_shape = NN.MaxPool2D.(x.out_shape) |> Array.to_list in
    let padding = NN.MaxPool2D.(x.padding) |> Padding.to_specs in
    let kernel = NN.MaxPool2D.(x.kernel) |> Array.to_list in
    let stride = NN.MaxPool2D.(x.stride) |> Array.to_list in
    let param = ST.make_param ~in_shape ~out_shape ~padding ~kernel ~stride in
    typ, param ()

  let of_specs x =
    let padding = ST.get_param_padding x |> Padding.of_specs in
    let kernel = ST.get_param_kernel x |> Array.of_list in
    let stride = ST.get_param_stride x |> Array.of_list in
    let neuron = NN.MaxPool2D.create padding kernel stride in
    NN.(MaxPool2D neuron)

end


module Dropout = struct

  let to_specs x =
    let typ = ST.(`Dropout) in
    let rate = NN.Dropout.(x.rate) in
    let in_shape = NN.Dropout.(x.in_shape) |> Array.to_list in
    let out_shape = NN.Dropout.(x.out_shape) |> Array.to_list in
    let param = ST.make_param ~rate ~in_shape ~out_shape in
    typ, param ()

  let of_specs x =
    let rate = ST.get_param_rate x in
    let neuron = NN.Dropout.create rate in
    NN.(Dropout neuron)

end


module Neuron = struct

  let to_specs = function
    | NN.Input x          -> Input.to_specs x
    | NN.Activation x     -> Activation.to_specs x
    | NN.Linear x         -> Linear.to_specs x
    | NN.LinearNoBias x   -> LinearNoBias.to_specs x
    | NN.LSTM x           -> LSTM.to_specs x
    | NN.GRU x            -> GRU.to_specs x
    | NN.Conv2D x         -> Conv2D.to_specs x
    | NN.Conv3D x         -> Conv3D.to_specs x
    | NN.FullyConnected x -> FullyConnected.to_specs x
    | NN.MaxPool2D x      -> MaxPool2D.to_specs x
    | NN.Dropout x        -> Dropout.to_specs x
    | _                   -> failwith "owl_zoo_specs_neural:neuron:to_specs"

  let of_specs x =
    let open ST in
    match x.neuron with
    | `Input          -> Input.of_specs x.param
    | `Activation     -> Activation.of_specs x.param
    | `Linear         -> Linear.of_specs x.param
    | `LinearNoBias   -> LinearNoBias.of_specs x.param
    | `LSTM           -> LSTM.of_specs x.param
    | `GRU            -> GRU.of_specs x.param
    | `Conv2D         -> Conv2D.of_specs x.param
    | `Conv3D         -> Conv3D.of_specs x.param
    | `FullyConnected -> FullyConnected.of_specs x.param
    | `MaxPool2D      -> MaxPool2D.of_specs x.param
    | `Dropout        -> Dropout.of_specs x.param
    | _               -> failwith "owl_zoo_specs_neural:neuron:of_specs"

  let to_string = function
    | NN.Input x          -> "input"
    | NN.Activation x     -> "activation"
    | NN.Linear x         -> "linear"
    | NN.LinearNoBias x   -> "linearnobias"
    | NN.LSTM x           -> "lstm"
    | NN.GRU x            -> "gru"
    | NN.Conv2D x         -> "conv2d"
    | NN.Conv3D x         -> "conv3d"
    | NN.FullyConnected x -> "fullyconnected"
    | NN.MaxPool2D x      -> "maxpool2d"
    | NN.Dropout x        -> "dropout"
    | _               -> failwith "owl_zoo_specs_neural:neuron:to_string"

end


module Graph = struct

  let to_specs x =
    let topo = GN.(x.topo)
      |> Array.to_list
      |> List.map (fun n ->
          let neuron, param = Neuron.to_specs GN.(n.neuron) in
          let name = GN.(n.name) in
          let prev = GN.(n.prev) |> Array.map (fun m -> GN.(m.name)) |> Array.to_list in
          let next = GN.(n.next) |> Array.map (fun m -> GN.(m.name)) |> Array.to_list in
          ST.({ name; neuron; param; prev; next })
        )
    in
    let nnid = GN.(x.nnid) in
    let root = GN.((get_root x).name) in
    let weights = Some "" in
    ST.({ nnid; root; topo; weights })

  let of_specs x =
    let network = GN.make_network ~nnid:ST.(x.nnid) 0 None [||] in
    ST.(x.topo)
    |> Array.of_list
    |> Array.iter (fun n ->
        let neuron = Neuron.of_specs n in
        let prev = ST.(n.prev) |> List.map (GN.get_node network) |> Array.of_list in
        let name = ST.(n.name) in
        let node = GN.make_node ~name [||] [||] neuron None network in
        GN.add_node network prev node |> ignore
      );
    GN.(network.root <- Some (get_node network ST.(x.root)));
    let weights_url =
      match ST.(x.weights) with
      | Some s -> s
      | None   -> ""
    in
    if weights_url <> "" then (
      (* TODO: download the file *)
      GN.load_weights network weights_url
    );
    network

  let to_json x = x
    |> to_specs
    |> SJ.string_of_graph
    |> Yojson.Safe.prettify

  let of_json x = x
    |> SJ.graph_of_string
    |> of_specs

end
