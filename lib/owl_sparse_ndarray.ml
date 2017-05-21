(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


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
