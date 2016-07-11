
module MX = Matrix.Dense

(** [ LU decomposition ]  *)

let inv x =
  let open Gsl.Vectmat in
  let y = Gsl.Linalg.invert_LU (`M x) in
  match y with `M y -> y | _ -> MX.empty 0 0

let det x =
  let open Gsl.Vectmat in
  Gsl.Linalg.det_LU (`M x)

let lu x =
  let open Gsl.Vectmat in
  let y = Gsl.Linalg.decomp_LU (`M x) in
  match y with `M a, b, c -> a, b, c

let lu_solve = None

let q


(** [ QR decomposition ]  *)


(** [ Sigular Value decomposition ]  *)


(** [ Cholesky Decomposition ]  *)
