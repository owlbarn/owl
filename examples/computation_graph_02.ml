#!/usr/bin/env owl

open Owl

module G = Owl_computation_graph

include Owl_algodiff_generic.Make (G)


let f x y = Maths.((x * sin (x + x) + ((pack_flt 1.) * sqrt x) / (pack_flt 7.)) * (relu y) |> sum')


let visualise_01 () =
  let x = G.const_elt "x" |> pack_elt in
  let y = G.const_elt "y" |> pack_elt in
  let z = f x y in
  let s = [unpack_elt z |> G.unpack_elt] |> G.to_dot in
  Owl_io.write_file "cgraph_01.dot" s;
  Sys.command "dot -Tpdf cgraph_01.dot -o cgraph_01.pdf" |> ignore


let visualise_02 () =
  let x = G.const_elt "x" |> pack_elt in
  let y = G.var_arr "y" None |> pack_arr in
  let z = (grad (f x)) y in
  let s = [unpack_arr z |> G.unpack_arr] |> G.to_dot in
  Owl_io.write_file "cgraph_02.dot" s;
  Sys.command "dot -Tpdf cgraph_02.dot -o cgraph_02.pdf" |> ignore


let visualise_03 () =
  let t = tag () in
  let x = make_reverse (G.var_arr "x" None |> pack_arr) t in
  let y = make_reverse (G.var_arr "y" None |> pack_arr) t in
  let z = f x y in
  let s = [primal z |> unpack_elt |> G.unpack_elt] |> G.to_dot in
  Owl_io.write_file "cgraph_03_forward.dot" s;
  Sys.command "dot -Tpdf cgraph_03_forward.dot -o cgraph_03_forward.pdf" |> ignore;

  reverse_prop (pack_flt 1.) z;
  let s = [adjval x |> unpack_arr |> G.unpack_arr] |> G.to_dot in
  Owl_io.write_file "cgraph_03_backward_x.dot" s;
  Sys.command "dot -Tpdf cgraph_03_backward_x.dot -o cgraph_03_backward_x.pdf" |> ignore;
  let s = [adjval y |> unpack_arr |> G.unpack_arr] |> G.to_dot in
  Owl_io.write_file "cgraph_03_backward_y.dot" s;
  Sys.command "dot -Tpdf cgraph_03_backward_y.dot -o cgraph_03_backward_y.pdf" |> ignore


let _ =
  visualise_01 ();
  visualise_02 ();
  visualise_03 ()
