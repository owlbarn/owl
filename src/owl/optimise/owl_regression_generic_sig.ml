(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module type Sig = sig
  module Optimise : Owl_optimise_generic_sig.Sig

  open Optimise.Algodiff

  (** {5 Type definition} *)

  type arr = A.arr
  (** Type of ndarray values. *)

  type elt = A.elt
  (** Type of scalar values. *)

  (** {5 Regression models} *)
  val ols : ?i:bool -> arr -> arr -> arr array
  (** 
      [ols ?i x y] performs Ordinary Least Squares (OLS) regression on the data [x] and [y].
      - [i] is an optional parameter indicating whether to include an intercept in the model. The default is [true].
      - [x] is the matrix of input features.
      - [y] is the vector of output values.
      Returns an array of coefficients for the linear model.
  *)
  
  val ridge : ?i:bool -> ?alpha:float -> arr -> arr -> arr array
  (** 
      [ridge ?i ?alpha x y] performs Ridge regression on the data [x] and [y].
      - [i] is an optional parameter indicating whether to include an intercept in the model. The default is [true].
      - [alpha] is the regularization strength parameter. The default value is 1.0.
      - [x] is the matrix of input features.
      - [y] is the vector of output values.
      Returns an array of coefficients for the linear model.
  *)
  
  val lasso : ?i:bool -> ?alpha:float -> arr -> arr -> arr array
  (** 
      [lasso ?i ?alpha x y] performs Lasso regression on the data [x] and [y].
      - [i] is an optional parameter indicating whether to include an intercept in the model. The default is [true].
      - [alpha] is the regularization strength parameter. The default value is 1.0.
      - [x] is the matrix of input features.
      - [y] is the vector of output values.
      Returns an array of coefficients for the linear model.
  *)
  
  val elastic_net : ?i:bool -> ?alpha:float -> ?l1_ratio:float -> arr -> arr -> arr array
  (** 
      [elastic_net ?i ?alpha ?l1_ratio x y] performs Elastic Net regression on the data [x] and [y].
      - [i] is an optional parameter indicating whether to include an intercept in the model. The default is [true].
      - [alpha] is the regularization strength parameter. The default value is 1.0.
      - [l1_ratio] is the ratio between L1 and L2 regularization terms. The default value is 0.5.
      - [x] is the matrix of input features.
      - [y] is the vector of output values.
      Returns an array of coefficients for the linear model.
  *)
  
  val svm : ?i:bool -> ?a:float -> arr -> arr -> arr array
  (** 
      [svm ?i ?a x y] performs Support Vector Machine (SVM) classification on the data [x] and [y].
      - [i] is an optional parameter indicating whether to include an intercept in the model. The default is [true].
      - [a] is an optional parameter for the regularization parameter (commonly denoted as C). The default value is 1.0.
      - [x] is the matrix of input features.
      - [y] is the vector of output values.
      Returns an array of support vectors and coefficients.
  *)
  
  val logistic : ?i:bool -> arr -> arr -> arr array
  (** 
      [logistic ?i x y] performs logistic regression on the data [x] and [y].
      - [i] is an optional parameter indicating whether to include an intercept in the model. The default is [true].
      - [x] is the matrix of input features.
      - [y] is the vector of output values.
      Returns an array of coefficients for the logistic model.
  *)
  
  val exponential : ?i:bool -> arr -> arr -> elt * elt * elt
  (** 
      [exponential ?i x y] fits an exponential model to the data [x] and [y].
      - [i] is an optional parameter indicating whether to include an intercept in the model. The default is [true].
      - [x] is the vector of input values.
      - [y] is the vector of output values.
      Returns a tuple containing the coefficients of the exponential model.
  *)
  
  val poly : arr -> arr -> int -> arr
  (** 
      [poly x y degree] fits a polynomial model of the specified [degree] to the data [x] and [y].
      - [x] is the vector of input values.
      - [y] is the vector of output values.
      - [degree] specifies the degree of the polynomial.
      Returns the coefficients of the polynomial model.
  *)
  
end
