module Make (M : Owl_types.Ndarray_Basic) = struct
  let wrap_fun () =
    let x = M.sequential [|4; 4|] in
    M.print x

  let _ = Function_timer.time_function wrap_fun
end
