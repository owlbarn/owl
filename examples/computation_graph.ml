#!/usr/bin/env owl
(* This example shows how to visualise the computation graph generated in
   Algodiff. To run this exmaple, you need to have Graphviz installed on your
   computer. Or you can use other visualisation tools for the generated dot file.
 *)

#zoo "2e7c902812a7ae0547e24f7ea743c7e6"
#zoo "217ef87bc36845c4e78e398d52bc4c5b"

open Owl
open Algodiff.S


let f x y = Maths.((x * sin (x + x) + ( F 1. * sqrt x) / F 7.) * (relu y) |> sum)


let visualise_simple_01 () =
  let t = tag () in
  let x = make_reverse (F 5.) t in
  let y = make_reverse (Mat.uniform 3 4) t in
  let z = f x y in
  to_trace [z]


let visualise_simple_02 () =
  let t = tag () in
  let x = make_reverse (F 5.) t in
  let y = make_reverse (Mat.uniform 3 4) t in
  let z = f x y in
  to_dot [z]


let visualise_vgg () =
  let network = Cifar10.make_network [|32;32;3|] in
  let x, _, y = Dataset.load_cifar_train_data 1 in
  let xt, yt = Optimise.S.Utils.draw_samples (Arr x) (Arr y) 5 in
  let yt', _ = Neural.S.Graph.(init network; forward network xt) in
  let loss = Maths.((cross_entropy yt yt') / (F (Mat.row_num yt |> float_of_int))) in
  to_dot [loss]


let visualise_lstm () =
  let wndsz = 10 and stepsz = 1 in
  let w2i, i2w, x, y = Lstm.prepare wndsz stepsz in
  let vocabsz = Hashtbl.length w2i in
  let network = Lstm.make_network wndsz vocabsz in
  let xt, yt = Optimise.S.Utils.draw_samples (Arr x) (Arr y) 15 in
  let yt', _ = Neural.S.Graph.(init network; forward network xt) in
  let loss = Maths.((cross_entropy yt yt') / (F (Mat.row_num yt |> float_of_int))) in
  to_dot [loss]


let _ =
  Log.info "visualise simple computation graph to terminal ...";
  visualise_simple_01 () |> print_endline;
  Log.info "visualise simple computation graph to dot file ...";
  visualise_simple_02 () |> Owl_utils.write_file "plot_algodiff_graph1.dot";
  Sys.command "dot -Tpdf plot_algodiff_graph1.dot -o plot_algodiff_graph1.pdf";
  Log.info "visualise VGG neural network ...";
  visualise_vgg () |> Owl_utils.write_file "plot_algodiff_graph2.dot";
  Sys.command "dot -Tpdf plot_algodiff_graph2.dot -o plot_algodiff_graph2.pdf";
  Log.info "visualise LSTM neural network ...";
  visualise_lstm () |> Owl_utils.write_file "plot_algodiff_graph3.dot";
  Sys.command "dot -Tpdf plot_algodiff_graph3.dot -o plot_algodiff_graph3.pdf"
