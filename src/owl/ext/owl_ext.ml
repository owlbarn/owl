(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Extension: interoperation on different number types *)


include Owl_ext_types

include Owl_ext_uniop

include Owl_ext_binop


module Dense = struct

  module Ndarray = struct
    include Owl_ext_dense_ndarray
  end

  module Matrix = struct
    include Owl_ext_dense_matrix
  end

end
