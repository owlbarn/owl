(** Unit test for Owl_stats module *)

module M = Owl_stats

(* define the test error *)
let eps = 1e-10

(* a module with functions to test *)
module To_test = struct
  let mannwhitneyu_both_side x y =
    let (_, p, _) = M.mannwhitneyu x y in
    p
  let mannwhitneyu_right_side x y =
    let (_, p, _) = M.mannwhitneyu ~side:M.RightSide x y in
    p
  let mannwhitneyu_left_side x y =
    let (_, p, _) = M.mannwhitneyu ~side:M.LeftSide x y in
    p
  let wilcoxon_both_side x y =
    let (_, p, _) = M.wilcoxon x y in
    p
  let wilcoxon_right_side x y =
    let (_, p, _) = M.wilcoxon ~side:M.RightSide x y in
    p
  let wilcoxon_left_side x y =
    let (_, p, _) = M.wilcoxon ~side:M.LeftSide x y in
    p
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
let mannwhitneyu_test_both_side_asym () =
  Alcotest.(check bool)
    "mannwhitneyu_test_both_side_asym"
    true
    ((abs_float((To_test.mannwhitneyu_both_side [|4.; 5.; 6.; 7.; 7.; 7.|] [|1.; 2.; 3.; 3.|])) -. 0.0093747684594348759) < eps)

let mannwhitneyu_test_right_side_asym () =
  Alcotest.(check bool)
    "mannwhitneyu_test_right_side_asym"
    true
    ((abs_float((To_test.mannwhitneyu_right_side [|4.; 5.; 6.; 7.; 7.; 7.|] [|1.; 2.; 3.; 3.|])) -. 0.0046873842297174379) < eps)

let mannwhitneyu_test_left_side_asym () =
  Alcotest.(check bool)
    "mannwhitneyu_test_left_side_asym"
    true
    ((abs_float((To_test.mannwhitneyu_left_side [|4.; 5.; 6.; 7.; 7.; 7.|] [|1.; 2.; 3.; 3.|])) -. 0.99531261577028252) < eps)

(* P-values computed using wilcox.test from R 3.2.3 *)
let mannwhitneyu_test_both_side_exact () =
  Alcotest.(check bool)
    "mannwhitneyu_test_both_side_asym"
    true
    ((abs_float((To_test.mannwhitneyu_both_side [|5.;6.;7.;4.;25.;12.;14.|] [|1.; 2.; 3.; 103.|])) -. 0.2303) < 0.001)

let mannwhitneyu_test_right_side_exact () =
  Alcotest.(check bool)
    "mannwhitneyu_test_right_side_asym"
    true
    ((abs_float((To_test.mannwhitneyu_right_side [|5.;6.;7.;4.;25.;12.;14.|] [|1.; 2.; 3.; 103.|])) -. 0.1152) < 0.001)

let mannwhitneyu_test_left_side_exact () =
  Alcotest.(check bool)
    "mannwhitneyu_test_left_side_asym"
    true
    ((abs_float((To_test.mannwhitneyu_left_side [|5.;6.;7.;4.;25.;12.;14.|] [|1.; 2.; 3.; 103.|])) -. 0.9182) < 0.001)

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


(* P-values computed using wilcox.test from R 3.2.3 *)
let wilcoxon_test_both_side_exact () =
  Alcotest.(check bool)
    "wilcoxon_test_both_side_exact"
    true
    (abs_float((To_test.wilcoxon_both_side [|1.;2.;3.;4.;5.|] [|10.; 9.; 8.; 7.; 6.|]) -. 0.0625) < 0.001)

let wilcoxon_test_right_side_exact () =
  Alcotest.(check bool)
    "wilcoxon_test_right_side_exact"
    true
    (abs_float((To_test.wilcoxon_right_side [|1.;2.;3.;4.;5.|] [|10.; 9.; 8.; 7.; 6.|]) -. 1.) < 0.001)

let wilcoxon_test_left_side_exact () =
  Alcotest.(check bool)
    "wilcoxon_test_left_side_exact"
    true
    (abs_float((To_test.wilcoxon_left_side [|1.;2.;3.;4.;5.|] [|10.; 9.; 8.; 7.; 6.|]) -. 0.03125) < 0.001)

(* P-values computed using wilcox.test from R 3.2.3 *)
let wilcoxon_test_both_side_asymp () =
  Alcotest.(check bool)
    "wilcoxon_test_both_side_asymp"
    true
    (abs_float((To_test.wilcoxon_both_side [|10.;9.;8.;7.;6.|] [|10.; 3.; 1.; 3.; 2.|]) -. 0.0656) < 0.001)

let wilcoxon_test_right_side_asymp () =
  Alcotest.(check bool)
    "wilcoxon_test_right_side_asymp"
    true
    (abs_float((To_test.wilcoxon_right_side [|10.;9.;8.;7.;6.|] [|10.; 3.; 1.; 3.; 2.|]) -. 0.9672) < 0.001)

let wilcoxon_test_left_side_asymp () =
  Alcotest.(check bool)
    "wilcoxon_test_left_side_asymp"
    true
     (abs_float((To_test.wilcoxon_left_side [|10.;9.;8.;7.;6.|] [|10.; 3.; 1.; 3.; 2.|]) -. 0.0328) < 0.001)




(* The tests *)
let test_set = [
  "mannwhitneyu_test_left_side_asym" , `Slow, mannwhitneyu_test_left_side_asym;
  "mannwhitneyu_test_right_side_asym" , `Slow, mannwhitneyu_test_right_side_asym;
  "mannwhitneyu_test_both_side_asym" , `Slow, mannwhitneyu_test_both_side_asym;
  "mannwhitneyu_test_both_side_exact" , `Slow, mannwhitneyu_test_both_side_exact;
  "mannwhitneyu_test_right_side_exact" , `Slow, mannwhitneyu_test_right_side_exact;
  "mannwhitneyu_test_left_side_exact" , `Slow, mannwhitneyu_test_left_side_exact;
  "wilcoxon_test_both_side_exact" , `Slow, wilcoxon_test_both_side_exact;
  "wilcoxon_test_right_side_exact" , `Slow, wilcoxon_test_right_side_exact;
  "wilcoxon_test_left_side_exact" , `Slow, wilcoxon_test_left_side_exact;
  "wilcoxon_test_both_side_asymp" , `Slow, wilcoxon_test_both_side_asymp;
  "wilcoxon_test_right_side_asymp" , `Slow, wilcoxon_test_right_side_asymp;
  "wilcoxon_test_left_side_asymp" , `Slow, wilcoxon_test_left_side_asymp;
  "fisher_test_both_side" , `Slow, fisher_test_both_side;
  "fisher_test_right_side", `Slow , fisher_test_right_side ;
  "fisher_test_left_side", `Slow, fisher_test_left_side;
  ]
