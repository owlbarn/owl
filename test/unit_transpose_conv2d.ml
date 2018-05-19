(** Unit test for Transpose Convolution2D operations *)

open Owl_types

module N = Owl.Dense.Ndarray.S


(* Functions used in tests *)

let tolerance_f64 = 1e-8
let tolerance_f32 = 5e-4

let close a b =
  N.(sub a b |> abs |> sum') < tolerance_f32

let compute_trans_conv2d seq input_shape kernel_shape stride pad =
  let inp = N.ones input_shape in
  let kernel =
    if seq = false then N.ones kernel_shape
    else N.sequential ~a:1. kernel_shape
  in
  N.transpose_conv2d ~padding:pad inp kernel stride

let compute_trans_conv2d_bi seq input_shape kernel_shape stride pad =
  let inp = N.ones input_shape in
  let kernel =
    if seq = false then N.ones kernel_shape
    else N.sequential ~a:1. kernel_shape
  in
  let output = N.transpose_conv2d ~padding:pad inp kernel stride in
  let os = N.shape output in
  let output' = N.ones os in
  N.transpose_conv2d_backward_input inp kernel stride output'

let compute_trans_conv2d_bk seq input_shape kernel_shape stride pad =
  let inp = N.ones input_shape in
  let kernel = N.ones kernel_shape in
  let output = N.transpose_conv2d ~padding:pad inp kernel stride in
  let os = N.shape output in
  let output' =
    if seq = false then N.ones os
    else N.sequential ~a:1. os
  in
  N.transpose_conv2d_backward_kernel inp kernel stride output'

let verify_value ?(seq=false) fn input_shape kernel_shape stride pad expected =
  let a = fn seq input_shape kernel_shape stride pad in
  let output_shape = N.shape a in
  let b = N.of_array expected output_shape in
  close a b

let test_forward input_shape kernel_shape stride pad magic_num =
  let ph = if pad = SAME then 0 else stride.(0) - 1 in
  let pw = if pad = SAME then 0 else stride.(1) - 1 in

  let result = compute_trans_conv2d false input_shape kernel_shape stride pad in
  let s = N.shape result in
  let expected = N.zeros s in

  for n = 0 to s.(0) - 1 do
    for k = 0 to s.(3) - 1 do
      for w = pw to s.(2) - 1 - pw do
        for h = ph to s.(1) - 1 - ph do
          let t = magic_num.(0) in
          let h_in = (h mod stride.(0) = 0) && (h > ph) && (h < s.(1) - 1 - ph) in
          let w_in = (w mod stride.(1) = 0) && (w > pw) && (w < s.(2) - 1 - pw) in
          let addon =
            if (h_in && w_in) then magic_num.(1) else
            if (h_in || w_in) then magic_num.(2) else 0.
          in
          let t = t +. addon in
          N.set expected [|n;h;w;k|] t;
        done
      done;

      if (pad = VALID) then (
        let foo = N.get_slice [[n]; []; [1]; [k]] expected in
        N.set_slice [[n]; []; [0]; [k]] expected foo;
        let foo = N.get_slice [[n]; []; [-2]; [k]] expected in
        N.set_slice [[n]; []; [-1]; [k]] expected foo;
        let foo = N.get_slice [[n]; [1]; []; [k]] expected in
        N.set_slice [[n]; [0]; []; [k]] expected foo;
        let foo = N.get_slice [[n]; [-2]; []; [k]] expected in
        N.set_slice [[n]; [-1]; []; [k]] expected foo;
      )
    done
  done;

  N.(result = expected)


(* Test Transpose Convolution2D forward operation *)

module To_test_transpose_conv2d = struct

  (* SingleStrideMultichannelSame *)
  let fun00 () =
    test_forward [|1;6;4;3|] [|3;3;3;2|] [|1;1|] SAME [|12.0; 15.0; 6.0|]

  (* TwoStrideSame *)
  let fun01 () =
    test_forward [|1;3;3;1|] [|3;3;1;1|] [|2;2|] SAME [|1.0; 3.0; 1.0|]

  (* SingleStrideSame *)
  let fun02 () =
    test_forward [|1;2;2;1|] [|3;3;1;1|] [|1;1|] SAME  [|4.0; 0.0; 0.0|]

  (* TwoStrideValid *)
  let fun03 () =
    test_forward [|1;6;4;3|] [|3;3;3;1|] [|2;2|] VALID [|3.0; 9.0; 3.0|]

  (* TwoStrideValid *)
  let fun04 () =
    test_forward [|1;2;2;1|] [|3;3;1;1|] [|2;2|] VALID [|1.0; 3.0; 1.0|]

  (* SingleStrideValid *)
  let fun05 () =
    let expected = [|
      1.0; 2.0; 3.0; 2.0; 1.0; 2.0; 4.0; 6.0; 4.0; 2.0; 3.0; 6.0; 9.0;
      6.0; 3.0; 2.0; 4.0; 6.0; 4.0; 2.0; 1.0; 2.0; 3.0; 2.0; 1.0|] in
    verify_value compute_trans_conv2d [|1;3;3;1|] [|3;3;1;1|]
      [|1;1|] VALID expected

  (* DifferentStrideSame *)
  let fun06 () =
    let expected = [|2.; 2.; 4.; 2.; 2.; 2.; 4.; 2.|] in
    verify_value compute_trans_conv2d [|1;2;2;1|] [|3;3;1;1|]
      [|1;2|] SAME expected

  (* SingleKernelSame *)
  let fun07 () =
    let expected = [|1.; 0.; 1.; 0.; 0.; 0.; 0.; 0.|] in
    verify_value compute_trans_conv2d [|1;1;2;1|] [|1;1;1;1|]
      [|2;2|] SAME expected

  (* SequantialKernelSame *)
  let fun08 () =
    let expected = [|
      1.0; 2.0; 4.0; 2.0; 4.0; 5.0; 10.0; 5.0; 8.0;
      10.0; 20.0; 10.0; 4.0; 5.0; 10.0; 5.0 |] in
    verify_value compute_trans_conv2d ~seq:true [|1;2;2;1|] [|3;3;1;1|]
      [|2;2|] SAME expected

end


(* Test Transpose Convolution2D backward operations *)

module To_test_transpose_conv2d_backward = struct

  (* BackwardInputTwoStrideValid *)
  let fun00 () =
    let expected = [|9.; 9.; 9.; 9.|] in
    verify_value compute_trans_conv2d_bi [|1;2;2;1|] [|3;3;1;1|]
      [|2;2|] VALID expected

  (* BackwardInputSingleStrideValid *)
  let fun01 () =
    let expected = [|9.; 9.; 9.; 9.|] in
    verify_value compute_trans_conv2d_bi [|1;2;2;1|] [|3;3;1;1|]
      [|1;1|] VALID expected

  (* BackwardInputTwoStrideSame *)
  let fun02 () =
    let expected = [|9.; 9.; 6.; 9.; 9.; 6.; 6.; 6.; 4.|] in
    verify_value compute_trans_conv2d_bi [|1;3;3;1|] [|3;3;1;1|]
      [|2;2|] SAME expected

  (* BackwardInputSingleStrideSame *)
  let fun03 () =
    let expected = [|
      4.; 6.; 6.; 4.; 6.; 9.; 9.; 6.;
      6.; 9.; 9.; 6.; 4.; 6.; 6.; 4.|] in
    verify_value compute_trans_conv2d_bi [|1;4;4;1|] [|3;3;1;1|]
      [|1;1|] SAME expected

  (* BackwardInputDifferentStrideSame *)
  let fun04 () =
    let expected = [|6.; 6.; 4.; 9.; 9.; 6.; 6.; 6.; 4.|] in
    verify_value compute_trans_conv2d_bi [|1;3;3;1|] [|3;3;1;1|]
      [|1;2|] SAME expected

  (* BackwardInputDifferentKernelSame *)
  let fun05 () =
    let expected = [|3.; 3.; 2.; 3.; 3.; 2.; 3.; 3.; 2.|] in
    verify_value compute_trans_conv2d_bi [|1;3;3;1|] [|1;3;1;1|]
      [|2;2|] SAME expected

  (* BackwardInputSequentialKernelSame *)
  let fun06 () =
    let expected = [|45.; 27.; 21.; 12.|] in
    verify_value compute_trans_conv2d_bi ~seq:true [|1;2;2;1|] [|3;3;1;1|]
      [|2;2|] SAME expected

  (* BackwardInputMultiChannelSame *)
  let fun07 () =
    let expected = [|18.; 18.; 12.; 12.; 12.; 12.; 8.; 8.|] in
    verify_value compute_trans_conv2d_bi [|1;2;2;2|] [|3;3;2;2|]
      [|2;2|] SAME expected

  (* BackwardKernelTwoStrideValid *)
  let fun08 () =
    let expected = [|4.; 4.; 4.; 4.; 4.; 4.; 4.; 4.; 4.|] in
    verify_value compute_trans_conv2d_bk [|1;2;2;1|] [|3;3;1;1|]
      [|2;2|] VALID expected

  (* BackwardKernelSingleStrideValid *)
  let fun09 () =
    let expected = [|4.; 4.; 4.; 4.; 4.; 4.; 4.; 4.; 4.|] in
    verify_value compute_trans_conv2d_bk [|1;2;2;1|] [|3;3;1;1|]
      [|1;1|] VALID expected

  (* BackwardKernelTwoStrideSame *)
  let fun10 () =
    let expected = [|9.; 9.; 6.; 9.; 9.; 6.; 6.; 6.; 4.|] in
    verify_value compute_trans_conv2d_bk [|1;3;3;1|] [|3;3;1;1|]
      [|2;2|] SAME expected

  (* BackwardKernelSingleStrideSame *)
  let fun11 () =
    let expected = [|9.; 12.; 9.; 12.; 16.; 12.; 9.; 12.; 9.|] in
    verify_value compute_trans_conv2d_bk [|1;4;4;1|] [|3;3;1;1|]
      [|1;1|] SAME expected

  (* BackwardKernelDifferentStrideSame *)
  let fun12 () =
    let expected = [|6.; 6.; 4.; 9.; 9.; 6.; 6.; 6.; 4.|] in
    verify_value compute_trans_conv2d_bk [|1;3;3;1|] [|3;3;1;1|]
      [|1;2|] SAME expected

  (* BackwardInputDifferentKernelSame *)
  let fun13 () =
    let expected = [|9.; 9.; 6.|] in
    verify_value compute_trans_conv2d_bk [|1;3;3;1|] [|1;3;1;1|]
      [|2;2|] SAME expected

  (* BackwardInputSequentialOutputValid *)
  let fun14 () =
    let expected = [|24.; 28.; 14.; 40.; 44.; 22.; 20.; 22.; 11.|] in
    verify_value compute_trans_conv2d_bk ~seq:true [|1;2;2;1|] [|3;3;1;1|]
      [|2;2|] SAME expected

  (* BackwardInputMultiChannelSame *)
  let fun15 () =
    let expected = [|
      4.; 4.; 4.; 4.; 4.; 4.; 4.; 4.; 2.; 2.; 2.; 2.; 4.; 4.; 4.; 4.; 4.; 4.;
      4.; 4.; 2.; 2.; 2.; 2.; 2.; 2.; 2.; 2.; 2.; 2.; 2.; 2.; 1.; 1.; 1.; 1.|]
    in
    verify_value compute_trans_conv2d_bk [|1;2;2;2|] [|3;3;2;2|]
      [|2;2|] SAME expected

end


(* tests for conv2d_transpose forward operation *)

let fun_ctf00 () =
  Alcotest.(check bool) "fun_ctf00" true (To_test_transpose_conv2d.fun00 ())

let fun_ctf01 () =
  Alcotest.(check bool) "fun_ctf01" true (To_test_transpose_conv2d.fun01 ())

let fun_ctf02 () =
  Alcotest.(check bool) "fun_ctf02" true (To_test_transpose_conv2d.fun02 ())

let fun_ctf03 () =
  Alcotest.(check bool) "fun_ctf03" true (To_test_transpose_conv2d.fun03 ())

let fun_ctf04 () =
  Alcotest.(check bool) "fun_ctf04" true (To_test_transpose_conv2d.fun04 ())

let fun_ctf05 () =
  Alcotest.(check bool) "fun_ctf05" true (To_test_transpose_conv2d.fun05 ())

let fun_ctf06 () =
  Alcotest.(check bool) "fun_ctf06" true (To_test_transpose_conv2d.fun06 ())

let fun_ctf07 () =
  Alcotest.(check bool) "fun_ctf07" true (To_test_transpose_conv2d.fun07 ())

let fun_ctf08 () =
  Alcotest.(check bool) "fun_ctf08" true (To_test_transpose_conv2d.fun08 ())

(* tests for transpose_conv2d backward operations *)

let fun_ctb00 () =
  Alcotest.(check bool) "fun_ctb00" true
    (To_test_transpose_conv2d_backward.fun00 ())

let fun_ctb01 () =
  Alcotest.(check bool) "fun_ctb01" true
    (To_test_transpose_conv2d_backward.fun01 ())

let fun_ctb02 () =
  Alcotest.(check bool) "fun_ctb02" true
    (To_test_transpose_conv2d_backward.fun02 ())

let fun_ctb03 () =
  Alcotest.(check bool) "fun_ctb03" true
    (To_test_transpose_conv2d_backward.fun03 ())

let fun_ctb04 () =
  Alcotest.(check bool) "fun_ctb04" true
    (To_test_transpose_conv2d_backward.fun04 ())

let fun_ctb05 () =
  Alcotest.(check bool) "fun_ctb05" true
    (To_test_transpose_conv2d_backward.fun05 ())

let fun_ctb06 () =
  Alcotest.(check bool) "fun_ctb06" true
    (To_test_transpose_conv2d_backward.fun06 ())

let fun_ctb07 () =
  Alcotest.(check bool) "fun_ctb07" true
    (To_test_transpose_conv2d_backward.fun07 ())

let fun_ctb08 () =
  Alcotest.(check bool) "fun_ctb08" true
    (To_test_transpose_conv2d_backward.fun08 ())

let fun_ctb09 () =
  Alcotest.(check bool) "fun_ctb09" true
    (To_test_transpose_conv2d_backward.fun09 ())

let fun_ctb10 () =
  Alcotest.(check bool) "fun_ctb10" true
    (To_test_transpose_conv2d_backward.fun10 ())

let fun_ctb11 () =
  Alcotest.(check bool) "fun_ctb11" true
    (To_test_transpose_conv2d_backward.fun11 ())

let fun_ctb12 () =
  Alcotest.(check bool) "fun_ctb12" true
    (To_test_transpose_conv2d_backward.fun12 ())

let fun_ctb13 () =
  Alcotest.(check bool) "fun_ctb13" true
    (To_test_transpose_conv2d_backward.fun13 ())

let fun_ctb14 () =
  Alcotest.(check bool) "fun_ctb14" true
    (To_test_transpose_conv2d_backward.fun14 ())

let fun_ctb15 () =
  Alcotest.(check bool) "fun_ctb15" true
    (To_test_transpose_conv2d_backward.fun15 ())

let test_set = [
  "fun_ctf00", `Slow, fun_ctf00;
  "fun_ctf01", `Slow, fun_ctf01;
  "fun_ctf02", `Slow, fun_ctf02;
  "fun_ctf03", `Slow, fun_ctf03;
  "fun_ctf04", `Slow, fun_ctf04;
  "fun_ctf05", `Slow, fun_ctf05;
  "fun_ctf06", `Slow, fun_ctf06;
  "fun_ctf07", `Slow, fun_ctf07;
  "fun_ctf08", `Slow, fun_ctf08;
  "fun_ctb00", `Slow, fun_ctb00;
  "fun_ctb01", `Slow, fun_ctb01;
  "fun_ctb02", `Slow, fun_ctb02;
  "fun_ctb03", `Slow, fun_ctb03;
  "fun_ctb04", `Slow, fun_ctb04;
  "fun_ctb05", `Slow, fun_ctb05;
  "fun_ctb06", `Slow, fun_ctb06;
  "fun_ctb07", `Slow, fun_ctb07;
  "fun_ctb08", `Slow, fun_ctb08;
  "fun_ctb09", `Slow, fun_ctb09;
  "fun_ctb10", `Slow, fun_ctb10;
  "fun_ctb11", `Slow, fun_ctb11;
  "fun_ctb12", `Slow, fun_ctb12;
  "fun_ctb13", `Slow, fun_ctb13;
  "fun_ctb14", `Slow, fun_ctb14;
  "fun_ctb15", `Slow, fun_ctb15;
]
