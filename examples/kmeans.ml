#!/usr/bin/env owl

open Owl
module LL = Owl_cluster

let _ =
  let x = Mat.load_txt "kmeans.data" in
  let m, n = Mat.shape x in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test matrix size: %i x %i\n" m n;
  print_endline (Bytes.make 60 '-');
  print_endline "test on input data ...";
  let centers, _ = LL.kmeans x 2 in Mat.print centers;
  print_endline "test on random data ...";
  let x = Mat.uniform 100000 8 in LL.kmeans x 3
