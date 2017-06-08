(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_common

type ('a, 'b) t = ('a, 'b, c_layout) Array2.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type area = { a : int; b : int; c : int; d : int }

(* transform between different format *)

let to_ndarray x = Bigarray.genarray_of_array2 x

let of_ndarray x = Bigarray.array2_of_genarray x

(* matrix creation operations *)

let kind x = Array2.kind x

let size_in_bytes x = x |> to_ndarray |> Owl_dense_ndarray_generic.size_in_bytes

let shape x = (Array2.dim1 x, Array2.dim2 x)

let row_num x = Array2.dim1 x

let col_num x = Array2.dim2 x

let numel x = (row_num x) * (col_num x)

let nnz x = Owl_dense_ndarray_generic.nnz (to_ndarray x)

let density x = Owl_dense_ndarray_generic.density (to_ndarray x)

let fill x a = Array2.fill x a

let reset x = Array2.fill x (_zero (kind x))

let empty k m n = Array2.create k c_layout m n

let create k m n a =
  let x = empty k m n in
  fill x a; x

let init k m n f = Owl_dense_ndarray_generic.init k [|m;n|] f |> of_ndarray

let init_nd k m n f =
  let x = empty k m n in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      Array2.unsafe_set x i j (f i j)
    done;
  done;
  x

let zeros k m n = create k m n (_zero k)

let ones k m n = create k m n (_one k)

let eye k n =
  let x = zeros k n n in
  let a = _one k in
  for i = 0 to n - 1 do
    Array2.unsafe_set x i i a
  done; x

(* FIXME: remove obsolete function *)
let sequential_obsolete k m n =
  let x = empty k m n in
  let c = ref (_zero k) in
  let a = _one k in
  let _op = _add_elt k in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      Array2.unsafe_set x i j !c;
      c := _op !c a;
    done
  done; x

let sequential k ?a ?step m n =
  Owl_dense_ndarray_generic.sequential k ?a ?step [|m;n|]
  |> of_ndarray

let linspace k a b n =
  let x = Owl_dense_ndarray_generic.linspace k a b n in
  let x = Owl_dense_ndarray_generic.reshape x [|1;n|] in
  reshape_2 x 1 n

let logspace k ?(base=Owl_maths.e) a b n =
  let x = Owl_dense_ndarray_generic.logspace k ~base a b n in
  let x = Owl_dense_ndarray_generic.reshape x [|1;n|] in
  reshape_2 x 1 n

(* matrix manipulations *)

let same_shape x1 x2 = shape x1 = shape x2

let area a b c d = { a = a; b = b; c = c; d = d }

let area_of x =
  let m, n = shape x in
  { a = 0; b = 0; c = m - 1; d = n - 1 }

let area_of_row x i = area i 0 i (col_num x - 1)

let area_of_col x i = area 0 i (row_num x - 1) i

let equal_area r1 r2 =
  ((r1.c-r1.a = r2.c-r2.a) && (r1.d-r1.b = r2.d-r2.b))

let same_area r1 r2 = r1 = r2

let set = Array2.unsafe_set

let get = Array2.unsafe_get

let row x i =
  let y = Array2.slice_left x i in
  reshape_2 (genarray_of_array1 y) 1 (col_num x)

let col x j =
  let m, n = shape x in
  let y = empty (Array2.kind x) m 1 in
  for i = 0 to m - 1 do
    Array2.unsafe_set y i 0 (Array2.unsafe_get x i j)
  done; y

let copy_area_to x1 r1 x2 r2 =
  if not (equal_area r1 r2) then
    failwith "Error: area mismatch"
  else
    for i = 0 to r1.c - r1.a do
      for j = 0 to r1.d - r1.b do
        Array2.unsafe_set x2 (r2.a + i) (r2.b + j)
        (Array2.unsafe_get x1 (r1.a + i) (r1.b + j))
      done
    done

let copy_to x1 x2 = Array2.blit x1 x2

let clone_area x r =
  let y = empty (Array2.kind x) (r.c - r.a + 1) (r.d - r.b + 1) in
  copy_area_to x r y (area_of y)

let clone x =
  let y = empty (Array2.kind x) (row_num x) (col_num x) in
  Array2.blit x y; y

let copy_row_to v x i =
  let u = row x i in
  copy_to v u

let copy_col_to v x i =
  let r1 = area_of v and r2 = area_of_col x i in
  copy_area_to v r1 x r2

let concat_vertical x1 x2 =
  let m1, m2 = row_num x1, row_num x2 in
  let n1, n2 = col_num x1, col_num x2 in
  let x3 = empty (Array2.kind x1) (m1 + m2) (min n1 n2) in
  for i = 0 to (m1 + m2) - 1 do
    let z = if i < m1 then row x1 i else row x2 (i - m1) in
    copy_row_to z x3 i
  done; x3

let concat_horizontal x1 x2 =
  let m1, m2 = row_num x1, row_num x2 in
  let n1, n2 = col_num x1, col_num x2 in
  let x3 = empty (Array2.kind x1) (min m1 m2) (n1 + n2)  in
  for i = 0 to (row_num x3) - 1 do
    for j = 0 to n1 - 1 do x3.{i,j} <- x1.{i,j} done;
    for j = 0 to n2 - 1 do x3.{i,j+n1} <- x2.{i,j} done;
  done; x3

let concatenate ?(axis=0) xs =
  assert (axis = 0 || axis = 1);
  let xs = Array.map to_ndarray xs in
  Owl_dense_ndarray_generic.concatenate ~axis xs
  |> of_ndarray

let rows x l =
  let m, n = Array.length (l), col_num x in
  let y = empty (Array2.kind x) m n in
  Array.iteri (fun i j -> copy_row_to (row x j) y i) l; y

let cols x l =
  let m, n = row_num x, Array.length (l) in
  let y = empty (Array2.kind x) m n in
  Array.iteri (fun i j -> copy_col_to (col x j) y i) l; y

let swap_rows x i i' = _eigen_swap_rows (kind x) x i i'

let swap_cols x j j' = _eigen_swap_cols (kind x) x j j'

(* let transpose x = _eigen_transpose (kind x) x *)
let transpose x =
  let y = empty (kind x) (col_num x) (row_num x) in
  Owl_backend_gsl_linalg.transpose_copy (kind x) y x;
  y

let replace_row v x i =
  let y = clone x in
  copy_row_to v y i; y

let replace_col v x i =
  let y = clone x in
  copy_col_to v y i; y

let tile x reps =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.tile x reps in
  of_ndarray y

let repeat ?axis x reps =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.repeat ?axis x reps in
  of_ndarray y

let reverse x =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.reverse x in
  of_ndarray y

let slice axis x =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.slice axis x in
  of_ndarray y

let pad ?v d x = Owl_dense_ndarray_generic.pad ?v d (to_ndarray x) |> of_ndarray


(* matrix iteration operations *)

let iteri f x =
  let m, n = shape x in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      f i j (Array2.unsafe_get x i j)
    done
  done

let iter f x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.iter f y

let iteri_rows f x =
  for i = 0 to (row_num x) - 1 do
    f i (row x i)
  done

let iter_rows f x = iteri_rows (fun _ y -> f y) x

let iter2i_rows f x y =
  if row_num x <> row_num y then failwith "error: iter2i_rows";
  iteri_rows (fun i u -> f i u (row y i)) x

let iter2_rows f x y = iter2i_rows (fun _ u v -> f u v) x y

let _row x i =  (* get row i of x, but return as a column vector *)
  let y = Array2.slice_left x i in
  reshape_2 (genarray_of_array1 y) (col_num x) 1

let iteri_cols f x =
  let y = transpose x in
  for i = 0 to (col_num x) - 1 do
    f i (_row y i)
  done

let iter_cols f x = iteri_cols (fun _ y -> f y) x

let mapi f x =
  let y = empty (Array2.kind x) (row_num x) (col_num x) in
  iteri (fun i j z -> Array2.unsafe_set y i j (f i j z)) x; y

let map f x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.map f y in
  of_ndarray y

let map2i f x y =
  if same_shape x y = false then failwith "error: map2i";
  let z = empty (Array2.kind x) (row_num x) (col_num x) in
  iteri (fun i j a ->
    let b = Array2.unsafe_get y i j in
    Array2.unsafe_set z i j (f i j a b)
  ) x; z

let map2 f x y = map2i (fun _ _ a b -> f a b) x y

let mapi_rows f x = Array.init (row_num x) (fun i -> f i (row x i))

let map_rows f x = mapi_rows (fun _ y -> f y) x

let mapi_cols f x =
  let y = transpose x in
  Array.init (col_num x) (fun i -> f i (_row y i))

let map_cols f x = mapi_cols (fun _ y -> f y) x

let mapi_by_row d f x =
  let y = empty (Array2.kind x) (row_num x) d in
  iteri_rows (fun i z ->
    copy_row_to (f i z) y i
  ) x; y

let map_by_row d f x = mapi_by_row d (fun _ y -> f y) x

let mapi_by_col d f x =
  let y = empty (Array2.kind x) d (col_num x) in
  iteri_cols (fun j z ->
    copy_col_to (f j z) y j
  ) x; y

let map_by_col d f x = mapi_by_col d (fun _ y -> f y) x

let filteri f x =
  let s = Owl_utils.Stack.make () in
  iteri (fun i j y ->
    if (f i j y) then Owl_utils.Stack.push s (i,j)
  ) x;
  Owl_utils.Stack.to_array s

let filter f x = filteri (fun _ _ y -> f y) x

let filteri_rows f x =
  let s = Owl_utils.Stack.make () in
  iteri_rows (fun i v ->
    if (f i v) then Owl_utils.Stack.push s i
  ) x;
  Owl_utils.Stack.to_array s

let filter_rows f x = filteri_rows (fun _ v -> f v) x

let filteri_cols f x =
  let s = Owl_utils.Stack.make () in
  iteri_cols (fun i v ->
    if (f i v) then Owl_utils.Stack.push s i
  ) x;
  Owl_utils.Stack.to_array s

let filter_cols f x = filteri_cols (fun _ v -> f v) x

let _fold_basic iter_fun f a x =
  let r = ref a in
  iter_fun (fun y -> r := f !r y) x;
  !r

let fold f a x = _fold_basic iter f a x

let fold_rows f a x = _fold_basic iter_rows f a x

let fold_cols f a x = _fold_basic iter_cols f a x

let foldi f a x =
  let r = ref a in
  iteri (fun i j y -> r := f i j !r y) x;
  !r

let exists f x =
  try iter (fun y ->
    if (f y) = true then failwith "found"
  ) x; false
  with exn -> true

let not_exists f x = not (exists f x)

let for_all f x = let g y = not (f y) in not_exists g x

let mapi_at_row f x i =
  let v = mapi (fun _ j y -> f i j y) (row x i) in
  let y = clone x in
  copy_row_to v y i; y

let map_at_row f x i = mapi_at_row (fun _ _ y -> f y) x i

let mapi_at_col f x j =
  let v = mapi (fun i _ y -> f i j y) (col x j) in
  let y = clone x in
  copy_col_to v y j; y

let map_at_col f x j = mapi_at_col (fun _ _ y -> f y) x j


(* matrix mathematical operations *)

(* general broadcast operations for add/sub/mul/div and etc.
  s: string of operation
  mv: operation index for [mat op vec]
  vm: operation index for [vec op mat]
 *)
let _broadcast_op s k mv vm x1 x2 m1 n1 m2 n2 =
  match m1 = m2, n1 = n2, m1 = 1, m2 = 1, n1 = 1, n2 = 1 with
  | true, false, _, _, true, false -> let y = clone x2 in (_eigen_colwise_op k) vm y x1; y
  | true, false, _, _, false, true -> let y = clone x1 in (_eigen_colwise_op k) mv y x2; y
  | false, true, true, false, _, _ -> let y = clone x2 in (_eigen_rowwise_op k) vm y x1; y
  | false, true, false, true, _, _ -> let y = clone x1 in (_eigen_rowwise_op k) mv y x2; y
  | _                              -> failwith ("_broadcast_op: " ^ s)

let add x1 x2 =
  let m1, n1 = shape x1 in
  let m2, n2 = shape x2 in
  match m1 = m2, n1 = n2 with
  | true, true -> (
      let y1 = to_ndarray x1 in
      let y2 = to_ndarray x2 in
      let y3 = Owl_dense_ndarray_generic.add y1 y2 in
      of_ndarray y3
    )
  | _, _      -> _broadcast_op "( + )" (kind x1) 0 0 x1 x2 m1 n1 m2 n2

let sub x1 x2 =
  let m1, n1 = shape x1 in
  let m2, n2 = shape x2 in
  match m1 = m2, n1 = n2 with
  | true, true -> (
      let y1 = to_ndarray x1 in
      let y2 = to_ndarray x2 in
      let y3 = Owl_dense_ndarray_generic.sub y1 y2 in
      of_ndarray y3
    )
  | _, _      -> _broadcast_op "( - )" (kind x1) 1 4 x1 x2 m1 n1 m2 n2

let mul x1 x2 =
  let m1, n1 = shape x1 in
  let m2, n2 = shape x2 in
  match m1 = m2, n1 = n2 with
  | true, true -> (
      let y1 = to_ndarray x1 in
      let y2 = to_ndarray x2 in
      let y3 = Owl_dense_ndarray_generic.mul y1 y2 in
      of_ndarray y3
    )
  | _, _      -> _broadcast_op "( * )" (kind x1) 2 2 x1 x2 m1 n1 m2 n2

let div x1 x2 =
  let m1, n1 = shape x1 in
  let m2, n2 = shape x2 in
  match m1 = m2, n1 = n2 with
  | true, true -> (
      let y1 = to_ndarray x1 in
      let y2 = to_ndarray x2 in
      let y3 = Owl_dense_ndarray_generic.div y1 y2 in
      of_ndarray y3
    )
  | _, _      -> _broadcast_op "( / )" (kind x1) 3 5 x1 x2 m1 n1 m2 n2

(* let dot x1 x2 = _eigen_dot (kind x1) x1 x2 *)
let dot x1 x2 = Owl_backend_gsl_linalg.dot (kind x1) x1 x2

let inv x = Owl_dense_common._eigen_inv (kind x) x

let sum_cols x =
  let y = ones (Array2.kind x) (col_num x) 1 in
  dot x y

let sum_rows x =
  let y = ones (Array2.kind x) 1 (row_num x) in
  dot y x

let average_cols x =
  let m, n = shape x in
  let k = Array2.kind x in
  let _a = (_average_elt k) (_one k) n in
  let y = create k n 1 _a in
  dot x y

let average_rows x =
  let m, n = shape x in
  let k = Array2.kind x in
  let _a = (_average_elt k) (_one k) m in
  let y = create k 1 m _a in
  dot y x

let is_zero x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.is_zero y

let is_positive x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.is_positive y

let is_negative x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.is_negative y

let is_nonnegative x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.is_nonnegative y

let is_nonpositive x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.is_nonpositive y

let equal x1 x2 = x1 = x2

let not_equal x1 x2 = x1 <> x2

let greater x1 x2 =
  let n = numel x1 in
  let y1 = to_ndarray x1 in
  let y1 = reshape y1 [|n|] |> array1_of_genarray in
  let y2 = to_ndarray x2 in
  let y2 = reshape y2 [|n|] |> array1_of_genarray in
  let _op = (_owl_greater (Array2.kind x1)) in
  (_op) (numel x1) y1 y2 = 1

let less x1 x2 =
  let n = numel x1 in
  let y1 = to_ndarray x1 in
  let y1 = reshape y1 [|n|] |> array1_of_genarray in
  let y2 = to_ndarray x2 in
  let y2 = reshape y2 [|n|] |> array1_of_genarray in
  let _op = (_owl_less (Array2.kind x1)) in
  (_op) (numel x1) y1 y2 = 1

let greater_equal x1 x2 =
  let n = numel x1 in
  let y1 = to_ndarray x1 in
  let y1 = reshape y1 [|n|] |> array1_of_genarray in
  let y2 = to_ndarray x2 in
  let y2 = reshape y2 [|n|] |> array1_of_genarray in
  let _op = (_owl_greater_equal (Array2.kind x1)) in
  (_op) (numel x1) y1 y2 = 1

let less_equal x1 x2 =
  let n = numel x1 in
  let y1 = to_ndarray x1 in
  let y1 = reshape y1 [|n|] |> array1_of_genarray in
  let y2 = to_ndarray x2 in
  let y2 = reshape y2 [|n|] |> array1_of_genarray in
  let _op = (_owl_less_equal (Array2.kind x1)) in
  (_op) (numel x1) y1 y2 = 1

let elt_equal x1 x2 = Owl_dense_ndarray_generic.elt_equal (to_ndarray x1) (to_ndarray x2) |> of_ndarray

let elt_not_equal x1 x2 = Owl_dense_ndarray_generic.elt_not_equal (to_ndarray x1) (to_ndarray x2) |> of_ndarray

let elt_less x1 x2 = Owl_dense_ndarray_generic.elt_less (to_ndarray x1) (to_ndarray x2) |> of_ndarray

let elt_greater x1 x2 = Owl_dense_ndarray_generic.elt_greater (to_ndarray x1) (to_ndarray x2) |> of_ndarray

let elt_less_equal x1 x2 = Owl_dense_ndarray_generic.elt_less_equal (to_ndarray x1) (to_ndarray x2) |> of_ndarray

let elt_greater_equal x1 x2 = Owl_dense_ndarray_generic.elt_greater_equal (to_ndarray x1) (to_ndarray x2) |> of_ndarray

let equal_scalar x a = Owl_dense_ndarray_generic.equal_scalar (to_ndarray x) a

let not_equal_scalar x a = Owl_dense_ndarray_generic.not_equal_scalar (to_ndarray x) a

let less_scalar x a = Owl_dense_ndarray_generic.less_scalar (to_ndarray x) a

let greater_scalar x a = Owl_dense_ndarray_generic.greater_scalar (to_ndarray x) a

let less_equal_scalar x a = Owl_dense_ndarray_generic.less_equal_scalar (to_ndarray x) a

let greater_equal_scalar x a = Owl_dense_ndarray_generic.greater_equal_scalar (to_ndarray x) a

let elt_equal_scalar x a = Owl_dense_ndarray_generic.elt_equal_scalar (to_ndarray x) a |> of_ndarray

let elt_not_equal_scalar x a = Owl_dense_ndarray_generic.elt_not_equal_scalar (to_ndarray x) a |> of_ndarray

let elt_less_scalar x a = Owl_dense_ndarray_generic.elt_less_scalar (to_ndarray x) a |> of_ndarray

let elt_greater_scalar x a = Owl_dense_ndarray_generic.elt_greater_scalar (to_ndarray x) a |> of_ndarray

let elt_less_equal_scalar x a = Owl_dense_ndarray_generic.elt_less_equal_scalar (to_ndarray x) a |> of_ndarray

let elt_greater_equal_scalar x a = Owl_dense_ndarray_generic.elt_greater_equal_scalar (to_ndarray x) a |> of_ndarray

let min x = Owl_dense_ndarray_generic.min (to_ndarray x)

let max x = Owl_dense_ndarray_generic.max (to_ndarray x)

let min_i x =
  let a, r = Owl_dense_ndarray_generic.min_i (to_ndarray x) in
  a, r.(0), r.(1)

let max_i x =
  let a, p = Owl_dense_ndarray_generic.max_i (to_ndarray x) in
  a, p.(0), p.(1)

let minmax x = Owl_dense_ndarray_generic.minmax (to_ndarray x)

let minmax_i x =
  let (a, p), (b, q) = Owl_dense_ndarray_generic.minmax_i (to_ndarray x) in
  (a, p.(0), p.(1)), (b, q.(0), q.(1))

let min_cols x =
  mapi_cols (fun j v ->
    let r, i, _ = min_i v in r, i, j
  ) x

let min_rows x =
  mapi_rows (fun i v ->
    let r, _, j = min_i v in r, i, j
  ) x

let max_cols x =
  mapi_cols (fun j v ->
    let r, i, _ = max_i v in r, i, j
  ) x

let max_rows x =
  mapi_rows (fun i v ->
    let r, _, j = max_i v in r, i, j
  ) x

let add_scalar x a =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.add_scalar y a in
  of_ndarray y

let sub_scalar x a =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.sub_scalar y a in
  of_ndarray y

let mul_scalar x a =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.mul_scalar y a in
  of_ndarray y

let div_scalar x a =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.div_scalar y a in
  of_ndarray y

let scalar_add a x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.scalar_add a y in
  of_ndarray y

let scalar_sub a x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.scalar_sub a y in
  of_ndarray y

let scalar_mul a x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.scalar_mul a y in
  of_ndarray y

let scalar_div a x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.scalar_div a y in
  of_ndarray y

let sum x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.sum y

let prod x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.prod y

let average x =
  let _op = _average_elt (kind x) in
  _op (sum x) (numel x)

let diag x =
  let m = Pervasives.min (row_num x) (col_num x) in
  let y = empty (Array2.kind x) 1 m in
  for i = 0 to m - 1 do y.{0,i} <- x.{i,i} done; y

let trace x = sum (diag x)

let add_diag x a =
  let m = Pervasives.min (row_num x) (col_num x) in
  let y = clone x in
  let _op = _add_elt (Array2.kind x) in
  for i = 0 to m - 1 do
    y.{i,i} <- _op x.{i,i} a
  done; y


(* formatted input / output operations *)

let reshape m n x =
  let x = genarray_of_array2 x in
  reshape_2 x m n

let flatten x = reshape 1 (numel x) x

(* TODO: improve performance

let of_arrays k x = Array2.of_array k c_layout x

let of_array k x m n = of_arrays k [|x|] |> reshape m n

let to_array x =
  let x = flatten x in
  Array.init (numel x) (fun i -> x.{0,i})

let to_arrays x = Array.init (row_num x) (fun i -> to_array (row x i))
*)

let of_array k x m n = Owl_backend_gsl_linalg.of_array k x m n

let to_array x = Owl_backend_gsl_linalg.to_array (kind x) x

let of_arrays k x = Owl_backend_gsl_linalg.of_arrays k x

let to_arrays x = Owl_backend_gsl_linalg.to_arrays (kind x) x

let to_rows x = Array.init (row_num x) (fun i -> row x i)

let to_cols x = Array.init (col_num x) (fun i -> col x i)

let of_rows l =
  let x = empty (kind l.(0)) (Array.length l) (col_num l.(0)) in
  Array.iteri (fun i v -> copy_row_to v x i) l;
  x

let of_cols l =
  let x = empty (kind l.(0)) (row_num l.(0)) (Array.length l)  in
  Array.iteri (fun i v -> copy_col_to v x i) l;
  x

(* FIXME *)
let save_txt x f =
  let _op = _owl_elt_to_str (Array2.kind x) in
  let h = open_out f in
  iter_rows (fun y ->
    iter (fun z -> Printf.fprintf h "%s\t" (_op z)) y;
    Printf.fprintf h "\n"
  ) x;
  close_out h

(* FIXME *)
let load_txt k f =
  let h = open_in f in
  let s = input_line h in
  let n = List.length(Str.split (Str.regexp "\t") s) in
  let m = ref 1 in (* counting lines in the input file *)
  let _ = try while true do ignore(input_line h); m := !m + 1
    done with End_of_file -> () in
  let x = zeros k !m n in seek_in h 0;
  for i = 0 to !m - 1 do
    let s = Str.split (Str.regexp "\t") (input_line h) in
    List.iteri (fun j y -> x.{i,j} <- float_of_string y) s
  done;
  close_in h; x

let save x f = Owl_utils.marshal_to_file x f

let load k f = Owl_utils.marshal_from_file f

let print x = _owl_print_mat (Array2.kind x) x

let pp_dsmat x = _owl_print_mat_toplevel (Array2.kind x) x

(* some other uncategorised functions *)

let uniform ?(scale=1.) k m n =
  let x = Owl_dense_ndarray_generic.uniform ~scale k [|m; n|] in
  of_ndarray x

let gaussian ?(sigma=1.) k m n =
  let _op = _owl_gaussian_fun k in
  let x = empty k m n in
  iteri (fun i j _ -> x.{i,j} <- _op sigma) x;
  x

let bernoulli k ?p ?seed m n =
  let x = Owl_dense_ndarray_generic.bernoulli k ?p ?seed [|m; n|] in
  of_ndarray x

let semidef k n =
  let x = uniform k n n in
  dot (transpose x) x

let draw_rows ?(replacement=true) x c =
  let a = Array.init (row_num x) (fun i -> i) in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in rows x l, l

let draw_cols ?(replacement=true) x c =
  let a = Array.init (col_num x) (fun i -> i) in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in cols x l, l

let draw_rows2 ?(replacement=true) x y c =
  let x_rows, l = draw_rows ~replacement x c in
  x_rows, rows y l, l

let draw_cols2 ?(replacement=true) x y c =
  let x_cols, l = draw_rows ~replacement x c in
  x_cols, cols y l, l

let shuffle_rows x =
  let y = clone x in
  let m, n = shape x in
  for i = 0 to m - 1 do
    swap_rows y i (Owl_stats.Rnd.uniform_int ~a:0 ~b:(m-1) ())
  done; y

let shuffle_cols x =
  let y = clone x in
  let m, n = shape x in
  for i = 0 to n - 1 do
    swap_cols y i (Owl_stats.Rnd.uniform_int ~a:0 ~b:(n-1) ())
  done; y

let shuffle x = x |> shuffle_rows |> shuffle_cols

let meshgrid k xa xb ya yb xn yn =
  let u = linspace k xa xb xn in
  let v = linspace k ya yb yn in
  let x = map_by_row xn (fun _ -> u) (empty k yn xn) in
  let y = map_by_row yn (fun _ -> v) (empty k xn yn) in
  x, transpose y

let meshup x y =
  let k = kind x in
  let xn = numel x in
  let yn = numel y in
  let x = map_by_row xn (fun _ -> x) (empty k yn xn) in
  let y = map_by_row yn (fun _ -> y) (empty k xn yn) in
  x, transpose y

let dropout ?rate ?seed x =
  let x = to_ndarray x in
  let x = Owl_dense_ndarray_generic.dropout ?rate ?seed x in
  of_ndarray x

(* unary matrix operation *)

let re_c2s x = x |> to_ndarray |> Owl_dense_ndarray_generic.re_c2s |> of_ndarray

let re_z2d x = x |> to_ndarray |> Owl_dense_ndarray_generic.re_z2d |> of_ndarray

let im_c2s x = x |> to_ndarray |> Owl_dense_ndarray_generic.im_c2s |> of_ndarray

let im_z2d x = x |> to_ndarray |> Owl_dense_ndarray_generic.im_z2d |> of_ndarray


(* TODO: optimise *)
let conj x = map Complex.conj x

let abs x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.abs y in
  of_ndarray y

let abs_c2s x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.abs_c2s y in
  of_ndarray y

let abs_z2d x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.abs_z2d y in
  of_ndarray y

let abs2 x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.abs2 y in
  of_ndarray y

let abs2_c2s x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.abs2_c2s y in
  of_ndarray y

let abs2_z2d x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.abs2_z2d y in
  of_ndarray y

let conj x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.conj y in
  of_ndarray y

let neg x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.neg y in
  of_ndarray y

let reci x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.reci y in
  of_ndarray y

let signum x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.signum y in
  of_ndarray y

let sqr x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.sqr y in
  of_ndarray y

let sqrt x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.sqrt y in
  of_ndarray y

let cbrt x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.cbrt y in
  of_ndarray y

let exp x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.exp y in
  of_ndarray y

let exp2 x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.exp2 y in
  of_ndarray y

let expm1 x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.expm1 y in
  of_ndarray y

let log x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.log y in
  of_ndarray y

let log10 x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.log10 y in
  of_ndarray y

let log2 x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.log2 y in
  of_ndarray y

let log1p x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.log1p y in
  of_ndarray y

let sin x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.sin y in
  of_ndarray y

let cos x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.cos y in
  of_ndarray y

let tan x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.tan y in
  of_ndarray y

let asin x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.asin y in
  of_ndarray y

let acos x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.acos y in
  of_ndarray y

let atan x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.atan y in
  of_ndarray y

let sinh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.sinh y in
  of_ndarray y

let cosh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.cosh y in
  of_ndarray y

let tanh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.tanh y in
  of_ndarray y

let asinh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.asinh y in
  of_ndarray y

let acosh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.acosh y in
  of_ndarray y

let atanh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.atanh y in
  of_ndarray y

let floor x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.floor y in
  of_ndarray y

let ceil x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.ceil y in
  of_ndarray y

let round x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.round y in
  of_ndarray y

let trunc x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.trunc y in
  of_ndarray y

let erf x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.erf y in
  of_ndarray y

let erfc x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.erfc y in
  of_ndarray y

let logistic x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.logistic y in
  of_ndarray y

let relu x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.relu y in
  of_ndarray y

let elu ?alpha x =
  to_ndarray x
  |> Owl_dense_ndarray_generic.elu ?alpha
  |> of_ndarray

let leaky_relu ?alpha x =
  to_ndarray x
  |> Owl_dense_ndarray_generic.leaky_relu ?alpha
  |> of_ndarray

let softplus x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.softplus y in
  of_ndarray y

let softsign x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.softsign y in
  of_ndarray y

let softmax x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.softmax y in
  of_ndarray y

let sigmoid x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray_generic.sigmoid y in
  of_ndarray y

let log_sum_exp x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.log_sum_exp y

let ssqr x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.ssqr y

let l1norm x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.l1norm y

let l2norm x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.l2norm y

let l2norm_sqr x =
  let y = to_ndarray x in
  Owl_dense_ndarray_generic.l2norm_sqr y

let cross_entropy x y =
  let x = to_ndarray x in
  let y = to_ndarray y in
  Owl_dense_ndarray_generic.cross_entropy x y


(* binary matrix operation *)

(* FIXME: obsolete *)
let pow_scalar x c =
  let _op = _power_scalar_elt (kind x) in
  map (fun y -> (_op) y c) x

let pow x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray_generic.pow x1 x2 in
  of_ndarray x3

let scalar_pow a x =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.scalar_pow a x in
  of_ndarray y

let pow_scalar x a =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.pow_scalar x a in
  of_ndarray y

let atan2 x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray_generic.atan2 x1 x2 in
  of_ndarray x3

let scalar_atan2 a x =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.scalar_atan2 a x in
  of_ndarray y

let atan2_scalar x a =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.atan2_scalar x a in
  of_ndarray y

let hypot x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray_generic.hypot x1 x2 in
  of_ndarray x3

let min2 x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray_generic.min2 x1 x2 in
  of_ndarray x3

let max2 x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray_generic.max2 x1 x2 in
  of_ndarray x3

let fmod x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray_generic.fmod x1 x2 in
  of_ndarray x3

let fmod_scalar x a =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.fmod_scalar x a in
  of_ndarray y

let scalar_fmod a x =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.scalar_fmod a x in
  of_ndarray y

let ssqr_diff x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  Owl_dense_ndarray_generic.ssqr_diff x1 x2

let clip_by_l2norm t x =
  let x = to_ndarray x in
  let y = Owl_dense_ndarray_generic.clip_by_l2norm t x in
  of_ndarray y

(* cast functions *)

let cast_s2d x = x |> to_ndarray |> Owl_dense_ndarray_generic.cast_s2d |> of_ndarray

let cast_d2s x = x |> to_ndarray |> Owl_dense_ndarray_generic.cast_d2s |> of_ndarray

let cast_c2z x = x |> to_ndarray |> Owl_dense_ndarray_generic.cast_c2z |> of_ndarray

let cast_z2c x = x |> to_ndarray |> Owl_dense_ndarray_generic.cast_z2c |> of_ndarray

let cast_s2c x = x |> to_ndarray |> Owl_dense_ndarray_generic.cast_s2c |> of_ndarray

let cast_d2z x = x |> to_ndarray |> Owl_dense_ndarray_generic.cast_d2z |> of_ndarray

let cast_s2z x = x |> to_ndarray |> Owl_dense_ndarray_generic.cast_s2z |> of_ndarray

let cast_d2c x = x |> to_ndarray |> Owl_dense_ndarray_generic.cast_d2c |> of_ndarray


(* experimental functions *)

let max_pool ?padding x kernel stride =
  let m, n = shape x in
  let x = to_ndarray x in
  let x = Owl_dense_ndarray_generic.reshape x [|1;m;n;1|] in
  let y = Owl_dense_ndarray_generic.max_pool2d ?padding x kernel stride in
  let s = Owl_dense_ndarray_generic.shape y in
  let m, n = s.(1), s.(2) in
  let y = Owl_dense_ndarray_generic.reshape y [|m;n|] in
  of_ndarray y

let avg_pool ?padding x kernel stride =
  let m, n = shape x in
  let x = to_ndarray x in
  let x = Owl_dense_ndarray_generic.reshape x [|1;m;n;1|] in
  let y = Owl_dense_ndarray_generic.avg_pool2d ?padding x kernel stride in
  let s = Owl_dense_ndarray_generic.shape y in
  let m, n = s.(1), s.(2) in
  let y = Owl_dense_ndarray_generic.reshape y [|m;n|] in
  of_ndarray y


(* end here *)
