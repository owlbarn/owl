(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Neural network: Graphical neural network *)

open Owl_types


(* Make functor starts *)

module Make
  (A : Ndarray_Algodiff)
  = struct

  module Neuron = Owl_neural_neuron.Make (A)
  module Optimise = Owl_optimise_generic.Make (A)
  open Neuron


  (* graph network and node definition *)

  type node = {
    mutable name    : string;     (* name of a node *)
    mutable prev    : node array; (* parents of a node *)
    mutable next    : node array; (* children of a node *)
    mutable neuron  : neuron;     (* neuron contained in a node *)
    mutable output  : t option;   (* output of a node *)
    mutable network : network;    (* network a node belongs to *)
    mutable train   : bool;       (* specify if a node is only for training *)
  }
  and network = {
    mutable nnid : string;        (* name of the graph network *)
    mutable size : int;           (* size of the graph network *)
    mutable root : node option;   (* root of the graph network, i.e. input *)
    mutable topo : node array;    (* nodes sorted in topological order *)
  }


  (* functions to manipulate the network *)

  let make_network ?nnid size root topo =
    let nnid = match nnid with
      | Some s -> s
      | None   -> "Graphical network"
    in
    { nnid; size; root; topo; }


  let make_node ?name ?(train=false) prev next neuron output network =
    let name = match name with
      | Some s -> s
      | None   -> Printf.sprintf "%s_%i" (to_name neuron) network.size
    in
    {
      name;
      prev;
      next;
      neuron;
      output;
      network;
      train;
    }


  let get_root nn =
    match nn.root with
    | Some n -> n
    | None   -> failwith "Owl_neural_graph:get_root"


  let get_node nn name =
    let x = Owl_utils.Array.filter (fun n -> n.name = name) nn.topo in
    if Array.length x = 0 then failwith "Owl_neural_graph:get_node"
    else x.(0)


  let get_network ?name n =
    let name = match name with
      | Some s -> s
      | None   -> Random.int 65535 |> string_of_int
    in
    n.network.nnid <- name;
    n.network


  let get_network_name n = n.nnid


  let set_network_name n name = n.nnid <- name


  let input_shape n = (get_root n).neuron |> Neuron.get_in_shape


  (* collect the outputs of a given set of nodes *)
  let collect_output nodes =
    Array.map (fun n ->
      match n.output with
      | Some o -> o
      | None   -> failwith "Owl_neural_graph:collect_output"
    ) nodes


  let connect_pair prev next =
    if Array.mem prev next.prev = false then
      next.prev <- Array.append next.prev [|prev|];
    if Array.mem next prev.next = false then
      prev.next <- Array.append prev.next [|next|]


  let connect_to_parents parents child =
    (* update the child's input and output shape *)
    if Array.length parents > 0 then (
      let out_shapes = Array.map (fun n ->
        n.neuron |> get_out_shape
      ) parents
      in
      connect out_shapes child.neuron
    );
    (* connect the child to the parents *)
    Array.iter (fun p ->
      connect_pair p child
    ) parents


  (* add child node to nn and connect to parents *)
  let rec add_node ?act_typ nn parents child =
    nn.size <- nn.size + 1;
    connect_to_parents parents child;
    nn.topo <- Array.append nn.topo [|child|];
    child.network <- nn;
    (* if activation is specified, recursively add_node *)
    match act_typ with
    | Some act -> (
        let neuron = Activation (Activation.create act) in
        let child_of_child = make_node [||] [||] neuron None nn in
        add_node nn [|child|] child_of_child
      )
    | None     -> child


  (* functions to interface to optimisation engine *)


  let init nn = Array.iter (fun n -> init n.neuron) nn.topo


  let reset nn = Array.iter (fun n -> reset n.neuron) nn.topo


  let mktag t nn = Array.iter (fun n -> mktag t n.neuron) nn.topo


  let mkpar nn = Array.map (fun n -> mkpar n.neuron) nn.topo


  let mkpri nn = Array.map (fun n -> mkpri n.neuron) nn.topo


  let mkadj nn = Array.map (fun n -> mkadj n.neuron) nn.topo


  let update nn us = Array.iter2 (fun n u -> update n.neuron u) nn.topo us


  let run x nn =
    Array.iter (fun n ->
      (* collect the inputs from parents' output *)
      let input = match n.neuron with
        | Input _ -> [|x|]
        | _       -> collect_output n.prev
      in
      (* process the current neuron, save output *)
      let output = run input n.neuron in
      n.output <- Some output
    ) nn.topo;
    (* collect the final output from the tail *)
    let sink = [|nn.topo.(Array.length nn.topo - 1)|] in
    (collect_output sink).(0)


  let forward nn x = mktag (tag ()) nn; run x nn, mkpar nn


  let backward nn y = reverse_prop (_f 1.) y; mkpri nn, mkadj nn


  let copy nn =
    let nn' = make_network ~nnid:nn.nnid nn.size None [||] in
    (* first iteration to copy the neurons *)
    nn'.topo <- Array.map (fun node ->
      let neuron' = copy node.neuron in
      make_node ~name:node.name ~train:node.train [||] [||] neuron' None nn'
    ) nn.topo;
    (* second iteration to re-construct the structure and infer the shape *)
    Array.iter2 (fun node node' ->
      node'.prev <- Array.map (fun n -> get_node nn' n.name) node.prev;
      node'.next <- Array.map (fun n -> get_node nn' n.name) node.next;
      connect_to_parents node'.prev node'
    ) nn.topo nn'.topo;
    (* set root to finalise the structure *)
    nn'.root <- Some (get_node nn' (get_root nn).name);
    nn'


  let _remove_training_nodes nn =
    let topo' = Owl_utils.Array.filter (fun n ->
      if n.train = true then (
        (* remove myself from my parents *)
        Array.iter (fun m ->
          let next' = Owl_utils.Array.filter (fun x -> x.name <> n.name) m.next in
          m.next <- next'
        ) n.prev;
        (* remove myself from my children *)
        Array.iter (fun m ->
          let prev' = Owl_utils.Array.filter (fun x -> x.name <> n.name) m.prev in
          m.prev <- prev'
        ) n.next;
        (* connect my parents and my children *)
        Array.iter (connect_to_parents n.prev) n.next
      );
      not n.train
    ) nn.topo
    in
    nn.topo <- topo'


  let model nn =
    let nn = copy nn in
    _remove_training_nodes nn;
    let inference x =
      match run (Arr x) nn with
      | Arr y -> y
      | _     -> failwith "Owl_neural_graph:model"
    in
    inference


  (* functions to create functional nodes *)


  let input ?name inputs =
    let neuron = Input (Input.create inputs) in
    let nn = make_network 0 None [||] in
    let n = make_node ?name [||] [||] neuron None nn in
    nn.root <- Some n;
    add_node nn [||] n


  let activation ?name act_typ input_node =
    let neuron = Activation (Activation.create act_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let linear ?name ?(init_typ=Init.Standard) ?act_typ outputs input_node =
    let neuron = Linear (Linear.create outputs init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let linear_nobias ?name ?(init_typ=Init.Standard) ?act_typ outputs input_node =
    let neuron = LinearNoBias (LinearNoBias.create outputs init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let embedding ?name ?(init_typ=Init.Standard) ?act_typ in_dim out_dim input_node =
    let neuron = Embedding (Embedding.create in_dim out_dim init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let recurrent ?name ?(init_typ=Init.Standard) ~act_typ outputs hiddens input_node =
    let neuron = Recurrent (Recurrent.create hiddens outputs act_typ init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let lstm ?name ?(init_typ=Init.Tanh) cells input_node =
    let neuron = LSTM (LSTM.create cells init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let gru ?name ?(init_typ=Init.Tanh) cells input_node =
    let neuron = GRU (GRU.create cells init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let conv1d ?name ?(padding=SAME) ?(init_typ=Init.Tanh) ?act_typ kernel strides input_node =
    let neuron = Conv1D (Conv1D.create padding kernel strides init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let conv2d ?name ?(padding=SAME) ?(init_typ=Init.Tanh) ?act_typ kernel strides input_node =
    let neuron = Conv2D (Conv2D.create padding kernel strides init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let conv3d ?name ?(padding=SAME) ?(init_typ=Init.Tanh) ?act_typ kernel strides input_node =
    let neuron = Conv3D (Conv3D.create padding kernel strides init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let dilated_conv1d ?name ?(padding=SAME) ?(stride=[|1|]) ?(init_typ=Init.Tanh) ?act_typ kernel rate input_node =
    let neuron = DilatedConv1D (DilatedConv1D.create padding ~stride kernel rate init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let dilated_conv2d ?name ?(padding=SAME) ?(stride=[|1; 1|]) ?(init_typ=Init.Tanh) ?act_typ kernel rate input_node =
    let neuron = DilatedConv2D (DilatedConv2D.create padding ~stride kernel rate init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let dilated_conv3d ?name ?(padding=SAME) ?(stride=[|1; 1; 1|]) ?(init_typ=Init.Tanh) ?act_typ kernel rate input_node =
    let neuron = DilatedConv3D (DilatedConv3D.create padding ~stride kernel rate init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let transpose_conv1d ?name ?(padding =SAME) ?(init_typ=Init.Tanh) ?act_typ kernel strides input_node =
    let neuron = TransposeConv1D (TransposeConv1D.create padding kernel strides init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let transpose_conv2d ?name ?(padding=SAME) ?(init_typ=Init.Tanh) ?act_typ kernel strides input_node =
    let neuron = TransposeConv2D (TransposeConv2D.create padding kernel strides init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let transpose_conv3d ?name ?(padding=SAME) ?(init_typ=Init.Tanh) ?act_typ kernel strides input_node =
    let neuron = TransposeConv3D (TransposeConv3D.create padding kernel strides init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let fully_connected ?name ?(init_typ=Init.Standard) ?act_typ outputs input_node =
    let neuron = FullyConnected (FullyConnected.create outputs init_typ) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let max_pool1d ?name ?(padding=SAME) ?act_typ kernel stride input_node =
    let neuron = MaxPool1D (MaxPool1D.create padding kernel stride) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let max_pool2d ?name ?(padding=SAME) ?act_typ kernel stride input_node =
    let neuron = MaxPool2D (MaxPool2D.create padding kernel stride) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let avg_pool1d ?name ?(padding=SAME) ?act_typ kernel stride input_node =
    let neuron = AvgPool1D (AvgPool1D.create padding kernel stride) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let avg_pool2d ?name ?(padding=SAME) ?act_typ kernel stride input_node =
    let neuron = AvgPool2D (AvgPool2D.create padding kernel stride) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let global_max_pool1d ?name ?act_typ input_node =
    let neuron = GlobalMaxPool1D (GlobalMaxPool1D.create ()) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let global_max_pool2d ?name ?act_typ input_node =
    let neuron = GlobalMaxPool2D (GlobalMaxPool2D.create ()) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let global_avg_pool1d ?name ?act_typ input_node =
    let neuron = GlobalAvgPool1D (GlobalAvgPool1D.create ()) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let global_avg_pool2d ?name ?act_typ input_node =
    let neuron = GlobalAvgPool2D (GlobalAvgPool2D.create ()) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let dropout ?name rate input_node =
    let neuron = Dropout (Dropout.create rate) in
    let nn = get_network input_node in
    let n = make_node ?name ~train:true [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let gaussian_noise ?name sigma input_node =
    let neuron = GaussianNoise (GaussianNoise.create sigma) in
    let nn = get_network input_node in
    let n = make_node ?name ~train:true [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let gaussian_dropout ?name rate input_node =
    let neuron = GaussianDropout (GaussianDropout.create rate) in
    let nn = get_network input_node in
    let n = make_node ?name ~train:true [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let alpha_dropout ?name rate input_node =
    let neuron = AlphaDropout (AlphaDropout.create rate) in
    let nn = get_network input_node in
    let n = make_node ?name ~train:true [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let normalisation ?name ?(axis=(-1)) ?training ?decay ?mu ?var input_node =
    let neuron = Normalisation (Normalisation.create ?training ?decay ?mu ?var axis) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let reshape ?name outputs input_node =
    let neuron = Reshape (Reshape.create outputs) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let flatten ?name input_node =
    let neuron = Flatten (Flatten.create ()) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node nn [|input_node|] n


  let lambda ?name ?act_typ lambda input_node =
    let neuron = Lambda (Lambda.create lambda) in
    let nn = get_network input_node in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn [|input_node|] n


  let add ?name ?act_typ input_node =
    let neuron = Add (Add.create ()) in
    let nn = get_network input_node.(0) in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn input_node n


  let mul ?name ?act_typ input_node =
    let neuron = Mul (Mul.create ()) in
    let nn = get_network input_node.(0) in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn input_node n


  let dot ?name ?act_typ input_node =
    let neuron = Dot (Dot.create ()) in
    let nn = get_network input_node.(0) in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn input_node n


  let max ?name ?act_typ input_node =
    let neuron = Max (Max.create ()) in
    let nn = get_network input_node.(0) in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn input_node n


  let average ?name ?act_typ input_node =
    let neuron = Average (Average.create ()) in
    let nn = get_network input_node.(0) in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn input_node n


  let concatenate ?name ?act_typ axis input_node =
    let neuron = Concatenate (Concatenate.create axis) in
    let nn = get_network input_node.(0) in
    let n = make_node ?name [||] [||] neuron None nn in
    add_node ?act_typ nn input_node n


  (* I/O functions *)


  let to_string nn =
    let s = ref (nn.nnid ^ "\n\n") in
    Array.iter (fun n ->
      let prev = Array.map (fun n -> n.name) n.prev
        |> Owl_utils_array.to_string (fun s -> s)
      in
      let next = Array.map (fun n -> n.name) n.next
        |> Owl_utils_array.to_string (fun s -> s)
      in
      s := !s ^
        Printf.sprintf "\x1b[31m[ Node %s ]:\x1b[0m\n" n.name ^
        Printf.sprintf "%s" (to_string n.neuron) ^
        Printf.sprintf "    prev:[%s] next:[%s]\n\n" prev next
    ) nn.topo; !s


  let pp_network formatter nn =
    Format.open_box 0;
    Format.fprintf formatter "%s" (to_string nn);
    Format.close_box ()


  let print nn = pp_network Format.std_formatter nn


  let save nn f = Owl_io.marshal_to_file (copy nn) f


  let load f : network = Owl_io.marshal_from_file f


  let save_weights nn f =
    let h = Hashtbl.create nn.size in
    Array.iter (fun n ->
      let ws = Neuron.mkpar n.neuron in
      Hashtbl.add h n.name ws
    ) nn.topo;
    Owl_io.marshal_to_file h f


  let load_weights nn f =
    let h = Owl_io.marshal_from_file f in
    Array.iter (fun n ->
      let ws = Hashtbl.find h n.name in
      Neuron.update n.neuron ws
    ) nn.topo


  (* training functions *)

  (* generic minimisation functions
     forward: fucntion to run the forward pass
     backward: function to run the backward pass
     update: function to update the weights according to the gradient
     save: function to save the model for checkpoint
   *)
  let train_generic ?state ?params ?(init_model=true) nn x y =
    if init_model = true then init nn;
    let f = forward nn in
    let b = backward nn in
    let u = update nn in
    let s = save nn in
    let p = match params with
      | Some p -> p
      | None   -> Optimise.Params.default ()
    in
    Optimise.minimise_network ?state p f b u s x y


  let train ?state ?params ?init_model nn x y =
    train_generic ?state ?params ?init_model nn (Arr x) (Arr y)



end

(* Make functor ends *)
