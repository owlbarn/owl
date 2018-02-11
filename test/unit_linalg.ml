(** Unit test for Owl_linalg module *)

open Owl

module M = Owl.Linalg.D

(* define the test error *)

let approx_equal a b =
  let eps = 1e-10 in
  Pervasives.(abs_float (a -. b) < eps)


(* some test input *)

let x0 = Mat.sequential ~a:1. 1 6

let x1 = Mat.sequential ~a:1. 3 3


(* a module with functions to test *)
module To_test = struct

  let rank () =
    let x = Mat.sequential 4 4 in
    M.rank x = 2

  let det () =
    let x = Mat.hadamard 4 in
    M.det x = 16.

  let inv () =
    let x = Mat.hadamard 4 in
    M.inv x |> Mat.sum' = 1.

  let vecnorm_01 () =
    let a = M.vecnorm ~p:1. x0 in
    approx_equal a 21.

  let vecnorm_02 () =
    let a = M.vecnorm ~p:2. x0 in
    approx_equal a 9.539392014169456

  let vecnorm_03 () =
    let a = M.vecnorm ~p:3. x0 in
    approx_equal a 7.6116626110202441

  let vecnorm_04 () =
    let a = M.vecnorm ~p:4. x0 in
    approx_equal a 6.9062985796189906

  let vecnorm_05 () =
    let a = M.vecnorm ~p:infinity x0 in
    approx_equal a 6.

  let vecnorm_06 () =
    let a = M.vecnorm ~p:(-1.) x0 in
    approx_equal a 0.40816326530612251

  let vecnorm_07 () =
    let a = M.vecnorm ~p:(-2.) x0 in
    approx_equal a 0.81885036774322384

  let vecnorm_08 () =
    let a = M.vecnorm ~p:(-3.) x0 in
    approx_equal a 0.94358755060582611

  let vecnorm_09 () =
    let a = M.vecnorm ~p:(-4.) x0 in
    approx_equal a 0.98068869669651115

  let vecnorm_10 () =
    let a = M.vecnorm ~p:neg_infinity x0 in
    approx_equal a 1.

  let norm_01 () =
    let a = M.norm ~p:1. x1 in
    approx_equal a 18.

  let norm_02 () =
    let a = M.norm ~p:2. x1 in
    approx_equal a 16.84810335261421

  let norm_03 () =
    let a = M.norm ~p:infinity x1 in
    approx_equal a 24.

  let norm_04 () =
    let a = M.norm ~p:(-1.) x1 in
    approx_equal a 12.

  let norm_05 () =
    let a = M.norm ~p:(-2.) x1 in
    approx_equal a 3.3347528650314325e-16

  let norm_06 () =
    let a = M.norm ~p:neg_infinity x1 in
    approx_equal a 6.

  let is_triu_1 () =
    let x = Mat.of_array [|1.;2.;3.;0.;5.;6.;0.;0.;9.|] 3 3 in
    M.is_triu x = true

  let is_triu_2 () =
    let x = Mat.of_array [|1.;2.;3.;4.;5.;6.;0.;0.;9.|] 3 3 in
    M.is_triu x = false

  let is_tril_1 () =
    let x = Mat.of_array [|1.;0.;0.;4.;5.;0.;7.;8.;9.|] 3 3 in
    M.is_tril x = true

  let is_tril_2 () =
    let x = Mat.of_array [|1.;0.;3.;4.;5.;0.;7.;8.;9.|] 3 3 in
    M.is_tril x = false

  let is_symmetric_1 () =
    let x = Mat.of_array [|1.;2.;3.;2.;5.;6.;3.;6.;9.|] 3 3 in
    M.is_symmetric x = true

  let is_symmetric_2 () =
    let x = Mat.of_array [|1.;2.;3.;4.;5.;6.;3.;6.;9.|] 3 3 in
    M.is_symmetric x = false

  let is_diag_1 () =
    let x = Mat.of_array [|1.;0.;0.;0.;1.;0.;0.;0.;1.|] 3 3 in
    M.is_diag x = true

  let is_diag_2 () =
    let x = Mat.of_array [|1.;0.;0.;0.;1.;0.;0.;1.;1.|] 3 3 in
    M.is_diag x = false

end

(* the tests *)

let rank () =
  Alcotest.(check bool) "rank" true (To_test.rank ())

let det () =
  Alcotest.(check bool) "det" true (To_test.det ())

let inv () =
  Alcotest.(check bool) "inv" true (To_test.inv ())

let vecnorm_01 () =
  Alcotest.(check bool) "vecnorm_01" true (To_test.vecnorm_01 ())

let vecnorm_02 () =
  Alcotest.(check bool) "vecnorm_02" true (To_test.vecnorm_02 ())

let vecnorm_03 () =
  Alcotest.(check bool) "vecnorm_03" true (To_test.vecnorm_03 ())

let vecnorm_04 () =
  Alcotest.(check bool) "vecnorm_04" true (To_test.vecnorm_04 ())

let vecnorm_05 () =
  Alcotest.(check bool) "vecnorm_05" true (To_test.vecnorm_05 ())

let vecnorm_06 () =
  Alcotest.(check bool) "vecnorm_06" true (To_test.vecnorm_06 ())

let vecnorm_07 () =
  Alcotest.(check bool) "vecnorm_07" true (To_test.vecnorm_07 ())

let vecnorm_08 () =
  Alcotest.(check bool) "vecnorm_08" true (To_test.vecnorm_08 ())

let vecnorm_09 () =
  Alcotest.(check bool) "vecnorm_09" true (To_test.vecnorm_09 ())

let vecnorm_10 () =
  Alcotest.(check bool) "vecnorm_10" true (To_test.vecnorm_10 ())

let norm_01 () =
  Alcotest.(check bool) "norm_01" true (To_test.norm_01 ())

let norm_02 () =
  Alcotest.(check bool) "norm_02" true (To_test.norm_02 ())

let norm_03 () =
  Alcotest.(check bool) "norm_03" true (To_test.norm_03 ())

let norm_04 () =
  Alcotest.(check bool) "norm_04" true (To_test.norm_04 ())

let norm_05 () =
  Alcotest.(check bool) "norm_05" true (To_test.norm_05 ())

let norm_06 () =
  Alcotest.(check bool) "norm_06" true (To_test.norm_06 ())

let is_triu_1 () =
  Alcotest.(check bool) "is_triu_1" true (To_test.is_triu_1 ())

let is_triu_2 () =
  Alcotest.(check bool) "is_triu_2" true (To_test.is_triu_2 ())

let is_tril_1 () =
  Alcotest.(check bool) "is_tril_1" true (To_test.is_tril_1 ())

let is_tril_2 () =
  Alcotest.(check bool) "is_tril_2" true (To_test.is_tril_2 ())

let is_symmetric_1 () =
  Alcotest.(check bool) "is_symmetric_1" true (To_test.is_symmetric_1 ())

let is_symmetric_2 () =
  Alcotest.(check bool) "is_symmetric_2" true (To_test.is_symmetric_2 ())

let is_diag_1 () =
  Alcotest.(check bool) "is_diag_1" true (To_test.is_diag_1 ())

let is_diag_2 () =
  Alcotest.(check bool) "is_diag_2" true (To_test.is_diag_2 ())

let test_set = [
  "rank", `Slow, rank;
  "det", `Slow, det;
  "inv", `Slow, inv;
  "vecnorm_01", `Slow, vecnorm_01;
  "vecnorm_02", `Slow, vecnorm_02;
  "vecnorm_03", `Slow, vecnorm_03;
  "vecnorm_04", `Slow, vecnorm_04;
  "vecnorm_05", `Slow, vecnorm_05;
  "vecnorm_06", `Slow, vecnorm_06;
  "vecnorm_07", `Slow, vecnorm_07;
  "vecnorm_08", `Slow, vecnorm_08;
  "vecnorm_09", `Slow, vecnorm_09;
  "vecnorm_10", `Slow, vecnorm_10;
  "norm_01", `Slow, norm_01;
  "norm_02", `Slow, norm_02;
  "norm_03", `Slow, norm_03;
  "norm_04", `Slow, norm_04;
  "norm_05", `Slow, norm_05;
  "norm_06", `Slow, norm_06;
  "is_triu_1", `Slow, is_triu_1;
  "is_triu_2", `Slow, is_triu_2;
  "is_tril_1", `Slow, is_tril_1;
  "is_tril_2", `Slow, is_tril_2;
  "is_symmetric_1", `Slow, is_symmetric_1;
  "is_symmetric_2", `Slow, is_symmetric_2;
  "is_diag_1", `Slow, is_diag_1;
  "is_diag_2", `Slow, is_diag_2;
]
