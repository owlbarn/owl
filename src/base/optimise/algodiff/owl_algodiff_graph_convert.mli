module Make : functor (Core: Owl_algodiff_core_sig.Sig) -> sig
  val to_trace : Core.t list -> string

  val to_dot : Core.t list -> string

  val pp_num : Format.formatter -> Core.t -> unit
    [@@ocaml.toplevel_printer] 

end
