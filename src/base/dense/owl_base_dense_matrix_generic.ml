(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

include Owl_base_dense_ndarray_generic

(* TODO: move other matrix-specific operations such as dot and trace here *)

let diagm ?(k = 0) _x =
  k |> ignore;
  raise (Owl_exception.NOT_IMPLEMENTED "owl_base_dense_ndarray_generic.diagm")


let tril ?(k = 0) _x =
  k |> ignore;
  raise (Owl_exception.NOT_IMPLEMENTED "owl_base_dense_ndarray_generic.tril")


let triu ?(k = 0) _x =
  k |> ignore;
  raise (Owl_exception.NOT_IMPLEMENTED "owl_base_dense_ndarray_generic.triu")
