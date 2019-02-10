(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module Make (G : Owl_computation_graph_sig.Sig) : sig

  val convert : G.graph -> string

end
