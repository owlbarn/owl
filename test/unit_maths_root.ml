(** Unit test for Owl_maths_root module *)

module M = Owl_maths_root


(* define the test error *)
let eps = 1e-6

let approx_equal a b = Pervasives.(abs_float (a -. b) < eps)


(* a module with functions to test *)
module To_test = struct

  let test_01 () =
    let x = M.bisec ~xtol:1e-10 sin 3. 4. in
    approx_equal x 3.14159265358979324

  let test_02 () =
    let x = M.false_pos ~xtol:1e-10 sin 3. 4. in
    approx_equal x 3.14159265358979324

  let test_03 () =
    let x = M.ridder ~xtol:1e-10 sin 3. 4. in
    approx_equal x 3.14159265358979324

  let test_04 () =
    let x = M.brent ~xtol:1e-10 sin 3. 4. in
    approx_equal x 3.14159265358979324

end


(* the tests *)

let test_01 () =
  Alcotest.(check bool) "test 01" true (To_test.test_01 ())

let test_02 () =
  Alcotest.(check bool) "test 02" true (To_test.test_02 ())

let test_03 () =
  Alcotest.(check bool) "test 03" true (To_test.test_03 ())

let test_04 () =
  Alcotest.(check bool) "test 04" true (To_test.test_04 ())


let test_set = [
  "test 01", `Slow, test_01;
  "test 02", `Slow, test_02;
  "test 03", `Slow, test_03;
  "test 04", `Slow, test_04;
]
