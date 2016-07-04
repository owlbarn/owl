module MM = Matrix.Matrix
module ML = Learn.Cluster

let _ =
  let x = MM.load "test_kmeans.data" in
  let m, n = MM.shape x in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test matrix size: %i x %i\n" m n;
  print_endline (Bytes.make 60 '-');
  print_endline "test on input data ...";
  let centers, _ = ML.kmeans x 2 in MM.pprint centers;
  print_endline "test on random data ...";
  let x = MM.random 1000000 8 in ML.kmeans x 3
