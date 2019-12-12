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

  let eye = Owl_base_dense_matrix_s.eye

  let diagm = Owl_base_dense_matrix_s.diagm

  let triu = Owl_base_dense_matrix_s.triu

  let tril = Owl_base_dense_matrix_s.tril

  let inv = Owl_base_linalg_s.inv

  let chol = Owl_base_linalg_s.chol

  let logdet = Owl_base_linalg_s.logdet

  let svd = Owl_base_linalg_s.svd

  let lq x = Owl_base_linalg_s.lq x

  let qr x =
    let q, r, _ = Owl_base_linalg_s.qr ~thin:true ~pivot:false x in
    (q,r)


  let sylvester = Owl_base_linalg_s.sylvester

  let lyapunov = Owl_base_linalg_s.lyapunov

  let discrete_lyapunov = Owl_base_linalg_s.discrete_lyapunov

  let linsolve = Owl_base_linalg_s.linsolve

  let care = Owl_base_linalg_s.care
end


module D = struct
  include Owl_base_dense_ndarray_d
  include Operator
  module Scalar = Owl_base_maths

  let eye = Owl_base_dense_matrix_d.eye

  let diagm = Owl_base_dense_matrix_d.diagm

  let triu = Owl_base_dense_matrix_d.triu

  let tril = Owl_base_dense_matrix_d.tril

  let inv = Owl_base_linalg_d.inv

  let chol = Owl_base_linalg_d.chol

  let logdet = Owl_base_linalg_d.logdet

  let svd = Owl_base_linalg_d.svd

  let lq x = Owl_base_linalg_d.lq x

  let qr x =
    let q, r, _ = Owl_base_linalg_d.qr ~thin:true ~pivot:false x in
    (q,r)

  let sylvester = Owl_base_linalg_d.sylvester

  let lyapunov = Owl_base_linalg_d.lyapunov

  let discrete_lyapunov = Owl_base_linalg_d.discrete_lyapunov

  let linsolve = Owl_base_linalg_d.linsolve

  let care = Owl_base_linalg_d.care
end


module C = struct
  include Owl_base_dense_ndarray_c
  include Operator
end


module Z = struct
  include Owl_base_dense_ndarray_z
  include Operator
end
