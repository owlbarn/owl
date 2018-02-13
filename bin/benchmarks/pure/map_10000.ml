module Size = struct
  let size = 10000
end

module M = Map_generic.Make(Owl_base_dense_ndarray.S)
include M.MakeOfSize(Size)
