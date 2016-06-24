module M = Matrix.Matrix

let test_01 () =
  M.random 10000 10000

let test_02 () =
  let x = M.random 10000 10000 in
  M.(x *$ 10.)

let test_03 () =
  let x = M.random 10000 10000 in
  M.sum_cols x

let _ = print_endline "matrix test";
  test_03 ()
