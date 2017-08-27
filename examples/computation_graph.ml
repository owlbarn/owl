#!/usr/bin/env owl
(* This example shows how to visualise the computation graph generated in
   Algodiff. To run this exmaple, you need to have Graphviz installed on your
   computer. Or you can use other visualisation tools for the generated dot file.
 *)

#zoo "2e7c902812a7ae0547e24f7ea743c7e6"
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


let visualise_neural_network () =
  let network = Cifar10.make_network [|32;32;3|] in
  let x, _, y = Dataset.load_cifar_train_data 1 in
  let xt, yt = Optimise.S.Utils.draw_samples (Arr x) (Mat y) 10 in
  let yt', _ = Neural.S.Graph.(init network; forward network xt) in
  let loss = Maths.((cross_entropy yt yt') / (F (Mat.row_num yt |> float_of_int))) in
  to_dot [loss]


let _ =
  Log.info "visualise simple computation graph to terminal ...";
  visualise_simple_01 () |> print_endline;
  Log.info "visualise simple computation graph to dot file ...";
  visualise_simple_02 () |> Owl_utils.write_file "plot_algodiff_graph1.dot";
  Sys.command "dot -Tpdf plot_algodiff_graph1.dot -o plot_algodiff_graph1.pdf";
  Log.info "visualise neural network ...";
  visualise_neural_network () |> Owl_utils.write_file "plot_algodiff_graph2.dot";
  Sys.command "dot -Tpdf plot_algodiff_graph2.dot -o plot_algodiff_graph2.pdf"
