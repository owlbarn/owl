(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module type Sig = sig

    include Owl_types_algodiff.Sig

    module Utils :
      sig
        val sample_num : t -> int
        val draw_samples : t -> t -> int -> t * t
        val get_chunk : t -> t -> int -> int -> t * t
      end
    module Learning_Rate :
      sig
        type typ =
            Adagrad of float
          | Const of float
          | Decay of float * float
          | Exp_decay of float * float
          | RMSprop of float * float
          | Schedule of float array
        val run : typ -> int -> 'a -> t -> t
        val default : typ -> typ
        val update_ch : typ -> t -> t -> t
        val to_string : typ -> string
      end
    module Batch :
      sig
        type typ = Full | Mini of int | Sample of int | Stochastic
        val run : typ -> t -> t -> int -> t * t
        val batches : typ -> t -> int
        val to_string : typ -> string
      end
    module Loss :
      sig
        type typ =
            Hinge
          | L1norm
          | L2norm
          | Quadratic
          | Cross_entropy
          | Custom of (t -> t -> t)
        val run : typ -> t -> t -> t
        val to_string : typ -> string
      end
    module Gradient :
      sig
        type typ = GD | CG | CD | NonlinearCG | DaiYuanCG | NewtonCG | Newton
        val run : typ -> (t -> t) -> t -> t -> t -> t -> t
        val to_string : typ -> string
      end
    module Momentum :
      sig
        type typ = Standard of float | Nesterov of float | None
        val run : typ -> t -> t -> t
        val default : typ -> typ
        val to_string : typ -> string
      end
    module Regularisation :
      sig
        type typ =
            L1norm of float
          | L2norm of float
          | Elastic_net of float * float
          | None
        val run : typ -> t -> t
        val to_string : typ -> string
      end
    module Clipping :
      sig
        type typ = L2norm of float | Value of float * float | None
        val run : typ -> t -> t
        val default : typ -> typ
        val to_string : typ -> string
      end
    module Stopping :
      sig
        type typ = Const of float | Early of int * int | None
        val run : typ -> float -> bool
        val default : typ -> typ
        val to_string : typ -> string
      end
    module Checkpoint :
      sig
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
        type typ =
            Batch of int
          | Epoch of float
          | Custom of (state -> unit)
          | None
        val init_state : int -> float -> state
        val default_checkpoint_fun : (string -> 'a) -> 'a
        val print_state_info : state -> unit
        val print_summary : state -> unit
        val run : typ -> (string -> unit) -> int -> t -> state -> unit
        val to_string : typ -> string
      end
    module Params :
      sig
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
        val default : unit -> typ
        val config :
          ?batch:Batch.typ ->
          ?gradient:Gradient.typ ->
          ?loss:Loss.typ ->
          ?learning_rate:Learning_Rate.typ ->
          ?regularisation:Regularisation.typ ->
          ?momentum:Momentum.typ ->
          ?clipping:Clipping.typ ->
          ?stopping:Stopping.typ ->
          ?checkpoint:Checkpoint.typ -> ?verbosity:bool -> float -> typ
        val to_string : typ -> string
      end
    val minimise_weight :
      ?state:Checkpoint.state ->
      Params.typ -> (t -> t -> t) -> t -> t -> t -> Checkpoint.state * t
    val minimise_network :
      ?state:Checkpoint.state ->
      Params.typ ->
      (t -> t * t array array) ->
      (t -> t array array * t array array) ->
      (t array array -> 'a) -> (string -> unit) -> t -> t -> Checkpoint.state
    val minimise_fun :
      ?state:Checkpoint.state ->
      Params.typ -> (t -> t) -> t -> Checkpoint.state * t
end


(* This is a dumb module for checking the module signature. *)

module Impl (A : Ndarray_Algodiff) : Sig = Owl_optimise_generic.Make (A)
