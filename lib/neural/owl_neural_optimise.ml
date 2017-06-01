(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff.S


(* This module contains the helper fucntions used by other sub-modules. They are
  useful but not general enough to be included in Algodiff.[S|D].Maths module. *)
module Utils = struct

  let draw_samples x y n =
    match x, y with
    | Arr x, Mat y -> (
        let x, i = Owl_dense_ndarray_generic.draw_along_dim0 x n in
        let y = Owl_dense_matrix_generic.rows y i in
        Arr x, Mat y
      )
    | Mat x, Mat y -> let x, y, _ = Owl_dense_matrix_generic.draw_rows2 ~replacement:false x y n in Mat x, Mat y
    | x, y         -> failwith ("Owl_neural_optimise.Utils.draw_samples:" ^ (type_info x))

  let sample_num x =
    match x with
    | Arr _ -> Arr.(shape x).(0)
    | Mat _ -> Mat.row_num x
    | x     -> failwith ("Owl_neural_optimise.Utils.sample_num:" ^ (type_info x))

end


module Learning_Rate = struct

  type typ =
    | Adagrad   of float
    | Const     of float
    | Decay     of float * float
    | Exp_decay of float * float
    | RMSprop   of float * float
    | Schedule  of float array

  let run = function
    | Adagrad a        -> fun _ g c -> Maths.(F a / sqrt (c + F 1e-8))
    | Const a          -> fun _ _ _ -> F a
    | Decay (a, k)     -> fun i _ _ -> Maths.(F a / (F 1. + F k * (F (float_of_int i))))
    | Exp_decay (a, k) -> fun i _ _ -> Maths.(F a * exp (neg (F k) * (F (float_of_int i))))
    | RMSprop (a, k)   -> fun _ g c -> Maths.(F a / sqrt (c + F 1e-6))
    | Schedule a       -> fun i _ _ -> F a.(i mod (Array.length a))

  let default = function
    | Adagrad _   -> Adagrad 0.01
    | Const _     -> Const 0.001
    | Decay _     -> Decay (0.1, 0.1)
    | Exp_decay _ -> Exp_decay (1., 0.1)
    | RMSprop _   -> RMSprop (0.001, 0.9)
    | Schedule _  -> Schedule [|0.001|]

  let update_ch typ gs ch = match typ with
    | Adagrad _      -> Owl_utils.aarr_map2 (fun g c -> Maths.(c + g * g)) gs ch
    | RMSprop (a, k) -> Owl_utils.aarr_map2 (fun g c -> Maths.((F k * c) + (F 1. - F k) * g * g)) gs ch
    | _              -> ch

  let to_string = function
    | Adagrad a        -> Printf.sprintf "adagrad %g" a
    | Const a          -> Printf.sprintf "constant %g" a
    | Decay (a, k)     -> Printf.sprintf "decay (%g, %g)" a k
    | Exp_decay (a, k) -> Printf.sprintf "exp_decay (%g, %g)" a k
    | RMSprop (a, k)   -> Printf.sprintf "rmsprop (%g, %g)" a k
    | Schedule a       -> Printf.sprintf "schedule %i" (Array.length a)

end


module Batch = struct

  type typ =
    | Full
    | Mini of int
    | Stochastic

  let run typ x y = match typ with
    | Full       -> x, y
    | Mini c     -> Utils.draw_samples x y c
    | Stochastic -> Utils.draw_samples x y 1

  let batches typ x = match typ with
    | Full       -> 1
    | Mini c     -> Utils.sample_num x / c
    | Stochastic -> Utils.sample_num x

  let to_string = function
    | Full       -> "full"
    | Mini c     -> Printf.sprintf "mini of %i" c
    | Stochastic -> "stochastic"

end


module Loss = struct

  type typ =
    | L1norm
    | L2norm
    | Quadratic
    | Cross_entropy
    | Custom of (t -> t -> t)

  let run typ y y' = match typ with
    | L1norm        -> Maths.(l1norm (y - y'))
    | L2norm        -> Maths.(l2norm (y - y'))
    | Quadratic     -> Maths.(l2norm_sqr (y - y'))
    | Cross_entropy -> Maths.(cross_entropy y y')
    | Custom f      -> f y y' (* y': prediction *)

  let to_string = function
    | L1norm        -> "l1norm"
    | L2norm        -> "l2norm"
    | Quadratic     -> "quadratic"
    | Cross_entropy -> "cross_entropy"
    | Custom _      -> "customise"

end


module Gradient = struct

  type typ =
    | GD           (* classic gradient descendent *)
    | CG           (* Hestenes and Stiefel 1952 *)
    | CD           (* Fletcher 1987 *)
    | NonlinearCG  (* Fletcher and Reeves 1964 *)
    | DaiYuanCG    (* Dai and Yuan 1999 *)
    | NewtonCG     (* Newton conjugate gradient *)
    | Newton       (* Exact Newton *)

  let run = function
    | GD          -> fun _ _ _ g' -> Maths.neg g'
    | CG          -> fun _ g p g' -> (
        let y = Maths.(g' - g) in
        let b = Maths.((g' *@ y) / (p *@ y)) in
        Maths.(neg g' + (b *@ p))
      )
    | CD          -> fun _ g p g' -> (
        let b = Maths.(l2norm_sqr g' / (neg p *@ g)) in
        Maths.(neg g' + (b *@ p))
      )
    | NonlinearCG -> fun _ g p g' -> (
        let b = Maths.((l2norm_sqr g') / (l2norm_sqr g)) in
        Maths.(neg g' + (b *@ p))
      )
    | DaiYuanCG   -> fun w g p g' -> (
        let y = Maths.(g' - g) in
        let b = Maths.((l2norm_sqr g') / (p *@ y)) in
        Maths.(neg g' + (b *@ p))
      )
    | NewtonCG    -> fun w g p g' -> failwith "not implemented" (* TODO *)
    | Newton      -> fun w g p g' -> failwith "not implemented" (* TODO *)

  let to_string = function
    | GD          -> "gradient descendent"
    | CG          -> "conjugate gradient"
    | CD          -> "conjugate descendent"
    | NonlinearCG -> "nonlinear conjugate gradient"
    | DaiYuanCG   -> "dai & yuan conjugate gradient"
    | NewtonCG    -> "newton conjugate gradient"
    | Newton      -> "newtown"

end


module Momentum = struct

  type typ =
    | Standard of float
    | Nesterov of float
    | None

  let run = function
    | Standard m -> fun u u' -> Maths.(F m * u + u')
    | Nesterov m -> fun u u' -> Maths.((F m * F m * u) + (F m + F 1.) * u')
    | None       -> fun _ u' -> u'

  let default = function
    | Standard _ -> Standard 0.9
    | Nesterov _ -> Nesterov 0.9
    | None       -> None

  let to_string = function
    | Standard m -> Printf.sprintf "standard %g" m
    | Nesterov m -> Printf.sprintf "nesterov %g" m
    | None       -> Printf.sprintf "none"

end


module Regularisation = struct

  type typ =
    | L1norm      of float
    | L2norm      of float
    | Elastic_net of float * float
    | None

  let run typ x = match typ with
    | L1norm a           -> Maths.(F a * l1norm x)
    | L2norm a           -> Maths.(F a * l2norm x)
    | Elastic_net (a, b) -> Maths.(F a * l1norm x + F b * l2norm x)
    | None               -> F 0.

  let to_string = function
    | L1norm a           -> Printf.sprintf "l1norm (alpha = %g)" a
    | L2norm a           -> Printf.sprintf "l2norm (alhpa = %g)" a
    | Elastic_net (a, b) -> Printf.sprintf "elastic net (a = %g, b = %g)" a b
    | None               -> "none"

end


module Clipping = struct

  type typ =
    | L2norm of float
    | Value  of float * float  (* min, max *)
    | None

  let run typ x = match typ with
    | L2norm t     -> clip_by_l2norm t x
    | Value (a, b) -> failwith "not implemented"  (* TODO *)
    | None         -> x

  let default = function
    | L2norm _ -> L2norm 1.
    | Value _  -> Value (0., 1.)
    | None     -> None

  let to_string = function
    | L2norm t     -> Printf.sprintf "l2norm (threshold = %g)" t
    | Value (a, b) -> Printf.sprintf "value (min = %g, max = %g)" a b
    | None         -> "none"

end


module Stopping = struct

  type typ =
    | Early of int * int (* stagnation patience, overfitting patience *)
    | None

  let run = function
    | Early (s, o) -> failwith "not implemented"   (* TODO *)
    | None         -> false

  let default = function
    | Early _ -> Early (750, 10)
    | None    -> None

  let to_string = function
    | Early (s, o) -> Printf.sprintf "early (s = %i, o = %i)" s o
    | None         -> "none"

end


module Params = struct

  type typ = {
    mutable epochs          : int;
    mutable batch           : Batch.typ;
    mutable gradient        : Gradient.typ;
    mutable loss            : Loss.typ;
    mutable learning_rate   : Learning_Rate.typ;
    mutable regularisation  : Regularisation.typ;
    mutable momentum        : Momentum.typ;
    mutable clipping        : Clipping.typ;
    mutable verbosity       : bool;
  }

  let default () = {
    epochs         = 1;
    batch          = Batch.Mini 100;
    gradient       = Gradient.GD;
    loss           = Loss.Cross_entropy;
    learning_rate  = Learning_Rate.(default (Const 0.));
    regularisation = Regularisation.None;
    momentum       = Momentum.None;
    clipping       = Clipping.None;
    verbosity      = true;
  }

  let config ?batch ?gradient ?loss ?learning_rate ?regularisation ?momentum ?clipping ?verbosity epochs =
    let p = default () in
    (match batch with Some x -> p.batch <- x | None -> ());
    (match gradient with Some x -> p.gradient <- x | None -> ());
    (match loss with Some x -> p.loss <- x | None -> ());
    (match learning_rate with Some x -> p.learning_rate <- x | None -> ());
    (match regularisation with Some x -> p.regularisation <- x | None -> ());
    (match momentum with Some x -> p.momentum <- x | None -> ());
    (match clipping with Some x -> p.clipping <- x | None -> ());
    (match verbosity with Some x -> p.verbosity <- x | None -> ());
    p.epochs <- epochs; p

  let to_string p =
    Printf.sprintf "--- Training config\n" ^
    Printf.sprintf "    epochs         : %i\n" (p.epochs) ^
    Printf.sprintf "    batch          : %s\n" (Batch.to_string p.batch) ^
    Printf.sprintf "    method         : %s\n" (Gradient.to_string p.gradient) ^
    Printf.sprintf "    loss           : %s\n" (Loss.to_string p.loss) ^
    Printf.sprintf "    learning rate  : %s\n" (Learning_Rate.to_string p.learning_rate) ^
    Printf.sprintf "    regularisation : %s\n" (Regularisation.to_string p.regularisation) ^
    Printf.sprintf "    momentum       : %s\n" (Momentum.to_string p.momentum) ^
    Printf.sprintf "    clipping       : %s\n" (Clipping.to_string p.clipping) ^
    Printf.sprintf "    verbosity      : %s\n" (if p.verbosity then "true" else "false") ^
    "---"

end


(* helper functions *)

let _print_info e_i e_n b_i b_n l l' =
  let l, l' = unpack_flt l, unpack_flt l' in
  let d = l -. l' in
  let s = if d = 0. then "-" else if d < 0. then "▲" else "▼" in
  Log.info "%i/%i | B: %i/%i | L: %g[%s]"
  e_i e_n b_i b_n l' s

let _print_summary t = Printf.printf "--- Training summary\n    Duration: %g s\n" t


(* core training functions for feedforward networks *)

let train_nn params forward backward update x y =
  let open Params in
  if params.verbosity = true then
    print_endline (Params.to_string params);

  (* make alias functions *)
  let batch    = Batch.run params.batch in
  let loss_fun = Loss.run params.loss in
  let grad_fun = Gradient.run params.gradient in
  let rate_fun = Learning_Rate.run params.learning_rate in
  let regl_fun = Regularisation.run params.regularisation in
  let momt_fun = Momentum.run params.momentum in
  let upch_fun = Learning_Rate.update_ch params.learning_rate in
  let clip_fun = Clipping.run params.clipping in

  (* operations in one iteration *)
  let iterate () =
    let xt, yt = batch x y in
    let yt', ws = forward xt in
    let loss = Maths.(loss_fun yt yt') in
    (* DEBUG
    Printf.printf "===> %g \n" (unpack_flt loss);
    Owl_dense_matrix_generic.print (unpack_mat yt);
    Owl_dense_matrix_generic.print (unpack_mat yt');
    flush_all ();
    exit 0; *)
    (* take the average of the loss *)
    let loss = Maths.(loss / (F (Mat.row_num yt |> float_of_int))) in
    (* add regularisation term if necessary *)
    let reg = match params.regularisation <> Regularisation.None with
      | true  -> Owl_utils.aarr_fold (fun a w -> Maths.(a + regl_fun w)) (F 0.) ws
      | false -> F 0.
    in
    let loss = Maths.(loss + reg) in
    let ws, gs' = backward loss in
    loss |> primal', ws, gs'
  in

  (* first iteration to bootstrap the training *)
  let t0 = Unix.time () in
  let _loss, _ws, _gs = iterate () in
  update _ws;

  (* variables used for specific modules *)
  let gs = ref _gs in
  let ps = ref (Owl_utils.aarr_map Maths.neg _gs) in
  let us = ref (Owl_utils.aarr_map (fun _ -> F 0.) _gs) in
  let ch = ref (Owl_utils.aarr_map (fun a -> F 0.) _gs) in

  (* variables used in training process *)
  let batches = Batch.batches params.batch x in
  let loss = ref (Array.make (params.epochs * batches + 1) (F 0.)) in
  let idx = ref 1 in
  !loss.(0) <- _loss;

  (* iterate all batches in each epoch *)
  for i = 1 to params.epochs do
    for j = 1 to batches do
      let loss', ws, gs' = iterate () in
      (* print out the current state of training *)
      if params.verbosity = true then
        _print_info i params.epochs j batches !loss.(!idx - 1) loss';
      (* calculate gradient updates *)
      let ps' = Owl_utils.aarr_map2i (
        fun k l w g' ->
          let g, p = !gs.(k).(l), !ps.(k).(l) in
          (* clip the gradient if necessary *)
          let g' = clip_fun g' in
          (* calculate the descendent *)
          grad_fun w g p g'
        ) ws gs' in
      (* update gcache if necessary *)
      ch := upch_fun gs' !ch;
      (* adjust direction based on learning_rate *)
      let us' = Owl_utils.aarr_map3 (fun p' g' c ->
        Maths.(p' * rate_fun i g' c)
      ) ps' gs' !ch in
      (* adjust direction based on momentum *)
      let us' = match params.momentum <> Momentum.None with
        | true  -> Owl_utils.aarr_map2 momt_fun !us us'
        | false -> us'
      in
      (* update the weight *)
      let ws' = Owl_utils.aarr_map2 (fun w u -> Maths.(w + u)) ws us' in
      update ws';
      (* save historical data *)
      if params.momentum <> Momentum.None then us := us';
      gs := gs';
      ps := ps';
      !loss.(!idx) <- loss';
      idx := !idx + 1;
    done
  done;

  (* print training summary *)
  if params.verbosity = true then
    _print_summary (Unix.time () -. t0);
  (* return loss history *)
  Array.map unpack_flt !loss


(* generic training functions for both feedforward and graph module
  init: function to initialise the weights in the network
  forward: fucntion to run the forward pass
  backward: function to run the backward pass
  update: function to update the weights according to the gradient
 *)
let train_nn_generic ?params init forward backward update nn x y =
  init nn;
  let f = forward nn in
  let b = backward nn in
  let u = update nn in
  let p = match params with
    | Some p -> p
    | None   -> Params.default ()
  in
  train_nn p f b u x y


(* generic function to test the neural network, for both feedforward and graph
  f : the passed in function applies to every x
  forward: fucntion to run the forward pass
  TODO :
 *)
let test_nn_generic f forward nn x y =
  match x, y with
  | Mat _, Mat _ -> (
      Mat.iter2_rows (fun u v ->
        forward u nn |> unpack_mat |> f
      ) x y
    )
  | Arr _, Mat _ -> (
      failwith "not implemented yet"
    )
  | _, _         -> failwith "Owl_neural_optimise:test_nn_generic"



(* ends here *)
