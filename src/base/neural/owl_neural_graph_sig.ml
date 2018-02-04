(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_types


module type Sig = sig


  module Neuron : Owl_neural_neuron_sig.Sig

  module Optimise : Owl_optimise_generic_sig.Sig

  open Neuron

  open Optimise


  type node = {
  mutable name : string;
  mutable prev : node array;
  mutable next : node array;
  mutable neuron : neuron;
  mutable output : t option;
  mutable network : network;
  mutable train : bool;
}
and network = {
  mutable nnid : string;
  mutable size : int;
  mutable root : node option;
  mutable topo : node array;
}
val make_network :
  ?nnid:string -> int -> node option -> node array -> network
val make_node :
  ?name:string ->
  ?train:bool ->
  node array ->
  node array -> neuron -> t option -> network -> node
val get_root : network -> node
val get_node : network -> string -> node
val get_network : node -> network
val collect_output : node array -> t array
val connect_pair : node -> node -> unit
val connect_to_parents : node array -> node -> unit
val add_node :
  ?act_typ:Activation.typ -> network -> node array -> node -> node
val init : network -> unit
val reset : network -> unit
val mktag : int -> network -> unit
val mkpar : network -> t array array
val mkpri : network -> t array array
val mkadj : network -> t array array
val update : network -> t array array -> unit
val run : t -> network -> t
val forward :
  network -> t -> t * t array array
val backward :
  network ->
  t -> t array array * t array array
val copy : network -> network
val model : network -> arr -> arr
val input : ?name:string -> int array -> node
val activation : ?name:string -> Activation.typ -> node -> node
val linear :
  ?name:string ->
  ?init_typ:Init.typ ->
  ?act_typ:Activation.typ -> int -> node -> node
val linear_nobias :
  ?name:string ->
  ?init_typ:Init.typ ->
  ?act_typ:Activation.typ -> int -> node -> node
val embedding :
  ?name:string ->
  ?init_typ:Init.typ ->
  ?act_typ:Activation.typ -> int -> int -> node -> node
val recurrent :
  ?name:string ->
  ?init_typ:Init.typ ->
  act_typ:Activation.typ -> int -> int -> node -> node
val lstm :
  ?name:string -> ?init_typ:Init.typ -> int -> node -> node
val gru :
  ?name:string -> ?init_typ:Init.typ -> int -> node -> node
val conv1d :
  ?name:string ->
  ?padding:Owl_types.padding ->
  ?init_typ:Init.typ ->
  ?act_typ:Activation.typ ->
  int array -> int array -> node -> node
val conv2d :
  ?name:string ->
  ?padding:Owl_types.padding ->
  ?init_typ:Init.typ ->
  ?act_typ:Activation.typ ->
  int array -> int array -> node -> node
val conv3d :
  ?name:string ->
  ?padding:Owl_types.padding ->
  ?init_typ:Init.typ ->
  ?act_typ:Activation.typ ->
  int array -> int array -> node -> node
val fully_connected :
  ?name:string ->
  ?init_typ:Init.typ ->
  ?act_typ:Activation.typ -> int -> node -> node
val max_pool1d :
  ?name:string ->
  ?padding:Owl_types.padding ->
  ?act_typ:Activation.typ ->
  int array -> int array -> node -> node
val max_pool2d :
  ?name:string ->
  ?padding:Owl_types.padding ->
  ?act_typ:Activation.typ ->
  int array -> int array -> node -> node
val avg_pool1d :
  ?name:string ->
  ?padding:Owl_types.padding ->
  ?act_typ:Activation.typ ->
  int array -> int array -> node -> node
val avg_pool2d :
  ?name:string ->
  ?padding:Owl_types.padding ->
  ?act_typ:Activation.typ ->
  int array -> int array -> node -> node
val global_max_pool1d :
  ?name:string -> ?act_typ:Activation.typ -> node -> node
val global_max_pool2d :
  ?name:string -> ?act_typ:Activation.typ -> node -> node
val global_avg_pool1d :
  ?name:string -> ?act_typ:Activation.typ -> node -> node
val global_avg_pool2d :
  ?name:string -> ?act_typ:Activation.typ -> node -> node
val dropout : ?name:string -> float -> node -> node
val gaussian_noise : ?name:string -> float -> node -> node
val gaussian_dropout : ?name:string -> float -> node -> node
val alpha_dropout : ?name:string -> float -> node -> node
val normalisation :
  ?name:string ->
  ?axis:int ->
  ?training:bool ->
  ?decay:float -> ?mu:arr -> ?var:arr -> node -> node
val reshape : ?name:string -> int array -> node -> node
val flatten : ?name:string -> node -> node
val lambda :
  ?name:string ->
  ?act_typ:Activation.typ ->
  (t -> t) -> node -> node
val add :
  ?name:string -> ?act_typ:Activation.typ -> node array -> node
val mul :
  ?name:string -> ?act_typ:Activation.typ -> node array -> node
val dot :
  ?name:string -> ?act_typ:Activation.typ -> node array -> node
val max :
  ?name:string -> ?act_typ:Activation.typ -> node array -> node
val average :
  ?name:string -> ?act_typ:Activation.typ -> node array -> node
val concatenate :
  ?name:string ->
  ?act_typ:Activation.typ -> int -> node array -> node
val to_string : network -> string
val pp_network : Format.formatter -> network -> unit
val print : network -> unit
val save : network -> string -> unit
val load : string -> network
val save_weights : network -> string -> unit
val load_weights : network -> string -> unit
val train_generic :
  ?state:Checkpoint.state ->
  ?params:Params.typ ->
  ?init_model:bool ->
  network -> t -> t -> Checkpoint.state
val train :
  ?state:Checkpoint.state ->
  ?params:Params.typ ->
  ?init_model:bool ->
  network -> arr -> arr -> Checkpoint.state

end


(* This is a dumb module for checking the module signature. *)

module Impl (A : Ndarray_Algodiff) : Sig = Owl_neural_graph.Make (A)
