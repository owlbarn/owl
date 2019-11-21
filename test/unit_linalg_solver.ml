open Owl
open Owl_exception

module N = Owl_base_dense_ndarray.D
module L = Owl_base_linalg_generic

(* define the test error *)

let approx_equal a b =
  let eps = 1e-5 in
  N.approx_equal ~eps a b


module To_test_gauss = struct

  let test01 () =
    let a = N.of_array [|1.;20.;-30.;4.|] [|2;2|] in
    let b = N.of_array [|1.;0.;1.;2.;-30.;0.;1.;0.; 1.;4.|] [|2; 5|]in
    let a_inv, x = L.linsolve_gauss a b in
    let flag01 = approx_equal (N.dot a a_inv) (N.eye 2) in
    let flag02 = approx_equal (N.dot a x) b in
    flag01 && flag02

  let test02 () =
    let a = N.of_array [|2.;3.;3.;5.|] [|2;2|] in
    let b = N.of_array [|1.;0.;1.;0.;1.;0.|] [|2; 3|]  in
    let a_inv, x = L.linsolve_gauss a b in
    let flag01 = approx_equal (N.dot a a_inv) (N.eye 2) in
    let flag02 = approx_equal (N.dot a x) b in
    flag01 && flag02

  let test03 () =
    let n = 20 in
    let a = N.uniform [|n; n|] in
    for i = 0 to n - 1 do
      let v = N.get a [|i; i|] in
      (* NOTE: this step limits datatype to float and double *)
      N.set a [|i; i|] ((v +. 0.1) *. 20.)
    done;
    let flag = ref true in
    for i = 0 to 9 do
      let b = N.uniform [|n; 3|] in
      let a_inv, x = L.linsolve_gauss a b in
      let flag01 = approx_equal (N.dot a a_inv) (N.eye n) in
      let flag02 = approx_equal (N.dot a x) b in
      flag := !flag && flag01 && flag02
    done;
    !flag

  let test04 () =
    let a = N.of_array [|
      1.; 0.; 0.; 0.; 0.; 0.; 1.; 0.; 1.;
      1.; 1.; 1.; 0.; 0.; 0.; 1.; 0.; 1.;
      0.; 1.; 1.; 0.; 0.; 0.; 1.; 0.; 1.;
      1.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.;
      1.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.;
      1.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.;
      1.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.;
      1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.;
      1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.;
    |] [|9; 9|] in
  let b = N.uniform [|9; 1|] in
  let flag = ref false in
  let _ = try
    L.linsolve_gauss a b |> ignore
  with SINGULAR ->
    flag := true
  in
  !flag

end


module To_test_lu = struct

  (* change the permutation index vector to matrix; perhaps should be included in main code. *)
  let perm_vec_to_mat vec =
    let n = Array.length vec in
    let mat = ref (N.eye n) in
    (* reverse the permutation order *)
    for i = n - 1 downto 0 do
      let j = vec.(i) in
      let a = N.eye n in
      N.set a [|i; i|] 0.;
      N.set a [|j; j|] 0.;
      N.set a [|i; j|] 1.;
      N.set a [|j; i|] 1.;
      mat := N.dot a !mat
    done;
    !mat


  (* Src: https://www.quantstart.com/articles/LU-Decomposition-in-Python-and-NumPy *)
  let test01 () =
    let x = N.of_array [|7.;3.;-1.;2.;3.;8.;1.;-4.;-1.;1.;4.;-1.;2.;-4.;-1.;6.|] [|4;4|] in
    let l, u, p = L.lu x in
    let l_expected = N.of_array
      [|1.0; 0.; 0.; 0.; 0.42857142857142855; 1.0; 0.0; 0.0;
      -0.14285714285714285; 0.2127659574468085; 1.0; 0.0; 0.2857142857142857;
      -0.7234042553191489; 0.0898203592814371; 1.0|] [|4;4|]
    in
    let u_expected = N.of_array
      [|7.0; 3.0; -1.0; 2.0; 0.0; 6.714285714285714; 1.4285714285714286;
       -4.857142857142857; 0.0; 0.0; 3.5531914893617023; 0.31914893617021267;
       0.0; 0.0; 0.0; 1.88622754491018|] [|4;4|]
    in
    let flag01 = approx_equal l l_expected in
    let flag02 = approx_equal u u_expected in
    let flag03 = p = [|0;1;2;3|] in
    flag01 && flag02 && flag03


  let test02 () =
    let x = N.of_array [|1.;2.;3.;1.;2.;3.;2.;5.;6.|] [|3;3|] in
    let l, u, perm = L.lu x in
    let perm_mat = perm_vec_to_mat perm in
    let result = N.dot (N.dot perm_mat l) u in
    let flag = approx_equal result x in
    flag


  let test03 () =
    let n = 20 in
    let flag = ref true in
    for i = 0 to 9 do
      let x = N.uniform [|n; n|] in
      let l, u, perm = L.lu x in
      let perm_mat = perm_vec_to_mat perm in
      let result = N.dot (N.dot perm_mat l) u in
      let f = approx_equal result x in
      flag := !flag && f
    done;
    !flag

  let test01 () =
    let a = N.of_array [|1.;20.;-30.;4.|] [|2;2|] in
    let b = N.of_array [|1.;0.|] [|2|]in
    let x = L.lu_solve_vec a b in
    approx_equal (N.dot a x) b

end


let test_gauss_01 () =
  Alcotest.(check bool) "test_guass_01" true (To_test_gauss.test01 ())

let test_gauss_02 () =
  Alcotest.(check bool) "test_guass_02" true (To_test_gauss.test02 ())

let test_gauss_03 () =
  Alcotest.(check bool) "test_guass_03" true (To_test_gauss.test03 ())

let test_gauss_04 () =
  Alcotest.(check bool) "test_guass_04" true (To_test_gauss.test04 ())

let test_lu_01 () =
  Alcotest.(check bool) "test_lu_01" true (To_test_lu.test01 ())

let test_lu_02 () =
  Alcotest.(check bool) "test_lu_02" true (To_test_lu.test02 ())

let test_lu_03 () =
  Alcotest.(check bool) "test_lu_03" true (To_test_lu.test03 ())


let test_set = [
  "test_gauss_01", `Slow, test_gauss_01;
  "test_gauss_02", `Slow, test_gauss_02;
  "test_gauss_03", `Slow, test_gauss_03;
  "test_gauss_04", `Slow, test_gauss_04;
  "test_lu_01",    `Slow, test_lu_01;
  "test_lu_02",    `Slow, test_lu_02;
  "test_lu_03",    `Slow, test_lu_03;
]
