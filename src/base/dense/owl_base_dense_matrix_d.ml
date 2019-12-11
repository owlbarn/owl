open Bigarray

module M = Owl_base_dense_matrix_generic
include M

type elt = float
type mat = (float, Bigarray.float64_elt) M.t

let eye = M.eye Float64
