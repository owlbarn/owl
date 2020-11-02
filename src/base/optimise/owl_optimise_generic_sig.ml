(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module type Sig = sig
  module Algodiff : Owl_algodiff_generic_sig.Sig

  open Algodiff

  (** Utils module *)
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

  (** Strategies for learning rate update *)
  module Learning_Rate : sig
    (** Representation of learning rate update strategies. Possible values include:
        - ``Adam (alpha, beta1, beta2)``, see {{: https://arxiv.org/abs/1412.6980 }ref} for parameter meaning
    *)
    type typ =
      | Adagrad   of float
      | Const     of float
      | Decay     of float * float
      | Exp_decay of float * float
      | RMSprop   of float * float
      | Adam      of float * float * float
      | Schedule  of float array

    val run : typ -> int -> t -> t array -> t
    (** Execute the computations defined in module ``typ``. *)

    val default : typ -> typ
    (** Create module ``typ`` with default values. *)

    val update_ch : typ -> t -> t array -> t array
    (** Update the cache of gradients. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)
  end

  (** Batch module *)
  module Batch : sig
    (** Types of batches. *)
    type typ =
      | Full
      | Mini       of int
      | Sample     of int
      | Stochastic

    val run : typ -> t -> t -> int -> t * t
    (** Execute the computations defined in module ``typ``. *)

    val batches : typ -> t -> int
    (** Return the total number of batches given a batch ``typ``. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)
  end

  (** Loss module *)
  module Loss : sig
    (** Types of loss functions. *)
    type typ =
      | Hinge
      | L1norm
      | L2norm
      | Quadratic
      | Cross_entropy
      | Custom        of (t -> t -> t)

    val run : typ -> t -> t -> t
    (** Execute the computations defined in module ``typ``. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)
  end

  (** Gradient module *)
  module Gradient : sig
    (** Types of gradient function. *)
    type typ =
      | GD
      | CG
      | CD
      | NonlinearCG
      | DaiYuanCG
      | NewtonCG
      | Newton

    val run : typ -> (t -> t) -> t -> t -> t -> t -> t
    (** Execute the computations defined in module ``typ``. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)
  end

  (** Momentum module *)
  module Momentum : sig
    (** Types of momentum functions. *)
    type typ =
      | Standard of float
      | Nesterov of float
      | None

    val run : typ -> t -> t -> t
    (** Execute the computations defined in module ``typ``. *)

    val default : typ -> typ
    (** Create module ``typ`` with default values. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)
  end

  (** Regularisation module *)
  module Regularisation : sig
    (** Types of regularisation functions. *)
    type typ =
      | L1norm      of float
      | L2norm      of float
      | Elastic_net of float * float
      | None

    val run : typ -> t -> t
    (** Execute the computations defined in module ``typ``. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)
  end

  (** Clipping module *)
  module Clipping : sig
    (** Types of clipping functions. *)
    type typ =
      | L2norm of float
      | Value  of float * float
      | None

    val run : typ -> t -> t
    (** Execute the computations defined in module ``typ``. *)

    val default : typ -> typ
    (** Create module ``typ`` with default values. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)
  end

  (** Stopping module *)
  module Stopping : sig
    (** Types of stopping functions. *)
    type typ =
      | Const of float
      | Early of int * int
      | None

    val run : typ -> float -> bool
    (** Execute the computations defined in module ``typ``. *)

    val default : typ -> typ
    (** Create module ``typ`` with default values. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)
  end

  (** Checkpoint module *)
  module Checkpoint : sig
    type state =
      { mutable current_batch : int
      ; mutable batches_per_epoch : int
      ; mutable epochs : float
      ; mutable batches : int
      ; mutable loss : t array
      ; mutable start_at : float
      ; mutable stop : bool
      ; mutable gs : t array array
      ; mutable ps : t array array
      ; mutable us : t array array
      ; mutable ch : t array array array
      }
    (** Type definition of checkpoint *)

    (** Batch type. *)
    type typ =
      | Batch  of int
      | Epoch  of float
      | Custom of (state -> unit)
      | None

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

  (** Params module *)
  module Params : sig
    type typ =
      { mutable epochs : float
      ; mutable batch : Batch.typ
      ; mutable gradient : Gradient.typ
      ; mutable loss : Loss.typ
      ; mutable learning_rate : Learning_Rate.typ
      ; mutable regularisation : Regularisation.typ
      ; mutable momentum : Momentum.typ
      ; mutable clipping : Clipping.typ
      ; mutable stopping : Stopping.typ
      ; mutable checkpoint : Checkpoint.typ
      ; mutable verbosity : bool
      }
    (** Type definition of parameter. *)

    val default : unit -> typ
    (** Create module ``typ`` with default values. *)

    val config
      :  ?batch:Batch.typ
      -> ?gradient:Gradient.typ
      -> ?loss:Loss.typ
      -> ?learning_rate:Learning_Rate.typ
      -> ?regularisation:Regularisation.typ
      -> ?momentum:Momentum.typ
      -> ?clipping:Clipping.typ
      -> ?stopping:Stopping.typ
      -> ?checkpoint:Checkpoint.typ
      -> ?verbosity:bool
      -> float
      -> typ
    (** This function creates a parameter object with many configurations. *)

    val to_string : typ -> string
    (** Convert the module ``typ`` to its string representation. *)
  end

  (** {4 Core functions} *)

  val minimise_weight
    :  ?state:Checkpoint.state
    -> Params.typ
    -> (t -> t -> t)
    -> t
    -> t
    -> t
    -> Checkpoint.state * t
  (**
     This function minimises the weight ``w`` of passed-in function ``f``.

   * ``f`` is a function ``f : w -> x -> y``.
   * ``w`` is a row vector but ``y`` can have any shape.
  *)

  val minimise_network
    :  ?state:Checkpoint.state
    -> Params.typ
    -> (t -> t * t array array)
    -> (t -> t array array * t array array)
    -> (t array array -> unit)
    -> (string -> unit)
    -> t
    -> t
    -> Checkpoint.state
  (**
     This function is specifically designed for minimising the weights in a neural
     network of graph structure. In Owl's earlier versions, the functions in the
     regression module were actually implemented using this function.
  *)

  val minimise_fun
    :  ?state:Checkpoint.state
    -> Params.typ
    -> (t -> t)
    -> t
    -> Checkpoint.state * t
  (**
     This function minimises ``f : x -> y`` w.r.t ``x``.

     ``x`` is an ndarray; and ``y`` is an scalar value.
  *)

  val minimise_compiled_network
    :  ?state:Checkpoint.state
    -> Params.typ
    -> (t -> t -> t)
    -> (unit -> unit)
    -> (string -> unit)
    -> t
    -> t
    -> Checkpoint.state
  (** TODO *)
end
