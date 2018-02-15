module Make(M : Owl_types.Ndarray_Basic) = struct
  let wrap_fun () =
    let _ = Printf.printf "Evaluating map operation\n" in

    let rank = (Array.length Sys.argv) - 1 in

    let _ =
      if (rank <= 0)
      then failwith "ERROR! Must provide the dimensions of the Ndarray." in

    let dims = Array.init rank (fun i -> int_of_string Sys.argv.(i + 1)) in
    let _ = Printf.printf "Evaluating Ndarray of rank %d with dims: [" rank in
    let _ = Array.iter (fun d -> Printf.printf "%d " d) dims in
    let _ = Printf.printf "]\n" in

    let f0 = (fun _ -> 0.) in
    let f1 = (fun _ -> 1.) in
    let f2 = (fun x -> x +. 11.) in
    let f3 = (fun x -> x *. 2.) in
    let f4 = (fun x -> x /. 2.) in

    let funs = [f0; f1; f2; f3; f4] in

    let v = ref (M.empty dims) in

    let _ =
      begin
        for rep = 0 to 10 do
          List.iter (fun f -> v := M.map f !v) funs
        done
      end
    in
    Printf.printf "Done!\n"

  let _ = Function_timer.time_function wrap_fun
end
