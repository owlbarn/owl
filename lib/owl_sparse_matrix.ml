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

let iteri f x =
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      f i j (get x i j)
    done
  done

let iter f x = iteri (fun _ _ y -> f y) x

let reset x =
  x.p <- _make_int_array (Array1.dim x.i);
  x.nz <- 0;
  x.typ <- TRIPLET;
  Hashtbl.reset x.h

let row x i =
  let y = zeros (kind x) 1 (col_num x) in
  for j = 0 to (col_num x) - 1 do
    set y 0 j (get x i j)
  done;
  y

let col x i =
  let y = zeros (kind x) (row_num x) 1 in
  for j = 0 to (row_num x) - 1 do
    set y j 0 (get x j i)
  done;
  y

let rows x l =
  let m, n = Array.length l, col_num x in
  let y = zeros (kind x) m n in
  Array.iteri (fun i i' ->
    for j = 0 to n - 1 do
      set y i j (get x i' j)
    done
  ) l;
  y

let cols x l =
  let m, n = row_num x, Array.length l in
  let y = zeros (kind x) m n in
  Array.iteri (fun j j' ->
    for i = 0 to m - 1 do
      set y i j (get x i j')
    done
  ) l;
  y

let mapi f x =
  let y = zeros (kind x) (row_num x) (col_num x) in
  iteri (fun i j z -> set y i j (f i j z)) x;
  y

let map f x = mapi (fun _ _ y -> f y) x

let _fold_basic iter_fun f a x =
  let r = ref a in
  iter_fun (fun y -> r := f !r y) x; !r

let fold f a x = _fold_basic iter f a x

let filteri f x =
  let r = ref [||] in
  iteri (fun i j y ->
    if (f i j y) then r := Array.append !r [|(i,j)|]
  ) x; !r

let filter f x = filteri (fun _ _ y -> f y) x

let iteri_nz f x =
  if _is_triplet x then _triplet2crs x;
  for i = 0 to x.m - 1 do
    for k = x.p.{i} to x.p.{i + 1} - 1 do
      let j = x.i.{k} in
      let y = x.d.{k} in
      f i j y
    done
  done

let iter_nz f x = iteri_nz (fun _ _ y -> f y) x

let _disassemble_rows x =
  Log.debug "_disassemble_rows: starts";
  if _is_triplet x then _triplet2crs x;
  let k = kind x in
  Log.debug "_disassemble_rows :allocate space";
  let d = Array.init (row_num x) (fun _ -> zeros k 1 (col_num x)) in
  Log.debug "_disassemble_rows: iteri_nz";
  let _ = iteri_nz (fun i j z -> set d.(i) 0 j z) x in
  Log.debug "_disassemble_rows: ends";
  d

let _disassemble_cols x =
  if _is_triplet x then _triplet2crs x;
  let k = kind x in
  let d = Array.init (col_num x) (fun _ -> zeros k (row_num x) 1) in
  let _ = iteri_nz (fun i j z -> set d.(j) i 0 z) x in
  d

let iteri_rows f x = Array.iteri (fun i y -> f i y) (_disassemble_rows x)

let iter_rows f x = iteri_rows (fun _ y -> f y) x

let iteri_cols f x = Array.iteri (fun j y -> f j y) (_disassemble_cols x)

let iter_cols f x = iteri_cols (fun _ y -> f y) x

let mapi_nz f x =
  if _is_triplet x then _triplet2crs x;
  let y = clone x in
  for i = 0 to x.m - 1 do
    for k = x.p.{i} to x.p.{i + 1} - 1 do
      let j = x.i.{k} in
      let z = x.d.{k} in
      y.d.{k} <- f i j z
    done
  done;
  y

let map_nz f x =
  let y = clone x in
  for i = 0 to x.nz - 1 do
    y.d.{i} <- f y.d.{i}
  done;
  y

let fold_nz f a x = _fold_basic iter_nz f a x

let filteri_nz f x =
  let r = ref [||] in
  iteri_nz (fun i j y ->
    if (f i j y) then r := Array.append !r [|(i,j)|]
  ) x; !r

let filter_nz f x = filteri_nz (fun _ _ y -> f y) x

let mapi_rows f x =
  let a = _disassemble_rows x in
  Array.init (row_num x) (fun i -> f i a.(i))

let map_rows f x = mapi_rows (fun _ y -> f y) x

let mapi_cols f x =
  let a = _disassemble_cols x in
  Array.init (col_num x) (fun i -> f i a.(i))

let map_cols f x = mapi_cols (fun _ y -> f y) x

let fold_rows f a x = _fold_basic iter_rows f a x

let fold_cols f a x = _fold_basic iter_cols f a x

let iteri_rows_nz f x = iteri_rows (fun i y -> if y.nz != 0 then f i y) x

let iter_rows_nz f x = iteri_rows_nz (fun _ y -> f y) x

let iteri_cols_nz f x = iteri_cols (fun i y -> if y.nz != 0 then f i y) x

let iter_cols_nz f x = iteri_cols_nz (fun _ y -> f y) x

let mapi_rows_nz f x =
  let a = _disassemble_rows x in
  let r = ref [||] in
  Array.iteri (fun i y ->
    if (nnz y) != 0 then r := Array.append !r [|f i y|]
  ) a; !r

let map_rows_nz f x = mapi_rows_nz (fun _ y -> f y) x

let mapi_cols_nz f x =
  let a = _disassemble_cols x in
  let r = ref [||] in
  Array.iteri (fun i y ->
    if (nnz y) != 0 then r := Array.append !r [|f i y|]
  ) a; !r

let map_cols_nz f x = mapi_cols_nz (fun _ y -> f y) x

let fold_rows_nz f a x = _fold_basic iter_rows_nz f a x

let fold_cols_nz f a x = _fold_basic iter_cols_nz f a x

let _exists_basic iter_fun f x =
  try iter_fun (fun y ->
    if (f y) = true then failwith "found"
  ) x; false
  with exn -> true
