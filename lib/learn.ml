(** [
  Machine learning library
  Note: Fortran layout column-based matrix
  ]  *)

module LC = Lacaml
module M = Matrix.Matrix

let print_list l = List.iter (print_int) l

module Cluster = struct

  let kmeans x c = let open M in
    let m, n = shape x in
    let cpts = draw_rows ~replacement:false x c and cpts_new = zeros c n in
    let assignment = Array.make m (0, max_float) in
    for counter = 1 to 100 do
    Printf.printf "iteration %i ...\n" counter; flush stdout;
    iteri_rows (fun i v ->
      iteri_rows (fun j u ->
        let e = sum((v -@ u) *@ (v -@ u)) in
        (*let _ = print_float e; print_char ' ' in*)
        if e < snd assignment.(i-1) then assignment.(i-1) <- (j, e)
      ) cpts
    ) x;
    iteri_rows (fun j u ->
      let l = Array.to_list assignment in
      let l = List.filter (fun y -> fst y = j) l in
      let l = List.map (fun y -> fst y) l in
      let _ = print_int (List.length l); print_char ' ' in
      if List.length l != 0 then
       let z = average_rows (rows x l) in
       let _ = copy_to_row z j cpts_new in ()
    ) cpts;
    if cpts =@ cpts_new then failwith "converged";
    ignore (cpts << cpts_new);
    done;
    assignment

end;;

module C = Cluster;;
