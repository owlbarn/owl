(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Regression Module ]
  This module implements a set of regression functions. S module provides
  supports for single precision float numbers whilst D module provides supports
  for double precision float numbers.
*)


module Make_Embedded
  (A : Owl_types_ndarray_algodiff.Sig)
  = struct

  include
    Owl_regression_generic.Make (
      Owl_optimise_generic.Make (
        Owl_algodiff_generic.Make (A)
      )
    )

end


module S = Make_Embedded (Owl_algodiff_primal_ops.S)


module D = Make_Embedded (Owl_algodiff_primal_ops.D)


(* ends here *)
