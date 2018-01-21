(** Unit test for Owl_stats module *)

open Owl

(* some test input *)

let x0 = Arr.sequential [|10|]

let x1 = Arr.sequential [|10;10|]

let x2 = Arr.sequential [|10;10;10|]

let x3 = Arr.sequential [|5;5;5;5|]


(* a module with functions to test *)
module To_test = struct

  let test_01 () =
    let s = [[]] in
    let y = Arr.get_slice_simple s x0 in
    Arr.(y = x0)

  let test_02 () =
    let s = [[3]] in
    let y = Arr.get_slice_simple s x0 in
    let z = Arr.of_array [|3.|] [|1|] in
    Arr.(y = z)

  let test_03 () =
    let s = [[2;5]] in
    let y = Arr.get_slice_simple s x0 in
    let z = Arr.of_array [|2.;3.;4.;5.|] [|4|] in
    Arr.(y = z)

  let test_04 () =
    let s = [[2;-1;3]] in
    let y = Arr.get_slice_simple s x0 in
    let z = Arr.of_array [|2.;5.;8.|] [|3|] in
    Arr.(y = z)

  let test_05 () =
    let s = [[-2;5]] in
    let y = Arr.get_slice_simple s x0 in
    let z = Arr.of_array [|8.;7.;6.;5.|] [|4|] in
    Arr.(y = z)

  let test_06 () =
    let s = [[-2;4;-2]] in
    let y = Arr.get_slice_simple s x0 in
    let z = Arr.of_array [|8.;6.;4.|] [|3|] in
    Arr.(y = z)

  let test_07 () =
    let s = [[];[]] in
    let y = Arr.get_slice_simple s x1 in
    Arr.(y = x1)

  let test_08 () =
    let s = [[2];[]] in
    let y = Arr.get_slice_simple s x1 in
    let z = Arr.of_array [|20.;21.;22.;23.;24.;25.;26.;27.;28.;29.|] [|1;10|] in
    Arr.(y = z)

  let test_09 () =
    let s = [[0;5];[]] in
    let y = Arr.get_slice_simple s x1 in
    let z = Arr.sequential [|6;10|] in
    Arr.(y = z)

  let test_10 () =
    let s = [[0;5;2];[]] in
    let y = Arr.get_slice_simple s x1 in
    let z = Arr.of_array [|
       0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.;
      20.;21.;22.;23.;24.;25.;26.;27.;28.;29.;
      40.;41.;42.;43.;44.;45.;46.;47.;48.;49.;
    |] [|3;10|] in
    Arr.(y = z)

  let test_11 () =
    let s = [[5;0;-2];[]] in
    let y = Arr.get_slice_simple s x1 in
    let z = Arr.of_array [|
      50.;51.;52.;53.;54.;55.;56.;57.;58.;59.;
      30.;31.;32.;33.;34.;35.;36.;37.;38.;39.;
      10.;11.;12.;13.;14.;15.;16.;17.;18.;19.;
    |] [|3;10|] in
    Arr.(y = z)

  let test_12 () =
    let s = [[0;5;2];[1;5]] in
    let y = Arr.get_slice_simple s x1 in
    let z = Arr.of_array [|
       1.; 2.; 3.; 4.; 5.;
      21.;22.;23.;24.;25.;
      41.;42.;43.;44.;45.;
    |] [|3;5|] in
    Arr.(y = z)

  let test_13 () =
    let s = [[0;5;2];[1;5;3]] in
    let y = Arr.get_slice_simple s x1 in
    let z = Arr.of_array [|
       1.; 4.;
      21.;24.;
      41.;44.;
    |] [|3;2|] in
    Arr.(y = z)

  let test_14 () =
    let s = [[0;5;2];[-5;1]] in
    let y = Arr.get_slice_simple s x1 in
    let z = Arr.of_array [|
       5.; 4.; 3.; 2.; 1.;
      25.;24.;23.;22.;21.;
      45.;44.;43.;42.;41.;
    |] [|3;5|] in
    Arr.(y = z)

  let test_15 () =
    let s = [[0;5;2];[-5;1;-2]] in
    let y = Arr.get_slice_simple s x1 in
    let z = Arr.of_array [|
       5.; 3.; 1.;
      25.;23.;21.;
      45.;43.;41.;
    |] [|3;3|] in
    Arr.(y = z)

  let test_16 () =
    let s = [[];[];[]] in
    let y = Arr.get_slice_simple s x2 in
    Arr.(y = x2)

  let test_17 () =
    let s = [[0];[];[]] in
    let y = Arr.get_slice_simple s x2 in
    let z = Arr.sequential [|1;10;10|] in
    Arr.(y = z)

  let test_18 () =
    let s = [[1];[2];[]] in
    let y = Arr.get_slice_simple s x2 in
    let z = Arr.of_array [|120.;121.;122.;123.;124.;125.;126.;127.;128.;129.|] [|1;1;10|] in
    Arr.(y = z)

  let test_19 () =
    let s = [[0;5;3];[0;5;3];[0;2]] in
    let y = Arr.get_slice_simple s x2 in
    let z = Arr.of_array [|
        0.;  1.;  2.;
       30.; 31.; 32.;
      300.;301.;302.;
      330.;331.;332.;
    |] [|2;2;3|] in
    Arr.(y = z)

  let test_20 () =
    let s = [[1];[2];[3]] in
    let y = Arr.get_slice_simple s x2 in
    let z = Arr.of_array [|123.|] [|1;1;1|] in
    Arr.(y = z)

  let test_21 () =
    let s = [[-1;0];[-1;0];[-1;0]] in
    let y = Arr.get_slice_simple s x2 in
    let z = Arr.reverse x2 in
    Arr.(y = z)

  let test_22 () =
    let s = [[-1;0];[-1;0];[-1;0];[-1;0]] in
    let y = Arr.get_slice_simple s x3 in
    let z = Arr.reverse x3 in
    Arr.(y = z)

end


(* the tests *)

let test_01 () =
  Alcotest.(check bool) "test 01" true (To_test.test_01 ())

let test_02 () =
  Alcotest.(check bool) "test 02" true (To_test.test_02 ())

let test_03 () =
  Alcotest.(check bool) "test 03" true (To_test.test_03 ())

let test_04 () =
  Alcotest.(check bool) "test 04" true (To_test.test_04 ())

let test_05 () =
  Alcotest.(check bool) "test 05" true (To_test.test_05 ())

let test_06 () =
  Alcotest.(check bool) "test 06" true (To_test.test_06 ())

let test_07 () =
  Alcotest.(check bool) "test 07" true (To_test.test_07 ())

let test_08 () =
  Alcotest.(check bool) "test 08" true (To_test.test_08 ())

let test_09 () =
  Alcotest.(check bool) "test 09" true (To_test.test_09 ())

let test_10 () =
  Alcotest.(check bool) "test 10" true (To_test.test_10 ())

let test_11 () =
  Alcotest.(check bool) "test 11" true (To_test.test_11 ())

let test_12 () =
  Alcotest.(check bool) "test 12" true (To_test.test_12 ())

let test_13 () =
  Alcotest.(check bool) "test 13" true (To_test.test_13 ())

let test_14 () =
  Alcotest.(check bool) "test 14" true (To_test.test_14 ())

let test_15 () =
  Alcotest.(check bool) "test 15" true (To_test.test_15 ())

let test_16 () =
  Alcotest.(check bool) "test 16" true (To_test.test_16 ())

let test_17 () =
  Alcotest.(check bool) "test 17" true (To_test.test_17 ())

let test_18 () =
  Alcotest.(check bool) "test 18" true (To_test.test_18 ())

let test_19 () =
  Alcotest.(check bool) "test 19" true (To_test.test_19 ())

let test_20 () =
  Alcotest.(check bool) "test 20" true (To_test.test_20 ())

let test_21 () =
  Alcotest.(check bool) "test 21" true (To_test.test_21 ())

let test_22 () =
  Alcotest.(check bool) "test 22" true (To_test.test_22 ())

let test_set = [
  "test 01", `Slow, test_01;
  "test 02", `Slow, test_02;
  "test 03", `Slow, test_03;
  "test 04", `Slow, test_04;
  "test 05", `Slow, test_05;
  "test 06", `Slow, test_06;
  "test 07", `Slow, test_07;
  "test 08", `Slow, test_08;
  "test 09", `Slow, test_09;
  "test 10", `Slow, test_10;
  "test 11", `Slow, test_11;
  "test 12", `Slow, test_12;
  "test 13", `Slow, test_13;
  "test 14", `Slow, test_14;
  "test 15", `Slow, test_15;
  "test 16", `Slow, test_16;
  "test 17", `Slow, test_17;
  "test 18", `Slow, test_18;
  "test 19", `Slow, test_19;
  "test 20", `Slow, test_20;
  "test 21", `Slow, test_21;
  "test 22", `Slow, test_22;
]
