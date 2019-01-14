(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Sparse ndarray: module aliases *)


module Operator = Owl_operator.Make_Basic (Owl_sparse_ndarray_generic)


module Generic = struct
  include Owl_sparse_ndarray_generic
  include Operator
end


module S = struct
  include Owl_sparse_ndarray_s
  include Operator
end


module D = struct
  include Owl_sparse_ndarray_d
  include Operator
end


module C = struct
  include Owl_sparse_ndarray_c
  include Operator
end


module Z = struct
  include Owl_sparse_ndarray_z
  include Operator
end
