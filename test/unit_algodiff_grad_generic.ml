(** Unit test for Algodiff module *)

open Owl_types

(* define the test error *)
let eps = 1e-16
let approx_equal ?eps:(eps=1e-12) a b = Pervasives.abs_float (a -. b) < eps


(* functor to generate test unit. *)

module Make
  (M : Ndarray_Algodiff with type elt = float)
  = struct

  module AlgoM = Owl_algodiff_generic.Make (M)
  open AlgoM

  (* a module with functions to test *)
  module To_test = struct

    let check_grad ?eps:(eps=1e-6) f dfs xys =
      let dim = Array.length xys in
      let xys_arr = M.init [|1;dim|] (fun i -> xys.(i)) in
      let grad_f =  (grad f (Arr xys_arr)) |> unpack_arr in
      let dfds   = Array.map (fun df -> df xys) dfs in
      let grad_f = Array.init dim (fun i -> M.get grad_f [|0; i|]) in
      let rec pass_fail acc i =
        let check_coord acc x y = acc && (approx_equal~eps:eps x y) in
        if (i == dim) then acc else (
          let new_acc = check_coord acc dfds.(i) grad_f.(i) in
          pass_fail new_acc (i+1)
        )
      in
      (pass_fail true 0, grad_f, dfds)
      (** check_grad f dfs xys checks the delta between the *algodiff* grad
          of f at xys=(x,y,..) and the functions dfs[] applied to x y.

          It returns a (bool * (float array) * (float array)); the bool indicates
          a pass/fail; the first float array is the *algodiff* calculated grad,
          and the second float array is the 'known good' dfsevaluated at the vector.

          f : a Maths function D.t -> D.t which maps a D.t value (always an (Arr
          (2D array)) here) to f(vec); vec is the first column of the supplied array.

          dfs : ((float array) -> float ) list is a list of derivative functions that each map
           a vector v (as a float array) to a float, the first function being with
           the derivative with respect to the (1,0,0,...) vector, the second with
           respect to (0,1,0,...) etc

          xys : (float array), a vector of where the derivatives and grad are to be evaluated
           and compared.

          Note that the D.t presented to f is a 2D array containing a single vector;
          to get the X coordinate, use (Mat.get xy 0 0), to get the Y coordinate use (Mat.get xy 0 1)

       **)

  end

  (* Vector positions for evaluation of grad *)
  let coords = [0.; 0.1; 0.2; 0.3; 0.8; 0.9; 1.0; 1.1; 2.0; 3.0; 4.0;]
  let vs_list =
    let vs_of_x acc x =
      List.fold_left (fun acc y -> [|x;(-1.)*.y|]::([|x;y|]::acc)) acc coords
    in
    List.fold_left (fun acc x -> vs_of_x acc x) [] coords

  let vs = Array.of_list vs_list

  let x_ne_y x y = ((abs_float (x -. y)) > 0.00000001)

  let vs_filter f vs =
    let filter acc v    = if (f v) then v::acc else acc in
    let filtered_vs_list vs = Array.fold_left filter [] vs in
    Array.of_list (filtered_vs_list vs)

  let vs_x_nonzero = vs_filter (fun v -> x_ne_y v.(0) 0.) vs

  let vs_x_pos = vs_filter (fun v -> v.(0) > 0.0000001) vs

  let vs_x_abs_lt_one = vs_filter (fun v -> (((v.(0))>(-1.) && ((v.(0))<1.0)))) vs

  let vs_y_abs_lt_one = vs_filter (fun v -> (((v.(1))>(-1.) && ((v.(1))<1.0)))) vs

  let vs_y_gt_one = vs_filter (fun v -> ((v.(1))>(1.))) vs

  let vs_prod_positive = vs_filter (fun v -> ((v.(1) *. v.(0))>0.00001)) vs

  let vs_diff = vs_filter (fun v -> (x_ne_y v.(1) v.(0))) vs

  let vs_sq_diff = vs_filter (fun v -> (x_ne_y (v.(1)**2.) (v.(0)**2.))) vs

  (* Functions to simplify testing of grad *)

  let check_grad test f dfs vs =
    let test_v v =
      let (r,test_result,good_result) = To_test.check_grad f dfs v in
      let strvec v =
        let strx acc x =
          if (String.length acc == 0) then (Printf.sprintf "%f" x) else (Printf.sprintf "%s,%f" acc x)
        in
        Array.fold_left strx "" v
      in
      let error_msg v = Printf.sprintf "Testing %s : %s : %s : %s" test (strvec v) (strvec test_result) (strvec good_result) in
      Alcotest.(check bool) (error_msg v) true r
    in
    Array.iter test_v vs
  (** check_grad applies *algodiff* to a function *f* at set of vectors *vs*

      It compares the resultant vectors with those achieved using known good
      functions *dfs* for the partial derivatives.

      The test name (or simple description) is supplied in *test*

   **)

  let make_grad_test_set set_name test_assoc =
    let mk_test named_test =
      let (name,test) = named_test in
      let (test_msg, test_f, test_dfs, test_vs) = test in
      let test_fn () = check_grad test_msg test_f test_dfs test_vs in
      ((Printf.sprintf "%s.%s" set_name name), `Slow, test_fn)
    in
    List.map mk_test test_assoc
  (** make_grad_test_set constructs an Alcotest test list from an assoc list *test_assoc*

    *test_assoc* is a list of ( name:string, test_description ). The name is used as the Alcotest test name.

      The test_description is (test message, f, dfs, vs); this is data that can be passed to check_grad.

      This function is used to build tests from simple lists, for ease of readability

   **)


  (* grad_tests_poly provide tests for constants, x, y, +, -, *, /, ** *)
  let grad_tests_poly = [
    ( "one", ("1",
              (fun v -> Maths.(F 1.)),
              [| (fun v -> 0.);
                 (fun v -> 0.);
              |],
              vs ));
    ( "x", ("x",
            (fun v -> Maths.(Mat.get v 0 0)),
            [| (fun v -> 1.);
               (fun v -> 0.);
            |],
            vs ));
    ( "x_p_y", ("x+y",
                (fun v -> Maths.((Mat.get v 0 0) + (Mat.get v 0 1))),
                [| (fun v -> 1.);
                   (fun v -> 1.);
                |],
                vs ));
    ( "x_m_y", ("x-y",
                (fun v -> Maths.((Mat.get v 0 0) - (Mat.get v 0 1))),
                [| (fun v -> 1.);
                   (fun v -> (-1.));
                |],
                vs ));
    ( "x_x", ("x * x",
              (fun v -> Maths.((Mat.get v 0 0) * (Mat.get v 0 0))),
              [| (fun v -> 2. *. (v.(0)));
                 (fun v -> 0.);
              |],
              vs ));
    ( "x_div_x", ("x / x",
                  (fun v -> Maths.((Mat.get v 0 0) / (Mat.get v 0 0))),
                  [| (fun v -> 0.);
                     (fun v -> 0.);
                  |],
                  vs_x_nonzero ));
    ( "y_div_x", ("y / x",
                  (fun v -> Maths.((Mat.get v 0 1) / (Mat.get v 0 0))),
                  [| (fun v -> -1. /. (v.(0) ** 2.) *. v.(1));
                     (fun v -> 1. /. (v.(0)));
                  |],
                  vs_x_nonzero ));
    ( "xsq_p_y", ("x^2 + y",
                  (fun v -> Maths.((Mat.get v 0 0)**(F 2.) + (Mat.get v 0 1))),
                  [| (fun v -> 2. *. (v.(0)));
                     (fun v -> 1.);
                  |],
                  vs ));
    ( "xy", ("xy",
             (fun v -> Maths.((Mat.get v 0 0) * (Mat.get v 0 1))),
             [| (fun v -> (v.(1)));
                (fun v -> (v.(0)));
             |],
             vs ));
    ( "xsq_p_ysq", ("x^2+y^2",
                    (fun v -> Maths.(((Mat.get v 0 0) ** (F 2.)) + ((Mat.get v 0 1)**(F 2.)))),
                    [| (fun v -> 2. *. (v.(0)));
                       (fun v -> 2. *. (v.(1)));
                    |],
                    vs ));
    ( "x_p_y_allsq", ("(x+y)^2 = x^2 + y^2 + 2xy",
                      (fun v -> Maths.(((Mat.get v 0 0) + (Mat.get v 0 1))**(F 2.))),
                      [| (fun v -> 2. *. (v.(0) +. (v.(1))));
                         (fun v -> 2. *. (v.(0) +. (v.(1))));
                      |],
                      vs ));
    ( "xy_sq", ("xy^2",
                (fun v -> Maths.(((Mat.get v 0 0) * (Mat.get v 0 1)) ** (F 2.))),
                [| (fun v -> 2. *. (v.(0) *. ((v.(1) ** 2.))));
                   (fun v -> 2. *. ((v.(0)**2.) *. (v.(1))));
                |],
                vs ));
    ( "xy_cube", ("xy^3",
                  (fun v -> Maths.((Mat.get v 0 0) * (Mat.get v 0 1) * (Mat.get v 0 0) * (Mat.get v 0 1) * (Mat.get v 0 0) * (Mat.get v 0 1))),
                  [| (fun v -> 3. *. ((v.(0) ** 2.) *. ((v.(1) ** 3.))));
                     (fun v -> 3. *. ((v.(0) ** 3.) *. ((v.(1) ** 2.))));
                  |],
                  vs ));
    ( "x_pow_y", ("x^y",
                  (fun v -> Maths.((Mat.get v 0 0) ** (Mat.get v 0 1))),
                  [| (fun v -> v.(1) *. (v.(0) ** (v.(1) -. 1.)));
                     (fun v ->  (log v.(0)) *. v.(0) ** v.(1));
                  |],
                  vs_x_pos ));
  ]

  (* grad_tests_other provide tests for min, max, neg, abs, sign, floor/ceil/round *)
  let grad_tests_other = [
    ( "min_x_y", ("min(x,y)",
                  (fun v -> Maths.(min2 (Mat.get v 0 0) (Mat.get v 0 1))),
                  [| (fun v -> (if (v.(0) < v.(1)) then 1. else 0.));
                     (fun v -> (if (v.(1) < v.(0)) then 1. else 0.));
                  |],
                  vs_diff ));

    ( "max_x_y", ("max(x,y)",
                  (fun v -> Maths.(max2 (Mat.get v 0 0) (Mat.get v 0 1))),
                  [| (fun v -> (if (v.(0) > v.(1)) then 1. else 0.));
                     (fun v -> (if (v.(1) > v.(0)) then 1. else 0.));
                  |],
                  vs_diff ));
    ( "neg_y", ("-y)",
                (fun v -> Maths.(neg (Mat.get v 0 1))),
                [| (fun v -> 0.);
                   (fun v -> (-1.));
                |],
                vs ));
    ( "abs_y2", ("abs(y^2)",
                 (fun v -> Maths.(abs ((Mat.get v 0 1) ** (F 2.)))),
                 [| (fun v -> 0.);
                    (fun v -> 2. *. v.(1));
                 |],
                 vs ));
    ( "abs_x2_m_y2", ("abs(x^2-y^2)",
                      (fun v -> Maths.(abs (((Mat.get v 0 0) ** (F 2.)) - (Mat.get v 0 1) ** (F 2.)))),
                      [| (fun v -> (if ((v.(0))**2.<v.(1)**2.) then (-1.) else (1.)) *. (2.) *. v.(0));
                         (fun v -> (if ((v.(0))**2.<v.(1)**2.) then (-1.) else (1.)) *. (-2.) *. v.(1));
                      |],
                      vs_sq_diff ));
    ( "sign_x2_m_y2", ("sign(x^2-y^2)",
                       (fun v -> Maths.(signum (((Mat.get v 0 0) ** (F 2.)) - (Mat.get v 0 1) ** (F 2.)))),
                       [| (fun v -> 0.);
                          (fun v -> 0.);
                       |],
                       vs ));
    ( "floor_x2_m_y2", ("floor(x^2-y^2)",
                        (fun v -> Maths.(floor (((Mat.get v 0 0) ** (F 2.)) - (Mat.get v 0 1) ** (F 2.)))),
                        [| (fun v -> 0.);
                           (fun v -> 0.);
                        |],
                        vs ));
    ( "ceil_x2_m_y2", ("ceil(x^2-y^2)",
                       (fun v -> Maths.(ceil (((Mat.get v 0 0) ** (F 2.)) - (Mat.get v 0 1) ** (F 2.)))),
                       [| (fun v -> 0.);
                          (fun v -> 0.);
                       |],
                       vs ));
    ( "round_x2_m_y2", ("round(x^2-y^2)",
                        (fun v -> Maths.(round (((Mat.get v 0 0) ** (F 2.)) - (Mat.get v 0 1) ** (F 2.)))),
                        [| (fun v -> 0.);
                           (fun v -> 0.);
                        |],
                        vs ));
  ]

  (* grad_tests_logexp provides tests for sqr, sqrt, log, log2, log10, exp *)
  let grad_tests_logexp = [
    ( "sqr_x_m_sqr_y", ("sqr(x)-sqr(y)",
                        (fun v -> Maths.((sqr (Mat.get v 0 0)) - (sqr (Mat.get v 0 1)) )),
                        [| (fun v -> 2. *. v.(0));
                           (fun v -> (-2.) *. v.(1));
                        |],
                        vs ));

    ( "sqrt_xy", ("sqrt(xy)",
                  (fun v -> Maths.(sqrt ((Mat.get v 0 0) * (Mat.get v 0 1)))),
                  [| (fun v -> (0.5) *. v.(1) /. sqrt(v.(0)*.v.(1)));
                     (fun v -> (0.5) *. v.(0) /. sqrt(v.(0)*.v.(1)));
                  |],
                  vs_prod_positive ));

    ( "log_xy", ("log(xy)",
                 (fun v -> Maths.(log ((Mat.get v 0 0) * (Mat.get v 0 1)))),
                 [| (fun v -> (1.) /. v.(0));
                    (fun v -> (1.) /. v.(1));
                 |],
                 vs_prod_positive ));
    ( "log2_xy", ("log2(xy)",
                  (fun v -> Maths.(log2 ((Mat.get v 0 0) * (Mat.get v 0 1)))),
                  [| (fun v -> (log 2.) /. v.(0));
                     (fun v -> (log 2.) /. v.(1));
                  |],
                  vs_prod_positive ));
    ( "log10_xy", ("log10(xy)",
                   (fun v -> Maths.(log10 ((Mat.get v 0 0) * (Mat.get v 0 1)))),
                   [| (fun v -> (log 10.) /. v.(0));
                      (fun v -> (log 10.) /. v.(1));
                   |],
                   vs_prod_positive ));
    ( "exp_xy", ("exp(xy)",
                 (fun v -> Maths.(exp ((Mat.get v 0 0) * (Mat.get v 0 1)))),
                 [| (fun v -> v.(1) *. (exp (v.(1) *. v.(0))));
                    (fun v -> v.(0) *. (exp (v.(1) *. v.(0))));
                 |],
                 vs ));
  ]

  (* grad_tests_trig provide tests for sin, cos, tan, asin, acos, atan, atan2 *)
  let grad_tests_trig = [
    ( "sin_x", ("sin(x)",
                (fun v -> Maths.(sin (Mat.get v 0 0))),
                [| (fun v -> cos v.(0));
                   (fun v -> 0.);
                |],
                vs ));
    ( "cos_y", ("cos(y)",
                (fun v -> Maths.(cos (Mat.get v 0 1))),
                [| (fun v -> 0.);
                   (fun v -> (-1.) *. sin v.(1));
                |],
                vs ));
    ( "sin_xy", ("sin(xy)",
                 (fun v -> Maths.(sin ((Mat.get v 0 0) * (Mat.get v 0 1)))),
                 [| (fun v -> v.(1) *. cos (v.(0) *. v.(1)));
                    (fun v -> v.(0) *. cos (v.(0) *. v.(1)));
                 |],
                 vs ));
    ( "cos_xy", ("cos(xy)",
                 (fun v -> Maths.(cos ((Mat.get v 0 0) * (Mat.get v 0 1)))),
                 [| (fun v -> (-1.) *. v.(1) *. sin (v.(0) *. v.(1)));
                    (fun v -> (-1.) *. v.(0) *. sin (v.(0) *. v.(1)));
                 |],
                 vs ));
    ( "cos_y_div_x", ("cos(y/x)",
                      (fun v -> Maths.( cos ((Mat.get v 0 1) / (Mat.get v 0 0)))),
                      [| (fun v -> (1.) *. v.(1) /. (v.(0) ** 2.) *. sin (v.(1) /. v.(0)));
                         (fun v -> (-1.) /. v.(0) *. sin (v.(1) /. v.(0)));
                      |],
                      vs_x_nonzero ));
    ( "tan_x_p_y", ("tan(x+y)",
                    (fun v -> Maths.(tan ((Mat.get v 0 0) + (Mat.get v 0 1)))),
                    [| (fun v -> 1. /. (cos(v.(0) +. v.(1)) ** 2.));
                       (fun v -> 1. /. (cos(v.(0) +. v.(1)) ** 2.));
                    |],
                    vs ));
    ( "asin_x", ("asin(x)",
                 (fun v -> Maths.(asin (Mat.get v 0 0))),
                 [| (fun v -> 1. /. (sqrt ( 1. -. v.(0) ** 2.)));
                    (fun v -> 0.);
                 |],
                 vs_x_abs_lt_one ));
    ( "acos_y", ("acos(y)",
                 (fun v -> Maths.(acos (Mat.get v 0 1))),
                 [| (fun v -> 0.);
                    (fun v -> (-1.) /. (sqrt ( 1. -. v.(1) ** 2.)));
                 |],
                 vs_y_abs_lt_one ));
    ( "atan_y", ("atan(y)",
                 (fun v -> Maths.(atan (Mat.get v 0 1))),
                 [| (fun v -> 0.);
                    (fun v -> 1. /. ( 1. +. v.(1)**2.));
                 |],
                 vs ));
    ( "atan2_y_x", ("atan2(y,x)",
                    (fun v -> Maths.(atan2 (Mat.get v 0 1) (Mat.get v 0 0))),
                    [| (fun v -> (-1.) /. ( 1. +. (v.(1)/.v.(0)) ** 2.) *.v.(1) /. (v.(0) ** 2.));
                       (fun v -> 1. /. ( 1. +. (v.(1)/.v.(0)) ** 2.) /. v.(0));
                    |],
                    vs_x_nonzero ));
  ]

  (* grad_tests_hype provide tests for sinh, cosh, tanh, asinh, acosh, atanh *)
  let grad_tests_hype = [
    ( "sinh_x", ("sinh(x)",
                 (fun v -> Maths.(sinh (Mat.get v 0 0))),
                 [| (fun v -> cosh v.(0));
                    (fun v -> 0.);
                 |],
                 vs ));
    ( "cosh_y", ("cosh(y)",
                 (fun v -> Maths.(cosh (Mat.get v 0 1))),
                 [| (fun v -> 0.);
                    (fun v -> (1.) *. sinh v.(1));
                 |],
                 vs ));
    ( "sinh_xy", ("sinh(xy)",
                  (fun v -> Maths.(sinh ((Mat.get v 0 0) * (Mat.get v 0 1)))),
                  [| (fun v -> v.(1) *. cosh (v.(0) *. v.(1)));
                     (fun v -> v.(0) *. cosh (v.(0) *. v.(1)));
                  |],
                  vs ));
    ( "cosh_xy", ("cosh(xy)",
                  (fun v -> Maths.(cosh ((Mat.get v 0 0) * (Mat.get v 0 1)))),
                  [| (fun v -> (1.) *. v.(1) *. sinh (v.(0) *. v.(1)));
                     (fun v -> (1.) *. v.(0) *. sinh (v.(0) *. v.(1)));
                  |],
                  vs ));
    ( "cosh_y_div_x", ("cosh(y/x)",
                       (fun v -> Maths.( cosh ((Mat.get v 0 1) / (Mat.get v 0 0)))),
                       [| (fun v -> (-1.) *. v.(1) /. (v.(0) ** 2.) *. sinh (v.(1) /. v.(0)));
                          (fun v -> (1.) /. v.(0) *. sinh (v.(1) /. v.(0)));
                       |],
                       vs_x_nonzero ));
    ( "tanh_x_p_y", ("tanh(x+y)",
                     (fun v -> Maths.(tanh ((Mat.get v 0 0) + (Mat.get v 0 1)))),
                     [| (fun v -> 1. /. (cosh(v.(0) +. v.(1)) ** 2.));
                        (fun v -> 1. /. (cosh(v.(0) +. v.(1)) ** 2.));
                     |],
                     vs ));
    ( "asinh_x", ("asinh(x)",
                  (fun v -> Maths.(asinh (Mat.get v 0 0))),
                  [| (fun v -> 1. /. (sqrt ( 1. +. v.(0) ** 2.)));
                     (fun v -> 0.);
                  |],
                  vs ));
    ( "acosh_y", ("acos(y)",
                  (fun v -> Maths.(acosh (Mat.get v 0 1))),
                  [| (fun v -> 0.);
                     (fun v -> 1. /. (sqrt ( (-1.) +. v.(1) ** 2.)));
                  |],
                  vs_y_gt_one ));
    ( "atanh_y", ("atan(y)",
                  (fun v -> Maths.(atanh (Mat.get v 0 1))),
                  [| (fun v -> 0.);
                     (fun v -> 1. /. ( 1. -. v.(1) ** 2.));
                  |],
                  vs_y_abs_lt_one ));
  ]


  (* test_set - create the test_set for Alcotest *)
  let test_set =
    List.concat [
      make_grad_test_set "poly"       grad_tests_poly;
      make_grad_test_set "logexp"     grad_tests_logexp;
      make_grad_test_set "other"      grad_tests_other;
      make_grad_test_set "trig"       grad_tests_trig;
      make_grad_test_set "hyperbolic" grad_tests_hype;
    ]

end
