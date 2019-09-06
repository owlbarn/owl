module Make : functor (Core: Owl_algodiff_core_sig.Sig) -> sig 
   val reverse_push : Core.t -> Core.t -> unit 
   val reverse_prop : Core.t -> Core.t -> unit 
   val reverse_reset : Core.t -> unit 
end
