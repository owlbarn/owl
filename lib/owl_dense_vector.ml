(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module Generic = struct
  include Owl_dense_vector_generic
end


module S = struct
  include Owl_dense_vector_s
end


module D = struct
  include Owl_dense_vector_d
end


module C = struct
  include Owl_dense_vector_c
end


module Z = struct
  include Owl_dense_vector_z
end
