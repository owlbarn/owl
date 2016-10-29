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

let _to_crs x =
  let i = Array.sub x.i 0 x.nz in
  let q = Array.sub x.p 0 x.nz in
  Array.iter (fun c -> q.(c) <- q.(c) + 1) i;
  let p = _make_int_array (x.m + 1) in
  Array.iteri (fun i c -> p.(i + 1) <- p.(i) + c) q;
  let d = _make_elt_array x.nz in
  ()

let set x i j y =
  let k = i * (x.n - 1) + j in
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
    print_int x.nz;
    x.i.(l) <- i;
    x.p.(l) <- j;
    x.d.{l} <- y;
    )

let _get_triplet x i j =
  let k = i * (x.n - 1) + j in
  if Hashtbl.mem x.h k then (
    let l = Hashtbl.find x.h k in
    x.d.{l}
  )
  else Complex.zero

let get x i j =
  match x.typ with
  | 0 -> _get_triplet x i j
  | _ -> Complex.one

(*
let get x i j =
  if _is_triplet x then _to_csc x;
  let a = x.p.(i) in
  let b = x.p.(i + 1) in
  let k = ref a in
  while x.i.(!k) <> i && !k < b do k := !k + 1 done;
  if !k < b then x.d.{!k}
  else Complex.zero


let set' x i j y =
  let a = x.p.{i} |> Int64.to_int in
  let b = x.p.{i + 1} |> Int64.to_int in
  let k = ref a in
  let i' = Int64.of_int i in
  while x.i.{!k} <> i' && !k < b do k := !k + 1 done;
  if !k < b then ()

let get' x i j =
  let a = x.p.{i} |> Int64.to_int in
  let b = x.p.{i + 1} |> Int64.to_int in
  let k = ref a in
  let i' = Int64.of_int i in
  while x.i.{!k} <> i' && !k < b do k := !k + 1 done;
  if !k < b then x.d.{!k}
  else Complex.zero
*)


let pp_spmat x = Printf.printf "print out something ..."

(** ends here *)
