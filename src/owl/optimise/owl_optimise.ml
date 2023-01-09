(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(* Alias modules of numerical differentiation. *)

module Make_Embedded (A : Owl_types_ndarray_algodiff.Sig) = struct
  include Owl_optimise_generic.Make (Owl_algodiff_generic.Make (A))
end

(* Optimise module of Float32 type *)
module S = Make_Embedded (Owl_algodiff_primal_ops.S)

(* Optimise module of Float64 type *)
module D = Make_Embedded (Owl_algodiff_primal_ops.D)

(* ends here *)
