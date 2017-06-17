(** Unit test for Algodiff module *)

open Owl.Algodiff.D

let approx_equal a b = Pervasives.abs_float (a -. b) < 1e-10

(* a module with functions to test *)
module To_test = struct

  let dumb () = true

  let sin1 x = x |> diff Maths.sin |> unpack_flt

  let sin2 x = x |> diff (diff Maths.sin) |> unpack_flt

  let sin3 x = x |> diff (diff (diff Maths.sin)) |> unpack_flt

  (* define a new function to test *)
  let pfuna x = Maths.((F 2.) * (x * x * x) + (F 3.) * (x * x) - (F 5.) * x + (F 1.))

  let poly1 x = x |> diff pfuna |> unpack_flt

  let poly2 x = x |> diff (diff pfuna) |> unpack_flt

  let poly3 x = x |> diff (diff (diff pfuna)) |> unpack_flt

  (* define a new function to test *)
  let pfunb x = Maths.((F 2.) * x * x + (F 3.) * sin x - (F 1. / x))

  let poly4 x = x |> diff pfunb |> unpack_flt

  let poly5 x = x |> diff (diff pfunb) |> unpack_flt

  let poly6 x = x |> diff (diff (diff pfunb)) |> unpack_flt

  (* define a new function to test *)
  let pfunc x = Maths.(F 2. * sqr x + sqrt x - tanh x)

  let poly7 x = x |> diff pfunc |> unpack_flt

  let poly8 x = x |> diff (diff pfunc) |> unpack_flt

  let poly9 x = x |> diff (diff (diff pfunc)) |> unpack_flt |> approx_equal 0.00636573616030225702


end

(* the tests *)

let dumb () =
  Alcotest.(check bool) "dumb" true (To_test.dumb ())

let sin1 () =
  Alcotest.(check float) "sin1" (cos 1.) (To_test.sin1 (F 1.))

let sin2 () =
  Alcotest.(check float) "sin2" (-.(sin 1.)) (To_test.sin2 (F 1.))

let sin3 () =
  Alcotest.(check float) "sin3" (-.(cos 1.)) (To_test.sin3 (F 1.))

let poly1 () =
  Alcotest.(check float) "poly1" 31. (To_test.poly1 (F 2.))

let poly2 () =
  Alcotest.(check float) "poly2" 30. (To_test.poly2 (F 2.))

let poly3 () =
  Alcotest.(check float) "poly3" 12. (To_test.poly3 (F 2.))

let poly4 () =
  Alcotest.(check float) "poly4" (12. +. 3. *. cos 3. +. 1. /. 9.) (To_test.poly4 (F 3.))

let poly5 () =
  Alcotest.(check float) "poly5" (4. -. 3. *. sin 3. -. 2. /. 27.) (To_test.poly5 (F 3.))

let poly6 () =
  Alcotest.(check float) "poly6" (-3. *. cos 3. +. 6. /. 81.) (To_test.poly6 (F 3.))

let poly7 () =
  Alcotest.(check float) "poly7" (16. +. 0.25 -. (Owl.Maths.sech 4.) ** 2.) (To_test.poly7 (F 4.))

let poly8 () =
  Alcotest.(check float) "poly8" (-0.25 /. (4. ** 1.5) +. 2. *. (Owl.Maths.tanh 4.) *. ((Owl.Maths.sech 4.) ** 2.) +. 4.) (To_test.poly8 (F 4.))

let poly9 () =
  Alcotest.(check bool) "poly9" true (To_test.poly9 (F 4.))

let test_set = [
  "dumb", `Slow, dumb;
  "sin1", `Slow, sin1;
  "sin2", `Slow, sin2;
  "sin3", `Slow, sin3;
  "poly1", `Slow, poly1;
  "poly2", `Slow, poly2;
  "poly3", `Slow, poly3;
  "poly4", `Slow, poly4;
  "poly5", `Slow, poly5;
  "poly6", `Slow, poly6;
  "poly7", `Slow, poly7;
  "poly8", `Slow, poly8;
  "poly9", `Slow, poly9;
]
