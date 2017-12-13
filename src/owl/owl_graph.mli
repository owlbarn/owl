(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** {6 Type definition} *)

type order = BFS | DFS
(** Order to traverse a graph, BFS or DFS. *)

type 'a node
(** type definition of a node *)


(** {6 Manipulation functions} *)

val node : ?name:string -> ?prev:'a node array -> ?next:'a node array -> 'a -> 'a node

val connect : 'a node array -> 'a node array -> unit

val parents : 'a node -> 'a node array

val children : 'a node -> 'a node array

val refnum : 'a node -> int


(** {6 Iterators} *)

val dfs_iter : ('a node -> unit) -> 'a node array -> ('a node -> 'a node array) -> unit

val iter_ancestors : order -> ('a node -> unit) -> 'a node array -> unit

val iter_descendants : order -> ('a node -> unit) -> 'a node array -> unit
