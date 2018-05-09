(** Unit test for Owl_stats module *)

module M = Owl_stats

(* define the test error *)
let eps = 1e-10

(* a module with functions to test *)
module To_test = struct
  let mannwhitneyu_both_side x y =
    let h = M.mannwhitneyu x y in
    h.p_value

  let mannwhitneyu_right_side x y =
    let h = M.mannwhitneyu ~side:M.RightSide x y in
    h.p_value

  let mannwhitneyu_left_side x y =
    let h = M.mannwhitneyu ~side:M.LeftSide x y in
    h.p_value

  let wilcoxon_both_side x y =
    let h = M.wilcoxon x y in
    h.p_value

  let wilcoxon_right_side x y =
    let h = M.wilcoxon ~side:M.RightSide x y in
    h.p_value

  let wilcoxon_left_side x y =
    let h = M.wilcoxon ~side:M.LeftSide x y in
    h.p_value

  let fisher_test_both_side a b c d =
    let h = M.fisher_test a b c d in
    h.p_value

  let fisher_test_right_side a b c d =
    let h = M.fisher_test ~side:M.RightSide a b c d in
    h.p_value

  let fisher_test_left_side a b c d =
    let h = M.fisher_test ~side:M.LeftSide a b c d in
    h.p_value

  let ks_test_pval a b =
    let h = M.ks_test a b in
    h.p_value

  let ks_test_statistic a b =
    let h = M.ks_test a b in
    h.score

  let ks2_test_pval a b =
    let h = M.ks2_test a b in
    h.p_value

  let ks2_test_statistic a b =
    let h = M.ks2_test a b in
    h.score

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

let ks_teststat1 () =
  Alcotest.(check bool)
    "ks_test test stat"
    true
    (abs_float((To_test.ks_test_statistic
                  [| 1.; 2.; 3. |]
                  (fun x -> M.gaussian_cdf ~mu:0. ~sigma:1. x)) -. 0.8413) < 0.0001)

let ks_teststat2 () =
  Alcotest.(check bool)
    "ks_test pval 4"
    true
    (abs_float((To_test.ks_test_statistic
                  [| 0.; 0.; 0. |]
                  (fun x -> M.gaussian_cdf ~mu:0. ~sigma:1. x)) -. 0.5) < 0.0001)

let ks_pval_test1 () =
  Alcotest.(check bool)
    "ks_test pval 1"
    true
    (abs_float((To_test.ks_test_pval
                  [| 1.; 2.; 3. |]
                  (fun x -> M.gaussian_cdf ~mu:0. ~sigma:1. x)) -. 0.0079) < 0.0001)

let ks_pval_test2 () =
  Alcotest.(check bool)
    "ks_test pval 2"
    true
    (abs_float((To_test.ks_test_pval
                  [| 0.; 0.25; 0.15; 0.05 |]
                  (fun x -> M.gaussian_cdf ~mu:0. ~sigma:1. x)) -. 0.1875) < 0.0001)

let ks_pval_test3 () =
  Alcotest.(check bool)
  "ks_test pval 3"
    true
    (abs_float((To_test.ks_test_pval
                  (Array.mapi (fun i _ -> 0.99 /. 2000. *. float_of_int i) (Array.create_float 2000))
                  (fun x -> M.uniform_cdf ~a:0. ~b:1. x)) -. 0.98025) < 0.00001)

let ks_pval_test4 () =
  Alcotest.(check bool)
  "ks_test pval 4"
    true
    (abs_float((To_test.ks_test_pval
                  (Array.mapi (fun i _ -> 0.99 /. 10_000. *. float_of_int i) (Array.create_float 10_000))
                  (fun x -> M.uniform_cdf ~a:0. ~b:1. x)) -. 0.25953) < 0.00001)

let ks_pval_test5 () =
  Alcotest.check_raises
    "ks_test exception"
    Owl_exception.EMPTY_ARRAY
    (fun _ -> ignore (To_test.ks_test_pval [| |] (fun x -> M.gaussian_cdf ~mu:0. ~sigma:1. x));)


let ks2_teststat () =
  Alcotest.(check bool)
    "ks2_test test statistic"
    true
    (abs_float((To_test.ks2_test_statistic
                  [| 0.; 2.; 3.; 1.; 4.|]
                  [| 6.; 5.; 3.; 4.;|]) -. 0.6) < 0.0001)

let ks2_pval_test1 () =
  Alcotest.(check bool)
    "ks2_test p value"
    true
    (abs_float((To_test.ks2_test_pval
                  [| 0.; 2.; 3.; 1.; 4.|]
                  [| 6.; 5.; 3.; 4.;|]) -. 0.2587) < 0.0001)

let ks2_pval_test2 () =
  Alcotest.(check bool)
    "ks2_test p value"
    true
    (abs_float((To_test.ks2_test_pval
                  [|8.3653642; 9.39604144; 9.567219; 8.95912556; 9.97116074|]
                  [|1.7835817; -0.37877421; -1.21761325;  0.91270459; -1.06491371|])
               -. 0.003781) < 0.0001)

let ks2_pval_test3 () =
  Alcotest.check_raises
    "ks2_test exception"
    Owl_exception.EMPTY_ARRAY
    (fun _ -> ignore (To_test.ks2_test_pval [||] [|1.; 2.; 3.;|]);)

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
  "fisher_test_right_side", `Slow , fisher_test_right_side;
  "fisher_test_left_side", `Slow, fisher_test_left_side;
  "ks_teststat1", `Slow, ks_teststat1;
  "ks_teststat2", `Slow, ks_teststat2;
  "ks_pval_test1", `Slow, ks_pval_test1;
  "ks_pval_test2", `Slow, ks_pval_test2;
  "ks_pval_test3", `Slow, ks_pval_test3;
  "ks_pval_test4", `Slow, ks_pval_test4;
  "ks_pval_test5", `Slow, ks_pval_test5;
  "ks2_pval_test1", `Slow, ks2_pval_test1;
  "ks2_pval_test2", `Slow, ks2_pval_test2;
  "ks2_pval_test3", `Slow, ks2_pval_test3;
  "ks2_teststat", `Slow, ks2_teststat;
]
