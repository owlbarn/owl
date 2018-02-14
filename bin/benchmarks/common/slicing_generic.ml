module Make(M : Owl_types.Ndarray_Basic) = struct
  let _ = Printf.printf "Evaluating slicing operations\n"

  let rank = (Array.length Sys.argv) - 1

  let _ =
    if (rank <= 0)
    then failwith "ERROR! Must provide the dimensions of the Ndarray."

  let dims = Array.init rank (fun i -> int_of_string Sys.argv.(i + 1))
  let _ = Array.iter
      (fun d ->
         if d <= 4 then failwith "ERROR! Each dim must be at least 5.") dims
  let _ = Printf.printf "Evaluating Ndarray of rank %d with dims: [" rank
  let _ = Array.iter (fun d -> Printf.printf "%d " d) dims
  let _ = Printf.printf "]\n"

  let slice_def = List.init rank (fun i -> [~- (dims.(i) / 4); dims.(i) / 4])
  let _ =
    Printf.printf "Slice size: ";
    List.iter (function
          [a; b] -> Printf.printf "[%d, %d] " a b
        | _ -> ()) slice_def;
    Printf.printf "\n"

  let v = M.empty dims
  let s = M.get_slice slice_def v
  let s = M.empty (M.shape s)

  let _ =
    Printf.printf "Slice dims: ";
    Array.iter (fun d -> Printf.printf "%d " d) (M.shape s);
    Printf.printf "\n"

  let _ =
    begin
      for rep = 0 to 10 do
        let _ = M.get_slice slice_def v in
        let _ = M.set_slice slice_def v s in
        ()
      done
    end

  let _ = Printf.printf "Done!\n"

end
