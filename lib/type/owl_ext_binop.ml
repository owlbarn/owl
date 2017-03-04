
open Owl_ext_types


module F_F = struct

  module M = Pervasives

  let ( + ) x y = F M.(x +. y)
  let ( - ) x y = F M.(x -. y)
  let ( * ) x y = F M.(x *. y)
  let ( / ) x y = F M.(x /. y)

end


module F_C = struct

  module M = Complex

  let ( + ) x y = C M.(add {re = x; im = 0.} y)
  let ( - ) x y = C M.(sub {re = x; im = 0.} y)
  let ( * ) x y = C M.(mul {re = x; im = 0.} y)
  let ( / ) x y = C M.(add {re = x; im = 0.} y)

end


module C_F = struct

  module M = Complex

  let ( + ) x y = C M.(add x {re = y; im = 0.})
  let ( - ) x y = C M.(sub x {re = y; im = 0.})
  let ( * ) x y = C M.(mul x {re = y; im = 0.})
  let ( / ) x y = C M.(div x {re = y; im = 0.})

end


module C_C = struct

  module M = Complex

  let ( + ) x y = C M.(add x y)
  let ( - ) x y = C M.(sub x y)
  let ( * ) x y = C M.(mul x y)
  let ( / ) x y = C M.(div x y)

end


module DAS_DAS = struct

  module M = Owl_ext_dense_ndarray.S

  let ( + ) x y = M.add x y
  let ( - ) x y = M.sub x y
  let ( * ) x y = M.mul x y
  let ( / ) x y = M.div x y

end


module DAS_F = struct

  module M = Owl_ext_dense_ndarray.S

  let ( + ) x a = M.add_scalar x a
  let ( - ) x a = M.sub_scalar x a
  let ( * ) x a = M.mul_scalar x a
  let ( / ) x a = M.div_scalar x a

end


module F_DAS = struct

  module M = Owl_ext_dense_ndarray.S

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)

end

(* FIXME : lift type *)
module C_DAS = struct

  module M = Owl_ext_dense_ndarray.S

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)

end

(* FIXME : lift type *)
module DAS_C = struct

  module M = Owl_ext_dense_ndarray.S

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)

end


(* overload binary operators *)

let ( + ) x y = match x, y with
  | F x, F y   -> F_F.(x + y)
  | F x, C y   -> F_C.(x + y)
  | C x, F y   -> C_F.(x + y)
  | C x, C y   -> C_C.(x + y)
  | F _, DAS _ -> F_DAS.(x + y)
  | DAS _, F _ -> DAS_F.(x + y)
  | C _, DAS _ -> C_DAS.(x + y)
  | DAS _, C _ -> DAS_C.(x + y)
  | DAS _, DAS _ -> DAS_DAS.(x + y)
  | _ -> failwith "( + ) : unknown type"



(* ends here *)
