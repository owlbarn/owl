(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_ext_types


(* error handling *)

let error_uniop op x =
  let s = type_info x in
  failwith (op ^ " : " ^ s)


(* trivial cases *)

module F = struct

  module M = Owl_maths

  let abs x = F M.(abs x)
  let neg x = F M.(neg x)
  let reci x = F M.(reci x)
  let signum x = F M.(signum x)
  let sqr x = F (x *. x)
  let sqrt x = F M.(sqrt x)

end


module C = struct

  module M = Complex

end


module DAS = struct

  module M = Owl_ext_dense_ndarray_s

end


(* ends here *)
