(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module Make (C : sig
  include Owl_algodiff_core_sig.Sig

  val reverse_add : t -> t -> t
end) : sig
  val reverse_push : C.t -> C.t -> unit

  val reverse_prop : C.t -> C.t -> unit

  val reverse_reset : C.t -> unit
end
