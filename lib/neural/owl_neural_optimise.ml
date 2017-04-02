(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff_ad


module Batch = struct

  type typ =
    | Fullbatch
    | Minibatch of int
    | Stochastic

end


module Params = struct

  type typ = {
    mutable pochs : int;
    mutable batch : Batch.typ;
  }

  let default () = None

end

let cross_entropy_loss y y' = Maths.(cross_entropy y y' / (F (Mat.row_num y |> float_of_int)))

let gd v g = Maths.(v - F 0.01 * g)

let train x y f update =
  for i = 1 to 1000 do
    let xt, yt = Owl_dataset.draw_samples x y 100 in
    let xt, yt = Mat xt, Mat yt in
    let loss = f (cross_entropy_loss yt) xt in
    update gd;
    loss |> unpack_flt |> Printf.printf "#%i : loss = %g\n" i |> flush_all;
  done
