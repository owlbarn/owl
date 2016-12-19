(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_common

type ('a, 'b) mat = ('a, 'b, c_layout) Array2.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type area = { a : int; b : int; c : int; d : int }

type mat_d = (float, Bigarray.float64_elt) mat

(* transform between different format *)

let to_ndarray x = Obj.magic (Bigarray.genarray_of_array2 x)

let of_ndarray x = Bigarray.array2_of_genarray (Obj.magic x)

(* c_layout -> fortran_layout *)
let c2fortran_matrix x =
  let y = Bigarray.genarray_of_array2 x in
  let y = Genarray.change_layout y fortran_layout in
  Bigarray.array2_of_genarray y

(* fortran_layout -> c_layout *)
let fortran2c_matrix x =
  let y = Bigarray.genarray_of_array2 x in
  let y = Genarray.change_layout y c_layout in
  Bigarray.array2_of_genarray y

(* matrix creation operations *)

let _kind x = Array2.kind x

let size_in_bytes x = Array2.size_in_bytes x

let shape x = (Array2.dim1 x, Array2.dim2 x)

let row_num x = Array2.dim1 x

let col_num x = Array2.dim2 x

let numel x = (row_num x) * (col_num x)

let fill x a = Array2.fill x a

let empty k m n = Array2.create k c_layout m n

let zeros k m n = (_make0 k) n m |> fortran2c_matrix

let create k m n a =
  let x = empty k m n in
  fill x a; x

let ones k m n = create k m n (_one k)

let eye k n =
  let x = zeros k n n in
  let a = _one k in
  for i = 0 to n - 1 do
    Array2.unsafe_set x i i a
  done; x

let sequential k m n =
  let x = empty k m n in
  let c = ref (_zero k) in
  let a = _one k in
  let _op = _add_elt k in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      c := _op !c a;
      Array2.unsafe_set x i j !c
    done
  done; x

let vector k n = empty k 1 n

let vector_ones k n = ones k 1 n

let vector_zeros k n = zeros k 1 n

(* FIXME *)
let linspace a b n =
  let x = empty Float64 1 n in
  let c = ((b -. a) /. (float_of_int (n - 1))) in
  for i = 0 to n - 1 do
    x.{0,i} <- a +. c *. (float_of_int i)
  done; x

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

let rows x l =
  let m, n = Array.length (l), col_num x in
  let y = empty (Array2.kind x) m n in
  Array.iteri (fun i j -> copy_row_to (row x j) y i) l; y

let cols x l =
  let m, n = row_num x, Array.length (l) in
  let y = empty (Array2.kind x) m n in
  Array.iteri (fun i j -> copy_col_to (col x j) y i) l; y

let swap_rows x i i' =
  let y = clone x in
  let _op = _gsl_swap_rows (Array2.kind x) in
  _op y i i';
  y

let swap_cols x j j' =
  let y = clone x in
  let _op = _gsl_swap_cols (Array2.kind x) in
  _op y j j';
  y

let swap_rowcol x i j =
  let y = clone x in
  Gsl.Matrix.swap_rowcol y i j;
  y

let transpose x =
  let y = empty (Array2.kind x) (col_num x) (row_num x) in
  let _op = _gsl_transpose_copy (Array2.kind x) in
  _op y x; y

let replace_row v x i =
  let y = clone x in
  copy_row_to v y i; y

let replace_col v x i =
  let y = clone x in
  copy_col_to v y i; y

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
  Owl_dense_ndarray.iter f y

let iteri_rows f x =
  for i = 0 to (row_num x) - 1 do
    f i (row x i)
  done

let iter_rows f x = iteri_rows (fun _ y -> f y) x

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
  let y = Owl_dense_ndarray.map f y in
  of_ndarray y

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
  let r = ref [||] in
  iteri (fun i j y ->
    if (f i j y) then r := Array.append !r [|(i,j)|]
  ) x; !r

let filter f x = filteri (fun _ _ y -> f y) x

let filteri_rows f x =
  let r = ref [||] in
  let _ = iteri_rows (fun i v ->
    if (f i v) then r := Array.append !r [|i|]
  ) x in !r

let filter_rows f x = filteri_rows (fun _ v -> f v) x

let filteri_cols f x =
  let r = ref [||] in
  let _ = iteri_cols (fun i v ->
    if (f i v) then r := Array.append !r [|i|]
  ) x in !r

let filter_cols f x = filteri_cols (fun _ v -> f v) x

let _fold_basic iter_fun f a x =
  let r = ref a in
  iter_fun (fun y -> r := f !r y) x; !r

let fold f a x = _fold_basic iter f a x

let fold_rows f a x = _fold_basic iter_rows f a x

let fold_cols f a x = _fold_basic iter_cols f a x

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

let add x1 x2 =
  let y1 = to_ndarray x1 in
  let y2 = to_ndarray x2 in
  let y3 = Owl_dense_ndarray.add y1 y2 in
  of_ndarray y3

let sub x1 x2 =
  let y1 = to_ndarray x1 in
  let y2 = to_ndarray x2 in
  let y3 = Owl_dense_ndarray.sub y1 y2 in
  of_ndarray y3

let mul x1 x2 =
  let y1 = to_ndarray x1 in
  let y2 = to_ndarray x2 in
  let y3 = Owl_dense_ndarray.mul y1 y2 in
  of_ndarray y3

let div x1 x2 =
  let y1 = to_ndarray x1 in
  let y2 = to_ndarray x2 in
  let y3 = Owl_dense_ndarray.div y1 y2 in
  of_ndarray y3

let dot x1 x2 = (_gsl_dot (Array2.kind x1)) x1 x2

let sum_cols x =
  let y = ones (Array2.kind x) (col_num x) 1 in
  dot x y

let sum_rows x =
  let y = ones (Array2.kind x) 1 (row_num x) in
  dot y x

let average_cols x =
  let m, n = shape x in
  let y = create (Array2.kind x) n 1 (1. /. (float_of_int n)) in
  dot x y

let average_rows x =
  let m, n = shape x in
  let y = create (Array2.kind x) 1 m (1. /. (float_of_int m)) in
  dot y x

let is_zero x =
  let _op = _gsl_isnull (Array2.kind x) in
  _op x

let is_positive x =
  let _op = _gsl_ispos (Array2.kind x) in
  _op x

let is_negative x =
  let _op = _gsl_isneg (Array2.kind x) in
  _op x

let is_nonnegative x =
  let _op = _gsl_isnonneg (Array2.kind x) in
  _op x

let is_nonpositive x =
  let _op = _gsl_ispos (Array2.kind x) in
  not (_op x)

let is_equal x1 x2 = x1 = x2

let is_unequal x1 x2 = x1 <> x2

let is_greater x1 x2 =
  let n = numel x1 in
  let y1 = to_ndarray x1 in
  let y1 = reshape y1 [|n|] |> array1_of_genarray in
  let y2 = to_ndarray x2 in
  let y2 = reshape y2 [|n|] |> array1_of_genarray in
  let _op = (_owl_is_greater (Array2.kind x1)) in
  (_op) (numel x1) y1 y2 = 1

let is_smaller x1 x2 =
  let n = numel x1 in
  let y1 = to_ndarray x1 in
  let y1 = reshape y1 [|n|] |> array1_of_genarray in
  let y2 = to_ndarray x2 in
  let y2 = reshape y2 [|n|] |> array1_of_genarray in
  let _op = (_owl_is_smaller (Array2.kind x1)) in
  (_op) (numel x1) y1 y2 = 1

let equal_or_greater x1 x2 =
  let n = numel x1 in
  let y1 = to_ndarray x1 in
  let y1 = reshape y1 [|n|] |> array1_of_genarray in
  let y2 = to_ndarray x2 in
  let y2 = reshape y2 [|n|] |> array1_of_genarray in
  let _op = (_owl_equal_or_greater (Array2.kind x1)) in
  (_op) (numel x1) y1 y2 = 1

let equal_or_smaller x1 x2 =
  let n = numel x1 in
  let y1 = to_ndarray x1 in
  let y1 = reshape y1 [|n|] |> array1_of_genarray in
  let y2 = to_ndarray x2 in
  let y2 = reshape y2 [|n|] |> array1_of_genarray in
  let _op = (_owl_equal_or_smaller (Array2.kind x1)) in
  (_op) (numel x1) y1 y2 = 1

let min : type a b . (a, b) mat -> a = fun x ->
  let k = Array2.kind x in
  match k with
  | Complex32 -> Owl_dense_ndarray.min (to_ndarray x)
  | Complex64 -> Owl_dense_ndarray.min (to_ndarray x)
  | _ -> (_gsl_min k) x

let max : type a b . (a, b) mat -> a = fun x ->
  let k = Array2.kind x in
  match k with
  | Complex32 -> Owl_dense_ndarray.max (to_ndarray x)
  | Complex64 -> Owl_dense_ndarray.max (to_ndarray x)
  | _ -> (_gsl_max k) x

let min_i x = (_gsl_min_index (Array2.kind x)) x

let max_i x = (_gsl_max_index (Array2.kind x)) x

let minmax x = (_gsl_minmax (Array2.kind x)) x

let minmax_i x = (_gsl_minmax_index (Array2.kind x)) x

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
  let y = Owl_dense_ndarray.add_scalar y a in
  of_ndarray y

let sub_scalar x a =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.sub_scalar y a in
  of_ndarray y

let mul_scalar x a =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.mul_scalar y a in
  of_ndarray y

let div_scalar x a =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.div_scalar y a in
  of_ndarray y

let sum x =
  let y = to_ndarray x in
  Owl_dense_ndarray.sum y

let average x = (sum x) /. (float_of_int (numel x))

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

let to_array x = Gsl.Matrix.to_array x

let to_arrays x = Gsl.Matrix.to_arrays x

let of_array x m n = Gsl.Matrix.of_array x m n

let of_arrays x = Gsl.Matrix.of_arrays x

let save_txt x f =
  let _op = _owl_elt_to_str (Array2.kind x) in
  let h = open_out f in
  iter_rows (fun y ->
    iter (fun z -> Printf.fprintf h "%s\t" (_op z)) y;
    Printf.fprintf h "\n"
  ) x;
  close_out h

let load_txt f =
  let h = open_in f in
  let s = input_line h in
  let n = List.length(Str.split (Str.regexp "\t") s) in
  let m = ref 1 in (* counting lines in the input file *)
  let _ = try while true do ignore(input_line h); m := !m + 1
    done with End_of_file -> () in
  let x = zeros Float64 !m n in seek_in h 0;
  for i = 0 to !m - 1 do
    let s = Str.split (Str.regexp "\t") (input_line h) in
    List.iteri (fun j y -> x.{i,j} <- float_of_string y) s
  done;
  close_in h; x

let save x f =
  let s = Marshal.to_string x [] in
  let h = open_out f in
  output_string h s;
  close_out h

let load : type a b . (a, b) kind -> string -> (a, b) mat = fun k f ->
  let h = open_in f in
  let s = really_input_string h (in_channel_length h) in
  Marshal.from_string s 0

let print x = _owl_print_mat (Array2.kind x) x

let pp_dsmat x = _owl_print_mat_toplevel (Array2.kind x) x

(* some other uncategorised functions *)

let uniform ?(scale=1.) k m n =
  let x = Owl_dense_ndarray.uniform ~scale k [|m; n|] in
  of_ndarray x

let gaussian ?(sigma=1.) k m n =
  let _op = _owl_gaussian k in
  let x = empty k m n in
  iteri (fun i j _ -> x.{i,j} <- _op sigma) x;
  x

let vector_uniform k n = uniform k 1 n

let semidef k n =
  let x = uniform k n n in
  dot (transpose x) x

let draw_rows ?(replacement=true) x c =
  let a = Array.init (row_num x - 1) (fun i -> i) in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in rows x l, l

let draw_cols ?(replacement=true) x c =
  let a = Array.init (col_num x - 1) (fun i -> i) in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in cols x l, l

let shuffle_rows x =
  let y = clone x in
  let m, n = shape x in
  let _op = _gsl_swap_rows (Array2.kind x) in
  for i = 0 to m - 1 do
    _op y i (Owl_stats.Rnd.uniform_int ~a:0 ~b:(m-1) ())
  done; y

let shuffle_cols x =
  let y = clone x in
  let m, n = shape x in
  let _op = _gsl_swap_cols (Array2.kind x) in
  for i = 0 to n - 1 do
    _op y i (Owl_stats.Rnd.uniform_int ~a:0 ~b:(n-1) ())
  done; y

let shuffle x = x |> shuffle_rows |> shuffle_cols

let reshape m n x =
  let x = genarray_of_array2 x in
  reshape_2 x m n

let meshgrid xa xb ya yb xn yn =
  let u = linspace xa xb xn in
  let v = linspace ya yb yn in
  let x = map_by_row xn (fun _ -> u) (empty Float64 yn xn) in
  let y = map_by_row yn (fun _ -> v) (empty Float64 xn yn) in
  x, transpose y

let meshup x y =
  let xn = numel x in
  let yn = numel y in
  let x = map_by_row xn (fun _ -> x) (empty Float64 yn xn) in
  let y = map_by_row yn (fun _ -> y) (empty Float64 xn yn) in
  x, transpose y

(* unary matrix operation *)

let re x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.re y in
  of_ndarray y

let im x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.im y in
  of_ndarray y

(* TODO: optimise *)
let conj x = map Complex.conj x

let abs x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.abs y in
  of_ndarray y

let neg x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.neg y in
  of_ndarray y

let signum x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.signum y in
  of_ndarray y

let sqr x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.sqr y in
  of_ndarray y

let sqrt x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.sqrt y in
  of_ndarray y

let cbrt x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.cbrt y in
  of_ndarray y

let exp x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.exp y in
  of_ndarray y

let exp2 x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.exp2 y in
  of_ndarray y

let expm1 x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.expm1 y in
  of_ndarray y

let log x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.log y in
  of_ndarray y

let log10 x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.log10 y in
  of_ndarray y

let log2 x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.log2 y in
  of_ndarray y

let log1p x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.log1p y in
  of_ndarray y

let sin x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.sin y in
  of_ndarray y

let cos x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.cos y in
  of_ndarray y

let tan x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.tan y in
  of_ndarray y

let asin x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.asin y in
  of_ndarray y

let acos x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.acos y in
  of_ndarray y

let atan x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.atan y in
  of_ndarray y

let sinh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.sinh y in
  of_ndarray y

let cosh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.cosh y in
  of_ndarray y

let tanh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.tanh y in
  of_ndarray y

let asinh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.asinh y in
  of_ndarray y

let acosh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.acosh y in
  of_ndarray y

let atanh x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.atanh y in
  of_ndarray y

let floor x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.floor y in
  of_ndarray y

let ceil x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.ceil y in
  of_ndarray y

let round x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.round y in
  of_ndarray y

let trunc x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.trunc y in
  of_ndarray y

let erf x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.erf y in
  of_ndarray y

let erfc x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.erfc y in
  of_ndarray y

let logistic x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.logistic y in
  of_ndarray y

let relu x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.relu y in
  of_ndarray y

let softplus x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.softplus y in
  of_ndarray y

let softsign x =
  let y = to_ndarray x in
  let y = Owl_dense_ndarray.softsign y in
  of_ndarray y

let sigmoid x = map (fun y -> 1. /. (1. +. (Pervasives.exp (-1. *. y)))) x

(* binary matrix operation *)

let pow x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray.pow x1 x2 in
  of_ndarray x3

let atan2 x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray.atan2 x1 x2 in
  of_ndarray x3

let hypot x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray.hypot x1 x2 in
  of_ndarray x3

let min2 x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray.min2 x1 x2 in
  of_ndarray x3

let max2 x1 x2 =
  let x1 = to_ndarray x1 in
  let x2 = to_ndarray x2 in
  let x3 = Owl_dense_ndarray.max2 x1 x2 in
  of_ndarray x3

(* shorhand infix operators *)

let ( @= ) = concat_vertical

let ( @|| ) = concat_horizontal

let ( >> ) = copy_to

let ( << ) x1 x2 = copy_to x2 x1

let ( +@ ) = add

let ( -@ ) = sub

let ( *@ ) = mul

let ( /@ ) = div

let ( =@ ) = ( = )

let ( <>@ ) = ( <> )

let ( >@ ) = is_greater

let ( <@ ) = is_smaller

let ( >=@ ) = equal_or_greater

let ( <=@ ) = equal_or_smaller

let ( +$ ) x a = add_scalar x a

let ( $+ ) a x = add_scalar x a

let ( -$ ) x a = sub_scalar x a

let ( $- ) a x = sub_scalar x a

let ( *$ ) x a = mul_scalar x a

let ( $* ) a x = mul_scalar x a

let ( /$ ) x a = div_scalar x a

let ( $/ ) a x = div_scalar x a

let ( @@ ) f x = map f x
