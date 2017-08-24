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
    let m = M.col_num x in
    let n = M.col_num y in
    (* initialise the matrices according to fan_in/out *)
    let r = 1. /. (float_of_int m) in
    let p = ref (Mat M.(sub_scalar (uniform ~scale:(2.*.r) m n) r)) in
    let b = ref (Mat M.(sub_scalar (uniform ~scale:(2.*.r) 1 n) r)) in

    (* forward/backward/update without bias *)
    let forward x =
      p := make_reverse !p (tag ());
      let pred = Maths.(x *@ !p) in
      pred, [| [|!p|] |]
    in
    let backward y =
      reverse_prop (F 1.) y;
      let pri_v = [| [|primal !p|] |] in
      let adj_v = [| [|adjval !p|] |] in
      pri_v, adj_v
    in
    let update us = p := us.(0).(0) in
    let save _ = () in

    (* forward/backward/update with bias *)
    let forward_bias x =
      let t = tag () in
      p := make_reverse !p t;
      b := make_reverse !b t;
      let pred = Maths.(x *@ !p + !b) in
      pred, [| [|!p; !b|] |]
    in
    let backward_bias y =
      reverse_prop (F 1.) y;
      let pri_v = [| [|primal !p; primal !b|] |] in
      let adj_v = [| [|adjval !p; adjval !b|] |] in
      pri_v, adj_v
    in
    let update_bias us =
      p := us.(0).(0);
      b := us.(0).(1)
    in

    (* return either [p] or [p, b] depends on [bias] *)
    if bias = true then
      let _ = minimise params forward_bias backward_bias update_bias save (Mat x) (Mat y) in
      [| !p |> primal' |> unpack_mat; !b |> primal' |> unpack_mat |]
    else
      let _ = minimise params forward backward update save (Mat x) (Mat y) in
      [| !p |> primal' |> unpack_mat |]


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
    let a = ref (F (Owl_stats.Rnd.uniform ())) in
    let lambda = ref (F (Owl_stats.Rnd.uniform ())) in
    let b = ref (F (Owl_stats.Rnd.uniform ())) in

    let forward x =
      let t = tag () in
      a := make_reverse !a t;
      lambda := make_reverse !lambda t;
      b := make_reverse !b t;
      let pred = Maths.(!a * exp (neg !lambda * x) + !b) in
      pred, [| [|!a; !lambda; !b|] |]
    in

    let backward y =
      reverse_prop (F 1.) y;
      let pri_v = [| [|primal !a; primal !lambda; primal !b|] |] in
      let adj_v = [| [|adjval !a; adjval !lambda; adjval !b|] |] in
      pri_v, adj_v
    in

    let update us =
      a := us.(0).(0);
      lambda := us.(0).(1);
      b := us.(0).(2)
    in

    let save _ = () in

    let params = Params.config
      ~batch:(Batch.Full) ~learning_rate:(Learning_Rate.Adagrad 1.) ~gradient:(Gradient.GD)
      ~loss:(Loss.Quadratic) ~stopping:(Stopping.Const 1e-16) 100000.
    in
    minimise params forward backward update save (Mat x) (Mat y) |> ignore;
    !a |> primal' |> unpack_flt,
    !lambda |> primal' |> unpack_flt,
    !b |> primal' |> unpack_flt



end
