module Make(M : Owl_types.Ndarray_Basic) = struct
  let wrap_fun () =
    let _ = Printf.printf "Evaluating slicing operations\n" in

    let rank = (Array.length Sys.argv) - 1 in

    let _ =
      if (rank <= 0)
      then failwith "ERROR! Must provide the dimensions of the Ndarray." in

    let dims = Array.init rank (fun i -> int_of_string Sys.argv.(i + 1)) in
    let _ = Array.iter
        (fun d ->
           if d <= 4 then failwith "ERROR! Each dim must be at least 5.") dims in
    let _ = Printf.printf "Evaluating Ndarray of rank %d with dims: [" rank in
    let _ = Array.iter (fun d -> Printf.printf "%d " d) dims in
    let _ = Printf.printf "]\n" in

    let slice_def = List.init rank (fun i -> [~- (dims.(i) / 4); dims.(i) / 4]) in
    let _ =
      Printf.printf "Slice size: ";
      List.iter (function
            [a; b] -> Printf.printf "[%d, %d] " a b
          | _ -> ()) slice_def;
      Printf.printf "\n"
    in

    let v = M.empty dims in
    let s = M.get_slice slice_def v in
    let s = M.empty (M.shape s) in

    let _ =
      Printf.printf "Slice dims: ";
      Array.iter (fun d -> Printf.printf "%d " d) (M.shape s);
      Printf.printf "\n"
    in

    let _ =
      begin
        for rep = 0 to 10 do
          let _ = M.get_slice slice_def v in
          let _ = M.set_slice slice_def v s in
          ()
        done
      end
    in
    Printf.printf "Done!\n"

  let _ = Function_timer.time_function wrap_fun
end
