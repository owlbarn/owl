(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module Make
  (M : MatrixSig)
  (A : NdarraySig with type elt = M.elt and type arr = M.arr)
  = struct

  include Owl_optimise_generic.Make (M) (A)


  (* iterative sovler for linear regression *)
  let _linear_reg bias params x y =
    let l, m = M.shape x in
    let n = M.col_num y in
    let o = if bias = true then m + 1 else m in
    let x = if bias = true then M.concatenate ~axis:1 [|x; M.ones l 1|] else x in
    (* initialise the matrices according to fan_in/out *)
    let r = 1. /. (float_of_int o) in
    let p = Mat M.(sub_scalar (uniform ~scale:(2.*.r) o n) r) in
    (* make the function to minimise *)
    let f w x =
      let w = Mat.reshape o n w in
      Maths.(x *@ w)
    in
    (* get the result, reshape, then return *)
    let w = minimise_weight params f (Maths.flatten p) (Mat x) (Mat y)
      |> snd |> Mat.reshape o n |> unpack_mat
    in
    match bias with
    | true  -> M.split ~axis:0 [|m;1|] w
    | false -> [|w|]


  let ols ?(i=false) x y =
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Quadratic) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 1000.
    in
    _linear_reg i params x y


  let ridge ?(i=false) ?(a=0.001) x y =
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Quadratic) ~regularisation:(Regularisation.L2norm a) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 1000.
    in
    _linear_reg i params x y


  let lasso ?(i=false) ?(a=0.001) x y =
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Quadratic) ~regularisation:(Regularisation.L1norm a) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 1000.
    in
    _linear_reg i params x y


  let svm ?(i=false) ?(a=0.001) x y =
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Hinge) ~regularisation:(Regularisation.L2norm a) ~verbosity:false
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
    let a = Owl_stats.Rnd.uniform () in
    let l = Owl_stats.Rnd.uniform () in
    let b = Owl_stats.Rnd.uniform () in

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
    let w = minimise_weight params f (Mat.of_arrays [|[|a;l;b|]|]) (Mat x) (Mat y)
      |> snd |> unpack_mat
    in
    M.(get w 0 0, get w 0 1, get w 0 2)


  let poly x y n =
    let z = Array.init (n + 1) (fun i -> M.(pow_scalar x (float_of_int i))) in
    let x = M.concatenate ~axis:1 z in
    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Const 1.) ~gradient:(Gradient.Newton)
      ~loss:(Loss.Quadratic) ~verbosity:false
      ~stopping:(Stopping.Const 1e-16) 100.
    in
    (_linear_reg false params x y).(0)


end
