(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff_ad


module Learning_Rate = struct

  type typ =
    | Const     of float
    | Decay     of float * float
    | Exp_decay of float * float

  let run typ g = match typ with
    | Const a          -> F a
    | Decay (a, k)     -> F a
    | Exp_decay (a, k) -> F a

  let to_string = function
    | Const a          -> Printf.sprintf "constant %g" a
    | Decay (a, k)     -> Printf.sprintf "decay (%g, %g)" a k
    | Exp_decay (a, k) -> Printf.sprintf "exp_decay (%g, %g)" a k

end


module Batch = struct

  type typ =
    | Fullbatch
    | Minibatch of int
    | Stochastic

  let run typ x y = match typ with
    | Fullbatch   -> x, y
    | Minibatch c -> let x, y, _ = Mat.draw_rows2 ~replacement:false x y c in x, y
    | Stochastic  -> let x, y, _ = Mat.draw_rows2 ~replacement:false x y 1 in x, y

  let batches typ x = match typ with
    | Fullbatch   -> 1
    | Minibatch c -> Mat.row_num x / c
    | Stochastic  -> Mat.row_num x

  let to_string = function
    | Fullbatch   -> "full"
    | Minibatch c -> Printf.sprintf "mini of %i" c
    | Stochastic  -> "stochastic"

end


module Loss = struct

  type typ =
    | L1norm
    | L2norm
    | Quadratic
    | Cross_entropy

  let run typ y y' = match typ with
    | L1norm        -> Maths.(l1norm (y - y'))
    | L2norm        -> Maths.(l2norm (y - y'))
    | Quadratic     -> Maths.(l2norm_sqr (y - y'))
    | Cross_entropy -> Maths.(cross_entropy y y')

  let to_string = function
    | L1norm        -> "l1norm"
    | L2norm        -> "l2norm"
    | Quadratic     -> "quadratic"
    | Cross_entropy -> "cross_entropy"

end


module Gradient = struct

  type typ =
    | GD
    | CG
    | CD
    | Newton

  (* FIXME *)
  let run = function
    | GD     -> fun _ _ _ g' -> Maths.neg g'
    | CG     -> fun w g p g' -> Maths.neg g'
    | CD     -> fun w g p g' -> Maths.neg g'
    | Newton -> fun w g p g' -> Maths.neg g'

  let to_string = function
    | GD     -> "gradient decscendent"
    | CG     -> "conjugate gradient"
    | CD     -> "conjugate descendent"
    | Newton -> "newtown"

end


module Regularisation = struct

  type typ =
    | L1norm of float
    | L2norm of float
    | Noreg

  let run typ x = match typ with
    | L1norm a -> Maths.(F a * l1norm x)
    | L2norm a -> Maths.(F a * l2norm x)
    | Noreg    -> x

end


module Params = struct

  type typ = {
    mutable epochs          : int;
    mutable gradient        : Gradient.typ;
    mutable learning_rate   : Learning_Rate.typ;
    mutable loss            : Loss.typ;
    mutable batch           : Batch.typ;
  }

  let default () = {
    epochs        = 1000;
    gradient      = Gradient.GD;
    learning_rate = Learning_Rate.Const 0.01;
    loss          = Loss.Cross_entropy;
    batch         = Batch.Minibatch 100;
  }

  let to_string p =
    "Train config\n" ^
    Printf.sprintf "epochs        : %i\n" p.epochs ^
    Printf.sprintf "batch         : %s\n" (Batch.to_string p.batch) ^
    Printf.sprintf "method        : %s\n" (Gradient.to_string p.gradient) ^
    Printf.sprintf "loss          : %s\n" (Loss.to_string p.loss) ^
    Printf.sprintf "learning rate : %s\n" (Learning_Rate.to_string p.learning_rate) ^
    ""

end


let train params forward backward update x y =
  let open Params in
  Printf.printf "%s" (Params.to_string params);

  (* make alias functions *)
  let batch = Batch.run params.batch in
  let loss_fun = Loss.run params.loss in
  let grad_fun = Gradient.run params.gradient in

  (* operations in one iteration *)
  let iterate () =
    let xt, yt = batch x y in
    let yt' = forward xt in
    let loss = Maths.(loss_fun yt yt') in
    let loss = Maths.(loss / (F (Mat.row_num yt |> float_of_int))) in
    let ws, gs' = backward loss in
    loss, ws, gs' in

  (* bootstrap the training *)
  let _loss, _ws, _gs = iterate () in
  let gs = ref _gs in
  let ps = ref (Owl_utils.aarr_map Maths.neg _gs) in
  update _ws;

  (* iterate all the epochs *)
  for i = 1 to params.epochs do
    let loss, ws, gs' = iterate () in
    (* calculate gradient descendent *)
    let ps' = Owl_utils.aarr_map2i (
      fun j _ w g' ->
        let g, p = !gs.(j), !ps.(j) in
        grad_fun w g p g'
      ) ws gs' in
    (* adjust direction based on learning_rate *)
    let us' = Owl_utils.aarr_map (fun p' -> Maths.(F 0.01 * p')) ps' in
    let ws' = Owl_utils.aarr_map2 (fun w u -> Maths.(w + u)) ws us' in
    (* update the weight *)
    update ws';
    (* save historical data *)
    gs := gs';
    ps := ps';
    (* print out log info *)
    loss |> unpack_flt |> Printf.printf "#%i : loss = %g\n" i |> flush_all;
  done
