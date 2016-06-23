(** [
  Wrap up Lacaml module
  ]  *)

module BA = Bigarray
module LL = Lacaml.D
module LM = LL.Mat

type area = { a : int; b : int; c : int; d : int }

module Matrix = struct

  (* matrix creation operations *)

  let make = LM.make

  let zeros = LM.make0

  let ones m n = make m n 1.

  let eye = LM.identity

  let random = LM.random

  let vector = make 1

  let vector_ones x = vector x 1.

  let vector_zeros x = vector x 0.

  let vector_random = random 1

  (* matrix manipulations *)

  let size (x : LM.t) = LM.dim1 x, LM.dim2 x

  let shape = size

  let same_shape x1 x2 = size x1 = size x2

  let area a b c d = { a = a; b = b; c = c; d= d }

  let area_of x =
    let m, n = size x in
    { a = 0; b = 0; c = m - 1; d= n - 1 }

  let equal_area r1 r2 =
    ((r1.c-r1.a = r2.c-r2.a) && (r1.d-r1.b = r2.d-r2.b))

  let same_area r1 r2 = r1 = r2

  let copy_area_to x1 r1 x2 r2 =
    LL.lacpy ~ar:(r1.a+1) ~ac:(r1.b+1) ~br:(r2.a+1) ~bc:(r2.b+1)
      ~m:(r1.c-r1.a+1) ~n:(r1.d-r1.b+1) ~b:x2 x1

  let copy_to x1 x2 =
    copy_area_to x1 (area_of x1) x2 (area_of x2)

  let ( >> ) = copy_to

  let ( << ) x1 x2 = copy_to x2 x1

  let concat_vertical x1 x2 =
    let r1, r2 = area_of x1, area_of x2 in
    let _ = assert (r1.d = r2.d) in
    let r3 = area (r1.c + 1) 0 (r1.c + r2.c + 1) r1.d in
    let x3 = zeros (r1.c + r2.c + 2) (r1.d + 1) in
    let _ = copy_area_to x1 r1 x3 r1 in
    let _ = copy_area_to x2 r2 x3 r3 in
    x3

  let ( @= ) = concat_vertical

  let concat_horizontal x1 x2 =
    let r1, r2 = area_of x1, area_of x2 in
    let _ = assert (r1.c = r2.c) in
    let r3 = area 0 (r1.d + 1) r1.c (r1.d + r2.d + 1) in
    let x3 = zeros (r1.c + 1) (r1.d + r2.d + 2) in
    let _ = copy_area_to x1 r1 x3 r1 in
    let _ = copy_area_to x2 r2 x3 r3 in
    x3

  let ( @|| ) = concat_horizontal

  let fill = LM.fill (* TODO: refine *)

  let transpose x = LL.Mat.transpose_copy x

  let numel x =
    let m, n = size x in
    m * n

  let row_num x = fst (size x)

  let col_num x = snd (size x)

  let part x r =
    let a, b, c, d = r.a, r.b, r.c, r.d in
    LL.lacpy ~ar:(a+1) ~ac:(b+1) ~m:(c-a+1) ~n:(d-b+1) x

  let duplicate x =
    let m, n = size x in
    let r = area 0 0 (m - 1) (n - 1) in
    part x r

  let col x i =
    let m, n = size x in
    let r = area 0 i (m - 1) i in
    part x r

  let row x i =
    let m, n = size x in
    let r = area i 0 i (n - 1) in
    part x r

  let _get_content_dim x l dim =  (* dim = 0 for rows; 1 for cols *)
    let m, n = size x and c = List.length l in
    let area_at i = if dim = 0 then area i 0 i (n - 1)
      else area 0 i (m - 1) i in
    let a, b = if dim = 0 then (c, n) else (m, c) in
    let y = zeros a b in
    List.iteri (fun i j ->
      let _ = copy_area_to x (area_at j) y (area_at i) in ()
    ) l; y

  let cols x l = _get_content_dim x l 1

  let rows x l = _get_content_dim x l 0

  let diag x =
    let v = LM.copy_diag x in
    LM.from_row_vec v

  let trace x = LM.trace

  (* matrix iteration operations *)

  let iteri f x =
    let m, n = size x in
    let a1, b1, a2, b2 = 0, 0, m - 1, n - 1 in
    for i = a1 to a2 do
      for j = b1 to b2 do
        f i j x.{i + 1, j + 1}
      done
    done

  let iter f x = iteri (fun _ _ y -> f y) x

  let _iteri_dim bound_fun get_fun f x =
    for i = 0 to (bound_fun x) - 1 do
      f i (get_fun x i)
    done

  let iteri_rows f x = _iteri_dim row_num row f x

  let iter_rows f x = iteri_rows (fun _ y -> f y) x

  let iteri_cols f x = _iteri_dim col_num col f x

  let iter_cols f x = iteri_cols (fun _ y -> f y) x

  let mapi f x =
    let y = duplicate x in
    let _ = iteri (fun i j z -> y.{i + 1, j + 1} <- f i j z) x in
    y

  let map f x = LM.map f x

  let filteri f x =
    let r = ref [ ] in
    let _ = iteri (fun c i j y ->
      if (f i j y) = true then r := !r @ [(i,j)]
    ) x in !r

  let filter f x = filteri (fun _ _ y -> f y) x

  let _filteri_dim iter_fun f x =
    let r = ref [ ] in
    let _ = iter_fun (fun i v ->
      if (f i v) = true then r := !r @ [i]
    ) x in !r

  let filteri_rows f x = _filteri_dim iteri_rows f x

  let filter_rows f x = filteri_rows (fun _ y -> f y) x

  let filteri_cols f x = _filteri_dim iteri_cols f x

  let filter_cols f x = filteri_cols (fun _ y -> f y) x

  let fold = None

  let fold_rows = None

  let fold_cols = None

  let exists f x =
    try iter (fun y ->
      if (f y) = true then failwith "found"
    ) x; false
    with exn -> true

  let not_exists f x = not (exists f x)

  let forall f x = let g y = not (f y) in not_exists g x

  (* matrix mathematical operations *)

  let add x1 x2 = LM.add x1 x2
  let ( +@ ) = add

  let sub x1 x2 = LM.sub x1 x2
  let ( -@ ) = sub

  let dot x1 x2 = LL.gemm x1 x2
  let ( $@ ) = dot

  let mul x1 x2 = LM.mul x1 x2
  let ( *@ ) = mul

  let div x1 x2 = LM.div x1 x2
  let ( /@ ) = div

  let abs x = LM.abs x

  let sum x = LM.sum x

  let is_equal x1 x2 = forall (( = ) 0.) (sub x1 x2)

  let ( =@ ) = is_equal

  let is_greater x1 x2 = forall (( < ) 0.) (sub x1 x2)

  let ( >@ ) = is_greater

  let is_smaller x1 x2 = forall (( > ) 0.) (sub x1 x2)

  let ( <@ ) = is_smaller

  let equal_or_greater x1 x2 = forall (( <= ) 0.) (sub x1 x2)

  let ( >=@ ) = equal_or_greater

  let equal_or_smaller x1 x2 = forall (( >= ) 0.) (sub x1 x2)

  let ( <=@ ) = equal_or_smaller

  let min_dim = None

  let min_col = None

  let min_row = None

  let max_dim = None

  let max_col = None

  let max_row = None

  let qr = None

  let svd = None

  let ( +$ ) x a = map (fun y -> y +. a) x

  let ( $+ ) a x = ( +$ ) x a

  let ( -$ ) x a = map (fun y -> y -. a) x

  let ( $- ) a x = ( -$ ) x a

  let ( *$ ) x a = map (fun y -> y *. a) x

  let ( $* ) a x = ( *$ ) x a

  let ( /$ ) x a = map (fun y -> y /. a) x

  let ( $/ ) a x = ( /$ ) x a

  (* formatted input / output operations *)

  let pprint x = Format.printf "%a\n" LL.pp_mat x

  let write_file = None

  let read_file = None

  (* transform to or from other types *)

  let to_list = LM.to_list

  let to_array = LM.to_array

  let of_list = LM.of_list

  let of_array = LM.of_array

  (* other functions *)

  let sequential m n =
    let x = zeros m n in
    let _ = iteri (fun i j _ ->
      let c = i * m + j in
      x.{i + 1, j + 1} <- (float_of_int c)
    ) x in x

end;;

module M = Matrix;;
