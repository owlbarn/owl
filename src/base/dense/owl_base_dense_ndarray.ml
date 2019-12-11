(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Ndarray: module aliases *)


module Operator = struct
  include Owl_operator.Make_Basic (Owl_base_dense_ndarray_generic)
  (* include Owl_operator.Make_Extend (Owl_base_dense_ndarray_generic) *)
  include Owl_operator.Make_Ndarray (Owl_base_dense_ndarray_generic)
end


module Generic = struct
  include Owl_base_dense_ndarray_generic
  include Operator
end


module S = struct
  include Owl_base_dense_ndarray_s
  include Operator
  module Scalar = Owl_base_maths

  let inv = Owl_base_linalg_generic.inv

  let chol = Owl_base_linalg_generic.chol

  let logdet = Owl_base_linalg_generic.logdet

  let svd = Owl_base_linalg_generic.svd

  let lq = Owl_base_linalg_generic.lq

  let qr = Owl_base_linalg_generic.qr

  let sylvester = Owl_base_linalg_generic.sylvester

  let lyapunov = Owl_base_linalg_generic.lyapunov

  let discrete_lyapunov = Owl_base_linalg_generic.discrete_lyapunov

  let linsolve = Owl_base_linalg_generic.linsolve

  let care = Owl_base_linalg_generic.care
end


module D = struct
  include Owl_base_dense_ndarray_d
  include Operator
  module Scalar = Owl_base_maths

  let inv = Owl_base_linalg_generic.inv

  let chol = Owl_base_linalg_generic.chol

  let logdet = Owl_base_linalg_generic.logdet

  let svd = Owl_base_linalg_generic.svd

  let lq = Owl_base_linalg_generic.lq

  let qr = Owl_base_linalg_generic.qr

  let sylvester = Owl_base_linalg_generic.sylvester

  let lyapunov = Owl_base_linalg_generic.lyapunov

  let discrete_lyapunov = Owl_base_linalg_generic.discrete_lyapunov

  let linsolve = Owl_base_linalg_generic.linsolve

  let care = Owl_base_linalg_generic.care
end


module C = struct
  include Owl_base_dense_ndarray_c
  include Operator
end


module Z = struct
  include Owl_base_dense_ndarray_z
  include Operator
end
