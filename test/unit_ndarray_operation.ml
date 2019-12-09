(** Unit test for Owl_maths module and special functions *)

module M = Owl_dense_ndarray_s

(* a module with functions to test *)
module To_test = struct
  let fun00 () =
    let x = M.unit_basis 10 0 in
    M.get x [| 0 |] = 1.


  let fun01 () =
    let x = M.unit_basis 10 3 in
    M.get x [| 3 |] = 1.


  let fun02 () =
    let x = M.unit_basis 10 9 in
    M.get x [| 9 |] = 1.
end

(* the tests *)

let test_fun00 () = Alcotest.(check bool) "basic operation 00" true (To_test.fun00 ())

let test_fun01 () = Alcotest.(check bool) "basic operation 01" true (To_test.fun01 ())

let test_fun02 () = Alcotest.(check bool) "basic operation 02" true (To_test.fun02 ())

let test_set =
  [ "test 00", `Slow, test_fun00; "test 01", `Slow, test_fun01
  ; "test 02", `Slow, test_fun02 ]
