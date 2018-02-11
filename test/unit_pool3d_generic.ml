(** Unit test for Pooling3D operations *)

open Owl_types


(** Functor to generate test module *)

module Make (N : Ndarray_Algodiff) = struct


  (* Functions used in tests *)

  let tolerance_f64 = 1e-8
  let tolerance_f32 = 5e-4
  let close a b =
    N.(sub a b |> abs |> sum') < tolerance_f32

  let test_maxpool3d input_shape kernel stride pad =
    let inp = N.sequential ~a:1. input_shape in
    N.max_pool3d ~padding:pad inp kernel stride

  let test_avgpool3d input_shape kernel stride pad =
    let inp = N.sequential ~a:1. input_shape in
    N.avg_pool3d ~padding:pad inp kernel stride

  let test_maxpool3d_back input_shape kernel stride pad =
    let input = N.sequential ~a:1. input_shape in
    let output = N.max_pool3d ~padding:pad input kernel stride in
    let output_shape = N.shape output in
    let output' = N.sequential ~a:1. output_shape in
    N.max_pool3d_backward pad input kernel stride output'

  let test_avgpool3d_back input_shape kernel stride pad =
    let input = N.sequential ~a:1. input_shape in
    let output = N.avg_pool3d ~padding:pad input kernel stride in
    let output_shape = N.shape output in
    let output' = N.sequential ~a:1. output_shape in
    N.avg_pool3d_backward pad input kernel stride output'

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


  (* Test MaxPooling3D backward operations *)
  module To_test_maxpool3d_back = struct

    (* testMaxPoolGradValidPadding1_1_3d *)
    let fun00 () =
      let expected = [|
        1. ;  2.;  3.;  4.;  5.;  6.;  7.;  8.;  9.; 10.; 11.;
        12.; 13.; 14.; 15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.;
        23.; 24.; 25.; 26.;  27.|] in
      verify_value test_maxpool3d_back [|1;3;3;3;1|]
        [|1;1;1|] [|1;1;1|] VALID expected

    (* testMaxPoolGradValidPadding2_1_6 *)
    let fun01 () =
      let expected = [|
        0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.;
        0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 1.; 2.; 3.; 4.; 5.;
        0.; 6.; 7.; 8.; 9.;10.; 0.; 0.; 0.; 0.; 0.; 0.; 0.;11.;12.;
        13.; 14.; 15.; 0.; 16.; 17.; 18.; 19.; 20.|] in
      verify_value test_maxpool3d_back [|1;3;3;6;1|]
        [|2;2;2|] [|1;1;1|] VALID expected

    (* testMaxPoolGradValidPadding2_1_7 *)
    let fun02 () =
      let expected = [|
        0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;
        0.; 0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;
        0.;  0.; 0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;  0.;
        0.;  1.;  2.; 3.;  4.;  5.;  6.;  0.;  7.;  8.;  9.; 10.; 11.; 12.;
        0.; 13.; 14.; 15.; 16.; 17.; 18.;  0.; 19.; 20.; 21.; 22.; 23.; 24.;
        0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 25.; 26.; 27.; 28.; 29.; 30.;  0.; 31.;
        32.; 33.; 34.; 35.; 36.; 0.; 37.; 38.; 39.; 40.; 41.; 42.; 0.; 43.;
        44.; 45.; 46.; 47.; 48.|]
      in
      verify_value test_maxpool3d_back [|1;3;5;7;1|]
        [|2;2;2|] [|1;1;1|] VALID expected

    (* testMaxPoolGradValidPadding2_2 *)
    let fun03 () =
      let expected = [|
        0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 1.; 2.|] in
      verify_value test_maxpool3d_back [|1;2;2;2;2|]
        [|2;2;2|] [|2;2;2|] VALID expected

    (* testMaxPoolGradSamePadding1_1 *)
    let fun04 () =
      let expected = [|
        1. ;  2.;  3.;  4.;  5.;  6.;  7.;  8.;  9.; 10.; 11.; 12.;
        13.; 14.; 15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.; 23.; 24.|] in
      verify_value test_maxpool3d_back [|1;3;2;4;1|]
        [|1;1;1|] [|1;1;1|] SAME expected

    (* testMaxPoolGradSamePadding2_1 *)
    let fun05 () =
      let expected = [|
        0.; 0.; 0.;  0.; 0.; 0.; 0.; 0.; 0.;  0.;  0.;   0.;
        0.; 6.; 8.; 22.; 0.; 0.; 0.; 0.; 0.; 60.; 64.; 140.|] in
      verify_value test_maxpool3d_back [|1;3;2;4;1|]
        [|2;2;2|] [|1;1;1|] SAME expected

    (* testMaxPoolGradSamePadding2_2 *)
    let fun06 () =
      let expected = [|
        0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 1.; 0.; 2.; 0.; 0.;
        0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 3.; 0.; 4.; 0.; 0.; 0.; 0.;
        0.; 5.; 0.; 6.|] in
      verify_value test_maxpool3d_back [|1;5;2;4;1|]
        [|2;2;2|] [|2;2;2|] SAME expected

    (* testMaxPoolGradSamePadding3_1 *)
    let fun07 () =
      let expected = [|
        0.;  0.;  0.;  0.;  0.;  0.;  0.;   0.; 0.;   0.;   0.;    0.;
        0.;  0.;  0.;  0.;  0.;  0.;  0.;   0.; 0.;   0.;   0.;    0.;
        0.;  0.;  0.;  0.;  0.;  1.;  2.;   3.; 4.;   5.;  13.;    0.;
       23.; 25.; 27.; 29.; 31.; 68.;  0.;   0.; 0.;   0.;   0.;    0.;
        0.;  0.; 65.; 67.; 69.; 71.; 73.; 152.; 0.; 172.; 176.;  180.;
        184.; 188.; 388.|] in
      verify_value test_maxpool3d_back [|1;3;3;7;1|]
        [|3;3;3|] [|1;1;1|] SAME expected

  end


  (* Test AvgPooling3D backward operations *)
  module To_test_avgpool3d_back = struct

    (* testAvgPoolGradValidPadding1_1 *)
    let fun00 () =
      let expected = [|
        1. ;  2.;  3.;  4.;  5.;  6.;  7.;  8.;  9.; 10.; 11.;
        12.; 13.; 14.; 15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.;
        23.; 24.; 25.; 26.;  27.|] in
      verify_value test_avgpool3d_back [|1;3;3;3;1|]
        [|1;1;1|] [|1;1;1|] VALID expected

    (* testAvgPoolGradValidPadding2_1 *)
    let fun01 () =
      let expected = [|
        0.125; 0.375; 0.25 ; 0.5  ; 1.25 ; 0.75 ; 0.375; 0.875; 0.5  ; 0.75;
        1.75;  1.   ; 2.   ; 4.5  ; 2.5  ; 1.25 ;  2.75; 1.5  ; 0.625; 1.375; 0.75;  1.5  ; 3.25 ; 1.75 ; 0.875; 1.875; 1.|] in
      verify_value test_avgpool3d_back [|1;3;3;3;1|]
        [|2;2;2|] [|1;1;1|] VALID expected

    (* testAvgPoolGradValidPadding2_2 *)
    let fun02 () =
      let expected = [|
        0.125; 0.25; 0.125; 0.25; 0.125; 0.25; 0.125; 0.25;
        0.125; 0.25; 0.125; 0.25; 0.125; 0.25; 0.125; 0.25|] in
      verify_value test_avgpool3d_back [|1;2;2;2;2|]
        [|2;2;2|] [|2;2;2|] VALID expected

    (* testAvgPoolGradSamePadding1_1 *)
    let fun03 () =
      let expected = [|
         1.;  2.;  3.;  4.;  5.;  6.;  7.;  8.;  9.; 10.; 11.; 12.;
         13.; 14.; 15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.; 23.; 24.|] in
      verify_value test_avgpool3d_back [|1;3;2;4;1|]
        [|1;1;1|] [|1;1;1|] SAME expected

    (* testAvgPoolGradSamePadding2_1 *)
    let fun04 () =
      let expected = [|
        0.125; 0.625; 0.875; 3.375; 1.375; 4.875; 5.625; 19.125 |] in
      verify_value test_avgpool3d_back [|1;2;2;2;1|]
        [|2;2;2|] [|1;1;1|] SAME expected

    (* testAvgPoolGradSamePadding2_2 *)
    let fun05 () =
      let expected = [|
        0.125; 0.125; 0.25 ; 0.25 ; 0.125; 0.125; 0.25 ; 0.25 ; 0.125; 0.125;
        0.25 ; 0.25 ; 0.125; 0.125; 0.25 ; 0.25 ; 0.375; 0.375; 0.5  ; 0.5  ;
        0.375; 0.375; 0.5  ; 0.5  ; 0.375; 0.375; 0.5  ; 0.5  ; 0.375; 0.375;
        0.5  ;  0.5 ; 1.25 ; 1.25 ; 1.5  ; 1.5  ; 1.25 ; 1.25 ; 1.5  ; 1.5 |] in
      verify_value test_avgpool3d_back [|1;5;2;4;1|]
        [|2;2;2|] [|2;2;2|] SAME expected

    (* testAvgPoolGradSamePadding3_1 *)
    let fun06 () =
      let expected = [|
         7.29166651; 10.57870388;  9.86111164; 10.55555534;  11.25; 14.05092716;
        10.30092621; 15.55555439; 22.37036705; 20.44444466;  21.55555725;
        22.66666603; 27.92592621; 20.37037277; 12.15277767;  17.38426018;
        15.69444466; 16.38888931; 17.08333397; 20.85648346;  15.16203785;
        23.33333397; 33.25925827; 29.77777863; 30.8888855 ;  31.99999809;
        38.81481552; 28.14814758; 43.55555344; 61.92592621;  55.11110687;
        56.88888931; 58.66666794; 70.81481934; 51.25925827;  31.11111259;
        44.1481514 ; 39.11111069; 40.22221756; 41.33333969;  49.70370483;
        35.92592621; 21.875     ; 30.99537086; 27.36111259;  28.05555534;
        28.75000191; 34.46759415; 24.88425827; 38.88888931;  55.0370369 ;
        48.44444275; 49.55554962; 50.66666794; 60.59259033;  43.70370483;
        26.73611259; 37.80093002; 33.19444275; 33.88888931;  34.58333588;
        41.27314758; 29.74537086|] in
      verify_value test_avgpool3d_back [|1;3;3;7;1|]
        [|3;3;3|] [|1;1;1|] SAME expected

  end


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

  (* tests for backward 3D maxpooling operations *)

  let fun_max3d_back00 () =
    Alcotest.(check bool) "fun_max3d_back00" true
      (To_test_maxpool3d_back.fun00 ())

  let fun_max3d_back01 () =
    Alcotest.(check bool) "fun_max3d_back01" true
      (To_test_maxpool3d_back.fun01 ())

  let fun_max3d_back02 () =
    Alcotest.(check bool) "fun_max3d_back02" true
      (To_test_maxpool3d_back.fun02 ())

  let fun_max3d_back03 () =
    Alcotest.(check bool) "fun_max3d_back03" true
      (To_test_maxpool3d_back.fun03 ())

  let fun_max3d_back04 () =
    Alcotest.(check bool) "fun_max3d_back04" true
      (To_test_maxpool3d_back.fun04 ())

  let fun_max3d_back05 () =
    Alcotest.(check bool) "fun_max3d_back05" true
      (To_test_maxpool3d_back.fun05 ())

  let fun_max3d_back06 () =
    Alcotest.(check bool) "fun_max3d_back06" true
      (To_test_maxpool3d_back.fun06 ())

  let fun_max3d_back07 () =
    Alcotest.(check bool) "fun_max3d_back07" true
      (To_test_maxpool3d_back.fun07 ())

  (* tests for backward 2D avgpooling operations *)

  let fun_avg3d_back00 () =
    Alcotest.(check bool) "fun_avg3d_back00" true
      (To_test_avgpool3d_back.fun00 ())

  let fun_avg3d_back01 () =
    Alcotest.(check bool) "fun_avg3d_back01" true
      (To_test_avgpool3d_back.fun01 ())

  let fun_avg3d_back02 () =
    Alcotest.(check bool) "fun_avg3d_back02" true
      (To_test_avgpool3d_back.fun02 ())

  let fun_avg3d_back03 () =
    Alcotest.(check bool) "fun_avg3d_back03" true
      (To_test_avgpool3d_back.fun03 ())

  let fun_avg3d_back04 () =
    Alcotest.(check bool) "fun_avg3d_back04" true
      (To_test_avgpool3d_back.fun04 ())

  let fun_avg3d_back05 () =
    Alcotest.(check bool) "fun_avg3d_back05" true
      (To_test_avgpool3d_back.fun05 ())

  let fun_avg3d_back06 () =
    Alcotest.(check bool) "fun_avg3d_back06" true
      (To_test_avgpool3d_back.fun06 ())


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
    "fun_max3d_back00", `Slow, fun_max3d_back00;
    "fun_max3d_back01", `Slow, fun_max3d_back01;
    "fun_max3d_back02", `Slow, fun_max3d_back02;
    "fun_max3d_back03", `Slow, fun_max3d_back03;
    "fun_max3d_back04", `Slow, fun_max3d_back04;
    "fun_max3d_back05", `Slow, fun_max3d_back05;
    "fun_max3d_back06", `Slow, fun_max3d_back06;
    "fun_max3d_back07", `Slow, fun_max3d_back07;
    "fun_avg3d_back00", `Slow, fun_avg3d_back00;
    "fun_avg3d_back01", `Slow, fun_avg3d_back01;
    "fun_avg3d_back02", `Slow, fun_avg3d_back02;
    "fun_avg3d_back03", `Slow, fun_avg3d_back03;
    "fun_avg3d_back04", `Slow, fun_avg3d_back04;
    "fun_avg3d_back05", `Slow, fun_avg3d_back05;
    "fun_avg3d_back06", `Slow, fun_avg3d_back06;
  ]


end
