(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  module Algodiff : Owl_algodiff_generic_sig2.Sig

  open Algodiff


  (** {6 Utils module} *)

  module Utils : sig

    val sample_num : t -> int
    (** Return the total number of samples in passed in ndarray. *)

    val draw_samples : t -> t -> int -> t * t
    (**
``draw_samples x y`` draws samples from both ``x`` (observations) and ``y``
(labels). The samples will be drew along axis 0, so ``x`` and ``y`` must agree
along axis 0.
     *)

    val get_chunk : t -> t -> int -> int -> t * t
    (**
``get_chunk x y i c`` gets a continuous chunk of ``c`` samples from position
``i`` from  ``x`` (observations) and ``y`` (labels).
     *)

  end


  (** {7 Learning_Rate module} *)

  module Learning_Rate : sig

    type typ =
      | Adagrad of float
      | Const of float
      | Decay of float * float
      | Exp_decay of float * float
      | RMSprop of float * float
      | Adam of float * float * float
      | Schedule of float array
    (** types of learning rate *)

    val run : typ -> int -> t -> t array -> t
    (** Execute the computations defined in module ``typ``. *)

    val default : typ -> typ
    (** Create module ``typ`` with default values. *)

    val update_ch : typ -> t -> t array -> t array
    (** Update the cache of gradients. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)

  end


  (** {6 Batch module} *)

  module Batch : sig

    type typ = Full | Mini of int | Sample of int | Stochastic
    (** Types of batches. *)

    val run : typ -> t -> t -> int -> t * t
    (** Execute the computations defined in module ``typ``. *)

    val batches : typ -> t -> int
    (** Return the total number of batches given a batch ``typ``. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)

  end


  (** {6 Loss module} *)

  module Loss : sig

    type typ =
      | Hinge
      | L1norm
      | L2norm
      | Quadratic
      | Cross_entropy
      | Custom of (t -> t -> t)
    (** Types of loss functions. *)

    val run : typ -> t -> t -> t
    (** Execute the computations defined in module ``typ``. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)

  end


  (** {6 Gradient module} *)

  module Gradient : sig

    type typ = GD | CG | CD | NonlinearCG | DaiYuanCG | NewtonCG | Newton
    (** Types of gradient function. *)

    val run : typ -> (t -> t) -> t -> t -> t -> t -> t
    (** Execute the computations defined in module ``typ``. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)

  end


  (** {6 Momentum module} *)

  module Momentum : sig

    type typ = Standard of float | Nesterov of float | None
    (** Types of momentum functions. *)

    val run : typ -> t -> t -> t
    (** Execute the computations defined in module ``typ``. *)

    val default : typ -> typ
    (** Create module ``typ`` with default values. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)

  end


  (** {6 Regularisation module} *)

  module Regularisation : sig

    type typ =
      | L1norm of float
      | L2norm of float
      | Elastic_net of float * float
      | None
    (** Types of regularisation functions. *)

    val run : typ -> t -> t
    (** Execute the computations defined in module ``typ``. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)

  end


  (** {6 Clipping module} *)

  module Clipping : sig

    type typ = L2norm of float | Value of float * float | None
    (** Types of clipping functions. *)

    val run : typ -> t -> t
    (** Execute the computations defined in module ``typ``. *)

    val default : typ -> typ
    (** Create module ``typ`` with default values. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)

  end


  (** {6 Stopping module} *)

  module Stopping : sig

    type typ = Const of float | Early of int * int | None
    (** Types of stopping functions. *)

    val run : typ -> float -> bool
    (** Execute the computations defined in module ``typ``. *)

    val default : typ -> typ
    (** Create module ``typ`` with default values. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)

  end


  (** {6 Checkpoint module} *)

  module Checkpoint : sig

    type state = {
      mutable current_batch : int;
      mutable batches_per_epoch : int;
      mutable epochs : float;
      mutable batches : int;
      mutable loss : t array;
      mutable start_at : float;
      mutable stop : bool;
      mutable gs : t array array;
      mutable ps : t array array;
      mutable us : t array array;
      mutable ch : t array array array;
    }
    (** Type definition of checkpoint *)

    type typ =
      | Batch of int
      | Epoch of float
      | Custom of (state -> unit)
      | None
    (** Batch type. *)

    val init_state : int -> float -> state
    (**
``init_state batches_per_epoch epochs`` initialises a state by specifying the
number of batches per epoch and the number of epochs in total.
     *)

    val default_checkpoint_fun : (string -> 'a) -> 'a
    (** This function is used for saving intermediate files during optimisation. *)

    val print_state_info : state -> unit
    (** Print out the detail information of current ``state``. *)

    val print_summary : state -> unit
    (** Print out the summary of current ``state``. *)

    val run : typ -> (string -> unit) -> int -> t -> state -> unit
    (** Execute the computations defined in module ``typ``. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)

  end


  (** {6 Params module} *)

  module Params : sig

    type typ = {
      mutable epochs : float;
      mutable batch : Batch.typ;
      mutable gradient : Gradient.typ;
      mutable loss : Loss.typ;
      mutable learning_rate : Learning_Rate.typ;
      mutable regularisation : Regularisation.typ;
      mutable momentum : Momentum.typ;
      mutable clipping : Clipping.typ;
      mutable stopping : Stopping.typ;
      mutable checkpoint : Checkpoint.typ;
      mutable verbosity : bool;
    }
    (** Type definition of paramater. *)

    val default : unit -> typ
    (** Create module ``typ`` with default values. *)

    val config : ?batch:Batch.typ -> ?gradient:Gradient.typ -> ?loss:Loss.typ -> ?learning_rate:Learning_Rate.typ -> ?regularisation:Regularisation.typ -> ?momentum:Momentum.typ -> ?clipping:Clipping.typ -> ?stopping:Stopping.typ -> ?checkpoint:Checkpoint.typ -> ?verbosity:bool -> float -> typ
    (** This function creates a parameter object with many configurations. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)

  end


  (** {6 Core functions} *)

  val minimise_weight : ?state:Checkpoint.state -> Params.typ -> (t -> t -> t) -> t -> t -> t -> Checkpoint.state * t
  (**
This function minimises the weight ``w`` of passed-in function ``f``.

* ``f`` is a function ``f : w -> x -> y``.
* ``w`` is a row vector but ``y`` can have any shape.
   *)

  val minimise_network : ?state:Checkpoint.state -> Params.typ -> (t -> t * t array array) -> (t -> t array array * t array array) -> (t array array -> 'a) -> (string -> unit) -> t -> t -> Checkpoint.state
  (**
This function is specifically designed for minimising the weights in a neural
network of graph structure. In Owl's earlier versions, the functions in the
regression module were actually implemented using this function.
   *)

  val minimise_fun : ?state:Checkpoint.state -> Params.typ -> (t -> t) -> t -> Checkpoint.state * t
  (**
This function minimises ``f : x -> y`` w.r.t ``x``.

``x`` is an ndarray; and ``y`` is an scalar value.
   *)

  val minimise_compiled_network : ?state:Checkpoint.state -> Params.typ -> (t -> t -> t) -> (unit -> 'a) -> (string -> unit) -> t -> t -> Checkpoint.state
  (** TODO *)


end
