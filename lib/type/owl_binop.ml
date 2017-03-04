

module DAS_DAS = struct

  module M = Owl_dense_ndarray_x.S

  let ( + ) x y = M.add x y
  let ( - ) x y = M.sub x y
  let ( * ) x y = M.mul x y
  let ( / ) x y = M.div x y

end


module DAS_F = struct

  module M = Owl_dense_ndarray_x.S

  let ( + ) x a = M.add_scalar x a
  let ( - ) x a = M.sub_scalar x a
  let ( * ) x a = M.mul_scalar x a
  let ( / ) x a = M.div_scalar x a

end
