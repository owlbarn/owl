(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Neural network: interface of parallel engine *)


open Owl_base_algodiff.S
open Owl_base_optimise.S


(* module signature of model parallel engine *)

module type KeyValueTypeSig = sig
  type key_t
  type value_t
end


module type EngineGenSig = functor (KeyValueTypeSpecifier : KeyValueTypeSig) -> sig
  type key_t = KeyValueTypeSpecifier.key_t
  type value_t = KeyValueTypeSpecifier.value_t
  type vars_t = (key_t * value_t) list

  type param_context
  type barrier = ASP | BSP | SSP | PSP

  (* functions of parameter server engine *)

  val start : ?barrier:barrier -> string -> string -> unit Lwt.t
  (** start running the model loop *)

  val register_barrier : (param_context ref -> int * (string list)) -> unit
  (** register user-defined barrier function at p2p server *)

  val register_schedule : (string list -> (string * (key_t * value_t) list) list Lwt.t) -> unit
  (** register user-defined scheduler *)

  val register_pull : ((key_t * value_t) list -> (key_t * value_t) Lwt.t list) -> unit
  (** register user-defined pull function executed at master *)

  val register_push : ((string -> (key_t * value_t) list -> (key_t * value_t) list)) -> unit
  (** register user-defined push function executed at worker *)

  val register_stop : (param_context ref -> bool) -> unit
  (** register stopping criterion function *)

  val get : key_t -> (value_t * int) Lwt.t
  (** given a key, get its value and timestamp *)

  val set : key_t -> value_t -> unit Lwt.t
  (** given a key, set its value at master *)

  val worker_num : unit -> int
  (** return the number of workders, only work at server side *)

end


(* module signature of neural network model *)

module type ModelSig = sig

  type network

  val mkpar : network -> t array array

  val init : network -> unit

  val update : network -> t array array -> unit

  val copy : network -> network

  val train_generic : ?state:Checkpoint.state -> ?params:Params.typ -> ?init_model:bool -> network -> t -> t -> Checkpoint.state

end


(* implementation of parallel neural network training *)

module Make (M : ModelSig) (EGEN : EngineGenSig) = struct

  module KeyValueTypeSpecifier = struct
    type key_t = int
    type value_t = M.network
  end

  module E = EGEN(KeyValueTypeSpecifier)

  type task = {
    mutable id     : int;
    mutable state  : Checkpoint.state option;
    mutable params : Params.typ;
    mutable model  : M.network;
    mutable data_x : t;
    mutable data_y : t;
  }


  let make_task id params model data_x data_y = {
    id;
    state = None;
    params;
    model;
    data_x;
    data_y;
  }


  (* calculate \delta model = model0 - model1, save the result in model0 *)
  let delta_model model0 model1 =
    let par0 = M.mkpar model0 in
    let par1 = M.mkpar model1 in
    let delta = Owl_utils.aarr_map2 (fun a0 a1 -> Maths.(a0 - a1)) par0 par1 in
    M.update model0 delta


  (* retrieve local model at parameter server, init if none *)
  let local_model task =
    try%lwt (let%lwt model, _ = E.get task.id in Lwt.return model)
    with Not_found -> (
      Owl_log.warn "set up first model";
      M.init task.model;
      E.set task.id task.model;%lwt
      (let%lwt model, _ = E.get task.id in Lwt.return model)
    )


  let schedule task workers =
    (* get model, if none then init locally *)
    let%lwt model = local_model task in
    let tasks = List.map (fun x ->
      (x, [(task.id, model)])
    ) workers
    in Lwt.return tasks


  let pull task vars =
    let n = E.worker_num () |> float_of_int in
    assert (n >= 1.); (* at least one worker *)
    (* there should be only one item in list *)
    List.map (fun (k, model1) ->
      let%lwt model0 = local_model task in
      let par0 = M.mkpar model0 in
      let par1 = M.mkpar model1 in
      Owl_utils.aarr_map2 (fun a0 a1 ->
        Maths.(a0 + a1)
      ) par0 par1
      |> M.update model0;
      task.model <- model0;
      E.set task.id task.model;%lwt
      Lwt.return (k, model0)
    ) vars


  let push task id vars =
    (* there should be only one item in list *)
    let updates = List.map (fun (k, model) ->
      task.model <- M.copy model;
      (* start local training *)
      let params = task.params in
      let x = task.data_x in
      let y = task.data_y in
      let state = match task.state with
        | Some state -> M.(train_generic ~state ~params ~init_model:false model x y)
        | None       -> M.(train_generic ~params ~init_model:false model x y)
      in
      Checkpoint.(state.stop <- false);
      task.state <- Some state;
      (* only send out delta model *)
      delta_model model task.model;
      (k, M.copy model) ) vars in
    updates


  (* FIXME: currently running forever *)
  let stop task context = false


  let train_generic ?params nn x y jid url =
    (* prepare params and make task *)
    let params = match params with
      | Some p -> p
      | None   -> Params.default ()
    in
    let id = Owl_base_stats.uniform_rvs 0. (float_of_int max_int) |> int_of_float in
    let task = make_task id params nn x y in
    (* register sched/push/pull/stop/barrier *)
    E.register_schedule (schedule task);
    E.register_pull (pull task);
    E.register_push (push task);
    E.register_stop (stop task);
    E.start ~barrier:E.ASP jid url


  let train ?params nn x y jid url = train_generic ?params nn (Arr x) (Arr y) jid url


end
