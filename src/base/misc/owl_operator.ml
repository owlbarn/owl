(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Operator definition such as add, sub, mul, and div. *)

open Owl_types_operator


(* define basic operators *)

module Make_Basic (M : BasicSig) = struct

  type ('a, 'b) op_t0 = ('a, 'b) M.t

  let ( + ) = M.add

  let ( - ) = M.sub

  let ( * ) = M.mul

  let ( / ) = M.div

  let ( +$ ) = M.add_scalar

  let ( -$ ) = M.sub_scalar

  let ( *$ ) = M.mul_scalar

  let ( /$ ) = M.div_scalar

  let ( $+ ) = M.scalar_add

  let ( $- ) = M.scalar_sub

  let ( $* ) = M.scalar_mul

  let ( $/ ) = M.scalar_div

  let ( = ) = M.equal

  let ( != ) = M.not_equal

  let ( <> ) = M.not_equal

  let ( > ) = M.greater

  let ( < ) = M.less

  let ( >= ) = M.greater_equal

  let ( <= ) = M.less_equal

end


module Make_Extend (M : ExtendSig) = struct

  type ('a, 'b) op_t1 = ('a, 'b) M.t

  let ( =$ ) = M.equal_scalar

  let ( !=$ ) = M.not_equal_scalar

  let ( <>$ ) = M.not_equal_scalar

  let ( <$ ) = M.less_scalar

  let ( >$ ) = M.greater_scalar

  let ( <=$ ) = M.less_equal_scalar

  let ( >=$ ) = M.greater_equal_scalar

  let ( =. ) = M.elt_equal

  let ( !=. ) = M.elt_not_equal

  let ( <>. ) = M.elt_not_equal

  let ( <. ) = M.elt_less

  let ( >. ) = M.elt_greater

  let ( <=. ) = M.elt_less_equal

  let ( >=. ) = M.elt_greater_equal

  let ( =.$ ) = M.elt_equal_scalar

  let ( !=.$ ) = M.elt_not_equal_scalar

  let ( <>.$ ) = M.elt_not_equal_scalar

  let ( <.$ ) = M.elt_less_scalar

  let ( >.$ ) = M.elt_greater_scalar

  let ( <=.$ ) = M.elt_less_equal_scalar

  let ( >=.$ ) = M.elt_greater_equal_scalar

  let ( =~ ) = M.approx_equal

  let ( =~$ ) = M.approx_equal_scalar

  let ( =~. ) = M.approx_elt_equal

  let ( =~.$ ) = M.approx_elt_equal_scalar

  let ( % ) = M.fmod

  let ( %$ ) = M.fmod_scalar

  let ( ** ) = M.pow

  let ( $** ) = M.scalar_pow

  let ( **$ ) = M.pow_scalar

  let ( += ) = M.add_

  let ( -= ) = M.sub_

  let ( *= ) = M.mul_

  let ( /= ) = M.div_

  let ( +$= ) = M.add_scalar_

  let ( -$= ) = M.sub_scalar_

  let ( *$= ) = M.mul_scalar_

  let ( /$= ) = M.div_scalar_

  let ( @= ) = M.concat_vertical

  let ( @|| ) = M.concat_horizontal

  let ( .!{ } ) x s = M.get_fancy s x

  let ( .!{ }<- ) x s = M.set_fancy s x

  let ( .${ } ) x s = M.get_slice s x

  let ( .${ }<- ) x s = M.set_slice s x

end


module Make_Matrix (M : MatrixSig) = struct

  type ('a, 'b) op_t2 = ('a, 'b) M.t

  let ( .%{ } ) x i = M.get x i.(0) i.(1)

  let ( .%{ }<- ) x i = M.set x i.(0) i.(1)

  let ( *@ ) a b = M.dot a b

  let ( **@ ) x a = M.mpow x a

end


module Make_Ndarray (M : NdarraySig) = struct

  type ('a, 'b) op_t3 = ('a, 'b) M.t

  let ( .%{ } ) x i = M.get x i

  let ( .%{ }<- ) x i = M.set x i

end


module Make_Linalg (M : LinalgSig) = struct

  type ('a, 'b) op_t4 = ('a, 'b) M.t

  let ( /@ ) b a = M.linsolve a b

end



(* ends here *)
