(** Unit test for Pooling3D operations *)

open Owl

module N = Dense.Ndarray.S

(* Functions used in tests *)

let tolerance_f64 = 1e-8
let tolerance_f32 = 5e-4
let close a b =
  N.(a - b |> abs |> sum') < tolerance_f32

let test_maxpool3d input_shape kernel stride pad =
  let inp = N.sequential ~a:1. input_shape in
  N.max_pool3d ~padding:pad inp kernel stride

let test_avgpool3d input_shape kernel stride pad =
  let inp = N.sequential ~a:1. input_shape in
  N.avg_pool3d ~padding:pad inp kernel stride

let verify_value fn input_shape kernel stride pad expected =
  let a = fn input_shape kernel stride pad in
  let output_shape = N.shape a in
  let b = N.of_array expected output_shape in
  close a b

(* Test AvgPooling3D and MaxPooling3D forward operations *)

module To_test_pool3d = struct

  (* testAvgPool3dValidPadding *)
  let fun00 () =
    let expected = [|20.5;21.5;22.5|] in
    verify_value test_avgpool3d [|1;3;3;3;3|] [|2;2;2|] [|2;2;2|] VALID expected

  (* testAvgPool3dSamePadding *)
  let fun01 () =
    let expected = [|20.5;21.5;22.5; 26.5; 27.5; 28.5|] in
    verify_value test_avgpool3d [|1;2;2;4;3|] [|2;2;2|] [|2;2;2|] SAME expected

  (* testAvgPool3dSamePaddingDifferentStrides *)
  let fun02 () =
    let expected = [|1.5; 4.5; 7.5; 17.5; 20.5; 23.5; 33.5; 36.5; 39.5|] in
    verify_value test_avgpool3d [|1;5;8;1;1|] [|1;2;3|] [|2;3;1|] SAME expected

  (* testMaxPool3dValidPadding *)
  let fun03 () =
    let expected = [|40.0; 41.0; 42.0|] in
    verify_value test_maxpool3d [|1;3;3;3;3|] [|2;2;2|] [|2;2;2|] VALID expected

  (* testMaxPool3dSamePadding *)
  let fun04 () =
    let expected = [|31.; 32.; 33.; 34.; 35.; 36.|] in
    verify_value test_maxpool3d [|1;2;2;3;3|] [|2;2;2|] [|2;2;2|] SAME expected

  (* testMaxPool3dSamePaddingDifferentStrides *)
  let fun05 () =
    let expected = [|2.; 5.; 8.; 18.; 21.; 24.; 34.; 37.; 40.|] in
    verify_value test_maxpool3d [|1;5;8;1;1|] [|1;2;3|] [|2;3;1|] SAME expected

  (* testKernelSmallerThanStride1 *)
  let fun06 () =
    let expected = [|1.; 3.; 7.; 9.; 19.; 21.; 25.; 27.|] in
    verify_value test_maxpool3d [|1;3;3;3;1|] [|1;1;1|] [|2;2;2|] SAME expected

  (* testKernelSmallerThanStride2 *)
  let fun07 () =
    let expected = [|58.; 61.; 79.; 82.; 205.; 208.; 226.; 229.|] in
    verify_value test_maxpool3d [|1;7;7;7;1|] [|2;2;2|] [|3;3;3|] VALID expected

  (* testKernelSmallerThanStride3 *)
  let fun08 () =
    let expected = [|1.; 3.; 7.; 9.; 19.; 21.; 25.; 27.|] in
    verify_value test_avgpool3d [|1;3;3;3;1|] [|1;1;1|] [|2;2;2|] SAME expected

  (* testKernelSmallerThanStride4 *)
  let fun09 () =
    let expected = [|29.5; 32.5; 50.5; 53.5; 176.5; 179.5; 197.5; 200.5|] in
    verify_value test_avgpool3d [|1;7;7;7;1|] [|2;2;2|] [|3;3;3|] VALID expected
end

(* TODO: Max/Pooling3D Backward Tests *)

(* tests for forward 3D pooling operations *)

let fun_forward00 () =
  Alcotest.(check bool) "fun_forward00" true (To_test_pool3d.fun00 ())

let fun_forward01 () =
  Alcotest.(check bool) "fun_forward01" true (To_test_pool3d.fun01 ())

let fun_forward02 () =
  Alcotest.(check bool) "fun_forward02" true (To_test_pool3d.fun02 ())

let fun_forward03 () =
  Alcotest.(check bool) "fun_forward03" true (To_test_pool3d.fun03 ())

let fun_forward04 () =
  Alcotest.(check bool) "fun_forward04" true (To_test_pool3d.fun04 ())

let fun_forward05 () =
  Alcotest.(check bool) "fun_forward05" true (To_test_pool3d.fun05 ())

let fun_forward06 () =
  Alcotest.(check bool) "fun_forward06" true (To_test_pool3d.fun06 ())

let fun_forward07 () =
  Alcotest.(check bool) "fun_forward07" true (To_test_pool3d.fun07 ())

let fun_forward08 () =
  Alcotest.(check bool) "fun_forward08" true (To_test_pool3d.fun08 ())

let fun_forward09 () =
  Alcotest.(check bool) "fun_forward09" true (To_test_pool3d.fun09 ())
  

let test_set = [
  "fun_forward00", `Slow, fun_forward00;
  "fun_forward01", `Slow, fun_forward01;
  "fun_forward02", `Slow, fun_forward02;
  "fun_forward03", `Slow, fun_forward03;
  "fun_forward04", `Slow, fun_forward04;
  "fun_forward05", `Slow, fun_forward05;
  "fun_forward06", `Slow, fun_forward06;
  "fun_forward07", `Slow, fun_forward07;
  "fun_forward08", `Slow, fun_forward08;
  "fun_forward09", `Slow, fun_forward09;
]
