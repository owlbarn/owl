#!/usr/bin/env owl

open Owl
module G = Owl_computation_engine.Make (Arr)
include Owl_algodiff_generic.Make (G.CGraph)


let f x y = Maths.((x * sin (x + x) + ((pack_flt 1.) * sqrt x) / (pack_flt 7.)) * (relu y) |> sum')


let visualise_01 () =
  let x = G.var_elt "x" |> pack_elt in
  let y = G.var_elt "y" |> pack_elt in
  let z = f x y in
  let s = [| unpack_elt z |> G.elt_to_node |] |> G.nodes_to_dot in
  Owl_io.write_file "cgraph_01.dot" s;
  Sys.command "dot -Tpdf cgraph_01.dot -o cgraph_01.pdf" |> ignore


let visualise_02 () =
  let x = G.var_elt "x" |> pack_elt in
  let y = G.var_arr "y" |> pack_arr in
  let z = (grad (f x)) y in
  let s = [| unpack_arr z |> G.arr_to_node |] |> G.nodes_to_dot in
  Owl_io.write_file "cgraph_02.dot" s;
  Sys.command "dot -Tpdf cgraph_02.dot -o cgraph_02.pdf" |> ignore


let visualise_03 () =
  let t = tag () in
  let x = make_reverse (G.var_arr "x" ~shape:[|3;4|] |> pack_arr) t in
  let y = make_reverse (G.var_arr "y" ~shape:[|1;4|] |> pack_arr) t in
  let z = f x y in
  let s0 = [| primal z |> unpack_elt |> G.elt_to_node |] |> G.nodes_to_dot in
  Owl_io.write_file "cgraph_03_forward.dot" s0;
  Sys.command "dot -Tpdf cgraph_03_forward.dot -o cgraph_03_forward.pdf" |> ignore;

  reverse_prop (pack_flt 1.) z;
  let x' = adjval x |> unpack_arr |> G.arr_to_node in
  let y' = adjval y |> unpack_arr |> G.arr_to_node in
  let s1 = G.nodes_to_dot [|x'|] in
  let s2 = G.nodes_to_dot [|y'|] in
  let s3 = G.nodes_to_dot [|x'; y'|] in
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
