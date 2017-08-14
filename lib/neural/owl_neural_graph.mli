(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff.S
open Owl_neural_neuron
open Owl_neural_optimise


(** Neural network: Graphical neural network *)


(** {6 Type definition of graph network and node} *)


type node = {
  mutable name    : string;
  mutable prev    : node array;
  mutable next    : node array;
  mutable neuron  : neuron;
  mutable output  : t option;
  mutable network : network;
}
and network = {
  mutable nnid : string;      (* name of the graph network *)
  mutable size : int;         (* size of the graph network *)
  mutable root : node option; (* root of the graph network, i.e. input *)
  mutable topo : node array;  (* nodes sorted in topological order *)
}


(** {6 Various types of neural nodes} *)

val input : ?name:string -> int array -> node

val activation : ?name:string -> Activation.typ -> node -> node

val linear : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> node -> node

val linear_nobias : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> node -> node

val recurrent: ?name:string -> ?init_typ:Init.typ -> act_typ:Activation.typ -> int -> int-> node -> node

val lstm : ?name:string -> int -> node -> node

val gru : ?name:string -> int -> node -> node

val conv1d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node

val conv2d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node

val conv3d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node

val max_pool1d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node

val max_pool2d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node

val avg_pool1d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node

val avg_pool2d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node

val fully_connected : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> node -> node

val dropout : ?name:string -> float -> node -> node

val gaussian_noise : ?name:string -> float -> node -> node

val gaussian_dropout : ?name:string -> float -> node -> node

val alpha_dropout : ?name:string -> float -> node -> node

val reshape : ?name:string -> ?convert:bool -> int array -> node -> node

val flatten : ?name:string -> ?convert:bool -> node -> node

val lambda : ?name:string -> ?act_typ:Activation.typ -> (t -> t) -> node -> node

val add : ?name:string -> ?act_typ:Activation.typ -> node array -> node

val mul : ?name:string -> ?act_typ:Activation.typ -> node array -> node

val dot : ?name:string -> ?act_typ:Activation.typ -> node array -> node

val max : ?name:string -> ?act_typ:Activation.typ -> node array -> node

val average : ?name:string -> ?act_typ:Activation.typ -> node array -> node

val concatenate : ?name:string -> ?act_typ:Activation.typ -> int -> node array -> node


(** {6 Training functions} *)

val train : ?params:Params.typ -> ?init_model:bool -> network -> mat -> mat -> float array

val train_cnn : ?params:Params.typ -> ?init_model:bool -> network -> arr -> mat -> float array

val train_generic : ?params:Params.typ -> ?init_model:bool -> network -> t -> t -> float array


(** {6 Manipuate network structure} *)

val make_network : ?nnid:string -> int -> node option -> node array -> network

val make_node : ?name:string -> node array -> node array -> neuron -> t option -> network -> node

val get_network : node -> network

val get_root : network -> node

val get_node : network -> string -> node

val add_node : ?act_typ:Activation.typ -> network -> node array -> node -> node


(** {6 Save, load, and print out network} *)

val save : network -> string -> unit

val load : string -> network

val save_weights : network -> string -> unit

val load_weights : network -> string -> unit

val to_string : network -> string

val print : network -> unit
