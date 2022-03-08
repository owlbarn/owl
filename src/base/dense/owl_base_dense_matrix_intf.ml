(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module type Common = sig
  type elt

  type arr

  val diagm : ?k:int -> arr -> arr

  val tril : ?k:int -> arr -> arr

  val triu : ?k:int -> arr -> arr
end
