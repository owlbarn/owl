(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex sparse matrix ]
  The default format is compressed row storage (CRS).
 *)

open Bigarray
open Owl_types.Sparse_complex

type spmat = spmat_record

type elt = Complex.t

let _make_int_array x = Array.make x 0
let _make_elt_array x = Array1.create complex64 c_layout x

let zeros m n =
  let c = max (m * n / 100) 1024 in
  {
    m   = m;
    n   = n;
    i   = _make_int_array c;
    d   = _make_elt_array c;
    p   = _make_int_array c;
    nz  = 0;
    typ = 0;
    h   = Hashtbl.create c;
  }

let _is_triplet x = x.typ = 0

let _remove_ith_triplet x i =
  for j = i to x.nz - 2 do
    x.i.(j) <- x.i.(j + 1);
    x.p.(j) <- x.p.(j + 1);
    x.d.{j} <- x.d.{j + 1};
  done

let _triplet2crs x =
  (* TODO: can be optimised by sorting col number *)
  let i = Array.sub x.i 0 x.nz in
  let q = _make_int_array x.m in
  Array.iter (fun c -> q.(c) <- q.(c) + 1) i;
  let p = _make_int_array (x.m + 1) in
  Array.iteri (fun i c -> p.(i + 1) <- p.(i) + c) q;
  let d = _make_elt_array x.nz in
  for j = 0 to x.nz - 1 do
    let c = x.d.{j} in
    let r_i = x.i.(j) in
    let pos = p.(r_i + 1) - q.(r_i) in
    d.{pos} <- c;
    i.(j) <- x.p.(j);
  done;
  x.i <- i;
  x.d <- d;
  x.p <- p;
  x.typ <- 2

let _allocate_more_space x =
  if x.nz < Array.length x.i then ()
  else (
    print_endline "allocate space ...";
    x.i <- Array.append x.i (_make_int_array x.nz);
    x.p <- Array.append x.p (_make_int_array x.nz);
    let d = _make_elt_array (x.nz * 2) in
    for j = 0 to x.nz - 1 do
      d.{j} <- x.d.{j}
    done;
    x.d <- d
  )

let set x i j y =
  if _is_triplet x = false then
    failwith "only triplet format is mutable.";
  _allocate_more_space x;
  let k = i * x.n + j in
  match y = Complex.zero with
  | true  -> (
    if Hashtbl.mem x.h k then (
      let t = x.d.{k} in
      _remove_ith_triplet x (Hashtbl.find x.h k);
      Hashtbl.remove x.h k;
      if t <> Complex.zero then x.nz <- x.nz - 1
    )
    )
  | false -> (
    let l = (
      if Hashtbl.mem x.h k then (
        Hashtbl.find x.h k
      )
      else (
        let t = x.nz in
        x.nz <- x.nz + 1;
        Hashtbl.add x.h k t;
        t
      )
    )
    in
    x.i.(l) <- i;
    x.p.(l) <- j;
    x.d.{l} <- y;
    )

let _get_triplet x i j =
  let k = i * x.n + j in
  if Hashtbl.mem x.h k then (
    let l = Hashtbl.find x.h k in
    x.d.{l}
  )
  else Complex.zero

let _get_crs x i j =
  let a = x.p.(i) in
  let b = x.p.(i + 1) in
  let k = ref a in
  while !k < b && x.i.(!k) <> j do k := !k + 1 done;
  if !k < b then x.d.{!k}
  else Complex.zero

let get x i j =
  match x.typ with
  | 0 -> _get_triplet x i j
  | 2 -> _get_crs x i j
  | _ -> failwith "unsupported sparse format."

let shape x = (x.m, x.n)

let row_num x = x.m

let col_num x = x.n

let numel x = (row_num x) * (col_num x)

let nnz x = x.nz

let density x =
  let a, b = nnz x, numel x in
  (float_of_int a) /. (float_of_int b)

let eye n =
  let x = zeros n n in
  for i = 0 to (row_num x) - 1 do
      set x i i Complex.one
  done;
  x


let iteri f x =
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      f i j (get x i j)
    done
  done

let iter f x = iteri (fun _ _ y -> f y) x

let row_num_nz x = 0

let col_num_nz x = 0

let to_dense x =
  let m, n = shape x in
  let y = Owl_dense_complex.zeros m n in
  iteri (fun i j z -> Owl_dense_complex.set y i j z) x;
  y

let pp_spmat x =
  let m, n = shape x in
  let c = nnz x in
  let p = 100. *. (density x) in
  let mz, nz = row_num_nz x, col_num_nz x in
  let _ = if m < 100 && n < 100 then Owl_dense_complex.pp_dsmat (to_dense x) in
  Printf.printf "shape = (%i,%i) | (%i,%i); nnz = %i (%.1f%%)\n" m n mz nz c p




(** ends here *)
