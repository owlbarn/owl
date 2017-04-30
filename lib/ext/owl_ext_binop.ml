(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_ext_types


(* error handling *)

let error_binop op x y =
  let s0 = type_info x in
  let s1 = type_info y in
  failwith (op ^ " : " ^ s0 ^ ", " ^ s1)


(* trivial cases *)

module F_F = struct

  module M = Pervasives

  let ( + ) x y = F M.(x +. y)
  let ( - ) x y = F M.(x -. y)
  let ( * ) x y = F M.(x *. y)
  let ( / ) x y = F M.(x /. y)
  let ( ** ) x y = F M.( x ** y)
  let ( = ) x y = Pervasives.(x = y)
  let ( <> ) x y = Pervasives.(x <> y)
  let ( > ) x y = Pervasives.(x > y)
  let ( < ) x y = Pervasives.(x < y)
  let ( >= ) x y = Pervasives.(x >= y)
  let ( <= ) x y = Pervasives.(x <= y)
  let min2 x y = F Pervasives.(min x y)
  let max2 x y = F Pervasives.(max x y)

end


module F_C = struct

  module M = Complex

  let ( + ) x y = C M.(add {re = x; im = 0.} y)
  let ( - ) x y = C M.(sub {re = x; im = 0.} y)
  let ( * ) x y = C M.(mul {re = x; im = 0.} y)
  let ( / ) x y = C M.(add {re = x; im = 0.} y)
  let ( ** ) x y = C M.(pow {re = x; im = 0.} y)
  let ( = ) x y = Pervasives.(M.({re = x; im = 0.}) = y)
  let ( <> ) x y = Pervasives.(M.({re = x; im = 0.}) <> y)
  let ( > ) x y = Pervasives.(M.({re = x; im = 0.}) > y)
  let ( < ) x y = Pervasives.(M.({re = x; im = 0.}) < y)
  let ( >= ) x y = Pervasives.(M.({re = x; im = 0.}) >= y)
  let ( <= ) x y = Pervasives.(M.({re = x; im = 0.}) <= y)

end


module C_F = struct

  module M = Complex

  let ( + ) x y = C M.(add x {re = y; im = 0.})
  let ( - ) x y = C M.(sub x {re = y; im = 0.})
  let ( * ) x y = C M.(mul x {re = y; im = 0.})
  let ( / ) x y = C M.(div x {re = y; im = 0.})
  let ( ** ) x y = C M.(pow x {re = y; im = 0.})
  let ( = ) x y = Pervasives.(x = M.({re = y; im = 0.}))
  let ( <> ) x y = Pervasives.(x <> M.({re = y; im = 0.}))
  let ( > ) x y = Pervasives.(x > M.({re = y; im = 0.}))
  let ( < ) x y = Pervasives.(x < M.({re = y; im = 0.}))
  let ( >= ) x y = Pervasives.(x >= M.({re = y; im = 0.}))
  let ( <= ) x y = Pervasives.(x <= M.({re = y; im = 0.}))

end


module C_C = struct

  module M = Complex

  let ( + ) x y = C M.(add x y)
  let ( - ) x y = C M.(sub x y)
  let ( * ) x y = C M.(mul x y)
  let ( / ) x y = C M.(div x y)
  let ( ** ) x y = C M.(pow x y)
  let ( = ) x y = Pervasives.(x = y)
  let ( <> ) x y = Pervasives.(x <> y)
  let ( > ) x y = Pervasives.(x > y)
  let ( < ) x y = Pervasives.(x < y)
  let ( >= ) x y = Pervasives.(x >= y)
  let ( <= ) x y = Pervasives.(x <= y)

end

(* float numbers, no lift *)

module F_DAS = struct

  module M = Owl_ext_dense_ndarray.S

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)
  let ( ** ) a x = M.pow0 a x

end


module DAS_F = struct

  module M = Owl_ext_dense_ndarray.S

  let ( + ) x a = M.add_scalar x a
  let ( - ) x a = M.sub_scalar x a
  let ( * ) x a = M.mul_scalar x a
  let ( / ) x a = M.div_scalar x a
  let ( ** ) x a = M.pow1 x a

end


module DAS_DAS = struct

  module M = Owl_ext_dense_ndarray.S

  let ( + ) x y = M.add x y
  let ( - ) x y = M.sub x y
  let ( * ) x y = M.mul x y
  let ( / ) x y = M.div x y
  let ( ** ) x y = M.pow x y
  let ( = ) x y = M.equal x y
  let ( <> ) x y = M.not_equal x y
  let ( > ) x y = M.greater x y
  let ( < ) x y = M.less x y
  let ( >= ) x y = M.greater_equal x y
  let ( <= ) x y = M.less_equal x y
  let ( =. ) x y = M.elt_equal x y
  let ( <>. ) x y = M.elt_not_equal x y
  let ( >. ) x y = M.elt_greater x y
  let ( <. ) x y = M.elt_less x y
  let ( >=. ) x y = M.elt_greater_equal x y
  let ( <=. ) x y = M.elt_less_equal x y
  let min2 x y = M.min2 x y
  let max2 x y = M.max2 x y

end


module F_DAD = struct

  module M = Owl_ext_dense_ndarray.D

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)
  let ( ** ) a x = M.pow0 a x

end


module DAD_F = struct

  module M = Owl_ext_dense_ndarray.D

  let ( + ) x a = M.add_scalar x a
  let ( - ) x a = M.sub_scalar x a
  let ( * ) x a = M.mul_scalar x a
  let ( / ) x a = M.div_scalar x a
  let ( ** ) x a = M.pow1 x a

end


module DAD_DAD = struct

  module M = Owl_ext_dense_ndarray.D

  let ( + ) x y = M.add x y
  let ( - ) x y = M.sub x y
  let ( * ) x y = M.mul x y
  let ( / ) x y = M.div x y
  let ( ** ) x y = M.pow x y
  let ( = ) x y = M.equal x y
  let ( <> ) x y = M.not_equal x y
  let ( > ) x y = M.greater x y
  let ( < ) x y = M.less x y
  let ( >= ) x y = M.greater_equal x y
  let ( <= ) x y = M.less_equal x y
  let ( =. ) x y = M.elt_equal x y
  let ( <>. ) x y = M.elt_not_equal x y
  let ( >. ) x y = M.elt_greater x y
  let ( <. ) x y = M.elt_less x y
  let ( >=. ) x y = M.elt_greater_equal x y
  let ( <=. ) x y = M.elt_less_equal x y
  let min2 x y = M.min2 x y
  let max2 x y = M.max2 x y

end


module F_DMS = struct

  module M = Owl_ext_dense_matrix.S

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)
  let ( ** ) a x = M.pow0 a x

end


module DMS_F = struct

  module M = Owl_ext_dense_matrix.S

  let ( + ) x a = M.add_scalar x a
  let ( - ) x a = M.sub_scalar x a
  let ( * ) x a = M.mul_scalar x a
  let ( / ) x a = M.div_scalar x a
  let ( ** ) x a = M.pow1 x a

end


module DMS_DMS = struct

  module M = Owl_ext_dense_matrix.S

  let ( + ) x y = M.add x y
  let ( - ) x y = M.sub x y
  let ( * ) x y = M.mul x y
  let ( / ) x y = M.div x y
  let ( ** ) x y = M.pow x y
  let ( = ) x y = M.equal x y
  let ( <> ) x y = M.not_equal x y
  let ( > ) x y = M.greater x y
  let ( < ) x y = M.less x y
  let ( >= ) x y = M.greater_equal x y
  let ( <= ) x y = M.less_equal x y
  let ( =. ) x y = M.elt_equal x y
  let ( <>. ) x y = M.elt_not_equal x y
  let ( >. ) x y = M.elt_greater x y
  let ( <. ) x y = M.elt_less x y
  let ( >=. ) x y = M.elt_greater_equal x y
  let ( <=. ) x y = M.elt_less_equal x y
  let min2 x y = M.min2 x y
  let max2 x y = M.max2 x y

end


module F_DMD = struct

  module M = Owl_ext_dense_matrix.D

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)
  let ( ** ) a x = M.pow0 a x

end


module DMD_F = struct

  module M = Owl_ext_dense_matrix.D

  let ( + ) x a = M.add_scalar x a
  let ( - ) x a = M.sub_scalar x a
  let ( * ) x a = M.mul_scalar x a
  let ( / ) x a = M.div_scalar x a
  let ( ** ) x a = M.pow1 x a

end


module DMD_DMD = struct

  module M = Owl_ext_dense_matrix.D

  let ( + ) x y = M.add x y
  let ( - ) x y = M.sub x y
  let ( * ) x y = M.mul x y
  let ( / ) x y = M.div x y
  let ( ** ) x y = M.pow x y
  let ( = ) x y = M.equal x y
  let ( <> ) x y = M.not_equal x y
  let ( > ) x y = M.greater x y
  let ( < ) x y = M.less x y
  let ( >= ) x y = M.greater_equal x y
  let ( <= ) x y = M.less_equal x y
  let ( =. ) x y = M.elt_equal x y
  let ( <>. ) x y = M.elt_not_equal x y
  let ( >. ) x y = M.elt_greater x y
  let ( <. ) x y = M.elt_less x y
  let ( >=. ) x y = M.elt_greater_equal x y
  let ( <=. ) x y = M.elt_less_equal x y
  let min2 x y = M.min2 x y
  let max2 x y = M.max2 x y

end

(* complex numbers, no lift *)

module C_DAC = struct

  module M = Owl_ext_dense_ndarray.C

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)

end


module DAC_C = struct

  module M = Owl_ext_dense_ndarray.C

  let ( + ) x a = M.add_scalar x a
  let ( - ) x a = M.sub_scalar x a
  let ( * ) x a = M.mul_scalar x a
  let ( / ) x a = M.div_scalar x a

end


module DAC_DAC = struct

  module M = Owl_ext_dense_ndarray.C

  let ( + ) x y = M.add x y
  let ( - ) x y = M.sub x y
  let ( * ) x y = M.mul x y
  let ( / ) x y = M.div x y
  let ( = ) x y = M.equal x y
  let ( <> ) x y = M.not_equal x y
  let ( > ) x y = M.greater x y
  let ( < ) x y = M.less x y
  let ( >= ) x y = M.greater_equal x y
  let ( <= ) x y = M.less_equal x y
  let ( =. ) x y = M.elt_equal x y
  let ( <>. ) x y = M.elt_not_equal x y
  let ( >. ) x y = M.elt_greater x y
  let ( <. ) x y = M.elt_less x y
  let ( >=. ) x y = M.elt_greater_equal x y
  let ( <=. ) x y = M.elt_less_equal x y

end


module C_DAZ = struct

  module M = Owl_ext_dense_ndarray.Z

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)

end


module DAZ_C = struct

  module M = Owl_ext_dense_ndarray.Z

  let ( + ) x a = M.add_scalar x a
  let ( - ) x a = M.sub_scalar x a
  let ( * ) x a = M.mul_scalar x a
  let ( / ) x a = M.div_scalar x a

end


module DAZ_DAZ = struct

  module M = Owl_ext_dense_ndarray.Z

  let ( + ) x y = M.add x y
  let ( - ) x y = M.sub x y
  let ( * ) x y = M.mul x y
  let ( / ) x y = M.div x y
  let ( = ) x y = M.equal x y
  let ( <> ) x y = M.not_equal x y
  let ( > ) x y = M.greater x y
  let ( < ) x y = M.less x y
  let ( >= ) x y = M.greater_equal x y
  let ( <= ) x y = M.less_equal x y
  let ( =. ) x y = M.elt_equal x y
  let ( <>. ) x y = M.elt_not_equal x y
  let ( >. ) x y = M.elt_greater x y
  let ( <. ) x y = M.elt_less x y
  let ( >=. ) x y = M.elt_greater_equal x y
  let ( <=. ) x y = M.elt_less_equal x y

end


module C_DMC = struct

  module M = Owl_ext_dense_matrix.C

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)

end


module DMC_C = struct

  module M = Owl_ext_dense_matrix.C

  let ( + ) x a = M.add_scalar x a
  let ( - ) x a = M.sub_scalar x a
  let ( * ) x a = M.mul_scalar x a
  let ( / ) x a = M.div_scalar x a

end


module DMC_DMC = struct

  module M = Owl_ext_dense_matrix.C

  let ( + ) x y = M.add x y
  let ( - ) x y = M.sub x y
  let ( * ) x y = M.mul x y
  let ( / ) x y = M.div x y
  let ( = ) x y = M.equal x y
  let ( <> ) x y = M.not_equal x y
  let ( > ) x y = M.greater x y
  let ( < ) x y = M.less x y
  let ( >= ) x y = M.greater_equal x y
  let ( <= ) x y = M.less_equal x y
  let ( =. ) x y = M.elt_equal x y
  let ( <>. ) x y = M.elt_not_equal x y
  let ( >. ) x y = M.elt_greater x y
  let ( <. ) x y = M.elt_less x y
  let ( >=. ) x y = M.elt_greater_equal x y
  let ( <=. ) x y = M.elt_less_equal x y

end


module C_DMZ = struct

  module M = Owl_ext_dense_matrix.Z

  let ( + ) a x = M.add_scalar x a
  let ( - ) a x = M.(sub_scalar x a |> neg)
  let ( * ) a x = M.mul_scalar x a
  let ( / ) a x = M.(mul_scalar (reci x) a)

end


module DMZ_C = struct

  module M = Owl_ext_dense_matrix.Z

  let ( + ) x a = M.add_scalar x a
  let ( - ) x a = M.sub_scalar x a
  let ( * ) x a = M.mul_scalar x a
  let ( / ) x a = M.div_scalar x a

end


module DMZ_DMZ = struct

  module M = Owl_ext_dense_matrix.Z

  let ( + ) x y = M.add x y
  let ( - ) x y = M.sub x y
  let ( * ) x y = M.mul x y
  let ( / ) x y = M.div x y
  let ( = ) x y = M.equal x y
  let ( <> ) x y = M.not_equal x y
  let ( > ) x y = M.greater x y
  let ( < ) x y = M.less x y
  let ( >= ) x y = M.greater_equal x y
  let ( <= ) x y = M.less_equal x y
  let ( =. ) x y = M.elt_equal x y
  let ( <>. ) x y = M.elt_not_equal x y
  let ( >. ) x y = M.elt_greater x y
  let ( <. ) x y = M.elt_less x y
  let ( >=. ) x y = M.elt_greater_equal x y
  let ( <=. ) x y = M.elt_less_equal x y

end


(* float/complex, lift precision *)

module DAS_DAD = struct

  module M = Owl_ext_dense_ndarray.D
  let lift = Owl_ext_lifts.DAS_DAD.lift

  let ( + ) x y = M.add (lift x) y
  let ( - ) x y = M.sub (lift x) y
  let ( * ) x y = M.mul (lift x) y
  let ( / ) x y = M.div (lift x) y
  let ( ** ) x y = M.pow (lift x) y
  let min2 x y = M.min2 (lift x) y
  let max2 x y = M.max2 (lift x) y

end


module DAD_DAS = struct

  module M = Owl_ext_dense_ndarray.D
  let lift = Owl_ext_lifts.DAS_DAD.lift

  let ( + ) x y = M.add x (lift y)
  let ( - ) x y = M.sub x (lift y)
  let ( * ) x y = M.mul x (lift y)
  let ( / ) x y = M.div x (lift y)
  let ( ** ) x y = M.pow x (lift y)
  let min2 x y = M.min2 x (lift y)
  let max2 x y = M.max2 x (lift y)

end


module DAC_DAZ = struct

  module M = Owl_ext_dense_ndarray.Z
  let lift = Owl_ext_lifts.DAC_DAZ.lift

  let ( + ) x y = M.add (lift x) y
  let ( - ) x y = M.sub (lift x) y
  let ( * ) x y = M.mul (lift x) y
  let ( / ) x y = M.div (lift x) y

end


module DAZ_DAC = struct

  module M = Owl_ext_dense_ndarray.Z
  let lift = Owl_ext_lifts.DAC_DAZ.lift

  let ( + ) x y = M.add x (lift y)
  let ( - ) x y = M.sub x (lift y)
  let ( * ) x y = M.mul x (lift y)
  let ( / ) x y = M.div x (lift y)

end


module DMS_DMD = struct

  module M = Owl_ext_dense_matrix.D
  let lift = Owl_ext_lifts.DMS_DMD.lift

  let ( + ) x y = M.add (lift x) y
  let ( - ) x y = M.sub (lift x) y
  let ( * ) x y = M.mul (lift x) y
  let ( / ) x y = M.div (lift x) y
  let ( ** ) x y = M.pow (lift x) y
  let min2 x y = M.min2 (lift x) y
  let max2 x y = M.max2 (lift x) y

end


module DMD_DMS = struct

  module M = Owl_ext_dense_matrix.D
  let lift = Owl_ext_lifts.DMS_DMD.lift

  let ( + ) x y = M.add x (lift y)
  let ( - ) x y = M.sub x (lift y)
  let ( * ) x y = M.mul x (lift y)
  let ( / ) x y = M.div x (lift y)
  let ( ** ) x y = M.pow x (lift y)
  let min2 x y = M.min2 x (lift y)
  let max2 x y = M.max2 x (lift y)

end


module DMC_DMZ = struct

  module M = Owl_ext_dense_matrix.Z
  let lift = Owl_ext_lifts.DMC_DMZ.lift

  let ( + ) x y = M.add (lift x) y
  let ( - ) x y = M.sub (lift x) y
  let ( * ) x y = M.mul (lift x) y
  let ( / ) x y = M.div (lift x) y

end


module DMZ_DMC = struct

  module M = Owl_ext_dense_matrix.Z
  let lift = Owl_ext_lifts.DMC_DMZ.lift

  let ( + ) x y = M.add x (lift y)
  let ( - ) x y = M.sub x (lift y)
  let ( * ) x y = M.mul x (lift y)
  let ( / ) x y = M.div x (lift y)

end


(* float -> complex, lift number type *)

module F_DAC = struct

  module M = Owl_ext_dense_ndarray.C
  let lift = Owl_ext_lifts.F_C.lift

  let ( + ) a x = M.add_scalar x (lift a)
  let ( - ) a x = M.(sub_scalar x (lift a) |> neg)
  let ( * ) a x = M.mul_scalar x (lift a)
  let ( / ) a x = M.(mul_scalar (reci x) (lift a))

end


module DAC_F = struct

  module M = Owl_ext_dense_ndarray.C
  let lift = Owl_ext_lifts.F_C.lift

  let ( + ) x a = M.add_scalar x (lift a)
  let ( - ) x a = M.sub_scalar x (lift a)
  let ( * ) x a = M.mul_scalar x (lift a)
  let ( / ) x a = M.div_scalar x (lift a)

end


module F_DAZ = struct

  module M = Owl_ext_dense_ndarray.Z
  let lift = Owl_ext_lifts.F_C.lift

  let ( + ) a x = M.add_scalar x (lift a)
  let ( - ) a x = M.(sub_scalar x (lift a) |> neg)
  let ( * ) a x = M.mul_scalar x (lift a)
  let ( / ) a x = M.(mul_scalar (reci x) (lift a))

end


module DAZ_F = struct

  module M = Owl_ext_dense_ndarray.Z
  let lift = Owl_ext_lifts.F_C.lift

  let ( + ) x a = M.add_scalar x (lift a)
  let ( - ) x a = M.sub_scalar x (lift a)
  let ( * ) x a = M.mul_scalar x (lift a)
  let ( / ) x a = M.div_scalar x (lift a)

end


module C_DAS = struct

  module M = Owl_ext_dense_ndarray.C
  let lift = Owl_ext_lifts.DAS_DAC.lift

  let ( + ) a x = M.add_scalar (lift x) a
  let ( - ) a x = M.(sub_scalar (lift x) a |> neg)
  let ( * ) a x = M.mul_scalar (lift x) a
  let ( / ) a x = M.(mul_scalar (reci (lift x)) a)

end


module DAS_C = struct

  module M = Owl_ext_dense_ndarray.C
  let lift = Owl_ext_lifts.DAS_DAC.lift

  let ( + ) x a = M.add_scalar (lift x) a
  let ( - ) x a = M.sub_scalar (lift x) a
  let ( * ) x a = M.mul_scalar (lift x) a
  let ( / ) x a = M.div_scalar (lift x) a

end


module C_DAD = struct

  module M = Owl_ext_dense_ndarray.Z
  let lift = Owl_ext_lifts.DAD_DAZ.lift

  let ( + ) a x = M.add_scalar (lift x) a
  let ( - ) a x = M.(sub_scalar (lift x) a |> neg)
  let ( * ) a x = M.mul_scalar (lift x) a
  let ( / ) a x = M.(mul_scalar (reci (lift x)) a)

end


module DAD_C = struct

  module M = Owl_ext_dense_ndarray.Z
  let lift = Owl_ext_lifts.DAD_DAZ.lift

  let ( + ) x a = M.add_scalar (lift x) a
  let ( - ) x a = M.sub_scalar (lift x) a
  let ( * ) x a = M.mul_scalar (lift x) a
  let ( / ) x a = M.div_scalar (lift x) a

end


module DAS_DAC = struct

  module M = Owl_ext_dense_ndarray.C
  let lift = Owl_ext_lifts.DAS_DAC.lift

  let ( + ) x y = M.add (lift x) y
  let ( - ) x y = M.sub (lift x) y
  let ( * ) x y = M.mul (lift x) y
  let ( / ) x y = M.div (lift x) y

end


module DAC_DAS = struct

  module M = Owl_ext_dense_ndarray.C
  let lift = Owl_ext_lifts.DAS_DAC.lift

  let ( + ) x y = M.add x (lift y)
  let ( - ) x y = M.sub x (lift y)
  let ( * ) x y = M.mul x (lift y)
  let ( / ) x y = M.div x (lift y)

end


module DAD_DAZ = struct

  module M = Owl_ext_dense_ndarray.Z
  let lift = Owl_ext_lifts.DAD_DAZ.lift

  let ( + ) x y = M.add (lift x) y
  let ( - ) x y = M.sub (lift x) y
  let ( * ) x y = M.mul (lift x) y
  let ( / ) x y = M.div (lift x) y

end


module DAZ_DAD = struct

  module M = Owl_ext_dense_ndarray.Z
  let lift = Owl_ext_lifts.DAD_DAZ.lift

  let ( + ) x y = M.add x (lift y)
  let ( - ) x y = M.sub x (lift y)
  let ( * ) x y = M.mul x (lift y)
  let ( / ) x y = M.div x (lift y)

end


module F_DMC = struct

  module M = Owl_ext_dense_matrix.C
  let lift = Owl_ext_lifts.F_C.lift

  let ( + ) a x = M.add_scalar x (lift a)
  let ( - ) a x = M.(sub_scalar x (lift a) |> neg)
  let ( * ) a x = M.mul_scalar x (lift a)
  let ( / ) a x = M.(mul_scalar (reci x) (lift a))

end


module DMC_F = struct

  module M = Owl_ext_dense_matrix.C
  let lift = Owl_ext_lifts.F_C.lift

  let ( + ) x a = M.add_scalar x (lift a)
  let ( - ) x a = M.sub_scalar x (lift a)
  let ( * ) x a = M.mul_scalar x (lift a)
  let ( / ) x a = M.div_scalar x (lift a)

end


module F_DMZ = struct

  module M = Owl_ext_dense_matrix.Z
  let lift = Owl_ext_lifts.F_C.lift

  let ( + ) a x = M.add_scalar x (lift a)
  let ( - ) a x = M.(sub_scalar x (lift a) |> neg)
  let ( * ) a x = M.mul_scalar x (lift a)
  let ( / ) a x = M.(mul_scalar (reci x) (lift a))

end


module DMZ_F = struct

  module M = Owl_ext_dense_matrix.Z
  let lift = Owl_ext_lifts.F_C.lift

  let ( + ) x a = M.add_scalar x (lift a)
  let ( - ) x a = M.sub_scalar x (lift a)
  let ( * ) x a = M.mul_scalar x (lift a)
  let ( / ) x a = M.div_scalar x (lift a)

end


module C_DMS = struct

  module M = Owl_ext_dense_matrix.C
  let lift = Owl_ext_lifts.DMS_DMC.lift

  let ( + ) a x = M.add_scalar (lift x) a
  let ( - ) a x = M.(sub_scalar (lift x) a |> neg)
  let ( * ) a x = M.mul_scalar (lift x) a
  let ( / ) a x = M.(mul_scalar (reci (lift x)) a)

end


module DMS_C = struct

  module M = Owl_ext_dense_matrix.C
  let lift = Owl_ext_lifts.DMS_DMC.lift

  let ( + ) x a = M.add_scalar (lift x) a
  let ( - ) x a = M.sub_scalar (lift x) a
  let ( * ) x a = M.mul_scalar (lift x) a
  let ( / ) x a = M.div_scalar (lift x) a

end


module C_DMD = struct

  module M = Owl_ext_dense_matrix.Z
  let lift = Owl_ext_lifts.DMD_DMZ.lift

  let ( + ) a x = M.add_scalar (lift x) a
  let ( - ) a x = M.(sub_scalar (lift x) a |> neg)
  let ( * ) a x = M.mul_scalar (lift x) a
  let ( / ) a x = M.(mul_scalar (reci (lift x)) a)

end


module DMD_C = struct

  module M = Owl_ext_dense_matrix.Z
  let lift = Owl_ext_lifts.DMD_DMZ.lift

  let ( + ) x a = M.add_scalar (lift x) a
  let ( - ) x a = M.sub_scalar (lift x) a
  let ( * ) x a = M.mul_scalar (lift x) a
  let ( / ) x a = M.div_scalar (lift x) a

end


module DMS_DMC = struct

  module M = Owl_ext_dense_matrix.C
  let lift = Owl_ext_lifts.DMS_DMC.lift

  let ( + ) x y = M.add (lift x) y
  let ( - ) x y = M.sub (lift x) y
  let ( * ) x y = M.mul (lift x) y
  let ( / ) x y = M.div (lift x) y

end


module DMC_DMS = struct

  module M = Owl_ext_dense_matrix.C
  let lift = Owl_ext_lifts.DMS_DMC.lift

  let ( + ) x y = M.add x (lift y)
  let ( - ) x y = M.sub x (lift y)
  let ( * ) x y = M.mul x (lift y)
  let ( / ) x y = M.div x (lift y)

end


module DMD_DMZ = struct

  module M = Owl_ext_dense_matrix.Z
  let lift = Owl_ext_lifts.DMD_DMZ.lift

  let ( + ) x y = M.add (lift x) y
  let ( - ) x y = M.sub (lift x) y
  let ( * ) x y = M.mul (lift x) y
  let ( / ) x y = M.div (lift x) y

end


module DMZ_DMD = struct

  module M = Owl_ext_dense_matrix.Z
  let lift = Owl_ext_lifts.DMD_DMZ.lift

  let ( + ) x y = M.add x (lift y)
  let ( - ) x y = M.sub x (lift y)
  let ( * ) x y = M.mul x (lift y)
  let ( / ) x y = M.div x (lift y)

end


(* float -> complex, lift both precision and number type *)

module DAS_DAZ = struct

  module M = Owl_ext_dense_ndarray.Z
  let lift = Owl_ext_lifts.DAS_DAZ.lift

  let ( + ) x y = M.add (lift x) y
  let ( - ) x y = M.sub (lift x) y
  let ( * ) x y = M.mul (lift x) y
  let ( / ) x y = M.div (lift x) y

end


module DAZ_DAS = struct

  module M = Owl_ext_dense_ndarray.Z
  let lift = Owl_ext_lifts.DAS_DAZ.lift

  let ( + ) x y = M.add x (lift y)
  let ( - ) x y = M.sub x (lift y)
  let ( * ) x y = M.mul x (lift y)
  let ( / ) x y = M.div x (lift y)

end


module DMS_DMZ = struct

  module M = Owl_ext_dense_matrix.Z
  let lift = Owl_ext_lifts.DMS_DMZ.lift

  let ( + ) x y = M.add (lift x) y
  let ( - ) x y = M.sub (lift x) y
  let ( * ) x y = M.mul (lift x) y
  let ( / ) x y = M.div (lift x) y

end


module DMZ_DMS = struct

  module M = Owl_ext_dense_matrix.Z
  let lift = Owl_ext_lifts.DMS_DMZ.lift

  let ( + ) x y = M.add x (lift y)
  let ( - ) x y = M.sub x (lift y)
  let ( * ) x y = M.mul x (lift y)
  let ( / ) x y = M.div x (lift y)

end

(* TODO: DMC_DMD ... *)


(* overload binary operators *)

let ( + ) x y = match x, y with
  | F x, F y     -> F_F.(x + y)
  | F x, C y     -> F_C.(x + y)
  | C x, F y     -> C_F.(x + y)
  | C x, C y     -> C_C.(x + y)
  | F _, DAS _   -> F_DAS.(x + y)
  | DAS _, F _   -> DAS_F.(x + y)
  | DAS _, DAS _ -> DAS_DAS.(x + y)
  | F _, DAD _   -> F_DAD.(x + y)
  | DAD _, F _   -> DAD_F.(x + y)
  | DAD _, DAD _ -> DAD_DAD.(x + y)
  | F _, DMS _   -> F_DMS.(x + y)
  | DMS _, F _   -> DMS_F.(x + y)
  | DMS _, DMS _ -> DMS_DMS.(x + y)
  | F _, DMD _   -> F_DMD.(x + y)
  | DMD _, F _   -> DMD_F.(x + y)
  | DMD _, DMD _ -> DMD_DMD.(x + y)
  | C _, DAC _   -> C_DAC.(x + y)
  | DAC _, C _   -> DAC_C.(x + y)
  | DAC _, DAC _ -> DAC_DAC.(x + y)
  | C _, DAZ _   -> C_DAZ.(x + y)
  | DAZ _, C _   -> DAZ_C.(x + y)
  | DAZ _, DAZ _ -> DAZ_DAZ.(x + y)
  | C _, DMC _   -> C_DMC.(x + y)
  | DMC _, C _   -> DMC_C.(x + y)
  | DMC _, DMC _ -> DMC_DMC.(x + y)
  | C _, DMZ _   -> C_DMZ.(x + y)
  | DMZ _, C _   -> DMZ_C.(x + y)
  | DMZ _, DMZ _ -> DMZ_DMZ.(x + y)
  | DAS _, DAD _ -> DAS_DAD.(x + y)
  | DAD _, DAS _ -> DAD_DAS.(x + y)
  | DAC _, DAZ _ -> DAC_DAZ.(x + y)
  | DAZ _, DAC _ -> DAZ_DAC.(x + y)
  | DMS _, DMD _ -> DMS_DMD.(x + y)
  | DMD _, DMS _ -> DMD_DMS.(x + y)
  | DMC _, DMZ _ -> DMC_DMZ.(x + y)
  | DMZ _, DMC _ -> DMZ_DMC.(x + y)
  | F _, DAC _   -> F_DAC.(x + y)
  | DAC _, F _   -> DAC_F.(x + y)
  | F _, DAZ _   -> F_DAZ.(x + y)
  | DAZ _, F _   -> DAZ_F.(x + y)
  | C _, DAS _   -> C_DAS.(x + y)
  | DAS _, C _   -> DAS_C.(x + y)
  | C _, DAD _   -> C_DAD.(x + y)
  | DAD _, C _   -> DAD_C.(x + y)
  | DAS _, DAC _ -> DAS_DAC.(x + y)
  | DAC _, DAS _ -> DAC_DAS.(x + y)
  | DAD _, DAZ _ -> DAD_DAZ.(x + y)
  | DAZ _, DAD _ -> DAZ_DAD.(x + y)
  | F _, DMC _   -> F_DMC.(x + y)
  | DMC _, F _   -> DMC_F.(x + y)
  | F _, DMZ _   -> F_DMZ.(x + y)
  | DMZ _, F _   -> DMZ_F.(x + y)
  | C _, DMS _   -> C_DMS.(x + y)
  | DMS _, C _   -> DMS_C.(x + y)
  | C _, DMD _   -> C_DMD.(x + y)
  | DMD _, C _   -> DMD_C.(x + y)
  | DMS _, DMC _ -> DMS_DMC.(x + y)
  | DMC _, DMS _ -> DMC_DMS.(x + y)
  | DMD _, DMZ _ -> DMD_DMZ.(x + y)
  | DMZ _, DMD _ -> DMZ_DMD.(x + y)
  | DAS _, DAZ _ -> DAS_DAZ.(x + y)
  | DAZ _, DAS _ -> DAZ_DAS.(x + y)
  | DMS _, DMZ _ -> DMS_DMZ.(x + y)
  | DMZ _, DMS _ -> DMZ_DMS.(x + y)
  | _            -> error_binop "( + )" x y


let ( - ) x y = match x, y with
  | F x, F y     -> F_F.(x - y)
  | F x, C y     -> F_C.(x - y)
  | C x, F y     -> C_F.(x - y)
  | C x, C y     -> C_C.(x - y)
  | F _, DAS _   -> F_DAS.(x - y)
  | DAS _, F _   -> DAS_F.(x - y)
  | DAS _, DAS _ -> DAS_DAS.(x - y)
  | F _, DAD _   -> F_DAD.(x - y)
  | DAD _, F _   -> DAD_F.(x - y)
  | DAD _, DAD _ -> DAD_DAD.(x - y)
  | F _, DMS _   -> F_DMS.(x - y)
  | DMS _, F _   -> DMS_F.(x - y)
  | DMS _, DMS _ -> DMS_DMS.(x - y)
  | F _, DMD _   -> F_DMD.(x - y)
  | DMD _, F _   -> DMD_F.(x - y)
  | DMD _, DMD _ -> DMD_DMD.(x - y)
  | C _, DAC _   -> C_DAC.(x - y)
  | DAC _, C _   -> DAC_C.(x - y)
  | DAC _, DAC _ -> DAC_DAC.(x - y)
  | C _, DAZ _   -> C_DAZ.(x - y)
  | DAZ _, C _   -> DAZ_C.(x - y)
  | DAZ _, DAZ _ -> DAZ_DAZ.(x - y)
  | C _, DMC _   -> C_DMC.(x - y)
  | DMC _, C _   -> DMC_C.(x - y)
  | DMC _, DMC _ -> DMC_DMC.(x - y)
  | C _, DMZ _   -> C_DMZ.(x - y)
  | DMZ _, C _   -> DMZ_C.(x - y)
  | DMZ _, DMZ _ -> DMZ_DMZ.(x - y)
  | DAS _, DAD _ -> DAS_DAD.(x - y)
  | DAD _, DAS _ -> DAD_DAS.(x - y)
  | DAC _, DAZ _ -> DAC_DAZ.(x - y)
  | DAZ _, DAC _ -> DAZ_DAC.(x - y)
  | DMS _, DMD _ -> DMS_DMD.(x - y)
  | DMD _, DMS _ -> DMD_DMS.(x - y)
  | DMC _, DMZ _ -> DMC_DMZ.(x - y)
  | DMZ _, DMC _ -> DMZ_DMC.(x - y)
  | F _, DAC _   -> F_DAC.(x - y)
  | DAC _, F _   -> DAC_F.(x - y)
  | F _, DAZ _   -> F_DAZ.(x - y)
  | DAZ _, F _   -> DAZ_F.(x - y)
  | C _, DAS _   -> C_DAS.(x - y)
  | DAS _, C _   -> DAS_C.(x - y)
  | C _, DAD _   -> C_DAD.(x - y)
  | DAD _, C _   -> DAD_C.(x - y)
  | DAS _, DAC _ -> DAS_DAC.(x - y)
  | DAC _, DAS _ -> DAC_DAS.(x - y)
  | DAD _, DAZ _ -> DAD_DAZ.(x - y)
  | DAZ _, DAD _ -> DAZ_DAD.(x - y)
  | F _, DMC _   -> F_DMC.(x - y)
  | DMC _, F _   -> DMC_F.(x - y)
  | F _, DMZ _   -> F_DMZ.(x - y)
  | DMZ _, F _   -> DMZ_F.(x - y)
  | C _, DMS _   -> C_DMS.(x - y)
  | DMS _, C _   -> DMS_C.(x - y)
  | C _, DMD _   -> C_DMD.(x - y)
  | DMD _, C _   -> DMD_C.(x - y)
  | DMS _, DMC _ -> DMS_DMC.(x - y)
  | DMC _, DMS _ -> DMC_DMS.(x - y)
  | DMD _, DMZ _ -> DMD_DMZ.(x - y)
  | DMZ _, DMD _ -> DMZ_DMD.(x - y)
  | DAS _, DAZ _ -> DAS_DAZ.(x - y)
  | DAZ _, DAS _ -> DAZ_DAS.(x - y)
  | DMS _, DMZ _ -> DMS_DMZ.(x - y)
  | DMZ _, DMS _ -> DMZ_DMS.(x - y)
  | _            -> error_binop "( - )" x y


let ( * ) x y = match x, y with
  | F x, F y     -> F_F.(x * y)
  | F x, C y     -> F_C.(x * y)
  | C x, F y     -> C_F.(x * y)
  | C x, C y     -> C_C.(x * y)
  | F _, DAS _   -> F_DAS.(x * y)
  | DAS _, F _   -> DAS_F.(x * y)
  | DAS _, DAS _ -> DAS_DAS.(x * y)
  | F _, DAD _   -> F_DAD.(x * y)
  | DAD _, F _   -> DAD_F.(x * y)
  | DAD _, DAD _ -> DAD_DAD.(x * y)
  | F _, DMS _   -> F_DMS.(x * y)
  | DMS _, F _   -> DMS_F.(x * y)
  | DMS _, DMS _ -> DMS_DMS.(x * y)
  | F _, DMD _   -> F_DMD.(x * y)
  | DMD _, F _   -> DMD_F.(x * y)
  | DMD _, DMD _ -> DMD_DMD.(x * y)
  | C _, DAC _   -> C_DAC.(x * y)
  | DAC _, C _   -> DAC_C.(x * y)
  | DAC _, DAC _ -> DAC_DAC.(x * y)
  | C _, DAZ _   -> C_DAZ.(x * y)
  | DAZ _, C _   -> DAZ_C.(x * y)
  | DAZ _, DAZ _ -> DAZ_DAZ.(x * y)
  | C _, DMC _   -> C_DMC.(x * y)
  | DMC _, C _   -> DMC_C.(x * y)
  | DMC _, DMC _ -> DMC_DMC.(x * y)
  | C _, DMZ _   -> C_DMZ.(x * y)
  | DMZ _, C _   -> DMZ_C.(x * y)
  | DMZ _, DMZ _ -> DMZ_DMZ.(x * y)
  | DAS _, DAD _ -> DAS_DAD.(x * y)
  | DAD _, DAS _ -> DAD_DAS.(x * y)
  | DAC _, DAZ _ -> DAC_DAZ.(x * y)
  | DAZ _, DAC _ -> DAZ_DAC.(x * y)
  | DMS _, DMD _ -> DMS_DMD.(x * y)
  | DMD _, DMS _ -> DMD_DMS.(x * y)
  | DMC _, DMZ _ -> DMC_DMZ.(x * y)
  | DMZ _, DMC _ -> DMZ_DMC.(x * y)
  | F _, DAC _   -> F_DAC.(x * y)
  | DAC _, F _   -> DAC_F.(x * y)
  | F _, DAZ _   -> F_DAZ.(x * y)
  | DAZ _, F _   -> DAZ_F.(x * y)
  | C _, DAS _   -> C_DAS.(x * y)
  | DAS _, C _   -> DAS_C.(x * y)
  | C _, DAD _   -> C_DAD.(x * y)
  | DAD _, C _   -> DAD_C.(x * y)
  | DAS _, DAC _ -> DAS_DAC.(x * y)
  | DAC _, DAS _ -> DAC_DAS.(x * y)
  | DAD _, DAZ _ -> DAD_DAZ.(x * y)
  | DAZ _, DAD _ -> DAZ_DAD.(x * y)
  | F _, DMC _   -> F_DMC.(x * y)
  | DMC _, F _   -> DMC_F.(x * y)
  | F _, DMZ _   -> F_DMZ.(x * y)
  | DMZ _, F _   -> DMZ_F.(x * y)
  | C _, DMS _   -> C_DMS.(x * y)
  | DMS _, C _   -> DMS_C.(x * y)
  | C _, DMD _   -> C_DMD.(x * y)
  | DMD _, C _   -> DMD_C.(x * y)
  | DMS _, DMC _ -> DMS_DMC.(x * y)
  | DMC _, DMS _ -> DMC_DMS.(x * y)
  | DMD _, DMZ _ -> DMD_DMZ.(x * y)
  | DMZ _, DMD _ -> DMZ_DMD.(x * y)
  | DAS _, DAZ _ -> DAS_DAZ.(x * y)
  | DAZ _, DAS _ -> DAZ_DAS.(x * y)
  | DMS _, DMZ _ -> DMS_DMZ.(x * y)
  | DMZ _, DMS _ -> DMZ_DMS.(x * y)
  | _            -> error_binop "( * )" x y


let ( / ) x y = match x, y with
  | F x, F y     -> F_F.(x / y)
  | F x, C y     -> F_C.(x / y)
  | C x, F y     -> C_F.(x / y)
  | C x, C y     -> C_C.(x / y)
  | F _, DAS _   -> F_DAS.(x / y)
  | DAS _, F _   -> DAS_F.(x / y)
  | DAS _, DAS _ -> DAS_DAS.(x / y)
  | F _, DAD _   -> F_DAD.(x / y)
  | DAD _, F _   -> DAD_F.(x / y)
  | DAD _, DAD _ -> DAD_DAD.(x / y)
  | F _, DMS _   -> F_DMS.(x / y)
  | DMS _, F _   -> DMS_F.(x / y)
  | DMS _, DMS _ -> DMS_DMS.(x / y)
  | F _, DMD _   -> F_DMD.(x / y)
  | DMD _, F _   -> DMD_F.(x / y)
  | DMD _, DMD _ -> DMD_DMD.(x / y)
  | C _, DAC _   -> C_DAC.(x / y)
  | DAC _, C _   -> DAC_C.(x / y)
  | DAC _, DAC _ -> DAC_DAC.(x / y)
  | C _, DAZ _   -> C_DAZ.(x / y)
  | DAZ _, C _   -> DAZ_C.(x / y)
  | DAZ _, DAZ _ -> DAZ_DAZ.(x / y)
  | C _, DMC _   -> C_DMC.(x / y)
  | DMC _, C _   -> DMC_C.(x / y)
  | DMC _, DMC _ -> DMC_DMC.(x / y)
  | C _, DMZ _   -> C_DMZ.(x / y)
  | DMZ _, C _   -> DMZ_C.(x / y)
  | DMZ _, DMZ _ -> DMZ_DMZ.(x / y)
  | DAS _, DAD _ -> DAS_DAD.(x / y)
  | DAD _, DAS _ -> DAD_DAS.(x / y)
  | DAC _, DAZ _ -> DAC_DAZ.(x / y)
  | DAZ _, DAC _ -> DAZ_DAC.(x / y)
  | DMS _, DMD _ -> DMS_DMD.(x / y)
  | DMD _, DMS _ -> DMD_DMS.(x / y)
  | DMC _, DMZ _ -> DMC_DMZ.(x / y)
  | DMZ _, DMC _ -> DMZ_DMC.(x / y)
  | F _, DAC _   -> F_DAC.(x / y)
  | DAC _, F _   -> DAC_F.(x / y)
  | F _, DAZ _   -> F_DAZ.(x / y)
  | DAZ _, F _   -> DAZ_F.(x / y)
  | C _, DAS _   -> C_DAS.(x / y)
  | DAS _, C _   -> DAS_C.(x / y)
  | C _, DAD _   -> C_DAD.(x / y)
  | DAD _, C _   -> DAD_C.(x / y)
  | DAS _, DAC _ -> DAS_DAC.(x / y)
  | DAC _, DAS _ -> DAC_DAS.(x / y)
  | DAD _, DAZ _ -> DAD_DAZ.(x / y)
  | DAZ _, DAD _ -> DAZ_DAD.(x / y)
  | F _, DMC _   -> F_DMC.(x / y)
  | DMC _, F _   -> DMC_F.(x / y)
  | F _, DMZ _   -> F_DMZ.(x / y)
  | DMZ _, F _   -> DMZ_F.(x / y)
  | C _, DMS _   -> C_DMS.(x / y)
  | DMS _, C _   -> DMS_C.(x / y)
  | C _, DMD _   -> C_DMD.(x / y)
  | DMD _, C _   -> DMD_C.(x / y)
  | DMS _, DMC _ -> DMS_DMC.(x / y)
  | DMC _, DMS _ -> DMC_DMS.(x / y)
  | DMD _, DMZ _ -> DMD_DMZ.(x / y)
  | DMZ _, DMD _ -> DMZ_DMD.(x / y)
  | DAS _, DAZ _ -> DAS_DAZ.(x / y)
  | DAZ _, DAS _ -> DAZ_DAS.(x / y)
  | DMS _, DMZ _ -> DMS_DMZ.(x / y)
  | DMZ _, DMS _ -> DMZ_DMS.(x / y)
  | _            -> error_binop "( / )" x y

let ( ** ) x y = match x, y with
  | F x, F y     -> F_F.(x ** y)
  | F x, C y     -> F_C.(x ** y)
  | C x, F y     -> C_F.(x ** y)
  | C x, C y     -> C_C.(x ** y)
  | F _, DAS _   -> F_DAS.(x ** y)
  | DAS _, F _   -> DAS_F.(x ** y)
  | DAS _, DAS _ -> DAS_DAS.(x ** y)
  | F _, DAD _   -> F_DAD.(x ** y)
  | DAD _, F _   -> DAD_F.(x ** y)
  | DAD _, DAD _ -> DAD_DAD.(x ** y)
  | F _, DMS _   -> F_DMS.(x ** y)
  | DMS _, F _   -> DMS_F.(x ** y)
  | DMS _, DMS _ -> DMS_DMS.(x ** y)
  | F _, DMD _   -> F_DMD.(x ** y)
  | DMD _, F _   -> DMD_F.(x ** y)
  | DMD _, DMD _ -> DMD_DMD.(x ** y)
  | DAS _, DAD _ -> DAS_DAD.(x ** y)
  | DAD _, DAS _ -> DAD_DAS.(x ** y)
  | DMS _, DMD _ -> DMS_DMD.(x ** y)
  | DMD _, DMS _ -> DMD_DMS.(x ** y)
  | _            -> error_binop "( ** )" x y

let ( = ) x y = match x, y with
  | F x, F y     -> F_F.( = ) x y
  | F x, C y     -> F_C.( = ) x y
  | C x, F y     -> C_F.( = ) x y
  | C x, C y     -> C_C.( = ) x y
  | DAS _, DAS _ -> DAS_DAS.( = ) x y
  | DAD _, DAD _ -> DAD_DAD.( = ) x y
  | DMS _, DMS _ -> DMS_DMS.( = ) x y
  | DMD _, DMD _ -> DMD_DMD.( = ) x y
  | DAC _, DAC _ -> DAC_DAC.( = ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( = ) x y
  | DMC _, DMC _ -> DMC_DMC.( = ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( = ) x y
  | _            -> error_binop "( = )" x y

let ( <> ) x y = match x, y with
  | F x, F y     -> F_F.( <> ) x y
  | F x, C y     -> F_C.( <> ) x y
  | C x, F y     -> C_F.( <> ) x y
  | C x, C y     -> C_C.( <> ) x y
  | DAS _, DAS _ -> DAS_DAS.( <> ) x y
  | DAD _, DAD _ -> DAD_DAD.( <> ) x y
  | DMS _, DMS _ -> DMS_DMS.( <> ) x y
  | DMD _, DMD _ -> DMD_DMD.( <> ) x y
  | DAC _, DAC _ -> DAC_DAC.( <> ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( <> ) x y
  | DMC _, DMC _ -> DMC_DMC.( <> ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( <> ) x y
  | _            -> error_binop "( <> )" x y

let ( != ) x y = ( <> ) x y

let ( > ) x y = match x, y with
  | F x, F y     -> F_F.( > ) x y
  | F x, C y     -> F_C.( > ) x y
  | C x, F y     -> C_F.( > ) x y
  | C x, C y     -> C_C.( > ) x y
  | DAS _, DAS _ -> DAS_DAS.( > ) x y
  | DAD _, DAD _ -> DAD_DAD.( > ) x y
  | DMS _, DMS _ -> DMS_DMS.( > ) x y
  | DMD _, DMD _ -> DMD_DMD.( > ) x y
  | DAC _, DAC _ -> DAC_DAC.( > ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( > ) x y
  | DMC _, DMC _ -> DMC_DMC.( > ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( > ) x y
  | _            -> error_binop "( > )" x y

let ( < ) x y = match x, y with
  | F x, F y     -> F_F.( < ) x y
  | F x, C y     -> F_C.( < ) x y
  | C x, F y     -> C_F.( < ) x y
  | C x, C y     -> C_C.( < ) x y
  | DAS _, DAS _ -> DAS_DAS.( < ) x y
  | DAD _, DAD _ -> DAD_DAD.( < ) x y
  | DMS _, DMS _ -> DMS_DMS.( < ) x y
  | DMD _, DMD _ -> DMD_DMD.( < ) x y
  | DAC _, DAC _ -> DAC_DAC.( < ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( < ) x y
  | DMC _, DMC _ -> DMC_DMC.( < ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( < ) x y
  | _            -> error_binop "( < )" x y

let ( >= ) x y = match x, y with
  | F x, F y     -> F_F.( >= ) x y
  | F x, C y     -> F_C.( >= ) x y
  | C x, F y     -> C_F.( >= ) x y
  | C x, C y     -> C_C.( >= ) x y
  | DAS _, DAS _ -> DAS_DAS.( >= ) x y
  | DAD _, DAD _ -> DAD_DAD.( >= ) x y
  | DMS _, DMS _ -> DMS_DMS.( >= ) x y
  | DMD _, DMD _ -> DMD_DMD.( >= ) x y
  | DAC _, DAC _ -> DAC_DAC.( >= ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( >= ) x y
  | DMC _, DMC _ -> DMC_DMC.( >= ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( >= ) x y
  | _            -> error_binop "( >= )" x y

let ( <= ) x y = match x, y with
  | F x, F y     -> F_F.( <= ) x y
  | F x, C y     -> F_C.( <= ) x y
  | C x, F y     -> C_F.( <= ) x y
  | C x, C y     -> C_C.( <= ) x y
  | DAS _, DAS _ -> DAS_DAS.( <= ) x y
  | DAD _, DAD _ -> DAD_DAD.( <= ) x y
  | DMS _, DMS _ -> DMS_DMS.( <= ) x y
  | DMD _, DMD _ -> DMD_DMD.( <= ) x y
  | DAC _, DAC _ -> DAC_DAC.( <= ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( <= ) x y
  | DMC _, DMC _ -> DMC_DMC.( <= ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( <= ) x y
  | _            -> error_binop "( <= )" x y

let ( =. ) x y = match x, y with
  | DAS _, DAS _ -> DAS_DAS.( =. ) x y
  | DAD _, DAD _ -> DAD_DAD.( =. ) x y
  | DMS _, DMS _ -> DMS_DMS.( =. ) x y
  | DMD _, DMD _ -> DMD_DMD.( =. ) x y
  | DAC _, DAC _ -> DAC_DAC.( =. ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( =. ) x y
  | DMC _, DMC _ -> DMC_DMC.( =. ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( =. ) x y
  | _            -> error_binop "( =. )" x y

let ( <>. ) x y = match x, y with
  | DAS _, DAS _ -> DAS_DAS.( <>. ) x y
  | DAD _, DAD _ -> DAD_DAD.( <>. ) x y
  | DMS _, DMS _ -> DMS_DMS.( <>. ) x y
  | DMD _, DMD _ -> DMD_DMD.( <>. ) x y
  | DAC _, DAC _ -> DAC_DAC.( <>. ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( <>. ) x y
  | DMC _, DMC _ -> DMC_DMC.( <>. ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( <>. ) x y
  | _            -> error_binop "( <>. )" x y

let ( >. ) x y = match x, y with
  | DAS _, DAS _ -> DAS_DAS.( >. ) x y
  | DAD _, DAD _ -> DAD_DAD.( >. ) x y
  | DMS _, DMS _ -> DMS_DMS.( >. ) x y
  | DMD _, DMD _ -> DMD_DMD.( >. ) x y
  | DAC _, DAC _ -> DAC_DAC.( >. ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( >. ) x y
  | DMC _, DMC _ -> DMC_DMC.( >. ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( >. ) x y
  | _            -> error_binop "( >. )" x y

let ( <. ) x y = match x, y with
  | DAS _, DAS _ -> DAS_DAS.( <. ) x y
  | DAD _, DAD _ -> DAD_DAD.( <. ) x y
  | DMS _, DMS _ -> DMS_DMS.( <. ) x y
  | DMD _, DMD _ -> DMD_DMD.( <. ) x y
  | DAC _, DAC _ -> DAC_DAC.( <. ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( <. ) x y
  | DMC _, DMC _ -> DMC_DMC.( <. ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( <. ) x y
  | _            -> error_binop "( <. )" x y

let ( >=. ) x y = match x, y with
  | DAS _, DAS _ -> DAS_DAS.( >=. ) x y
  | DAD _, DAD _ -> DAD_DAD.( >=. ) x y
  | DMS _, DMS _ -> DMS_DMS.( >=. ) x y
  | DMD _, DMD _ -> DMD_DMD.( >=. ) x y
  | DAC _, DAC _ -> DAC_DAC.( >=. ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( >=. ) x y
  | DMC _, DMC _ -> DMC_DMC.( >=. ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( >=. ) x y
  | _            -> error_binop "( >=. )" x y

let ( <=. ) x y = match x, y with
  | DAS _, DAS _ -> DAS_DAS.( <=. ) x y
  | DAD _, DAD _ -> DAD_DAD.( <=. ) x y
  | DMS _, DMS _ -> DMS_DMS.( <=. ) x y
  | DMD _, DMD _ -> DMD_DMD.( <=. ) x y
  | DAC _, DAC _ -> DAC_DAC.( <=. ) x y
  | DAZ _, DAZ _ -> DAZ_DAZ.( <=. ) x y
  | DMC _, DMC _ -> DMC_DMC.( <=. ) x y
  | DMZ _, DMZ _ -> DMZ_DMZ.( <=. ) x y
  | _            -> error_binop "( <=. )" x y

let min2 x y = match x, y with
  | F x, F y     -> F_F.min2 x y
  | DAS _, DAS _ -> DAS_DAS.min2 x y
  | DAD _, DAD _ -> DAD_DAD.min2 x y
  | DMS _, DMS _ -> DMS_DMS.min2 x y
  | DMD _, DMD _ -> DMD_DMD.min2 x y
  | DAS _, DAD _ -> DAS_DAD.min2 x y
  | DAD _, DAS _ -> DAD_DAS.min2 x y
  | DMS _, DMD _ -> DMS_DMD.min2 x y
  | DMD _, DMS _ -> DMD_DMS.min2 x y
  | _            -> error_binop "min2" x y

let max2 x y = match x, y with
  | F x, F y     -> F_F.max2 x y
  | DAS _, DAS _ -> DAS_DAS.max2 x y
  | DAD _, DAD _ -> DAD_DAD.max2 x y
  | DMS _, DMS _ -> DMS_DMS.max2 x y
  | DMD _, DMD _ -> DMD_DMD.max2 x y
  | DAS _, DAD _ -> DAS_DAD.max2 x y
  | DAD _, DAS _ -> DAD_DAS.max2 x y
  | DMS _, DMD _ -> DMS_DMD.max2 x y
  | DMD _, DMS _ -> DMD_DMS.max2 x y
  | _            -> error_binop "max2" x y


(* ends here *)
