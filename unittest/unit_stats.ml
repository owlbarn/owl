
module M = Owl_stats

let eps = 0.0000000001

(* a module with functions to test *)
module To_test = struct
  let fisher_test_both_side a b c d =
    let (_, p, _) = M.fisher_test a b c d in
    p
  let fisher_test_right_side a b c d =
    let (_, p, _) = M.fisher_test ~side:M.RightSide a b c d in
    p
  let fisher_test_left_side a b c d =
    let (_, p, _) = M.fisher_test ~side:M.LeftSide a b c d in
    p
end


(* The tests *)
(* P-values computed using stats.fisher_exact from SciPy 0.18.1 *)


let fisher_test_both_side () =
  Alcotest.(check bool)
    "fisher_test_both_side"
    true
    (abs_float((To_test.fisher_test_both_side 45 25 10 15) -. 0.057776279489461277) < eps)

let fisher_test_right_side () =
  Alcotest.(check bool)
    "fisher_test_right_side"
    true
    (abs_float((To_test.fisher_test_right_side 45 25 10 15) -. 0.0307852082455) < eps)

let fisher_test_left_side () =
  Alcotest.(check bool)
    "fisher_test_left_side"
    true
    (abs_float((To_test.fisher_test_left_side 45 25 10 15) -. 0.990376800656) < eps)

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
