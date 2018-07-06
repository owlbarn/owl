(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
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
      Owl_optimise_generic2.Make (
        Owl_algodiff_generic2.Make (A)
      )
    )

end


module S = Make_Embedded (Owl_dense_ndarray.S)


module D = Make_Embedded (Owl_dense_ndarray.D)


(* ends here *)
