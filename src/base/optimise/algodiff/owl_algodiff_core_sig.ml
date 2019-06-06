module type Sig = sig
  include Owl_algodiff_types_sig.Sig

  (* hepler functions of the core AD component *)

  val cmp_tag : int -> int -> int
  val reset_zero : t -> t
  val primal : t -> t
  val primal' : t -> t
  val zero : t -> t
  val tangent : t -> t
  val adjref : t -> t ref
  val adjval : t -> t
  val shape : t -> int array
  val row_num : t -> int
  val col_num : t -> int
  val numel : t -> int
  val clip_by_value : amin:A.elt -> amax:A.elt -> t -> t
  val clip_by_l2norm : A.elt -> t -> t
  val copy_primal' : t -> t
  val tile : t -> int array -> t
  val repeat : t -> int array -> t

  (* packing and unpacking functions *)
  val pack_elt : A.elt -> t
  val unpack_elt : t -> A.elt
  val pack_flt : float -> t

  (* shorcut for type conversion *)
  val _f : float -> t
  val unpack_flt : t -> float
  val pack_arr : A.arr -> t
  val unpack_arr : t -> A.arr

  (* functions to report errors, help in debugging *)

  val deep_info : t -> string
  val type_info : t -> string
  val error_binop : string -> t -> t -> 'a
  val error_uniop : string -> t -> 'a

  (* single input single output operation *)
  val op_siso : t -> (t -> t) -> (t -> t) -> (t -> t -> t -> t) -> (t -> op) -> t

  (* single input pair outputs operation *)
  val op_sipo
    :  t
    -> (t -> t * t)
    -> (t -> t * t)
    -> (t -> t -> t -> t)
    -> (t * (t ref * t ref) * (t ref * t ref) -> op)
    -> t * t

  (* single input triple outputs operation *)
  val op_sito
    :  t
    -> (t -> t * t * t)
    -> (t -> t * t * t)
    -> (t -> t -> t -> t)
    -> (t * (t ref * t ref * t ref) * (t ref * t ref * t ref) -> op)
    -> t * t * t

  (* single input array outputs operation *)
  val op_siao
    :  t
    -> (t -> t array)
    -> (t -> t array)
    -> (t -> t -> t -> t)
    -> (t * t ref array * t ref array -> op)
    -> t array

  (* pair inputs single output operation *)
  val op_piso
    :  t
    -> t
    -> (t -> t -> t)
    -> (t -> t -> t)
    -> (t -> t -> t -> t)
    -> (t -> t -> t -> t)
    -> (t -> t -> t -> t -> t -> t)
    -> (t -> t -> op)
    -> (t -> t -> op)
    -> (t -> t -> op)
    -> t
end
