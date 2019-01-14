(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Functor of making the symbols of a computation graph. *)

module type Sig = sig

  module Type : Owl_computation_type_sig.Sig

  open Type

  (** {6 Core functions} *)

  val infer_shape : op -> attr Owl_graph.node array -> int array option array
  (** TODO *)

end
