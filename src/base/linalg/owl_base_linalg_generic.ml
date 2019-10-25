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

(* let _swap a ia ja b ib jb =
  let u = M.get a [|ia; ja|] in
  let v = M.get b [|ib; jb|] in
  M.set b [|ib; jb|] u;
  M.set a [ia; ja|] v
*)

(* Linear equation solution by Gauss-Jordan elimination *)
let gaussj a b =
  (*TODO: shape check *)
  let a = M.copy a in
  let b = M.copy b in

  let n = (M.shape a).(0) in
  let m = (M.shape b).(1) in
  let icol = ref 0 in
  let irow = ref 0 in
  let dum = ref 0.0 in
  let pivinv = ref 0.0 in
  let indxc = Array.make n 0 in
  let indxr = Array.make n 0 in
  let ipiv  = Array.make n 0 in
  for i = 0 to n - 1  do
    let big = ref 0.0 in
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

    (* TODO: how to swap elegantly? *)
    if (!irow != !icol) then (
      for l = 0 to n - 1 do
        let u = M.get a [|!irow; l|] in
        let v = M.get a [|!icol; l|] in
        M.set a [|!icol; l|] u;
        M.set a [|!irow; l|] v
      done;

      for l = 0 to n - 1 do
        let u = M.get b [|!irow; l|] in
        let v = M.get b [|!icol; l|] in
        M.set b [|!icol; l|] u;
        M.set b [|!irow; l|] v
      done
    );

    indxr.(i) <- !irow;
    indxc.(i) <- !icol;
    let p = M.get a [|!icol; !icol|] in
    if (p == 0.0) then failwith "gaussj: Singular Matrix";
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
        for l = 0 to n - 1 do
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


let ludcmp a =
  let _aref = M.copy a in
  let lu = M.copy a in
  let n = (M.shape a).(0) in (* row *)
  let indx = Array.make n 0 in
  let vv = Array.make n 0. in

  let tiny = 1.0e-40 in
  let big = ref 0. in
  let temp = ref 0. in
  let d = ref 1.0 in

  let imax = ref 0 in

  for i = 0 to n - 1 do
    big := 0.;
    for j = 0 to n - 1 do
      temp := M.get lu [|i; j|] |> abs_float;
      if !temp > !big then big := !temp
    done;

    if (!big = 0.) then failwith "ludcmp: Singular matrix.";
    vv.(i) <- 1.0 /. !big
  done;

  for k = 0 to n - 1 do
    big := 0.;
    for i = k to n - 1 do
      temp := (M.get lu [|i; k|] |> abs_float) *. vv.(i);
      if (!temp > !big) then (
        big := !temp;
        imax := i
      )
    done;

    if (k != !imax) then (
      for j = 0 to n - 1 do
        temp := M.get lu [|!imax; j|];
        let tmp = M.get lu [|k; j|] in
        M.set lu [|!imax; j|] tmp;
        M.set lu [|k; j|] !temp
      done;
      d := !d *. (-1.);
      vv.(!imax) <- vv.(k);
    );

    indx.(k) <- !imax;
    if (M.get lu [|k; k|] == 0.) then M.set lu [|k; k|] tiny;

    for i = k + 1 to n - 1 do
      let tmp0 = M.get lu [|i; k|] in
      let tmp1 = M.get lu [|k; k|] in
      temp := tmp0 /. tmp1;
      for j = k + 1 to n - 1 do
        let prev = M.get lu [|i; j|] in
        M.set lu [|i; j|] (prev -. !temp *. (M.get lu [|k; j|]))
      done
    done
  done;

  lu, indx


let lu_solve_vec a b =
  (*TODO: check shape; b and x are vectors *)
  let n = (M.shape a).(0) in
  if ((M.shape b).(0) != n || (M.shape x).(0) != n) then
    failwith "LUdcmp::solve bad sizes";

  let sum = ref 0. in
  let x = M.copy b in

  let lu, indx = ludcmp a in

  for i = 0 to n - 1 do
    let ip = indx.(i) in
    let sum = x.(ip) in
    x.(ip) <- x.(i) 
  done




(* ends here *)
