open Owl_converter_types
open Owl_converter_attr
open Owl_converter_utils

let make_node () = {
    name  = "";
    op    = "Noop";
    input = [|""|];
    attr  = [| make_attr_pair ()|]
  }

(* make_node is the CORE operation here!!! *)

(* return one or more nodes according to one Owl cgraph node *)
(*
let make_node ~name ~op ~input ~attr () =
  let op = match op with
  | "Dot" -> "MatMul"
  | ....
  let name = random_generate () in
  ...
*)


let create () =
  let node = make_node () in
  Array.make 1 node


let node_to_string n = n.name


let to_string nodes =
  let node_arr = Array.map (fun n ->
    node_to_string n
  ) nodes
  in
  let nodes_str = array_to_string (fun s -> s) node_arr in
  Printf.sprintf "graph_def {%s}" nodes_str
