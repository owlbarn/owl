#!/usr/bin/env owl

open Owl
module G = Owl_computation_cpu_engine.Make (Owl_algodiff_primal_ops.D)
include Owl_algodiff_generic.Make (G)


let f x y = Maths.((x * sin (x + x) + ((pack_flt 1.) * sqrt x) / (pack_flt 7.)) * (relu y) |> sum')


let visualise_01 () =
  let x = G.var_elt "x" |> pack_elt in
  let y = G.var_elt "y" |> pack_elt in
  let z = f x y in
  let inputs = [| unpack_elt x |> G.elt_to_node; unpack_elt y |> G.elt_to_node |] in
  let outputs = [| unpack_elt z |> G.elt_to_node |] in
  let graph = G.make_graph inputs outputs "graph" in
  let s = G.graph_to_dot graph in
  Owl_io.write_file "cgraph_01.dot" s;
  Sys.command "dot -Tpdf cgraph_01.dot -o cgraph_01.pdf" |> ignore


let visualise_02 () =
  let x = G.var_elt "x" |> pack_elt in
  let y = G.var_elt "y" |> pack_elt in
  let z = (grad (f x)) y in
  let inputs = [| unpack_elt x |> G.elt_to_node; unpack_elt y |> G.elt_to_node |] in
  let outputs = [| unpack_elt z |> G.elt_to_node |] in
  let s = G.make_graph inputs outputs "graph" |> G.graph_to_dot in
  Owl_io.write_file "cgraph_02.dot" s;
  Sys.command "dot -Tpdf cgraph_02.dot -o cgraph_02.pdf" |> ignore


let visualise_03 () =
  let t = tag () in
  let x = make_reverse (G.var_arr "x" ~shape:[|3;4|] |> pack_arr) t in
  let y = make_reverse (G.var_arr "y" ~shape:[|1;4|] |> pack_arr) t in
  let z = f x y in
  let i0 = [| unpack_arr x |> G.arr_to_node; unpack_arr y |> G.arr_to_node |] in
  let o0 = [| primal z |> unpack_elt |> G.elt_to_node |] in
  let s0 = G.make_graph i0 o0 "graph" |> G.graph_to_dot in
  Owl_io.write_file "cgraph_03_forward.dot" s0;
  Sys.command "dot -Tpdf cgraph_03_forward.dot -o cgraph_03_forward.pdf" |> ignore;

  reverse_prop (pack_flt 1.) z;
  let x' = adjval x |> unpack_arr |> G.arr_to_node in
  let y' = adjval y |> unpack_arr |> G.arr_to_node in
  let i1 = [| unpack_arr x |> G.arr_to_node |] in
  let s1 = G.make_graph i1 [| x' |] "graph" |> G.graph_to_dot in
  let i2 = [| unpack_arr y |> G.arr_to_node |] in
  let s2 = G.make_graph i2 [| y' |] "graph" |> G.graph_to_dot in
  let s3 = G.make_graph i0 [| x'; y' |] "graph" |> G.graph_to_dot in
  Owl_io.write_file "cgraph_03_backward_x.dot" s1;
  Sys.command "dot -Tpdf cgraph_03_backward_x.dot -o cgraph_03_backward_x.pdf" |> ignore;
  Owl_io.write_file "cgraph_03_backward_y.dot" s2;
  Sys.command "dot -Tpdf cgraph_03_backward_y.dot -o cgraph_03_backward_y.pdf" |> ignore;
  Owl_io.write_file "cgraph_03_backward_xy.dot" s3;
  Sys.command "dot -Tpdf cgraph_03_backward_xy.dot -o cgraph_03_backward_xy.pdf" |> ignore


let _ =
  visualise_01 ();
  visualise_02 ();
  visualise_03 ()
