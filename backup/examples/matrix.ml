(** [
  Wrap up Lacaml module
  ]  *)

type 'mat unop =
  ?m : int ->
  ?n : int ->
  ?br : int ->
  ?bc : int ->
  ?b : 'mat ->
  ?ar : int ->
  ?ac : int ->
  'mat
  -> 'mat

type 'mat binop =
  ?m : int ->
  ?n : int ->
  ?cr : int ->
  ?cc : int ->
  ?c : 'mat ->
  ?ar : int ->
  ?ac : int ->
  'mat ->
  ?br : int ->
  ?bc : int ->
  'mat
  -> 'mat

module type MatrixSig = sig
  type t

  val add : t binop
end;;


module MakeMatrix (Op : MatrixSig)
  : MatrixSig with type t = Op.t = struct

  type t = Op.t

  let add = Op.add
end;;
