(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Dense matrix ]  *)

open Bigarray
open Owl_types

type dsmat = Gsl.Matrix.matrix

type area = { a : int; b : int; c : int; d : int }

(* matrix creation operations *)

let size = None

let shape x = (Array2.dim1 x, Array2.dim2 x)

let row_num x = fst (shape x)

let col_num x = snd (shape x)

let numel x = (row_num x) * (col_num x)

let empty m n = Gsl.Matrix.create m n

let create m n v = Gsl.Matrix.create ~init:v m n

let ones m n = create m n 1.

let zeros m n = create m n 0.

let eye n =
  let x = zeros n n in
  for i = 0 to n - 1 do x.{i,i} <- 1. done; x

let sequential m n =
  let x = empty m n and c = ref 0 in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      c := !c + 1; x.{i,j} <- (float_of_int !c)
    done
  done; x

let vector n = empty 1 n

let vector_ones n = ones 1 n

let vector_zeros n = zeros 1 n

let linspace a b n =
  let x = empty 1 n in
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
  let y = empty m 1 in
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

let ( >> ) = copy_to

let ( << ) x1 x2 = copy_to x2 x1

let clone_area x r =
  let y = empty (r.c - r.a + 1) (r.d - r.b + 1) in
  copy_area_to x r y (area_of y)

let clone x =
  let y = empty (row_num x) (col_num x) in
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
  let x3 = empty (m1 + m2) (min n1 n2) in
  for i = 0 to (m1 + m2) - 1 do
    let z = if i < m1 then row x1 i else row x2 (i - m1) in
    copy_row_to z x3 i
  done; x3

let ( @= ) = concat_vertical

let concat_horizontal x1 x2 =
  let m1, m2 = row_num x1, row_num x2 in
  let n1, n2 = col_num x1, col_num x2 in
  let x3 = empty (min m1 m2) (n1 + n2)  in
  for i = 0 to (row_num x3) - 1 do
    for j = 0 to n1 - 1 do x3.{i,j} <- x1.{i,j} done;
    for j = 0 to n2 - 1 do x3.{i,j+n1} <- x2.{i,j} done;
  done; x3

let ( @|| ) = concat_horizontal

let rows x l =
  let m, n = Array.length (l), col_num x in
  let y = empty m n in
  Array.iteri (fun i j -> copy_row_to (row x j) y i) l; y

let cols x l =
  let m, n = row_num x, Array.length (l) in
  let y = empty m n in
  Array.iteri (fun i j -> copy_col_to (col x j) y i) l; y

let swap_rows = Gsl.Matrix.swap_rows

let swap_cols = Gsl.Matrix.swap_columns

let swap_rowcol = Gsl.Matrix.swap_rowcol

let transpose x =
  let y = empty (col_num x) (row_num x) in
  Gsl.Matrix.transpose y x; y

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

let iter f x = iteri (fun _ _ y -> f y) x

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
  let y = empty (row_num x) (col_num x) in
  iteri (fun i j z -> Array2.unsafe_set y i j (f i j z)) x; y

let map f x = mapi (fun _ _ y -> f y) x

let mapi_rows f x = Array.init (row_num x) (fun i -> f i (row x i))

let map_rows f x = mapi_rows (fun _ y -> f y) x

let mapi_cols f x =
  let y = transpose x in
  Array.init (col_num x) (fun i -> f i (_row y i))

let map_cols f x = mapi_cols (fun _ y -> f y) x

let mapi_by_row ?(d=0) f x =
  let n = if d > 0 then d else col_num (f 0 (row x 0)) in
  let y = empty (row_num x) n in
  iteri_rows (fun i z ->
    copy_row_to (f i z) y i
  ) x; y

let map_by_row ?(d=0) f x = mapi_by_row ~d (fun _ y -> f y) x

let mapi_by_col ?(d=0) f x =
  let m = if d > 0 then d else row_num (f 0 (col x 0)) in
  let y = empty m (col_num x) in
  iteri_cols (fun j z ->
    copy_col_to (f j z) y j
  ) x; y

let map_by_col ?(d=0) f x = mapi_by_col ~d (fun _ y -> f y) x

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

let inplace_map = None

(* matrix mathematical operations *)

let add x1 x2 =
  let x3 = clone x1 in
  Gsl.Matrix.add x3 x2; x3

let ( +@ ) = add

let sub x1 x2 =
  let x3 = clone x1 in
  Gsl.Matrix.sub x3 x2; x3

let ( -@ ) = sub

(* TODO: far too slow! need to find a solution! *)
let dot x1 x2 =
  let open Gsl.Blas in
  let x3 = empty (row_num x1) (col_num x2) in
  gemm ~ta:NoTrans ~tb:NoTrans ~alpha:1. ~beta:0. ~a:x1 ~b:x2 ~c:x3; x3

let ( $@ ) = dot

let mul x1 x2 =
  let x3 = clone x1 in
  Gsl.Matrix.mul_elements x3 x2; x3

let ( *@ ) = mul

let div x1 x2 =
  let x3 = clone x1 in
  Gsl.Matrix.div_elements x3 x2; x3

let ( /@ ) = div

let power x c = map (fun y -> y ** c) x

let ( **@ ) = power

let abs x = map abs_float x

let neg x =
  let y = clone x in
  Gsl.Matrix.scale y (-1.); y

let sum x =
  let y = ones 1 (row_num x) in
  let z = ones (col_num x) 1 in
  (dot (dot y x) z).{0,0}

let sum_cols x =
  let y = ones (col_num x) 1 in
  dot x y

let sum_rows x =
  let y = ones 1 (row_num x) in
  dot y x

let average x = (sum x) /. (float_of_int (numel x))

let average_cols x =
  let m, n = shape x in
  let y = create n 1 (1. /. (float_of_int n)) in
  dot x y

let average_rows x =
  let m, n = shape x in
  let y = create 1 m (1. /. (float_of_int m)) in
  dot y x

let stderr = None

let stderr_cols = None

let stderr_rows = None

let is_equal x1 x2 =
  let open Owl_matrix_foreign in
  let x1 = mat_to_matptr x1 in
  let x2 = mat_to_matptr x2 in
  (gsl_matrix_equal x1 x2) = 1

let ( =@ ) = is_equal

let is_unequal x1 x2 = not (is_equal x1 x2)

let ( <>@ ) = is_unequal

let is_greater x1 x2 =
  let open Owl_matrix_foreign in
  let x3 = sub x1 x2 in
  let x3 = mat_to_matptr x3 in
  (gsl_matrix_ispos x3) = 1

let ( >@ ) = is_greater

let is_smaller x1 x2 = is_greater x2 x1

let ( <@ ) = is_smaller

let equal_or_greater x1 x2 =
  let open Owl_matrix_foreign in
  let x3 = sub x1 x2 in
  let x3 = mat_to_matptr x3 in
  (gsl_matrix_isnonneg x3) = 1

let ( >=@ ) = equal_or_greater

let equal_or_smaller x1 x2 = equal_or_greater x2 x1

let ( <=@ ) = equal_or_smaller

let is_zero x =
  let open Owl_matrix_foreign in
  let x = mat_to_matptr x in
  (gsl_matrix_isnull x) = 1

let is_positive x =
  let open Owl_matrix_foreign in
  let x = mat_to_matptr x in
  (gsl_matrix_ispos x) = 1

let is_negative x =
  let open Owl_matrix_foreign in
  let x = mat_to_matptr x in
  (gsl_matrix_isneg x) = 1

let is_nonnegative x =
  let open Owl_matrix_foreign in
  let x = mat_to_matptr x in
  (gsl_matrix_isnonneg x) = 1

let min x =
  let open Owl_matrix_foreign in
  let open Ctypes in
  let x = mat_to_matptr x in
  let i = allocate int 0 in
  let j = allocate int 0 in
  let r = gsl_matrix_min x in
  let _ = gsl_matrix_min_index x i j in
  r, !@i, !@j

let min_cols x =
  mapi_cols (fun j v ->
    let r, i, _ = min v in r, i, j
  ) x

let min_rows x =
  mapi_rows (fun i v ->
    let r, _, j = min v in r, i, j
  ) x

let max x =
  let open Owl_matrix_foreign in
  let open Ctypes in
  let x = mat_to_matptr x in
  let i = allocate int 0 in
  let j = allocate int 0 in
  let r = gsl_matrix_max x in
  let _ = gsl_matrix_max_index x i j in
  r, !@i, !@j

let max_cols x =
  mapi_cols (fun j v ->
    let r, i, _ = max v in r, i, j
  ) x

let max_rows x =
  mapi_rows (fun i v ->
    let r, _, j = max v in r, i, j
  ) x

let minmax x =
  let xmin, irow, icol = min x in
  let xmax, arow, acol = max x in
  xmin, xmax, irow, icol, arow, acol

let ( +$ ) x a =
  let y = clone x in
  Gsl.Matrix.add_constant y a; y

let ( $+ ) a x = ( +$ ) x a

let ( -$ ) x a = ( +$ ) x (-1. *. a)

let ( $- ) a x = ( -$ ) x a

let ( *$ ) x a =
  let y = clone x in
  Gsl.Matrix.scale y a; y

let ( $* ) a x = ( *$ ) x a

let ( /$ ) x a = ( *$ ) x (1. /. a)

let ( $/ ) a x = ( /$ ) x a

let add_scalar = ( +$ )

let sub_scalar = ( -$ )

let mul_scalar = ( *$ )

let div_scalar = ( /$ )

(* advanced matrix methematical operations *)

let log x = map log x

let log10 x = map log10 x

let exp x = map exp x

let sigmoid x = map (fun y -> 1. /. (1. +. (Pervasives.exp (-1. *. y)))) x

let diag x =
  let m = Pervasives.min (row_num x) (col_num x) in
  let y = empty 1 m in
  for i = 0 to m - 1 do y.{0,i} <- x.{i,i} done; y

let trace x = sum (diag x)

let add_diag x a =
  let m = Pervasives.min (row_num x) (col_num x) in
  let y = clone x in
  for i = 0 to m - 1 do y.{i,i} <- x.{i,i} +. a done; y


(* formatted input / output operations *)

let to_array x = Gsl.Matrix.to_array x

let to_arrays x = Gsl.Matrix.to_arrays x

let of_array x m n = Gsl.Matrix.of_array x m n

let of_arrays x = Gsl.Matrix.of_arrays x

let save_txt x f =
  let h = open_out f in
  iter_rows (fun y ->  (* TODO: 64-bit -> 16 digits *)
    iter (fun z -> Printf.fprintf h "%.8f\t" z) y;
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
  let x = zeros !m n in seek_in h 0;
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

let load f =
  let h = open_in f in
  let s = really_input_string h (in_channel_length h) in
  Marshal.from_string s 0

let print x = let open Owl_pretty in
  Format.printf "%a\n" Owl_pretty.pp_fmat x;;

let pp_dsmat x = let open Owl_pretty in
  Format.printf "%a\n" Toplevel.pp_fmat x;;

(* some other uncategorised functions *)

let uniform_int ?(a=0) ?(b=99) m n =
  let x = empty m n in
  iteri (fun i j _ -> x.{i,j} <-
    float_of_int (Owl_stats.Rnd.uniform_int ~a ~b ())
  ) x; x

let uniform ?(scale=1.) m n =
  let x = empty m n in
  iteri (fun i j _ ->
    x.{i,j} <- Owl_stats.Rnd.uniform () *. scale
  ) x; x

let gaussian ?(sigma=1.) m n =
  let x = empty m n in
  iteri (fun i j _ -> x.{i,j} <- Owl_stats.Rnd.gaussian ~sigma ()) x; x

let vector_uniform n = uniform 1 n

let semidef n =
  let x = uniform n n in
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

let reshape m n x = of_array (to_array x) m n

let meshgrid xa xb ya yb xn yn =
  let u = linspace xa xb xn in
  let v = linspace ya yb yn in
  let x = map_by_row (fun _ -> u) (empty yn xn) in
  let y = map_by_row (fun _ -> v) (empty xn yn) in
  x, transpose y

let meshup x y =
  let xn = numel x in
  let yn = numel y in
  let x = map_by_row (fun _ -> x) (empty yn xn) in
  let y = map_by_row (fun _ -> y) (empty xn yn) in
  x, transpose y

let ( @@ ) f x = map f x  (* TODO: experimental *)

(* TODO: use this to replace col function, faster *)
let gsl_col x i =
  let open Owl_matrix_foreign in
  let y = allocate_col_vecptr (row_num x) in
  let _ = gsl_matrix_get_col y.vptr (mat_to_matptr x) i in
  y.vdata
