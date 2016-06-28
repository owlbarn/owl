(** [
  Wrap up Lacaml module
  Note: C layout row-major matrix
  The layout is really important, can impact the performance greatly!
  ]  *)

type area = { a : int; b : int; c : int; d : int }

module Matrix = struct

  (* matrix creation operations *)

  let shape = Gsl.Matrix.dims

  let col_num x = fst (shape x)

  let row_num x = snd (shape x)

  let numel x = (row_num x) * (col_num x)

  let empty = Gsl.Matrix.create

  let create m n v = empty ~init:v m n

  let ones m n = create m n 1.

  let zeros m n = create m n 0.

  let eye n =
    let x = empty n n in
    for i = 0 to n - 1 do
      x.{i,i} <- 1.
    done

  let identity = eye

  let sequential m n =
    let x = empty m n and c = ref 0 in
    for i = 0 to m - 1 do
      for j = 0 to n - 1 do
        c := !c + 1; x.{i,j} <- (float_of_int !c)
      done
    done; x

  let random = None

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

  let area_of_row x i = area i 0 i (row_num x - 1)

  let area_of_col x i = area 0 i (col_num x - 1) i

  let equal_area r1 r2 =
    ((r1.c-r1.a = r2.c-r2.a) && (r1.d-r1.b = r2.d-r2.b))

  let same_area r1 r2 = r1 = r2

  let copy_area_to x1 r1 x2 r2 =
    if not (equal_area r1 r2) then
      failwith "Error: area mismatch"
    else
      for i = 0 to r1.c - r1.a do
        for j = 0 to r1.d - r1.b do
          x2.{r2.a + i, r2.b + j} <- x1.{r1.a + i, r1.b + j}
        done
      done

  let copy_to x1 x2 = Gsl.Matrix.memcpy x1 x2

  let clone_area x r =
    let y = empty (r.c - r.a + 1) (r.d - r.b + 1) in
    copy_area_to x r y (area_of y)

  let clone x = Gsl.Matrix.copy x

  let ( >> ) = copy_to

  let row x i = Gsl.Matrix.row x i

  let col x j =
    let m, n = shape x in
    let y = empty m 1 in
    for i = 0 to m - 1 do
      y.{i,0} <- x.{i,j}
    done; y

  (* matrix iteration operations *)

  let iteri f x =
    let m, n = shape x in
    for i = 0 to m - 1 do
      for j = 0 to n - 1 do
        f i j x.{i,j}
      done
    done

  let iter f x = iteri (fun _ _ y -> f y) x

  let iteri_rows f x =
    for i = 0 to (row_num x) - 1 do
      f i (row x i)
    done

  let iter_rows f x = iteri_rows (fun _ y -> f y) x

  let iteri_cols f x =
    for i = 0 to (col_num x) - 1 do
      f i (col x i)
    done

  let iter_cols f x = iteri_cols (fun _ y -> f y) x

  let mapi f x =
    let y = empty (row_num x) (col_num x) in
    iteri (fun i j z -> y.{i,j} <- f i j z) x; y

  let map f x = mapi (fun _ _ y -> f y) x

  let mapi_rows f x = Array.init (row_num x) (fun i -> f i (row x i))

  let map_rows f x = mapi_rows (fun _ y -> f y) x

  let mapi_cols f x = Array.init (col_num x) (fun i -> f i (col x i))

  let map_cols f x = mapi_cols (fun _ y -> f y) x

  let filteri f x =
    let r = ref [||] in
    iteri (fun i j y ->
      if (f i j y) then r := Array.append !r [|y|]
    ) x; !r

  let filter f x = filteri (fun _ _ y -> f y) x

  let filteri_rows f x =
    let r = ref [||] in
    let _ = iteri_rows (fun i v ->
      if (f i v) then r := Array.append !r [|v|]
    ) x in !r

  let filter_rows f x = filteri_rows (fun _ v -> f v) x

  let filteri_cols f x =
    let r = ref [||] in
    let _ = iteri_cols (fun i v ->
      if (f i v) then r := Array.append !r [|v|]
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

end;;

module M = Matrix;;
