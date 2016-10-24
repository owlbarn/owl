(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Regression Module ]
  This module implements a set of regression models with and without
  regularisation. The module relies on the algorithms provided in GSL library
  and optimisation module.
*)

module MX = Owl_dense_real

type dsmat = Owl_dense_real.mat
type vector = Gsl.Vector.vector

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
  both x and y are n x 1 matrices.
  *)
let linear ?(i=false) x y =
  let m, n = MX.shape x in
  let r =
    if n = 1 then _linear_single_var ~i x y
    else _linear_multiple_var ~i x y
  in r

(** [ Polynomial regression without regression ]
  x : variables, n x 1 matrix
  y : observations, n x 1 matrix
  d : the highest degree
  the returned value is a (d+1)x1 matrix, the value in each row is the coeff of corresponding degree
  *)
let polynomial x y d =
  let x = MX.to_array x in
  let y = MX.to_array y in
  let c, _, _ = Gsl.Multifit.fit_poly ~x ~y d in
  MX.of_array c (Array.length c) 1

(** [ Nonlinear Least Square Regression ]  *)
let _nonlinear p fdf x =
  let open Gsl.Fun in
  let open Gsl.Multifit_nlin in
  make LMSDER (Gsl.Vector.length x) (Gsl.Vector.length p) fdf p

let _nonlinear_driver s maxiter epsabs epsrel =
  let open Gsl.Multifit_nlin in
  try for i = 0 to maxiter - 1 do
    let _ = iterate s in
    if test_delta s epsabs epsrel then
      failwith "converged"
  done with exn -> ()

(** [ y = a * exp^(-lambda * x) + b ]
  both x and y are n x 1 matrices.
*)
let exponential x y =
  let open Gsl.Fun in
  let p = Gsl.Vector.of_array [|0.1;0.1;0.1|] in
  let x = Gsl.Vector.of_array MX.(to_array x) in
  let y = Gsl.Vector.of_array MX.(to_array y) in
  let _f ~x:p ~f:y' = (
    let a, lambda, b = p.{0}, p.{1}, p.{2} in
    for i = 0 to (Gsl.Vector.length y') - 1 do
      let x' = x.{i} in
      let z = (a *. Owl_maths.exp ((-.lambda) *. x')) +. b in
      y'.{i} <- (z -. y.{i})
    done )
  in
  let _df ~x:p ~j:j = (
    let a, lambda, b = p.{0}, p.{1}, p.{2} in
    for i = 0 to (MX.row_num j) - 1 do
      let x' = x.{i} in
      let e = Owl_maths.exp ((-.lambda) *. x') in
      j.{i,0} <- e;
      j.{i,1} <- ((-.x') *. a *. e);
      j.{i,2} <- 1.;
    done )
  in
  let _fdf ~x:p ~f:y' ~j:j = () in
  let fdf = { multi_f=_f; multi_df=_df; multi_fdf=_fdf } in
  let s = _nonlinear p fdf x in
  let maxiter, epsabs, epsrel = 1000, 1e-6, 1e-6 in
  let _ = _nonlinear_driver s maxiter epsabs epsrel in
  let _ = Gsl.Multifit_nlin.position s p in
  MX.of_array (Gsl.Vector.to_array p) 3 1


(** [ Nonlinear regression for user-defined function ]
  both x and y are n x 1 matrices; p is the initial guess of the parameters
  g : user-defined function, first is parameter array, second is variable
*)
let nonlinear g p x y =
  let open Gsl.Fun in
  let p = Gsl.Vector.of_array p in
  let x = Gsl.Vector.of_array MX.(to_array x) in
  let y = Gsl.Vector.of_array MX.(to_array y) in
  let _f ~x:p ~f:y' = (
    for i = 0 to (Gsl.Vector.length y') - 1 do
      let z = g p x.{i} in
      y'.{i} <- (z -. y.{i})
    done )
  in (* _df is a numberical approx of Jacobian matrix *)
  let _df ~x:p ~j:j = (
    let dp = 1e-6 in
    for i = 0 to (MX.row_num j) - 1 do
      for k = 0 to (Gsl.Vector.length p) - 1 do
        let p0 = Gsl.Vector.copy p in
        let p1 = Gsl.Vector.copy p in
        let _ = p0.{k} <- p.{k} -. dp in
        let _ = p1.{k} <- p.{k} +. dp in
        let y0 = g p0 x.{i} in
        let y1 = g p1 x.{i} in
        let dj = (y1 -. y0) /. (2. *. dp) in
        j.{i,k} <- dj
      done
    done )
    in
    let _fdf ~x:p ~f:y' ~j:j = () in
    let fdf = { multi_f=_f; multi_df=_df; multi_fdf=_fdf } in
    let s = _nonlinear p fdf x in
    let maxiter, epsabs, epsrel = 1000, 1e-6, 1e-6 in
    let _ = _nonlinear_driver s maxiter epsabs epsrel in
    let _ = Gsl.Multifit_nlin.position s p in
    MX.of_array (Gsl.Vector.to_array p) (Gsl.Vector.length p) 1


(* regression functions in Optimise module *)
let kmeans = Owl_optimise.kmeans

let ols = Owl_optimise.ols_regression

let lasso = Owl_optimise.lasso_regression

let svm = Owl_optimise.svm_regression

let ridge = Owl_optimise.ridge_regression

let logistic = Owl_optimise.logistic_regression






(* ends here *)
