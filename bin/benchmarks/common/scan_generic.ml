module Make(M : Owl_types.Ndarray_Basic) = struct

  let rank = (Array.length Sys.argv) - 1

  let _ =
    if (rank <= 0)
    then failwith "ERROR! Must provide the dimensions of the Ndarray."

  let dims = Array.init rank (fun i -> int_of_string Sys.argv.(i + 1))
  let _ = Printf.printf "Evaluating Ndarray of rank %d with dims: [" rank
  let _ = Array.iter (fun d -> Printf.printf "%d " d) dims
  let _ = Printf.printf "]\n"

  let v = ref (M.empty dims)

  let _ =
    begin
      for rep = 0 to 10 do
        for axis = 0 to rank - 1 do
          v := M.scan ~axis (fun x y -> x +. 1.) !v
        done
      done
    end

  let _ = Printf.printf "Done!\n"

end
