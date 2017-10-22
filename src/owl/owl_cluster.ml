(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module MX = Owl_dense.Matrix.D
module UT = Owl_utils

let _ = Log.color_on (); Log.(set_log_level INFO)

(** K-means clustering algorithm
  x is the row-based data points and c is the number of clusters.
 *)

let kmeans x c =
  let open MX in
  let cpts0 = fst (draw_rows x c) in
  let cpts1 = zeros c (col_num x) in
  let assignment = Array.make (row_num x) (0, max_float) in
  let _ =
    try for counter = 1 to 100 do
      Log.info "iteration %i ..." counter; flush stdout;
      iteri_rows (fun i v ->
        iteri_rows (fun j u ->
          let e = sum' (pow_scalar (sub v u) 2.) in
          if Pervasives.(e < snd assignment.(i)) then
            assignment.(i) <- (j, e)
        ) cpts0
      ) x;
      iteri_rows (fun j u ->
        let l = UT.array_filteri_v (fun i y -> Pervasives.(fst y = j), i) assignment in
        let z = mean_rows (rows x l) in
        let _ = copy_row_to z cpts1 j in ()
      ) cpts0;
      if equal cpts0 cpts1 then failwith "converged" else ignore (copy_to cpts1 cpts0)
    done with exn -> ()
  in
  cpts1, UT.array_map fst assignment
