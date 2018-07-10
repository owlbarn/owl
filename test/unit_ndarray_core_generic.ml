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

  let repeat_along_axis x reps =
    let n = Array.length reps in
    let y = ref x in
    for i = n - 1 downto 0 do
      let axes = Array.make n 1 in
      axes.(i) <- reps.(i);
      y := N.(repeat !y axes)
    done;
    !y

  let tile_along_axis x reps =
    let n = Array.length reps in
    let y = ref x in
    for i = n - 1 downto 0 do
      let axes = Array.make n 1 in
      axes.(i) <- reps.(i);
      y := N.(tile !y axes)
    done;
    !y

  let test_repeat_along_axis shp reps =
    let x = N.sequential shp in
    let expected = repeat_along_axis x reps in
    let result = N.repeat x reps in
    result = expected

  let test_tile_along_axis shp reps =
    let x = N.sequential shp in
    let expected = tile_along_axis x reps in
    let result = N.tile x reps in
    result = expected


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
      let expected = [|30.; 34.; 38.; 42.; 46.|] in
      test_sum_reduce ~seq:true expected [|4;5|] [|0|]

    let fun09 () =
      let expected = [|10.; 35.; 60.; 85.|] in
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
      test_repeat [|1.; 2.|] [|1.; 2.|] [|2|] [|1|] [|1|]

    let fun01 () =
      test_repeat [|1.; 1.; 2.; 2.|] [|1.; 2.|] [|2|] [|2|] [|1|]

    let fun02 () =
      test_repeat [|1.; 2.; 1.; 2.|] [|1.; 2.|] [|2|] [|1|] [|2|]

    let fun03 () =
      test_repeat [|1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.|]
        [|1.; 2.|] [|2|] [|2|] [|2|]

    let fun04 () =
      test_repeat [|1.; 2.|] [|1.; 2.|] [|1;2|] [|1;1|] [|1;1|]

    let fun05 () =
      test_repeat [|1.; 1.; 2.; 2.|] [|1.; 2.|] [|2;1|] [|2;1|] [|1;1|]

    let fun06 () =
      test_repeat [|1.; 1.; 2.; 2.|] [|1.; 2.|] [|2;1|] [|1;2|] [|1;1|]

    let fun07 () =
      test_repeat [|1.; 1.; 2.; 2.; 1.; 1.; 2.; 2.|] [|1.; 2.|] [|2;1|] [|1;2|] [|2;1|]

    let fun08 () =
      test_repeat [|1.; 1.; 2.; 2.|] [|1.; 2.|] [|2;1|] [|1;1|] [|1;2|]

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
        2.; 3.; 4.; 5.; 4.; 5.; 6.; 7.; 6.; 7.; 8.; 9.; 8.; 9.; 10.; 11.; 10.;
        11.; 6.; 7.; 6.; 7.; 8.; 9.; 8.; 9.; 10.; 11.; 10.; 11.|]
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

    let fun31 () =
      test_repeat [|
        0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.; 0.; 1.; 2.; 0.; 1.; 2.;
        3.; 4.; 5.; 3.; 4.; 5.; 0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.|]
        [|0.; 1.; 2.; 3.; 4.; 5.|] [|1;2;3|] [|1;1;1|] [|3;1;2|]

    let fun32 () =
      test_repeat [|
        0.; 1.; 2.; 0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.; 3.; 4.; 5.|]
        [|0.; 1.; 2.; 3.; 4.; 5.|] [|1;2;3|] [|1;1;1|] [|3|]

    let fun33 () =
      test_repeat [|
        0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.; 0.; 1.; 2.; 0.; 1.; 2.;
        3.; 4.; 5.; 3.; 4.; 5.; 0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.;
        0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.; 0.; 1.; 2.; 0.; 1.; 2.;
        3.; 4.; 5.; 3.; 4.; 5.; 0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.;
        0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.; 0.; 1.; 2.; 0.; 1.; 2.;
        3.; 4.; 5.; 3.; 4.; 5.; 0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.;
        0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.; 0.; 1.; 2.; 0.; 1.; 2.;
        3.; 4.; 5.; 3.; 4.; 5.; 0.; 1.; 2.; 0.; 1.; 2.; 3.; 4.; 5.; 3.; 4.; 5.|]
        [|0.; 1.; 2.; 3.; 4.; 5.|] [|1;2;3|] [|1;1;1|] [|2;1;2;3;2|]

    let fun34 () =
      test_repeat [|
        0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.; 5.;
        0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.; 5.|]
        [|0.; 1.; 2.; 3.; 4.; 5.|] [|2;3|] [|1;1|] [|4;1;1|]

    let fun35 () =
      test_repeat [|0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.; 5.|]
        [|0.; 1.; 2.; 3.; 4.; 5.|] [|1;2;3|] [|1;1;1|] [|1;2;1|]

    let fun36 () =
      test_repeat [|0.; 0.; 0.; 0.|]
        [|0.|] [|1;1;1|] [|1;1;1|] [|4|]

    let fun37 () =
      test_repeat [|0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.; 5.|]
        [|0.; 1.; 2.; 3.; 4.; 5.|] [|6|] [|1|] [|1;2;1|]

    let fun38 () =
      test_repeat [|
        0.; 1.; 0.; 1.; 2.; 3.; 2.; 3.; 4.; 5.; 4.; 5.; 6.; 7.; 6.; 7.; 8.; 9.;
        8.; 9.; 10.; 11.; 10.; 11.; 0.; 1.; 0.; 1.; 2.; 3.; 2.; 3.; 4.; 5.; 4.;
        5.; 6.; 7.; 6.; 7.; 8.; 9.; 8.; 9.; 10.; 11.; 10.; 11.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.|]
        [|2;3;1;2|] [|1;1;1;1|] [|2;1;2;1|]

    let fun39 () =
      test_repeat [|
        0.; 0.; 0.; 1.; 1.; 1.; 2.; 2.; 2.; 3.; 3.; 3.; 4.; 4.; 4.; 5.; 5.; 5.;
        0.; 0.; 0.; 1.; 1.; 1.; 2.; 2.; 2.; 3.; 3.; 3.; 4.; 4.; 4.; 5.; 5.; 5.;
        6.; 6.; 6.; 7.; 7.; 7.; 8.; 8.; 8.; 9.; 9.; 9.; 10.; 10.; 10.; 11.;
        11.; 11.; 6.; 6.; 6.; 7.; 7.; 7.; 8.; 8.; 8.; 9.; 9.; 9.; 10.; 10.;
        10.; 11.; 11.; 11.; 12.; 12.; 12.; 13.; 13.; 13.; 14.; 14.; 14.; 15.;
        15.; 15.; 16.; 16.; 16.; 17.; 17.; 17.; 12.; 12.; 12.; 13.; 13.; 13.;
        14.; 14.; 14.; 15.; 15.; 15.; 16.; 16.; 16.; 17.; 17.; 17.; 18.; 18.;
        18.; 19.; 19.; 19.; 20.; 20.; 20.; 21.; 21.; 21.; 22.; 22.; 22.; 23.;
        23.; 23.; 18.; 18.; 18.; 19.; 19.; 19.; 20.; 20.; 20.; 21.; 21.; 21.;
        22.; 22.; 22.; 23.; 23.; 23.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.;
          13.; 14.; 15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.; 23.|]
        [|4;3;1;2;1|] [|1;1;1;1;1|] [|2;1;1;3|]

    let fun40 () =
      test_repeat [|0.; 1.; 2.; 3.; 4.; 0.; 1.; 2.; 3.; 4.|]
        [|0.; 1.; 2.; 3.; 4.|] [|5|] [|1|] [|2|]

    let fun41 () =
      test_repeat [|0.; 1.; 2.; 3.; 4.; 0.; 1.; 2.; 3.; 4.|]
        [|0.; 1.; 2.; 3.; 4.|] [|5;1|] [|1;1|] [|2;1|]

    let fun42 () =
      test_repeat [|
        0.; 1.; 0.; 1.; 2.; 3.; 2.; 3.; 4.; 5.; 4.; 5.; 0.; 1.; 0.; 1.; 2.;
        3.; 2.; 3.; 4.; 5.; 4.; 5.; 6.; 7.; 6.; 7.; 8.; 9.; 8.; 9.; 10.;
        11.; 10.; 11.; 6.; 7.; 6.; 7.; 8.; 9.; 8.; 9.; 10.; 11.; 10.; 11.;
        12.; 13.; 12.; 13.; 14.; 15.; 14.; 15.; 16.; 17.; 16.; 17.; 12.;
        13.; 12.; 13.; 14.; 15.; 14.; 15.; 16.; 17.; 16.; 17.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.;
        15.; 16.; 17.|]
        [|3;3;2|] [|2;2;1|] [|1|]

    let fun43 () =
      test_repeat [|
        0.; 1.; 0.; 1.; 0.; 1.; 2.; 3.; 2.; 3.; 2.; 3.; 4.; 5.; 4.; 5.; 4.;
        5.; 0.; 1.; 0.; 1.; 0.; 1.; 2.; 3.; 2.; 3.; 2.; 3.; 4.; 5.; 4.; 5.;
        4.; 5.; 6.; 7.; 6.; 7.; 6.; 7.; 8.; 9.; 8.; 9.; 8.; 9.; 10.; 11.;
        10.; 11.; 10.; 11.; 6.; 7.; 6.; 7.; 6.; 7.; 8.; 9.; 8.; 9.; 8.; 9.;
        10.; 11.; 10.; 11.; 10.; 11.; 12.; 13.; 12.; 13.; 12.; 13.; 14.;
        15.; 14.; 15.; 14.; 15.; 16.; 17.; 16.; 17.; 16.; 17.; 12.; 13.;
        12.; 13.; 12.; 13.; 14.; 15.; 14.; 15.; 14.; 15.; 16.; 17.; 16.;
        17.; 16.; 17.; 18.; 19.; 18.; 19.; 18.; 19.; 20.; 21.; 20.; 21.;
        20.; 21.; 22.; 23.; 22.; 23.; 22.; 23.; 18.; 19.; 18.; 19.; 18.;
        19.; 20.; 21.; 20.; 21.; 20.; 21.; 22.; 23.; 22.; 23.; 22.; 23.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.;
        15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.; 23.|]
        [|4;3;2;1|] [|2;3;1;1|] [|1|]

    let fun44 () =
      test_repeat [|
        0.; 0.; 0.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.; 0.; 1.; 1.; 1.; 1.; 2.;
        2.; 2.; 2.; 3.; 3.; 3.; 3.; 2.; 2.; 2.; 2.; 3.; 3.; 3.; 3.; 4.; 4.;
        4.; 4.; 5.; 5.; 5.; 5.; 4.; 4.; 4.; 4.; 5.; 5.; 5.; 5.; 6.; 6.; 6.;
        6.; 7.; 7.; 7.; 7.; 6.; 6.; 6.; 6.; 7.; 7.; 7.; 7.; 8.; 8.; 8.; 8.;
        9.; 9.; 9.; 9.; 8.; 8.; 8.; 8.; 9.; 9.; 9.; 9.; 10.; 10.; 10.; 10.;
        11.; 11.; 11.; 11.; 10.; 10.; 10.; 10.; 11.; 11.; 11.; 11.; 12.;
        12.; 12.; 12.; 13.; 13.; 13.; 13.; 12.; 12.; 12.; 12.; 13.; 13.;
        13.; 13.; 14.; 14.; 14.; 14.; 15.; 15.; 15.; 15.; 14.; 14.; 14.;
        14.; 15.; 15.; 15.; 15.; 16.; 16.; 16.; 16.; 17.; 17.; 17.; 17.;
        16.; 16.; 16.; 16.; 17.; 17.; 17.; 17.; 18.; 18.; 18.; 18.; 19.;
        19.; 19.; 19.; 18.; 18.; 18.; 18.; 19.; 19.; 19.; 19.; 20.; 20.;
        20.; 20.; 21.; 21.; 21.; 21.; 20.; 20.; 20.; 20.; 21.; 21.; 21.;
        21.; 22.; 22.; 22.; 22.; 23.; 23.; 23.; 23.; 22.; 22.; 22.; 22.;
        23.; 23.; 23.; 23.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.;
        15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.; 23.|]
        [|4;3;2;1|] [|1;2;2;2|] [|1|]

    let fun45 () =
      test_repeat [|
        0.;1.;2.;3.;4.;5.;6.;7.;8.;0.;1.;2.;3.;4.;5.;6.;7.;8.;9.;10.;11.;
        12.;13.;14.;15.;16.;17.;9.;10.;11.;12.;13.;14.;15.;16.;17.;18.;19.;
        20.;21.;22.;23.;24.;25.;26.;18.;19.;20.;21.;22.;23.;24.;25.;26.;0.;
        1.;2.;3.;4.;5.;6.;7.;8.;0.;1.;2.;3.;4.;5.;6.;7.;8.;9.;10.;11.;12.;
        13.;14.;15.;16.;17.;9.;10.;11.;12.;13.;14.;15.;16.;17.;18.;19.;20.;
        21.;22.;23.;24.;25.;26.;18.;19.;20.;21.;22.;23.;24.;25.;26.;27.;
        28.;29.;30.;31.;32.;33.;34.;35.;27.;28.;29.;30.;31.;32.;33.;34.;
        35.;36.;37.;38.;39.;40.;41.;42.;43.;44.;36.;37.;38.;39.;40.;41.;
        42.;43.;44.;45.;46.;47.;48.;49.;50.;51.;52.;53.;45.;46.;47.;48.;
        49.;50.;51.;52.;53.;27.;28.;29.;30.;31.;32.;33.;34.;35.;27.;28.;
        29.;30.;31.;32.;33.;34.;35.;36.;37.;38.;39.;40.;41.;42.;43.;44.;
        36.;37.;38.;39.;40.;41.;42.;43.;44.;45.;46.;47.;48.;49.;50.;51.;
        52.;53.;45.;46.;47.;48.;49.;50.;51.;52.;53.;54.;55.;56.;57.;58.;
        59.;60.;61.;62.;54.;55.;56.;57.;58.;59.;60.;61.;62.;63.;64.;65.;
        66.;67.;68.;69.;70.;71.;63.;64.;65.;66.;67.;68.;69.;70.;71.;72.;
        73.;74.;75.;76.;77.;78.;79.;80.;72.;73.;74.;75.;76.;77.;78.;79.;
        80.;54.;55.;56.;57.;58.;59.;60.;61.;62.;54.;55.;56.;57.;58.;59.;
        60.;61.;62.;63.;64.;65.;66.;67.;68.;69.;70.;71.;63.;64.;65.;66.;
        67.;68.;69.;70.;71.;72.;73.;74.;75.;76.;77.;78.;79.;80.;72.;73.;
        74.;75.;76.;77.;78.;79.;80.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.;
        15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.; 23.; 24.; 25.; 26.; 27.;
        28.; 29.; 30.; 31.; 32.; 33.; 34.; 35.; 36.; 37.; 38.; 39.; 40.;
        41.; 42.; 43.; 44.; 45.; 46.; 47.; 48.; 49.; 50.; 51.; 52.; 53.;
        54.; 55.; 56.; 57.; 58.; 59.; 60.; 61.; 62.; 63.; 64.; 65.; 66.;
        67.; 68.; 69.; 70.; 71.; 72.; 73.; 74.; 75.; 76.; 77.; 78.; 79.;
        80.|]
        [|3;3;3;3|] [|2;2;1;1|] [|1|]

    let fun46 () =
      test_repeat_along_axis [|10;10;10;10|] [|1;4;3;1|]

    let fun47 () =
      test_repeat_along_axis [|4;4;4;4;4|] [|3;3;3;3;3|]

    let fun48 () =
      test_repeat_along_axis [|4;3;2;3;4|] [|3;3;3;1;1|]

    let fun49 () =
      test_repeat_along_axis [|4;3;4;4;3;4|] [|1;1;6;5;1;1|]

    let fun50 () =
      test_repeat_along_axis [|3;4;5;3;4;5|] [|3;3;1;1;4;2|]

    let fun51 () =
      test_repeat [|
        0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.;
        11.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.; 15.; 16.; 17.; 12.;
        13.; 14.; 15.; 16.; 17.; 0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.;
        5.; 6.; 7.; 8.; 9.; 10.; 11.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.;
        14.; 15.; 16.; 17.; 12.; 13.; 14.; 15.; 16.; 17.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.;
        15.; 16.; 17.|]
        [|3;3;2|] [|1;1;1|] [|2;2;1|]

    let fun52 () =
      test_repeat [|
        0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.;
        5.; 6.; 7.; 8.; 9.; 10.; 11.; 6.; 7.; 8.; 9.; 10.; 11.; 6.; 7.; 8.;
        9.; 10.; 11.; 12.; 13.; 14.; 15.; 16.; 17.; 12.; 13.; 14.; 15.;
        16.; 17.; 12.; 13.; 14.; 15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.;
        23.; 18.; 19.; 20.; 21.; 22.; 23.; 18.; 19.; 20.; 21.; 22.; 23.;
        0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.; 5.; 0.; 1.; 2.; 3.; 4.;
        5.; 6.; 7.; 8.; 9.; 10.; 11.; 6.; 7.; 8.; 9.; 10.; 11.; 6.; 7.; 8.;
        9.; 10.; 11.; 12.; 13.; 14.; 15.; 16.; 17.; 12.; 13.; 14.; 15.;
        16.; 17.; 12.; 13.; 14.; 15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.;
        23.; 18.; 19.; 20.; 21.; 22.; 23.; 18.; 19.; 20.; 21.; 22.; 23.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.;
        15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.; 23.|]
        [|4;3;2;1|] [|1;1;1;1|] [|2;3;1;1|]

    let fun53 () =
      test_repeat [|
        0.; 0.; 1.; 1.; 0.; 0.; 1.; 1.; 2.; 2.; 3.; 3.; 2.; 2.; 3.; 3.; 4.;
        4.; 5.; 5.; 4.; 4.; 5.; 5.; 0.; 0.; 1.; 1.; 0.; 0.; 1.; 1.; 2.; 2.;
        3.; 3.; 2.; 2.; 3.; 3.; 4.; 4.; 5.; 5.; 4.; 4.; 5.; 5.; 6.; 6.; 7.;
        7.; 6.; 6.; 7.; 7.; 8.; 8.; 9.; 9.; 8.; 8.; 9.; 9.; 10.; 10.; 11.;
        11.; 10.; 10.; 11.; 11.; 6.; 6.; 7.; 7.; 6.; 6.; 7.; 7.; 8.; 8.;
        9.; 9.; 8.; 8.; 9.; 9.; 10.; 10.; 11.; 11.; 10.; 10.; 11.; 11.;
        12.; 12.; 13.; 13.; 12.; 12.; 13.; 13.; 14.; 14.; 15.; 15.; 14.;
        14.; 15.; 15.; 16.; 16.; 17.; 17.; 16.; 16.; 17.; 17.; 12.; 12.;
        13.; 13.; 12.; 12.; 13.; 13.; 14.; 14.; 15.; 15.; 14.; 14.; 15.;
        15.; 16.; 16.; 17.; 17.; 16.; 16.; 17.; 17.; 18.; 18.; 19.; 19.;
        18.; 18.; 19.; 19.; 20.; 20.; 21.; 21.; 20.; 20.; 21.; 21.; 22.;
        22.; 23.; 23.; 22.; 22.; 23.; 23.; 18.; 18.; 19.; 19.; 18.; 18.;
        19.; 19.; 20.; 20.; 21.; 21.; 20.; 20.; 21.; 21.; 22.; 22.; 23.;
        23.; 22.; 22.; 23.; 23.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.;
        15.; 16.; 17.; 18.; 19.; 20.; 21.; 22.; 23.|]
        [|4;3;2;1|] [|1;1;1;1|] [|1;2;2;2|]

    let fun54 () =
      test_repeat [|
        0.;1.;2.;3.;4.;5.;6.;7.;8.;9.;10.;11.;12.;13.;14.;15.;16.;17.;18.;
        19.;20.;21.;22.;23.;24.;25.;26.;0.;1.;2.;3.;4.;5.;6.;7.;8.;9.;10.;
        11.;12.;13.;14.;15.;16.;17.;18.;19.;20.;21.;22.;23.;24.;25.;26.;
        27.;28.;29.;30.;31.;32.;33.;34.;35.;36.;37.;38.;39.;40.;41.;42.;
        43.;44.;45.;46.;47.;48.;49.;50.;51.;52.;53.;27.;28.;29.;30.;31.;
        32.;33.;34.;35.;36.;37.;38.;39.;40.;41.;42.;43.;44.;45.;46.;47.;
        48.;49.;50.;51.;52.;53.;54.;55.;56.;57.;58.;59.;60.;61.;62.;63.;
        64.;65.;66.;67.;68.;69.;70.;71.;72.;73.;74.;75.;76.;77.;78.;79.;
        80.;54.;55.;56.;57.;58.;59.;60.;61.;62.;63.;64.;65.;66.;67.;68.;
        69.;70.;71.;72.;73.;74.;75.;76.;77.;78.;79.;80.;0.;1.;2.;3.;4.;5.;
        6.;7.;8.;9.;10.;11.;12.;13.;14.;15.;16.;17.;18.;19.;20.;21.;22.;
        23.;24.;25.;26.;0.;1.;2.;3.;4.;5.;6.;7.;8.;9.;10.;11.;12.;13.;14.;
        15.;16.;17.;18.;19.;20.;21.;22.;23.;24.;25.;26.;27.;28.;29.;30.;
        31.;32.;33.;34.;35.;36.;37.;38.;39.;40.;41.;42.;43.;44.;45.;46.;
        47.;48.;49.;50.;51.;52.;53.;27.;28.;29.;30.;31.;32.;33.;34.;35.;
        36.;37.;38.;39.;40.;41.;42.;43.;44.;45.;46.;47.;48.;49.;50.;51.;
        52.;53.;54.;55.;56.;57.;58.;59.;60.;61.;62.;63.;64.;65.;66.;67.;
        68.;69.;70.;71.;72.;73.;74.;75.;76.;77.;78.;79.;80.;54.;55.;56.;
        57.;58.;59.;60.;61.;62.;63.;64.;65.;66.;67.;68.;69.;70.;71.;72.;
        73.;74.;75.;76.;77.;78.;79.;80.|]
        [|0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.;
        15.; 16.;17.; 18.; 19.; 20.; 21.; 22.; 23.; 24.; 25.; 26.; 27.;
        28.; 29.; 30.; 31.; 32.; 33.; 34.; 35.; 36.; 37.; 38.; 39.; 40.;
        41.; 42.; 43.; 44.; 45.; 46.; 47.; 48.; 49.; 50.; 51.; 52.; 53.;
        54.; 55.; 56.; 57.; 58.; 59.; 60.; 61.; 62.; 63.; 64.; 65.; 66.;
        67.; 68.; 69.; 70.; 71.; 72.; 73.; 74.; 75.; 76.; 77.; 78.; 79.;
        80.|]
        [|3;3;3;3|] [|1;1;1;1|] [|2;2;1;1|]

    let fun55 () =
      test_tile_along_axis [|10;10;10;10|] [|1;4;3;1|]

    let fun56 () =
      test_tile_along_axis [|4;4;4;4;4|] [|3;3;3;3;3|]

    let fun57 () =
      test_tile_along_axis [|4;3;2;3;4|] [|3;3;3;1;1|]

    let fun58 () =
      test_tile_along_axis [|4;3;4;4;3;4|] [|1;1;6;5;1;1|]

    let fun59 () =
      test_tile_along_axis [|3;4;5;3;4;5|] [|3;3;1;1;4;2|]

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

  let fun_rt31 () =
    Alcotest.(check bool) "repeat_tile 31" true (To_test_repeat.fun31 ())

  let fun_rt32 () =
    Alcotest.(check bool) "repeat_tile 32" true (To_test_repeat.fun32 ())

  let fun_rt33 () =
    Alcotest.(check bool) "repeat_tile 33" true (To_test_repeat.fun33 ())

  let fun_rt34 () =
    Alcotest.(check bool) "repeat_tile 34" true (To_test_repeat.fun34 ())

  let fun_rt35 () =
    Alcotest.(check bool) "repeat_tile 35" true (To_test_repeat.fun35 ())

  let fun_rt36 () =
    Alcotest.(check bool) "repeat_tile 36" true (To_test_repeat.fun36 ())

  let fun_rt37 () =
    Alcotest.(check bool) "repeat_tile 37" true (To_test_repeat.fun37 ())

  let fun_rt38 () =
    Alcotest.(check bool) "repeat_tile 38" true (To_test_repeat.fun38 ())

  let fun_rt39 () =
    Alcotest.(check bool) "repeat_tile 39" true (To_test_repeat.fun39 ())

  let fun_rt40 () =
    Alcotest.(check bool) "repeat_tile 40" true (To_test_repeat.fun40 ())

  let fun_rt41 () =
    Alcotest.(check bool) "repeat_tile 41" true (To_test_repeat.fun41 ())

  let fun_rt42 () =
    Alcotest.(check bool) "repeat_tile 42" true (To_test_repeat.fun42 ())

  let fun_rt43 () =
    Alcotest.(check bool) "repeat_tile 43" true (To_test_repeat.fun43 ())

  let fun_rt44 () =
    Alcotest.(check bool) "repeat_tile 44" true (To_test_repeat.fun44 ())

  let fun_rt45 () =
    Alcotest.(check bool) "repeat_tile 45" true (To_test_repeat.fun45 ())

  let fun_rt46 () =
    Alcotest.(check bool) "repeat_tile 46" true (To_test_repeat.fun46 ())

  let fun_rt47 () =
    Alcotest.(check bool) "repeat_tile 47" true (To_test_repeat.fun47 ())

  let fun_rt48 () =
    Alcotest.(check bool) "repeat_tile 48" true (To_test_repeat.fun48 ())

  let fun_rt49 () =
    Alcotest.(check bool) "repeat_tile 49" true (To_test_repeat.fun49 ())

  let fun_rt50 () =
    Alcotest.(check bool) "repeat_tile 50" true (To_test_repeat.fun50 ())

  let fun_rt51 () =
    Alcotest.(check bool) "repeat_tile 51" true (To_test_repeat.fun51 ())

  let fun_rt52 () =
    Alcotest.(check bool) "repeat_tile 52" true (To_test_repeat.fun52 ())

  let fun_rt53 () =
    Alcotest.(check bool) "repeat_tile 53" true (To_test_repeat.fun53 ())

  let fun_rt54 () =
    Alcotest.(check bool) "repeat_tile 54" true (To_test_repeat.fun54 ())

  let fun_rt55 () =
    Alcotest.(check bool) "repeat_tile 55" true (To_test_repeat.fun55 ())

  let fun_rt56 () =
    Alcotest.(check bool) "repeat_tile 56" true (To_test_repeat.fun56 ())

  let fun_rt57 () =
    Alcotest.(check bool) "repeat_tile 57" true (To_test_repeat.fun57 ())

  let fun_rt58 () =
    Alcotest.(check bool) "repeat_tile 58" true (To_test_repeat.fun58 ())

  let fun_rt59 () =
    Alcotest.(check bool) "repeat_tile 59" true (To_test_repeat.fun59 ())

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
    "fun_rt31",  `Slow, fun_rt31;
    "fun_rt32",  `Slow, fun_rt32;
    "fun_rt33",  `Slow, fun_rt33;
    "fun_rt34",  `Slow, fun_rt34;
    "fun_rt35",  `Slow, fun_rt35;
    "fun_rt36",  `Slow, fun_rt36;
    "fun_rt37",  `Slow, fun_rt37;
    "fun_rt38",  `Slow, fun_rt38;
    "fun_rt39",  `Slow, fun_rt39;
    "fun_rt40",  `Slow, fun_rt40;
    "fun_rt41",  `Slow, fun_rt41;
    "fun_rt42",  `Slow, fun_rt42;
    "fun_rt43",  `Slow, fun_rt43;
    "fun_rt44",  `Slow, fun_rt44;
    "fun_rt45",  `Slow, fun_rt45;
    "fun_rt46",  `Slow, fun_rt46;
    "fun_rt47",  `Slow, fun_rt47;
    "fun_rt48",  `Slow, fun_rt48;
    "fun_rt49",  `Slow, fun_rt49;
    "fun_rt50",  `Slow, fun_rt50;
    "fun_rt51",  `Slow, fun_rt51;
    "fun_rt52",  `Slow, fun_rt52;
    "fun_rt53",  `Slow, fun_rt53;
    "fun_rt54",  `Slow, fun_rt54;
    "fun_rt55",  `Slow, fun_rt55;
    "fun_rt56",  `Slow, fun_rt56;
    "fun_rt57",  `Slow, fun_rt57;
    "fun_rt58",  `Slow, fun_rt58;
    "fun_rt59",  `Slow, fun_rt59;
  ]


end
