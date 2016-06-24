module M = Matrix.Matrix

let test_op s c op =
  for i = 1 to c do
    op ()
  done

let test () =
  let x = Lacaml.D.Mat.random 3 3 in
  let _ = print_endline "matrix x"; Format.printf "%a" Lacaml.D.pp_mat x in
  let y = Lacaml.D.Mat.random 3 3 in
  let _ = print_endline "matrix y"; Format.printf "%a" Lacaml.D.pp_mat y in
  let z = M.add x y in
  let _ = print_endline "matrix z"; Format.printf "%a" Lacaml.D.pp_mat z in ()

let _ = print_endline "hello test";
  test ()
