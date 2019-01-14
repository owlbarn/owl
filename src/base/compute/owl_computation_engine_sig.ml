(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Make_Graph_Sig = sig

  include Owl_computation_graph_sig.Sig

end


module type Flatten_Sig = sig

  include Owl_types_computation_engine.Sig

  include Owl_computation_graph_sig.Sig

  include Owl_computation_optimiser_sig.Sig

  include Owl_computation_operator_sig.Sig

  include Owl_computation_symbol_sig.Sig

  include Owl_computation_shape_sig.Sig

  include Owl_computation_type_sig.Sig

  include Owl_types_computation_device.Sig

  val number : Owl_types_common.number

end
