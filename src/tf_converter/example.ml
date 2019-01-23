(*
open Owl
open Owl_converter

module G = Owl_computation_cpu_engine.Make (Dense.Ndarray.S)
module T = Owl_converter.Make (G)

include Owl_algodiff_generic.Make (G)

let f x y = Maths.((x * sin (x + x) + ((pack_flt 1.) * sqrt x) / (pack_flt 7.)) * (relu y) |> sum')

let _ =
  let x = G.var_elt "x" |> pack_elt in
  let y = G.var_elt "y" |> pack_elt in
  let z = f x y in
  let output = [| unpack_elt z |> G.elt_to_node |] in
  let input  = [| unpack_elt x |> G.elt_to_node; unpack_elt y |> G.elt_to_node|] in

  let g = G.make_graph ~input ~output "graph_01" in
  let s = T.convert g in
  T.Utils.pbtxt_to_pb "test_cgraph.meta" s
*)
