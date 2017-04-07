(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* NOTE: this is an experimental module being built now *)

open Owl_algodiff_ad
open Owl_neural_layer


(* module aliases *)

module Init = Init
module Activation = Activation
module Feedforward = Feedforward


(* helper functions *)

let linear ~inputs ~outputs ~init_typ = Linear (Linear.create inputs outputs init_typ)

let recurrent ~inputs ~hiddens ~outputs ~act_typ ~init_typ = Recurrent (Recurrent.create inputs hiddens outputs act_typ init_typ)

let lstm ~inputs ~cells = LSTM (LSTM.create inputs cells)

let print nn = Feedforward.to_string nn |> Printf.printf "%s"

let train ?params nn x y =
  Feedforward.init nn;
  let f = Feedforward.forward nn in
  let b = Feedforward.backward nn in
  let u = Feedforward.update nn in
  let p = match params with
    | Some p -> p
    | None   -> Owl_neural_optimise.Params.default ()
  in
  Owl_neural_optimise.train p f b u x y

let test_model nn x y =
  Mat.iter2_rows (fun u v ->
    Owl_dataset.print_mnist_image (unpack_mat u);
    let p = Feedforward.run u nn |> unpack_mat in
    Owl_dense_matrix_generic.print p;
    Printf.printf "prediction: %i\n" (let _, _, j = Owl_dense_matrix_generic.max_i p in j)
  ) x y


(* ends here *)
