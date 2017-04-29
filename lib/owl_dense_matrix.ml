(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module S = Owl_dense_matrix_s

module D = Owl_dense_matrix_d

module C = Owl_dense_matrix_c

module Z = Owl_dense_matrix_z

module Generic = Owl_dense_matrix_generic

module Operator = struct
  include Owl_operator.Make_Basic (Generic)
  include Owl_operator.Make_Ext (Generic)
end
