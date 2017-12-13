(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Type definition} *)

type order = BFS | DFS
(** Order to traverse a graph, BFS or DFS. *)

type 'a node
(** type definition of a node *)


(** {6 Obtaining properties} *)

val id : 'a node -> int

val name : 'a node -> string

val parents : 'a node -> 'a node array

val children : 'a node -> 'a node array

val indegree : 'a node -> int

val outdegree : 'a node -> int

val attr : 'a node -> 'a


(** {6 Manipulation functions} *)

val node : ?name:string -> ?prev:'a node array -> ?next:'a node array -> 'a -> 'a node

val connect : 'a node array -> 'a node array -> unit

val remove_node : 'a node -> unit

val remove_link : 'a node -> 'a node -> unit


(** {6 Iterators} *)

val dfs_iter : ('a node -> unit) -> 'a node array -> ('a node -> 'a node array) -> unit

val iter_ancestors : order -> ('a node -> unit) -> 'a node array -> unit

val iter_descendants : order -> ('a node -> unit) -> 'a node array -> unit


(** {6 Helper functions} *)

val to_string : bool -> ('a node -> string) -> 'a node list -> string
