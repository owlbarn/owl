(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Experimental module, working in progress *)

open Owl_neural_layer


type neuron =
  | Input          of Input.layer
  | Linear         of Linear.layer
  | LinearNoBias   of LinearNoBias.layer


type node = {
  mutable id     : int;
  mutable neuron : neuron;
  mutable prev   : node array;
  mutable next   : node array;
  mutable output : t;
}


type network = {
  mutable root : node;
}


let connect prev next =
  assert (Array.mem prev next.prev = false);
  assert (Array.mem next prev.next = false);
  next.prev <- Array.append next.prev [|prev|];
  prev.next <- Array.append prev.next [|next|]


(* traverse the nodes in BFS way, apply [f : node -> unit] to each node *)
let rec bfs_traverse f = function
  | []     -> ()
  | hd::tl -> (
      let _ = f hd in
      let new_tl = tl @ (Array.to_list hd.next) in
      bfs_traverse f new_tl
    )

let init nn =
  let init_f hd =
    match hd.neuron with
    | Linear n       -> Linear.init n
    | LinearNoBias n -> LinearNoBias.init n
    | _              -> ()
  in
  bfs_traverse init_f [ nn.root ]

let run x nn =
  let run_f hd =
    let input = Array.map (fun n -> n.output) hd.prev in
    (* process the current neuron *)
    let output =
      match hd.neuron with
      | Input n        -> Input.run input.(0) n
      | Linear n       -> Linear.run input.(0) n
      | LinearNoBias n -> LinearNoBias.run input.(0) n
    in
    (* save current neuron's output *)
    hd.output <- output
  in
  (* bootstrap the run *)
  nn.root.output <- x;
  Array.to_list nn.root.next
  |> bfs_traverse run_f


(* may become obsolete *)

let rec _traverse = function
  | []     -> ()
  | hd::tl -> (
      let input = Array.map (fun n -> n.output) hd.prev in
      (* process the current neuron *)
      let output =
        match hd.neuron with
        | Input n        -> Input.run input.(0) n
        | Linear n       -> Linear.run input.(0) n
        | LinearNoBias n -> LinearNoBias.run input.(0) n
      in
      (* save current neuron's output *)
      hd.output <- output;
      (* traverse next node in BFS way *)
      let new_tl = tl @ (Array.to_list hd.next) in
      _traverse new_tl
    )

let run0 x nn =
  nn.root.output <- x;
  Array.to_list nn.root.next
  |> _traverse


let create () =  None

let forward = None

let backward = None


(*
let linear ?(init_typ = Init.Standard) ?inputs outputs =
  let neuron = Linear (Linear.create ?inputs outputs init_typ) in
  let output = {
    id     = 0;
    neuron = neuron;
    prec   = [||];
  }
  in
  output
*)
