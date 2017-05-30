(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Experimental module, working in progress *)

open Owl_algodiff.S
open Owl_neural_neuron


type node = {
  mutable id      : int;
  mutable neuron  : neuron;
  mutable prev    : node array;
  mutable next    : node array;
  mutable output  : t option;
  mutable network : network;
}
and network = {
  mutable size : int;         (* size of the graph network *)
  mutable root : node option; (* root of the graph network, i.e. input *)
  mutable topo : node array;  (* nodes sorted in topological order *)
}


(* sort the nodes in a graph network into topological order *)
let topological_sort nn = None

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
let bfs_array x = bfs_map (fun n -> n) x

let get_root nn =
  match nn.root with
  | Some n -> n
  | None   -> failwith "Owl_neural_graph:get_root"

let get_network n = n.network

(* collect the outputs of a given set of nodes *)
let collect_output nodes =
  Array.map (fun n ->
    match n.output with
    | Some o -> o
    | None   -> failwith "Owl_neural_graph:collect_output"
  ) nodes

let connect_pair prev next =
  assert (Array.mem prev next.prev = false);
  assert (Array.mem next prev.next = false);
  next.prev <- Array.append next.prev [|prev|];
  prev.next <- Array.append prev.next [|next|]

let connect_to_parents parents child =
  (* check all the inputs have the same shape *)
  let shp = parents.(0).neuron |> get_out_shape in
  Array.iter (fun n ->
    let shp' = n.neuron |> get_out_shape in
    assert (shp = shp');
  ) parents;
  (* update the child's output shape *)
  connect shp child.neuron;
  (* connect the child to the parents *)
  Array.iter (fun p ->
    connect_pair p child
  ) parents


(* add child node to nn and connect to parents *)
let add_node nn parents child =
  nn.size <- nn.size + 1;
  child.id <- nn.size;
  connect_to_parents parents child;
  nn.topo <- Array.append nn.topo [|child|];
  child.network <- nn

let init nn = Array.iter (fun n -> init n.neuron) nn.topo

let reset nn = Array.iter (fun n -> reset n.neuron) nn.topo

let mktag t nn = Array.iter (fun n -> mktag t n.neuron) nn.topo

let mkpar nn = Array.map (fun n -> mkpar n.neuron) nn.topo

let mkpri nn = Array.map (fun n -> mkpri n.neuron) nn.topo

let mkadj nn = Array.map (fun n -> mkadj n.neuron) nn.topo

let update nn us = Array.iter2 (fun n u -> update n.neuron u) nn.topo us

let run x nn =
  (* init the first input to bootstrap *)
  (get_root nn).output <- Some x;
  Array.iter (fun n ->
    (* collect the inputs from parents' output *)
    let input = match n.neuron with
      | Input _ -> [|x|]
      | _       -> collect_output n.prev
    in
    (* process the current neuron *)
    let output = run_array input n.neuron in
    (* save current neuron's output *)
    n.output <- Some output
  ) nn.topo;
  (collect_output [|nn.topo.(Array.length nn.topo - 1)|]).(0)

let forward nn x = mktag (tag ()) nn; run x nn, mkpar nn

let backward nn y = reverse_prop (F 1.) y; mkpri nn, mkadj nn


(* creation function of various nodes *)

let empty_network () = {
  size = 0;
  root = None;
  topo = [||];
}

let empty_node nn neuron = {
  id = -1;
  neuron;
  prev = [||];
  next = [||];
  output = None;
  network = nn;
}

let input inputs =
  let neuron = Input (Input.create inputs) in
  let nn = {
    size = 1;
    root = None;
    topo = [||];
  }
  in
  let n = {
    id = 1;
    neuron;
    prev = [||];
    next = [||];
    output = None;
    network = nn;
  }
  in
  nn.root <- Some n;
  nn.topo <- [|n|];
  n

let linear ?(init_typ = Init.Standard) outputs input_node =
  let nn = get_network input_node in
  let neuron = Linear (Linear.create outputs init_typ) in
  let n = empty_node nn neuron in
  add_node nn [|input_node|] n;
  n

let activation act_typ input_node =
  let nn = get_network input_node in
  let neuron = Activation (Activation.create act_typ) in
  let n = empty_node nn neuron in
  add_node nn [|input_node|] n;
  n

let to_string nn =
  let s = ref "Graphical network\n\n" in
  for i = 0 to Array.length nn.topo - 1 do
    let t = to_string nn.topo.(i).neuron in
    s := !s ^ (Printf.sprintf "(%i): %s\n" i t)
  done; !s


let train ?params nn x y =
  init nn;
  let f = forward nn in
  let b = backward nn in
  let u = update nn in
  let p = match params with
    | Some p -> p
    | None   -> Owl_neural_optimise.Params.default ()
  in
  let x, y = Mat x, Mat y in
  Owl_neural_optimise.train_nn p f b u x y

(*
let init nn = bfs_iter (fun x ->
  match x.neuron with
  | Linear n       -> Linear.init n
  | LinearNoBias n -> LinearNoBias.init n
  | _              -> () (* activation, etc. *)
  ) [ nn.root ]


let reset nn = bfs_iter (fun x ->
  x.output <- None;
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
  nn.root.output <- Some x;
  bfs_iter (fun x ->
    (* collect the inputs from parents' output *)
    let input = collect_output x.prev in
    (* process the current neuron *)
    let output =
      match x.neuron with
      | Input n        -> Input.run input.(0) n
      | Linear n       -> Linear.run input.(0) n
      | LinearNoBias n -> LinearNoBias.run input.(0) n
    in
    (* save current neuron's output *)
    x.output <- Some output
  ) (Array.to_list nn.root.next)


let forward nn x = mktag (tag ()) nn; run x nn, mkpar nn

let backward nn y = reverse_prop (F 1.) y; mkpri nn, mkadj nn

let to_string nn = None
*)

(* ends here *)
