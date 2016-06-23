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

  let compare = None
  let ( =@ ) = None

  let ( ?@ ) = None

  let ( >@ ) = None

  let ( <@ ) = None

  let min = None

  let min_col = None

  let min_row = None

  let max = None

  let max_col = None

  let max_row = None

  let qr = None

  let svd = None

  (* matrix manipulations *)

  let size (x : LM.t) =
    let m = BA.Array2.dim1 x in
    let n = BA.Array2.dim2 x in
    m, n

  let area a b c d = { a = a; b = b; c = c; d= d }

  let area_of x =
    let m, n = size x in
    { a = 0; b = 0; c = m - 1; d= n - 1 }

  let assert_equal_area r1 r2 =
    assert ((r1.c-r1.a = r2.c-r2.a) && (r1.d-r1.b = r2.d-r2.b))

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

  let ( @|| ) = concat_vertical

  let concat_horizontal x1 x2 =
    let r1, r2 = area_of x1, area_of x2 in
    let _ = assert (r1.c = r2.c) in
    let r3 = area 0 (r1.d + 1) r1.c (r1.d + r2.d + 1) in
    let x3 = zeros (r1.c + 1) (r1.d + r2.d + 2) in
    let _ = copy_area_to x1 r1 x3 r1 in
    let _ = copy_area_to x2 r2 x3 r3 in
    x3

  let ( @= ) = concat_horizontal

  let transpose x =
    LL.Mat.transpose_copy x

  let shape = size

  let numel x =
    let m, n = size x in
    m * n

  let col_num x = fst (size x)

  let row_num x = snd (size x)

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

  let cols = None

  let rows = None

  let diag x =
    let v = LM.copy_diag x in
    LM.from_row_vec v

  (* matrix iteration operations *)

  (* TODO: implement region *)
  let iteri f x =
    let m, n = size x in
    let a1, b1, a2, b2 = 0, 0, m - 1, n - 1 in
    let inc = let c = ref (-1) in fun () -> c := !c + 1; !c in
    for i = a1 to a2 do
      for j = b1 to b2 do
        f (inc ()) i j x.{i + 1, j + 1}
      done
    done

  let iter f x =
    iteri (fun _ _ _ y -> f y) x

  let map f x = LM.map f x

  let mapi f x =
    let y = duplicate x in
    let _ = iteri (fun c i j z -> y.{i + 1, j + 1} <- f c i j z) x in
    y

  let iter_rows = None

  let iter_cols = None

  let filter = None

  let check = None

  let checkall = None

  (* formatted output operations *)

  let pprint x = Format.printf "%a\n" LL.pp_mat x

  (* other functions *)

  let sequential m n =
    let x = zeros m n in
    let _ = iteri (fun c i j _ -> x.{i + 1, j + 1} <- (float_of_int c)) x in
    x

  let ( +$ ) x a = map (fun y -> y +. a) x

  let ( $+ ) a x = ( +$ ) x a

  let ( -$ ) x a = map (fun y -> y -. a) x

  let ( $- ) a x = ( -$ ) x a

  let ( *$ ) x a = map (fun y -> y *. a) x

  let ( $* ) a x = ( *$ ) x a

  let ( /$ ) x a = map (fun y -> y /. a) x

  let ( $/ ) a x = ( /$ ) x a

end;;
