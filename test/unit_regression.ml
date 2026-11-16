(** Unit test for [Owl_regression].

    Most data sets are generated without noise from known parameters, so the
    solvers must recover those parameters to near machine precision. Where
    noise is added, the result is checked against the optimality conditions
    of the objective instead. *)

module R = Owl_regression.D
module M = Owl_dense_matrix.D

let seed () = Owl_stats_prng.init 42

let max_abs_diff a b = M.(sub a b |> abs |> max')

let l1 a = M.(abs a |> sum')

let raises_invalid_arg f =
  try
    ignore (f ());
    false
  with
  | Invalid_argument _ -> true


(* y = x w + b with x uniform in [0, scale) *)
let true_w = M.of_array [| 2.; -3.; 0.5 |] 3 1

let true_b = 7.

let linear_data ?(n = 200) ?(scale = 1.) () =
  seed ();
  let x = M.(uniform n 3 *$ scale) in
  x, M.((x *@ true_w) +$ true_b)


(* four features, the last one irrelevant, plus a little noise *)
let noisy_data () =
  seed ();
  let x = M.uniform 200 4 in
  let w = M.of_array [| 2.; -3.; 0.5; 0. |] 4 1 in
  x, M.((x *@ w) +$ true_b + gaussian ~sigma:0.1 200 1)


(* separable classes: label +1 above the line x0 + x1 = 1 and -1 below it,
   with a margin of 0.1 left empty *)
let classification_data () =
  seed ();
  let x = M.uniform 400 2 in
  let s = M.(sum ~axis:1 x -$ 1.) in
  let keep =
    M.to_array s
    |> Array.to_list
    |> List.mapi (fun i v -> i, v)
    |> List.filter (fun (_, v) -> Float.abs v > 0.1)
    |> List.map fst
    |> Array.of_list
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


(* Optimality of [||y - x w - b||^2 + l1 ||w||_1 + l2 ||w||^2]: the residual
   sums to zero (free intercept) and, for every weight, [2 x_j' r] equals
   [l1 sign w_j + 2 l2 w_j] when [w_j <> 0] and lies in [-l1, l1] otherwise. *)
let kkt ?(tol = 1e-6) ~l1 ~l2 x y r =
  let w = r.(0)
  and b = M.get r.(1) 0 0 in
  let res = M.(y - (x *@ w) -$ b) in
  let c = M.(transpose x *@ res *$ 2.) in
  Float.abs (M.sum' res) < tol
  && List.for_all
       (fun j ->
         let wj = M.get w j 0
         and cj = M.get c j 0 in
         if wj = 0.
         then Float.abs cj <= l1 +. tol
         else Float.abs (cj -. (l1 *. Float.of_int (compare wj 0.)) -. (2. *. l2 *. wj)) < tol)
       (List.init (M.row_num w) Fun.id)


(* runs [f] with stdout and stderr redirected to a temporary file and tells
   whether nothing was written *)
let silent f =
  flush stdout;
  flush stderr;
  let tmp = Filename.temp_file "owl_regression" ".log" in
  let fd = Unix.openfile tmp [ Unix.O_WRONLY; Unix.O_TRUNC ] 0o600 in
  let out = Unix.dup Unix.stdout
  and err = Unix.dup Unix.stderr in
  Unix.dup2 fd Unix.stdout;
  Unix.dup2 fd Unix.stderr;
  Fun.protect
    (fun () ->
      ignore (f ());
      flush stdout;
      flush stderr)
    ~finally:(fun () ->
      Unix.dup2 out Unix.stdout;
      Unix.dup2 err Unix.stderr;
      List.iter Unix.close [ out; err; fd ]);
  let size = (Unix.stat tmp).Unix.st_size in
  Sys.remove tmp;
  size = 0


module To_test = struct
  let ols () =
    let x, y = linear_data () in
    fits_linear ~tol:1e-9 (R.ols ~i:true x y)


  (* the iterative solver used before got the intercept wrong by about 3 here *)
  let ols_scaled_features () =
    let x, y = linear_data ~scale:100. () in
    fits_linear ~tol:1e-8 (R.ols ~i:true x y)


  let ols_no_intercept () =
    seed ();
    let x = M.uniform 200 3 in
    let r = R.ols ~i:false x M.(x *@ true_w) in
    Array.length r = 1 && M.shape r.(0) = (3, 1) && max_abs_diff r.(0) true_w < 1e-9


  (* one weight column per output column *)
  let ols_multi_output () =
    seed ();
    let x = M.uniform 200 3 in
    let w = M.of_array [| 1.; -1.; 2.; 0.; 0.5; 3. |] 3 2 in
    let b = M.of_array [| 4.; -2. |] 1 2 in
    let r = R.ols ~i:true x M.((x *@ w) + b) in
    M.shape r.(0) = (3, 2)
    && M.shape r.(1) = (1, 2)
    && max_abs_diff r.(0) w < 1e-9
    && max_abs_diff r.(1) b < 1e-9


  (* with a repeated column the minimum-norm solution splits the weight *)
  let ols_rank_deficient () =
    seed ();
    let x0 = M.uniform 100 1
    and x1 = M.uniform 100 1 in
    let x = M.concat_horizontal (M.concat_horizontal x0 x0) x1 in
    let y = M.((2. $* x0) + x1) in
    let r = R.ols ~i:false x y in
    max_abs_diff r.(0) (M.of_array [| 1.; 1.; 1. |] 3 1) < 1e-9


  let ols_single_precision () =
    seed ();
    let module S = Owl_dense_matrix.S in
    let x = S.uniform 200 3 in
    let w = S.of_array [| 2.; -3.; 0.5 |] 3 1 in
    let r = Owl_regression.S.ols ~i:true x S.((x *@ w) +$ 7.) in
    S.(sub r.(0) w |> abs |> max') < 1e-3 && Float.abs (S.get r.(1) 0 0 -. 7.) < 1e-3


  let ols_rows_mismatch () =
    raises_invalid_arg (fun () -> R.ols (M.uniform 10 2) (M.uniform 9 1))


  (* ridge against the normal equations on centred data *)
  let ridge () =
    let x, y = noisy_data () in
    let alpha = 5. in
    let r = R.ridge ~i:true ~alpha x y in
    let xm = M.mean ~axis:0 x
    and ym = M.mean' y in
    let xc = M.(x - xm)
    and yc = M.(y -$ ym) in
    let w = M.(Owl_linalg.D.inv ((transpose xc *@ xc) + (alpha $* eye 4)) *@ transpose xc *@ yc) in
    let b = ym -. M.(xm *@ w |> sum') in
    max_abs_diff r.(0) w < 1e-9 && Float.abs (M.get r.(1) 0 0 -. b) < 1e-9


  (* with a tiny penalty the result stays close to the true weights *)
  let ridge_small_alpha () =
    let x, y = linear_data () in
    fits_linear ~tol:1e-6 (R.ridge ~i:true ~alpha:1e-6 x y)


  (* the intercept is not penalised: shifting y only shifts b *)
  let intercept_not_penalised fit () =
    let x, y = noisy_data () in
    let r = fit x y
    and r' = fit x M.(y +$ 100.) in
    max_abs_diff r.(0) r'.(0) < 1e-8
    && Float.abs (M.get r'.(1) 0 0 -. M.get r.(1) 0 0 -. 100.) < 1e-8


  (* every penalised variant shrinks the weights towards zero *)
  let shrinks fit =
    let x, y = noisy_data () in
    let ols = R.ols ~i:true x y in
    let r = fit x y in
    Array.length r = 2 && M.shape r.(0) = (4, 1) && l1 r.(0) < l1 ols.(0)


  let ridge_shrinks () = shrinks (R.ridge ~i:true ~alpha:5.)

  let lasso_shrinks () = shrinks (R.lasso ~i:true ~alpha:5.)

  let elastic_net_shrinks () = shrinks (R.elastic_net ~i:true ~alpha:5. ~l1_ratio:0.5)

  let lasso_optimal () =
    let x, y = noisy_data () in
    kkt ~l1:5. ~l2:0. x y (R.lasso ~i:true ~alpha:5. x y)


  (* the irrelevant feature is set exactly to zero, the others are kept *)
  let lasso_sparse () =
    let x, y = noisy_data () in
    let w = (R.lasso ~i:true ~alpha:5. x y).(0) in
    M.get w 3 0 = 0. && List.for_all (fun j -> M.get w j 0 <> 0.) [ 0; 1; 2 ]


  let elastic_net_optimal () =
    let x, y = noisy_data () in
    let alpha, ratio = 5., 0.3 in
    let r = R.elastic_net ~i:true ~alpha ~l1_ratio:ratio x y in
    kkt ~l1:(alpha *. ratio) ~l2:(alpha *. (1. -. ratio) /. 2.) x y r


  let negative_alpha () =
    let x, y = noisy_data () in
    raises_invalid_arg (fun () -> R.ridge ~alpha:(-1.) x y)
    && raises_invalid_arg (fun () -> R.lasso ~alpha:(-1.) x y)
    && raises_invalid_arg (fun () -> R.elastic_net ~l1_ratio:1.5 x y)


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


  let fits_exponential ~tol (a, l, b) x =
    let a', l', b' = R.exponential x M.((a $* exp (neg (l $* x))) +$ b) in
    Float.abs (a -. a') < tol && Float.abs (l -. l') < tol && Float.abs (b -. b') < tol


  (* the parameters used in examples/regression.ml *)
  let exponential_decay () =
    seed ();
    fits_exponential ~tol:1e-6 (0.25, 0.55, 0.79) (M.uniform 50 1)


  (* issue #650: a growing exponential, which the old solver missed entirely *)
  let exponential_growth () =
    seed ();
    fits_exponential ~tol:1e-6 (14.8494, -4.21473, 0.) (M.uniform 50 1)


  (* x far from zero: a is huge and exp (-l x) tiny, but their product is not *)
  let exponential_offset () =
    seed ();
    let a, l, b = 2e9, 1., -1. in
    let x = M.(uniform 50 1 +$ 20.) in
    let a', l', b' = R.exponential x M.((a $* exp (neg (l $* x))) +$ b) in
    Float.abs ((a -. a') /. a) < 1e-6 && Float.abs (l -. l') < 1e-6 && Float.abs (b -. b') < 1e-6


  let exponential_degenerate () =
    raises_invalid_arg (fun () -> R.exponential (M.ones 10 1) (M.uniform 10 1))


  (* labels in {0, 1}; a separable set is classified without error *)
  let logistic_separable () =
    let x, y = classification_data () in
    let y01 = M.((y +$ 1.) /$ 2.) in
    let r = R.logistic ~i:true x y01 in
    let pred = M.(elt_greater_scalar ((x *@ r.(0)) +$ M.get r.(1) 0 0) 0.) in
    M.(elt_equal pred y01 |> sum') = float_of_int (M.row_num y)


  (* labels drawn from a logistic model: the result is the maximum likelihood
     estimate, where the gradient [x' (sigmoid (x w + b) - y)] vanishes *)
  let logistic_mle () =
    seed ();
    let x = M.(uniform 500 2 *$ 4. -$ 2.) in
    let p = M.(sigmoid ((x *@ of_array [| 1.5; -1. |] 2 1) +$ 0.5)) in
    let y = M.(elt_less (uniform 500 1) p) in
    let r = R.logistic ~i:true x y in
    let e = M.(sigmoid ((x *@ r.(0)) +$ get r.(1) 0 0) - y) in
    Float.abs (M.sum' e) < 1e-8 && M.(transpose x *@ e |> abs |> max') < 1e-8


  (* no model prints a training log; [svm] used to print about 1000 lines *)
  let quiet () =
    let x, y = linear_data () in
    let xc, yc = classification_data () in
    let yc01 = M.((yc +$ 1.) /$ 2.) in
    silent (fun () -> R.svm ~i:true xc yc)
    && silent (fun () -> R.ols ~i:true x y)
    && silent (fun () -> R.ridge ~i:true x y)
    && silent (fun () -> R.lasso ~i:true x y)
    && silent (fun () -> R.elastic_net ~i:true x y)
    && silent (fun () -> R.logistic ~i:true xc yc01)
    && silent (fun () -> R.poly (M.uniform 50 1) (M.uniform 50 1) 3)
    && silent (fun () -> R.exponential (M.uniform 50 1) (M.uniform 50 1))


  (* labels in {-1, 1} are rejected instead of silently giving nonsense *)
  let logistic_rejects_signed_labels () =
    let x, y = classification_data () in
    raises_invalid_arg (fun () -> R.logistic ~i:true x y)
end

let check name f () = Alcotest.(check bool) name true (f ())

let test_set =
  let open To_test in
  [ "ols", `Slow, check "ols" ols
  ; "ols scaled features", `Slow, check "ols scaled features" ols_scaled_features
  ; "ols no intercept", `Slow, check "ols no intercept" ols_no_intercept
  ; "ols multi output", `Slow, check "ols multi output" ols_multi_output
  ; "ols rank deficient", `Slow, check "ols rank deficient" ols_rank_deficient
  ; "ols single precision", `Slow, check "ols single precision" ols_single_precision
  ; "ols rows mismatch", `Quick, check "ols rows mismatch" ols_rows_mismatch
  ; "ridge", `Slow, check "ridge" ridge
  ; "ridge small alpha", `Slow, check "ridge small alpha" ridge_small_alpha
  ; "ridge shrinks", `Slow, check "ridge shrinks" ridge_shrinks
  ; ( "ridge intercept not penalised"
    , `Slow
    , check "ridge intercept not penalised" (intercept_not_penalised (R.ridge ~i:true ~alpha:5.)) )
  ; "lasso shrinks", `Slow, check "lasso shrinks" lasso_shrinks
  ; "lasso optimal", `Slow, check "lasso optimal" lasso_optimal
  ; "lasso sparse", `Slow, check "lasso sparse" lasso_sparse
  ; ( "lasso intercept not penalised"
    , `Slow
    , check "lasso intercept not penalised" (intercept_not_penalised (R.lasso ~i:true ~alpha:5.)) )
  ; "elastic net shrinks", `Slow, check "elastic net shrinks" elastic_net_shrinks
  ; "elastic net optimal", `Slow, check "elastic net optimal" elastic_net_optimal
  ; "negative alpha", `Quick, check "negative alpha" negative_alpha
  ; "poly", `Slow, check "poly" poly
  ; "poly degree 6", `Slow, check "poly degree 6" poly_degree_6
  ; "svm", `Slow, check "svm" svm
  ; "exponential decay", `Slow, check "exponential decay" exponential_decay
  ; "exponential growth #650", `Slow, check "exponential growth #650" exponential_growth
  ; "exponential offset", `Slow, check "exponential offset" exponential_offset
  ; "exponential degenerate", `Quick, check "exponential degenerate" exponential_degenerate
  ; "logistic separable", `Slow, check "logistic separable" logistic_separable
  ; "logistic mle", `Slow, check "logistic mle" logistic_mle
  ; "quiet", `Slow, check "quiet" quiet
  ; ( "logistic rejects signed labels"
    , `Quick
    , check "logistic rejects signed labels" logistic_rejects_signed_labels ) ]
