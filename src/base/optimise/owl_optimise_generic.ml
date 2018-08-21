(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(**
Optimisation engine

This module provides fundamental supports for Owl's regression and neural
network module. The module supports both single and double precision float
numbers.
 *)

[@@@warning "-45"]

(* Make functor starts *)

module Make
  (Algodiff : Owl_algodiff_generic_sig.Sig)
  = struct

  module Algodiff = Algodiff

  open Algodiff


  module Utils = struct

    let sample_num x =
      match x with
      | Arr _ -> Arr.(shape x).(0)
      | x     -> failwith ("Owl_optimise.Utils.sample_num:" ^ (type_info x))

    let draw_samples x y n =
      match x, y with
      | Arr x, Arr y -> (
          let x, i = A.draw ~axis:0 x n in
          let y = A.rows y i in
          Arr x, Arr y
        )
      | x, _         -> failwith ("Owl_optimise.Utils.draw_samples:" ^ (type_info x))

    let get_chunk x y i c =
      match x, y with
      | Arr x, Arr y -> (
          let n = A.row_num y in
          let a = (i * c) mod n in
          let b = a + c - 1 in
          if b < n then (
            let x = A.get_slice [[a;b]] x in
            let y = A.get_slice [[a;b]] y in
            Arr x, Arr y
          )
          else (
            let x0 = A.get_slice [[a;n-1]] x in
            let y0 = A.get_slice [[a;n-1]] y in
            let x1 = A.get_slice [[0;b-n]] x in
            let y1 = A.get_slice [[0;b-n]] y in
            let x = A.concatenate ~axis:0 [|x0; x1|] in
            let y = A.concatenate ~axis:0 [|y0; y1|] in
            Arr x, Arr y
          )
        )
      | x, _         -> failwith ("Owl_optimise.Utils.get_chunk:" ^ (type_info x))

  end


  module Learning_Rate = struct

    type typ =
      | Adagrad   of float
      | Const     of float
      | Decay     of float * float
      | Exp_decay of float * float
      | RMSprop   of float * float
      | Adam      of float * float * float
      | Schedule  of float array

    let run = function
      | Adagrad a        -> fun _ _ c -> Maths.(_f a / sqrt (c.(0) + _f 1e-32))
      | Const a          -> fun _ _ _ -> _f a
      | Decay (a, k)     -> fun i _ _ -> Maths.(_f a / (_f 1. + _f k * (_f (float_of_int i))))
      | Exp_decay (a, k) -> fun i _ _ -> Maths.(_f a * exp (neg (_f k) * (_f (float_of_int i))))
      | RMSprop (a, _)   -> fun _ _ c -> Maths.(_f a / sqrt (c.(0) + _f 1e-32))
      | Adam (a, b1, b2) -> fun i g c -> Maths.(_f a *
          (sqrt (_f 1. - _f b2 ** _f (float_of_int i))) /
          (_f 1. - _f b1 ** _f (float_of_int i)) *
          c.(0) / (sqrt c.(1) + _f 1e-8) /
          (g + _f 1e-32))
      | Schedule a       -> fun i _ _ -> _f a.(i mod (Array.length a))

    let default = function
      | Adagrad _   -> Adagrad 0.01
      | Const _     -> Const 0.001
      | Decay _     -> Decay (0.1, 0.1)
      | Exp_decay _ -> Exp_decay (1., 0.1)
      | RMSprop _   -> RMSprop (0.001, 0.9)
      | Adam _      -> Adam (0.001, 0.9, 0.999)
      | Schedule _  -> Schedule [|0.001|]

    let update_ch typ g c = match typ with
      | Adagrad _        -> [|Maths.(c.(0) + g * g); c.(1)|]
      | RMSprop (_, k)   -> [|Maths.((_f k * c.(0)) + (_f 1. - _f k) * g * g); c.(1)|]
      | Adam (_, b1, b2) ->
          let m = Maths.(_f b1 * c.(0) + (_f 1. - _f b1) * g) in
          let v = Maths.(_f b2 * c.(1) + (_f 1. - _f b2) * g * g) in
          [|m; v|]
      | _                -> c

    let to_string = function
      | Adagrad a        -> Printf.sprintf "adagrad %g" a
      | Const a          -> Printf.sprintf "constant %g" a
      | Decay (a, k)     -> Printf.sprintf "decay (%g, %g)" a k
      | Exp_decay (a, k) -> Printf.sprintf "exp_decay (%g, %g)" a k
      | RMSprop (a, k)   -> Printf.sprintf "rmsprop (%g, %g)" a k
      | Adam (a, b1, b2) -> Printf.sprintf "adam (%g, %g, %g)" a b1 b2
      | Schedule a       -> Printf.sprintf "schedule %i" (Array.length a)

  end


  module Batch = struct

    type typ =
      | Full
      | Mini       of int
      | Sample     of int
      | Stochastic

    let run typ x y i = match typ with
      | Full       -> x, y
      | Mini c     -> Utils.get_chunk x y i c
      | Sample c   -> Utils.draw_samples x y c
      | Stochastic -> Utils.draw_samples x y 1

    let batches typ x = match typ with
      | Full       -> 1
      | Mini c     -> Utils.sample_num x / c
      | Sample c   -> Utils.sample_num x / c
      | Stochastic -> Utils.sample_num x

    let to_string = function
      | Full       -> Printf.sprintf "%s" "full"
      | Mini c     -> Printf.sprintf "mini of %i" c
      | Sample c   -> Printf.sprintf "sample of %i" c
      | Stochastic -> Printf.sprintf "%s" "stochastic"

  end


  module Loss = struct

    type typ =
      | Hinge
      | L1norm
      | L2norm
      | Quadratic
      | Cross_entropy
      | Custom of (t -> t -> t)

    let run typ y y' = match typ with
      | Hinge         -> Maths.(sum' (max2 (_f 0.) (_f 1. - y * y')))
      | L1norm        -> Maths.(l1norm' (y - y'))
      | L2norm        -> Maths.(l2norm' (y - y'))
      | Quadratic     -> Maths.(l2norm_sqr' (y - y'))
      | Cross_entropy -> Maths.(cross_entropy y y')
      | Custom f      -> f y y' (* y': prediction *)

    let to_string = function
      | Hinge         -> "Hinge"
      | L1norm        -> "l1norm"
      | L2norm        -> "l2norm"
      | Quadratic     -> "quadratic"
      | Cross_entropy -> "cross_entropy"
      | Custom _      -> "customise"

  end


  module Gradient = struct

    type typ =
      | GD           (* classic gradient descent *)
      | CG           (* Hestenes and Stiefel 1952 *)
      | CD           (* Fletcher 1987 *)
      | NonlinearCG  (* Fletcher and Reeves 1964 *)
      | DaiYuanCG    (* Dai and Yuan 1999 *)
      | NewtonCG     (* Newton conjugate gradient *)
      | Newton       (* Exact Newton *)

    let run = function
      | GD          -> fun _ _ _ _ g' -> Maths.neg g'
      | CG          -> fun _ _ g p g' -> (
          let y = Maths.(g' - g) in
          let b = Maths.((sum' (g' * y)) / ((sum' (p * y)) + _f 1e-32)) in
          Maths.((neg g') + (b * p))
        )
      | CD          -> fun _ _ g p g' -> (
          let b = Maths.((l2norm_sqr' g') / (sum' (neg p * g))) in
          Maths.((neg g') + (b * p))
        )
      | NonlinearCG -> fun _ _ g p g' -> (
          let b = Maths.((l2norm_sqr' g') / (l2norm_sqr' g)) in
          Maths.((neg g') + (b * p))
        )
      | DaiYuanCG   -> fun _ _ g p g' -> (
          let y = Maths.(g' - g) in
          let b = Maths.((l2norm_sqr' g') / (sum' (p * y))) in
          Maths.((neg g') + (b * p))
        )
      | NewtonCG    -> fun f w _ p g' -> (
          (* TODO: NOT FINISHED *)
          let hv = hessianv f w p |> Maths.transpose in
          let b = Maths.((hv *@ g') / (hv *@ p)) in
          Maths.((neg g') + p *@ b)
        )
      | Newton      -> fun f w _ _ _  -> (
          let g', h' = gradhessian f w in
          Maths.(neg (g' *@ (inv h')))
        )

    let to_string = function
      | GD          -> "gradient descent"
      | CG          -> "conjugate gradient"
      | CD          -> "conjugate descent"
      | NonlinearCG -> "nonlinear conjugate gradient"
      | DaiYuanCG   -> "dai & yuan conjugate gradient"
      | NewtonCG    -> "newton conjugate gradient"
      | Newton      -> "newton"

  end


  module Momentum = struct

    type typ =
      | Standard of float
      | Nesterov of float
      | None

    let run = function
      | Standard m -> fun u u' -> Maths.(_f m * u + u')
      | Nesterov m -> fun u u' -> Maths.((_f m * _f m * u) + (_f m + _f 1.) * u')
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
      | L1norm a           -> Maths.(_f a * l1norm' x)
      | L2norm a           -> Maths.(_f a * l2norm' x)
      | Elastic_net (a, b) -> Maths.(_f a * l1norm' x + _f b * l2norm' x)
      | None               -> _f 0.

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
      | L2norm t     -> clip_by_l2norm (A.float_to_elt t) x
      | Value (a, b) -> clip_by_value ~amin:(A.float_to_elt a) ~amax:(A.float_to_elt b) x
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
      | Const of float
      | Early of int * int (* stagnation patience, overfitting patience *)
      | None

    let run typ x = match typ with
      | Const a      -> x < a
      | Early (_, _) -> failwith "not implemented"   (* TODO *)
      | None         -> false

    let default = function
      | Const _ -> Const 1e-6
      | Early _ -> Early (750, 10)
      | None    -> None

    let to_string = function
      | Const a      -> Printf.sprintf "const (a = %g)" a
      | Early (s, o) -> Printf.sprintf "early (s = %i, o = %i)" s o
      | None         -> "none"

  end


  module Checkpoint = struct

    type state = {
      mutable current_batch     : int;                 (* current iteration progress in batch *)
      mutable batches_per_epoch : int;                 (* number of batches in each epoch *)
      mutable epochs            : float;               (* total number of epochs to run *)
      mutable batches           : int;                 (* total batches = batches_per_epoch * epochs *)
      mutable loss              : t array;             (* history of loss value in each iteration *)
      mutable start_at          : float;               (* time when the optimisation starts *)
      mutable stop              : bool;                (* optimisation stops if true, otherwise false *)
      mutable gs                : t array array;       (* gradient of the the previous iteration *)
      mutable ps                : t array array;       (* direction of the the prevoius iteration *)
      mutable us                : t array array;       (* direction update of the previous iteration *)
      mutable ch                : t array array array; (* gcache of the prevoius iteration *)
    }

    type typ =
      | Batch  of int             (* default checkpoint at every specified batch interval *)
      | Epoch  of float           (* default checkpoint at every specified epoch interval *)
      | Custom of (state -> unit) (* customised checkpoint called at every batch *)
      | None                      (* no checkpoint at all, or interval is infinity *)

    let init_state batches_per_epoch epochs =
      let batches = (float_of_int batches_per_epoch) *. epochs |> int_of_float in
      {
        current_batch     = 1;
        batches_per_epoch = batches_per_epoch;
        epochs            = epochs;
        batches           = batches;
        loss              = Array.make (batches + 1) (_f 0.);
        start_at          = Unix.gettimeofday ();
        stop              = false;
        gs                = [| [| _f 0. |] |];
        ps                = [| [| _f 0. |] |];
        us                = [| [| _f 0. |] |];
        ch                = [| [| [| _f 0.; _f 0.|] |] |];
      }

    let default_checkpoint_fun save_fun =
      let file_name = Printf.sprintf "%s/%s.%i"
        (Sys.getcwd ()) "model" (Unix.time () |> int_of_float)
      in
      Owl_log.info "checkpoint => %s" file_name;
      save_fun file_name

    let print_state_info state =
      let b_i = state.current_batch in
      let b_n = state.batches in
      let e_n = state.epochs in
      let e_i = (float_of_int b_i) /. ((float_of_int b_n) /. e_n) in
      let l0 = state.loss.(b_i - 1) |> unpack_flt in
      let l1 = state.loss.(b_i) |> unpack_flt in
      let d = l0 -. l1 in
      let s = if d = 0. then "-" else if d < 0. then "▲" else "▼" in
      let t = (Unix.gettimeofday () -. state.start_at) |> Owl_utils.format_time in
      Owl_log.info "T: %s | E: %.1f/%g | B: %i/%i | L: %.6f[%s]"
        t e_i e_n b_i b_n l1 s

    let print_summary state =
      (Unix.gettimeofday () -. state.start_at)
      |> Owl_utils.format_time
      |> Printf.printf "--- Training summary\n    Duration: %s\n"
      |> flush_all

    let run typ save_fun current_batch current_loss state =
      state.loss.(current_batch) <- (primal' current_loss);
      state.stop <- (state.current_batch >= state.batches);
      let interval = match typ with
        | Batch i  -> i
        | Epoch i  -> i *. (float_of_int state.batches_per_epoch) |> int_of_float
        | Custom _ -> 1
        | None     -> max_int
      in
      if (state.current_batch mod interval = 0) && (state.current_batch < state.batches) then
        match typ with
        | Custom f -> f state
        | _        -> default_checkpoint_fun save_fun

    let to_string = function
      | Batch i  -> Printf.sprintf "per %i batches" i
      | Epoch i  -> Printf.sprintf "per %g epochs" i
      | Custom _ -> Printf.sprintf "customised f"
      | None     -> Printf.sprintf "none"

  end


  module Params = struct

    type typ = {
      mutable epochs         : float;
      mutable batch          : Batch.typ;
      mutable gradient       : Gradient.typ;
      mutable loss           : Loss.typ;
      mutable learning_rate  : Learning_Rate.typ;
      mutable regularisation : Regularisation.typ;
      mutable momentum       : Momentum.typ;
      mutable clipping       : Clipping.typ;
      mutable stopping       : Stopping.typ;
      mutable checkpoint     : Checkpoint.typ;
      mutable verbosity      : bool;
    }

    let default () = {
      epochs         = 1.;
      batch          = Batch.Sample 100;
      gradient       = Gradient.GD;
      loss           = Loss.Cross_entropy;
      learning_rate  = Learning_Rate.(default (Const 0.));
      regularisation = Regularisation.None;
      momentum       = Momentum.None;
      clipping       = Clipping.None;
      stopping       = Stopping.None;
      checkpoint     = Checkpoint.None;
      verbosity      = true;
    }

    let config
      ?batch ?gradient ?loss ?learning_rate ?regularisation ?momentum ?clipping
      ?stopping ?checkpoint ?verbosity epochs
      =
      let p = default () in
      (match batch with Some x -> p.batch <- x | None -> ());
      (match gradient with Some x -> p.gradient <- x | None -> ());
      (match loss with Some x -> p.loss <- x | None -> ());
      (match learning_rate with Some x -> p.learning_rate <- x | None -> ());
      (match regularisation with Some x -> p.regularisation <- x | None -> ());
      (match momentum with Some x -> p.momentum <- x | None -> ());
      (match clipping with Some x -> p.clipping <- x | None -> ());
      (match stopping with Some x -> p.stopping <- x | None -> ());
      (match checkpoint with Some x -> p.checkpoint <- x | None -> ());
      (match verbosity with Some x -> p.verbosity <- x | None -> ());
      p.epochs <- epochs; p

    let to_string p =
      Printf.sprintf "--- Training config\n" ^
      Printf.sprintf "    epochs         : %g\n" (p.epochs) ^
      Printf.sprintf "    batch          : %s\n" (Batch.to_string p.batch) ^
      Printf.sprintf "    method         : %s\n" (Gradient.to_string p.gradient) ^
      Printf.sprintf "    loss           : %s\n" (Loss.to_string p.loss) ^
      Printf.sprintf "    learning rate  : %s\n" (Learning_Rate.to_string p.learning_rate) ^
      Printf.sprintf "    regularisation : %s\n" (Regularisation.to_string p.regularisation) ^
      Printf.sprintf "    momentum       : %s\n" (Momentum.to_string p.momentum) ^
      Printf.sprintf "    clipping       : %s\n" (Clipping.to_string p.clipping) ^
      Printf.sprintf "    stopping       : %s\n" (Stopping.to_string p.stopping) ^
      Printf.sprintf "    checkpoint     : %s\n" (Checkpoint.to_string p.checkpoint) ^
      Printf.sprintf "    verbosity      : %s\n" (if p.verbosity then "true" else "false") ^
      "---"

  end


  (* core optimisation functions *)

  (* This function minimises the weight [w] of passed-in function [f].
     [f] is a function [f : w -> x -> y].
     [w] is a row vector but [y] can have any shape.
   *)
  let minimise_weight ?state params f w x y =
    let open Params in
    if params.verbosity = true && state = None then
      print_endline (Params.to_string params);

    (* make alias functions *)
    let bach_fun = Batch.run params.batch in
    let loss_fun = Loss.run params.loss in
    let grad_fun = Gradient.run params.gradient in
    let rate_fun = Learning_Rate.run params.learning_rate in
    let regl_fun = Regularisation.run params.regularisation in
    let momt_fun = Momentum.run params.momentum in
    let upch_fun = Learning_Rate.update_ch params.learning_rate in
    let clip_fun = Clipping.run params.clipping in
    let stop_fun = Stopping.run params.stopping in
    let chkp_fun = Checkpoint.run params.checkpoint in

    (* make the function to minimise *)
    let optz_fun xi yi wi = Maths.((loss_fun yi (f wi xi)) + (regl_fun wi)) in

    (* operations in the ith iteration *)
    let iterate i w =
      let xi, yi = bach_fun x y i in
      let optz = (optz_fun xi yi) in
      let loss, g = grad' optz w in
      loss |> primal', g, optz
    in

    (* init new or continue previous state of optimisation process *)
    let state = match state with
      | Some state -> state
      | None       -> (
          let batches_per_epoch = Batch.batches params.batch x in
          let state = Checkpoint.init_state batches_per_epoch params.epochs in
          (* first iteration to bootstrap the optimisation *)
          let loss, _g0, _ = iterate 0 w in
          (* variables used for specific gradient method *)
          Checkpoint.(state.gs <- [| [|_g0|] |]);
          Checkpoint.(state.ps <- [| [|Maths.(neg _g0)|] |]);
          Checkpoint.(state.us <- [| [|_f 0.|] |]);
          Checkpoint.(state.ch <- [| [| [|_f 0.; _f 0.|] |] |]);
          Checkpoint.(state.loss.(0) <- primal' loss);
          state
        )
    in

    (* try to iterate all batches *)
    let w = ref w in
    while Checkpoint.(state.stop = false) do
      let loss', g', optz' = iterate Checkpoint.(state.current_batch) !w in
      (* check if the stopping criterion is met *)
      Checkpoint.(state.stop <- stop_fun (unpack_flt loss'));
      (* checkpoint of the optimisation if necessary *)
      chkp_fun (fun _ -> ()) Checkpoint.(state.current_batch) loss' state;
      (* print out the current state of optimisation *)
      if params.verbosity = true then Checkpoint.print_state_info state;
      (* clip the gradient if necessary *)
      let g' = clip_fun g' in
      (* calculate gradient descent *)
      let p' = Checkpoint.(grad_fun optz' !w state.gs.(0).(0) state.ps.(0).(0) g') in
      (* update gcache if necessary *)
      Checkpoint.(state.ch.(0).(0) <- upch_fun g' state.ch.(0).(0));
      (* adjust direction based on learning_rate *)
      let u' = Checkpoint.(Maths.(p' * rate_fun state.current_batch g' state.ch.(0).(0))) in
      (* adjust direction based on momentum *)
      let u' = momt_fun Checkpoint.(state.us.(0).(0)) u' in
      (* update the weight *)
      w := Maths.(!w + u') |> primal';
      (* save historical data *)
      if params.momentum <> Momentum.None then Checkpoint.(state.us.(0).(0) <- u');
      Checkpoint.(state.gs.(0).(0) <- g');
      Checkpoint.(state.ps.(0).(0) <- p');
      Checkpoint.(state.current_batch <- state.current_batch + 1);
      (* force GC to release bigarray memory *)
      Gc.minor ();
    done;

    (* print optimisation summary *)
    if params.verbosity = true && Checkpoint.(state.current_batch >= state.batches) then
      Checkpoint.print_summary state;
    (* return both loss history and weight *)
    state, !w


  (* This function is specifically designed for minimising the weights in a
     neural network of graph structure. In Owl's earlier versions, the functions
     in the regression module were actually implemented using this function.
   *)
  let minimise_network ?state params forward backward update save x y =
    let open Params in
    if params.verbosity = true && state = None then
      print_endline (Params.to_string params);

    (* make alias functions *)
    let bach_fun = Batch.run params.batch in
    let loss_fun = Loss.run params.loss in
    let grad_fun = Gradient.run params.gradient in
    let rate_fun = Learning_Rate.run params.learning_rate in
    let regl_fun = Regularisation.run params.regularisation in
    let momt_fun = Momentum.run params.momentum in
    let upch_fun = Learning_Rate.update_ch params.learning_rate in
    let clip_fun = Clipping.run params.clipping in
    let stop_fun = Stopping.run params.stopping in
    let chkp_fun = Checkpoint.run params.checkpoint in

    (* operations in the ith iteration *)
    let iterate i =
      let xt, yt = bach_fun x y i in
      let yt', ws = forward xt in
      let loss = loss_fun yt yt' in
      (* take the mean of the loss *)
      let loss = Maths.(loss / (_f (Mat.row_num yt |> float_of_int))) in
      (* add regularisation term if necessary *)
      let reg = match params.regularisation <> Regularisation.None with
        | true  -> Owl_utils.aarr_fold (fun a w -> Maths.(a + regl_fun w)) (_f 0.) ws
        | false -> _f 0.
      in
      let loss = Maths.(loss + reg) in
      let ws, gs' = backward loss in
      loss |> primal', ws, gs'
    in

    (* init new or continue previous state of optimisation process *)
    let state = match state with
      | Some state -> state
      | None       -> (
          let batches_per_epoch = Batch.batches params.batch x in
          let state = Checkpoint.init_state batches_per_epoch params.epochs in
          (* first iteration to bootstrap the optimisation *)
          let loss, _ws, _gs = iterate 0 in
          update _ws;
          (* variables used for specific gradient method *)
          Checkpoint.(state.gs <- _gs);
          Checkpoint.(state.ps <- Owl_utils.aarr_map Maths.neg _gs);
          Checkpoint.(state.us <- Owl_utils.aarr_map (fun _ -> _f 0.) _gs);
          Checkpoint.(state.ch <- Owl_utils.aarr_map (fun _ -> [|_f 0.; _f 0.|]) _gs);
          Checkpoint.(state.loss.(0) <- primal' loss);
          state
        )
    in

    (* try to iterate all batches *)
    while Checkpoint.(state.stop = false) do
      let loss', ws, gs' = iterate Checkpoint.(state.current_batch) in
      (* check if the stopping criterion is met *)
      Checkpoint.(state.stop <- stop_fun (unpack_flt loss'));
      (* checkpoint of the optimisation if necessary *)
      chkp_fun save Checkpoint.(state.current_batch) loss' state;
      (* print out the current state of optimisation *)
      if params.verbosity = true then Checkpoint.print_state_info state;
      (* clip the gradient if necessary *)
      let gs' = Owl_utils.aarr_map clip_fun gs' in
      (* calculate gradient descent *)
      let ps' = Checkpoint.(Owl_utils.aarr_map4 (grad_fun (fun a -> a)) ws state.gs state.ps gs') in
      (* update gcache if necessary *)
      Checkpoint.(state.ch <- Owl_utils.aarr_map2 upch_fun gs' state.ch);
      (* adjust direction based on learning_rate *)
      let us' = Checkpoint.(
        Owl_utils.aarr_map3 (fun p' g' c ->
          Maths.(p' * rate_fun state.current_batch g' c)
        ) ps' gs' state.ch
      )
      in
      (* adjust direction based on momentum *)
      let us' = Owl_utils.aarr_map2 momt_fun Checkpoint.(state.us) us' in
      (* update the weight *)
      let ws' = Owl_utils.aarr_map2 (fun w u -> Maths.(w + u)) ws us' in
      update ws';
      (* save historical data *)
      if params.momentum <> Momentum.None then Checkpoint.(state.us <- us');
      Checkpoint.(state.gs <- gs');
      Checkpoint.(state.ps <- ps');
      Checkpoint.(state.current_batch <- state.current_batch + 1);
      (* force GC to release bigarray memory *)
      Gc.minor ();
    done;

    (* print optimisation summary *)
    if params.verbosity = true && Checkpoint.(state.current_batch >= state.batches) then
      Checkpoint.print_summary state;
    (* return the current state *)
    state


  (* This function minimises [f : x -> y] wrt [x].
    [x] is an ndarray; and [y] is an scalar value.
   *)
  let minimise_fun ?state params f x =
    let open Params in
    if params.verbosity = true && state = None then
      print_endline (Params.to_string params);

    (* make alias functions *)
    let grad_fun = Gradient.run params.gradient in
    let rate_fun = Learning_Rate.run params.learning_rate in
    let regl_fun = Regularisation.run params.regularisation in
    let momt_fun = Momentum.run params.momentum in
    let upch_fun = Learning_Rate.update_ch params.learning_rate in
    let clip_fun = Clipping.run params.clipping in
    let stop_fun = Stopping.run params.stopping in
    let chkp_fun = Checkpoint.run params.checkpoint in

    (* make the function to minimise *)
    let optz_fun xi = Maths.((f xi) + (regl_fun xi)) in

    (* operations in the ith iteration *)
    let iterate _ xi =
      let loss, g = grad' optz_fun xi in
      loss |> primal', g, optz_fun
    in

    (* init new or continue previous state of optimisation process *)
    let state = match state with
      | Some state -> state
      | None       -> (
          let state = Checkpoint.init_state 1 params.epochs in
          (* first iteration to bootstrap the optimisation *)
          let loss, _g0, _ = iterate 0 x in
          (* variables used for specific gradient method *)
          Checkpoint.(state.gs <- [| [|_g0|] |]);
          Checkpoint.(state.ps <- [| [|Maths.(neg _g0)|] |]);
          Checkpoint.(state.us <- [| [|_f 0.|] |]);
          Checkpoint.(state.ch <- [| [| [|_f 0.; _f 0.|] |] |]);
          Checkpoint.(state.loss.(0) <- primal' loss);
          state
        )
    in

    (* try to iterate all batches *)
    let x = ref x in
    while Checkpoint.(state.stop = false) do
      let loss', g', optz' = iterate Checkpoint.(state.current_batch) !x in
      (* check if the stopping criterion is met *)
      Checkpoint.(state.stop <- stop_fun (unpack_flt loss'));
      (* checkpoint of the optimisation if necessary *)
      chkp_fun (fun _ -> ()) Checkpoint.(state.current_batch) loss' state;
      (* print out the current state of optimisation *)
      if params.verbosity = true then Checkpoint.print_state_info state;
      (* clip the gradient if necessary *)
      let g' = clip_fun g' in
      (* calculate gradient descent *)
      let p' = Checkpoint.(grad_fun optz' !x state.gs.(0).(0) state.ps.(0).(0) g') in
      (* update gcache if necessary *)
      Checkpoint.(state.ch.(0).(0) <- upch_fun g' state.ch.(0).(0));
      (* adjust direction based on learning_rate *)
      let u' = Checkpoint.(Maths.(p' * rate_fun state.current_batch g' state.ch.(0).(0))) in
      (* adjust direction based on momentum *)
      let u' = momt_fun Checkpoint.(state.us.(0).(0)) u' in
      (* update the weight *)
      x := Maths.(!x + u') |> primal';
      (* save historical data *)
      if params.momentum <> Momentum.None then Checkpoint.(state.us.(0).(0) <- u');
      Checkpoint.(state.gs.(0).(0) <- g');
      Checkpoint.(state.ps.(0).(0) <- p');
      Checkpoint.(state.current_batch <- state.current_batch + 1);
      (* force GC to release bigarray memory *)
      Gc.minor ();
    done;

    (* print optimisation summary *)
    if params.verbosity = true && Checkpoint.(state.current_batch >= state.batches) then
      Checkpoint.print_summary state;
    (* return both loss history and weight *)
    state, !x


  (* This function minimises deeply compiled neural network. *)
  let minimise_compiled_network ?state params eval update save x y =
    let open Params in
    if params.verbosity = true && state = None then
      print_endline (Params.to_string params);

    (* make alias functions *)
    let bach_fun = Batch.run params.batch in
    let stop_fun = Stopping.run params.stopping in
    let chkp_fun = Checkpoint.run params.checkpoint in

    (* operations in the ith iteration *)
    let iterate i =
      let xt, yt = bach_fun x y i in
      let loss = eval xt yt in
      loss
    in

    (* init new or continue previous state of optimisation process *)
    let state = match state with
      | Some state -> state
      | None       -> (
          let batches_per_epoch = Batch.batches params.batch x in
          let state = Checkpoint.init_state batches_per_epoch params.epochs in
          (* first iteration to bootstrap the optimisation *)
          let loss = iterate 0 in
          update ();
          (* variables used for specific gradient method *)
          Checkpoint.(state.loss.(0) <- (primal' loss));
          state
        )
    in

    (* try to iterate all batches *)
    while Checkpoint.(state.stop = false) do
      let loss' = iterate Checkpoint.(state.current_batch) in
      (* check if the stopping criterion is met *)
      Checkpoint.(state.stop <- stop_fun (unpack_flt loss'));
      (* checkpoint of the optimisation if necessary *)
      chkp_fun save Checkpoint.(state.current_batch) (loss' |> unpack_flt |> pack_flt) state;
      (* print out the current state of optimisation *)
      if params.verbosity = true then Checkpoint.print_state_info state;
      update ();
      (* save historical data *)
      Checkpoint.(state.current_batch <- state.current_batch + 1);
      (* force GC to release bigarray memory *)
      (* FIXME Gc.minor (); *)
    done;

    (* print optimisation summary *)
    if params.verbosity = true && Checkpoint.(state.current_batch >= state.batches) then
      Checkpoint.print_summary state;
    (* return the current state *)
    state


end

(* Make functor ends *)
