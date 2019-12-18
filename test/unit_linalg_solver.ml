open Owl_exception
module N = Owl_base_dense_ndarray.D
module M = Owl_base_dense_matrix_d
module L = Owl_base_linalg_generic

(* TODO: add complex input cases *)

(* define the test error *)

let approx_equal a b =
  let eps = 1e-5 in
  N.approx_equal ~eps a b


module To_test_gauss = struct
  let test01 () =
    let a = N.of_array [| 1.; 20.; -30.; 4. |] [| 2; 2 |] in
    let b = N.of_array [| 1.; 0.; 1.; 2.; -30.; 0.; 1.; 0.; 1.; 4. |] [| 2; 5 |] in
    let a_inv, x = L.linsolve_gauss a b in
    let flag01 = approx_equal (N.dot a a_inv) (M.eye 2) in
    let flag02 = approx_equal (N.dot a x) b in
    flag01 && flag02


  let test02 () =
    let a = N.of_array [| 2.; 3.; 3.; 5. |] [| 2; 2 |] in
    let b = N.of_array [| 1.; 0.; 1.; 0.; 1.; 0. |] [| 2; 3 |] in
    let a_inv, x = L.linsolve_gauss a b in
    let flag01 = approx_equal (N.dot a a_inv) (M.eye 2) in
    let flag02 = approx_equal (N.dot a x) b in
    flag01 && flag02


  let test03 () =
    let n = 20 in
    let a = N.uniform [| n; n |] in
    for i = 0 to n - 1 do
      let v = N.get a [| i; i |] in
      (* NOTE: this step limits datatype to float and double *)
      N.set a [| i; i |] ((v +. 0.1) *. 20.)
    done;
    let flag = ref true in
    for _ = 0 to 9 do
      let b = N.uniform [| n; 3 |] in
      let a_inv, x = L.linsolve_gauss a b in
      let flag01 = approx_equal (N.dot a a_inv) (M.eye n) in
      let flag02 = approx_equal (N.dot a x) b in
      flag := !flag && flag01 && flag02
    done;
    !flag


  let test04 () =
    let a =
      N.of_array
        [| 1.; 0.; 0.; 0.; 0.; 0.; 1.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.; 1.; 0.; 1.; 0.; 1.
         ; 1.; 0.; 0.; 0.; 1.; 0.; 1.; 1.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.; 1.; 0.; 1.; 1.
         ; 1.; 1.; 0.; 0.; 0.; 1.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.; 1.; 0.; 1.; 1.; 1.; 1.
         ; 0.; 0.; 0.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.
         ; 1. |]
        [| 9; 9 |]
    in
    let b = N.uniform [| 9; 1 |] in
    let flag = ref false in
    let _ =
      try L.linsolve_gauss a b |> ignore with
      | SINGULAR -> flag := true
    in
    !flag
end

module To_test_lu = struct
  (* Change the permutation index vector to matrix; perhaps should be included in main code. *)
  let perm_vec_to_mat vec =
    let n = Array.length vec in
    let mat = ref (M.eye n) in
    (* reverse the permutation order *)
    for i = n - 1 downto 0 do
      let j = vec.(i) in
      let a = M.eye n in
      N.set a [| i; i |] 0.;
      N.set a [| j; j |] 0.;
      N.set a [| i; j |] 1.;
      N.set a [| j; i |] 1.;
      mat := N.dot a !mat
    done;
    !mat


  (* Src: https://www.quantstart.com/articles/LU-Decomposition-in-Python-and-NumPy *)
  let test01 () =
    let x =
      N.of_array
        [| 7.; 3.; -1.; 2.; 3.; 8.; 1.; -4.; -1.; 1.; 4.; -1.; 2.; -4.; -1.; 6. |]
        [| 4; 4 |]
    in
    let l, u, p = L.lu x in
    let l_expected =
      N.of_array
        [| 1.0; 0.; 0.; 0.; 0.42857142857142855; 1.0; 0.0; 0.0; -0.14285714285714285
         ; 0.2127659574468085; 1.0; 0.0; 0.2857142857142857; -0.7234042553191489
         ; 0.0898203592814371; 1.0 |]
        [| 4; 4 |]
    in
    let u_expected =
      N.of_array
        [| 7.0; 3.0; -1.0; 2.0; 0.0; 6.714285714285714; 1.4285714285714286
         ; -4.857142857142857; 0.0; 0.0; 3.5531914893617023; 0.31914893617021267; 0.0; 0.0
         ; 0.0; 1.88622754491018 |]
        [| 4; 4 |]
    in
    let flag01 = approx_equal l l_expected in
    let flag02 = approx_equal u u_expected in
    let flag03 = p = [| 0; 1; 2; 3 |] in
    flag01 && flag02 && flag03


  let test02 () =
    let x = N.of_array [| 1.; 2.; 3.; 1.; 2.; 3.; 2.; 5.; 6. |] [| 3; 3 |] in
    let l, u, perm = L.lu x in
    let perm_mat = perm_vec_to_mat perm in
    let result = N.dot (N.dot perm_mat l) u in
    let flag = approx_equal result x in
    flag


  let test03 () =
    let n = 20 in
    let flag = ref true in
    for _ = 0 to 9 do
      let x = N.uniform [| n; n |] in
      let l, u, perm = L.lu x in
      let perm_mat = perm_vec_to_mat perm in
      let result = N.dot (N.dot perm_mat l) u in
      let f = approx_equal result x in
      flag := !flag && f
    done;
    !flag


  (*  LU-based linear solver *)

  let test04 () =
    let a = N.of_array [| 1.; 20.; -30.; 4. |] [| 2; 2 |] in
    let b = N.of_array [| 1.; 0.; 1.; 2.; -30.; 0.; 1.; 0.; 1.; 4. |] [| 2; 5 |] in
    let x = L.linsolve_lu a b in
    approx_equal (N.dot a x) b


  let test05 () =
    let a = N.of_array [| 2.; 3.; 3.; 5. |] [| 2; 2 |] in
    let b = N.of_array [| 1.; 0.; 1.; 0.; 1.; 0. |] [| 2; 3 |] in
    let x = L.linsolve_lu a b in
    approx_equal (N.dot a x) b


  let test06 () =
    let n = 20 in
    let a = N.uniform [| n; n |] in
    for i = 0 to n - 1 do
      let v = N.get a [| i; i |] in
      N.set a [| i; i |] ((v +. 0.1) *. 20.)
    done;
    let flag = ref true in
    for _ = 0 to 9 do
      let b = N.uniform [| n; 3 |] in
      let x = L.linsolve_lu a b in
      let f = approx_equal (N.dot a x) b in
      flag := !flag && f
    done;
    !flag


  let test07 () =
    let a =
      N.of_array
        [| 1.; 0.; 0.; 0.; 0.; 0.; 1.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.; 1.; 0.; 1.; 0.; 1.
         ; 1.; 0.; 0.; 0.; 1.; 0.; 1.; 1.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.; 1.; 0.; 1.; 1.
         ; 1.; 1.; 0.; 0.; 0.; 1.; 0.; 1.; 1.; 1.; 1.; 0.; 0.; 0.; 1.; 0.; 1.; 1.; 1.; 1.
         ; 0.; 0.; 0.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.; 1.
         ; 1. |]
        [| 9; 9 |]
    in
    let b = N.uniform [| 9; 1 |] in
    let flag = ref false in
    let _ =
      try L.linsolve_lu a b |> ignore with
      | SINGULAR -> flag := true
    in
    !flag


  (* LU-based det *)

  let test08 () =
    let a = N.of_array [| 1.; 2.; 3.; 4. |] [| 2; 2 |] in
    let det = L.det a in
    let result = N.of_array [| det |] [| 1 |] in
    let expect = N.of_array [| -2. |] [| 1 |] in
    approx_equal result expect


  let test09 () =
    let a = N.of_array [| 6.; 1.; 1.; 4.; -2.; 5.; 2.; 8.; 7. |] [| 3; 3 |] in
    let det = L.det a in
    let result = N.of_array [| det |] [| 1 |] in
    let expect = N.of_array [| -306. |] [| 1 |] in
    approx_equal result expect


  (* LU-based inv *)

  let test10 () =
    let n = 20 in
    let a = N.uniform [| n; n |] in
    for i = 0 to n - 1 do
      let v = N.get a [| i; i |] in
      N.set a [| i; i |] ((v +. 0.1) *. 20.)
    done;
    let flag = ref true in
    for _ = 0 to 9 do
      let a_inv = L.inv a in
      let f = approx_equal (N.dot a a_inv) (M.eye n) in
      flag := !flag && f
    done;
    !flag
end

module To_test_bandiag = struct
  let _test_tridiag n =
    (* TODO: we need a `to_array` in Owl_base_dense_ndarray module *)
    let a = N.uniform [| n |] in
    let trimat = N.zeros [| n; n |] in
    let a_vec = Array.make n 0. in
    for i = 1 to n - 1 do
      let v = N.get a [| i |] in
      a_vec.(i) <- v;
      N.set trimat [| i; i - 1 |] v
    done;
    let b = N.uniform [| n |] in
    let b_vec = Array.make n 0. in
    for i = 0 to n - 1 do
      let v = N.get b [| i |] in
      b_vec.(i) <- v;
      N.set trimat [| i; i |] v
    done;
    let c = N.uniform [| n |] in
    let c_vec = Array.make n 0. in
    for i = 0 to n - 2 do
      let v = N.get c [| i |] in
      c_vec.(i) <- v;
      N.set trimat [| i; i + 1 |] v
    done;
    let r = N.uniform [| n |] in
    let r_vec = Array.make n 0. in
    for i = 0 to n - 1 do
      r_vec.(i) <- N.get r [| i |]
    done;
    let x = L.tridiag_solve_vec a_vec b_vec c_vec r_vec in
    let x = N.of_array x [| n; 1 |] in
    let result = N.dot trimat x in
    approx_equal (N.reshape result [| n |]) r


  let test01 () =
    let n = 20 in
    let repeat = 10 in
    let flag = ref true in
    for _ = 0 to repeat - 1 do
      flag := !flag && _test_tridiag n
    done;
    !flag
end

let test_gauss_01 () =
  Alcotest.(check bool) "test_guass_01" true (To_test_gauss.test01 ())


let test_gauss_02 () =
  Alcotest.(check bool) "test_guass_02" true (To_test_gauss.test02 ())


let test_gauss_03 () =
  Alcotest.(check bool) "test_guass_03" true (To_test_gauss.test03 ())


let test_gauss_04 () =
  Alcotest.(check bool) "test_guass_04" true (To_test_gauss.test04 ())


let test_lu_01 () = Alcotest.(check bool) "test_lu_01" true (To_test_lu.test01 ())

let test_lu_02 () = Alcotest.(check bool) "test_lu_02" true (To_test_lu.test02 ())

let test_lu_03 () = Alcotest.(check bool) "test_lu_03" true (To_test_lu.test03 ())

let test_lu_04 () = Alcotest.(check bool) "test_lu_04" true (To_test_lu.test04 ())

let test_lu_05 () = Alcotest.(check bool) "test_lu_05" true (To_test_lu.test05 ())

let test_lu_06 () = Alcotest.(check bool) "test_lu_06" true (To_test_lu.test06 ())

let test_lu_07 () = Alcotest.(check bool) "test_lu_07" true (To_test_lu.test07 ())

let test_lu_08 () = Alcotest.(check bool) "test_lu_08" true (To_test_lu.test08 ())

let test_lu_09 () = Alcotest.(check bool) "test_lu_09" true (To_test_lu.test09 ())

let test_lu_10 () = Alcotest.(check bool) "test_lu_10" true (To_test_lu.test10 ())

let test_bandiag_01 () =
  Alcotest.(check bool) "To_test_bandiag_01" true (To_test_bandiag.test01 ())


let test_set =
  [ "test_gauss_01", `Slow, test_gauss_01; "test_gauss_02", `Slow, test_gauss_02
  ; "test_gauss_03", `Slow, test_gauss_03; "test_gauss_04", `Slow, test_gauss_04
  ; "test_lu_01", `Slow, test_lu_01; "test_lu_02", `Slow, test_lu_02
  ; "test_lu_03", `Slow, test_lu_03; "test_lu_04", `Slow, test_lu_04
  ; "test_lu_05", `Slow, test_lu_05; "test_lu_06", `Slow, test_lu_06
  ; "test_lu_08", `Slow, test_lu_08; "test_lu_09", `Slow, test_lu_09
  ; "test_lu_10", `Slow, test_lu_10
  ; (* "test_lu_07",    `Slow, test_lu_07;
   TODO: The singular matrix is not detected *)
    "test_bandiag_01", `Slow, test_bandiag_01 ]
