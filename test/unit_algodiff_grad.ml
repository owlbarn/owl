(** Unit test for Algodiff module, Dense Ndarray in Core *)

include Unit_algodiff_grad_generic.Make (Owl_algodiff_primal_ops.D)
