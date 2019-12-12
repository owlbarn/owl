open Bigarray

module M = Owl_base_dense_matrix_generic
include M

type elt = Complex.t
type mat = (Complex.t, Bigarray.complex64_elt) M.t
type cast_mat = (float, float64_elt) Owl_base_dense_matrix_generic.t

let eye = M.eye Complex64
