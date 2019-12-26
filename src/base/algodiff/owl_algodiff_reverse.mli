(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module Make (C : sig
  include Owl_algodiff_core_sig.Sig

  val reverse_add : t -> t -> t
end) : sig
  val reverse_push : C.t -> C.t -> unit

  val reverse_prop : C.t -> C.t -> unit

  val reverse_reset : C.t -> unit
end
