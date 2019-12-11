open Bigarray

module M = Owl_base_dense_matrix_generic
include M

type elt = float
type mat = (float, Bigarray.float32_elt) M.t

let eye = M.eye Float32
