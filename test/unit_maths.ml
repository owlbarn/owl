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

  let test_i0 () =
    M.i0 0.3 -. 1.0226268793515974 < eps

  let test_i0e () =
    M.i0e 0.3 -. 0.7575806251825481 < eps

  let test_i1 () =
    M.i1 0.3 -. 0.15169384000359282 < eps

  let test_i1e () =
    M.i1e 0.3 -. 0.11237756063983881 < eps

  let test_iv () =
    M.iv 0.3 0.1 -. 0.45447035229197424 < eps

  let test_k0 () =
    M.k0 0.3 -. 1.3724600605442983 < eps

  let test_k0e () =
    M.k0e 0.3 -. 1.8526273007720155 < eps

  let test_k1 () =
    M.k1 0.3 -. 3.0559920334573252 < eps

  let test_k1e () =
    M.k1e 0.3 -. 4.12515776224447 < eps

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

let test_i0 () =
  Alcotest.(check bool) "test i0" true (To_test.test_i0 ())

let test_i0e () =
  Alcotest.(check bool) "test i0e" true (To_test.test_i0e ())

let test_i1 () =
  Alcotest.(check bool) "test i1" true (To_test.test_i1 ())

let test_i1e () =
  Alcotest.(check bool) "test i1e" true (To_test.test_i1e ())

let test_iv () =
  Alcotest.(check bool) "test iv" true (To_test.test_iv ())

let test_k0 () =
  Alcotest.(check bool) "test k0" true (To_test.test_k0 ())

let test_k0e () =
  Alcotest.(check bool) "test k0e" true (To_test.test_k0e ())

let test_k1 () =
  Alcotest.(check bool) "test k1" true (To_test.test_k1 ())

let test_k1e () =
  Alcotest.(check bool) "test k1e" true (To_test.test_k1e ())

let test_set = [
  "test j0", `Slow, test_j0;
  "test j1", `Slow, test_j1;
  "test jv", `Slow, test_jv;
  "test y0", `Slow, test_y0;
  "test y1", `Slow, test_y1;
  "test yv", `Slow, test_yv;
  "test i0", `Slow, test_i0;
  "test i0e", `Slow, test_i0e;
  "test i1", `Slow, test_i1;
  "test i1e", `Slow, test_i1e;
  "test iv", `Slow, test_iv;
  "test k0", `Slow, test_k0;
  "test k0e", `Slow, test_k0e;
  "test k1", `Slow, test_k1;
  "test k1e", `Slow, test_k1e;
]
