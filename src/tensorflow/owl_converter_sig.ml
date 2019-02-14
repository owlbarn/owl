(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_converter_types


module type Sig = sig

  module TFgraph : Owl_converter_graph_sig.Sig

  type tf_cgraph = {
    mutable tfmeta  : tfmeta;
    mutable tfgraph : TFgraph.tfgraph;
    mutable tfsaver : tfsaver;
    mutable tfcolls : tfcolls
  }

  val convert : TFgraph.G.graph -> tf_cgraph

  val to_pbtxt : tf_cgraph ->  string

end
