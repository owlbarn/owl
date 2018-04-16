(** Unit test for Owl_linalg module *)

open Owl

module M = Owl.Linalg.D

(* define the test error *)

let approx_equal a b =
  let eps = 1e-6 in
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

  let mpow () =
    let x = Mat.uniform 4 4 in
    let y = M.mpow x 3. in
    let z = Mat.(dot x (dot x x)) in
    approx_equal Mat.((y - z) |> sum') 0.

  let expm_1 () =
    let x = Mat.sequential ~a:1. 3 3 in
    let y = Mat.of_array
      [| 1118906.6994132 ;  1374815.06293582;  1630724.42645844;
         2533881.04189899;  3113415.03138058;  3692947.02086217;
         3948856.38438479;  4852012.99982535;  5755170.6152659 |] 3 3
    in
    let z = M.expm x in
    approx_equal Mat.((y - z) |> sum') 0.

  let expm_2 () =
    let x = Mat.(sequential ~a:1. 3 3 /$ 10.) in
    let y = Mat.of_array
      [| 1.37316027;  0.53148466;  0.68980905;
         1.00926035;  2.2481482 ;  1.48703605;
         1.64536043;  1.96481174;  3.28426304; |] 3 3
    in
    let z = M.expm x in
    approx_equal Mat.((y - z) |> sum') 0.

  let expm_3 () =
    let x = Mat.(sequential ~a:1. 3 3 /$ 50.) in
    let y = Mat.of_array
      [| 1.02667783;  0.04803414;  0.06939044;
         0.09473789;  1.11808977;  0.14144165;
         0.16279795;  0.1881454 ;  1.21349285 |] 3 3
    in
    let z = M.expm x in
    approx_equal Mat.((y - z) |> sum') 0.

  let expm_4 () =
    let x = Mat.(sequential ~a:1. 3 3 /$ 200.) in
    let y = Mat.of_array
      [| 1.00538495;  0.01046225;  0.01553954;
         0.02084758;  1.02604024;  0.03123291;
         0.03631021;  0.04161824;  1.04692628 |] 3 3
    in
    let z = M.expm x in
    approx_equal Mat.((y - z) |> sum') 0.

  let sinm () =
    let x = Mat.sequential ~a:1. 2 2 in
    let y = Mat.of_array
      [|-0.46558149; -0.14842446; -0.22263669; -0.68821818|] 2 2
    in
    let z = M.sinm x in
    approx_equal Mat.((y - z) |> sum') 0.

  let cosm () =
    let x = Mat.sequential ~a:1. 2 2 in
    let y = Mat.of_array
      [|0.85542317; -0.11087638; -0.16631457; 0.68910859|] 2 2
    in
    let z = M.cosm x in
    approx_equal Mat.((y - z) |> sum') 0.

  let tanm () =
    let x = Mat.sequential ~a:1. 2 2 in
    let y = Mat.of_array
      [|-0.60507478; -0.31274165; -0.46911248; -1.07418726|] 2 2
    in
    let z = M.tanm x in
    approx_equal Mat.((y - z) |> sum') 0.

  let sincosm () =
    let x = Mat.sequential ~a:1. 2 2 in
    let s = M.sinm x in
    let c = M.cosm x in
    let s', c' = M.sincosm x in
    (approx_equal Mat.((s - s') |> sum') 0.) &&
    (approx_equal Mat.((c - c') |> sum') 0.)

  let sinhm () =
    let x = Mat.(sequential ~a:1. 2 2 /$ 10.) in
    let y = Mat.of_array
      [|0.10625636; 0.20913073; 0.31369609; 0.41995246|] 2 2
    in
    let z = M.sinhm x in
    approx_equal Mat.((y - z) |> sum') 0.

  let coshm () =
    let x = Mat.(sequential ~a:1. 2 2 /$ 10.) in
    let y = Mat.of_array
      [|1.03583718; 0.05122002; 0.07683003; 1.11266721|] 2 2
    in
    let z = M.coshm x in
    approx_equal Mat.((y - z) |> sum') 0.

  let tanhm () =
    let x = Mat.(sequential ~a:1. 2 2 /$ 10.) in
    let y = Mat.of_array
      [|0.08894293; 0.18386007; 0.2757901; 0.36473303|] 2 2
    in
    let z = M.tanhm x in
    approx_equal Mat.((y - z) |> sum') 0.

  let sinhcoshm () =
    let x = Mat.(sequential ~a:1. 2 2 /$ 10.) in
    let s = M.sinhm x in
    let c = M.coshm x in
    let s', c' = M.sinhcoshm x in
    (approx_equal Mat.((s - s') |> sum') 0.) &&
    (approx_equal Mat.((c - c') |> sum') 0.)

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

let mpow () =
  Alcotest.(check bool) "mpow" true (To_test.mpow ())

let expm_1 () =
  Alcotest.(check bool) "expm_1" true (To_test.expm_1 ())

let expm_2 () =
  Alcotest.(check bool) "expm_2" true (To_test.expm_2 ())

let expm_3 () =
  Alcotest.(check bool) "expm_3" true (To_test.expm_3 ())

let expm_4 () =
  Alcotest.(check bool) "expm_4" true (To_test.expm_4 ())

let sinm () =
  Alcotest.(check bool) "sinm" true (To_test.sinm ())

let cosm () =
  Alcotest.(check bool) "cosm" true (To_test.cosm ())

let tanm () =
  Alcotest.(check bool) "tanm" true (To_test.tanm ())

let sincosm () =
  Alcotest.(check bool) "sincosm" true (To_test.sincosm ())

let sinhm () =
  Alcotest.(check bool) "sinhm" true (To_test.sinhm ())

let coshm () =
  Alcotest.(check bool) "coshm" true (To_test.coshm ())

let tanhm () =
  Alcotest.(check bool) "tanhm" true (To_test.tanhm ())

let sinhcoshm () =
  Alcotest.(check bool) "sinhcoshm" true (To_test.sinhcoshm ())

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
  "mpow", `Slow, mpow;
  "expm_1", `Slow, expm_1;
  "expm_2", `Slow, expm_2;
  "expm_3", `Slow, expm_3;
  "expm_4", `Slow, expm_4;
  "sinm", `Slow, sinm;
  "cosm", `Slow, cosm;
  "tanm", `Slow, tanm;
  "sincosm", `Slow, sincosm;
  "sinhm", `Slow, sinhm;
  "coshm", `Slow, coshm;
  "tanhm", `Slow, tanhm;
  "sinhcoshm", `Slow, sinhcoshm;
]
