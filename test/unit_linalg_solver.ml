open Owl

module N = Owl_base_dense_ndarray.S
module L = Owl_base_linalg_generic

(* define the test error *)

let approx_equal a b =
  let eps = 1e-6 in
  Stdlib.(abs_float (a -. b) < eps)


module To_test_gauss = struct

  let test01 () =
    let a = N.of_array [|1.;20.;-30.;4.|] [|2;2|] in
    let b = N.of_array [|1.;0.;0.;1.;1.;0.;2.;1.; -30.;4.|] [|5;2|] in
    let a_inv, x = L.linsolv_gauss a b in
    let flag01 = approx_equal N.(((dot a a_inv) - N.eye 2 |> sum')) 0. in
    let flag02 = approx_equal N.(((dot a x) - b) |> sum') 0. in
    flag01 && flag02

end


let test_gauss_01 () =
  Alcotest.(check bool) "test_guass_01" true (To_test_gauss.test01 ())


let test_set = [
  "test_gauss_01", `Slow, test_gauss_01
]

(*
Alcotest.run "Owl" [
  "base: linalg", test_set
]
*)
