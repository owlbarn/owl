(** Unit test for Convolution3D operations *)

open Owl_types

module N = Owl.Dense.Ndarray.S


(* Functions used in tests *)

let tolerance_f64 = 1e-8
let tolerance_f32 = 5e-4

let close a b =
  N.(sub a b |> abs |> sum') < tolerance_f32

let compute_conv2d_trans input_shape kernel_shape stride pad =
  let inp = N.ones input_shape in
  let kernel = N.ones kernel_shape in
  N.conv2d_transpose ~padding:pad inp kernel stride

let compute_conv2d_trans_bi input_shape kernel_shape stride pad =
  let inp = N.ones input_shape in
  let kernel = N.ones kernel_shape in
  let output = N.conv2d_transpose ~padding:pad inp kernel stride in
  let os = N.shape output in
  let output' = N.ones os in
  N.conv2d_transpose_backward_input inp kernel stride output'

let compute_conv2d_trans_bk input_shape kernel_shape stride pad =
  let inp = N.ones input_shape in
  let kernel = N.ones kernel_shape in
  let output = N.conv2d_transpose ~padding:pad inp kernel stride in
  let os = N.shape output in
  let output' = N.ones os in
  N.conv2d_transpose_backward_kernel inp kernel stride output'

let verify_value fn input_shape kernel_shape stride pad expected =
  let a = fn input_shape kernel_shape stride pad in
  let output_shape = N.shape a in
  let b = N.of_array expected output_shape in
  close a b

let test_forward input_shape kernel_shape stride pad magic_num =
  let ph = if pad = SAME then 0 else stride.(0) - 1 in
  let pw = if pad = SAME then 0 else stride.(1) - 1 in

  let result = compute_conv2d_trans input_shape kernel_shape stride pad in
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


(* Test Convolution2D Transpose forward operation *)

module To_test_conv2d_transpose = struct

  (* testConv2DTransposeSingleStride *)
  let fun00 () =
    test_forward [|1;6;4;3|] [|3;3;3;2|] [|1;1|] SAME [|12.0; 15.0; 6.0|]

  (* testConv2DTransposeTwoStride *)
  let fun01 () =
    test_forward [|1;3;3;1|] [|3;3;1;1|] [|2;2|] SAME [|1.0; 3.0; 1.0|]

  (* testConv2DTransposeSame *)
  let fun02 () =
    test_forward [|1;2;2;1|] [|3;3;1;1|] [|1;1|] SAME  [|4.0; 0.0; 0.0|]

  (* testConv2DTransposeValid *)
  let fun03 () =
    test_forward [|1;6;4;3|] [|3;3;3;1|] [|2;2|] VALID [|3.0; 9.0; 3.0|]

  (* testConv2DTransposeValid *)
  let fun04 () =
    test_forward [|1;2;2;1|] [|3;3;1;1|] [|2;2|] VALID [|1.0; 3.0; 1.0|]

end


(* Test Convolution2D Transpose backward operations *)

module To_test_conv2d_transpose_backward = struct

  (* BackwardInputTwoStride *)
  let fun00 () =
    let expected = [|9.; 9.; 9.; 9.|] in
    verify_value compute_conv2d_trans_bi [|1;2;2;1|] [|3;3;1;1|]
      [|2;2|] VALID expected

  (* BackwardInputSingleStride *)
  let fun01 () =
    let expected = [|9.; 9.; 9.; 9.|] in
    verify_value compute_conv2d_trans_bi [|1;2;2;1|] [|3;3;1;1|]
      [|1;1|] VALID expected

  (* BackwardInputTowStrideSame *)
  let fun02 () =
    let expected = [|9.; 9.; 6.; 9.; 9.; 6.; 6.; 6.; 4.|] in
    verify_value compute_conv2d_trans_bi [|1;3;3;1|] [|3;3;1;1|]
      [|2;2|] SAME expected

  (* BackwardInputSingleStrideSame *)
  let fun03 () =
    let expected = [|
      4.; 6.; 6.; 4.; 6.; 9.; 9.; 6.;
      6.; 9.; 9.; 6.; 4.; 6.; 6.; 4.|] in
    verify_value compute_conv2d_trans_bi [|1;4;4;1|] [|3;3;1;1|]
      [|1;1|] SAME expected

  (* BackwardKernelTwoStride *)
  let fun04 () =
    let expected = [|4.; 4.; 4.; 4.; 4.; 4.; 4.; 4.; 4.|] in
    verify_value compute_conv2d_trans_bk [|1;2;2;1|] [|3;3;1;1|]
      [|2;2|] VALID expected

  (* BackwardKernelSingleStride *)
  let fun05 () =
    let expected = [|4.; 4.; 4.; 4.; 4.; 4.; 4.; 4.; 4.|] in
    verify_value compute_conv2d_trans_bk [|1;2;2;1|] [|3;3;1;1|]
      [|1;1|] VALID expected

  (* BackwardKernelTowStrideSame *)
  let fun06 () =
    let expected = [|4.; 6.; 6.; 6.; 9.; 9.; 6.; 9.; 9.|] in
    verify_value compute_conv2d_trans_bk [|1;3;3;1|] [|3;3;1;1|]
      [|2;2|] SAME expected

  (* BackwardKernelSingleStrideSame *)
  let fun07 () =
    let expected = [|9.; 12.; 9.; 12.; 16.; 12.; 9.; 12.; 9.|] in
    verify_value compute_conv2d_trans_bk [|1;4;4;1|] [|3;3;1;1|]
      [|1;1|] SAME expected

end


(* tests for conv2d_transpose forward operation *)

let fun_ctf00 () =
  Alcotest.(check bool) "fun_ctf00" true (To_test_conv2d_transpose.fun00 ())

let fun_ctf01 () =
  Alcotest.(check bool) "fun_ctf01" true (To_test_conv2d_transpose.fun01 ())

let fun_ctf02 () =
  Alcotest.(check bool) "fun_ctf02" true (To_test_conv2d_transpose.fun02 ())

let fun_ctf03 () =
  Alcotest.(check bool) "fun_ctf03" true (To_test_conv2d_transpose.fun03 ())

let fun_ctf04 () =
  Alcotest.(check bool) "fun_ctf04" true (To_test_conv2d_transpose.fun04 ())

(* tests for conv2d_transpose backward operations *)

let fun_ctb00 () =
  Alcotest.(check bool) "fun_ctb00" true
    (To_test_conv2d_transpose_backward.fun00 ())

let fun_ctb01 () =
  Alcotest.(check bool) "fun_ctb01" true
    (To_test_conv2d_transpose_backward.fun01 ())

let fun_ctb02 () =
  Alcotest.(check bool) "fun_ctb02" true
    (To_test_conv2d_transpose_backward.fun02 ())

let fun_ctb03 () =
  Alcotest.(check bool) "fun_ctb03" true
    (To_test_conv2d_transpose_backward.fun03 ())

let fun_ctb04 () =
  Alcotest.(check bool) "fun_ctb04" true
    (To_test_conv2d_transpose_backward.fun04 ())

let fun_ctb05 () =
  Alcotest.(check bool) "fun_ctb05" true
    (To_test_conv2d_transpose_backward.fun05 ())

let fun_ctb06 () =
  Alcotest.(check bool) "fun_ctb06" true
    (To_test_conv2d_transpose_backward.fun06 ())

let fun_ctb07 () =
  Alcotest.(check bool) "fun_ctb07" true
    (To_test_conv2d_transpose_backward.fun07 ())


let test_set = [
  "fun_ctf00", `Slow, fun_ctf00;
  "fun_ctf01", `Slow, fun_ctf01;
  "fun_ctf02", `Slow, fun_ctf02;
  "fun_ctf03", `Slow, fun_ctf03;
  "fun_ctf04", `Slow, fun_ctf04;

  "fun_ctb00", `Slow, fun_ctb00;
  "fun_ctb01", `Slow, fun_ctb01;
  "fun_ctb02", `Slow, fun_ctb02;
  "fun_ctb03", `Slow, fun_ctb03;
  "fun_ctb04", `Slow, fun_ctb04;
  "fun_ctb05", `Slow, fun_ctb05;
  "fun_ctb06", `Slow, fun_ctb06;
  "fun_ctb07", `Slow, fun_ctb07;
]
