(** Unit test for Convolution3D operations *)

open Owl

module N = Owl_base_dense_ndarray.NdarrayPureSingle

(* Functions used in tests *)

let tolerance_f64 = 1e-8
let tolerance_f32 = 5e-4

let close a b =
  N.((sub a b) |> abs |> sum') < tolerance_f32

let test_conv2d input_shape kernel_shape stride pad =
  let inp = N.sequential ~a:1. input_shape  in
  let kernel = N.sequential ~a:1. kernel_shape in
  N.conv2d ~padding:pad inp kernel stride

let test_conv2d_back_input input_shape kernel_shape stride pad =
  let inp = N.sequential ~a:1. input_shape  in
  let kernel = N.sequential ~a:1. kernel_shape in
  let output = N.conv2d ~padding:pad inp kernel stride in
  let output_shape = N.shape output in
  let output' = N.sequential ~a:1. output_shape in
  N.conv2d_backward_input  inp kernel stride output'

let test_conv2d_back_kernel input_shape kernel_shape stride pad =
  let inp = N.sequential ~a:1. input_shape  in
  let kernel = N.sequential ~a:1. kernel_shape in
  let output = N.conv2d ~padding:pad inp kernel stride in
  let output_shape = N.shape output in
  let output' = N.sequential ~a:1. output_shape in
  N.conv2d_backward_kernel inp kernel stride output'

let verify_value fn input_shape kernel_shape stride pad expected =
  let a = fn input_shape kernel_shape stride pad in
  let output_shape = N.shape a in
  let b = N.of_array expected output_shape in
  close a b


(* Test Convolution2D forward operations *)

module To_test_conv2d = struct

  (* conv2D1x1Kernel *)
  let fun00 () =
    let expected = [|
      30.0;  36.0;  42.0;  66.0;  81.0;  96.0; 102.0; 126.0; 150.0;
      138.0; 171.0; 204.0; 174.0; 216.0; 258.0; 210.0; 261.0; 312.0|] in
    verify_value test_conv2d [|1;2;3;3|] [|1;1;3;3|] [|1;1|] VALID expected

  (* conv2D2x2Kernel *)
  let fun01 () =
    let expected = [| 2271.0; 2367.0; 2463.0; 2901.0; 3033.0; 3165.0|] in
    verify_value test_conv2d [|1;2;3;3|] [|2;2;3;3|] [|1;1|] VALID expected

  (* conv2D1x2Kernel *)
  let fun02 () =
    let expected = [|
      231.0; 252.0; 273.0; 384.0; 423.0; 462.0;
      690.0; 765.0; 840.0; 843.0; 936.0; 1029.0|] in
    verify_value test_conv2d [|1;2;3;3|] [|1;2;3;3|] [|1;1|] VALID expected

  (* conv2D2x2KernelStride2 *)
  let fun03 () =
    let expected = [| 2271.0; 2367.0; 2463.0|] in
    verify_value test_conv2d [|1;2;3;3|] [|2;2;3;3|] [|2;2|] VALID expected

  (* conv2D2x2KernelStride2Same*)
  let fun04 () =
    let expected = [|2271.0; 2367.0; 2463.0; 1230.0; 1305.0; 1380.0|] in
    verify_value test_conv2d [|1;2;3;3|] [|2;2;3;3|] [|2;2|] SAME expected

end


(* Test Convolution2D input-backward operations *)

module To_test_conv2d_back_input = struct

  (* conv2D1x1Kernel *)
  let fun00 () =
    let expected = [|
      5.; 11.; 17.; 11.; 25.; 39.; 17.; 39.; 61.; 23.; 53.; 83.; 29.; 67.; 105.;
      35.; 81.; 127.; 41.; 95.; 149.; 47.; 109.; 171.; 53.; 123.; 193.; 59.;
      137.; 215.; 65.; 151.; 237.; 71.; 165.; 259.; 77.; 179.; 281.; 83.; 193.;
      303.; 89.; 207.; 325.; 95.; 221.; 347.|] in
    verify_value test_conv2d_back_input [|1;4;4;3|]
      [|1;1;3;2|] [|1;1|] VALID expected

  (* conv2D1x2KernelStride3Width5 *)
  let fun01 () =
    let expected = [|1.;2.;0.;2.;4.|] in
    verify_value test_conv2d_back_input [|1;1;5;1|]
      [|1;2;1;1|] [|3;3|] VALID expected

  (* conv2D1x2KernelStride3Width6 *)
  let fun02 () =
    let expected = [|1.;2.;0.;2.;4.;0.|] in
    verify_value test_conv2d_back_input [|1;1;6;1|]
      [|1;2;1;1|] [|3;3|] VALID expected

  (* conv2D1x2KernelStride3Width7 *)
  let fun03 () =
    let expected = [|1.;2.;0.;2.;4.;0.;0.|] in
    verify_value test_conv2d_back_input [|1;1;7;1|]
      [|1;2;1;1|] [|3;3|] VALID expected

  (* conv2D2x2KernelC1Same *)
  let fun04 () =
    let expected = [|1.; 4.; 7.; 7.; 23.; 33.|] in
    verify_value test_conv2d_back_input [|1;2;3;1|]
      [|2;2;1;1|] [|1;1|] SAME expected

  (* conv2D2x2Kernel *)
  let fun05 () =
    let expected = [|
      14.; 32.; 50.; 100.; 163.; 226.; 167.; 212.; 257.;
      122.; 140.; 158.; 478.; 541.; 604.; 437.; 482.; 527.|] in
    verify_value test_conv2d_back_input [|1;2;3;3|]
      [|2;2;3;3|] [|1;1|] VALID expected

  (* conv2D2x2KernelSame *)
  let fun06 () =
    let expected = [|
      14.; 32.; 50.; 100.; 163.; 226.; 217.; 334.; 451.; 190.;
      307.; 424.; 929.; 1217.; 1505.; 1487.; 1883.; 2279.|] in
    verify_value test_conv2d_back_input [|1;2;3;3|]
      [|2;2;3;3|] [|1;1|] SAME expected

  (* conv2D1x2Kernel *)
  let fun07 () =
    let expected = [|1.; 4.; 4.; 3.; 10.; 8.; 5.; 16.; 12.|] in
    verify_value test_conv2d_back_input [|1;3;3;1|]
      [|1;2;1;1|] [|1;1|] VALID expected

  (* conv2D2x2KernelStride2 *)
  let fun08 () =
    let expected = [|
      1.; 2.; 5.; 4.; 6.; 0.; 0.; 0.; 0.; 0.; 3.; 6.; 13.; 8.; 12.|] in
    verify_value test_conv2d_back_input [|1;3;5;1|]
      [|1;3;1;1|] [|2;2|] VALID expected

  (* conv2D2x2KernelStride2Same *)
  let fun08 () =
    let expected = [|1.; 2.; 2.; 3.; 4.; 6.|] in
    verify_value test_conv2d_back_input [|1;2;3;1|]
      [|2;2;1;1|] [|2;2|] SAME expected

end


(* Test Convolution2D kernel-backward operations *)

module To_test_conv2d_back_kernel = struct

  (* conv2D1x1Kernel *)
  let fun00 () =
    let expected = [|8056.; 8432.; 8312.; 8704.; 8568.; 8976.|] in
    verify_value test_conv2d_back_kernel [|1;4;4;3|]
      [|1;1;3;2|] [|1;1|] VALID expected

  (* conv2D1x2Kernel *)
  let fun01 () =
    let expected = [|120.;141.|] in
    verify_value test_conv2d_back_kernel [|1;3;3;1|]
      [|1;2;1;1|] [|1;1|] VALID expected

  (* conv2D2x2KernelDepth1 *)
  let fun02 () =
    let expected = [|5.;8.;14.;17.|] in
    verify_value test_conv2d_back_kernel [|1;2;3;1|]
      [|2;2;1;1|] [|1;1|] VALID expected

  (* conv2D2x2Kernel *)
  let fun03 () =
    let expected = [|
      17.; 22.; 27.; 22.; 29.; 36.; 27.; 36.; 45.; 32.; 43.; 54.; 37.; 50.; 63.;
      42.; 57.; 72.; 62.; 85.; 108.; 67.; 92.; 117.; 72.; 99.; 126.; 77.; 106.;
      135.; 82.; 113.; 144.; 87.; 120.; 153.|] in
    verify_value test_conv2d_back_kernel [|1;2;3;3|]
      [|2;2;3;3|] [|1;1|] VALID expected

  (* conv2D1x2KernelStride3Width5 *)
  let fun04 () =
    let expected = [|9.;12.|] in
    verify_value test_conv2d_back_kernel [|1;1;5;1|]
      [|1;2;1;1|] [|3;3|] VALID expected

  (* conv2D1x2KernelStride3Width6 *)
  let fun05 () =
    let expected = [|9.;12.|] in
    verify_value test_conv2d_back_kernel [|1;1;6;1|]
      [|1;2;1;1|] [|3;3|] VALID expected

  (* conv2D1x2KernelStride3Width7 *)
  let fun06 () =
    let expected = [|9.;12.|] in
    verify_value test_conv2d_back_kernel [|1;1;7;1|]
      [|1;2;1;1|] [|3;3|] VALID expected

  (* conv2D1x3Kernel *)
  let fun07 () =
    let expected = [|5.; 8.; 11.|] in
    verify_value test_conv2d_back_kernel [|1;1;4;1|]
      [|1;3;1;1|] [|1;1|] VALID expected

  (* conv2D1x3Kernel *)
  let fun08 () =
    let expected = [|5.; 8.; 11.|] in
    verify_value test_conv2d_back_kernel [|1;1;4;1|]
      [|1;3;1;1|] [|1;1|] VALID expected


  (* conv2D1x3KernelSame *)
  let fun09 () =
    let expected = [|20.; 30.; 20.|] in
    verify_value test_conv2d_back_kernel [|1;1;4;1|]
      [|1;3;1;1|] [|1;1|] SAME expected

  (* conv2D1x3KernelSameOutbackprop2 *)
  let fun10 () =
    let expected = [|7.; 10.; 3.|] in
    verify_value test_conv2d_back_kernel [|1;1;4;1|]
      [|1;3;1;1|] [|2;2|] SAME expected

  (* conv2D2x2KernelC1Same *)
  let fun11 () =
    let expected = [|91.; 58.; 32.; 17.|] in
    verify_value test_conv2d_back_kernel [|1;2;3;1|]
      [|2;2;1;1|] [|1;1|] SAME expected

  (* conv2D2x2KernelStride2 *)
  let fun12 () =
    let expected = [|92.; 102.; 112.|] in
    verify_value test_conv2d_back_kernel [|1;3;5;1|]
      [|1;3;1;1|] [|2;2|] VALID expected

  (* conv2D2x2KernelStride2Same *)
  let fun13 () =
    let expected = [|7.; 2.; 16.; 5.|] in
    verify_value test_conv2d_back_kernel [|1;2;3;1|]
      [|2;2;1;1|] [|2;2|] SAME expected

end


(* tests for conv2d forward operation *)

let fun_conv00 () =
  Alcotest.(check bool) "fun_conv00" true (To_test_conv2d.fun00 ())

let fun_conv01 () =
  Alcotest.(check bool) "fun_conv01" true (To_test_conv2d.fun01 ())

let fun_conv02 () =
  Alcotest.(check bool) "fun_conv02" true (To_test_conv2d.fun02 ())

let fun_conv03 () =
  Alcotest.(check bool) "fun_conv03" true (To_test_conv2d.fun03 ())

let fun_conv04 () =
  Alcotest.(check bool) "fun_conv04" true (To_test_conv2d.fun04 ())

(* tests for conv2d input backward operation *)

let fun_cbi00 () =
  Alcotest.(check bool) "fun_conv2d_back_input_00" true
    (To_test_conv2d_back_input.fun00 ())

let fun_cbi01 () =
  Alcotest.(check bool) "fun_conv2d_back_input_01" true
    (To_test_conv2d_back_input.fun01 ())

let fun_cbi02 () =
  Alcotest.(check bool) "fun_conv2d_back_input_02" true
    (To_test_conv2d_back_input.fun01 ())

let fun_cbi03 () =
  Alcotest.(check bool) "fun_conv2d_back_input_03" true
    (To_test_conv2d_back_input.fun03 ())

let fun_cbi04 () =
  Alcotest.(check bool) "fun_conv2d_back_input_04" true
    (To_test_conv2d_back_input.fun04 ())

let fun_cbi05 () =
  Alcotest.(check bool) "fun_conv2d_back_input_05" true
    (To_test_conv2d_back_input.fun05 ())

let fun_cbi06 () =
  Alcotest.(check bool) "fun_conv2d_back_input_06" true
    (To_test_conv2d_back_input.fun06 ())

let fun_cbi07 () =
  Alcotest.(check bool) "fun_conv2d_back_input_07" true
    (To_test_conv2d_back_input.fun07 ())

let fun_cbi08 () =
  Alcotest.(check bool) "fun_conv2d_back_input_08" true
    (To_test_conv2d_back_input.fun08 ())

(* tests for conv2d kernel backward operation *)

let fun_cbk00 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_00" true
    (To_test_conv2d_back_kernel.fun00 ())

let fun_cbk01 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_01" true
    (To_test_conv2d_back_kernel.fun01 ())

let fun_cbk02 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_02" true
    (To_test_conv2d_back_kernel.fun02 ())

let fun_cbk03 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_03" true
    (To_test_conv2d_back_kernel.fun03 ())

let fun_cbk04 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_04" true
    (To_test_conv2d_back_kernel.fun04 ())

let fun_cbk05 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_05" true
    (To_test_conv2d_back_kernel.fun05 ())

let fun_cbk06 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_06" true
    (To_test_conv2d_back_kernel.fun06 ())

let fun_cbk07 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_07" true
    (To_test_conv2d_back_kernel.fun07 ())

let fun_cbk08 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_08" true
    (To_test_conv2d_back_kernel.fun08 ())

let fun_cbk09 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_09" true
    (To_test_conv2d_back_kernel.fun09 ())

let fun_cbk10 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_10" true
    (To_test_conv2d_back_kernel.fun10 ())

let fun_cbk11 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_11" true
    (To_test_conv2d_back_kernel.fun11 ())

let fun_cbk12 () =
  Alcotest.(check bool) "fun_conv2d_back_kernel_11" true
    (To_test_conv2d_back_kernel.fun11 ())


let test_set = [
  "fun_conv00", `Slow, fun_conv00;
  "fun_conv01", `Slow, fun_conv01;
  "fun_conv02", `Slow, fun_conv02;
  "fun_conv03", `Slow, fun_conv03;
  "fun_conv04", `Slow, fun_conv04;
  "fun_cbi00", `Slow, fun_cbi00;
  "fun_cbi01", `Slow, fun_cbi01;
  "fun_cbi02", `Slow, fun_cbi02;
  "fun_cbi03", `Slow, fun_cbi03;
  "fun_cbi04", `Slow, fun_cbi04;
  "fun_cbi05", `Slow, fun_cbi05;
  "fun_cbi06", `Slow, fun_cbi06;
  "fun_cbi07", `Slow, fun_cbi07;
  "fun_cbi08", `Slow, fun_cbi08;
  "fun_cbk00", `Slow, fun_cbk00;
  "fun_cbk01", `Slow, fun_cbk01;
  "fun_cbk02", `Slow, fun_cbk02;
  "fun_cbk03", `Slow, fun_cbk03;
  "fun_cbk04", `Slow, fun_cbk04;
  "fun_cbk05", `Slow, fun_cbk05;
  "fun_cbk06", `Slow, fun_cbk06;
  "fun_cbk07", `Slow, fun_cbk07;
  "fun_cbk08", `Slow, fun_cbk08;
  "fun_cbk09", `Slow, fun_cbk09;
  "fun_cbk10", `Slow, fun_cbk10;
  "fun_cbk11", `Slow, fun_cbk11;
  "fun_cbk12", `Slow, fun_cbk12;
]
