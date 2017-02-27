(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_sparse_common

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) t = {
  mutable m : int;                             (* number of rows *)
  mutable n : int;                             (* number of columns *)
  mutable k : ('a, 'b) kind;                   (* type of sparse matrices *)
  mutable d : ('a, 'b) eigen_mat;              (* point to eigen struct *)
}

let zeros ?(density=0.01) k m n = {
  m = m;
  n = n;
  k = k;
  d = (_eigen_create) density k m n;
}

let eye k m = {
  m = m;
  n = m;
  k = k;
  d = (_eigen_eye) k m;
}

let shape x = (x.m, x.n)

let row_num x = x.m

let col_num x = x.n

let numel x = x.m * x.n

let nnz x = _eigen_nnz x.d

let density x = (float_of_int (nnz x)) /. (float_of_int (numel x))

let kind x = x.k

let insert x i j a =
  if a <> Owl_types._zero x.k then
  _eigen_insert x.d i j a

let set x i j a = _eigen_set x.d i j a

let get x i j = _eigen_get x.d i j

let reset x = _eigen_reset x.d

let prune x a eps = _eigen_prune x.d a eps

let clone x = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_clone x.d;
}

let transpose x = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_transpose x.d;
}

let diag x = {
  m = min x.m x.n;
  n = 1;
  k = x.k;
  d = _eigen_diagonal x.d;
}

let trace x = _eigen_trace x.d

let row x i = {
  m = 1;
  n = x.n;
  k = x.k;
  d = _eigen_row x.d i;
}

let col x j = {
  m = x.m;
  n = 1;
  k = x.k;
  d = _eigen_col x.d j;
}

let iteri f x =
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      f i j (get x i j)
    done
  done

let iter f x =
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      f (get x i j)
    done
  done

let mapi f x =
  let d = density x in
  let y = zeros ~density:d (kind x) (row_num x) (col_num x) in
  iteri (fun i j z -> insert y i j (f i j z)) x;
  y

let map f x =
  let d = density x in
  let y = zeros ~density:d (kind x) (row_num x) (col_num x) in
  iteri (fun i j z -> insert y i j (f z)) x;
  y

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
  let _ = _eigen_compress x.d in
  let d = _eigen_valueptr x.d in
  let q = _eigen_innerindexptr x.d in
  let p = _eigen_outerindexptr x.d in
  for i = 0 to x.m - 1 do
    for k = (Int64.to_int p.{i}) to (Int64.to_int p.{i + 1}) - 1 do
      let j = Int64.to_int q.{k} in
      f i j d.{k}
    done
  done

let iter_nz f x =
  let _ = _eigen_compress x.d in
  let d = _eigen_valueptr x.d in
  for i = 0 to Array1.dim d - 1 do
    f d.{i}
  done

let mapi_nz f x =
  let _ = _eigen_compress x.d in
  let d = _eigen_valueptr x.d in
  let q = _eigen_innerindexptr x.d in
  let p = _eigen_outerindexptr x.d in
  let y = clone x in
  let e = _eigen_valueptr y.d in
  for i = 0 to x.m - 1 do
    for k = (Int64.to_int p.{i}) to (Int64.to_int p.{i + 1}) - 1 do
      let j = Int64.to_int q.{k} in
      e.{k} <- f i j d.{k}
    done
  done;
  y

let map_nz f x =
  let _ = _eigen_compress x.d in
  let d = _eigen_valueptr x.d in
  let y = clone x in
  let e = _eigen_valueptr y.d in
  for i = 0 to Array1.dim d - 1 do
    e.{i} <- f d.{i}
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

let _disassemble_rows x =
  _eigen_compress x.d;
  Log.debug "_disassemble_rows :allocate space";
  let d = Array.init x.m (fun _ -> zeros x.k 1 x.n) in
  Log.debug "_disassemble_rows: iteri_nz";
  let _ = iteri_nz (fun i j z -> insert d.(i) 0 j z) x in
  Log.debug "_disassemble_rows: ends";
  d

let _disassemble_cols x =
  _eigen_compress x.d;
  let d = Array.init x.n (fun _ -> zeros x.k x.m 1) in
  let _ = iteri_nz (fun i j z -> insert d.(j) i 0 z) x in
  d

let iteri_rows f x = Array.iteri (fun i y -> f i y) (_disassemble_rows x)

let iter_rows f x = iteri_rows (fun _ y -> f y) x

let iteri_cols f x = Array.iteri (fun j y -> f j y) (_disassemble_cols x)

let iter_cols f x = iteri_cols (fun _ y -> f y) x

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

let iteri_rows_nz f x = iteri_rows (fun i y -> if (nnz y) != 0 then f i y) x

let iter_rows_nz f x = iteri_rows_nz (fun _ y -> f y) x

let iteri_cols_nz f x = iteri_cols (fun i y -> if (nnz y) != 0 then f i y) x

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

let is_zero x = _eigen_is_zero x.d

let is_positive x = _eigen_is_positive x.d

let is_negative x = _eigen_is_negative x.d

let is_nonpositive x = _eigen_is_nonpositive x.d

let is_nonnegative x = _eigen_is_nonnegative x.d

let is_equal x1 x2 = _eigen_is_equal x1.d x2.d

let is_unequal x1 x2 = _eigen_is_unequal x1.d x2.d

let is_greater x1 x2 = _eigen_is_greater x1.d x2.d

let is_smaller x1 x2 = _eigen_is_smaller x1.d x2.d

let equal_or_greater x1 x2 = _eigen_equal_or_greater x1.d x2.d

let equal_or_smaller x1 x2 = _eigen_equal_or_smaller x1.d x2.d

let add x y = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_add x.d y.d;
}

let sub x y = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_sub x.d y.d;
}

let mul x y = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_mul x.d y.d;
}

let div x y = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_div x.d y.d;
}

let dot x y = {
  m = x.m;
  n = y.n;
  k = x.k;
  d = _eigen_dot x.d y.d;
}

let add_scalar x a = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_add_scalar x.d a;
}

let sub_scalar x a = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_sub_scalar x.d a;
}

let mul_scalar x a = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_mul_scalar x.d a;
}

let div_scalar x a = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_div_scalar x.d a;
}

let min x = _eigen_min x.d

let max x = _eigen_max x.d

(* TODO: optimise *)
let minmax x = _eigen_min x.d, _eigen_max x.d

let min2 x y = _eigen_min2 x.d y.d

let max2 x y = _eigen_max2 x.d y.d

let sum x = _eigen_sum x.d

let average x = (Owl_dense_common._average_elt x.k) (sum x) (numel x)

let abs x = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_abs x.d;
}

let neg x = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_neg x.d;
}

let power_scalar x c =
  let _op = Owl_dense_common._power_scalar_elt (kind x) in
  map (fun y -> (_op) y c) x

(** permutation and draw functions *)

let permutation_matrix k d =
  let l = Array.init d (fun x -> x) |> Owl_stats.shuffle in
  let y = zeros k d d in
  let _a1 = Owl_types._one k in
  Array.iteri (fun i j -> insert y i j _a1) l;
  y

let draw_rows ?(replacement=true) x c =
  let m, n = shape x in
  let a = Array.init m (fun x -> x) |> Owl_stats.shuffle in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in
  let y = zeros (kind x) c m in
  let _a1 = Owl_types._one (kind x) in
  let _ = Array.iteri (fun i j -> insert y i j _a1) l in
  dot y x, l

let draw_cols ?(replacement=true) x c =
  let m, n = shape x in
  let a = Array.init n (fun x -> x) |> Owl_stats.shuffle in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in
  let y = zeros (kind x) n c in
  let _a1 = Owl_types._one (kind x) in
  let _ = Array.iteri (fun j i -> insert y i j _a1) l in
  dot x y, l

let shuffle_rows x =
  let y = permutation_matrix (kind x) (row_num x) in
  dot y x

let shuffle_cols x =
  let y = permutation_matrix (kind x) (col_num x) in
  dot x y

let shuffle x = x |> shuffle_rows |> shuffle_cols

let to_dense x =
  let y = Owl_dense_matrix.zeros x.k x.m x.n in
  iteri_nz (fun i j z -> Owl_dense_matrix.set y i j z) x;
  y

let of_dense x =
  let m, n = Owl_dense_matrix.shape x in
  let y = zeros ~density:1. (Owl_dense_matrix.kind x) m n in
  Owl_dense_matrix.iteri (fun i j z -> insert y i j z) x;
  y

let sum_rows x =
  let y = Owl_dense_matrix.ones x.k 1 x.m |> of_dense in
  dot y x

let sum_cols x =
  let y = Owl_dense_matrix.ones x.k x.n 1 |> of_dense in
  dot x y

let average_rows x =
  let m, n = shape x in
  let k = kind x in
  let a = (Owl_dense_common._average_elt k) (Owl_types._one k) m in
  let y = Owl_dense_matrix.create k 1 m a |> of_dense in
  dot y x

let average_cols x =
  let m, n = shape x in
  let k = kind x in
  let a = (Owl_dense_common._average_elt k) (Owl_types._one k) n in
  let y = Owl_dense_matrix.create k n 1 a |> of_dense in
  dot x y

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

let to_array x =
  let y = Array.make (nnz x) ([||], Owl_types._zero x.k) in
  let k = ref 0 in
  iteri_nz (fun i j v ->
    y.(!k) <- ([|i;j|], v);
    k := !k + 1;
  ) x;
  y

let of_array k m n x =
  let y = zeros k m n in
  Array.iter (fun (i,v) -> insert y i.(0) i.(1) v) x;
  y

let ones k m n = Owl_dense_matrix.ones k m n |> of_dense

let sequential k m n =
  let x = Owl_dense_matrix.sequential k m n |> of_dense in
  _eigen_prune x.d (Owl_types._zero x.k) 0.;
  x

let fill x a =
  let m, n = shape x in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      insert x i j a
    done
  done

let _random_basic d k f m n =
  let c = int_of_float ((float_of_int (m * n)) *. d) in
  let x = zeros ~density:(d +. 0.01) k m n in
  let l = Owl_stats.choose (Array.init (m * n) (fun i -> i)) c in
  for k = 0 to c - 1 do
    let i = l.(k) / n in
    let j = l.(k) - (i * n) in
    insert x i j (f ())
  done;
  x

let binary ?(density=0.15) k m n =
  let _a1 = Owl_types._one k in
  _random_basic density k (fun () -> _a1) m n

let uniform ?(density=0.15) ?(scale=1.) k m n =
  let _op = Owl_dense_common._owl_uniform k in
  _random_basic density k (fun () -> _op scale) m n

let print x = _eigen_print x.d

let pp_spmat x =
  let m, n = shape x in
  let c = nnz x in
  let p = 100. *. (density x) in
  let mz, nz = row_num_nz x, col_num_nz x in
  if m < 100 && n < 100 then Owl_dense_matrix.pp_dsmat (to_dense x);
  Printf.printf "shape = (%i,%i) | (%i,%i); nnz = %i (%.1f%%)\n" m n mz nz c p

let save x f = Owl_utils.marshal_to_file x f

let load k f = Owl_utils.marshal_from_file f

(* TODO: optimise *)
let rows x l =
  let y = zeros x.k (Array.length l) x.n in
  Array.iteri (fun i k ->
    iteri_nz (fun _ j v -> insert y i j v) (row x k)
  ) l;
  y

let cols x l =
  let y = zeros x.k x.m (Array.length l) in
  Array.iteri (fun j k ->
    iteri_nz (fun i _ v -> insert y i j v) (col x k)
  ) l;
  y

(* shorhand infix operators *)

let ( +@ ) = add

let ( -@ ) = sub

let ( *@ ) = mul

let ( /@ ) = div

let ( $@ ) = dot

let ( **@ ) = power_scalar

let ( =@ ) = ( = )

let ( <>@ ) = ( <> )

let ( >@ ) = is_greater

let ( <@ ) = is_smaller

let ( >=@ ) = equal_or_greater

let ( <=@ ) = equal_or_smaller

let ( +$ ) x a = add_scalar x a

let ( $+ ) a x = add_scalar x a

let ( -$ ) x a = sub_scalar x a

let ( $- ) a x = sub_scalar x a |> neg

let ( *$ ) x a = mul_scalar x a

let ( $* ) a x = mul_scalar x a

(* FIXME: wrong ... fixme *)
let ( /$ ) x a = div_scalar x a

let ( $/ ) a x = div_scalar x a

let ( @@ ) f x = map f x
