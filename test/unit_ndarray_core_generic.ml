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

  let test_sum_reduce ?(seq=false) ?(a=true) expected shape axis =
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

  let test_repeat expected arr shp in_rep out_rep =
    let x = N.of_array arr shp in
    let rep_result = N.repeat x in_rep in
    let output = N.tile rep_result out_rep in
    let output_shp = N.shape output in
    let expected = N.of_array expected output_shp in
    output = expected


  (* test sum_reduce operation *)

  module To_test_sum_reduce = struct

    let fun00 () =
      test_sum_reduce [|720.|] [|1;2;3;4;5;6|] [|0;1;2;3;4;5|]

    let fun01 () =
      let expected = Array.make 720 1. in
      test_sum_reduce expected [|1;2;3;4;5;6|] [|0|]

    let fun02 () =
      let expected = Array.make 180 4. in
      test_sum_reduce expected [|1;2;3;4;5;6|] [|3|]

    let fun03 () =
      let expected = Array.make 72 10. in
      test_sum_reduce expected [|1;2;3;4;5;6|] [|1;4|]

    let fun04 () =
      let expected = Array.make 6 120. in
      test_sum_reduce expected [|1;2;3;4;5;6|] [|1;2;3;4|]

    let fun05 () =
      let expected = Array.make 48 15. in
      test_sum_reduce expected [| 1;2;3;4;5;6|] [|0;2;4|]

    let fun06 () =
      let expected = Array.make 18 40. in
      test_sum_reduce expected [|1;2;3;4;5;6|] [|0;1;3;4|]

    let fun07 () =
      let expected = [|45.|] in
      test_sum_reduce ~seq:true expected [|10|] [|0|]

    let fun08 () =
      let expected = [|30.;34.;38.;42.;46.|] in
      test_sum_reduce ~seq:true expected [|4;5|] [|0|]

    let fun09 () =
      let expected = [|10.;35.;60.;85.|] in
      test_sum_reduce ~seq:true expected [|4;5|] [|1|]

    let fun10 () =
      let expected = [|1.|] in
      test_sum_reduce expected [|1;1;1;1;1|] [|1;2;4|]

    let fun11 () =
      let expected = [|
        21.; 70.; 119.; 168.; 217.; 266.; 315.;
        364.; 413.; 462.; 511.; 560.; 609.|]
      in
      test_sum_reduce ~seq:true expected [|1;13;1;7|] [|0;3|]

    let fun12 () =
      test_sum_reduce ~a:false [|720.|] [|1;2;3;4;5;6|] [|0|]

  end


  (* test repeat and tile operation *)

  module To_test_repeat = struct

    let fun00 () =
      test_repeat [|1.;2.|] [|1.;2.|] [|2|] [|1|] [|1|]

    let fun01 () =
      test_repeat [|1.; 1.; 2.; 2.|] [|1.;2.|] [|2|] [|2|] [|1|]

    let fun02 () =
      test_repeat [|1.; 2.; 1.; 2.|] [|1.;2.|] [|2|] [|1|] [|2|]

    let fun03 () =
      test_repeat [|1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.|]
        [|1.;2.|] [|2|] [|2|] [|2|]

    let fun04 () =
      test_repeat [|1.;2.|] [|1.;2.|] [|1;2|] [|1;1|] [|1;1|]

    let fun05 () =
      test_repeat [|1.; 1.; 2.; 2.|] [|1.;2.|] [|2;1|] [|2;1|] [|1;1|]

    let fun06 () =
      test_repeat [|1.; 1.; 2.; 2.|] [|1.;2.|] [|2;1|] [|1;2|] [|1;1|]

    let fun07 () =
      test_repeat [|1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.|] [|1.;2.|] [|2;1|] [|1;2|] [|2;1|]

    let fun08 () =
      test_repeat [|1.; 1.; 2.; 2.|] [|1.;2.|] [|2;1|] [|1;1|] [|1;2|]

    let fun09 () =
      test_repeat [|1.; 2.; 3.; 4.; 1.; 2.; 3.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|1;1|] [|2;1|]

    let fun10 () =
      test_repeat [|1.; 2.; 1.; 2.; 3.; 4.; 3.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|1;1|] [|1;2|]

    let fun11 () =
      test_repeat [|
        1.; 2.; 1.; 2.; 3.; 4.; 3.; 4.; 1.; 2.; 1.; 2.; 3.; 4.; 3.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|1;1|] [|2;2|]

    let fun12 () =
      test_repeat [|
        1.; 2.; 1.; 2.; 3.; 4.; 3.; 4.|] [|1.; 2.; 3.; 4.|]
        [|2;2|] [|2;1|] [|1;1|]

    let fun13 () =
      test_repeat [|
        1.; 2.; 1.; 2.; 3.; 4.; 3.; 4.; 1.; 2.; 1.; 2.; 3.; 4.; 3.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|2;1|] [|2;1|]

    let fun14 () =
      test_repeat [|
        1.; 2.; 1.; 2.; 3.; 4.; 3.; 4.; 1.; 2.; 1.; 2.; 3.; 4.; 3.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|2;1|] [|2;1|]

    let fun15 () =
      test_repeat [|
        1.; 2.; 1.; 2.; 1.; 2.; 1.; 2.; 3.; 4.; 3.; 4.; 3.; 4.; 3.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|2;1|] [|1;2|]

    let fun16 () =
      test_repeat [|1.; 1.; 2.; 2.; 3.; 3.; 4.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|1;2|] [|1;1|]

    let fun17 () =
      test_repeat [|
        1.; 1.; 2.; 2.; 3.; 3.; 4.; 4.; 1.; 1.; 2.; 2.; 3.; 3.; 4.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|1;2|] [|2;1|]

    let fun18 () =
      test_repeat [|
        1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.; 3.; 3.; 4.; 4.; 3.; 3.; 4.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|1;2|] [|1;2|]

    let fun19 () =
      test_repeat [|
        1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.;
        3.; 3.; 4.; 4.; 3.; 3.; 4.; 4.; 3.; 3.; 4.; 4.; 3.; 3.; 4.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|2;2|] [|1;2|]

    let fun20 () =
      test_repeat [|
        1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.;
        3.; 3.; 4.; 4.; 3.; 3.; 4.; 4.; 3.; 3.; 4.; 4.; 3.; 3.; 4.; 4.;
        1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.;
        3.; 3.; 4.; 4.; 3.; 3.; 4.; 4.; 3.; 3.; 4.; 4.; 3.; 3.; 4.; 4.|]
        [|1.; 2.; 3.; 4.|] [|2;2|] [|2;2|] [|2;2|]

    let fun21 () =
      test_repeat [|0.; 1.; 2.; 3.; 4.; 5.|] [|0.; 1.; 2.; 3.; 4.; 5.|]
        [|1;2;3|] [|1;1;1|] [|1;1;1|]

    let fun22 () =
      test_repeat [|
        0.; 0.; 1.; 1.; 2.; 2.; 0.; 0.; 1.; 1.; 2.; 2.; 3.; 3.; 4.; 4.; 5.; 5.;
        3.; 3.; 4.; 4.; 5.; 5.; 0.; 0.; 1.; 1.; 2.; 2.; 0.; 0.; 1.; 1.; 2.; 2.;
        3.; 3.; 4.; 4.; 5.; 5.; 3.; 3.; 4.; 4.; 5.; 5.; 0.; 0.; 1.; 1.; 2.; 2.;
        0.; 0.; 1.; 1.; 2.; 2.; 3.; 3.; 4.; 4.; 5.; 5.; 3.; 3.; 4.; 4.; 5.; 5.|]
        [|0.; 1.; 2.; 3.; 4.; 5.|] [|1;2;3|] [|3;2;2|] [|1;1;1|]

    let fun23 () =
      test_repeat [|0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.|]
        [|0.; 1.; 2.; 3.; 4.; 5.|] [|1;2;3|] [|1;2;1|] [|1;1;1|]

    let fun24 () =
      test_repeat [|0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.; 5.|]
        [|0.; 1.; 2.; 3.; 4.; 5.|] [|1;2;3|] [|2;1;1|] [|1;1;1|]

    let fun25 () =
      test_repeat [|0.; 0.; 1.; 1.; 2.; 2.; 3.; 3.; 4.; 4.; 5.; 5.|]
        [|0.; 1.; 2.; 3.; 4.; 5.|] [|1;2;3|] [|1;1;2|] [|1;1;1|]

    let fun26 () =
      test_repeat [|
        0.; 1.; 0.; 1.; 2.; 3.; 2.; 3.; 4.; 5.; 4.; 5.; 0.; 1.; 0.; 1.; 2.; 3.;
        2.; 3.; 4.; 5.; 4.; 5.; 6.; 7.; 6.; 7.; 8.; 9.; 8.; 9.; 10.; 11.; 10.; 11.; 6.; 7.; 6.; 7.; 8.; 9.; 8.; 9.; 10.; 11.; 10.; 11.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.|]
        [|2;3;1;2|] [|2;1;2;1|] [|1;1;1;1|]

    let fun27 () =
      test_repeat [|
        0.; 0.; 0.; 1.; 1.; 1.; 0.; 0.; 0.; 1.; 1.; 1.; 2.; 2.; 2.; 3.; 3.; 3.;
        2.; 2.; 2.; 3.; 3.; 3.; 4.; 4.; 4.; 5.; 5.; 5.; 4.; 4.; 4.; 5.; 5.; 5.;
        6.; 6.; 6.; 7.; 7.; 7.; 6.; 6.; 6.; 7.; 7.; 7.; 8.; 8.; 8.; 9.; 9.; 9.;
        8.; 8.; 8.; 9.; 9.; 9.; 10.; 10.; 10.; 11.; 11.; 11.; 10.; 10.; 10.;
        11.; 11.; 11.; 12.; 12.; 12.; 13.; 13.; 13.; 12.; 12.; 12.; 13.; 13.;
        13.; 14.; 14.; 14.; 15.; 15.; 15.; 14.; 14.; 14.; 15.; 15.; 15.; 16.;
        16.; 16.; 17.; 17.; 17.; 16.; 16.; 16.; 17.; 17.; 17.; 18.; 18.; 18.;
        19.; 19.; 19.; 18.; 18.; 18.; 19.; 19.; 19.; 20.; 20.; 20.; 21.; 21.;
        21.; 20.; 20.; 20.; 21.; 21.; 21.; 22.; 22.; 22.; 23.; 23.; 23.; 22.;
        22.; 22.; 23.; 23.; 23.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.;
        13.; 14.; 15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.; 23.|]
        [|4;3;1;2;1|] [|1;2;1;1;3|] [|1;1;1;1;1|]

    let fun28 () =
      test_repeat [|0.; 0.; 1.; 1.; 2.; 2.; 3.; 3.; 4.; 4.|]
        [|0.; 1.; 2.; 3.; 4.|] [|5|] [|2|] [|1|]

    let fun29 () =
      test_repeat [|0.; 0.; 1.; 1.; 2.; 2.; 3.; 3.; 4.; 4.|]
        [|0.; 1.; 2.; 3.; 4.|] [|5;1|] [|2;1|] [|1;1|]

    let fun30 () =
      test_repeat [|0.; 0.; 0.; 0.|]
        [|0.|] [|1;1;1|] [|2;1;2|] [|1;1;1|]

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

  let fun_rt00 () =
    Alcotest.(check bool) "repeat_tile 00" true (To_test_repeat.fun00 ())

  let fun_rt01 () =
    Alcotest.(check bool) "repeat_tile 01" true (To_test_repeat.fun01 ())

  let fun_rt02 () =
    Alcotest.(check bool) "repeat_tile 02" true (To_test_repeat.fun02 ())

  let fun_rt03 () =
    Alcotest.(check bool) "repeat_tile 03" true (To_test_repeat.fun03 ())

  let fun_rt04 () =
    Alcotest.(check bool) "repeat_tile 04" true (To_test_repeat.fun04 ())

  let fun_rt05 () =
    Alcotest.(check bool) "repeat_tile 05" true (To_test_repeat.fun05 ())

  let fun_rt06 () =
    Alcotest.(check bool) "repeat_tile 06" true (To_test_repeat.fun06 ())

  let fun_rt07 () =
    Alcotest.(check bool) "repeat_tile 07" true (To_test_repeat.fun07 ())

  let fun_rt08 () =
    Alcotest.(check bool) "repeat_tile 08" true (To_test_repeat.fun08 ())

  let fun_rt09 () =
    Alcotest.(check bool) "repeat_tile 09" true (To_test_repeat.fun09 ())

  let fun_rt10 () =
    Alcotest.(check bool) "repeat_tile 10" true (To_test_repeat.fun10 ())

  let fun_rt11 () =
    Alcotest.(check bool) "repeat_tile 11" true (To_test_repeat.fun11 ())

  let fun_rt12 () =
    Alcotest.(check bool) "repeat_tile 12" true (To_test_repeat.fun12 ())

  let fun_rt13 () =
    Alcotest.(check bool) "repeat_tile 13" true (To_test_repeat.fun13 ())

  let fun_rt14 () =
    Alcotest.(check bool) "repeat_tile 14" true (To_test_repeat.fun14 ())

  let fun_rt15 () =
    Alcotest.(check bool) "repeat_tile 15" true (To_test_repeat.fun15 ())

  let fun_rt16 () =
    Alcotest.(check bool) "repeat_tile 16" true (To_test_repeat.fun16 ())

  let fun_rt17 () =
    Alcotest.(check bool) "repeat_tile 17" true (To_test_repeat.fun17 ())

  let fun_rt18 () =
    Alcotest.(check bool) "repeat_tile 18" true (To_test_repeat.fun18 ())

  let fun_rt19 () =
    Alcotest.(check bool) "repeat_tile 19" true (To_test_repeat.fun19 ())

  let fun_rt20 () =
    Alcotest.(check bool) "repeat_tile 20" true (To_test_repeat.fun20 ())

  let fun_rt21 () =
    Alcotest.(check bool) "repeat_tile 21" true (To_test_repeat.fun21 ())

  let fun_rt22 () =
    Alcotest.(check bool) "repeat_tile 22" true (To_test_repeat.fun22 ())

  let fun_rt23 () =
    Alcotest.(check bool) "repeat_tile 23" true (To_test_repeat.fun23 ())

  let fun_rt24 () =
    Alcotest.(check bool) "repeat_tile 24" true (To_test_repeat.fun24 ())

  let fun_rt25 () =
    Alcotest.(check bool) "repeat_tile 25" true (To_test_repeat.fun25 ())

  let fun_rt26 () =
    Alcotest.(check bool) "repeat_tile 26" true (To_test_repeat.fun26 ())

  let fun_rt27 () =
    Alcotest.(check bool) "repeat_tile 27" true (To_test_repeat.fun27 ())

  let fun_rt28 () =
    Alcotest.(check bool) "repeat_tile 28" true (To_test_repeat.fun28 ())

  let fun_rt29 () =
    Alcotest.(check bool) "repeat_tile 29" true (To_test_repeat.fun29 ())

  let fun_rt30 () =
    Alcotest.(check bool) "repeat_tile 30" true (To_test_repeat.fun30 ())

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
    "fun_rt00",  `Slow, fun_rt00;
    "fun_rt01",  `Slow, fun_rt01;
    "fun_rt02",  `Slow, fun_rt02;
    "fun_rt03",  `Slow, fun_rt03;
    "fun_rt04",  `Slow, fun_rt04;
    "fun_rt05",  `Slow, fun_rt05;
    "fun_rt06",  `Slow, fun_rt06;
    "fun_rt07",  `Slow, fun_rt07;
    "fun_rt08",  `Slow, fun_rt08;
    "fun_rt09",  `Slow, fun_rt09;
    "fun_rt10",  `Slow, fun_rt10;
    "fun_rt11",  `Slow, fun_rt11;
    "fun_rt12",  `Slow, fun_rt12;
    "fun_rt13",  `Slow, fun_rt13;
    "fun_rt14",  `Slow, fun_rt14;
    "fun_rt15",  `Slow, fun_rt15;
    "fun_rt16",  `Slow, fun_rt16;
    "fun_rt17",  `Slow, fun_rt17;
    "fun_rt18",  `Slow, fun_rt18;
    "fun_rt19",  `Slow, fun_rt19;
    "fun_rt20",  `Slow, fun_rt20;
    "fun_rt21",  `Slow, fun_rt21;
    "fun_rt22",  `Slow, fun_rt22;
    "fun_rt23",  `Slow, fun_rt23;
    "fun_rt24",  `Slow, fun_rt24;
    "fun_rt25",  `Slow, fun_rt25;
    "fun_rt26",  `Slow, fun_rt26;
    "fun_rt27",  `Slow, fun_rt27;
    "fun_rt28",  `Slow, fun_rt28;
    "fun_rt29",  `Slow, fun_rt29;
    "fun_rt30",  `Slow, fun_rt30;
  ]


end
