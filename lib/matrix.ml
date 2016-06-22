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

  let div = LM.div
  let ( /@ ) x1 x2 = div x1 x2

  let min = None

  let min_col = None

  let min_row = None

  let max = None

  let max_col = None

  let max_row = None

  (* matrix manipulations *)

  let concat_vertical = None
  let ( @|| ) = concat_vertical

  let concat_horizontal = None
  let ( @= ) = concat_horizontal

  let transpose = None

  let size x =
    let m = BA.Array2.dim1 x in
    let n = BA.Array2.dim2 x in
    m, n

  let shape = size

  let col_num x = fst (size x)

  let row_num x = snd (size x)

  let col x n = LM.col x (n + 1)

  let row x n = None

  let cols = None

  let rows = None

  let diag x =
    let m, n = size x in
    let j = Pervasives.min m n in
    let v = vector_zeros j in
    for i = 0 to (j - 1) do
      v.{1, i + 1} <- x.{i + 1, i + 1}
    done;
    v

  (* matrix iteration operations *)

  let map = None

  let filter = None

  let check = None

  let checkall = None

  (* formatted output operations *)

  let pprint x = Format.printf "%a\n" LL.pp_mat x

end;;
