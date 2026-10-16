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

let test_contract1 kind of_float () =
  let module N = Owl_dense_ndarray_generic in
  let values = Array.init 8 (fun i -> of_float (float_of_int (i + 1))) in
  let x = N.of_array kind values [| 2; 2; 2 |] in
  let y = N.contract1 [| 1, 2 |] x in
  Alcotest.(check (array int)) "remaining dimension" [| 2 |] (N.shape y);
  Alcotest.(check bool) "batched traces" true
    (N.to_array y = Array.map of_float [| 5.; 13. |])

let real x = x

let complex x = Complex.{ re = x; im = x }

let test_set =
  [ "test 00", `Slow, test_fun00; "test 01", `Slow, test_fun01
  ; "test 02", `Slow, test_fun02
  ; "contract float32", `Quick, test_contract1 Bigarray.float32 real
  ; "contract float64", `Quick, test_contract1 Bigarray.float64 real
  ; "contract complex32", `Quick, test_contract1 Bigarray.complex32 complex
  ; "contract complex64", `Quick, test_contract1 Bigarray.complex64 complex ]
