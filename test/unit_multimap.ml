(** Unit test for Owl_utils_multimap module *)

module Multimap = Owl_utils_multimap.Make(struct
                    type t = int
                    let compare : int -> int -> int = compare
                  end)


(* a module with functions to test *)
module To_test = struct

  let multimap0 () =
    let map = Multimap.empty in
    let map = Multimap.add 0 0 map in
    let map = Multimap.add 0 1 map in
    let map = Multimap.add 2 (-1) map in
    let map = Multimap.remove 0 map in
    let zero = Multimap.find 0 map in
    let (_, mone) = Multimap.max_binding map in
    let map = Multimap.remove 2 map in
    let map = Multimap.remove 0 map in
    zero = 0 && mone = -1 && Multimap.is_empty map

  let multimap1 () =
    let map = Multimap.empty in
    let map = Multimap.add 0 0 map in
    let map = Multimap.add 1 1 map in
    let map = Multimap.add 3 3 map in
    let map = Multimap.add 4 4 map in
    let gt n k = k > n in
    let gt4 = Multimap.find_first_opt (gt 4) map in
    let gt2 = Multimap.find_first_opt (gt 2) map in
    gt4 = None && gt2 = Some (3, 3)

end

let multimap0 () =
  Alcotest.(check bool) "multimap0" true (To_test.multimap0 ())

let multimap1 () =
  Alcotest.(check bool) "multimap1" true (To_test.multimap1 ())

(* the tests *)

let test_set = [
  "multimap0", `Slow, multimap0;
  "multimap1", `Slow, multimap1;
]
