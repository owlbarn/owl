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

  let run = function
    | Const a          -> fun _ _ -> F a
    | Decay (a, k)     -> fun i _ -> Maths.(F a / (F 1. + F k * (F (float_of_int i))))
    | Exp_decay (a, k) -> fun _ _ -> F a

  let default = function
    | Const _     -> Const 0.001
    | Decay _     -> Decay (0.1, 0.1)
    | Exp_decay _ -> Exp_decay (1., 0.1)

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
    | Noreg    -> F 0.

  let to_string = function
    | L1norm a -> Printf.sprintf "l1norm (alpha = %g)" a
    | L2norm a -> Printf.sprintf "l2norm (alhpa = %g)" a
    | Noreg    -> "none"

end


module Params = struct

  type typ = {
    mutable epochs          : int;
    mutable batch           : Batch.typ;
    mutable gradient        : Gradient.typ;
    mutable loss            : Loss.typ;
    mutable learning_rate   : Learning_Rate.typ;
    mutable regularisation  : Regularisation.typ;
  }

  let default () = {
    epochs         = 1;
    batch          = Batch.Minibatch 100;
    gradient       = Gradient.GD;
    loss           = Loss.Cross_entropy;
    learning_rate  = Learning_Rate.(default (Const 0.));
    regularisation = Regularisation.Noreg;
  }

  let to_string p =
    Printf.sprintf "--- Training config\n" ^
    Printf.sprintf "    epochs         : %i\n" (p.epochs) ^
    Printf.sprintf "    batch          : %s\n" (Batch.to_string p.batch) ^
    Printf.sprintf "    method         : %s\n" (Gradient.to_string p.gradient) ^
    Printf.sprintf "    loss           : %s\n" (Loss.to_string p.loss) ^
    Printf.sprintf "    learning rate  : %s\n" (Learning_Rate.to_string p.learning_rate) ^
    Printf.sprintf "    regularisation : %s\n" (Regularisation.to_string p.regularisation) ^
    "---"

end


let _print_info e_i e_n b_i b_n l l' =
  let l, l' = unpack_flt l, unpack_flt l' in
  let d = l -. l' in
  let s = if d = 0. then "-" else if d < 0. then "▲" else "▼" in
  Log.info "%i/%i | B: %i/%i | L: %g[%s]"
  e_i e_n b_i b_n l' s

let _print_summary t = Printf.printf "--- Training summary\n    Duration: %g s\n" t


let train params forward backward update x y =
  let open Params in
  print_endline (Params.to_string params);

  (* make alias functions *)
  let batch = Batch.run params.batch in
  let loss_fun = Loss.run params.loss in
  let grad_fun = Gradient.run params.gradient in
  let rate_fun = Learning_Rate.run params.learning_rate in
  let regl_fun = Regularisation.run params.regularisation in

  (* operations in one iteration *)
  let iterate () =
    let xt, yt = batch x y in
    let yt', ws = forward xt in
    let loss = Maths.(loss_fun yt yt') in
    (* take the average of the loss *)
    let loss = Maths.(loss / (F (Mat.row_num yt |> float_of_int))) in
    (* add regularisation term if necessary *)
    let reg = match params.regularisation <> Regularisation.Noreg with
      | true  -> Owl_utils.aarr_fold (fun a w -> Maths.(a + regl_fun w)) (F 0.) ws
      | false -> F 0.
    in
    let loss = Maths.(loss + reg) in
    let ws, gs' = backward loss in
    loss |> primal', ws, gs' in

  (* bootstrap the training *)
  let t0 = Unix.time () in
  let _loss, _ws, _gs = iterate () in
  let gs = ref _gs in
  let ps = ref (Owl_utils.aarr_map Maths.neg _gs) in
  update _ws;

  (* variables used in training process *)
  let batches = Batch.batches params.batch x in
  let loss = ref _loss in

  (* iterate all batches in each epoch *)
  for i = 1 to params.epochs do
    for j = 1 to batches do
      let loss', ws, gs' = iterate () in
      (* print out the current state of training *)
      _print_info i params.epochs j batches !loss loss';
      (* calculate gradient descendent *)
      let ps' = Owl_utils.aarr_map2i (
        fun k _ w g' ->
          let g, p = !gs.(k), !ps.(k) in
          grad_fun w g p g'
        ) ws gs' in
      (* adjust direction based on learning_rate *)
      let us' = Owl_utils.aarr_map (fun p' -> Maths.(p' * rate_fun j p')) ps' in
      let ws' = Owl_utils.aarr_map2 (fun w u -> Maths.(w + u)) ws us' in
      (* update the weight *)
      update ws';
      (* save historical data *)
      gs := gs';
      ps := ps';
      loss := loss';
    done
  done;

  (* print training summary *)
  _print_summary (Unix.time () -. t0)


(* ends here *)
