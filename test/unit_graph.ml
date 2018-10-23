(** Unit test for Owl_graph module *)

module M = Owl_graph

let to_array order traversal nodes =
  let s = Owl_utils.Stack.make () in
  let f u = Owl_utils.Stack.push s u in
  M.iter_descendants ~order ~traversal f nodes;
  Array.map M.attr (Owl_utils.Stack.to_array s)

let graph () =
  let n0, n1, n2, n3, n4 = M.node 0, M.node 1, M.node 2, M.node 3, M.node 4 in
  M.connect [|n0|] [|n1; n2; n3|];
  M.connect [|n1|] [|n2|];
  M.connect [|n2; n3|] [|n4|];
  n0, n1, n2, n3, n4

(* a module with functions to test *)
module To_test = struct

  let topo0 () =
    let _, _, _, _, n4 = graph () in
    Array.map M.attr (M.topo_sort [|n4|]) = [|0; 1; 2; 3; 4|]

  let topo1 () =
    let _, _, n2, n3, _ = graph () in
    Array.map M.attr (M.topo_sort [|n2; n3|]) = [|0; 1; 2; 3|]

  (* cyclic graph *)
  let dfs0 () =
    let n0, n1, n2 = M.node 0, M.node 1, M.node 2 in
    M.connect [|n0|] [|n1|];
    M.connect [|n1|] [|n2|];
    M.connect [|n2|] [|n0|];
    to_array DFS PostOrder [|n0|] = [|2; 1; 0|]

  let dfs1 () =
    let n0 = M.node 0 in
    to_array DFS PreOrder [|n0|] = [|0|]

  let bfs0 () =
    let n0, n1, n2, n3, n4 = M.node 0, M.node 1, M.node 2, M.node 3, M.node 4 in
    M.connect [|n0|] [|n1; n3|];
    M.connect [|n1|] [|n2; n3|];
    M.connect [|n2|] [|n3|];
    M.connect [|n2; n3|] [|n4|];
    to_array BFS PreOrder [|n0|] = [|0; 1; 3; 2; 4|]

  let num0 () =
    let _, _, n2, _, _ = graph () in
    M.num_ancestor [|n2|] = 3 && M.num_descendant [|n2|] = 2

end

let topo0 () =
  Alcotest.(check bool) "topo0" true (To_test.topo0 ())

let topo1 () =
  Alcotest.(check bool) "topo1" true (To_test.topo1 ())

let dfs0 () =
  Alcotest.(check bool) "dfs0" true (To_test.dfs0 ())

let dfs1 () =
  Alcotest.(check bool) "dfs1" true (To_test.dfs1 ())

let bfs0 () =
  Alcotest.(check bool) "bfs0" true (To_test.bfs0 ())

let num0 () =
  Alcotest.(check bool) "num0" true (To_test.num0 ())

(* the tests *)

let test_set = [
  "topo0", `Slow, topo0;
  "topo1", `Slow, topo1;
  "dfs0", `Slow, dfs0;
  "dfs1", `Slow, dfs1;
  "bfs0", `Slow, bfs0;
  "num0", `Slow, num0;
]
