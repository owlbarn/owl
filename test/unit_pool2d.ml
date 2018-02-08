(** Unit test for Pooling2D operations *)

open Owl

module N = Dense.Ndarray.S


(* Functions used in tests *)

let tolerance_f64 = 1e-8
let tolerance_f32 = 5e-4

let close a b =
  N.(a - b |> abs |> sum') < tolerance_f32

let test_maxpool2d input_shape kernel stride pad =
  let inp = N.sequential ~a:1. input_shape in
  N.max_pool2d ~padding:pad inp kernel stride

let test_avgpool2d input_shape kernel stride pad =
  let inp = N.sequential ~a:1. input_shape in
  N.avg_pool2d ~padding:pad inp kernel stride

let test_maxpool2d_back input_shape kernel stride pad =
  let input = N.sequential ~a:1. input_shape in
  let output = N.max_pool2d ~padding:pad input kernel stride in
  let output_shape = N.shape output in
  let output' = N.sequential ~a:1. output_shape in
  N.max_pool2d_backward pad input kernel stride output'

let test_avgpool2d_back input_shape kernel stride pad =
  let input = N.sequential ~a:1. input_shape in
  let output = N.avg_pool2d ~padding:pad input kernel stride in
  let output_shape = N.shape output in
  let output' = N.sequential ~a:1. output_shape in
  N.avg_pool2d_backward pad input kernel stride output'

let verify_value fn input_shape kernel stride pad expected =
  let a = fn input_shape kernel stride pad in
  let output_shape = N.shape a in
  let b = N.of_array expected output_shape in
  close a b


(* Test AvgPooling2D and MaxPooling2D forward operations *)

module To_test_forward = struct

  (* testMaxPoolValidPadding *)
  let fun00 () =
    let expected = [|13.;14.;15.|] in
    verify_value test_maxpool2d [|1;3;3;3|] [|2;2|] [|2;2|] VALID expected

  (* testMaxPoolSamePadding *)
  let fun01 () =
    let expected = [|13.;14.;15.;16.;17.;18.|] in
    verify_value test_maxpool2d [|1;2;3;3|] [|2;2|] [|2;2|] SAME expected

  (* testMaxPoolSamePaddingNonSquareWindow *)
  let fun02 () =
    let expected = [|2.;2.;4.;4.|] in
    verify_value test_maxpool2d [|1;2;2;1|] [|1;2|] [|1;1|] SAME expected

  (* testMaxPoolValidPaddingUnevenStride1 *)
  let fun03 () =
    let expected = [|6.;8.;10.;12.;14.;16.|] in
    verify_value test_maxpool2d [|1;4;4;1|] [|2;2|] [|1;2|] VALID expected

  (* testMaxPoolValidPaddingUnevenStride2 *)
  let fun04 () =
    let expected = [|6.;7.;8.;14.;15.;16.|] in
    verify_value test_maxpool2d [|1;4;4;1|] [|2;2|] [|2;1|] VALID expected

  (* testMaxPoolSamePaddingKernel4 *)
  let fun05 () =
    let expected = [|
      21.; 22.; 23.; 24.; 29.; 30.; 31.; 32.;
      53.; 54.; 55.; 56.; 61.; 62.; 63.; 64.|] in
    verify_value test_maxpool2d [|1;4;4;4|] [|2;2|] [|2;2|] SAME expected

  (* testMaxPoolSamePaddingKernel8 *)
  let fun06 () =
    let expected = [|
      145.; 146.; 147.; 148.; 149.; 150.; 151.; 152.; 161.; 162.;
      163.; 164.; 165.; 166.; 167.; 168.; 177.; 178.; 179.; 180.;
      181.; 182.; 183.; 184.; 185.; 186.; 187.; 188.; 189.; 190.;
      191.; 192.; 273.; 274.; 275.; 276.; 277.; 278.; 279.; 280.;
      289.; 290.; 291.; 292.; 293.; 294.; 295.; 296.; 305.; 306.;
      307.; 308.; 309.; 310.; 311.; 312.; 313.; 314.; 315.; 316.;
      317.; 318.; 319.; 320.; 401.; 402.; 403.; 404.; 405.; 406.;
      407.; 408.; 417.; 418.; 419.; 420.; 421.; 422.; 423.; 424.;
      433.; 434.; 435.; 436.; 437.; 438.; 439.; 440.; 441.; 442.;
      443.; 444.; 445.; 446.; 447.; 448.; 465.; 466.; 467.; 468.;
      469.; 470.; 471.; 472.; 481.; 482.; 483.; 484.; 485.; 486.;
      487.; 488.; 497.; 498.; 499.; 500.; 501.; 502.; 503.; 504.;
      505.; 506.; 507.; 508.; 509.; 510.; 511.; 512.|]
    in
    verify_value test_maxpool2d [|1;8;8;8|] [|3;3|] [|2;2|] SAME expected

  (* testKernelSmallerThanStrideValid *)
  let fun07 () =
    let expected = [|9.;12.;30.;33.|] in
    verify_value test_maxpool2d [|1;7;7;1|] [|2;2|] [|3;3|] VALID expected

  (* testKernelSmallerThanStrideSame1 *)
  let fun08 () =
    let expected = [|1.;3.;7.;9.|] in
    verify_value test_maxpool2d [|1;3;3;1|] [|1;1|] [|2;2|] SAME expected

  (* testKernelSmallerThanStrideSame2 *)
  let fun09 () =
    let expected = [|1.;3.;9.;11.|] in
    verify_value test_maxpool2d [|1;4;4;1|] [|1;1|] [|2;2|] SAME expected

  (* testAvgPoolValidPadding *)
  let fun10 () =
    let expected = [|7.;8.;9.|] in
    verify_value test_avgpool2d [|1;3;3;3|] [|2;2|] [|2;2|] VALID expected

  (* testAvgPoolSamePadding *)
  let fun11 () =
    let expected = [|7.;8.;9.;11.5;12.5;13.5|] in
    verify_value test_avgpool2d [|1;2;3;3|] [|2;2|] [|2;2|] SAME expected

end


(* Test MaxPooling2D backward operations *)
module To_test_maxpool2d_back = struct

  (* VALID Padding *)
  let fun00 () =
    let expected = [|
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.;
      0.; 0.; 0.; 1.; 2.; 3.; 0.; 0.; 0.;
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.|] in
    verify_value test_maxpool2d_back [|1;3;3;3|] [|2;2|] [|2;2|] VALID expected

  (* SAME Padding *)
  let fun01 () =
    let expected = [|
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.;
      0.; 0.; 0.; 1.; 2.; 3.; 4.; 5.; 6.|] in
    verify_value test_maxpool2d_back [|1;2;3;3|] [|2;2|] [|2;2|] SAME expected

  (* SAME padding, non square window *)
  let fun02 () =
    let expected = [|0.; 3.; 0.; 7.|] in
    verify_value test_maxpool2d_back [|1;2;2;1|] [|1;2|] [|1;1|] SAME expected

  (* VALID padding, uneven stride 1*)
  let fun03 () =
    let expected = [|
      0.; 0.; 0.; 0.; 0.; 1.; 0.; 2.;
      0.; 3.; 0.; 4.; 0.; 5.; 0.; 6.|] in
    verify_value test_maxpool2d_back [|1;4;4;1|] [|2;2|] [|1;2|] VALID expected

  (* VALID padding, uneven stride 2*)
  let fun04 () =
    let expected = [|
      0.; 0.; 0.; 0.; 0.; 1.; 2.; 3.;
      0.; 0.; 0.; 0.; 0.; 4.; 5.; 6.|] in
    verify_value test_maxpool2d_back [|1;4;4;1|] [|2;2|] [|2;1|] VALID expected

  (* SAME padding, size 4 input *)
  let fun05 () =
    let expected = [|
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.;
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 1.; 2.;
      3.; 4.; 0.; 0.; 0.; 0.; 5.; 6.; 7.; 8.; 0.;
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.;
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 9.; 10.; 11.;
      12.; 0.; 0.; 0.; 0.; 13.; 14.; 15.; 16. |] in
    verify_value test_maxpool2d_back [|1;4;4;4|] [|2;2|] [|2;2|] SAME expected
end


(* Test AvgPooling2D backward operations *)
module To_test_avgpool2d_back = struct

  (* VALID padding *)
  let fun00 () =
    let expected = [|
      0.25; 0.5 ; 0.75; 0.25; 0.5 ; 0.75; 0.; 0.; 0.;
      0.25; 0.5 ; 0.75; 0.25; 0.5 ; 0.75; 0.; 0.; 0.;
      0.  ; 0.  ; 0.  ; 0.  ; 0.  ; 0.  ; 0.; 0.; 0.|] in
    verify_value test_avgpool2d_back [|1;3;3;3|] [|2;2|] [|2;2|] VALID expected

  (* SAME padding *)
  let fun01 () =
    let expected = [|
      0.25; 0.5; 0.75; 0.25; 0.5; 0.75; 2.; 2.5; 3.;
      0.25; 0.5; 0.75; 0.25; 0.5; 0.75; 2.; 2.5; 3.|] in
    verify_value test_avgpool2d_back [|1;2;3;3|] [|2;2|] [|2;2|] SAME expected

  (* SAME padding, non square window *)
  let fun02 () =
    let expected = [|0.5; 2.5; 1.5; 5.5|] in
    verify_value test_avgpool2d_back [|1;2;2;1|] [|1;2|] [|1;1|] SAME expected

  (* VALID padding, uneven stride 1*)
  let fun03 () =
    let expected = [|
      0.25; 0.25; 0.5; 0.5; 1.  ; 1.  ; 1.5; 1.5;
      2.  ; 2.  ; 2.5; 2.5; 1.25; 1.25; 1.5; 1.5|] in
    verify_value test_avgpool2d_back [|1;4;4;1|] [|2;2|] [|1;2|] VALID expected

  (* VALID padding, uneven stride 2*)
  let fun04 () =
    let expected = [|
      0.25; 0.75; 1.25; 0.75; 0.25; 0.75; 1.25; 0.75;
      1.  ; 2.25; 2.75; 1.5 ; 1.  ; 2.25; 2.75; 1.5 |] in
    verify_value test_avgpool2d_back [|1;4;4;1|] [|2;2|] [|2;1|] VALID expected

  (* SAME padding, size 4 input *)
  let fun05 () =
    let expected = [|
      0.25; 0.5 ; 0.75; 1.  ; 0.25; 0.5 ; 0.75; 1.  ; 1.25;
      1.5 ; 1.75; 2.  ; 1.25; 1.5 ; 1.75; 2.  ; 0.25; 0.5 ;
      0.75; 1.  ; 0.25; 0.5 ; 0.75; 1.  ; 1.25; 1.5 ; 1.75;
      2.  ; 1.25; 1.5 ; 1.75; 2.  ; 2.25; 2.5 ; 2.75; 3.  ;
      2.25; 2.5 ; 2.75; 3.  ; 3.25; 3.5 ; 3.75; 4.  ; 3.25;
      3.5 ; 3.75; 4.  ; 2.25; 2.5 ; 2.75; 3.  ; 2.25; 2.5 ;
      2.75; 3.  ; 3.25; 3.5 ; 3.75; 4.  ; 3.25; 3.5 ; 3.75; 4.|] in
    verify_value test_avgpool2d_back [|1;4;4;4|] [|2;2|] [|2;2|] SAME expected

end


(* tests for forward 2D pooling operations *)

let fun_forward00 () =
  Alcotest.(check bool) "fun_forward00" true (To_test_forward.fun00 ())

let fun_forward01 () =
  Alcotest.(check bool) "fun_forward01" true (To_test_forward.fun01 ())

let fun_forward02 () =
  Alcotest.(check bool) "fun_forward02" true (To_test_forward.fun02 ())

let fun_forward03 () =
  Alcotest.(check bool) "fun_forward03" true (To_test_forward.fun03 ())

let fun_forward04 () =
  Alcotest.(check bool) "fun_forward04" true (To_test_forward.fun04 ())

let fun_forward05 () =
  Alcotest.(check bool) "fun_forward05" true (To_test_forward.fun05 ())

let fun_forward06 () =
  Alcotest.(check bool) "fun_forward06" true (To_test_forward.fun06 ())

let fun_forward07 () =
  Alcotest.(check bool) "fun_forward07" true (To_test_forward.fun07 ())

let fun_forward08 () =
  Alcotest.(check bool) "fun_forward08" true (To_test_forward.fun08 ())

let fun_forward09 () =
  Alcotest.(check bool) "fun_forward09" true (To_test_forward.fun09 ())

let fun_forward10 () =
  Alcotest.(check bool) "fun_forward10" true (To_test_forward.fun10 ())

let fun_forward11 () =
  Alcotest.(check bool) "fun_forward11" true (To_test_forward.fun11 ())

(* tests for backward 2D maxpooling operations *)

let fun_max2d_back00 () =
  Alcotest.(check bool) "fun_max2d_back00" true
    (To_test_maxpool2d_back.fun00 ())

let fun_max2d_back01 () =
  Alcotest.(check bool) "fun_max2d_back01" true
    (To_test_maxpool2d_back.fun01 ())

let fun_max2d_back02 () =
  Alcotest.(check bool) "fun_max2d_back02" true
    (To_test_maxpool2d_back.fun02 ())

let fun_max2d_back03 () =
  Alcotest.(check bool) "fun_max2d_back03" true
    (To_test_maxpool2d_back.fun03 ())

let fun_max2d_back04 () =
  Alcotest.(check bool) "fun_max2d_back04" true
    (To_test_maxpool2d_back.fun04 ())

let fun_max2d_back05 () =
  Alcotest.(check bool) "fun_max2d_back05" true
    (To_test_maxpool2d_back.fun05 ())

(* tests for backward 2D avgpooling operations *)

let fun_avg2d_back00 () =
  Alcotest.(check bool) "fun_avg2d_back00" true
    (To_test_avgpool2d_back.fun00 ())

let fun_avg2d_back01 () =
  Alcotest.(check bool) "fun_avg2d_back01" true
    (To_test_avgpool2d_back.fun01 ())

let fun_avg2d_back02 () =
  Alcotest.(check bool) "fun_avg2d_back02" true
    (To_test_avgpool2d_back.fun02 ())

let fun_avg2d_back03 () =
  Alcotest.(check bool) "fun_avg2d_back03" true
    (To_test_avgpool2d_back.fun03 ())

let fun_avg2d_back04 () =
  Alcotest.(check bool) "fun_avg2d_back04" true
    (To_test_avgpool2d_back.fun04 ())

let fun_avg2d_back05 () =
  Alcotest.(check bool) "fun_avg2d_back05" true
    (To_test_avgpool2d_back.fun05 ())


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
  "fun_forward10", `Slow, fun_forward10;
  "fun_forward11", `Slow, fun_forward11;
  "fun_max2d_back00", `Slow, fun_max2d_back00;
  "fun_max2d_back01", `Slow, fun_max2d_back01;
  "fun_max2d_back02", `Slow, fun_max2d_back02;
  "fun_max2d_back03", `Slow, fun_max2d_back03;
  "fun_max2d_back04", `Slow, fun_max2d_back04;
  "fun_max2d_back05", `Slow, fun_max2d_back05;
  "fun_avg2d_back00", `Slow, fun_avg2d_back00;
  "fun_avg2d_back01", `Slow, fun_avg2d_back01;
  "fun_avg2d_back02", `Slow, fun_avg2d_back02;
  "fun_avg2d_back03", `Slow, fun_avg2d_back03;
  "fun_avg2d_back04", `Slow, fun_avg2d_back04;
  "fun_avg2d_back05", `Slow, fun_avg2d_back05;
]
