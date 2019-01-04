(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Neural network: interface of parallel engine *)


open Owl_algodiff.S
open Owl_optimise.S


(* module signature of model parallel engine *)

module type EngineSig = sig

  type param_context
  type barrier = ASP | BSP | SSP | PSP

  (* functions of parameter server engine *)

  val get : 'a -> 'b * int

  val set : 'a -> 'b -> unit

  val worker_num : unit -> int

  val start : ?barrier:barrier -> string -> string -> unit

  val register_barrier : (param_context ref -> int * (string list)) -> unit

  val register_schedule : ('a list -> ('a * ('b * 'c) list) list) -> unit

  val register_pull : (('a * 'b) list -> ('a * 'c) list) -> unit

  val register_push : ('a -> ('b * 'c) list -> ('b * 'c) list) -> unit

  val register_stop : (param_context ref -> bool) -> unit

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

module Make (M : ModelSig) (E : EngineSig) = struct

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
    try E.get task.id |> fst
    with Not_found -> (
      Owl_log.warn "set up first model";
      M.init task.model;
      E.set task.id task.model;
      E.get task.id |> fst;
    )


  let schedule task workers =
    (* get model, if none then init locally *)
    let model = local_model task in
    let tasks = List.map (fun x ->
      (x, [(task.id, model)])
    ) workers
    in tasks


  let pull task vars =
    let n = E.worker_num () |> float_of_int in
    assert (n >= 1.); (* at least one worker *)
    (* there should be only one item in list *)
    List.map (fun (k, model1) ->
      let model0 = local_model task in
      let par0 = M.mkpar model0 in
      let par1 = M.mkpar model1 in
      Owl_utils.aarr_map2 (fun a0 a1 ->
        Maths.(a0 + a1)
      ) par0 par1
      |> M.update model0;
      task.model <- model0;
      E.set task.id task.model;
      (k, model0)
    ) vars


  let push task _id vars =
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
  let stop _task _context = false


  let train_generic ?params nn x y jid url =
    (* prepare params and make task *)
    let params = match params with
      | Some p -> p
      | None   -> Params.default ()
    in
    let id = Owl_stats.uniform_int_rvs ~a:0 ~b:max_int in
    let task = make_task id params nn x y in
    (* register sched/push/pull/stop/barrier *)
    E.register_schedule (schedule task);
    E.register_pull (pull task);
    E.register_push (push task);
    E.register_stop (stop task);
    E.start ~barrier:E.ASP jid url


  let train ?params nn x y jid url = train_generic ?params nn (Arr x) (Arr y) jid url


end
