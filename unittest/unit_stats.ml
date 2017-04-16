
module M = Owl_stats



(* a module with functions to test *)
module To_test = struct
  let fisher_test_both_side alpha a b c d =
    let (check, _, _) = M.fisher_test ~alpha:alpha a b c d in
    check
  let fisher_test_right_side alpha a b c d =
    let (check, _, _) = M.fisher_test ~alpha:alpha ~side:M.RightSide a b c d in
    check
  let fisher_test_left_side alpha a b c d =
    let (check, _, _) = M.fisher_test ~alpha:alpha ~side:M.LeftSide a b c d in
    check
end


(* The tests *)
let fisher_test_both_side () =
  Alcotest.(check bool)
    "fisher_test_both_side"
    false
    (To_test.fisher_test_both_side 0.05 45 25 10 15)

let fisher_test_right_side () =
  Alcotest.(check bool)
    "fisher_test_right_side"
    true
    (To_test.fisher_test_right_side 0.05 45 25 10 15)

let fisher_test_left_side () =
  Alcotest.(check bool)
    "fisher_test_left_side"
    false
    (To_test.fisher_test_left_side 0.05 45 25 10 15)




(* The tests *)
let test_set = [
  "fisher_test_both_side" , `Slow, fisher_test_both_side;
  "fisher_test_right_side", `Slow , fisher_test_right_side ;
  "fisher_test_left_side", `Slow, fisher_test_left_side;
]

(* Run it *)
let () =
  Alcotest.run "Test M." [
    "stats", test_set;
  ]
