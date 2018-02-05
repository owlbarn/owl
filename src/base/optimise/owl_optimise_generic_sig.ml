(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module type Sig = sig

  include Owl_algodiff_generic_sig.Sig


  (** {6 Utils module} *)

  module Utils : sig

    val sample_num : t -> int
    (** TODO *)

    val draw_samples : t -> t -> int -> t * t
    (** TODO *)

    val get_chunk : t -> t -> int -> int -> t * t
    (** TODO *)

  end


  (** {6 Learning_Rate module} *)

  module Learning_Rate : sig

    type typ =
      | Adagrad of float
      | Const of float
      | Decay of float * float
      | Exp_decay of float * float
      | RMSprop of float * float
      | Schedule of float array
    (** types of learning rate *)

    val run : typ -> int -> 'a -> t -> t
    (** TODO *)

    val default : typ -> typ
    (** TODO *)
    val update_ch : typ -> t -> t -> t
    (** TODO *)
    val to_string : typ -> string
    (** TODO *)

  end


  (** {6 Batch module} *)

  module Batch : sig

    type typ = Full | Mini of int | Sample of int | Stochastic
    (** TODO *)

    val run : typ -> t -> t -> int -> t * t
    (** TODO *)

    val batches : typ -> t -> int
    (** TODO *)

    val to_string : typ -> string
    (** TODO *)

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
    (** TODO *)

    val run : typ -> t -> t -> t
    (** TODO *)

    val to_string : typ -> string
    (** TODO *)

  end


  (** {6 Gradient module} *)

  module Gradient : sig

    type typ = GD | CG | CD | NonlinearCG | DaiYuanCG | NewtonCG | Newton
    (** TODO *)

    val run : typ -> (t -> t) -> t -> t -> t -> t -> t
    (** TODO *)

    val to_string : typ -> string
    (** TODO *)

  end


  (** {6 Momentum module} *)

  module Momentum : sig

    type typ = Standard of float | Nesterov of float | None
    (** TODO *)

    val run : typ -> t -> t -> t
    (** TODO *)

    val default : typ -> typ
    (** TODO *)

    val to_string : typ -> string
    (** TODO *)

  end


  (** {6 Regularisation module} *)

  module Regularisation : sig

    type typ =
      | L1norm of float
      | L2norm of float
      | Elastic_net of float * float
      | None
    (** TODO *)

    val run : typ -> t -> t
    (** TODO *)

    val to_string : typ -> string
    (** TODO *)

  end


  (** {6 Clipping module} *)

  module Clipping : sig

    type typ = L2norm of float | Value of float * float | None
    (** TODO *)

    val run : typ -> t -> t
    (** TODO *)

    val default : typ -> typ
    (** TODO *)

    val to_string : typ -> string
    (** TODO *)

  end


  (** {6 Stopping module} *)

  module Stopping : sig

    type typ = Const of float | Early of int * int | None
    (** TODO *)

    val run : typ -> float -> bool
    (** TODO *)

    val default : typ -> typ
    (** TODO *)

    val to_string : typ -> string
    (** TODO *)

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
      mutable ch : t array array;
    }
    (** TODO *)

    type typ =
      | Batch of int
      | Epoch of float
      | Custom of (state -> unit)
      | None
    (** TODO *)

    val init_state : int -> float -> state
    (** TODO *)

    val default_checkpoint_fun : (string -> 'a) -> 'a
    (** TODO *)

    val print_state_info : state -> unit
    (** TODO *)

    val print_summary : state -> unit
    (** TODO *)

    val run : typ -> (string -> unit) -> int -> t -> state -> unit
    (** TODO *)

    val to_string : typ -> string
    (** TODO *)

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
    (** TODO *)

    val default : unit -> typ
    (** TODO *)

    val config : ?batch:Batch.typ -> ?gradient:Gradient.typ -> ?loss:Loss.typ -> ?learning_rate:Learning_Rate.typ -> ?regularisation:Regularisation.typ -> ?momentum:Momentum.typ -> ?clipping:Clipping.typ -> ?stopping:Stopping.typ -> ?checkpoint:Checkpoint.typ -> ?verbosity:bool -> float -> typ
    (** TODO *)

    val to_string : typ -> string
    (** TODO *)

  end


  (** {6 Core functions} *)

  val minimise_weight : ?state:Checkpoint.state -> Params.typ -> (t -> t -> t) -> t -> t -> t -> Checkpoint.state * t
  (** TODO *)

  val minimise_network : ?state:Checkpoint.state -> Params.typ -> (t -> t * t array array) -> (t -> t array array * t array array) -> (t array array -> 'a) -> (string -> unit) -> t -> t -> Checkpoint.state
  (** TODO *)

  val minimise_fun : ?state:Checkpoint.state -> Params.typ -> (t -> t) -> t -> Checkpoint.state * t
  (** TODO *)
  
end


(* This is a dumb module for checking the module signature. *)

module Impl (A : Ndarray_Algodiff) : Sig = Owl_optimise_generic.Make (A)
