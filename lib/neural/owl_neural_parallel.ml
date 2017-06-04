(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Experimental module, do not use now *)

open Owl_neural


(* module signature of model parallel engine *)

module type EngineSig = sig

  type param_context

  (* functions to hook into parameter server *)

  val get : 'a -> 'b * int

  val set : 'a -> 'b -> unit

  val register_barrier : (param_context ref -> int * (string list)) -> unit

  val register_schedule : ('a list -> ('a * ('b * 'c) list) list) -> unit

  val register_pull : (('a * 'b) list -> ('a * 'c) list) -> unit

  val register_push : ('a -> ('b * 'c) list -> ('b * 'c) list) -> unit

  val register_stop : (param_context ref -> bool) -> unit

end


(* module signature of neural network model *)

module type ModelSig = sig

  type network

  val train_generic : ?params:Params.typ -> network -> Owl_algodiff.S.t -> Owl_algodiff.S.t -> float array

end


(* implementation of parallel neural network training *)

module Make (E : EngineSig) (M : ModelSig) = struct

  type task = {
    mutable params : Owl_neural.Params.typ;
    mutable model  : Owl_neural_feedforward.network;
    mutable data_x : Owl_algodiff.S.t;
    mutable data_y : Owl_algodiff.S.t;
  }

  let register_stop = E.register_stop

  let pull = None

  let push = None

  let retrieve_model () =
    let open Owl_neural_feedforward in
    (* model has been initialised *)
    try E.get "model" |> fst
    (* model does not exist, init *)
    with Not_found -> (
      Log.warn "model does not exists, init now ...";
      let nn = input [|28;28;1|]
        |> conv2d [|5;5;1;32|] [|1;1|] ~act_typ:Activation.Relu
        |> max_pool2d [|2;2|] [|2;2|]
        |> conv2d [|5;5;32;64|] [|1;1|] ~act_typ:Activation.Relu
        |> max_pool2d [|2;2|] [|2;2|]
        |> dropout 0.1
        |> fully_connected 1024 ~act_typ:Activation.Relu
        |> linear 10 ~act_typ:Activation.Softmax
      in
      E.set "model" nn;
      E.get "model" |> fst
    )

  let schedule workers =
    let model = retrieve_model () in
    let tasks = List.map (fun x ->
      (x, [("model", model)])
    ) workers
    in tasks


  let push task id vars =
    let updates = List.map (fun (k, model) ->
      let params = task.params in
      let x = task.data_x in
      let y = task.data_y in
      Feedforward.train_generic ~params model x y |> ignore;
      (k, model) ) vars in
    updates

end
