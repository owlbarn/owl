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
    | GD     -> fun _ _ _ g' -> Maths.neg g', g'
    | CG     -> fun w g p g' -> Maths.neg g', g'
    | CD     -> fun w g p g' -> Maths.neg g', g'
    | Newton -> fun w g p g' -> Maths.neg g', g'

end


module Regularisation = struct

  type typ =
    | L1norm of float
    | L2norm of float
    | NoReg

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
    epochs        = 10;
    gradient      = Gradient.GD;
    learning_rate = Learning_Rate.Const 0.01;
    loss          = Loss.Cross_entropy;
    batch         = Batch.Minibatch 100;
  }

end


let train (params : Params.typ) forward backward update x y =
  let open Params in

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
  let ps = ref (Owl_utils.arrarr_map Maths.neg _gs) in
  update _ws;

  for i = 1 to params.epochs do
    let loss, ws, gs' = iterate () in
    let _l = Owl_utils.array_map2i (
      fun j _ws _gs' ->
        Array.map2 (fun w g' ->
          let g, p = !gs.(j), !ps.(j) in
          grad_fun w g p g'
        ) _ws _gs'
      ) ws gs'
    in
    (* adjust direction based on learning_rate *)
    let ps' = Owl_utils.arrarr_map fst _l in
    let us' = Owl_utils.arrarr_map (fun p' -> Maths.(F 0.01 * p')) ps' in
    let ws' = Owl_utils.arrarr_map2 (fun w u -> Maths.(w + u)) ws us' in
    (* update the weight *)
    update ws';
    (* save historical data *)
    gs := gs';
    ps := ps';
    (* print out log info *)
    loss |> unpack_flt |> Printf.printf "#%i : loss = %g\n" i |> flush_all;
  done

(*
let cross_entropy_loss y y' = Maths.(cross_entropy y y' / (F (Mat.row_num y |> float_of_int)))

let gd v g = Maths.(v - F 0.01 * g)

let train0 x y f update =
  for i = 1 to 1000 do
    let xt, yt = Owl_dataset.draw_samples x y 100 in
    let xt, yt = Mat xt, Mat yt in
    let loss = f (cross_entropy_loss yt) xt in
    update gd;
    loss |> unpack_flt |> Printf.printf "#%i : loss = %g\n" i |> flush_all;
  done
*)
