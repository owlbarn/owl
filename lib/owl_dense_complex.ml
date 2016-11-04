(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex dense matrix module ]  *)

open Bigarray
open Owl_types


type mat = Gsl.Matrix_complex.matrix

type elt = Complex.t

type area = { a : int; b : int; c : int; d : int }


let const_0 = Complex.zero

let const_1 = Complex.one

let empty m n = Gsl.Matrix_complex.create m n

let create m n v = Gsl.Matrix_complex.create ~init:v m n

let shape x = (Array2.dim1 x, Array2.dim2 x)

let row_num x = fst (shape x)

let col_num x = snd (shape x)

let numel x = (row_num x) * (col_num x)

let zeros m n = create m n const_0

let ones m n = create m n const_1

let eye n =
  let x = zeros n n in
  for i = 0 to n - 1 do
    x.{i,i} <- const_1
  done; x

let vector n = empty 1 n

let vector_ones n = ones 1 n

let vector_zeros n = zeros 1 n

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
        set x2 (r2.a + i) (r2.b + j)
        (get x1 (r1.a + i) (r1.b + j))
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

let swap_rows = Gsl.Matrix_complex.swap_rows

let swap_cols = Gsl.Matrix_complex.swap_columns

let swap_rowcol = Gsl.Matrix_complex.swap_rowcol

let transpose x =
  let y = empty (Array2.dim2 x) (Array2.dim1 x) in
  Gsl.Matrix_complex.transpose y x; y

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

let sequential m n =
  let x = empty m n and c = ref const_0 in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      c := Complex.(add !c const_1);
      x.{i,j} <- !c
    done
  done; x


(* matrix mathematical operations *)

let add x1 x2 =
  let x3 = clone x1 in
  Gsl.Matrix_complex.add x3 x2; x3

let sub x1 x2 =
  let x3 = clone x1 in
  Gsl.Matrix_complex.sub x3 x2; x3

let mul x1 x2 =
  let x3 = clone x1 in
  Gsl.Matrix_complex.mul_elements x3 x2; x3

let div x1 x2 =
  let x3 = clone x1 in
  Gsl.Matrix_complex.div_elements x3 x2; x3

let dot x1 x2 =
  let x3 = empty (row_num x1) (col_num x2) in
  let _ = Gsl.Blas.(Complex.gemm ~ta:NoTrans ~tb:NoTrans ~alpha:const_1 ~beta:const_0 ~a:x1 ~b:x2 ~c:x3)
  in x3

let power x c = map (fun y -> Complex.pow y c) x

let abs x = map (fun y -> Complex.({re = norm y; im = 0.})) x

let abs2 x = map (fun y -> Complex.({re = norm2 y; im = 0.})) x

let neg x =
  let y = clone x in
  Gsl.Matrix_complex.scale y Complex.({re = -1.; im = -1.}); y

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

let average x =
  let c = float_of_int (numel x) in
  Complex.(div (sum x) {re = c; im = 0.})

let average_cols x =
  let m, n = shape x in
  let c = 1. /. (float_of_int n) in
  let y = create n 1 Complex.({re = c; im = 0.}) in
  dot x y

let average_rows x =
  let m, n = shape x in
  let c = 1. /. (float_of_int m) in
  let y = create 1 m Complex.({re = c; im = 0.}) in
  dot y x

let is_equal x1 x2 =
  let open Owl_foreign in
  let open Owl_foreign.DC in
  let x1 = dc_mat_to_matptr x1 in
  let x2 = dc_mat_to_matptr x2 in
  (gsl_matrix_complex_equal x1 x2) = 1

let ( =@ ) = is_equal

let is_unequal x1 x2 = not (is_equal x1 x2)

let ( <>@ ) = is_unequal

let is_greater x1 x2 =
  let open Owl_foreign in
  let open Owl_foreign.DC in
  let x3 = sub x1 x2 in
  let x3 = dc_mat_to_matptr x3 in
  (gsl_matrix_complex_ispos x3) = 1

let ( >@ ) = is_greater

let is_smaller x1 x2 = is_greater x2 x1

let ( <@ ) = is_smaller

let equal_or_greater x1 x2 =
  let open Owl_foreign in
  let open Owl_foreign.DC in
  let x3 = sub x1 x2 in
  let x3 = dc_mat_to_matptr x3 in
  (gsl_matrix_complex_isnonneg x3) = 1

let ( >=@ ) = equal_or_greater

let equal_or_smaller x1 x2 = equal_or_greater x2 x1

let ( <=@ ) = equal_or_smaller

let is_zero x = Gsl.Matrix_complex.is_null x

let is_positive x =
  let open Owl_foreign in
  let open Owl_foreign.DC in
  let x = dc_mat_to_matptr x in
  (gsl_matrix_complex_ispos x) = 1

let is_negative x =
  let open Owl_foreign in
  let open Owl_foreign.DC in
  let x = dc_mat_to_matptr x in
  (gsl_matrix_complex_isneg x) = 1

let is_nonnegative x =
  let open Owl_foreign in
  let open Owl_foreign.DC in
  let x = dc_mat_to_matptr x in
  (gsl_matrix_complex_isnonneg x) = 1

let ( +@ ) = add

let ( -@ ) = sub

let ( *@ ) = mul

let ( /@ ) = div

let ( $@ ) = dot

let ( **@ ) = power

let ( +$ ) x a =
  let y = clone x in
  Gsl.Matrix_complex.add_constant y a; y

let ( $+ ) a x = ( +$ ) x a

let ( -$ ) x a = ( +$ ) x (Complex.neg a)

let ( $- ) a x = ( -$ ) x a

let ( *$ ) x a =
  let y = clone x in
  Gsl.Matrix_complex.scale y a; y

let ( $* ) a x = ( *$ ) x a

let ( /$ ) x a = ( *$ ) x (Complex.inv a)

let ( $/ ) a x = ( /$ ) x a

let add_scalar = ( +$ )

let sub_scalar = ( -$ )

let mul_scalar = ( *$ )

let div_scalar = ( /$ )

(* advanced matrix methematical operations *)

let log x = map Gsl_complex.log x

let log10 x = map Gsl_complex.log10 x

let exp x = map Gsl_complex.exp x

let sin x = map Gsl_complex.sin x

let cos x = map Gsl_complex.cos x


let diag x =
  let m = Pervasives.min (row_num x) (col_num x) in
  let y = empty 1 m in
  for i = 0 to m - 1 do y.{0,i} <- x.{i,i} done; y

let trace x = sum (diag x)

let add_diag x a =
  let m = Pervasives.min (row_num x) (col_num x) in
  let y = clone x in
  for i = 0 to m - 1 do
    y.{i,i} <- (Complex.add x.{i,i} a)
  done; y


(* some other uncategorised functions *)

let uniform_int ?(a=0) ?(b=99) m n =
  let x = empty m n in
  iteri (fun i j _ ->
    let re = float_of_int (Owl_stats.Rnd.uniform_int ~a ~b ()) in
    let im = float_of_int (Owl_stats.Rnd.uniform_int ~a ~b ()) in
    x.{i,j} <- Complex.({re; im})
  ) x; x

let uniform ?(scale=1.) m n =
  let x = empty m n in
  iteri (fun i j _ ->
    let re = Owl_stats.Rnd.uniform () *. scale in
    let im = Owl_stats.Rnd.uniform () *. scale in
    x.{i,j} <- Complex.({re; im})
  ) x; x

let gaussian ?(sigma=1.) m n =
  let x = empty m n in
  iteri (fun i j _ ->
    let re = Owl_stats.Rnd.gaussian ~sigma () in
    let im = Owl_stats.Rnd.gaussian ~sigma () in
    x.{i,j} <- Complex.({re; im})
  ) x; x

let vector_uniform n = uniform 1 n

let permutation_matrix d =
  let l = Array.init d (fun x -> x) |> Owl_stats.shuffle in
  let y = zeros d d in
  let _ = Array.iteri (fun i j -> set y i j const_1) l in y

let draw_rows ?(replacement=true) x c =
  let m, n = shape x in
  let a = Array.init m (fun x -> x) |> Owl_stats.shuffle in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in
  let y = zeros c m in
  let _ = Array.iteri (fun i j -> set y i j const_1) l in
  dot y x, l

let draw_cols ?(replacement=true) x c =
  let m, n = shape x in
  let a = Array.init n (fun x -> x) |> Owl_stats.shuffle in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in
  let y = zeros n c in
  let _ = Array.iteri (fun j i -> set y i j const_1) l in
  dot x y, l

let shuffle_rows x =
  let y = permutation_matrix (row_num x) in dot y x

let shuffle_cols x =
  let y = permutation_matrix (col_num x) in dot x y

let shuffle x = x |> shuffle_rows |> shuffle_cols


(* formatted input / output operations *)

let to_array x = Gsl.Matrix_complex.to_array x

let to_arrays x = Gsl.Matrix_complex.to_arrays x

let of_array x m n = Gsl.Matrix_complex.of_array x m n

let of_arrays x = Gsl.Matrix_complex.of_arrays x

let reshape m n x = of_array (to_array x) m n

let save x f =
  let s = Marshal.to_string x [] in
  let h = open_out f in
  output_string h s;
  close_out h

let load f =
  let h = open_in f in
  let s = really_input_string h (in_channel_length h) in
  Marshal.from_string s 0

let print x =
  let open Owl_pretty in
  Format.printf "%a\n" Owl_pretty.pp_cmat x;;

let pp_dsmat x = Format.printf "%a\n" Owl_pretty.Toplevel.pp_cmat x

let re = None

let im = None
