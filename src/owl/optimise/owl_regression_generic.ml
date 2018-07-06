(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module Make
  (Optimise : Owl_optimise_generic_sig2.Sig)
  = struct

  module Optimise = Optimise

  open Optimise

  open Optimise.Algodiff


  (* iterative sovler for linear regression *)
  let _linear_reg bias params x y =
    let s = A.shape x in
    let l, m = s.(0), s.(1) in
    let n = A.col_num y in
    let o = if bias = true then m + 1 else m in
    let x = if bias = true then A.concatenate ~axis:1 [| x; A.ones [|l;1|] |] else x in
    (* initialise the matrices according to fan_in/out *)
    let r = 1. /. (float_of_int o) in
    let p = Arr A.(uniform ~a:(float_to_elt (-.r)) ~b:(float_to_elt r) [|o;n|]) in
    (* make the function to minimise *)
    let f w x =
      let w = Mat.reshape o n w in
      Maths.(x *@ w)
    in
    (* get the result, reshape, then return *)
    let w = minimise_weight params f (Maths.flatten p) (Arr x) (Arr y)
      |> snd |> Mat.reshape o n |> unpack_arr
    in
    match bias with
    | true  -> A.split ~axis:0 [|m;1|] w
    | false -> [|w|]


  let ols ?(i=false) x y =
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Quadratic) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 1000.
    in
    _linear_reg i params x y


  let ridge ?(i=false) ?(alpha=0.001) x y =
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Quadratic) ~regularisation:(Regularisation.L2norm alpha) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 1000.
    in
    _linear_reg i params x y


  let lasso ?(i=false) ?(alpha=0.001) x y =
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Quadratic) ~regularisation:(Regularisation.L1norm alpha) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 1000.
    in
    _linear_reg i params x y


  let elastic_net ?(i=false) ?(alpha=1.0) ?(l1_ratio=0.5) x y =
    let a = alpha *. l1_ratio in
    let b = alpha *. (1. -. l1_ratio) /. 2. in
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Quadratic) ~regularisation:(Regularisation.Elastic_net (a, b)) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 1000.
    in
    _linear_reg i params x y


  let svm ?(i=false) ?(a=0.001) x y =
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Hinge) ~regularisation:(Regularisation.L2norm a) ~verbosity:true
      ~stopping:(Stopping.Const 1e-16) 1000.
    in
    _linear_reg i params x y


  let logistic ?(i=false) x y =
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Cross_entropy) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 1000.
    in
    _linear_reg i params x y


  let exponential ?(i=false) x y =
    let a = Owl_stats.std_uniform_rvs () in
    let l = Owl_stats.std_uniform_rvs () in
    let b = Owl_stats.std_uniform_rvs () in

    let f w x =
      let a = Mat.get w 0 0 in
      let l = Mat.get w 0 1 in
      let b = Mat.get w 0 2 in
      Maths.(a * exp (neg l * x) + b)
    in

    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Const 0.1) ~gradient:(Gradient.Newton)
      ~loss:(Loss.Quadratic) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 1000.
    in
    let a, l, b = A.(float_to_elt a, float_to_elt l, float_to_elt b) in
    let w = minimise_weight params f (Mat.of_arrays [|[|a; l; b|]|]) (Arr x) (Arr y)
      |> snd |> unpack_arr
    in
    A.(get w [|0;0|], get w [|0;1|], get w [|0;2|])


  let poly x y n =
    let z = Array.init (n + 1) (fun i -> A.(pow_scalar x (float_of_int i |> float_to_elt))) in
    let x = A.concatenate ~axis:1 z in
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Const 1.) ~gradient:(Gradient.Newton)
      ~loss:(Loss.Quadratic) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 100.
    in
    (_linear_reg false params x y).(0)


end
