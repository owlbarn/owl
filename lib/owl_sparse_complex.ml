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

let _make_int_array x = Array1.create int64 c_layout x
let _make_elt_array x = Array1.create complex64 c_layout x

let zeros m n =
  let p = _make_int_array (m + 1) in
  for i = 0 to m - 1 do p.{i} <- Int64.of_int 0 done;
  p.{m} <- Int64.of_int 1;
  {
    m   = m;
    n   = n;
    i   = _make_int_array 0;
    d   = _make_elt_array 0;
    p   = p;
    nz  = 0;
    typ = 0;
  }

let set x i j y = None

let get x i j =
  let a = x.p.{i} |> Int64.to_int in
  let b = x.p.{i + 1} |> Int64.to_int in
  let k = ref a in
  let i' = Int64.of_int i in
  while x.i.{!k} <> i' && !k < b do k := !k + 1 done;
  if !k < b then x.d.{!k}
  else Complex.zero




let pp_spmat x = Printf.printf "print out something ..."

(** ends here *)
