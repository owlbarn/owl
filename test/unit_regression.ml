(** Unit test for [Owl_regression].

    All data sets are generated without noise from known parameters, so a
    correct solver can recover those parameters almost exactly. The ordinary
    tests use the loose tolerances the current iterative solvers can meet; the
    tests registered with [known_bug] state what a correct implementation must
    achieve and are skipped unless [OWL_TEST_KNOWN_BUGS=1] is set. *)

module R = Owl_regression.D
module M = Owl_dense_matrix.D

let seed () = Owl_stats_prng.init 42

let max_abs_diff a b = M.(sub a b |> abs |> max')

let l1 a = M.(abs a |> sum')

(* y = x w + b with x uniform in [0, scale) *)
let true_w = M.of_array [| 2.; -3.; 0.5 |] 3 1

let true_b = 7.

let linear_data ?(n = 200) ?(scale = 1.) () =
  seed ();
  let x = M.(uniform n 3 *$ scale) in
  x, M.((x *@ true_w) +$ true_b)


(* separable classes: label +1 above the line x0 + x1 = 1 and -1 below it,
   with a margin of 0.1 left empty *)
let classification_data () =
  seed ();
  let x = M.uniform 400 2 in
  let s = M.(sum ~axis:1 x -$ 1.) in
  let keep =
    M.to_array s |> Array.to_list |> List.mapi (fun i v -> i, v)
    |> List.filter (fun (_, v) -> Float.abs v > 0.1)
    |> List.map fst |> Array.of_list
  in
  let x = M.rows x keep in
  let y = M.(rows s keep |> signum) in
  x, y


let accuracy x y w b =
  let pred = M.((x *@ w) +$ M.get b 0 0 |> signum) in
  let hits = M.(elt_equal pred y |> sum') in
  hits /. float_of_int (M.row_num y)


let fits_linear ~tol r =
  Array.length r = 2
  && M.shape r.(0) = (3, 1)
  && M.shape r.(1) = (1, 1)
  && max_abs_diff r.(0) true_w < tol
  && Float.abs (M.get r.(1) 0 0 -. true_b) < tol


module To_test = struct
  let ols () =
    let x, y = linear_data () in
    fits_linear ~tol:0.05 (R.ols ~i:true x y)


  let ols_no_intercept () =
    seed ();
    let x = M.uniform 200 3 in
    let r = R.ols ~i:false x M.(x *@ true_w) in
    Array.length r = 1 && M.shape r.(0) = (3, 1) && max_abs_diff r.(0) true_w < 0.05


  (* one weight column per output column *)
  let ols_multi_output () =
    seed ();
    let x = M.uniform 200 3 in
    let w = M.of_array [| 1.; -1.; 2.; 0.; 0.5; 3. |] 3 2 in
    let r = R.ols ~i:true x M.(x *@ w) in
    M.shape r.(0) = (3, 2) && M.shape r.(1) = (1, 2) && max_abs_diff r.(0) w < 0.05


  (* every penalised variant shrinks the weights towards zero *)
  let shrinks fit =
    let x, y = linear_data () in
    let ols = R.ols ~i:true x y in
    let r = fit x y in
    Array.length r = 2 && M.shape r.(0) = (3, 1) && l1 r.(0) < l1 ols.(0)


  let ridge () = shrinks (R.ridge ~i:true ~alpha:5.)

  let lasso () = shrinks (R.lasso ~i:true ~alpha:5.)

  let elastic_net () = shrinks (R.elastic_net ~i:true ~alpha:5. ~l1_ratio:0.5)

  (* with a tiny penalty the result stays close to the true weights *)
  let ridge_small_alpha () =
    let x, y = linear_data () in
    fits_linear ~tol:0.05 (R.ridge ~i:true ~alpha:1e-6 x y)


  (* y = 1 + 2x - 0.5x^2 is in the model space, and one Newton step on a
     quadratic loss is exact *)
  let poly () =
    seed ();
    let x = M.(uniform 100 1 *$ 3.) in
    let y = M.(1. $+ (2. $* x) - (0.5 $* sqr x)) in
    let p = R.poly x y 2 in
    M.shape p = (3, 1) && max_abs_diff p (M.of_array [| 1.; 2.; -0.5 |] 3 1) < 1e-6


  (* the example from issue #690, which reported a segfault for n > 2 *)
  let poly_degree_6 () =
    seed ();
    let x = M.(uniform 100 1 *$ 9.) in
    let y = M.(sin x + gaussian ~sigma:0.1 100 1) in
    let p = R.poly x y 6 in
    M.shape p = (7, 1) && M.for_all Float.is_finite p


  let svm () =
    let x, y = classification_data () in
    let r = R.svm ~i:true x y in
    accuracy x y r.(0) r.(1) > 0.95


  (* KNOWN BUG: [ols] runs 1000 Adagrad steps instead of solving the normal
     equations, so even noiseless, well-conditioned data is only fitted to
     about 1e-2 *)
  let ols_exact () =
    let x, y = linear_data () in
    fits_linear ~tol:1e-6 (R.ols ~i:true x y)


  (* KNOWN BUG: with features in [0, 100) the intercept comes out near 4
     instead of 7 *)
  let ols_scaled_features () =
    let x, y = linear_data ~scale:100. () in
    fits_linear ~tol:1e-4 (R.ols ~i:true x y)


  (* the parameters used in examples/regression.ml *)
  let exponential () =
    seed ();
    let x = M.uniform 50 1 in
    let a, l, b = 0.25, 0.55, 0.79 in
    let y = M.((a $* exp (neg (l $* x))) +$ b) in
    let a', l', b' = R.exponential x y in
    Float.abs (a -. a') < 1e-3 && Float.abs (l -. l') < 1e-3 && Float.abs (b -. b') < 1e-3


  (* KNOWN BUG (#650): with these parameters [exponential] ends far from the
     answer, about (1e-46, 1e-16, 230), even on exact data *)
  let exponential_issue_650 () =
    seed ();
    let x = M.uniform 50 1 in
    let a, l, b = 14.8494, -4.21473, 0. in
    let y = M.((a $* exp (neg (l $* x))) +$ b) in
    let a', l', b' = R.exponential x y in
    Float.abs (a -. a') < 1e-3 && Float.abs (l -. l') < 1e-3 && Float.abs (b -. b') < 1e-3


  (* KNOWN BUG: [logistic] minimises [-sum (y * log (x w))] on the raw linear
     output, without a sigmoid, so it is not logistic regression *)
  let logistic () =
    let x, y = classification_data () in
    let y01 = M.((y +$ 1.) /$ 2.) in
    let r = R.logistic ~i:true x y01 in
    let p = M.((x *@ r.(0)) +$ M.get r.(1) 0 0) in
    let pred = M.elt_greater_scalar p 0. in
    let hits = M.(elt_equal pred y01 |> sum') in
    hits /. float_of_int (M.row_num y) > 0.95
end

let check name f () = Alcotest.(check bool) name true (f ())

let known_bugs_enabled = Sys.getenv_opt "OWL_TEST_KNOWN_BUGS" = Some "1"

let known_bug name f () = if known_bugs_enabled then check name f () else Alcotest.skip ()

let test_set =
  let open To_test in
  [ "ols", `Slow, check "ols" ols
  ; "ols no intercept", `Slow, check "ols no intercept" ols_no_intercept
  ; "ols multi output", `Slow, check "ols multi output" ols_multi_output
  ; "ridge", `Slow, check "ridge" ridge
  ; "ridge small alpha", `Slow, check "ridge small alpha" ridge_small_alpha
  ; "lasso", `Slow, check "lasso" lasso
  ; "elastic net", `Slow, check "elastic net" elastic_net
  ; "poly", `Slow, check "poly" poly
  ; "poly degree 6", `Slow, check "poly degree 6" poly_degree_6
  ; "svm", `Slow, check "svm" svm
  ; "exponential", `Slow, check "exponential" exponential
  ; "known bug: ols exact", `Slow, known_bug "ols exact" ols_exact
  ; "known bug: ols scaled features", `Slow, known_bug "ols scaled features" ols_scaled_features
  ; "known bug: exponential #650", `Slow, known_bug "exponential #650" exponential_issue_650
  ; "known bug: logistic", `Slow, known_bug "logistic" logistic ]
