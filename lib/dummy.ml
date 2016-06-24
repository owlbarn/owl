module M = Matrix.Matrix

let test_01 () =
  let x = M.random 10000 10000 in
  M.sum x

let test_02 () =
  let x = M.random 10000 10000 in
  M.(x *$ 10.)

let _ = print_endline "matrix test";
  test_02 ()
