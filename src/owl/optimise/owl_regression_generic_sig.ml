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
      [ols ?i x y] performs Ordinary Least Squares regression, minimising
      [||y - x w - b||^2].
      - [i] adds an intercept [b] when [true]. The default is [false].
      - [x] is the [n] by [m] matrix of input features.
      - [y] is the [n] by [k] matrix of outputs, one model per column.
      Returns [[| w |]], or [[| w; b |]] with an intercept, where [w] is [m] by
      [k] and [b] is [1] by [k]. The solution is computed directly from the SVD
      of [x]; if [x] is rank deficient the minimum-norm solution is returned.
  *)

  val ridge : ?i:bool -> ?alpha:float -> arr -> arr -> arr array
  (**
      [ridge ?i ?alpha x y] performs Ridge regression, minimising
      [||y - x w - b||^2 + alpha ||w||^2]. The intercept [b] is not penalised.
      - [i] adds an intercept when [true]. The default is [false].
      - [alpha] is the non-negative penalty strength. The default is [0.001].
      Shapes and results are as for {!ols}; the solution is computed directly.
  *)

  val lasso : ?i:bool -> ?alpha:float -> arr -> arr -> arr array
  (**
      [lasso ?i ?alpha x y] performs Lasso regression, minimising
      [||y - x w - b||^2 + alpha ||w||_1] by cyclic coordinate descent. The
      intercept [b] is not penalised.
      - [i] adds an intercept when [true]. The default is [false].
      - [alpha] is the non-negative penalty strength. The default is [0.001].
      Shapes and results are as for {!ols}.
  *)

  val elastic_net : ?i:bool -> ?alpha:float -> ?l1_ratio:float -> arr -> arr -> arr array
  (**
      [elastic_net ?i ?alpha ?l1_ratio x y] performs Elastic Net regression,
      minimising [||y - x w - b||^2 + alpha * l1_ratio * ||w||_1
      + alpha * (1 - l1_ratio) / 2 * ||w||^2] by cyclic coordinate descent. The
      intercept [b] is not penalised.
      - [i] adds an intercept when [true]. The default is [false].
      - [alpha] is the non-negative penalty strength. The default is [1.0].
      - [l1_ratio] in [[0, 1]] balances the two penalties. The default is [0.5].
      Shapes and results are as for {!ols}.
  *)

  val svm : ?i:bool -> ?a:float -> arr -> arr -> arr array
  (**
      [svm ?i ?a x y] trains a linear Support Vector Machine by gradient descent
      on the hinge loss [sum (max 0 (1 - y (x w + b))) + a ||(w, b)||]; unlike
      the other models here, the intercept is penalised too.
      - [i] adds an intercept when [true]. The default is [false].
      - [a] is the regularisation strength. The default is [0.001].
      - [y] holds labels in [{-1, 1}].
      Returns [[| w |]], or [[| w; b |]] with an intercept.
  *)

  val logistic : ?i:bool -> arr -> arr -> arr array
  (**
      [logistic ?i x y] performs logistic regression: it maximises the
      likelihood of [P (y = 1) = sigmoid (x w + b)] by Newton's method.
      - [i] adds an intercept when [true]. The default is [false].
      - [y] holds targets in [[0, 1]], usually labels in [{0, 1}], one model
        per column. Other values raise [Invalid_argument].
      Returns [[| w |]], or [[| w; b |]] with an intercept. On linearly
      separable data the likelihood has no maximum; the weights returned then
      classify the training data correctly but their size is arbitrary.
  *)

  val exponential : ?i:bool -> arr -> arr -> elt * elt * elt
  (**
      [exponential x y] fits [y = a * exp (-l * x) + b] by least squares and
      returns [(a, l, b)]. [l] may be negative, for a growing exponential. For a
      fixed [l] the model is linear in [a] and [b], so the residual is minimised
      over [l] alone: on a grid of [l * (max x - min x)] in [[-50, 50]],
      refined by golden-section search.
      - [i] is ignored.
      - [x] and [y] hold the same number of values, at least 3 distinct in [x].
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
