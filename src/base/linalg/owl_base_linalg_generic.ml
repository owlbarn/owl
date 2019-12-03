(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type ('a, 'b) t = ('a, 'b) Owl_base_dense_ndarray_generic.t

module M = Owl_base_dense_ndarray_generic


(* Check matrix properties *)

let is_triu x =
  let shp = M.shape x in
  let m, n = shp.(0), shp.(1) in
  let k = Stdlib.min m n in
  let _a0 = Owl_const.zero (M.kind x) in
  try
    for i = 0 to k - 1 do
      for j = 0 to i - 1 do
        assert (M.get x [|i; j|] = _a0)
      done
    done;
    true
  with _exn -> false


let is_tril x =
  let shp = M.shape x in
  let m, n = shp.(0), shp.(1) in
  let k = Stdlib.min m n in
  let _a0 = Owl_const.zero (M.kind x) in
  try
    for i = 0 to k - 1 do
      for j = i + 1 to k - 1 do
        assert (M.get x [|i; j|] = _a0)
      done
    done;
    true
  with _exn -> false


let is_symmetric x =
  let shp = M.shape x in
  let m, n = shp.(0), shp.(1) in
  if m <> n then false
  else (
    try
      for i = 0 to n - 1 do
        for j = i + 1 to n - 1 do
          let a = M.get x [|j; i|] in
          let b = M.get x [|i; j|] in
          assert (a = b)
        done
      done;
      true
    with _exn -> false
  )


let is_hermitian x =
  let shp = M.shape x in
  let m, n = shp.(0), shp.(1) in
  if m <> n then false
  else (
    try
      for i = 0 to n - 1 do
        for j = i to n - 1 do
          let a = M.get x [|j; i|] in
          let b = Complex.conj (M.get x [|i; j|]) in
          assert (a = b)
        done
      done;
      true
    with _exn -> false
  )


let is_diag x = is_triu x && is_tril x


let _check_is_matrix dims =
  if (Array.length dims) <> 2
  then raise (Invalid_argument "The given NDarray is not a matrix!")
  else ()


(* ======= WARNING: the linalg functions below are experimental. ======= *)
(* ========= Corner cases etc. are not sufficiently tested. ============ *)

(* Linear equation solution by Gauss-Jordan elimination.
 * Input matrix: a[n][n], b[n][m];
 * Output: ``ainv``, inversed matrix of a; ``x``, so that ax = b.
 * TODO: Extend to multiple types: double, complex; unify with existing owl
 * structures e.g. naming.
 * Test: https://github.com/scipy/scipy/blob/master/scipy/linalg/tests/test_basic.py#L496 *)
let linsolve_gauss a b =
  let (dims_a, dims_b) = (M.shape a, M.shape b) in
  let (_, _) = (_check_is_matrix dims_a, _check_is_matrix dims_b) in

  let a = M.copy a in
  let b = M.copy b in

  let n = dims_a.(0) in
  let m = dims_b.(1) in
  let icol = ref 0 in
  let irow = ref 0 in
  let dum  = ref 0.0 in
  let pivinv = ref 0.0 in
  let indxc = Array.make n 0 in
  let indxr = Array.make n 0 in
  let ipiv  = Array.make n 0 in

  (* Main loop over the columns to be reduced. *)
  for i = 0 to n - 1  do
    let big = ref 0.0 in
    (* Outer loop of the search for at pivot element *)
    for j = 0 to n - 1 do
      if ipiv.(j) <> 1 then (
        for k = 0 to n - 1 do
          if ipiv.(k) == 0 then (
            let v = M.get a [|j; k|] |> abs_float in
            if (v >= !big) then (
              big := v;
              irow := j; icol := k;
            )
          )
        done
      )
    done;
    ipiv.(!icol) <- ipiv.(!icol) + 1;

    if (!irow <> !icol) then (
      for l = 0 to n - 1 do
        let u = M.get a [|!irow; l|] in
        let v = M.get a [|!icol; l|] in
        M.set a [|!icol; l|] u;
        M.set a [|!irow; l|] v
      done;

      for l = 0 to m - 1 do
        let u = M.get b [|!irow; l|] in
        let v = M.get b [|!icol; l|] in
        M.set b [|!icol; l|] u;
        M.set b [|!irow; l|] v
      done
    );

    indxr.(i) <- !irow;
    indxc.(i) <- !icol;
    let p = M.get a [|!icol; !icol|] in
    if (p = 0.0) then raise Owl_exception.SINGULAR;
    pivinv :=  1.0 /. p;
    M.set a [|!icol; !icol|] 1.0;
    for l = 0 to n - 1 do
      let prev = M.get a [|!icol; l|] in
      M.set a [|!icol; l|] (prev *. !pivinv)
    done;
    for l = 0 to m - 1 do
      let prev = M.get b [|!icol; l|] in
      M.set b [|!icol; l|] (prev *. !pivinv)
    done;

    for ll = 0 to n - 1 do
      if (ll <> !icol) then (
        dum := M.get a [|ll; !icol|];
        M.set a [|ll; !icol|] 0.0;
        for l = 0 to n - 1 do
          let p = M.get a [|!icol; l|] in
          let prev = M.get a [|ll; l|] in
          M.set a [|ll; l|] (prev -. p *. !dum)
        done;
        for l = 0 to m - 1 do
          let p = M.get b [|!icol; l|] in
          let prev = M.get b [|ll; l|] in
          M.set b [|ll; l|] (prev -. p *. !dum)
        done
      )
    done

  done;

  for l = n - 1 downto 0 do
    if (indxr.(l) <> indxc.(l)) then (
      for k = 0 to n - 1 do
        let u = M.get a [|k; indxr.(l)|] in
        let v = M.get a [|k; indxc.(l)|] in
        M.set a [|k; indxc.(l)|] u;
        M.set a [|k; indxr.(l)|] v
      done
    )
  done;

  a, b



(* LU decomposition.
 * Input matrix: a[n][n]; return L/U in one matrix, and the row permutation vector.
 * Test: https://github.com/scipy/scipy/blob/master/scipy/linalg/tests/test_decomp.py
 *)
let _lu_base a =
  let lu = M.copy a in
  let n = (M.shape a).(0) in
  let m = (M.shape a).(1) in
  assert (n = m);
  let indx = Array.make n 0 in
  (* implicit scaling of each row *)
  let vv = Array.make n 0. in
  let tiny = 1.0e-40 in
  let big = ref 0. in
  let temp = ref 0. in
  (* flag of row exchange *)
  let d = ref 1.0 in
  let imax = ref 0 in
  (* loop over rows to get the implicit scaling information *)
  for i = 0 to n - 1 do
    big := 0.;
    for j = 0 to n - 1 do
      temp := M.get lu [| i; j |] |> abs_float;
      if !temp > !big then big := !temp
    done;
    if !big = 0. then raise Owl_exception.SINGULAR;
    vv.(i) <- 1.0 /. !big
  done;
  for k = 0 to n - 1 do
    big := 0.;
    (* choose suitable pivot *)
    for i = k to n - 1 do
      temp := (M.get lu [| i; k |] |> abs_float) *. vv.(i);
      if !temp > !big
      then (
        big := !temp;
        imax := i)
    done;
    (* interchange rows *)
    if k <> !imax
    then (
      for j = 0 to n - 1 do
        temp := M.get lu [| !imax; j |];
        let tmp = M.get lu [| k; j |] in
        M.set lu [| !imax; j |] tmp;
        M.set lu [| k; j |] !temp
      done;
      d := !d *. -1.;
      vv.(!imax) <- vv.(k));
    indx.(k) <- !imax;
    if M.get lu [| k; k |] = 0. then M.set lu [| k; k |] tiny;
    for i = k + 1 to n - 1 do
      let tmp0 = M.get lu [| i; k |] in
      let tmp1 = M.get lu [| k; k |] in
      temp := tmp0 /. tmp1;
      M.set lu [| i; k |] !temp;
      for j = k + 1 to n - 1 do
        let prev = M.get lu [| i; j |] in
        M.set lu [| i; j |] (prev -. (!temp *. M.get lu [| k; j |]))
      done
    done
  done;
  lu, indx, !d


(* LU decomposition, return L, U, and permutation vector *)
let lu a =
  let k = M.kind a in
  let lu, indx, _ = _lu_base a in
  let n = (M.shape lu).(0) in
  let m = (M.shape lu).(1) in
  assert (n = m && n >= 2);
  let l = M.eye k n in
  for r = 1 to n - 1 do
    for c = 0 to r - 1 do
      let v = M.get lu [| r; c |] in
      M.set l [| r; c |] v;
      M.set lu [| r; c |] 0.
    done
  done;
  l, lu, indx


let _lu_solve_vec a b =
  assert (Array.length (M.shape b) = 1);
  let n = (M.shape a).(0) in
  if (M.shape b).(0) <> n then failwith "LUdcmp::solve bad sizes";
  let ii = ref 0 in
  let sum = ref 0. in
  let x = M.copy b in
  let lu, indx, _ = _lu_base a in
  for i = 0 to n - 1 do
    let ip = indx.(i) in
    sum := M.get x [| ip |];
    M.set x [| ip |] (M.get x [| i |]);
    if !ii <> 0
    then
      for j = !ii - 1 to i - 1 do
        sum := !sum -. (M.get lu [| i; j |] *. M.get x [| j |])
      done
    else if !sum <> 0.
    then ii := !ii + 1;
    M.set x [| i |] !sum
  done;
  for i = n - 1 downto 0 do
    sum := M.get x [| i |];
    for j = i + 1 to n - 1 do
      sum := !sum -. (M.get lu [| i; j |] *. M.get x [| j |])
    done;
    M.set x [| i |] (!sum /. M.get lu [| i; i |])
  done;
  x


(* Linear equation solution by LU decomposition.
 * Input matrix: a[n][n], b[n][m];
 * Output: ``x``, so that ax = b. *)
let linsolve_lu a b =
  let dims_a, dims_b = M.shape a, M.shape b in
  let _, _ = _check_is_matrix dims_a, _check_is_matrix dims_b in
  assert (dims_a.(0) = dims_a.(1));
  let m = dims_b.(1) in
  let b = M.copy b in
  for j = 0 to m - 1 do
    let vec = M.get_slice [ []; [ j ] ] b |> M.flatten in
    let x = _lu_solve_vec a vec in
    M.set_slice [ []; [ j ] ] b x
  done;
  b


(* Matrix inverse *)
let inv a =
  let dims_a = M.shape a in
  _check_is_matrix dims_a |> ignore;
  assert (dims_a.(0) = dims_a.(1));
  let n = dims_a.(0) in
  let b = M.eye (M.kind a) n in
  linsolve_lu a b


(* Determinant of matrix a *)
let det a =
  let dims_a = M.shape a in
  _check_is_matrix dims_a |> ignore;
  assert (dims_a.(0) = dims_a.(1));
  let n = dims_a.(0) in
  let lu, _, sign = _lu_base a in
  let big = ref sign in
  for i = 0 to n - 1 do
    big := !big *. M.get lu [| i; i |]
  done;
  !big


(* Solver for tridiagonal matrix
 * Input: a[n], b[n], c[n], which together consit the tridiagonal matrix A, and the right side vector r[n]. Return: x[n].
 *)

let tridiag_solve_vec a b c r =
  let n = Array.length a in
  let n1 = Array.length b in
  let n2 = Array.length c in
  assert (n = n1 && n = n2);
  if b.(0) = 0.
  then raise (Invalid_argument 
    "tridiag_solve_vec: 0 at the beginning of diagonal vector");
  let bet = ref b.(0) in
  let gam = Array.make n 0. in
  let x = Array.make n 0. in
  x.(0) <- r.(0) /. !bet;
  for j = 1 to n - 1 do
    gam.(j) <- c.(j - 1) /. !bet;
    bet := b.(j) -. (a.(j) *. gam.(j));
    if !bet = 0.
    then raise (Invalid_argument "tridiag_solve_vec: algorithm fails");
    x.(j) <- (r.(j) -. (a.(j) *. x.(j - 1))) /. !bet
  done;
  for j = n - 2 downto 0 do
    x.(j) <- x.(j) -. (gam.(j + 1) *. x.(j + 1))
  done;
  x

(* ends here *)
