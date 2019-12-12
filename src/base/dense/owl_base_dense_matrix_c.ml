open Bigarray

module M = Owl_base_dense_matrix_generic
include M

type elt = Complex.t
type mat = (Complex.t, Bigarray.complex32_elt) M.t

let eye = M.eye Complex32
