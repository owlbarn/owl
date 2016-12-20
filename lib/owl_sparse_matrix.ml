(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_common

type format_typ = TRIPLET | CCS | CRS
type int_array = (int, int_elt, c_layout) Array1.t
type ('a, 'b) elt_array = ('a, 'b, c_layout) Array1.t

type ('a, 'b) t = {
  mutable m   : int;                             (* number of rows *)
  mutable n   : int;                             (* number of columns *)
  mutable i   : int_array;                       (* i index, meaning depends on the matrix format *)
  mutable d   : ('a, 'b) elt_array;              (* where data actually stored *)
  mutable p   : int_array;                       (* p index, meaning depends on the matrix format *)
  mutable nz  : int;                             (* total number of non-zero elements *)
  mutable typ : format_typ;                      (* sparse matrix format, triplet; CCS; CRS *)
  mutable h   : (int, int) Hashtbl.t
}

let _make_int_array n = Array1.create int c_layout n
let _make_elt_array k n = Array1.create k c_layout n

let zeros k m n =
  let c = max (m * n / 100) 1024 in
  {
    m   = m;
    n   = n;
    i   = _make_int_array c;
    d   = _make_elt_array k c;
    p   = _make_int_array c;
    nz  = 0;
    typ = TRIPLET;
    h   = Hashtbl.create c;
  }

let kind x = Array1.kind x.d

let _is_triplet x =
  match x.typ with
  | TRIPLET -> true
  | _       -> false

let _remove_ith_triplet x i =
  Log.debug "_remove_ith_triplet";
  for j = i to x.nz - 2 do
    x.i.{j} <- x.i.{j + 1};
    x.p.{j} <- x.p.{j + 1};
    x.d.{j} <- x.d.{j + 1};
    Hashtbl.replace x.h (x.i.{j} * x.n + x.p.{j}) j;
  done

(* for debug purpose *)
let _print_complex x = Printf.printf "{re = %f; im = %f} " Complex.(x.re) Complex.(x.im)

(* for debug purpose *)
let _print_array x =
  Array.iter (fun y -> print_int y; print_char ' ') x;
  print_endline ""

let _triplet2crs x =
  (* NOTE: without sorting col number *)
  Log.debug "triplet -> crs starts";
  if _is_triplet x = false then failwith "not in triplet format";
  let i = Array1.sub x.i 0 x.nz in
  let q = _make_int_array x.m in
  Owl_utils.array1_iter (fun c -> q.{c} <- q.{c} + 1) i;
  let p = _make_int_array (x.m + 1) in
  Owl_utils.array1_iteri (fun i c -> p.{i + 1} <- p.{i} + c) q;
  let d = _make_elt_array (kind x) x.nz in
  for j = 0 to x.nz - 1 do
    let c = x.d.{j} in
    let r_i = x.i.{j} in
    let pos = p.{r_i + 1} - q.{r_i} in
    d.{pos} <- c;
    i.{pos} <- x.p.{j};
    q.{r_i} <- q.{r_i} - 1;
  done;
  x.i <- i;
  x.d <- d;
  x.p <- p;
  x.typ <- CRS;
  Hashtbl.reset x.h;
  Log.debug "triplet -> crs ends"

let _crs2triplet x = None

let _allocate_more_space x =
  if x.nz < Array1.dim x.i then ()
  else (
    Log.debug "allocate space %i" x.nz;
    x.i <- Owl_utils.array1_extend x.i x.nz;
    x.p <- Owl_utils.array1_extend x.p x.nz;
    x.d <- Owl_utils.array1_extend x.d x.nz;
  )

let set x i j y =
  if _is_triplet x = false then
    failwith "only triplet format is mutable.";
  _allocate_more_space x;
  let k = i * x.n + j in
  let _a0 = (_zero (kind x)) in
  match y = _a0 with
  | true  -> (
    if Hashtbl.mem x.h k then (
      let l = Hashtbl.find x.h k in
      let t = x.d.{l} in
      _remove_ith_triplet x l;
      Hashtbl.remove x.h k;
      if t <> _a0 then x.nz <- x.nz - 1
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
    x.i.{l} <- i;
    x.p.{l} <- j;
    x.d.{l} <- y;
    )

let _get_triplet x i j =
  let k = i * x.n + j in
  if Hashtbl.mem x.h k then (
    let l = Hashtbl.find x.h k in
    x.d.{l}
  )
  else _zero (kind x)

let _get_crs x i j =
  let a = x.p.{i} in
  let b = x.p.{i + 1} in
  let k = ref a in
  while !k < b && x.i.{!k} <> j do
    k := !k + 1
  done;
  if !k < b then x.d.{!k}
  else _zero (kind x)

let get x i j =
  match x.typ with
  | TRIPLET -> _get_triplet x i j
  | CRS     -> _get_crs x i j
  | _       -> failwith "unsupported sparse format."

let shape x = (x.m, x.n)

let row_num x = x.m

let col_num x = x.n

let numel x = (row_num x) * (col_num x)

let nnz x = x.nz

let density x =
  let a, b = nnz x, numel x in
  (float_of_int a) /. (float_of_int b)

let eye k n =
  let x = zeros k n n in
  let a = _one k in
  for i = 0 to (row_num x) - 1 do
      set x i i a
  done;
  x

let _random_basic k f m n =
  let c = int_of_float ((float_of_int (m * n)) *. 0.15) in
  let x = zeros k m n in
  for k = 0 to c do
    let i = Owl_stats.Rnd.uniform_int ~a:0 ~b:(m-1) () in
    let j = Owl_stats.Rnd.uniform_int ~a:0 ~b:(n-1) () in
    set x i j (f ())
  done;
  x

let binary k m n =
  let _a1 = _one k in
  _random_basic k (fun () -> _a1) m n

let uniform ?(scale=1.) k m n =
  _random_basic k (fun () ->
    let re = Owl_stats.Rnd.uniform () *. scale in
    let im = Owl_stats.Rnd.uniform () *. scale in
    Complex.({re; im})
  ) m n

let uniform_int ?(a=1) ?(b=99) k m n =
  _random_basic k (fun () ->
    let re = Owl_stats.Rnd.uniform_int ~a ~b () |> float_of_int in
    let im = Owl_stats.Rnd.uniform_int ~a ~b () |> float_of_int in
    Complex.({re; im})
  ) m n

let clone x =
  {
    m   = x.m;
    n   = x.n;
    i   = Owl_utils.array1_clone x.i;
    d   = Owl_utils.array1_clone x.d;
    p   = Owl_utils.array1_clone x.p;
    nz  = x.nz;
    typ = x.typ;
    h   = Hashtbl.copy x.h;
  }
