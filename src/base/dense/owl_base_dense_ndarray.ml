(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Ndarray: module aliases *)


module Operator = struct
  include Owl_operator.Make_Basic (Owl_base_dense_ndarray_generic)
  (* include Owl_operator.Make_Extend (Owl_base_dense_ndarray_generic) *)
  (* include Owl_operator.Make_Ndarray (Owl_base_dense_ndarray_generic) *)
end


module Generic = struct
  include Owl_base_dense_ndarray_generic
  include Operator
end


module S = struct
  include Owl_base_dense_ndarray_s
  include Operator
  module Scalar = Owl_base_maths
end


module D = struct
  include Owl_base_dense_ndarray_d
  include Operator
  module Scalar = Owl_base_maths
end


(** TODO

module C = struct
  include Owl_dense_ndarray_c
  include Operator
end


module Z = struct
  include Owl_dense_ndarray_z
  include Operator
end

*)
