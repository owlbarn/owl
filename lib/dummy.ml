module M = Matrix.Matrix

let test_01 () =
  let x = M.random 10000 1000 in
  M.(x *$ 10.)

let _ = print_endline "matrix test";
  test_01 ()
