(** Unit test for functions in ndarray core *)

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

  let test ?(seq=false) ?(a=true) expected shape axis =
    let input = if seq = false then
      N.ones shape
    else
      N.sequential shape
    in
    let output = if a = true then
      N.sum_reduce ~axis input
    else
      N.sum_reduce input
    in
    let out_shp = N.shape output in
    let expected = N.of_array expected out_shp in
    close output expected


  (* Test sum_reduce operation *)

  module To_test_sum_reduce = struct

    let fun00 () =
      test [|720.|] [|1;2;3;4;5;6|] [|0;1;2;3;4;5|]

    let fun01 () =
      let expected = Array.make 720 1. in
      test expected [|1;2;3;4;5;6|] [|0|]

    let fun02 () =
      let expected = Array.make 180 4. in
      test expected [|1;2;3;4;5;6|] [|3|]

    let fun03 () =
      let expected = Array.make 72 10. in
      test expected [|1;2;3;4;5;6|] [|1;4|]

    let fun04 () =
      let expected = Array.make 6 120. in
      test expected [|1;2;3;4;5;6|] [|1;2;3;4|]

    let fun05 () =
      let expected = Array.make 48 15. in
      test expected [| 1;2;3;4;5;6|] [|0;2;4|]

    let fun06 () =
      let expected = Array.make 18 40. in
      test expected [|1;2;3;4;5;6|] [|0;1;3;4|]

    let fun07 () =
      let expected = [|45.|] in
      test ~seq:true expected [|10|] [|0|]

    let fun08 () =
      let expected = [|30.;34.;38.;42.;46.|] in
      test ~seq:true expected [|4;5|] [|0|]

    let fun09 () =
      let expected = [|10.;35.;60.;85.|] in
      test ~seq:true expected [|4;5|] [|1|]

    let fun10 () =
      let expected = [|1.|] in
      test expected [|1;1;1;1;1|] [|1;2;4|]

    let fun11 () =
      let expected = [|
        21.; 70.; 119.; 168.; 217.; 266.; 315.;
        364.; 413.; 462.; 511.; 560.; 609.|]
      in
      test ~seq:true expected [|1;13;1;7|] [|0;3|]

    let fun12 () =
      test ~a:false [|720.|] [|1;2;3;4;5;6|] [|0|]

  end


  (* Tests *)

  let fun_sr00 () =
    Alcotest.(check bool) "sum_reduce 00" true (To_test_sum_reduce.fun00 ())

  let fun_sr01 () =
    Alcotest.(check bool) "sum_reduce 01" true (To_test_sum_reduce.fun01 ())

  let fun_sr02 () =
    Alcotest.(check bool) "sum_reduce 02" true (To_test_sum_reduce.fun02 ())

  let fun_sr03 () =
    Alcotest.(check bool) "sum_reduce 03" true (To_test_sum_reduce.fun03 ())

  let fun_sr04 () =
    Alcotest.(check bool) "sum_reduce 04" true (To_test_sum_reduce.fun04 ())

  let fun_sr05 () =
    Alcotest.(check bool) "sum_reduce 05" true (To_test_sum_reduce.fun05 ())

  let fun_sr06 () =
    Alcotest.(check bool) "sum_reduce 06" true (To_test_sum_reduce.fun06 ())

  let fun_sr07 () =
    Alcotest.(check bool) "sum_reduce 07" true (To_test_sum_reduce.fun07 ())

  let fun_sr08 () =
    Alcotest.(check bool) "sum_reduce 08" true (To_test_sum_reduce.fun08 ())

  let fun_sr09 () =
    Alcotest.(check bool) "sum_reduce 09" true (To_test_sum_reduce.fun09 ())

  let fun_sr10 () =
    Alcotest.(check bool) "sum_reduce 10" true (To_test_sum_reduce.fun10 ())

  let fun_sr11 () =
    Alcotest.(check bool) "sum_reduce 11" true (To_test_sum_reduce.fun11 ())

  let fun_sr12 () =
    Alcotest.(check bool) "sum_reduce 12" true (To_test_sum_reduce.fun12 ())

  let test_set = [
    "fun_sr00",  `Slow, fun_sr00;
    "fun_sr01",  `Slow, fun_sr01;
    "fun_sr02",  `Slow, fun_sr02;
    "fun_sr03",  `Slow, fun_sr03;
    "fun_sr04",  `Slow, fun_sr04;
    "fun_sr05",  `Slow, fun_sr05;
    "fun_sr06",  `Slow, fun_sr06;
    "fun_sr07",  `Slow, fun_sr07;
    "fun_sr08",  `Slow, fun_sr08;
    "fun_sr09",  `Slow, fun_sr09;
    "fun_sr10",  `Slow, fun_sr10;
    "fun_sr11",  `Slow, fun_sr11;
    "fun_sr12",  `Slow, fun_sr12;
  ]


end
