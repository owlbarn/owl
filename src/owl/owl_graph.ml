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

type dir = Ancestor | Descendant


let _global_id = ref 0

let id x = x.id

let name x = x.name

let parents x = x.prev

let children x = x.next

let indegree x = Array.length x.prev

let outdegree x = Array.length x.next

let attr x = x.attr

let set_attr x a = x.attr <- a


let node ?id ?(name="") ?(prev=[||]) ?(next=[||]) attr =
  let id = match id with
    | Some i -> i
    | None   -> (
        _global_id := !_global_id + 1;
        !_global_id
      )
  in
  { id; name; prev; next; attr }


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
    parent.next <- Owl_utils.Array.filter f parent.next
  ) x.prev;
  Array.iter (fun child ->
    child.prev <- Owl_utils.Array.filter f child.prev
  ) x.next


let remove_edge src dst =
  src.next <- Owl_utils.Array.filter (fun x -> x.id <> dst.id) src.next;
  dst.prev <- Owl_utils.Array.filter (fun x -> x.id <> src.id) dst.prev


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


let iter_ancestors ?(order=DFS) f x =
  match order with
  | BFS -> bfs_iter f x parents
  | DFS -> dfs_iter f x parents


let iter_descendants ?(order=DFS) f x =
  match order with
  | BFS -> bfs_iter f x children
  | DFS -> dfs_iter f x children


let iter ?(dir=Ancestor) ?order f x =
  match dir with
  | Ancestor   -> iter_ancestors ?order f x
  | Descendant -> iter_descendants ?order f x


let filter_ancestors f x =
  let s = Owl_utils.Stack.make () in
  iter_ancestors (fun n -> if f n then Owl_utils.Stack.push s n) x;
  Owl_utils.Stack.to_array s


let filter_descendants f x =
  let s = Owl_utils.Stack.make () in
  iter_descendants (fun n -> if f n then Owl_utils.Stack.push s n) x;
  Owl_utils.Stack.to_array s


let fold_ancestors f a x =
  let a = ref a in
  iter_ancestors (fun b -> a := f !a b) x;
  !a


let fold_descendants f a x =
  let a = ref a in
  iter_descendants (fun b -> a := f !a b) x;
  !a


let iter_in_edges ?order f x =
  iter_ancestors ?order (fun dst ->
    Array.iter (fun src -> f src dst) dst.prev
  ) x


let iter_out_edges ?order f x =
  iter_descendants ?order (fun src ->
    Array.iter (fun dst -> f src dst) src.next
  ) x


let fold_in_edges f a x =
  let a = ref a in
  iter_in_edges (fun b c -> a := f !a b c) x;
  !a


let fold_out_edges f a x =
  let a = ref a in
  iter_out_edges (fun b c -> a := f !a b c) x;
  !a


(* TODO: optimise *)
let copy ?(dir=Ancestor) x =
  let _make_if_not_exists h n =
    if Hashtbl.mem h n.id = true then Hashtbl.find h n.id
    else (
      let n' = node ~id:n.id ~name:n.name ~prev:[||] ~next:[||] n.attr in
      Hashtbl.add h n'.id n';
      n'
    )
  in
  let h = Hashtbl.create 128 in
  let _copy src dst =
    let src' = _make_if_not_exists h src in
    let dst' = _make_if_not_exists h dst in
    connect [|src'|] [|dst'|]
  in
  let _ = match dir with
    | Ancestor   -> iter_in_edges _copy x
    | Descendant -> iter_out_edges _copy x
  in
  Array.map (fun n -> Hashtbl.find h n.id) x


let to_array = None

let to_hashtbl = None


let node_to_str x =
  Printf.sprintf "[ #%i %s in:%i out:%i ]" x.id x.name (indegree x) (outdegree x)


let pp_node formatter x =
  Format.open_box 0;
  Format.fprintf formatter "%s" (node_to_str x);
  Format.close_box ()


let to_string from_root x =
  let s = ref "" in
  let iter_fun = if from_root then iter_out_edges else iter_in_edges in
  iter_fun (fun u v -> s := Printf.sprintf "%s%i -> %i\n" !s u.id v.id) x;
  !s


(* ends here *)
