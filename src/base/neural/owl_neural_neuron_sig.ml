(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  module Optimise : Owl_optimise_generic_sig.Sig

  open Optimise.Algodiff


  (** {6 Init neuron} *)

module Init : sig

  type typ =
    | Uniform       of float * float
    | Gaussian      of float * float
    | Standard
    | Tanh
    | GlorotNormal
    | GlorotUniform
    | LecunNormal
    | Custom        of (int array -> t)
  (** Initialisation types *)


  val calc_fans : int array -> float * float
  (** Calculate fan-in and fan-out of weights. *)

  val run : typ -> int array -> t -> t
  (** Execute the computation in this neuron. *)

  val to_string : typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Input neuron} *)

module Input : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : int array -> neuron_typ
  (** Create the neuron. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Activation neuron} *)

module Activation : sig

  type typ =
    | Elu
    | Relu
    | Sigmoid
    | HardSigmoid
    | Softmax of int
    | Softplus
    | Softsign
    | Tanh
    | Relu6
    | LeakyRelu of float
    | TRelu of float
    | Custom of (t -> t)
    | None
    (** Types of activation functions. *)

  type neuron_typ = {
    mutable activation : typ;
    mutable in_shape   : int array;
    mutable out_shape  : int array;
  }
  (** Neuron type definition. *)

  val create : typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val run_activation : t -> typ -> t
  (** Run one specific activation function. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val activation_to_string : typ -> string
  (** Return the name of a specific activation function. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Linear neuron} *)

module Linear : sig

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int -> int -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 LinearNoBias neuron} *)

module LinearNoBias : sig

  type neuron_typ = {
    mutable w         : t;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int -> int -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Recurrent neuron} *)

module Recurrent : sig

  type neuron_typ = {
    mutable whh       : t;
    mutable wxh       : t;
    mutable why       : t;
    mutable bh        : t;
    mutable by        : t;
    mutable h         : t;
    mutable hiddens   : int;
    mutable act       : Activation.typ;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?time_steps:int -> ?inputs:int -> int -> int -> Activation.typ -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 LSTM neuron} *)

module LSTM : sig

  type neuron_typ = {
    mutable wxi       : t;
    mutable whi       : t;
    mutable wxc       : t;
    mutable whc       : t;
    mutable wxf       : t;
    mutable whf       : t;
    mutable wxo       : t;
    mutable who       : t;
    mutable bi        : t;
    mutable bc        : t;
    mutable bf        : t;
    mutable bo        : t;
    mutable c         : t;
    mutable h         : t;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?time_steps:int -> ?inputs:int -> int -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 GRU neuron} *)

module GRU : sig

  type neuron_typ = {
    mutable wxz       : t;
    mutable whz       : t;
    mutable wxr       : t;
    mutable whr       : t;
    mutable wxh       : t;
    mutable whh       : t;
    mutable bz        : t;
    mutable br        : t;
    mutable bh        : t;
    mutable h         : t;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?time_steps:int -> ?inputs:int -> int -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Conv1D neuron} *)

module Conv1D : sig

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable padding   : Owl_types.padding;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int array -> Owl_types.padding -> int array -> int array -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Conv2D neuron} *)

module Conv2D : sig

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable padding   : Owl_types.padding;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int array -> Owl_types.padding -> int array -> int array -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Conv3D neuron} *)

module Conv3D : sig

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable padding   : Owl_types.padding;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int array -> Owl_types.padding -> int array -> int array -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 DilatedConv1D neuron} *)

module DilatedConv1D : sig

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable rate      : int array;
    mutable padding   : Owl_types.padding;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int array -> Owl_types.padding -> int array -> int array -> int array -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


(** {6 DilatedConv2D neuron} *)

module DilatedConv2D : sig

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable rate      : int array;
    mutable padding   : Owl_types.padding;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int array -> Owl_types.padding -> int array -> int array -> int array -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


(** {6 DilatedConv3D neuron} *)

module DilatedConv3D : sig

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable rate      : int array;
    mutable padding   : Owl_types.padding;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int array -> Owl_types.padding -> int array -> int array -> int array -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 TransposeConv1D neuron} *)

module TransposeConv1D : sig

  type neuron_typ = {
    mutable w : t;
    mutable b : t;
    mutable kernel : int array;
    mutable stride : int array;
    mutable padding : Owl_types.padding;
    mutable init_typ : Init.typ;
    mutable in_shape : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int array -> Owl_types.padding -> int array -> int array -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 TransposeConv2D neuron} *)

module TransposeConv2D : sig

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable padding   : Owl_types.padding;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int array -> Owl_types.padding -> int array -> int array -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 TransposeConv3D neuron} *)

module TransposeConv3D : sig

  type neuron_typ = {
    mutable w : t;
    mutable b : t;
    mutable kernel : int array;
    mutable stride : int array;
    mutable padding : Owl_types.padding;
    mutable init_typ : Init.typ;
    mutable in_shape : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int array -> Owl_types.padding -> int array -> int array -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 FullyConnected neuron} *)

module FullyConnected : sig

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int -> int -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 MaxPool1D neuron} *)

module MaxPool1D : sig

  type neuron_typ = {
    mutable padding   : Owl_types.padding;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : Owl_types.padding -> int array -> int array -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 MaxPool2D neuron} *)

module MaxPool2D : sig

  type neuron_typ = {
    mutable padding   : Owl_types.padding;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : Owl_types.padding -> int array -> int array -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 AvgPool1D neuron} *)

module AvgPool1D : sig

  type neuron_typ = {
    mutable padding   : Owl_types.padding;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : Owl_types.padding -> int array -> int array -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 AvgPool2D neuron} *)

module AvgPool2D : sig

  type neuron_typ = {
    mutable padding   : Owl_types.padding;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : Owl_types.padding -> int array -> int array -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 GlobalMaxPool1D neuron} *)

module GlobalMaxPool1D : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : unit -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : 'a -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 GlobalMaxPool2D neuron} *)

module GlobalMaxPool2D : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : unit -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : 'a -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 GlobalAvgPool1D neuron} *)

module GlobalAvgPool1D : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : unit -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : 'a -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 GlobalAvgPool2D neuron} *)

module GlobalAvgPool2D : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : unit -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : 'a -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 UpSampling1D neuron} *)

module UpSampling1D : sig  end


  (** {6 UpSampling2D neuron} *)

module UpSampling2D : sig

  type neuron_typ = {
    mutable size      : int array;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : int array -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 UpSampling3D neuron} *)

module UpSampling3D : sig  end


  (** {6 Padding1D neuron} *)

module Padding1D : sig  end


  (** {6 Padding2D neuron} *)

module Padding2D : sig  end


  (** {6 Padding3D neuron} *)

module Padding3D : sig  end


  (** {6 Lambda neuron} *)

module Lambda : sig

  type neuron_typ = {
    mutable lambda    : t -> t;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : (t -> t) -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Dropout neuron} *)

module Dropout : sig

  type neuron_typ = {
    mutable rate      : float;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : float -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Reshape neuron} *)

module Reshape : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int array -> int array -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Flatten neuron} *)

module Flatten : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : unit -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : 'a -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Add neuron} *)

module Add : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : unit -> neuron_typ
  (** Create the neuron. *)

  val connect : int array array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : 'a -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t array -> 'a -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Mul neuron} *)

module Mul : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : unit -> neuron_typ
  (** Create the neuron. *)

  val connect : int array array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : 'a -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t array -> 'a -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Dot neuron} *)

module Dot : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : unit -> neuron_typ
  (** Create the neuron. *)

  val connect : int array array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : 'a -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t array -> 'a -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Max neuron} *)

module Max : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : unit -> neuron_typ
  (** Create the neuron. *)

  val connect : int array array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : 'a -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t array -> 'a -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Average neuron} *)

module Average : sig

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : unit -> neuron_typ
  (** Create the neuron. *)

  val connect : int array array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : 'a -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t array -> 'a -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Concatenate neuron} *)

module Concatenate : sig

  type neuron_typ = {
    mutable axis      : int;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : int -> neuron_typ
  (** Create the neuron. *)

  val connect : int array array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t array -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Normalisation neuron} *)

module Normalisation : sig

  type neuron_typ = {
    mutable axis      : int;
    mutable beta      : t;
    mutable gamma     : t;
    mutable mu        : t;
    mutable var       : t;
    mutable decay     : t;
    mutable training  : bool;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?training:bool -> ?decay:float -> ?mu:A.arr -> ?var:A.arr -> int -> neuron_typ
  (** Create the neuron. Note that axis 0 is the batch axis. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 GaussianNoise neuron} *)

module GaussianNoise : sig

  type neuron_typ = {
    mutable sigma     : float;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : float -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 GaussianDropout neuron} *)

module GaussianDropout : sig

  type neuron_typ = {
    mutable rate      : float;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : float -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 AlphaDropout neuron} *)

module AlphaDropout : sig

  type neuron_typ = {
    mutable rate      : float;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : float -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Embedding neuron} *)

module Embedding : sig

  type neuron_typ = {
    mutable w         : t;
    mutable init_typ  : Init.typ;
    mutable in_dim    : int;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }
  (** Neuron type definition. *)

  val create : ?inputs:int -> int -> int -> Init.typ -> neuron_typ
  (** Create the neuron. *)

  val connect : int array -> neuron_typ -> unit
  (** Connect this neuron to others in a neural network. *)

  val init : neuron_typ -> unit
  (** Initialise the neuron and its parameters. *)

  val reset : neuron_typ -> unit
  (** Reset the parameters in a neuron. *)

  val mktag : int -> neuron_typ -> unit
  (** Tag the neuron, used by ``Algodiff`` module. *)

  val mkpar : neuron_typ -> t array
  (** Assemble all the parameters in an array, used by ``Optimise`` module. *)

  val mkpri : neuron_typ -> t array
  (** Assemble all the primial values in an array, used by ``Optimise`` module. *)

  val mkadj : neuron_typ -> t array
  (** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

  val update : neuron_typ -> t array -> unit
  (** Update parameters in a neuron, used by ``Optimise`` module. *)

  val copy : neuron_typ -> neuron_typ
  (** Make a deep copy of the neuron and its parameters. *)

  val run : t -> neuron_typ -> t
  (** Execute the computation in this neuron. *)

  val to_string : neuron_typ -> string
  (** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

  val to_name : unit -> string
  (** Return the name of the neuron. *)

end


  (** {6 Masking neuron} *)

module Masking : sig  end


  (** {6 Core functions} *)

type neuron =
  | Input           of Input.neuron_typ
  | Linear          of Linear.neuron_typ
  | LinearNoBias    of LinearNoBias.neuron_typ
  | Embedding       of Embedding.neuron_typ
  | LSTM            of LSTM.neuron_typ
  | GRU             of GRU.neuron_typ
  | Recurrent       of Recurrent.neuron_typ
  | Conv1D          of Conv1D.neuron_typ
  | Conv2D          of Conv2D.neuron_typ
  | Conv3D          of Conv3D.neuron_typ
  | DilatedConv1D   of DilatedConv1D.neuron_typ
  | DilatedConv2D   of DilatedConv2D.neuron_typ
  | DilatedConv3D   of DilatedConv3D.neuron_typ
  | TransposeConv1D of TransposeConv1D.neuron_typ
  | TransposeConv2D of TransposeConv2D.neuron_typ
  | TransposeConv3D of TransposeConv3D.neuron_typ
  | FullyConnected  of FullyConnected.neuron_typ
  | MaxPool1D       of MaxPool1D.neuron_typ
  | MaxPool2D       of MaxPool2D.neuron_typ
  | AvgPool1D       of AvgPool1D.neuron_typ
  | AvgPool2D       of AvgPool2D.neuron_typ
  | GlobalMaxPool1D of GlobalMaxPool1D.neuron_typ
  | GlobalMaxPool2D of GlobalMaxPool2D.neuron_typ
  | GlobalAvgPool1D of GlobalAvgPool1D.neuron_typ
  | GlobalAvgPool2D of GlobalAvgPool2D.neuron_typ
  | UpSampling2D    of UpSampling2D.neuron_typ
  | Dropout         of Dropout.neuron_typ
  | Reshape         of Reshape.neuron_typ
  | Flatten         of Flatten.neuron_typ
  | Lambda          of Lambda.neuron_typ
  | Activation      of Activation.neuron_typ
  | GaussianNoise   of GaussianNoise.neuron_typ
  | GaussianDropout of GaussianDropout.neuron_typ
  | AlphaDropout    of AlphaDropout.neuron_typ
  | Normalisation   of Normalisation.neuron_typ
  | Add             of Add.neuron_typ
  | Mul             of Mul.neuron_typ
  | Dot             of Dot.neuron_typ
  | Max             of Max.neuron_typ
  | Average         of Average.neuron_typ
  | Concatenate     of Concatenate.neuron_typ
(** Types of neuron. *)

val get_in_out_shape : neuron -> int array * int array
(** Get both input and output shapes of a neuron. *)

val get_in_shape : neuron -> int array
(** Get the input shape of a neuron. *)

val get_out_shape : neuron -> int array
(** Get the output shape of a neuron. *)

val connect : int array array -> neuron -> unit
(** Connect this neuron to others in a neural network. *)

val init : neuron -> unit
(** Initialise the neuron and its parameters. *)

val reset : neuron -> unit
(** Reset the parameters in a neuron. *)

val mktag : int -> neuron -> unit
(** Tag the neuron, used by ``Algodiff`` module. *)

val mkpar : neuron -> t array
(** Assemble all the parameters in an array, used by ``Optimise`` module. *)

val mkpri : neuron -> t array
(** Assemble all the primial values in an array, used by ``Optimise`` module. *)

val mkadj : neuron -> t array
(** Assemble all the adjacent values in an array, used by ``Optimise`` module. *)

val update : neuron -> t array -> unit
(** Update parameters in a neuron, used by ``Optimise`` module. *)

val copy : neuron -> neuron
(** Make a deep copy of the neuron and its parameters. *)

val run : t array -> neuron -> t
(** Execute the computation in this neuron. *)

val to_string : neuron -> string
(** Convert the neuron to its string representation. The string is often a summary of the parameters defined in the neuron. *)

val to_name : neuron -> string
(** Return the name of the neuron. *)


end
