module Make(M : Owl_types.Ndarray_Basic) = struct
  let _ = Printf.printf "Evaluating indexing operations\n"

  let rank = (Array.length Sys.argv) - 1

  let _ =
    if (rank <= 0)
    then failwith "ERROR! Must provide the dimensions of the Ndarray."

  let dims = Array.init rank (fun i -> int_of_string Sys.argv.(i + 1))
  let _ = Printf.printf "Evaluating Ndarray of rank %d with dims: [" rank
  let _ = Array.iter (fun d -> Printf.printf "%d " d) dims
  let _ = Printf.printf "]\n"

  let v = M.empty dims
  let n = M.numel v

  let stride = Owl_utils.calc_stride dims
  let ind = Array.init rank (fun _ -> 0)
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

  let _ = Printf.printf "Done!\n"

end
