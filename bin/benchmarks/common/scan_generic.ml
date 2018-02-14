module Make(M : Owl_types.Ndarray_Basic) = struct
  let wrap_fun () =
    let _ = Printf.printf "Evaluating scan operation\n" in

    let rank = (Array.length Sys.argv) - 1 in

    let _ =
      if (rank <= 0)
      then failwith "ERROR! Must provide the dimensions of the Ndarray." in

    let dims = Array.init rank (fun i -> int_of_string Sys.argv.(i + 1)) in
    let _ = Printf.printf "Evaluating Ndarray of rank %d with dims: [" rank in
    let _ = Array.iter (fun d -> Printf.printf "%d " d) dims in
    let _ = Printf.printf "]\n" in

    let v = ref (M.empty dims) in

    let _ =
      begin
        for rep = 0 to 10 do
          for axis = 0 to rank - 1 do
            v := M.scan ~axis (fun x y -> x +. 1.) !v
          done
        done
      end
    in
    Printf.printf "Done!\n"

  let _ = Function_timer.time_function wrap_fun
end
