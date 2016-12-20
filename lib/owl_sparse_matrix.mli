(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type ('a, 'b) t
type ('a, 'b) kind

(** {6 Create sparse matrices} *)

val zeros : ('a, 'b) kind -> int -> int -> ('a, 'b) t

val ones : ('a, 'b) kind -> int -> int -> ('a, 'b) t

val eye : ('a, 'b) kind -> int -> ('a, 'b) t
