(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module type Sig = sig

  include Owl_types_algodiff.Sig


module Init :
  sig
    type typ =
        Uniform of float * float
      | Gaussian of float * float
      | Standard
      | Tanh
      | GlorotNormal
      | GlorotUniform
      | LecunNormal
      | Custom of (int array -> t)
    val calc_fans : int array -> float * float
    val run : typ -> int array -> t -> t
    val to_string : typ -> string
    val to_name : unit -> string
  end
module Input :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : int array -> neuron_typ
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Activation :
  sig
    type typ =
        Elu
      | Relu
      | Sigmoid
      | HardSigmoid
      | Softmax
      | Softplus
      | Softsign
      | Tanh
      | Relu6
      | LeakyRelu of float
      | TRelu of float
      | Custom of (t -> t)
      | None
    type neuron_typ = {
      mutable activation : typ;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val run_activation : t -> typ -> t
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val activation_to_string : typ -> string
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Linear :
  sig
    type neuron_typ = {
      mutable w : t;
      mutable b : t;
      mutable init_typ : Init.typ;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : ?inputs:int -> int -> Init.typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module LinearNoBias :
  sig
    type neuron_typ = {
      mutable w : t;
      mutable init_typ : Init.typ;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : ?inputs:int -> int -> Init.typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Recurrent :
  sig
    type neuron_typ = {
      mutable whh : t;
      mutable wxh : t;
      mutable why : t;
      mutable bh : t;
      mutable by : t;
      mutable h : t;
      mutable hiddens : int;
      mutable act : Activation.typ;
      mutable init_typ : Init.typ;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create :
      ?time_steps:int ->
      ?inputs:int ->
      int -> int -> Activation.typ -> Init.typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module LSTM :
  sig
    type neuron_typ = {
      mutable wxi : t;
      mutable whi : t;
      mutable wxc : t;
      mutable whc : t;
      mutable wxf : t;
      mutable whf : t;
      mutable wxo : t;
      mutable who : t;
      mutable bi : t;
      mutable bc : t;
      mutable bf : t;
      mutable bo : t;
      mutable c : t;
      mutable h : t;
      mutable init_typ : Init.typ;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create :
      ?time_steps:int -> ?inputs:int -> int -> Init.typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module GRU :
  sig
    type neuron_typ = {
      mutable wxz : t;
      mutable whz : t;
      mutable wxr : t;
      mutable whr : t;
      mutable wxh : t;
      mutable whh : t;
      mutable bz : t;
      mutable br : t;
      mutable bh : t;
      mutable h : t;
      mutable init_typ : Init.typ;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create :
      ?time_steps:int -> ?inputs:int -> int -> Init.typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Conv1D :
  sig
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
    val create :
      ?inputs:int array ->
      Owl_types.padding ->
      int array -> int array -> Init.typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Conv2D :
  sig
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
    val create :
      ?inputs:int array ->
      Owl_types.padding ->
      int array -> int array -> Init.typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Conv3D :
  sig
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
    val create :
      ?inputs:int array ->
      Owl_types.padding ->
      int array -> int array -> Init.typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module FullyConnected :
  sig
    type neuron_typ = {
      mutable w : t;
      mutable b : t;
      mutable init_typ : Init.typ;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : ?inputs:int -> int -> Init.typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module MaxPool1D :
  sig
    type neuron_typ = {
      mutable padding : Owl_types.padding;
      mutable kernel : int array;
      mutable stride : int array;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create :
      Owl_types.padding -> int array -> int array -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module MaxPool2D :
  sig
    type neuron_typ = {
      mutable padding : Owl_types.padding;
      mutable kernel : int array;
      mutable stride : int array;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create :
      Owl_types.padding -> int array -> int array -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module AvgPool1D :
  sig
    type neuron_typ = {
      mutable padding : Owl_types.padding;
      mutable kernel : int array;
      mutable stride : int array;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create :
      Owl_types.padding -> int array -> int array -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module AvgPool2D :
  sig
    type neuron_typ = {
      mutable padding : Owl_types.padding;
      mutable kernel : int array;
      mutable stride : int array;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create :
      Owl_types.padding -> int array -> int array -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module GlobalMaxPool1D :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : unit -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : 'a -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module GlobalMaxPool2D :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : unit -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : 'a -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module GlobalAvgPool1D :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : unit -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : 'a -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module GlobalAvgPool2D :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : unit -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : 'a -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module UpSampling1D : sig  end
module UpSampling2D : sig  end
module UpSampling3D : sig  end
module Padding1D : sig  end
module Padding2D : sig  end
module Padding3D : sig  end
module Lambda :
  sig
    type neuron_typ = {
      mutable lambda : t -> t;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : (t -> t) -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Dropout :
  sig
    type neuron_typ = {
      mutable rate : float;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : float -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Reshape :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : ?inputs:int array -> int array -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Flatten :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : unit -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : 'a -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Add :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : unit -> neuron_typ
    val connect : int array array -> neuron_typ -> unit
    val copy : 'a -> neuron_typ
    val run : t array -> 'a -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Mul :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : unit -> neuron_typ
    val connect : int array array -> neuron_typ -> unit
    val copy : 'a -> neuron_typ
    val run : t array -> 'a -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Dot :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : unit -> neuron_typ
    val connect : int array array -> neuron_typ -> unit
    val copy : 'a -> neuron_typ
    val run : t array -> 'a -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Max :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : unit -> neuron_typ
    val connect : int array array -> neuron_typ -> unit
    val copy : 'a -> neuron_typ
    val run : t array -> 'a -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Average :
  sig
    type neuron_typ = {
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : unit -> neuron_typ
    val connect : int array array -> neuron_typ -> unit
    val copy : 'a -> neuron_typ
    val run : t array -> 'a -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Concatenate :
  sig
    type neuron_typ = {
      mutable axis : int;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : int -> neuron_typ
    val connect : int array array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t array -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Normalisation :
  sig
    type neuron_typ = {
      mutable axis : int;
      mutable beta : t;
      mutable gamma : t;
      mutable mu : t;
      mutable var : t;
      mutable decay : t;
      mutable training : bool;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create :
      ?training:bool ->
      ?decay:float -> ?mu:arr -> ?var:arr -> int -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module GaussianNoise :
  sig
    type neuron_typ = {
      mutable sigma : float;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : float -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module GaussianDropout :
  sig
    type neuron_typ = {
      mutable rate : float;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : float -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module AlphaDropout :
  sig
    type neuron_typ = {
      mutable rate : float;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : float -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Embedding :
  sig
    type neuron_typ = {
      mutable w : t;
      mutable init_typ : Init.typ;
      mutable in_dim : int;
      mutable in_shape : int array;
      mutable out_shape : int array;
    }
    val create : ?inputs:int -> int -> int -> Init.typ -> neuron_typ
    val connect : int array -> neuron_typ -> unit
    val init : neuron_typ -> unit
    val reset : neuron_typ -> unit
    val mktag : int -> neuron_typ -> unit
    val mkpar : neuron_typ -> t array
    val mkpri : neuron_typ -> t array
    val mkadj : neuron_typ -> t array
    val update : neuron_typ -> t array -> unit
    val copy : neuron_typ -> neuron_typ
    val run : t -> neuron_typ -> t
    val to_string : neuron_typ -> string
    val to_name : unit -> string
  end
module Masking : sig  end
type neuron =
    Input of Input.neuron_typ
  | Linear of Linear.neuron_typ
  | LinearNoBias of LinearNoBias.neuron_typ
  | Embedding of Embedding.neuron_typ
  | LSTM of LSTM.neuron_typ
  | GRU of GRU.neuron_typ
  | Recurrent of Recurrent.neuron_typ
  | Conv1D of Conv1D.neuron_typ
  | Conv2D of Conv2D.neuron_typ
  | Conv3D of Conv3D.neuron_typ
  | FullyConnected of FullyConnected.neuron_typ
  | MaxPool1D of MaxPool1D.neuron_typ
  | MaxPool2D of MaxPool2D.neuron_typ
  | AvgPool1D of AvgPool1D.neuron_typ
  | AvgPool2D of AvgPool2D.neuron_typ
  | GlobalMaxPool1D of GlobalMaxPool1D.neuron_typ
  | GlobalMaxPool2D of GlobalMaxPool2D.neuron_typ
  | GlobalAvgPool1D of GlobalAvgPool1D.neuron_typ
  | GlobalAvgPool2D of GlobalAvgPool2D.neuron_typ
  | Dropout of Dropout.neuron_typ
  | Reshape of Reshape.neuron_typ
  | Flatten of Flatten.neuron_typ
  | Lambda of Lambda.neuron_typ
  | Activation of Activation.neuron_typ
  | GaussianNoise of GaussianNoise.neuron_typ
  | GaussianDropout of GaussianDropout.neuron_typ
  | AlphaDropout of AlphaDropout.neuron_typ
  | Normalisation of Normalisation.neuron_typ
  | Add of Add.neuron_typ
  | Mul of Mul.neuron_typ
  | Dot of Dot.neuron_typ
  | Max of Max.neuron_typ
  | Average of Average.neuron_typ
  | Concatenate of Concatenate.neuron_typ
val get_in_out_shape : neuron -> int array * int array
val get_in_shape : neuron -> int array
val get_out_shape : neuron -> int array
val connect : int array array -> neuron -> unit
val init : neuron -> unit
val reset : neuron -> unit
val mktag : int -> neuron -> unit
val mkpar : neuron -> t array
val mkpri : neuron -> t array
val mkadj : neuron -> t array
val update : neuron -> t array -> unit
val copy : neuron -> neuron
val run : t array -> neuron -> t
val to_string : neuron -> string
val to_name : neuron -> string

end


(* This is a dumb module for checking the module signature. *)

module Impl (A : Ndarray_Algodiff) : Sig = Owl_neural_neuron.Make (A)
