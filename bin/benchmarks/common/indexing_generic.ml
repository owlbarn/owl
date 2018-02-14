module Make(M : Owl_types.Ndarray_Basic) = struct
  let wrap_fun () =
    let _ = Printf.printf "Evaluating indexing operations\n" in

    let rank = (Array.length Sys.argv) - 1 in

    let _ =
      if (rank <= 0)
      then failwith "ERROR! Must provide the dimensions of the Ndarray." in

    let dims = Array.init rank (fun i -> int_of_string Sys.argv.(i + 1)) in
    let _ = Printf.printf "Evaluating Ndarray of rank %d with dims: [" rank in
    let _ = Array.iter (fun d -> Printf.printf "%d " d) dims in
    let _ = Printf.printf "]\n" in

    let v = M.empty dims in
    let n = M.numel v in

    let stride = Owl_utils.calc_stride dims in
    let ind = Array.init rank (fun _ -> 0) in
    let _ =
      begin
        for rep = 0 to 10 do
          for i = 0 to n - 1 do
            let _ = Owl_utils.index_1d_nd i ind stride in
            let x = M.get v ind in
            M.set v ind (x +. 1.)
          done
        done
      end
    in
    Printf.printf "Done!\n"

  let _ = Function_timer.time_function wrap_fun
end
