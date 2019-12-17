(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
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

  let tril ?(k=0) x = Owl_dense_matrix_generic.tril ~k x

  let triu ?(k=0) x = Owl_dense_matrix_generic.triu ~k x
end


module S = struct
  include Owl_dense_ndarray_s
  include Operator

  (* inject function aliases *)

  let inv = Owl_linalg_s.inv

  let mpow = Owl_linalg_s.mpow

  let diagm ?(k=0) x = Owl_dense_matrix_generic.diagm ~k x

  let eye n = Owl_dense_matrix_s.eye n

  let tril ?(k=0) x = Owl_dense_matrix_generic.tril ~k x

  let triu ?(k=0) x = Owl_dense_matrix_generic.triu ~k x
end


module D = struct
  include Owl_dense_ndarray_d
  include Operator

  (* inject function aliases *)

  let inv = Owl_linalg_d.inv

  let mpow = Owl_linalg_d.mpow

  let diagm ?(k=0) x = Owl_dense_matrix_generic.diagm ~k x

  let eye n = Owl_dense_matrix_d.eye n

  let tril ?(k=0) x = Owl_dense_matrix_generic.tril ~k x

  let triu ?(k=0) x = Owl_dense_matrix_generic.triu ~k x

end


module C = struct
  include Owl_dense_ndarray_c
  include Operator

  (* inject function aliases *)

  let inv = Owl_linalg_c.inv

  let mpow = Owl_linalg_c.mpow

  let eye n = Owl_dense_matrix_c.eye n

  let tril ?(k=0) x = Owl_dense_matrix_generic.tril ~k x

  let triu ?(k=0) x = Owl_dense_matrix_generic.triu ~k x
end


module Z = struct
  include Owl_dense_ndarray_z
  include Operator

  (* inject function aliases *)

  let inv = Owl_linalg_z.inv

  let mpow = Owl_linalg_z.mpow

  let eye n = Owl_dense_matrix_z.eye n

  let tril ?(k=0) x = Owl_dense_matrix_generic.tril ~k x

  let triu ?(k=0) x = Owl_dense_matrix_generic.triu ~k x
end


module Any = struct
  include Owl_dense_ndarray_a
end
