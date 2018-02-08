(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types_operator


(** {6 Basic operators} *)

module Make_Basic (M : BasicSig) : sig

  val ( + ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``add`` *)

  val ( - ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``sub`` *)

  val ( * ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``mul`` *)

  val ( / ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``div`` *)

  val ( +$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``add_scalar`` *)

  val ( -$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``sub_scalar`` *)

  val ( *$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``mul_scalar`` *)

  val ( /$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``div_scalar`` *)

  val ( $+ ) : 'a -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``scalar_add`` *)

  val ( $- ) : 'a -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``scalar_sub`` *)

  val ( $* ) : 'a -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``scalar_mul`` *)

  val ( $/ ) : 'a -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``scalar_div`` *)

  val ( = ) : ('a, 'b) M.t -> ('a, 'b) M.t -> bool
  (** Operator of ``equal`` *)

  val ( != ) : ('a, 'b) M.t -> ('a, 'b) M.t -> bool
  (** Operator of ``not_equal`` *)

  val ( <> ) : ('a, 'b) M.t -> ('a, 'b) M.t -> bool
  (** Operator of ``not_equal`` *)

  val ( > ) : ('a, 'b) M.t -> ('a, 'b) M.t -> bool
  (** Operator of ``greater`` *)

  val ( < ) : ('a, 'b) M.t -> ('a, 'b) M.t -> bool
  (** Operator of ``less`` *)

  val ( >= ) : ('a, 'b) M.t -> ('a, 'b) M.t -> bool
  (** Operator of ``greater_equal`` *)

  val ( <= ) : ('a, 'b) M.t -> ('a, 'b) M.t -> bool
  (** Operator of ``less_equal`` *)

end


(** {6 Extended operators} *)

module Make_Extend (M : ExtendSig) : sig

  val ( =$ ) : ('a, 'b) M.t -> 'a -> bool
  (** Operator of ``equal_scalar`` *)

  val ( !=$ ) : ('a, 'b) M.t -> 'a -> bool
  (** Operator of ``not_equal_scalar`` *)

  val ( <>$ ) : ('a, 'b) M.t -> 'a -> bool
  (** Operator of ``not_equal_scalar`` *)

  val ( <$ ) : ('a, 'b) M.t -> 'a -> bool
  (** Operator of ``less_scalar`` *)

  val ( >$ ) : ('a, 'b) M.t -> 'a -> bool
  (** Operator of ``greater_scalar`` *)

  val ( <=$ ) : ('a, 'b) M.t -> 'a -> bool
  (** Operator of ``less_equal_scalar`` *)

  val ( >=$ ) : ('a, 'b) M.t -> 'a -> bool
  (** Operator of ``greater_equal_scalar`` *)

  val ( =. ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``elt_equal`` *)

  val ( !=. ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``elt_not_equal`` *)

  val ( <>. ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``elt_not_equal`` *)

  val ( <. ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``elt_less`` *)

  val ( >. ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``elt_greater`` *)

  val ( <=. ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``elt_less_equal`` *)

  val ( >=. ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``elt_greater_equal`` *)

  val ( =.$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``elt_equal_scalar`` *)

  val ( !=.$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``elt_not_equal_scalar`` *)

  val ( <>.$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``elt_not_equal_scalar`` *)

  val ( <.$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``elt_less_scalar`` *)

  val ( >.$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``elt_greater_scalar`` *)

  val ( <=.$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``elt_less_equal_scalar`` *)

  val ( >=.$ ) : ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``elt_greater_equal_scalar`` *)

  val ( =~ ) : ?eps:float -> ('a, 'b) M.t -> ('a, 'b) M.t -> bool
  (** Operator of ``approx_equal`` *)

  val ( =~$ ) : ?eps:float -> ('a, 'b) M.t -> 'a -> bool
  (** Operator of ``approx_equal_scalar`` *)

  val ( =~. ) : ?eps:float -> ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``approx_elt_equal`` *)

  val ( =~.$ ) : ?eps:float -> ('a, 'b) M.t -> 'a -> ('a, 'b) M.t
  (** Operator of ``approx_elt_equal_scalar`` *)

  val ( % ) : (float, 'a) M.t -> (float, 'a) M.t -> (float, 'a) M.t
  (** Operator of ``fmod`` *)

  val ( %$ ) : (float, 'a) M.t -> float -> (float, 'a) M.t
  (** Operator of ``fmod_scalar`` *)

  val ( ** ) : (float, 'a) M.t -> (float, 'a) M.t -> (float, 'a) M.t
  (** Operator of ``pow`` *)

  val ( $** ) : float -> (float, 'a) M.t -> (float, 'a) M.t
  (** Operator of ``scalar_pow`` *)

  val ( **$ ) : (float, 'a) M.t -> float -> (float, 'a) M.t
  (** Operator of ``pow_scalar`` *)

  val ( += ) : ('a, 'b) M.t -> ('a, 'b) M.t -> unit
  (** Operator of ``add_`` *)

  val ( -= ) : ('a, 'b) M.t -> ('a, 'b) M.t -> unit
  (** Operator of ``sub_`` *)

  val ( *= ) : ('a, 'b) M.t -> ('a, 'b) M.t -> unit
  (** Operator of ``mul_`` *)

  val ( /= ) : ('a, 'b) M.t -> ('a, 'b) M.t -> unit
  (** Operator of ``div_`` *)

  val ( +$= ) : ('a, 'b) M.t -> 'a -> unit
  (** Operator of ``add_scalar_`` *)

  val ( -$= ) : ('a, 'b) M.t -> 'a -> unit
  (** Operator of ``sub_scalar_`` *)

  val ( *$= ) : ('a, 'b) M.t -> 'a -> unit
  (** Operator of ``mul_scalar_`` *)

  val ( /$= ) : ('a, 'b) M.t -> 'a -> unit
  (** Operator of ``div_scalar_`` *)

  val ( .!{} ) : ('a, 'b) M.t -> Owl_types.index list -> ('a, 'b) M.t
  (** Operator of ``get_fancy`` *)

  val ( .!{}<- ) : ('a, 'b) M.t -> Owl_types.index list -> ('a, 'b) M.t -> unit
  (** Operator of ``set_fancy`` *)

  val ( .${} ) : ('a, 'b) M.t -> int list list -> ('a, 'b) M.t
  (** Operator of ``get_slice`` *)

  val ( .${}<- ) : ('a, 'b) M.t -> int list list -> ('a, 'b) M.t -> unit
  (** Operator of ``set_slice`` *)

end


(** {6 Matrix-specific operators} *)

module Make_Matrix (M : MatrixSig) : sig

  val ( *@ ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``dot`` *)

  val ( @= ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``concat_vertical`` *)

  val ( @|| ) : ('a, 'b) M.t -> ('a, 'b) M.t -> ('a, 'b) M.t
  (** Operator of ``concat_horizontal`` *)

  val ( .%{} ) : ('a, 'b) M.t -> int array -> 'a
  (** Operator of ``get`` *)

  val ( .%{}<- ) : ('a, 'b) M.t -> int array -> 'a -> unit
  (** Operator of ``set`` *)

end


(** {6 Ndarray-specific operators} *)

module Make_Ndarray (M : NdarraySig) : sig

  val ( .%{} ) : ('a, 'b) M.t -> int array -> 'a
  (** Operator of ``get`` *)

  val ( .%{}<- ) : ('a, 'b) M.t -> int array -> 'a -> unit
  (** Operator of ``set`` *)

end
