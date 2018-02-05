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


  (** {6 Type definition} *)

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
  (** TODO *)


  (** {6 Manipuate networks} *)

  val make_network : ?nnid:string -> int -> node option -> node array -> network
  (** TODO *)

  val make_node : ?name:string -> ?train:bool -> node array -> node array -> neuron -> t option -> network -> node
  (** TODO *)

  val get_root : network -> node
  (** TODO *)

  val get_node : network -> string -> node
  (** TODO *)

  val get_network : node -> network
  (** TODO *)

  val collect_output : node array -> t array
  (** TODO *)

  val connect_pair : node -> node -> unit
  (** TODO *)

  val connect_to_parents : node array -> node -> unit
  (** TODO *)

  val add_node : ?act_typ:Activation.typ -> network -> node array -> node -> node
  (** TODO *)


  (** {6 Interface to optimisation engine} *)

  val init : network -> unit
  (** TODO *)

  val reset : network -> unit
  (** TODO *)

  val mktag : int -> network -> unit
  (** TODO *)

  val mkpar : network -> t array array
  (** TODO *)

  val mkpri : network -> t array array
  (** TODO *)

  val mkadj : network -> t array array
  (** TODO *)

  val update : network -> t array array -> unit
  (** TODO *)

  val run : t -> network -> t
  (** TODO *)

  val forward : network -> t -> t * t array array
  (** TODO *)

  val backward : network -> t -> t array array * t array array
  (** TODO *)

  val copy : network -> network
  (** TODO *)

  val model : network -> arr -> arr
  (** TODO *)


  (** {6 Create Neurons} *)

  val input : ?name:string -> int array -> node
  (** TODO *)

  val activation : ?name:string -> Activation.typ -> node -> node
  (** TODO *)

  val linear : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> node -> node
  (** TODO *)

  val linear_nobias : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> node -> node
  (** TODO *)

  val embedding : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> int -> node -> node
  (** TODO *)

  val recurrent : ?name:string -> ?init_typ:Init.typ -> act_typ:Activation.typ -> int -> int -> node -> node
  (** TODO *)

  val lstm : ?name:string -> ?init_typ:Init.typ -> int -> node -> node
  (** TODO *)

  val gru : ?name:string -> ?init_typ:Init.typ -> int -> node -> node
  (** TODO *)

  val conv1d : ?name:string -> ?padding:Owl_types.padding -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
  (** TODO *)

  val conv2d : ?name:string -> ?padding:Owl_types.padding -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
  (** TODO *)

  val conv3d : ?name:string -> ?padding:Owl_types.padding -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
  (** TODO *)

  val fully_connected : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> node -> node
  (** TODO *)

  val max_pool1d : ?name:string -> ?padding:Owl_types.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
  (** TODO *)

  val max_pool2d : ?name:string -> ?padding:Owl_types.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
  (** TODO *)

  val avg_pool1d : ?name:string -> ?padding:Owl_types.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
  (** TODO *)

  val avg_pool2d : ?name:string -> ?padding:Owl_types.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
  (** TODO *)

  val global_max_pool1d : ?name:string -> ?act_typ:Activation.typ -> node -> node
  (** TODO *)

  val global_max_pool2d : ?name:string -> ?act_typ:Activation.typ -> node -> node
  (** TODO *)

  val global_avg_pool1d : ?name:string -> ?act_typ:Activation.typ -> node -> node
  (** TODO *)

  val global_avg_pool2d : ?name:string -> ?act_typ:Activation.typ -> node -> node
  (** TODO *)

  val dropout : ?name:string -> float -> node -> node
  (** TODO *)

  val gaussian_noise : ?name:string -> float -> node -> node
  (** TODO *)

  val gaussian_dropout : ?name:string -> float -> node -> node
  (** TODO *)

  val alpha_dropout : ?name:string -> float -> node -> node
  (** TODO *)

  val normalisation : ?name:string -> ?axis:int -> ?training:bool -> ?decay:float -> ?mu:arr -> ?var:arr -> node -> node
  (** TODO *)

  val reshape : ?name:string -> int array -> node -> node
  (** TODO *)

  val flatten : ?name:string -> node -> node
  (** TODO *)

  val lambda : ?name:string -> ?act_typ:Activation.typ -> (t -> t) -> node -> node
  (** TODO *)

  val add : ?name:string -> ?act_typ:Activation.typ -> node array -> node
  (** TODO *)

  val mul : ?name:string -> ?act_typ:Activation.typ -> node array -> node
  (** TODO *)

  val dot : ?name:string -> ?act_typ:Activation.typ -> node array -> node
  (** TODO *)

  val max : ?name:string -> ?act_typ:Activation.typ -> node array -> node
  (** TODO *)

  val average : ?name:string -> ?act_typ:Activation.typ -> node array -> node
  (** TODO *)

  val concatenate : ?name:string -> ?act_typ:Activation.typ -> int -> node array -> node
  (** TODO *)


  (** {6 Helper functions} *)

  val to_string : network -> string
  (** TODO *)

  val pp_network : Format.formatter -> network -> unit
  (** TODO *)

  val print : network -> unit
  (** TODO *)

  val save : network -> string -> unit
  (** TODO *)

  val load : string -> network
  (** TODO *)

  val save_weights : network -> string -> unit
  (** TODO *)

  val load_weights : network -> string -> unit
  (** TODO *)


  (** {6 Train Networks} *)

  val train_generic : ?state:Checkpoint.state -> ?params:Params.typ -> ?init_model:bool -> network -> t -> t -> Checkpoint.state
  (** TODO *)

  val train : ?state:Checkpoint.state -> ?params:Params.typ -> ?init_model:bool -> network -> arr -> arr -> Checkpoint.state
  (** TODO *)


end


(* This is a dumb module for checking the module signature. *)

module Impl (A : Ndarray_Algodiff) : Sig = Owl_neural_graph.Make (A)
