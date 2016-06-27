(** [
  Machine learning library
  Note: Fortran layout column-based matrix
  ]  *)

module LC = Lacaml
module M = Matrix.Matrix

let print_list l = List.iter (print_int) l

module Cluster = struct

  let kmeans x c = let open M in
    let cpts0 = draw_rows ~replacement:true x c in
    let cpts1 = zeros c (col_num x) in
    let assignment = Array.make (row_num x) (0, max_float) in
    for counter = 1 to 100 do
    Printf.printf "iteration %i ...\n" counter; flush stdout;
    iteri_rows (fun i v ->
      iteri_rows (fun j u ->
        let e = sum((v -@ u) **@ 2.) in
        if e < snd assignment.(i-1) then assignment.(i-1) <- (j, e)
      ) cpts0
    ) x;
    iteri_rows (fun j u ->
      let l = Array.to_list assignment in
            let _ = print_endline "here" in
      let l = List.filter (fun y -> fst y = j) l in
            let _ = print_endline "heree" in
      let l = List.map (fun y -> fst y) l in
            let _ = print_endline "hereee" in
      let z = average_rows (rows x l) in
      let _ = copy_to_row z j cpts1 in ()
    ) cpts0;
    if cpts0 =@ cpts1 then failwith "converged";
    ignore (cpts0 << cpts1);
    done;
    assignment

end;;

module C = Cluster;;
