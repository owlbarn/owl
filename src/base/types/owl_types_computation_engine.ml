(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  type arr

  type elt

  val eval_elt : elt array -> unit

  val eval_arr : arr array -> unit

end
