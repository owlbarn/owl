(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module MX = Owl_dense.Matrix.D
module UT = Owl_utils

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
      Owl_log.info "iteration %i ..." counter; flush stdout;
      iteri_rows (fun i v ->
        iteri_rows (fun j u ->
          let e = sum' (pow_scalar (sub v u) 2.) in
          if Stdlib.(e < snd assignment.(i)) then
            assignment.(i) <- (j, e)
        ) cpts0
      ) x;
      iteri_rows (fun j _u ->
        let l = UT.Array.filteri_v (fun i y -> Stdlib.(fst y = j), i) assignment in
        let z = mean_rows (rows x l) in
        let _ = copy_row_to z cpts1 j in ()
      ) cpts0;
      if equal cpts0 cpts1 then failwith "converged" else ignore (copy_ ~out:cpts0 cpts1)
    done with _exn -> ()
  in
  cpts1, UT.Array.map fst assignment
