(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Graph module supports basic operations on DAG. *)


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

val remove_edge : 'a node -> 'a node -> unit


(** {6 Iterators} *)

val iter_ancestors : ?order:order -> ('a node -> unit) -> 'a node array -> unit

val iter_descendants : ?order:order -> ('a node -> unit) -> 'a node array -> unit

val filter_ancestors : ('a node -> bool) -> 'a node array -> 'a node array

val filter_descendants : ('a node -> bool) -> 'a node array -> 'a node array

val fold_ancestors : ('b -> 'a node -> 'b) -> 'b -> 'a node array -> 'b

val fold_descendants : ('b -> 'a node -> 'b) -> 'b -> 'a node array -> 'b

val iter_in_edges : ?order:order -> ('a node -> 'a node -> unit) -> 'a node array -> unit

val iter_out_edges : ?order:order -> ('a node -> 'a node -> unit) -> 'a node array -> unit

val fold_in_edges : ('b -> 'a node -> 'a node -> 'b) -> 'b -> 'a node array -> 'b

val fold_out_edges : ('b -> 'a node -> 'a node -> 'b) -> 'b -> 'a node array -> 'b


(** {6 Helper functions} *)

val pp_node : Format.formatter -> 'a node -> unit

val to_string : bool -> ('a node -> string) -> 'a node list -> string
(* FIXME *)
