(** Unit test for UpSampling operations *)

open Owl_types


(** Functor to generate test module *)

module Make
  (N : Ndarray_Algodiff with type elt = float)
  = struct


  (* Functions used in tests *)

  let tolerance_f64 = 1e-8
  let tolerance_f32 = 5e-4

  let close a b =
    N.(sub a b |> abs |> sum') < tolerance_f32

  let test_upsampling2d_forward input_shape size =
    let inp  = N.sequential input_shape in
    let outp = N.upsampling2d inp size in
    let expected = N.repeat inp [|1; size.(0); size.(1); 1|] in
    close outp expected

  let test_upsampling2d_backward input_shape size =
    let inp = N.ones input_shape in
    let outp = N.upsampling2d inp size in
    let out_shp = N.shape outp in
    let outp' = N.sequential out_shp in
    N.upsampling2d_backward inp size outp'

  let verify_value input_shape size expected =
    let a = test_upsampling2d_backward input_shape size in
    let output_shape' = N.shape a in
    assert (output_shape' = input_shape);
    let b = N.of_array expected input_shape in
    close a b


  (* Test Upsampling2D forward operations *)

  module To_test_upsampling2d = struct

    let fun00 () = test_upsampling2d_forward [|1; 8; 7; 1|] [|2; 2|]

    let fun01 () = test_upsampling2d_forward [|1; 8; 7; 1|] [|2; 3|]

    let fun02 () = test_upsampling2d_forward [|4; 8; 7; 3|] [|3; 2|]

    let fun03 () = test_upsampling2d_forward [|4; 8; 7; 3|] [|1; 1|]

    let fun04 () =
      let expected = [|
        18.; 26.; 34.; 42.; 82.; 90.; 98.; 106.; 146.; 154.; 162.; 170.|]
      in
      verify_value [|1; 3; 4; 1|] [|2; 2|] expected

    let fun05 () =
      let expected = [|
        56.0; 60.0; 64.0; 68.0; 88.0; 92.0; 96.0; 100.0; 120.0; 124.0; 128.0;
        132.0; 248.0; 252.0; 256.0; 260.0; 280.0; 284.0; 288.0; 292.0; 312.0;
        316.0; 320.0; 324.0|]
      in
      verify_value [|1; 2; 3; 4|] [|2; 2|] expected

    let fun06 () =
      let expected = [|
        156.0; 162.0; 168.0; 174.0; 204.0; 210.0; 216.0; 222.0; 252.0; 258.0;
        264.0; 270.0; 588.0; 594.0; 600.0; 606.0; 636.0; 642.0; 648.0; 654.0;
        684.0; 690.0; 696.0; 702.0|]
      in
      verify_value [|1; 2; 3; 4|] [|3; 2|] expected

    let fun07 () =
      let expected = [|
        66.0; 72.0; 102.0; 108.0; 138.0; 144.0; 282.0; 288.0; 318.0; 324.0;
        354.0; 360.0; 498.0; 504.0; 534.0; 540.0; 570.0; 576.0; 714.0; 720.0;
        750.0; 756.0; 786.0; 792.0; 930.0; 936.0; 966.0; 972.0; 1002.0; 1008.0;
        1146.0; 1152.0; 1182.0; 1188.0; 1218.0; 1224.0|]
      in
      verify_value [|3; 2; 3; 2|] [|2;3|] expected

    let fun08 () =
      let expected = [|
        0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.; 15.;
        16.; 17.; 18.; 19.; 20.; 21.; 22.; 23.; 24.; 25.; 26.; 27.; 28.; 29.|]
      in
      verify_value [|1; 5; 6; 1|] [|1; 1|] expected

  end


  (* tests for upsampling2d operations *)

  let fun_us2d00 () =
    Alcotest.(check bool) "fun_us2d00" true (To_test_upsampling2d.fun00 ())

  let fun_us2d01 () =
    Alcotest.(check bool) "fun_us2d01" true (To_test_upsampling2d.fun01 ())

  let fun_us2d02 () =
    Alcotest.(check bool) "fun_us2d02" true (To_test_upsampling2d.fun02 ())

  let fun_us2d03 () =
    Alcotest.(check bool) "fun_us2d03" true (To_test_upsampling2d.fun03 ())

  let fun_us2d04 () =
    Alcotest.(check bool) "fun_us2d04" true (To_test_upsampling2d.fun04 ())

  let fun_us2d05 () =
    Alcotest.(check bool) "fun_us2d05" true (To_test_upsampling2d.fun05 ())

  let fun_us2d06 () =
    Alcotest.(check bool) "fun_us2d06" true (To_test_upsampling2d.fun06 ())

  let fun_us2d07 () =
    Alcotest.(check bool) "fun_us2d07" true (To_test_upsampling2d.fun07 ())

  let fun_us2d08 () =
    Alcotest.(check bool) "fun_us2d08" true (To_test_upsampling2d.fun08 ())


  let test_set = [
    "fun_us2d00", `Slow, fun_us2d00;
    "fun_us2d01", `Slow, fun_us2d01;
    "fun_us2d02", `Slow, fun_us2d02;
    "fun_us2d03", `Slow, fun_us2d03;
    "fun_us2d04", `Slow, fun_us2d04;
    "fun_us2d05", `Slow, fun_us2d05;
    "fun_us2d06", `Slow, fun_us2d06;
    "fun_us2d07", `Slow, fun_us2d07;
    "fun_us2d08", `Slow, fun_us2d08;
  ]


end
