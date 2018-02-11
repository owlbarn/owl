(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  include Owl_types_ndarray_basic.Sig

  val mapi : (int -> elt -> elt) -> arr -> arr

  (* FIXME *)

  val ( + ) : arr -> arr -> arr

  val ( - ) : arr -> arr -> arr

  val ( * ) : arr -> arr -> arr

  val ( / ) : arr -> arr -> arr

  val ( +$ ) : arr -> elt -> arr

  val ( -$ ) : arr -> elt -> arr

  val ( *$ ) : arr -> elt -> arr

  val ( /$ ) : arr -> elt -> arr

end
