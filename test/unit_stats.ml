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

  let hist_uni n x =
    let h = M.histogram (`N n) x in
    h.counts

  let hist_uni_sorted n x =
    let h = M.histogram_sorted (`N n) x in
    h.counts

  let hist_bin bins x =
    let h = M.histogram (`Bins bins) x in
    h.counts

  let hist_bin_sorted bins x =
    let h = M.histogram_sorted (`Bins bins) x in
    h.counts

  let hist_bin_weighted bins weights x =
    let h = M.histogram (`Bins bins) ~weights x in
    h.counts, h.weighted_counts

  let hist_bin_weighted_sorted bins weights x =
    let h = M.histogram_sorted (`Bins bins) ~weights x in
    h.counts, h.weighted_counts

  let hist_normalise bins ?weights x =
    let h = M.histogram (`Bins bins) ?weights x
          |> M.normalise
          |> M.normalise_density in
    h.normalised_counts, h.density

  let tukey_fences x =
    M.tukey_fences x

  let quantiles ~p x =
    let f = M.quantile x in
    Some (Array.map f p)
end


module Data = struct
  let x1 = [|0.; -1.; 0.; sqrt 0.5; 2.;|]
  let x1_sorted = [| -1.; 0.; 0.; sqrt 0.5; 2.;|]
  let w1 = [|0.; 2.; 1.; 1.; 0.2; |]
  let w1_sorted = [|2.; 0.; 1.; 1.; 0.2; |]
  let bin1 = [| -1.; 0. |]
  let bin_wrong = [|4.|]
  let bin_low = [| -3.; -2. |]
  let bin_high = [| 3.; 4. |]
  let x2 = Array.append x1 [|infinity|]
  let x2_sorted = Array.append x1_sorted [|infinity|]
  let w2 = Array.append w1 [|0.2|]
  let bin2 = [| -.1.; 0.; sqrt 0.5; 3.|]
  let bin2_inf = [| -.infinity; 0.; sqrt 0.5; infinity|]
  let with_outliers = [|-10000.0;0.0;1.0;2.0;10000.0|]
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

let hist_uni_1 () =
  Alcotest.(check (array int))
    "uniform histogram"
    [|1; 3; 1|]
    (To_test.hist_uni 3 Data.x1)

let hist_uni_sorted_1 () =
  Alcotest.(check (array int))
    "uniform histogram sorted"
    [|1; 3; 1|]
    (To_test.hist_uni_sorted 3 Data.x1_sorted)

let hist_bins_1 () =
  Alcotest.(check (array int))
    "histogram with bins"
    [|3|]
    (To_test.hist_bin Data.bin1 Data.x1)

let hist_bins_low () =
  Alcotest.(check (array int))
    "bin below"
    [|0|]
    (To_test.hist_bin Data.bin_low Data.x1)

let hist_bins_high () =
  Alcotest.(check (array int))
    "bin above"
    [|0|]
    (To_test.hist_bin Data.bin_high Data.x1)

let hist_bins_sorted_low () =
  Alcotest.(check (array int))
    "bin below sorted"
    [|0|]
    (To_test.hist_bin_sorted Data.bin_low Data.x1_sorted)

let hist_bins_sorted_high () =
  Alcotest.(check (array int))
    "bin above sorted"
    [|0|]
    (To_test.hist_bin Data.bin_high Data.x1_sorted)

let hist_bins_wrong () =
  Alcotest.(check_raises)
    "histogram with bins"
    (Failure "Need at least two bin boundaries!")
    (fun () -> To_test.hist_bin Data.bin_wrong Data.x1|> ignore)

let hist_bins_2 () =
  Alcotest.(check (array int))
    "histogram with infinite bins"
    [|1; 2; 2|]
    (To_test.hist_bin Data.bin2 Data.x2)

let hist_bins_sorted_2 () =
  Alcotest.(check (array int))
    "histogram with infinite bins sorted"
    [|1; 2; 2|]
    (To_test.hist_bin_sorted Data.bin2 Data.x2_sorted)

(* a utility *)
let fao =
  let open Alcotest in
  let fl = testable Fmt.float (fun x y ->
      x = y || (* cover infinity cases *)
      abs_float (x -. y) <= eps) in
  option (array fl)

let hist_bins_weights () =
  Alcotest.(check (pair (array int) fao))
    "weighted histogram with bins"
    ([|3|], Some [|3.|])
    (To_test.hist_bin_weighted Data.bin1 Data.w1 Data.x1)

let hist_bins_weights_sorted () =
  Alcotest.(check (pair (array int) fao))
    "weighted histogram with bins sorted"
    ([|3|], Some [|3.|])
    (To_test.hist_bin_weighted_sorted Data.bin1 Data.w1_sorted Data.x1_sorted)

let hist_bins_normalise () =
  Alcotest.(check (pair fao fao))
    "normalisation test unweighted"
    (Some [|1./.5.; 2./.5.; 2./.5.|],
     Some [|1./.5.; 2./.5./.sqrt 0.5; 2./.5./.(3. -. sqrt 0.5)|])
    (To_test.hist_normalise Data.bin2 Data.x2)

let hist_bins_normalise_weights () =
  Alcotest.(check (pair fao fao))
    "normalisation test with weights"
    (Some [|2./.4.2; 1./.4.2; 1.2/.4.2|],
     Some [|2./.4.2; 1./.4.2/.sqrt 0.5; 1.2/.4.2/.(3. -. sqrt 0.5)|])
    (To_test.hist_normalise Data.bin2 ~weights:Data.w2 Data.x2)

let hist_bins_normalise_binf () =
  Alcotest.(check (pair fao fao))
    "normalisation test unweighted, infinite bins"
    (Some [|1./.6.; 2./.6.; 3./.6.|],
     Some [|0.; 2./.6./.sqrt 0.5; 0.|])
    (To_test.hist_normalise Data.bin2_inf Data.x2)

let tukey_fences () =
  Alcotest.(check (pair (float 0.0) (float 0.0)))
    "tukey fences test with data containing outliers"
    (-3.0, 5.0)
    (To_test.tukey_fences Data.with_outliers)

let quantiles () =
  (* reference computed with R 3.4.4*)
  Alcotest.(check fao)
    "quantiles calculation"
    (Some [|0.106500;0.190700;0.376750;0.767625;0.978800|])
    (To_test.quantiles
       ~p:[|0.;0.25;0.5;0.75;1.|]
       [| 0.1182 ; 0.8388 ; 0.4569 ; 0.1902 ; 0.8652 ; 0.2966 ; 0.9788 ; 0.5541 ; 0.1065 ; 0.1922 |])

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
  "hist_uni_1", `Slow, hist_uni_1;
  "hist_uni_sorted_1", `Slow, hist_uni_sorted_1;
  "hist_bins_1", `Slow, hist_bins_1;
  "hist_bins_low", `Slow, hist_bins_low;
  "hist_bins_high", `Slow, hist_bins_high;
  "hist_bins_sorted_low", `Slow, hist_bins_low;
  "hist_bins_sorted_high", `Slow, hist_bins_high;
  "hist_bins_wrong", `Slow, hist_bins_wrong;
  "hist_bins_2", `Slow, hist_bins_2;
  "hist_bins_sorted_2", `Slow, hist_bins_sorted_2;
  "hist_bins_weights", `Slow, hist_bins_weights;
  "hist_bins_weights_sorted", `Slow, hist_bins_weights_sorted;
  "hist_bins_normalise", `Slow, hist_bins_normalise;
  "hist_bins_normalise_weights", `Slow, hist_bins_normalise_weights;
  "hist_bins_normalise_binf", `Slow, hist_bins_normalise_binf;
  "tukey_fences", `Slow, tukey_fences;
  "quantiles", `Slow, quantiles;
]



