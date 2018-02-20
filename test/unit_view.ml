(** Unit test for Owl_view module *)

module N = Owl.Arr

module V = Owl_view.Make (N)


(* some test input *)

let x0 = N.sequential [|10|] |> V.of_arr

let x1 = N.sequential [|10;10|] |> V.of_arr

let x2 = N.sequential [|10;10;10|] |> V.of_arr

let x3 = N.sequential [|5;5;5;5|] |> V.of_arr


(* a module with functions to test *)
module To_test = struct

  let test_01 () =
    let s = [[]] in
    let y = V.get_slice s x0 in
    V.equal y x0

  let test_02 () =
    let s = [[3]] in
    let y = V.get_slice s x0 in
    let z = N.of_array [|3.|] [|1|] in
    V.equal y (V.of_arr z)

  let test_03 () =
    let s = [[2;5]] in
    let y = V.get_slice s x0 in
    let z = N.of_array [|2.;3.;4.;5.|] [|4|] in
    V.equal y (V.of_arr z)

  let test_04 () =
    let s = [[2;-1;3]] in
    let y = V.get_slice s x0 in
    let z = N.of_array [|2.;5.;8.|] [|3|] in
    V.equal y (V.of_arr z)

  let test_05 () =
    let s = [[-2;5]] in
    let y = V.get_slice s x0 in
    let z = N.of_array [|8.;7.;6.;5.|] [|4|] in
    V.equal y (V.of_arr z)

  let test_06 () =
    let s = [[-2;4;-2]] in
    let y = V.get_slice s x0 in
    let z = N.of_array [|8.;6.;4.|] [|3|] in
    V.equal y (V.of_arr z)

  let test_07 () =
    let s = [[];[]] in
    let y = V.get_slice s x1 in
    V.equal y x1

  let test_08 () =
    let s = [[2];[]] in
    let y = V.get_slice s x1 in
    let z = N.of_array [|20.;21.;22.;23.;24.;25.;26.;27.;28.;29.|] [|1;10|] in
    V.equal y (V.of_arr z)

  let test_09 () =
    let s = [[0;5];[]] in
    let y = V.get_slice s x1 in
    let z = N.sequential [|6;10|] in
    V.equal y (V.of_arr z)

  let test_10 () =
    let s = [[0;5;2];[]] in
    let y = V.get_slice s x1 in
    let z = N.of_array [|
        0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.;
        20.;21.;22.;23.;24.;25.;26.;27.;28.;29.;
        40.;41.;42.;43.;44.;45.;46.;47.;48.;49.;
      |] [|3;10|] in
    V.equal y (V.of_arr z)

  let test_11 () =
    let s = [[5;0;-2];[]] in
    let y = V.get_slice s x1 in
    let z = N.of_array [|
        50.;51.;52.;53.;54.;55.;56.;57.;58.;59.;
        30.;31.;32.;33.;34.;35.;36.;37.;38.;39.;
        10.;11.;12.;13.;14.;15.;16.;17.;18.;19.;
      |] [|3;10|] in
    V.equal y (V.of_arr z)

  let test_12 () =
    let s = [[0;5;2];[1;5]] in
    let y = V.get_slice s x1 in
    let z = N.of_array [|
        1.; 2.; 3.; 4.; 5.;
        21.;22.;23.;24.;25.;
        41.;42.;43.;44.;45.;
      |] [|3;5|] in
    V.equal y (V.of_arr z)

  let test_13 () =
    let s = [[0;5;2];[1;5;3]] in
    let y = V.get_slice s x1 in
    let z = N.of_array [|
        1.; 4.;
        21.;24.;
        41.;44.;
      |] [|3;2|] in
    V.equal y (V.of_arr z)

  let test_14 () =
    let s = [[0;5;2];[-5;1]] in
    let y = V.get_slice s x1 in
    let z = N.of_array [|
        5.; 4.; 3.; 2.; 1.;
        25.;24.;23.;22.;21.;
        45.;44.;43.;42.;41.;
      |] [|3;5|] in
    V.equal y (V.of_arr z)

  let test_15 () =
    let s = [[0;5;2];[-5;1;-2]] in
    let y = V.get_slice s x1 in
    let z = N.of_array [|
        5.; 3.; 1.;
        25.;23.;21.;
        45.;43.;41.;
      |] [|3;3|] in
    V.equal y (V.of_arr z)

  let test_16 () =
    let s = [[];[];[]] in
    let y = V.get_slice s x2 in
    V.equal y x2

  let test_17 () =
    let s = [[0];[];[]] in
    let y = V.get_slice s x2 in
    let z = N.sequential [|1;10;10|] in
    V.equal y (V.of_arr z)

  let test_18 () =
    let s = [[1];[2];[]] in
    let y = V.get_slice s x2 in
    let z = N.of_array [|120.;121.;122.;123.;124.;125.;126.;127.;128.;129.|] [|1;1;10|] in
    V.equal y (V.of_arr z)

  let test_19 () =
    let s = [[0;5;3];[0;5;3];[0;2]] in
    let y = V.get_slice s x2 in
    let z = N.of_array [|
        0.;  1.;  2.;
        30.; 31.; 32.;
        300.;301.;302.;
        330.;331.;332.;
      |] [|2;2;3|] in
    V.equal y (V.of_arr z)

  let test_20 () =
    let s = [[1];[2];[3]] in
    let y = V.get_slice s x2 in
    let z = N.of_array [|123.|] [|1;1;1|] in
    V.equal y (V.of_arr z)

  let test_21 () =
    let s = [[-1;0];[-1;0];[-1;0]] in
    let y = V.get_slice s x2 in
    let z = N.reverse (V.to_arr x2) in
    V.equal y (V.of_arr z)

  let test_22 () =
    let s = [[-1;0];[-1;0];[-1;0];[-1;0]] in
    let y = V.get_slice s x3 in
    let z = N.reverse (V.to_arr x3) in
    V.equal y (V.of_arr z)

  let test_23 () =
    let s = [[0;2]] in
    let x = V.to_arr x0 |> V.of_arr in
    let y = N.of_array [|2.;3.;5.|] [|3|] in
    V.set_slice s x (V.of_arr y);
    let z = N.of_array [|2.;3.;5.;3.;4.;5.;6.;7.;8.;9.|] [|10|] in
    V.equal x (V.of_arr z)

  let test_24 () =
    let s = [[5;3]] in
    let x = V.to_arr x0 |> V.of_arr in
    let y = N.of_array [|2.;3.;5.|] [|3|] in
    V.set_slice s x (V.of_arr y);
    let z = N.of_array [|0.;1.;2.;5.;3.;2.;6.;7.;8.;9.|] [|10|] in
    V.equal x (V.of_arr z)

  let test_25 () =
    let s = [[2;8;3]] in
    let x = V.to_arr x0 |> V.of_arr in
    let y = N.of_array [|2.;3.;5.|] [|3|] in
    V.set_slice s x (V.of_arr y);
    let z = N.of_array [|0.;1.;2.;3.;4.;3.;6.;7.;5.;9.|] [|10|] in
    V.equal x (V.of_arr z)

  let test_26 () =
    let s = [[-1];[-1]] in
    let x = V.to_arr x1 |> V.of_arr in
    let y = N.of_array [|0.|] [|1;1|] in
    V.set_slice s x (V.of_arr y);
    let z = V.to_arr x1 in
    N.set z [|9;9|] 0.;
    V.equal x (V.of_arr z)

  let test_27 () =
    let s = [[0;9;9];[0;9;9]] in
    let x = V.to_arr x1 |> V.of_arr in
    let y = N.of_array [|5.;6.;7.;8.;|] [|2;2|] in
    V.set_slice s x (V.of_arr y);
    let z = V.to_arr x1 in
    N.set z [|0;0|] 5.;
    N.set z [|0;9|] 6.;
    N.set z [|9;0|] 7.;
    N.set z [|9;9|] 8.;
    V.equal x (V.of_arr z)

  let test_28 () =
    let s = [[-1;0;-9];[-1;0;-9]] in
    let x = V.to_arr x1 |> V.of_arr in
    let y = N.of_array [|5.;6.;7.;8.;|] [|2;2|] in
    V.set_slice s x (V.of_arr y);
    let z = V.to_arr x1 in
    N.set z [|0;0|] 8.;
    N.set z [|0;9|] 7.;
    N.set z [|9;0|] 6.;
    N.set z [|9;9|] 5.;
    V.equal x (V.of_arr z)

  let test_29 () =
    let s = [[-1];[-1];[-2]] in
    let x = V.to_arr x2 |> V.of_arr in
    let y = N.of_array [|5.|] [|1;1;1|] in
    V.set_slice s x (V.of_arr y);
    let z = V.to_arr x2 in
    N.set z [|9;9;8|] 5.;
    V.equal x (V.of_arr z)

  let test_30 () =
    let s = [[-1];[5;6];[0]] in
    let x = V.to_arr x2 |> V.of_arr in
    let y = N.of_array [|1.;2.|] [|1;2;1|] in
    V.set_slice s x (V.of_arr y);
    let z = V.to_arr x2 in
    N.set z [|9;5;0|] 1.;
    N.set z [|9;6;0|] 2.;
    V.equal x (V.of_arr z)

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

let test_23 () =
  Alcotest.(check bool) "test 23" true (To_test.test_23 ())

let test_24 () =
  Alcotest.(check bool) "test 24" true (To_test.test_24 ())

let test_25 () =
  Alcotest.(check bool) "test 25" true (To_test.test_25 ())

let test_26 () =
  Alcotest.(check bool) "test 26" true (To_test.test_26 ())

let test_27 () =
  Alcotest.(check bool) "test 27" true (To_test.test_27 ())

let test_28 () =
  Alcotest.(check bool) "test 28" true (To_test.test_28 ())

let test_29 () =
  Alcotest.(check bool) "test 29" true (To_test.test_29 ())

let test_30 () =
  Alcotest.(check bool) "test 30" true (To_test.test_30 ())

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
  "test 23", `Slow, test_23;
  "test 24", `Slow, test_24;
  "test 25", `Slow, test_25;
  "test 26", `Slow, test_26;
  "test 27", `Slow, test_27;
  "test 28", `Slow, test_28;
  "test 29", `Slow, test_29;
  "test 30", `Slow, test_30;
]
