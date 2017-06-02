(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Experimental module, do not use now *)


module type EngineSig = sig

  val load : string -> string

  val save : string -> string -> int

  val map : ('a -> 'b) -> string -> string

  val reduce : ('a -> 'a -> 'a) -> string -> 'a option

end


module Make (E : EngineSig) = struct

  let map f x = E.map f x

end
