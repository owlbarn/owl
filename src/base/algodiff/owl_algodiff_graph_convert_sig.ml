module type Sig = sig
  type t

  val to_trace : t list -> string
  (** ``to_trace [t0; t1; ...]`` outputs the trace of computation graph on the terminal
      in a human-readable format. *)

  val to_dot : t list -> string
  (** ``to_dot [t0; t1; ...]`` outputs the trace of computation graph in the dot file
      format which you can use other tools further visualisation, such as Graphviz. *)

  val pp_num : Format.formatter -> t -> unit
    [@@ocaml.toplevel_printer]
  (** ``pp_num t`` pretty prints the abstract number used in ``Algodiff``. *)
end
