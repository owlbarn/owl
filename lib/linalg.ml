
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


(** [ QR decomposition ]  *)

let qr x =
  let open Gsl.Vectmat in
  let m, n = MX.shape x in
  let y = MX.clone x in
  let v = Gsl.Vector.create (min m n) in
  let _ = Gsl.Linalg._QR_decomp (`M y) (`V v) in
  let q = MX.empty m m in
  let r = MX.empty m n in
  let _ = Gsl.Linalg._QR_unpack (`M y) (`V v) (`M q) (`M r) in
  q, r

let qr_sqsolve a b =
  let open Gsl.Vectmat in
  let c = MX.clone a in
  let b = Gsl.Vector.of_array (MX.to_array b) in
  let v = Gsl.Vector.create (MX.row_num a) in
  let x = Gsl.Vector.create (MX.row_num a) in
  let _ = Gsl.Linalg._QR_decomp (`M c) (`V v) in
  let _ = Gsl.Linalg._QR_solve (`M c) (`V v) (`V b) (`V x) in
  MX.of_array (Gsl.Vector.to_array x) (MX.row_num a) 1

let qr_lssolve a b =
  let open Gsl.Vectmat in
  let m, n = MX.shape a in
  let c = MX.clone a in
  let b = Gsl.Vector.of_array (MX.to_array b) in
  let v = Gsl.Vector.create (min m n) in
  let x = Gsl.Vector.create n in
  let r = Gsl.Vector.create m in
  let _ = Gsl.Linalg._QR_decomp (`M c) (`V v) in
  let _ = Gsl.Linalg._QR_lssolve (`M c) (`V v) (`V b) (`V x) (`V r) in
  let x = MX.of_array (Gsl.Vector.to_array x) n 1 in
  let r = MX.of_array (Gsl.Vector.to_array r) m 1 in
  x, r

let qr_solve a b =
  let m, n = MX.shape a in
  match m = n with
  | true -> qr_sqsolve a b, MX.empty 0 0
  | false -> qr_lssolve a b

let rank = None

(** [ Sigular Value decomposition ]  *)

let svd x = None

(** [ Cholesky Decomposition ]  *)

let cholesky x =
  let open Gsl.Vectmat in
  let y = MX.clone x in
  let _ = Gsl.Linalg.cho_decomp (`M y) in y

let is_posdef x =
  try cholesky x; true
  with exn -> false





(* ends here *)
