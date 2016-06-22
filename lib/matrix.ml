(** [
  Wrap up Lacaml module
  ]  *)

module BA = Bigarray
module LL = Lacaml.D
module LM = LL.Mat

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

  let add = LM.add
  let ( +@ ) x1 x2 = add x1 x2

  let sub = LM.sub
  let ( -@ ) x1 x2 = sub x1 x2

  (* this is elementwise product ... fix *)
  let mul = LM.mul
  let ( *@ ) x1 x2 = mul x1 x2
  let ( *$@ ) x1 x2 = None

  let div = LM.div
  let ( /@ ) x1 x2 = div x1 x2

  let min = None

  let min_col = None

  let min_row = None

  let max = None

  let max_col = None

  let max_row = None

  let qr = None

  let svd = None

  (* matrix manipulations *)

  let concat_vertical = None
  let ( @|| ) = concat_vertical

  let concat_horizontal = None
  let ( @= ) = concat_horizontal

  let transpose = None

  let size (x : LM.t) =
    let m = BA.Array2.dim1 x in
    let n = BA.Array2.dim2 x in
    m, n

  let shape = size

  let col_num x = fst (size x)

  let row_num x = snd (size x)

  let part ~a1 ~b1 ~a2 ~b2 x =
    LL.lacpy ~ar:(a1+1) ~ac:(b1+1) ~m:(a2-a1+1) ~n:(b2-b1+1) x

  let col x i =
    let m, n = size x in
    part 0 i (m - 1) i x

  let row x i =
    let m, n = size x in
    part i 0 i (n - 1) x

  let cols = None

  let rows = None

  let diag x =
    let v = LM.copy_diag x in
    LM.from_row_vec v

  (* matrix iteration operations *)

  let map = LM.map

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

  let ( +$ ) x a =
    let _ = iteri (fun _ i j y -> x.{i + 1, j + 1} <- y +. a) x in
    x

  let ( -$ ) x a =
    let _ = iteri (fun _ i j y -> x.{i + 1, j + 1} <- y -. a) x in
    x

  let ( *$ ) x a =
    let _ = iteri (fun _ i j y -> x.{i + 1, j + 1} <- y *. a) x in
    x

  let ( /$ ) x a =
    let _ = iteri (fun _ i j y -> x.{i + 1, j + 1} <- y /. a) x in
    x

end;;
