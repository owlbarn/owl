(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Graph module supports basic operations on DAG. *)


(** {6 Type definition} *)

type order = BFS | DFS
(** Order to traverse a graph, BFS or DFS. *)

type dir = Ancestor | Descendant
(** Iteration direction, i.e. ancestors or descendants *)

type 'a node
(** type definition of a node *)


(** {6 Obtaining properties} *)

val id : 'a node -> int
(** ``id x`` returns the id of node ``x``.  *)

val name : 'a node -> string
(** ``name x`` returns the name string of node ``x``.  *)

val parents : 'a node -> 'a node array
(** ``parents x`` returns the parents of node ``x``.  *)

val children : 'a node -> 'a node array
(** ``children x`` returns the children of node ``x``.  *)

val indegree : 'a node -> int
(** ``indegree x`` returns the in-degree of node ``x``.  *)

val outdegree : 'a node -> int
(** ``outdegree x`` returns the out-degree of node ``x``.  *)

val attr : 'a node -> 'a
(** ``attr x`` returns the ``attr`` field of node ``x``.  *)

val set_attr : 'a node -> 'a -> unit
(** ``set_attr x`` sets the ``attr`` field of node ``x``.  *)


(** {6 Manipulation functions} *)

val node : ?id:int -> ?name:string -> ?prev:'a node array -> ?next:'a node array -> 'a -> 'a node
(**
``node ~id ~name ~prev ~next attr`` creates a node with given id and name
string. The created node is also connected to parents in ``prev`` and children
in ``next``. The ``attr`` will be saved in ``attr`` field.
 *)

val connect : 'a node array -> 'a node array -> unit
(**
``connect parents children`` connects a set of parents to a set of children.
The created links are the Cartesian product of parents and children.
*)

val remove_node : 'a node -> unit
(**
``remove_node x`` removes node ``x`` from the graph by disconnecting itself
from all its parent nodes and child nodes.
 *)

val remove_edge : 'a node -> 'a node -> unit
(**
``remove_edge src dst`` removes a link ``src -> dst`` from the graph. Note that
it does not remove [dst -> src] if there exists one.
 *)

val copy : ?dir:dir -> 'a node array -> 'a node array
(**
``copy ~dir x`` makes a copy of ``x`` and all its ancestors
(if ``dir = Ancestor``) or all its descendants (if ``dir = Descendant``).

Note that this function only makes a copy of the graph structure, ``attr``
fileds of the nodes in the new graph share the same memory with those in the
original graph.
 *)


(** {6 Iterators} *)

val iter_ancestors : ?order:order -> ('a node -> unit) -> 'a node array -> unit
(** Iterate the ancestors of a given node. *)

val iter_descendants : ?order:order -> ('a node -> unit) -> 'a node array -> unit
(** Iterate the descendants of a given node. *)

val filter_ancestors : ('a node -> bool) -> 'a node array -> 'a node array
(** Filter the ancestors of a given node. *)

val filter_descendants : ('a node -> bool) -> 'a node array -> 'a node array
(** Iterate the descendants of a given node. *)

val fold_ancestors : ('b -> 'a node -> 'b) -> 'b -> 'a node array -> 'b
(** Fold the ancestors of a given node. *)

val fold_descendants : ('b -> 'a node -> 'b) -> 'b -> 'a node array -> 'b
(** Fold the descendants of a given node. *)

val iter_in_edges : ?order:order -> ('a node -> 'a node -> unit) -> 'a node array -> unit
(** Iterate all the in-edges of a given node. *)

val iter_out_edges : ?order:order -> ('a node -> 'a node -> unit) -> 'a node array -> unit
(** Iterate all the out-edges of a given node. *)

val fold_in_edges : ('b -> 'a node -> 'a node -> 'b) -> 'b -> 'a node array -> 'b
(** Fold all the in-edges of a given node. *)

val fold_out_edges : ('b -> 'a node -> 'a node -> 'b) -> 'b -> 'a node array -> 'b
(** Fold all the out-edges of a given node. *)


(** {6 Helper functions} *)

val pp_node : Format.formatter -> 'a node -> unit
(** Pretty print a given node. *)

val to_string : bool -> 'a node array -> string
(** Convert a given node to string. *)
