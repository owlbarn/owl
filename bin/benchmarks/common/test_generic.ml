module Make (M : Owl_types.Ndarray_Basic) = struct
  let x = M.sequential [|4; 4|]
  let _ = M.print x
end
