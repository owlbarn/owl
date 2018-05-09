(** Unit test for Owl_base_complex module *)

module M = Owl_base_complex


(* define the test error *)
let eps = 1e-10

let approx_equal a b =
  Complex.((abs_float (a.re -. b.re) < eps) && (abs_float (a.im -. b.im) < eps))


(* a module with functions to test *)
module To_test = struct

  let test_add () =
    let x = M.complex 1. 2. in
    let y = M.complex 2. 3. in
    let z = M.complex 3. 5. in
    approx_equal (M.add x y) z

  let test_sub () =
    let x = M.complex 3. 4. in
    let y = M.complex 2. 3. in
    let z = M.complex 1. 1. in
    approx_equal (M.sub x y) z

  (* TODO: add more tests *)

end


(* the tests *)

let test_add () =
  Alcotest.(check bool) "test add" true (To_test.test_add ())

let test_sub () =
  Alcotest.(check bool) "test sub" true (To_test.test_sub ())

let test_set = [
  "test add", `Slow, test_add;
  "test sub", `Slow, test_sub;
]
