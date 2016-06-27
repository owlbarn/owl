(** [
  Machine learning library
  Note: Fortran layout column-based matrix
  ]  *)

module LC = Lacaml
module MM = Matrix.Matrix
module UT = Utils

module Cluster = struct

  let kmeans x c = let open MM in
    let cpts0 = draw_rows ~replacement:true x c in
    let cpts1 = zeros c (col_num x) in
    let assignment = Array.make (row_num x) (0, max_float) in
    try for counter = 1 to 100 do
    Printf.printf "iteration %i ...\n" counter; flush stdout;
    iteri_rows (fun i v ->
      iteri_rows (fun j u ->
        let e = sum((v -@ u) **@ 2.) in
        if e < snd assignment.(i-1) then assignment.(i-1) <- (j, e)
      ) cpts0
    ) x;
    iteri_rows (fun j u ->
      let l = UT.filter_array (fun i y -> fst y = j, i + 1) assignment in
      let z = average_rows (rows x (Array.to_list l)) in
      let _ = copy_to_row z j cpts1 in ()
    ) cpts0;
    if cpts0 =@ cpts1 then failwith "converged" else ignore (cpts0 << cpts1)
    done; assignment
    with exn -> assignment

end;;

module C = Cluster;;
