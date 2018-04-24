(** Unit test for Convolution3D operations *)

open Owl_types

module N = Owl.Dense.Ndarray.S

(* Functions used in tests *)

let compute_conv2d_trans input_shape kernel_shape stride pad =
  let inp = N.ones input_shape in
  let kernel = N.ones kernel_shape in
  N.conv2d_transpose ~padding:pad inp kernel stride


let test input_shape kernel_shape stride pad magic_num =
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

(* Test Convolution2D Transpose forward operations *)

module To_test_conv2d_transpose = struct

  (* testConv2DTransposeSingleStride *)
  let fun00 () =
    test [|1;6;4;3|] [|3;3;3;2|] [|1;1|] SAME [|12.0; 15.0; 6.0|]

  (* testConv2DTransposeSame *)
  let fun01 () =
    test [|1;3;3;1|] [|3;3;1;1|] [|2;2|] SAME [|1.0; 3.0; 1.0|]

  (* testConv2DTransposeSame2 *)
  let fun02 () =
    test [|1;2;2;1|] [|3;3;1;1|] [|1;1|] SAME  [|4.0; 0.0; 0.0|]

  (* testConv2DTransposeValid1 *)
  let fun03 () =
    test [|1;6;4;3|] [|3;3;3;1|] [|2;2|] VALID [|3.0; 9.0; 3.0|]

  (* testConv2DTransposeValid2 *)
  let fun04 () =
    test [|1;2;2;1|] [|3;3;1;1|] [|2;2|] VALID [|1.0; 3.0; 1.0|]

end


(* tests for conv2d_transpose forward operation *)

let fun_00 () =
  Alcotest.(check bool) "fun_00" true (To_test_conv2d_transpose.fun00 ())

let fun_01 () =
  Alcotest.(check bool) "fun_01" true (To_test_conv2d_transpose.fun01 ())

let fun_02 () =
  Alcotest.(check bool) "fun_02" true (To_test_conv2d_transpose.fun02 ())

let fun_03 () =
  Alcotest.(check bool) "fun_03" true (To_test_conv2d_transpose.fun03 ())

let fun_04 () =
  Alcotest.(check bool) "fun_04" true (To_test_conv2d_transpose.fun04 ())


let test_set = [
  "fun_00", `Slow, fun_00;
  "fun_01", `Slow, fun_01;
  "fun_02", `Slow, fun_02;
  "fun_03", `Slow, fun_03;
  "fun_04", `Slow, fun_04;
]
