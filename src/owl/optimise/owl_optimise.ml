(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Alias modules of numerical differentiation. *)

module Make_Embedded
  (A : Owl_types_ndarray_algodiff.Sig)
  = struct

  include
    Owl_optimise_generic.Make (
      Owl_algodiff_generic.Make (A)
    )

end



(* Optimise module of Float32 type *)
module S = Make_Embedded (Owl_dense_ndarray.S)


(* Optimise module of Float64 type *)
module D = Make_Embedded (Owl_dense_ndarray.D)


(* ends here *)
