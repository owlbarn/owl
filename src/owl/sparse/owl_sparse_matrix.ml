(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** Sparse matrix: module aliases *)

module Operator = struct
  include Owl_operator.Make_Basic (Owl_sparse_matrix_generic)
  include Owl_operator.Make_Matrix (Owl_sparse_matrix_generic)
end

module Generic = struct
  include Owl_sparse_matrix_generic
  include Operator
end

module S = struct
  include Owl_sparse_matrix_s
  include Operator
end

module D = struct
  include Owl_sparse_matrix_d
  include Operator
end

module C = struct
  include Owl_sparse_matrix_c
  include Operator
end

module Z = struct
  include Owl_sparse_matrix_z
  include Operator
end

module DOK = struct
  include Owl_sparse_dok_matrix
end
