(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module type Sig = sig
  module A : Owl_types_ndarray_algodiff.Sig

  (** {5 Type definition} *)

  include Owl_algodiff_types_sig.Sig with type elt := A.elt and type arr := A.arr

  (** {5 Core functions} *)

  val tag : unit -> int
  (** start global tagging counter *)

  val primal : t -> t
  (** get primal component of DF or DR type *)

  val primal' : t -> t
  (** iteratively get primal component of DF or DR type until the component itself is not DF/DR *)

  val zero : t -> t
  (** return a zero value, which type decided by the input value *)

  val reset_zero : t -> t
  (** [reset_zero x] iteratively resets all elements included in [x] *)

  val tangent : t -> t
  (** get the tangent component of input, if the data type is suitable *)

  val adjref : t -> t ref
  (** get the adjref component of input, if the data type is suitable *)

  val adjval : t -> t
  (** get the adjval component of input, if the data type is suitableTODO *)

  val shape : t -> int array
  (** get the shape of primal' value of input *)

  val is_float : t -> bool
  (** check if input is of float value; if input is of type DF/DR, check its primal' value *)

  val is_arr : t -> bool
  (** check if input is of ndarray value; if input is of type DF/DR, check its primal' value *)

  val row_num : t -> int
  (** get the shape of primal' value of input; and then get the first dimension *)

  val col_num : t -> int
  (** get the shape of primal' value of input; and then get the second dimension *)

  val numel : t -> int
  (** for ndarray type input, return its total number of elements. *)

  val clip_by_value : amin:A.elt -> amax:A.elt -> t -> t
  (** other functions, without tracking gradient *)

  val clip_by_l2norm : A.elt -> t -> t
  (** other functions, without tracking gradient *)

  val copy_primal' : t -> t
  (** if primal' value of input is ndarray, copy its value in a new AD type ndarray *)

  val tile : t -> int array -> t
  (** if primal' value of input is ndarray, apply the tile function *)

  val repeat : t -> int array -> t
  (** if primal' value of input is ndarray, apply the repeat function *)

  val pack_elt : A.elt -> t
  (** convert from [elt] type to [t] type. *)

  val unpack_elt : t -> A.elt
  (** convert from [t] type to [elt] type. *)

  val pack_flt : float -> t
  (** convert from [float] type to [t] type. *)

  val _f : float -> t
  (** A shortcut function for [F A.(float_to_elt x)]. *)

  val unpack_flt : t -> float
  (** convert from [t] type to [float] type. *)

  val pack_arr : A.arr -> t
  (** convert from [arr] type to [t] type. *)

  val unpack_arr : t -> A.arr
  (** convert from [t] type to [arr] type. *)

  (* functions to report errors, help in debugging *)

  val deep_info : t -> string

  val type_info : t -> string

  val error_binop : string -> t -> t -> 'a

  val error_uniop : string -> t -> 'a

end
