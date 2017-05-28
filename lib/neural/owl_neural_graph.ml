(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Experimental module, working in progress *)

open Owl_algodiff.S
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


(* BFS iterate the nodes, apply [f : node -> unit] to each node *)
let rec bfs_iter f x =
  match x with
  | []     -> ()
  | hd::tl -> (
      let _ = f hd in
      let new_tl = tl @ (Array.to_list hd.next) in
      bfs_iter f new_tl
    )


(* BFS map the nodes, apply [f : node -> 'a] then return ['a array] *)
let bfs_map f x =
  let stack = Owl_utils.Stack.make () in
  bfs_iter (fun n ->
    Owl_utils.Stack.push stack (f n)
  ) x;
  Owl_utils.Stack.to_array stack


(* convert nn to array, the order is in BFS order *)
let to_array x = bfs_map (fun n -> n) x


let connect prev next =
  assert (Array.mem prev next.prev = false);
  assert (Array.mem next prev.next = false);
  next.prev <- Array.append next.prev [|prev|];
  prev.next <- Array.append prev.next [|next|]


let init nn = bfs_iter (fun x ->
  match x.neuron with
  | Linear n       -> Linear.init n
  | LinearNoBias n -> LinearNoBias.init n
  | _              -> () (* activation, etc. *)
  ) [ nn.root ]


let reset nn = bfs_iter (fun x ->
  match x.neuron with
  | Linear n       -> Linear.reset n
  | LinearNoBias n -> LinearNoBias.reset n
  | _              -> () (* activation, etc. *)
  ) [ nn.root ]


let mktag t nn = bfs_iter (fun x ->
  match x.neuron with
  | Linear n         -> Linear.mktag t n
  | LinearNoBias n   -> LinearNoBias.mktag t n
  | _                -> () (* activation, etc. *)
  ) [ nn.root ]


let mkpar nn = bfs_map (fun x ->
  match x.neuron with
  | Linear n         -> Linear.mkpar n
  | LinearNoBias n   -> LinearNoBias.mkpar n
  | _                -> [||] (* activation, etc. *)
  ) [ nn.root ]


let mkpri nn = bfs_map (fun x ->
  match x.neuron with
  | Linear n         -> Linear.mkpri n
  | LinearNoBias n   -> LinearNoBias.mkpri n
  | _                -> [||] (* activation, etc. *)
  ) [ nn.root ]


let mkadj nn = bfs_map (fun x ->
  match x.neuron with
  | Linear n         -> Linear.mkadj n
  | LinearNoBias n   -> LinearNoBias.mkadj n
  | _                -> [||] (* activation, etc. *)
  ) [ nn.root ]


let update nn us = Array.iter2 (fun x u ->
  match x.neuron with
  | Linear n         -> Linear.update n u
  | LinearNoBias n   -> LinearNoBias.update n u
  | _                -> () (* activation, etc. *)
  ) (to_array nn) us


let run x nn =
  (* init the first input to bootstrap *)
  nn.root.output <- x;
  bfs_iter (fun x ->
    let input = Array.map (fun n -> n.output) x.prev in
    (* process the current neuron *)
    let output =
      match x.neuron with
      | Input n        -> Input.run input.(0) n
      | Linear n       -> Linear.run input.(0) n
      | LinearNoBias n -> LinearNoBias.run input.(0) n
    in
    (* save current neuron's output *)
    x.output <- output
  ) (Array.to_list nn.root.next)


let forward nn x = mktag (tag ()) nn; run x nn, mkpar nn

let backward nn y = reverse_prop (F 1.) y; mkpri nn, mkadj nn

let to_string nn = None


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
