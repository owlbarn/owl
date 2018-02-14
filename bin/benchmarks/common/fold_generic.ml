module Make(M : Owl_types.Ndarray_Basic) = struct
  let wrap_fun () =
    let _ = Printf.printf "Evaluating fold operation\n" in

    let rank = (Array.length Sys.argv) - 1 in

    let _ =
      if (rank <= 0)
      then failwith "ERROR! Must provide the dimensions of the Ndarray." in

    let dims = Array.init rank (fun i -> int_of_string Sys.argv.(i + 1)) in
    let _ = Printf.printf "Evaluating Ndarray of rank %d with dims: [" rank in
    let _ = Array.iter (fun d -> Printf.printf "%d " d) dims in
    let _ = Printf.printf "]\n" in

    let v = M.empty dims in

    let _ =
      begin
        for rep = 0 to 10 do
          for axis = 0 to rank - 1 do
            let _ = M.fold ~axis Pervasives.(+.) 0. v in
            ()
          done
        done
      end
    in
    Printf.printf "Done!\n"

  let _ = Function_timer.time_function wrap_fun

end
