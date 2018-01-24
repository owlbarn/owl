(** Unit test for Owl_maths module and special functions *)

module M = Owl_maths


(* define the test error *)
let eps = 1e-10


(* a module with functions to test *)
module To_test = struct

  let test_j0 () =
    M.j0 0.5 -. 0.93846980724081297 < eps

  let test_j1 () =
    M.j1 0.5 -. 0.24226845767487387 < eps

  let test_jv () =
    M.jv 0.1 0.3 -. 0.85180759557596664 < eps

  let test_y0 () =
    M.y0 0.5 -. (-0.44451873350670662) < eps

  let test_y1 () =
    M.y1 0.3 -. (-2.2931051383885293) < eps

  let test_yv () =
    M.yv 0.3 0.2 -. (-1.470298525261079) < eps

end


(* the tests *)

let test_j0 () =
  Alcotest.(check bool) "test j0" true (To_test.test_j0 ())

let test_j1 () =
  Alcotest.(check bool) "test j1" true (To_test.test_j1 ())

let test_jv () =
  Alcotest.(check bool) "test jv" true (To_test.test_jv ())

let test_y0 () =
  Alcotest.(check bool) "test y0" true (To_test.test_y0 ())

let test_y1 () =
  Alcotest.(check bool) "test y1" true (To_test.test_y1 ())

let test_yv () =
  Alcotest.(check bool) "test yv" true (To_test.test_yv ())

let test_set = [
  "test j0", `Slow, test_j0;
  "test j1", `Slow, test_j1;
  "test jv", `Slow, test_jv;
  "test y0", `Slow, test_y0;
  "test y1", `Slow, test_y1;
  "test yv", `Slow, test_yv;
]
