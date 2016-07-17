(** [ Regression Module ]
  This module implements a set of regression models with and without
  regularisation. The module relies on the algorithms provided in GSL library
  and optimisation module.
*)

module MX = Matrix.Dense


(** [ Linear regression with single variables ]  *)
let _linear_single_var ?(i=false) x y =
  let open Gsl.Fit in
  let x = MX.to_array x in
  let y = MX.to_array y in
  let r =
    if i = true then let r = Gsl.Fit.linear x y in [| r.c0; r.c1 |]
    else let r = Gsl.Fit.mul x y in [| r.m_c1 |]
  in MX.of_array r (Array.length r) 1

(** [ Linear regression of multiple parameters ]  *)
let _linear_multiple_var ?(i=false) x y =
  let open Gsl.Multifit in
  let open Gsl.Vectmat in
  let x = if i = false then x
    else MX.(ones (row_num x) 1 @|| x) in
  let y = Gsl.Vector.of_array (MX.to_array y) in
  let c, _, _ = Gsl.Multifit.linear (`M x) (`V y) in
  MX.of_array (Gsl.Vector.to_array c) (Gsl.Vector.length c) 1

(** [ Linear regression without regularisation ]
  i : whether to include intercept, the first coeff in the returned result is the intercept.
  *)
let linear ?(i=false) x y =
  let m, n = MX.shape x in
  let r =
    if n = 1 then _linear_single_var ~i x y
    else _linear_multiple_var ~i x y
  in r

(** [ polynomial regression without regression ]  *)
let polynomial ?(i=false) x y = None







(* ends here *)
