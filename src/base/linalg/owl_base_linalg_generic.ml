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
  if (Array.length dims) != 2
  then raise (Invalid_argument "The given NDarray is not a matrix!")
  else ()


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
      if ipiv.(j) != 1 then (
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
      if (ll != !icol) then (
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
    if (indxr.(l) != indxc.(l)) then (
      for k = 0 to n - 1 do
        let u = M.get a [|k; indxr.(l)|] in
        let v = M.get a [|k; indxc.(l)|] in
        M.set a [|k; indxc.(l)|] u;
        M.set a [|k; indxr.(l)|] v
      done
    )
  done;

  a, b


(* ends here *)
