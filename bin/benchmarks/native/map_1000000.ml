module Size = struct
  let size = 1000000
end

module M = Map_generic.Make(Owl_dense_ndarray.S)
include M.MakeOfSize(Size)
