(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) t


(** {6 Create sparse matrices} *)

val zeros : ('a, 'b) kind -> int -> int -> ('a, 'b) t

val eye : ('a, 'b) kind -> int -> ('a, 'b) t
