(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Matrix: module aliases *)


module Operator = struct
  include Owl_operator.Make_Basic (Owl_dense_matrix_generic)
  include Owl_operator.Make_Extend (Owl_dense_matrix_generic)
  include Owl_operator.Make_Matrix (Owl_dense_matrix_generic)
  include Owl_operator.Make_Linalg (Owl_linalg_generic)
end


module Generic = struct
  include Owl_dense_matrix_generic
  include Operator
end


module S = struct
  include Owl_dense_matrix_s
  include Operator
end


module D = struct
  include Owl_dense_matrix_d
  include Operator
end


module C = struct
  include Owl_dense_matrix_c
  include Operator
end


module Z = struct
  include Owl_dense_matrix_z
  include Operator
end
