(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Ndarray: module aliases *)


module Operator = struct
  include Owl_operator.Make_Basic (Owl_dense_ndarray_generic)
  include Owl_operator.Make_Extend (Owl_dense_ndarray_generic)
  include Owl_operator.Make_Ndarray (Owl_dense_ndarray_generic)
end


module Generic = struct
  include Owl_dense_ndarray_generic
  include Operator
  (* inject function aliases *)
  let inv = Owl_linalg_generic.inv
  let mpow = Owl_linalg_generic.mpow
end


module S = struct
  include Owl_dense_ndarray_s
  include Operator
  module Scalar = Owl_maths
  (* inject function aliases *)
  let inv = Owl_linalg_s.inv
  let mpow = Owl_linalg_s.mpow
end


module D = struct
  include Owl_dense_ndarray_d
  include Operator
  module Scalar = Owl_maths
  (* inject function aliases *)
  let inv = Owl_linalg_d.inv
  let mpow = Owl_linalg_d.mpow
end


module C = struct
  include Owl_dense_ndarray_c
  include Operator
  (* inject function aliases *)
  let inv = Owl_linalg_c.inv
  let mpow = Owl_linalg_c.mpow
end


module Z = struct
  include Owl_dense_ndarray_z
  include Operator
  (* inject function aliases *)
  let inv = Owl_linalg_z.inv
  let mpow = Owl_linalg_z.mpow
end


module Any = Owl_dense_ndarray_a
