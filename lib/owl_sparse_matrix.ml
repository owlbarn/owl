(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_common

type format_typ = TRIPLET | CCS | CRS
type int_array = (int, int_elt, c_layout) Array1.t
type ('a, 'b) elt_array = ('a, 'b, c_layout) Array1.t
type ('a, 'b) kind = ('a, 'b) Bigarray.kind

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

let _make_int_array n =
  let x = Array1.create int c_layout n in
  Array1.fill x 0;
  x

let _make_elt_array k n =
  let x = Array1.create k c_layout n in
  Array1.fill x (_zero k);
  x

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

let _triplet2crs x =
  (* NOTE: without sorting col number *)
  Log.debug "triplet -> crs starts";
  if _is_triplet x = false then failwith "not in triplet format";
  let i = Owl_utils.array1_clone (Array1.sub x.i 0 x.nz) in
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
  let _op = _owl_uniform k in
  _random_basic k (fun () -> _op scale) m n

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

let foldi f a x =
  let r = ref a in
  iteri (fun i j y -> r := f i j !r y) x;
  !r

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

let foldi_nz f a x =
  let r = ref a in
  iteri_nz (fun i j y -> r := f i j !r y) x;
  !r

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

let exists f x = _exists_basic iter f x

let not_exists f x = not (exists f x)

let for_all f x = let g y = not (f y) in not_exists g x

let exists_nz f x = _exists_basic iter_nz f x

let not_exists_nz f x = not (exists_nz f x)

let for_all_nz f x = let g y = not (f y) in not_exists_nz g x

let nnz_rows x =
  let s = Hashtbl.create 1000 in
  let _ = iteri_nz (fun i _ _ -> if not (Hashtbl.mem s i) then Hashtbl.add s i 0) x in
  Hashtbl.fold (fun k v l -> l @ [k]) s [] |> Array.of_list

let nnz_cols x =
  let s = Hashtbl.create 1000 in
  let _ = iteri_nz (fun _ j _ -> if not (Hashtbl.mem s j) then Hashtbl.add s j 0) x in
  Hashtbl.fold (fun k v l -> l @ [k]) s [] |> Array.of_list

let row_num_nz x = nnz_rows x |> Array.length

let col_num_nz x = nnz_cols x |> Array.length

let transpose x =
  let m, n = shape x in
  let y = zeros (kind x) n m in
  iteri_nz (fun i j a -> set y j i a) x;
  y

(** matrix mathematical operations *)

let add_scalar x a =
  let __add_elt = _add_elt (kind x) in
  map_nz (fun z -> __add_elt z a) x

let sub_scalar x a = add_scalar x (_neg_elt (kind x) a)

let mul_scalar x a =
  let __mul_elt = _mul_elt (kind x) in
  map_nz (fun z -> __mul_elt z a) x

let div_scalar x a = mul_scalar x ((_inv_elt (kind x)) a)

let add x1 x2 =
  let k = kind x1 in
  let _a0 = _zero k in
  let __add_elt = _add_elt k in
  let y = zeros k (row_num x1) (col_num x1) in
  let _ = iteri_nz (fun i j a ->
    let b = get x2 i j in
    if b = _a0 then set y i j a
  ) x1 in
  let _ = iteri_nz (fun i j a ->
    let b = get x1 i j in
    set y i j (__add_elt a b)
  ) x2 in
  y

let neg x = map_nz (_neg_elt (kind x)) x

let dot x1 x2 =
  let m1, n1 = shape x1 in
  let m2, n2 = shape x2 in
  if n1 <> m2 then failwith "dimension mistach";
  if _is_triplet x1 then _triplet2crs x1;
  if _is_triplet x2 then _triplet2crs x2;
  let k = kind x1 in
  let y = zeros k m1 n2 in
  let __add_elt = _add_elt k in
  let __mul_elt = _mul_elt k in
  iteri_nz (fun i j c1 ->
    for i' = x2.p.{j} to x2.p.{j + 1} - 1 do
      let j' = x2.i.{i'} in
      let c2 = x2.d.{i'} in
      let c0 = get y i j' in
      set y i j' (__add_elt c0 (__mul_elt c1 c2))
    done
  ) x1;
  y

let sub x1 x2 = add x1 (neg x2)

let mul x1 x2 =
  let k = kind x1 in
  let _a0 = _zero k in
  let __mul_elt = _mul_elt k in
  let y = zeros (kind x1) (row_num x1) (col_num x1) in
  let _ = iteri_nz (fun i j a ->
    let b = get x2 i j in
    if b <> _a0 then set y i j (__mul_elt a b)
  ) x1 in
  y

let div x1 x2 =
  let k = kind x1 in
  let _a0 = _zero k in
  let __div_elt = _div_elt k in
  let __inv_elt = _inv_elt k in
  let y = zeros (kind x1) (row_num x1) (col_num x1) in
  let _ = iteri_nz (fun i j a ->
    let b = get x2 i j in
    if b <> _a0 then set y i j (__div_elt a (__inv_elt b))
  ) x1 in
  y

let abs x =
  let _op = _abs_elt (kind x) in
  map_nz _op x

let sum x =
  let k = kind x in
  fold_nz (_add_elt k) (_zero k) x

let average x = (_average_elt (kind x)) (sum x) (numel x)

(* FIXME: inconsistent with Dense.Matrix.pow *)
let power x c = map_nz (fun y -> Complex.pow y c) x

let is_zero x = x.nz = 0

let is_positive x =
  let _a0 = _zero (kind x) in
  if x.nz < (x.m * x.n) then false
  else for_all (( < ) _a0) x

let is_negative x =
  let _a0 = _zero (kind x) in
  if x.nz < (x.m * x.n) then false
  else for_all (( > ) _a0) x

let is_nonpositive x =
  let _a0 = _zero (kind x) in
  for_all_nz (( >= ) _a0) x

let is_nonnegative x =
  let _a0 = _zero (kind x) in
  for_all_nz (( <= ) _a0) x

let minmax x =
  let k = kind x in
  let _a0 = _zero k in
  let xmin = ref (_pos_inf k) in
  let xmax = ref (_neg_inf k) in
  iter_nz (fun y ->
    if y < !xmin then xmin := y;
    if y > !xmax then xmax := y;
  ) x;
  match x.nz < (numel x) with
  | true  -> (min !xmin _a0), (max !xmax _a0)
  | false -> !xmin, !xmax

let min x = fst (minmax x)

let max x = snd (minmax x)

let is_equal x1 x2 =
  if x1.nz <> x2.nz then false
  else (sub x1 x2 |> is_zero)

let is_unequal x1 x2 = not (is_equal x1 x2)

let is_greater x1 x2 = is_positive (sub x1 x2)

let is_smaller x1 x2 = is_greater x2 x1

let equal_or_greater x1 x2 = is_nonnegative (sub x1 x2)

let equal_or_smaller x1 x2 = equal_or_greater x2 x1

(** advanced matrix methematical operations *)

let diag x =
  let m = Pervasives.min (row_num x) (col_num x) in
  let y = zeros (kind x) 1 m in
  iteri_nz (fun i j z ->
    if i = j then set y 0 j z else ()
  ) x; y

let trace x = sum (diag x)

(** transform to and from different types *)

let to_dense x =
  let m, n = shape x in
  let y = Owl_dense_matrix.zeros (kind x) m n in
  iteri (fun i j z -> Owl_dense_matrix.set y i j z) x;
  y

let of_dense x =
  let m, n = Owl_dense_matrix.shape x in
  let x' = genarray_of_array2 x in
  let x' = reshape_1 x' (Owl_dense_matrix.numel x) in
  let y = zeros (Array1.kind x') m n in
  Owl_dense_matrix.iteri (fun i j z -> set y i j z) x;
  y

let sum_rows x =
  let y = Owl_dense_matrix.ones (kind x) 1 (row_num x) |> of_dense in
  dot y x

let sum_cols x =
  let y = Owl_dense_matrix.ones (kind x) (col_num x) 1 |> of_dense in
  dot x y

let average_rows x =
  let m, n = shape x in
  let k = kind x in
  let a = (_average_elt k) (_one k) m in
  let y = Owl_dense_matrix.create k 1 m a |> of_dense in
  dot y x

let average_cols x =
  let m, n = shape x in
  let k = kind x in
  let a = (_average_elt k) (_one k) n in
  let y = Owl_dense_matrix.create k n 1 a |> of_dense in
  dot x y

(** formatted input / output operations *)

let print x =
  let _op = _owl_elt_to_str (kind x) in
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      let c = get x i j in
      Printf.printf "%s " (_op c)
    done;
    print_endline ""
  done

let pp_spmat x =
  let m, n = shape x in
  let c = nnz x in
  let p = 100. *. (density x) in
  (* let mz, nz = row_num_nz x, col_num_nz x in *)
  let mz, nz = 0, 0 in
  if m < 100 && n < 100 then Owl_dense_matrix.pp_dsmat (to_dense x);
  Printf.printf "shape = (%i,%i) | (%i,%i); nnz = %i (%.1f%%)\n" m n mz nz c p

let save x f =
  let s = Marshal.to_string x [] in
  let h = open_out f in
  output_string h s;
  close_out h

let load k f =
  let h = open_in f in
  let s = really_input_string h (in_channel_length h) in
  Marshal.from_string s 0

(** permutation and draw functions *)

let permutation_matrix k d =
  let l = Array.init d (fun x -> x) |> Owl_stats.shuffle in
  let y = zeros k d d in
  let _a1 = _one k in
  Array.iteri (fun i j -> set y i j _a1) l;
  y

let draw_rows ?(replacement=true) x c =
  let m, n = shape x in
  let a = Array.init m (fun x -> x) |> Owl_stats.shuffle in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in
  let y = zeros (kind x) c m in
  let _a1 = _one (kind x) in
  let _ = Array.iteri (fun i j -> set y i j _a1) l in
  dot y x, l

let draw_cols ?(replacement=true) x c =
  let m, n = shape x in
  let a = Array.init n (fun x -> x) |> Owl_stats.shuffle in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in
  let y = zeros (kind x) n c in
  let _a1 = _one (kind x) in
  let _ = Array.iteri (fun j i -> set y i j _a1) l in
  dot x y, l

let shuffle_rows x =
  let y = permutation_matrix (kind x) (row_num x) in
  dot y x

let shuffle_cols x =
  let y = permutation_matrix (kind x) (col_num x) in
  dot x y

let shuffle x = x |> shuffle_rows |> shuffle_cols

let ones k m n = Owl_dense_matrix.ones k m n |> of_dense

let sequential k m n = Owl_dense_matrix.sequential k m n |> of_dense

let fill x a =
  let m, n = shape x in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      set x i j a
    done
  done

let to_array x =
  let y = Array.make (nnz x) ([||], _zero (kind x)) in
  let k = ref 0 in
  iteri_nz (fun i j v ->
    y.(!k) <- ([|i;j|], v);
    k := !k + 1;
  ) x;
  y

let of_array k m n x =
  let y = zeros k m n in
  Array.iter (fun (i,v) -> set y i.(0) i.(1) v) x;
  y

(** short-hand infix operators *)

let ( +@ ) = add

let ( -@ ) = sub

let ( *@ ) = mul

let ( /@ ) = div

let ( $@ ) = dot

let ( **@ ) = power

let ( *$ ) x a = mul_scalar x a

let ( $* ) a x = mul_scalar x a

let ( /$ ) x a = div_scalar x a

let ( $/ ) a x = div_scalar x a

let ( =@ ) = is_equal

let ( >@ ) = is_greater

let ( <@ ) = is_smaller

let ( <>@ ) = is_unequal

let ( >=@ ) = equal_or_greater

let ( <=@ ) = equal_or_smaller

let ( @@ ) f x = map f x



(** ends here *)
