module MX = Owl_dense_real
module LL = Owl_optimise

let _ =
  let x = MX.load_txt "test_kmeans.data" in
  let m, n = MX.shape x in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test matrix size: %i x %i\n" m n;
  print_endline (Bytes.make 60 '-');
  print_endline "test on input data ...";
  let centers, _ = LL.kmeans x 2 in MX.pp_dsmat centers;
  print_endline "test on random data ...";
  let x = MX.uniform 100000 8 in LL.kmeans x 3
