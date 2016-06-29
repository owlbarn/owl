(** [
  Wrap up Lacaml module
  Note: C layout row-major matrix
  The layout is really important, can impact the performance greatly!
  ]  *)

open Bigarray

type matrix = Gsl.Matrix.matrix

type area = { a : int; b : int; c : int; d : int }

module Dense = struct

  (* matrix creation operations *)

  let size = None

  let shape x = (Array2.dim1 x, Array2.dim2 x)

  let row_num x = fst (shape x)

  let col_num x = snd (shape x)

  let numel x = (row_num x) * (col_num x)

  let empty = Gsl.Matrix.create

  let create m n v = empty ~init:v m n

  let ones m n = create m n 1.

  let zeros m n = create m n 0.

  let eye n =
    let x = zeros n n in
    for i = 0 to n - 1 do x.{i,i} <- 1. done; x

  let identity = eye

  let sequential m n =
    let x = empty m n and c = ref 0 in
    for i = 0 to m - 1 do
      for j = 0 to n - 1 do
        c := !c + 1; x.{i,j} <- (float_of_int !c)
      done
    done; x

  let random m n = None

  let vector n = empty 1 n

  let vector_ones n = ones 1 n

  let vector_zeros n = zeros 1 n

  let vector_random = None

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
    let y = empty (row_num x) (col_num x) in
    Gsl.Matrix.transpose x y; x

  let diag x =
    let m = min (row_num x) (col_num x) in
    let y = empty 1 m in
    for i = 0 to m - 1 do y.{0,i} <- x.{i,i} done; y

  let trace = None

  let add_diag = None

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

  let _iteri_cols f x =  (* TODO: slow, use iteri_cols instead *)
    for i = 0 to (col_num x) - 1 do
      f i (col x i)
    done

  let _row x i =
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

  let mapi_cols f x = Array.init (col_num x) (fun i -> f i (col x i))

  let map_cols f x = mapi_cols (fun _ y -> f y) x

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

  let dot x1 x2 = let open Gsl.Blas in
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

  let abs x = None

  let neg x = None

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

  let is_equal x1 x2 = for_all (( = ) 0.) (sub x1 x2)

  let ( =@ ) = is_equal

  let is_unequal x1 x2 = not (is_equal x1 x2)

  let ( <>@ ) = is_unequal

  let is_greater x1 x2 = for_all (( < ) 0.) (sub x1 x2)

  let ( >@ ) = is_greater

  let is_smaller x1 x2 = for_all (( > ) 0.) (sub x1 x2)

  let ( <@ ) = is_smaller

  let equal_or_greater x1 x2 = for_all (( <= ) 0.) (sub x1 x2)

  let ( >=@ ) = equal_or_greater

  let equal_or_smaller x1 x2 = for_all (( >= ) 0.) (sub x1 x2)

  let ( <=@ ) = equal_or_smaller

  let min x =
    let r = ref max_float and p = ref (0,0) in
    iteri (fun i j y ->
      if y < !r then (r := y; p := (i,j))
    ) x; !r, !p

  let min_col x =
    mapi_cols (fun j v ->
      let r, (i, _) = min v in r, (i,j)
    ) x

  let min_row x =
    mapi_rows (fun i v ->
      let r, (_, j) = min v in r, (i,j)
    ) x

  let max x =
    let r = ref min_float and p = ref (0,0) in
    iteri (fun i j y ->
      if y > !r then (r := y; p := (i,j))
    ) x; !r, !p

  let max_col x =
    mapi_cols (fun j v ->
      let r, (i, _) = max v in r, (i,j)
    ) x

  let max_row x =
    mapi_rows (fun i v ->
      let r, (_, j) = max v in r, (i,j)
    ) x

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

  (* advanced matrix methematical operations *)

  let detri x = x

  let lu x = x

  let qr x = x

  let cholesky x = x

  let svd x = let open Gsl.Vectmat in
    let m, n = shape x in
    let y, v = `M (clone x), `M (empty n n) in
    let s, w = `V (Gsl.Vector.create n), `V (Gsl.Vector.create n) in
    let _ = Gsl.Linalg._SV_decomp y v s w in
    match y, s, v with `M y, `V s, `M v -> y, s, v

  let sdd x = x

  let inv x = x

  let least_square x = x

  (* formatted input / output operations *)

  let dump x f =
    let h = open_out f in
    iter_rows (fun y ->  (* TODO: 64-bit -> 16 digits *)
      iter (fun z -> Printf.fprintf h "%.8f " z) y;
      Printf.fprintf h "\n"
    ) x;
    close_out h

  let load f =
    let h = open_in f in
    let s = input_line h in
    let n = List.length(Str.split (Str.regexp " ") s) in
    let m = ref 1 in (* counting lines in the input file *)
    let _ = try while true do ignore(input_line h); m := !m + 1
      done with End_of_file -> () in
    let x = zeros !m n in seek_in h 0;
    for i = 0 to !m - 1 do
      let s = Str.split (Str.regexp " ") (input_line h) in
      List.iteri (fun j y -> x.{i,j} <- float_of_string y) s
    done;
    close_in h; x

  let pprint x =
    let m = Pervasives.min 10 (row_num x) in
    let n = Pervasives.min 10 (col_num x) in
    for i = 0 to m - 1 do
      for j = 0 to n - 1 do
        Printf.printf "%.2f " x.{i,j}
      done;
      if n < (col_num x) then print_endline "..."
      else print_endline ""
    done;
    if m < (row_num x) then print_endline "..."
    else print_endline ""

  let print x = let open Pretty in
    Format.printf "%a\n" Pretty.pp_fmat x;;

  let pprint x = let open Pretty in
    Format.printf "%a\n" Toplevel.pp_fmat x;;

  (* other functions *)

  let uniform_int ?(a=0) ?(b=99) m n =
    let x = empty m n in
    iteri (fun i j _ -> x.{i,j} <-
      float_of_int (Rand.uniform_int ~a ~b ())
    ) x; x

  let uniform ?(scale=1.) m n =
    let x = empty m n in
    iteri (fun i j _ ->
      x.{i,j} <- Rand.uniform () *. scale
    ) x; x

  let gaussian ?(sigma=1.) m n =
    let x = empty m n in
    iteri (fun i j _ -> x.{i,j} <- Rand.gaussian ~sigma ()) x; x

  let draw_rows ?(replacement=true) x c = x

  let draw_cols ?(replacement=true) x c = x

end;;


module Sparse = struct

end;;


module M = Dense;;
