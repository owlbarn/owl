open Ctypes
open Foreign

type block

let blk : block structure typ = structure "blk"
let size = field blk "size" int64_t
let dta = field blk "dta" (ptr double)
let () = seal blk

type mat

let mat : mat structure typ = structure "mat"
let size1 = field mat "size1" int64_t
let size2 = field mat "size2" int64_t
let tda = field mat "tda" int64_t
let data = field mat "data" (ptr double)
let block = field mat "block" (ptr blk)
let owner = field mat "owner" int64_t
let () = seal mat

let mat_max = foreign "gsl_matrix_max" (ptr mat @-> returning double)

let empty = foreign "gsl_matrix_alloc" (int @-> int @-> returning (ptr mat))

let zeros = foreign "gsl_matrix_set_zero" (ptr mat @-> returning void)

let print_array x =
  for i = 0 to (Bigarray.Array2.dim1 x) - 1 do
    for j = 0 to (Bigarray.Array2.dim2 x) - 1 do
      Printf.printf "%.1f " x.{i,j}
    done;
    print_endline ""
  done

let _ =
  let x = empty 3 5 in
  let _ = zeros x in
  let raw = getf (!@ x) data in
  let y = bigarray_of_ptr array2 (3,5) Bigarray.float64 raw in
  let _ = y.{2,0} <- 5. in
  print_array y;
  ()
