(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** This module defines the types shared by various sub-libraries in Owl.
  Note that they just wrappers, to find the exact module signature, please
  refer to the definition in the corresponding module.
 *)

include Owl_types_common


(* Module Signature for Ndarray *)

module type Ndarray_Basic = sig

  include Owl_types_ndarray_basic.Sig

end


module type Ndarray_Compare = sig

  include Owl_types_ndarray_compare.Sig

end


module type Ndarray_Mutable = sig

  include Owl_types_ndarray_mutable.Sig

end


module type Ndarray_Algodiff = sig

  include Owl_types_ndarray_algodiff.Sig

end


module type Ndarray_Numdiff = sig

  include Owl_types_ndarray_numdiff.Sig

end


module type Stats_Dist = sig

  include Owl_types_stats_dist.Sig

end



(* ends here *)
