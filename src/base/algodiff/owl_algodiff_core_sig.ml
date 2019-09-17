module type Sig = sig
  module A : Owl_types_ndarray_algodiff.Sig

  (** {6 Type definition} *)

  include Owl_algodiff_types_sig.Sig with type elt := A.elt and type arr := A.arr

  (** {6 Core functions} *)

  (** TODO *)
  val tag : unit -> int

  (** TODO *)
  val primal : t -> t

  (** TODO *)
  val primal' : t -> t

  (** TODO *)
  val zero : t -> t

  (** TODO *)
  val reset_zero : t -> t

  (** TODO *)
  val tangent : t -> t

  (** TODO *)
  val adjref : t -> t ref

  (** TODO *)
  val adjval : t -> t

  (** TODO *)
  val shape : t -> int array

  (** number of rows *)
  val row_num : t -> int

  (** number of columns *)
  val col_num : t -> int

  (** number of elements *)
  val numel : t -> int

  (** other functions, without tracking gradient *)
  val clip_by_value : amin:A.elt -> amax:A.elt -> t -> t

  (** other functions, without tracking gradient *)
  val clip_by_l2norm : A.elt -> t -> t

  (** TODO *)
  val copy_primal' : t -> t

  (** TODO *)
  val tile : t -> int array -> t

  (** TODO *)
  val repeat : t -> int array -> t

  (** convert from ``elt`` type to ``t`` type. *)
  val pack_elt : A.elt -> t

  (** convert from ``t`` type to ``elt`` type. *)
  val unpack_elt : t -> A.elt

  (** convert from ``float`` type to ``t`` type. *)
  val pack_flt : float -> t

  (** A shortcut function for ``F A.(float_to_elt x)``. *)
  val _f : float -> t

  (** convert from ``t`` type to ``float`` type. *)
  val unpack_flt : t -> float

  (** convert from ``arr`` type to ``t`` type. *)
  val pack_arr : A.arr -> t

  (** convert from ``t`` type to ``arr`` type. *)
  val unpack_arr : t -> A.arr

  (* functions to report errors, help in debugging *)

  (** TODO *)
  val deep_info : t -> string

  (** TODO *)
  val type_info : t -> string

  (** TODO *)
  val error_binop : string -> t -> t -> 'a

  (** TODO *)
  val error_uniop : string -> t -> 'a
end
