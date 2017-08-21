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
  mutable name    : string;     (* name of a node *)
  mutable prev    : node array; (* parents of a node *)
  mutable next    : node array; (* children of a node *)
  mutable neuron  : neuron;     (* neuron contained in a node *)
  mutable output  : t option;   (* output of a node *)
  mutable network : network;    (* network a node belongs to *)
  mutable train   : bool;       (* true if a node is only for training *)
}
and network = {
  mutable nnid : string;        (* name of the graph network *)
  mutable size : int;           (* size of the graph network *)
  mutable root : node option;   (* root of the graph network, i.e. input *)
  mutable topo : node array;    (* nodes sorted in topological order *)
}


(** {6 Various types of neural nodes} *)

val input : ?name:string -> int array -> node
(**
  [input shape] creates a [node] for input data.

  Arguments:
  - [shape]: shape of input data.
*)

val activation : ?name:string -> Activation.typ -> node -> node
(**
  [activation type node] applies an activation function [type] to [node].

  Arguments:
  - [type]: name of activation function to use.
*)

val linear : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> node -> node
(**
  [linear ?act_typ ?init_typ units node] adds a regular densely-connected NN
  node to [node].

  Arguments:
  - [units]: Positive integer, dimensionality of the output space.
  - [act_typ]: Activation function to use.
  - [init_typ]: Initialising method to set the initial weights.
*)

val linear_nobias : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> node -> node
(**
  Similar to [linear], but does not use the bias vector.
*)

val embedding : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> int -> node -> node
(**
  [embedding ?init_typ ?act_typ in_dim out_dim node] turns positive integers
  (indexes) from [node] into dense vectors of fixed size.

  Arguments:
  - [in_dim]: Size of the vocabulary
  - [out_dim]: Dimension of the dense embedding.
  - [init_typ]: Initialising method to set the initial weights.
  - [act_typ]: Activation function to use.
*)

val recurrent: ?name:string -> ?init_typ:Init.typ -> act_typ:Activation.typ -> int -> int -> node -> node
(** *)

val lstm : ?name:string -> ?init_typ:Init.typ -> int -> node -> node
(**
  [lstm ~init_typ units node] adds a LSTM node on previous [node].

  Arguments:
  - [units]: Dimensionality of the output space.
  - [init_typ]: Initialising method to set the initial weights.
*)

val gru : ?name:string -> ?init_typ:Init.typ -> int -> node -> node
(**
  [gru ~init_typ units node] adds a Gated Recurrent Unit node on previous [node].

  Arguments:
  - [units]: Dimensionality of the output space.
*)

val conv1d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
(**
  [conv1d ~padding ~init_typ ~act_typ kernels strides node] adds a 1D
  convolution node (e.g. temporal convolution) on previous [node].

  Arguments:
  - [kernel]: Integer array consists of [h, i, o]. [h] specifies the dimension
  of the 1D convolution window. [i] and [o] are the dimensionalities of the
  input and output space.
  - [stride]: Array of 1 integer, the stride length of the convolution.
  - [init_typ]: Initialising method to set the initial weights.
  - [padding]: Padding type on input.
  - [act_typ]: Activation function to use.
*)

val conv2d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
(**
  [conv2d ~padding ~init_typ ~act_typ kernels strides node] adds a 2D
  convolution node (e.g. spatial convolution over images) on previous [node].

  Arguments:
  - [kernel]: Array consists of [w, h, i, o]. [w] and [h] specify the width
    and height of the 2D convolution window. [i] and [o] are the dimensionality
    of the input and output space.
  - [stride]: Array of 2 integers, the stride length of the convolution.
  - [init_typ]: Initialising method to set the initial weights.
  - [padding]: Padding type on input.
  - [act_typ]: Activation function to use.
*)

val conv3d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
(**
  [conv3d ~padding ~init_typ ~act_typ kernels strides node] adds a 3D
  convolution node (e.g. spatial convolution over volumes) on previous [node].

  Arguments:
  - [kernel]: Array consists of [w, h, d, i, o]. [w], [h], and [d] specify
    the 3 dimensionality of the 3D convolution window. [i] and [o] are the
    dimensionality of the input and output space.
  - [stride]: Array of 3 integers, the stride length of the convolution.
  - [init_typ]: Initialising method to set the initial weights.
  - [padding]: Padding type on input.
  - [act_typ]: Activation function to use.
*)

val max_pool1d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
(**
  [max_pool1d ~padding ~act_typ pool_size strides node] adds a max pooling
  operation for temporal data to [node].

  Arguments:
  - [pool_size]: Array of one integer, size of the max pooling windows.
  - [strides]: Array of one integer, factor by which to downscale.
  - [padding]: Padding type on input.
  - [act_typ]: Activation function to use.
*)

val max_pool2d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
(**
  [max_pool2d ~padding ~act_typ pool_size strides node] adds a max pooling
  operation for spatial data to [node].

  Arguments:
  - [pool_size]: Array of 2 integers, size of the max pooling windows.
  - [strides]: Array of 2 integers, factor by which to downscale.
  - [padding]: Padding type on input.
  - [act_typ]: Activation function to use.
*)

val avg_pool1d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
(**
  [avg_pool1d ~padding ~act_typ pool_size strides node] adds an average pooling
  operation for temporal data to [node].

  Arguments:
  - [pool_size]: Array of one integer, size of the max pooling windows.
  - [strides]: Array of one integer, factor by which to downscale.
  - [padding]: Padding type on input.
  - [act_typ]: Activation function to use.
*)

val avg_pool2d : ?name:string -> ?padding:Owl_dense_ndarray_generic.padding -> ?act_typ:Activation.typ -> int array -> int array -> node -> node
(**
  [avg_pool2d ~padding ~act_typ pool_size strides node] adds an average pooling
  operation for spatial data to [node].

  Arguments:
  - [pool_size]: Array of 2 integers, size of the max pooling windows.
  - [strides]: Array of 2 integers, factor by which to downscale.
  - [padding]: Padding type on input.
  - [act_typ]: Activation function to use.
*)

val global_max_pool1d : ?name:string -> ?act_typ:Activation.typ -> node -> node
(**
  [global_max_pool1d ~act_typ node] adds global max pooling operation for temporal data on [node].

  Arguments:
  - [act_typ]: Activation function to use.
*)

val global_max_pool2d : ?name:string -> ?act_typ:Activation.typ -> node -> node
(**
  [global_max_poo2d ~act_typ] adds global max pooling operation for spatial data on [node].

  Arguments:
  - [act_typ]: Activation function to use.
*)

val global_avg_pool1d : ?name:string -> ?act_typ:Activation.typ -> node -> node
(**
  [global_avg_pool1d ~act_typ] adds global average pooling operation for temporal data on [node].

  Arguments:
  - [act_typ]: Activation function to use.
*)

val global_avg_pool2d : ?name:string -> ?act_typ:Activation.typ -> node -> node
(**
  [global_avg_poo2d ~act_typ] adds global average pooling operation for spatial data on [node].

  Arguments:
  - [act_typ]: Activation function to use.
*)

val fully_connected : ?name:string -> ?init_typ:Init.typ -> ?act_typ:Activation.typ -> int -> node -> node
(**
  [fully_connected ~init_typ ~act_typ outputs node] adds a fully connected node to [node].

  Arguments:
  - [outputs]: integer, the number of output units in the node
  - [init_typ]: Initialising method to set the initial weights.
  - [act_typ]: Activation function to use.
*)

val dropout : ?name:string -> float -> node -> node
(**
  [dropout rate node] applies Dropout to the input [node] to prevent
  overfitting.

  Arguments:
  - [rate]: Fraction of the input units to drop. Between 0 and 1.
*)

val gaussian_noise : ?name:string -> float -> node -> node
(**
  [gaussian_noise stddev node] applies additive zero-centered Gaussian noise to
  [node].

  Arguments:
  - [stddev]: Standard deviation of the noise distribution.
*)

val gaussian_dropout : ?name:string -> float -> node -> node
(**
  [gaussian_dropout rate node] applies multiplicative 1-centered Gaussian noise
  to input [node]. Only active at training time.

  Arguments:
  - [rates]: Drop probability.
*)

val alpha_dropout : ?name:string -> float -> node -> node
(**
  [alpha_dropout rate node] applies Alpha Dropout to the input [node].
  Only active at training time.

  Arguments:
  - [rates]: Drop probability.
*)

val normalisation : ?name:string -> ?axis:int -> node -> node
(**
  [normalisation axis node] normalises the activations of the previous node at
  each batch.

  Arguments:
  - [axis]:  Integer, the axis that should be normalised (typically the features
    axis). Default value is 0.
*)

val reshape : ?name:string -> ?convert:bool -> int array -> node -> node
(**
  [reshape target_shape node] reshapes an output to a certain shape.

  Arguments:
  - [target_shape]: target shape. Array of integers. Does not include the batch
    axis.
*)

val flatten : ?name:string -> ?convert:bool -> node -> node
(**
  [flatten node] flattens the input. Does not affect the batch size.
*)

val lambda : ?name:string -> ?act_typ:Activation.typ -> (t -> t) -> node -> node
(**
  [lambda func node] wraps arbitrary expression as a Node object.

  Arguments:
  - [func]: The function to be evaluated. Takes input tensor as first argument.
*)

val add : ?name:string -> ?act_typ:Activation.typ -> node array -> node
(**
  Node that adds a list of inputs.

  It takes as input an array of nodes, all of the same shape, and returns a
  single node (also of the same shape).
*)

val mul : ?name:string -> ?act_typ:Activation.typ -> node array -> node
(**
  Node that multiplies (element-wise) a list of inputs.

  It takes as input an array of nodes, all of the same shape, and returns a
  single node (also of the same shape).
*)

val dot : ?name:string -> ?act_typ:Activation.typ -> node array -> node
(**
  Node that computes a dot product between samples in two nodes.
*)

val max : ?name:string -> ?act_typ:Activation.typ -> node array -> node
(**
  Node that computes the maximum (element-wise) a list of inputs.
*)

val average : ?name:string -> ?act_typ:Activation.typ -> node array -> node
(**
  Node that averages a list of inputs.

  It takes as input an array of nodes, all of the same shape, and returns a
  single node (also of the same shape).
*)

val concatenate : ?name:string -> ?act_typ:Activation.typ -> int -> node array -> node
(**
  [concatenate axis nodes] concatenates a array of [nodes] and return as a
  single node.

  Arguments:
  - [axis]: Axis along which to concatenate.
*)


(** {6 Training and inference functions} *)

val train : ?params:Params.typ -> ?init_model:bool -> network -> mat -> mat -> float array

val train_cnn : ?params:Params.typ -> ?init_model:bool -> network -> arr -> mat -> float array

val train_generic : ?params:Params.typ -> ?init_model:bool -> network -> t -> t -> float array

val run : t -> network -> t

val model : network -> (mat -> mat)

val model_cnn : network -> (arr -> mat)


(** {6 Manipuate network structure} *)

val make_network : ?nnid:string -> int -> node option -> node array -> network

val make_node : ?name:string -> ?train:bool -> node array -> node array -> neuron -> t option -> network -> node

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
