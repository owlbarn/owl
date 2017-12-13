(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type 'a node = {
  mutable id   : int;            (* unique identifier *)
  mutable name : string;         (* name of the node *)
  mutable prev : 'a node array;  (* parents of the node *)
  mutable next : 'a node array;  (* children of the node *)
  mutable attr : 'a;             (* indicate the validity *)
}

type order = BFS | DFS


let _global_id = ref 0

let id x = x.id

let name x = x.name

let parents x = x.prev

let children x = x.next

let indegree x = Array.length x.prev

let outdegree x = Array.length x.next

let attr x = x.attr


let node ?(name="") ?(prev=[||]) ?(next=[||]) attr =
  _global_id := !_global_id + 1;
  {
    id = !_global_id;
    name;
    prev;
    next;
    attr;
  }


let connect parents children =
  Array.iter (fun parent ->
    Array.iter (fun child ->
        parent.next <- (Array.append parent.next [|child|]);
        child.prev <- (Array.append child.prev [|parent|]);
    ) children
  ) parents


let remove_node x =
  let f = fun y -> y.id <> x.id in
  Array.iter (fun parent ->
    parent.next <- Owl_utils.array_filter f parent.next
  ) x.prev;
  Array.iter (fun child ->
    child.prev <- Owl_utils.array_filter f child.prev
  ) x.next


let remove_link src dst =
  src.next <- Owl_utils.array_filter (fun x -> x.id <> dst.id) src.next;
  dst.prev <- Owl_utils.array_filter (fun x -> x.id <> src.id) dst.prev


(* depth-first search from [x]; [f : node -> unit] is applied to each node;
  [next node -> node array] returns the next set of nodes to iterate;
*)
let dfs_iter f x next =
  let h = Hashtbl.create 512 in
  let rec _dfs_iter y =
    Array.iter (fun z ->
      if Hashtbl.mem h z.id = false then (
        f z;
        Hashtbl.add h z.id None;
        _dfs_iter (next z);
      )
    ) y
  in
  _dfs_iter x


(* TODO: BFS iterator *)
let bfs_iter f next x = failwith "owl_graph:bfs_iter"


let iter_ancestors order f x =
  match order with
  | BFS -> bfs_iter f x parents
  | DFS -> dfs_iter f x parents


let iter_descendants order f x =
  match order with
  | BFS -> bfs_iter f x children
  | DFS -> dfs_iter f x children


(* TODO *)
let copy = None


let node_to_str x =
  Printf.sprintf "[ #%i %s in:%i out:%i ]" x.id x.name (indegree x) (outdegree x)


let pp_node formatter x =
  Format.open_box 0;
  Format.fprintf formatter "%s" (node_to_str x);
  Format.close_box ()


let to_string from_root node_to_str x =
  let s = ref "" in
  let flip_fun, next_fun, iter_fun =
    match from_root with
    | true  -> (fun x y -> (x,y)), (fun x -> x.next), (iter_descendants DFS)
    | false -> (fun x y -> (y,x)), (fun x -> x.prev), (iter_ancestors DFS)
  in
  iter_fun (fun m ->
    Array.iter (fun n ->
      let a, b = flip_fun (node_to_str m) (node_to_str n) in
      s := Printf.sprintf "%s%s -> %s\n" !s a b;
    ) (next_fun m)
  ) (Array.of_list x);
  !s


(* ends here *)
