(** Unit test for Algodiff module, Dense Ndarray in Base *)

include Unit_algodiff_diff_generic.Make (Owl_base_algodiff_primal_ops.D)
