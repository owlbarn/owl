(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  type elt

  val add : elt -> elt -> elt

end
