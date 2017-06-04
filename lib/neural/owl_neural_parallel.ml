(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Experimental module, do not use now *)

open Owl_neural
open Owl_algodiff.S


(* module signature of model parallel engine *)

module type EngineSig = sig

  type param_context
  type barrier = ASP | BSP | SSP | PSP

  (* functions to hook into parameter server *)

  val get : 'a -> 'b * int

  val set : 'a -> 'b -> unit

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

  val update : network -> t array array -> t array array

  val train_generic : ?params:Params.typ -> network -> t -> t -> float array

end


(* implementation of parallel neural network training *)

module Make (E : EngineSig) (M : ModelSig) = struct

  type task = {
    mutable params : Params.typ;
    mutable model  : M.network;
    mutable data_x : t;
    mutable data_y : t;
  }


  let make_task params model data_x data_y = {
    params;
    model;
    data_x;
    data_y;
  }

  let schedule task workers =
    (* get model, if none then init locally *)
    let model = try E.get "model" |> fst
      with Not_found -> (
        E.set "model" task.model;
        E.get "model" |> fst;
      )
    in
    let tasks = List.map (fun x ->
      (x, [("model", model)])
    ) workers
    in tasks


  let pull task vars =
    (* FIXME: average over number of workers *)
    let n = 2 in
    (* there should be only one item in list *)
    List.map (fun (k, model) ->
      (k, model)
    ) vars


  let push task id vars =
    (* there should be only one item in list *)
    let updates = List.map (fun (k, model) ->
      let params = task.params in
      let x = task.data_x in
      let y = task.data_y in
      M.train_generic ~params model x y |> ignore;
      (k, model) ) vars in
    updates


  let train ?params nn x y jid url =
    (* prepare params and make task *)
    let params = match params with
      | Some p -> p
      | None   -> Params.default ()
    in
    let task = make_task params nn x y in
    (* register sched/push/pull/barrier fun *)
    E.register_schedule (schedule task);
    E.register_pull (pull task);
    E.register_push (push task);
    E.start ~barrier:E.ASP jid url

end
