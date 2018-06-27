(** Unit test for Algodiff module *)

open Owl_types


(* functor to generate test unit. *)

module Make
  (M : Ndarray_Algodiff with type elt = float)
  = struct

  module AlgoM = Owl_algodiff_generic.Make (M)
  open AlgoM

  (* define the test error *)

  let eps = 1e-14

  let approx_equal a b = Pervasives.abs_float (a -. b) < eps

  let approx_equal_arr a b =
    let r = ref true in
    M.(sub a b |> abs)
    |> M.map (fun c -> if c >= eps then r := false; c)
    |> ignore;
    !r


  (* a module with functions to test *)
  
  module To_test = struct

    let dumb () = true

    let sin1 x = x |> diff Maths.sin |> unpack_flt

    let sin2 x = x |> diff (diff Maths.sin) |> unpack_flt

    let sin3 x = x |> diff (diff (diff Maths.sin)) |> unpack_flt

    (* define a new function to test *)
    let pfuna x = Maths.((F 2.) * (x * x * x) + (F 3.) * (x * x) - (F 5.) * x + (F 1.))

    let poly1 x = x |> diff pfuna |> unpack_flt

    let poly2 x = x |> diff (diff pfuna) |> unpack_flt

    let poly3 x = x |> diff (diff (diff pfuna)) |> unpack_flt

    (* define a new function to test *)
    let pfunb x = Maths.((F 2.) * x * x + (F 3.) * sin x - (F 1. / x))

    let poly4 x = x |> diff pfunb |> unpack_flt

    let poly5 x = x |> diff (diff pfunb) |> unpack_flt

    let poly6 x = x |> diff (diff (diff pfunb)) |> unpack_flt

    (* define a new function to test *)
    let pfunc x = Maths.(F 2. * sqr x + sqrt x - tanh x)

    let poly7 x = x |> diff pfunc |> unpack_flt

    let poly8 x = x |> diff (diff pfunc) |> unpack_flt

    let poly9 x = x |> diff (diff (diff pfunc)) |> unpack_flt |> approx_equal 0.00636573616030225702

    let derivative_delta f df x = ((diff f (F x)) |> unpack_flt) -. (df x)
    (** derivative_delta f df x returns the delta between the *algodiff*
        derivative of f at x and the function df applied to x

        f : a Maths function D.t -> D.t which maps a D.t 'x' value (always an (F
        float) here) to f(x)

        df : float -> float maps x to the value of df/dx at x

        x : float **)

    let check_derivative ?eps:(eps=0.) f df x =
      let delta = derivative_delta f df x in
      (abs_float delta) < eps
    (** check_derivative ?eps f df x returns true if the absolute delta between
        the *algodiff* derivative calculation and the provided df at x is smaller
        than epsilon

        f : a Maths function D.t -> D.t which maps a D.t 'x' value (always an (F
        float) here) to f(x)

        df : float -> float maps x to the value of df/dx at x

        x : float **)

    let check_derivative_array ?eps:(eps=0.) f df x_arr =
      M.print x_arr;
      let df_arr   = M.map (fun x -> df x) x_arr in
      M.print df_arr;
      let diff_arr = M.map (fun x -> diff f (F x) |> unpack_flt) x_arr in
      M.print diff_arr;
      approx_equal_arr df_arr diff_arr
      (** check_derivative_array ?eps f df x_arr returns true if the absolute delta
          between the *algodiff* derivative calculation and the provided df at every
          value in the float array x_arr is smaller than epsilon

          f : a Maths function D.t -> D.t which maps a D.t 'x' value (always an (F
          float) here) to f(x)

          df : float -> float maps x to the value of df/dx at x

          x_arr : float array **)

  end

  let check_derivative ?eps:(eps=1e-10) text f df xs =
    let error_msg x = (Printf.sprintf "%s : x=%f : error=%f " text x (To_test.derivative_delta f df x)) in
    let test_x x = Alcotest.(check bool) (error_msg x) true (To_test.check_derivative ~eps:eps f df x) in
    Array.iter test_x xs;
    let x_arr = M.init [|Array.length xs|] (fun i -> xs.(i)) in
    let array_passed = To_test.(check_derivative_array ~eps:eps f df x_arr) in
    Alcotest.(check bool) (Printf.sprintf "Array test for %s" text) true array_passed
  (** check_derivatives ?eps text f df xs

      This function takes a Maths function f : D.t->D.t and a known good
      derivative function df : float -> float, and tests the *algodiff*
      differentiation of f at the set of points provided by the float array xs.

      The two derived values must be within *eps:float* of each other to be valid.

      On failure, and error message including *text:string* will be displayed.

      Two types of checked are performed. Firstly the values in *xs:float array*
      are checked individually as Maths.t 'F x' values. Secondly the values in
     *xs* are converted to a Bigarray, and 'diff f array' is invoked, as well as
      an iterated mapping of each element of *xs* to a new element in a Bigarray
      for df. These two arrays are then compared using the Owl 'approx_equal'
      array comparison function, and if any elements differ by more than eps then
      an error is displayed (the failing entry numebr is not displayed at
      present)

   **)

  (* Still to test array functions

     Array: sum mean dot transpose inv relu

     and a few more

  *)

  (* Test data *)
  let xs = [| -4.; -3.; -2.; -1.2; -1.1; -1.; -0.9; -0.8; -0.7; -0.6; -0.5;
              -0.4; -0.3; -0.2; -0.1; 0.; 0.1; 0.2; 0.3; 0.4; 0.5; 0.6; 0.7;
              0.8; 0.9; 1.; 1.1; 1.2; 2.; 3.; 4.; |]

  let xs_filter f =
    let filter acc x     = if (f x) then x::acc else acc in
    let filtered_xs_list = Array.fold_left filter [] xs in
    Array.of_list filtered_xs_list

  let x_ne_y x y = ((abs_float (x -. y)) > 0.00000001)

  let xs_gt_one = xs_filter (fun x -> (x > 1.0))

  let xs_abs_lt_one = xs_filter (fun x -> ((x > (-1.) && (x < 1.0))))

  let xs_nonones = xs_filter (fun x -> (x_ne_y x 1.0) && (x_ne_y x (-1.)))

  let xs_nonzero = xs_filter (fun x -> (x_ne_y x 0.0))

  let xs_nonzero_nonone = xs_filter (fun x -> (x_ne_y x 0.0) && (x_ne_y x 1.0))

  let xs_positive = xs_filter (fun x -> (x >= 0.0))

  let xs_positive_nonzero =  xs_filter (fun x -> (x > 0.0))

  (* Simple powers/multiples of x *)
  let constant () =
    check_derivative "f(x) = 1" (fun x -> Maths.(F 1.)) (fun x -> 0.) xs

  let linear () =
    check_derivative "f(x) = x" (fun x -> Maths.(x)) (fun x -> 1.) xs

  let square () =
    check_derivative "f(x) = x^2" (fun x -> Maths.(x * x)) (fun x -> 2.*.x) xs

  let cube () =
    check_derivative "f(x) = x^3" (fun x -> Maths.(x * x * x )) (fun x -> 3.*.x*.x) xs

  let sum_x_x () =
    check_derivative "f(x) = x + x" (fun x -> Maths.(x + x)) (fun x -> 2.) xs

  let diff_2x_x () =
    check_derivative "f(x) = 2x - x" (fun x -> Maths.((F 2.) * x - x)) (fun x -> 1.) xs

  let div_x_x () =
    check_derivative "f(x) = x / x" (fun x -> Maths.(x / x)) (fun x -> 0.) xs_nonzero

  let div_x2_x () =
    check_derivative "f(x) = x^2 / x" (fun x -> Maths.((x * x) / x)) (fun x -> 1.) xs_nonzero

  let pow_x_2_5 () =
    check_derivative "f(x) = x^(2.5)" (fun x -> Maths.(x ** (F 2.5))) (fun x -> 2.5 *. (x**1.5)) xs_positive

  let pow_2_5_x () =
    check_derivative "f(x) = 2.5^x" (fun x -> Maths.((F 2.5) ** x)) (fun x -> (log 2.5) *. (2.5**x)) xs

  (* Min, max, neg, abs, sign, floor/ceil/round *)

  let min_x_x2 () =
    (* min2 f(x) g(x) is INCORRECT at points where f(x)=g(x) as the function is not
       differentiable at those points *)
    check_derivative "f(x) = min(x,x^2)"
      (fun x -> Maths.(min2 (x) (x*x)))
      (fun x -> (if ((x < 0.0) || (x > 1.0)) then 1. else (2.*.x)))
      xs_nonzero_nonone

  let max_x_x2 () =
    (* max2 f(x) g(x) is INCORRECT at points where f(x)=g(x) as the function is not
       differentiable at those points *)
    check_derivative  "f(x) = max(x,x^2)"
      (fun x -> Maths.(max2 (x) (x*x)))
      (fun x -> (if ((x < 0.0) || (x > 1.0)) then (2.*.x) else 1.))
      xs_nonzero_nonone

  let neg_x () =
    check_derivative "f(x) = -x"
      (fun x -> Maths.(neg x))
      (fun x -> (-1.))
      xs

  let abs_x2 () =
    check_derivative "f(x) = abs(x^2)"
      (fun x -> Maths.(abs (x*x)))
      (fun x -> 2. *. x)
      xs

  let abs_x2_m_1 () =
    (* abs f(x) is INCORRECT at points where f(x)=0 as the function is not differentiable at those points *)
    check_derivative "f(x) = abs(x^2-1)"
      (fun x -> Maths.(abs (x*x - (F 1.))))
      (fun x -> (if (x < (-1.) || (x > 1.)) then (2. *. x) else ((-2.) *. x)))
      xs_nonones

  let sign_x2_m_1 () =
    (* sign(f) is not differentiable when f is zero, but otherwise its derivative is zero; hence d/dx(sign(f(x)) === 0 *)
    check_derivative "f(x) = signum(x^2-1)"
      (fun x -> Maths.(signum (x*x -(F 1.))))
      (fun x -> 0.)
      xs

  let floor_x2_m_1 () =
    (* floor(f) is not differentiable when f is an integer, but otherwise its derivative is zero; hence d/dx === 0 *)
    check_derivative "f(x) = floor(x^2-1)"
      (fun x -> Maths.(floor (x*x - (F 1.))))
      (fun x -> 0.)
      xs

  let ceil_x2_m_1 () =
    (* ceil(f) is not differentiable when f is an integer, but otherwise its derivative is zero; hence d/dx === 0 *)
    check_derivative "f(x) = ceil(x^2-1)"
      (fun x -> Maths.(ceil (x*x - (F 1.))))
      (fun x -> 0.)
      xs

  let round_x2_m_1 () =
    (* round(f) is not differentiable when f is an integer, but otherwise its derivative is zero; hence d/dx === 0 *)
    check_derivative "f(x) = round(x^2-1)"
      (fun x -> Maths.(round (x*x - (F 1.))))
      (fun x -> 0.)
      xs

  (* sqr, sqrt, log, log2, log10, exp *)
  let sqr_x () =
    check_derivative "f(x) = sqr(x)"
      (fun x -> Maths.(sqr x))
      (fun x -> 2. *. x)
      xs

  let sqr_x_x () =
    check_derivative "f(x) = sqr(x*x)"
      (fun x -> Maths.(sqr (x*x)))
      (fun x -> 4. *. x *. x *. x)
      xs

  let sqrt_x () =
    check_derivative "f(x) = sqrt(x)"
      (fun x -> Maths.(sqrt x))
      (fun x -> 0.5 /. (x ** 0.5))
      xs_positive_nonzero

  let log_x () =
    check_derivative "f(x) = log(x)"
      (fun x -> Maths.(log x))
      (fun x -> 1. /. x)
      xs_positive_nonzero

  let log_x_x () =
    check_derivative "f(x) = log(x*x)"
      (fun x -> Maths.(log (x*x)))
      (fun x -> 2. /. x)
      xs_positive_nonzero

  let log2_x () =
    check_derivative "f(x) = log2(x)"
      (fun x -> Maths.(log2 (x)))
      (fun x -> (log 2.) /. x )
      xs_positive_nonzero

  let log10_x () =
    check_derivative "f(x) = log10(x)"
      (fun x -> Maths.(log10 (x)))
      (fun x -> (log 10.) /. x )
      xs_positive_nonzero

  let exp_x () =
    check_derivative "f(x) = exp(x)"
      (fun x -> Maths.(exp (x)))
      (fun x -> exp x )
      xs

  (* trigonometric functions - sin, cos, tan, asin, acos, atan, atan2 *)

  let sin_x () =
    check_derivative "f(x) = sin(x)"
      (fun x -> Maths.(sin (x)))
      (fun x -> cos x )
      xs

  let sin_x_x () =
    check_derivative "f(x) = sin(x*x)"
      (fun x -> Maths.(sin (x * x)))
      (fun x -> 2. *. x *. (cos (x*.x)))
      xs

  let cos_x () =
    check_derivative "f(x) = cos(x)"
      (fun x -> Maths.(cos (x)))
      (fun x -> sin (-. x))
      xs

  let tan_x () =
    check_derivative "f(x) = tan(x)"
      (fun x -> Maths.(tan (x)))
      (fun x -> 1. /. ((cos x) ** 2.))
      xs

  let asin_x () =
    check_derivative "f(x) = asin(x)"
      (fun x -> Maths.(asin (x)))
      (fun x -> 1. /. sqrt( 1. -. (x**2.)))
      xs_abs_lt_one

  let acos_x () =
    check_derivative "f(x) = acos(x)"
      (fun x -> Maths.(acos (x)))
      (fun x -> (-1.) /. sqrt( 1. -. (x**2.)))
      xs_abs_lt_one

  let atan_x () =
    check_derivative "f(x) = atan(x)"
      (fun x -> Maths.(atan (x)))
      (fun x -> 1. /. ( 1. +. (x**2.)))
      xs

  let atan2_x2_x () =
    check_derivative "f(x) = atan2(x*x,x)"
      (fun x -> Maths.(atan2 (x*x) x))
      (fun x -> 1. /. ( 1. +. (x**2.)))
      xs_nonzero

  let atan2_x_x2 () =
    check_derivative "f(x) = atan2(x,x*x)"
      (fun x -> Maths.(atan2 x (x*x)))
      (fun x -> (-1.) /. ( 1. +. (x**2.)))
      xs_nonzero

  (* trigonometric functions - sin, cos, tan, asin, acos, atan, atan2 *)

  let sinh_x () =
    check_derivative "f(x) = sinh(x)"
      (fun x -> Maths.(sinh (x)))
      (fun x -> cosh x )
      xs

  let sinh_x_x () =
    check_derivative "f(x) = sinh(x*x)"
      (fun x -> Maths.(sinh (x * x)))
      (fun x -> 2. *. x *. (cosh (x*.x)))
      xs

  let cosh_x () =
    check_derivative "f(x) = cosh(x)"
      (fun x -> Maths.(cosh (x)))
      (fun x -> sinh x)
      xs

  let tanh_x () =
    check_derivative "f(x) = tanh(x)"
      (fun x -> Maths.(tanh (x)))
      (fun x -> 1. -. ((tanh x) ** 2.))
      xs

  let asinh_x () =
    check_derivative "f(x) = asinh(x)"
      (fun x -> Maths.(asinh (x)))
      (fun x -> 1. /. sqrt( 1. +. (x**2.)))
      xs

  let acosh_x () =
    check_derivative "f(x) = acosh(x)"
      (fun x -> Maths.(acosh (x)))
      (fun x -> 1. /. sqrt( (-1.) +. (x**2.)))
      xs_gt_one

  let atanh_x () =
    check_derivative "f(x) = atanh(x)"
      (fun x -> Maths.(atanh (x)))
      (fun x -> 1. /. ( 1. -. (x**2.)))
      xs_abs_lt_one

  (* the tests *)

  let dumb () =
    Alcotest.(check bool) "dumb" true (To_test.dumb ())

  let sin1 () =
    Alcotest.(check (float eps)) "sin1" (cos 1.) (To_test.sin1 (F 1.))

  let sin2 () =
    Alcotest.(check (float eps)) "sin2" (-.(sin 1.)) (To_test.sin2 (F 1.))

  let sin3 () =
    Alcotest.(check (float eps)) "sin3" (-.(cos 1.)) (To_test.sin3 (F 1.))

  let poly1 () =
    Alcotest.(check (float eps)) "poly1" 31. (To_test.poly1 (F 2.))

  let poly2 () =
    Alcotest.(check (float eps)) "poly2" 30. (To_test.poly2 (F 2.))

  let poly3 () =
    Alcotest.(check (float eps)) "poly3" 12. (To_test.poly3 (F 2.))

  let poly4 () =
    Alcotest.(check (float eps)) "poly4" (12. +. 3. *. cos 3. +. 1. /. 9.) (To_test.poly4 (F 3.))

  let poly5 () =
    Alcotest.(check (float eps)) "poly5" (4. -. 3. *. sin 3. -. 2. /. 27.) (To_test.poly5 (F 3.))

  let poly6 () =
    Alcotest.(check (float eps)) "poly6" (-3. *. cos 3. +. 6. /. 81.) (To_test.poly6 (F 3.))

  let poly7 () =
    Alcotest.(check (float eps)) "poly7" (16. +. 0.25 -. (Owl.Maths.sech 4.) ** 2.) (To_test.poly7 (F 4.))

  let poly8 () =
    Alcotest.(check (float eps)) "poly8" (-0.25 /. (4. ** 1.5) +. 2. *. (Owl.Maths.tanh 4.) *. ((Owl.Maths.sech 4.) ** 2.) +. 4.) (To_test.poly8 (F 4.))

  let poly9 () =
    Alcotest.(check bool) "poly9" true (To_test.poly9 (F 4.))

  let test_set = [
    (* "new",            `Slow, newtest;*)

    "constant",            `Slow, constant;
    "linear",              `Slow, linear;
    "square",              `Slow, square;
    "cube",                `Slow, cube;
    "sum_x_x",             `Slow, sum_x_x;
    "diff_2x_x",           `Slow, diff_2x_x;
    "div_x_x",             `Slow, div_x_x;
    "div_x2_x",            `Slow, div_x2_x;
    "pow_2_5_x",           `Slow, pow_2_5_x;
    "pow_x_2_5",           `Slow, pow_x_2_5;
    "min_x_x2",            `Slow, min_x_x2;
    "max_x_x2",            `Slow, max_x_x2;
    "neg_x",               `Slow, neg_x;
    "abs_x2",              `Slow, abs_x2;
    "abs_x2_m_1",          `Slow, abs_x2_m_1;
    "sign_x2_m_1",         `Slow, sign_x2_m_1;
    "floor_x2_m_1",        `Slow, floor_x2_m_1;
    "ceil_x2_m_1",         `Slow, ceil_x2_m_1;
    "round_x2_m_1",        `Slow, round_x2_m_1;
    "sqr_x",               `Slow, sqr_x;
    "sqr_x_x",             `Slow, sqr_x_x;
    "sqrt_x",              `Slow, sqrt_x;
    "log_x",               `Slow, log_x;
    "log_x_x",             `Slow, log_x_x;
    "log2_x",              `Slow, log2_x;
    "log10_x",             `Slow, log10_x;
    "exp_x",               `Slow, exp_x;
    "sin_x",               `Slow, sin_x;
    "sin_x_x",             `Slow, sin_x_x;
    "cos_x",               `Slow, cos_x;
    "tan_x",               `Slow, tan_x;
    "asin_x",              `Slow, asin_x;
    "acos_x",              `Slow, acos_x;
    "atan_x",              `Slow, atan_x;
    "atan2_x2_x",          `Slow, atan2_x2_x;
    "atan2_x_x2",          `Slow, atan2_x_x2;
    "sinh_x",              `Slow, sinh_x;
    "sinh_x_x",            `Slow, sinh_x_x;
    "cosh_x",              `Slow, cosh_x;
    "tanh_x",              `Slow, tanh_x;
    "asinh_x",             `Slow, asinh_x;
    "acosh_x",             `Slow, acosh_x;
    "atanh_x",             `Slow, atanh_x;

    "dumb",                `Slow, dumb;
    "sin1",                `Slow, sin1;
    "sin2",                `Slow, sin2;
    "sin3",                `Slow, sin3;
    "poly1",               `Slow, poly1;
    "poly2",               `Slow, poly2;
    "poly3",               `Slow, poly3;
    "poly4",               `Slow, poly4;
    "poly5",               `Slow, poly5;
    "poly6",               `Slow, poly6;
    "poly7",               `Slow, poly7;
    "poly8",               `Slow, poly8;
    "poly9",               `Slow, poly9;
  ]

end
