(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module type Common = sig
  type elt

  type arr

  val diagm : ?k:int -> arr -> arr

  val tril : ?k:int -> arr -> arr

  val triu : ?k:int -> arr -> arr
end
