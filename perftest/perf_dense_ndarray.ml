(* Performance test of Owl_dense_ndarray module *)

module M = Owl_dense_ndarray

let test_op s c op =
  let ttime = ref 0. in
  for i = 1 to c do
    let t0 = Unix.gettimeofday () in
    let _ = op () in
    let t1 = Unix.gettimeofday () in
    ttime := !ttime +. (t1 -. t0)
  done;
  let _ = ttime := !ttime /. (float_of_int c) in
  Printf.printf "| %s :\t %.4fs \n" s !ttime;
  flush stdout

let _ =
  let _ = Random.self_init () in
  let m, n, o = 10, 1000, 10000 and c = 1 in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test ndarray size: %i x %i x %i    exps: %i\n" m n o c;
  print_endline (Bytes.make 60 '-');
  let x = M.create Bigarray.Float64 [|m;n;o|] 1. in
  let y = M.create Bigarray.Float64 [|m;n;o|] 2. in
  let z = M.ones Bigarray.Complex64 [|m;n;o|] in
  test_op "empty             " c (fun () -> M.empty Bigarray.Float32 [|m;n;o|]);
  test_op "create            " c (fun () -> M.create Bigarray.Float32 [|m;n;o|] 1.);
  test_op "slice_left        " c (fun () -> M.slice_left x [|0|]);
  test_op "slice (0,*.*)     " c (fun () -> M.slice [|Some 0; None; None|] x);
  test_op "slice (*,0.*)     " c (fun () -> M.slice [|None; Some 0; None|] x);
  test_op "slice (*,*.0)     " c (fun () -> M.slice [|None; None; Some 0|] x);
  test_op "reshape           " c (fun () -> M.reshape x [|o;n;m|]);
  test_op "flatten           " c (fun () -> M.flatten x);
  test_op "minmax            " c (fun () -> M.minmax x);
  test_op "max               " c (fun () -> M.max x);
  test_op "abs               " c (fun () -> M.abs x);
  test_op "neg               " c (fun () -> M.neg x);
  test_op "sum               " c (fun () -> M.sum x);
  test_op "add x y           " c (fun () -> M.add x y);
  test_op "mul x y           " c (fun () -> M.mul x y);
  test_op "add_scalar        " c (fun () -> M.add_scalar x 0.5);
  test_op "mul_scalar        " c (fun () -> M.mul_scalar x 10.);
  test_op "sin x             " c (fun () -> M.sin x);
  test_op "max2              " c (fun () -> M.max2 x y);
  test_op "is_zero           " c (fun () -> M.is_zero x);
  test_op "is_equal          " c (fun () -> M.is_equal x x);
  test_op "is_greater        " c (fun () -> M.is_greater x x);
  test_op "equal_or_smaller  " c (fun () -> M.equal_or_smaller x x);
  test_op "transpose         " c (fun () -> M.transpose x);
  test_op "swap 0 1          " c (fun () -> M.swap 0 1 x);
  test_op "fill              " c (fun () -> M.fill x 1.5);
  test_op "clone             " c (fun () -> M.clone x);
  test_op "copy              " c (fun () -> M.copy x y);
  test_op "iteri             " c (fun () -> M.iteri (fun i a -> ()) x);
  test_op "iter              " c (fun () -> M.iter (fun a -> ()) x);
  test_op "iteri (0,*,*)     " c (fun () -> M.iteri ~axis:[|Some 0; None; None|] (fun i a -> ()) x);
  test_op "iter (0,*,*)      " c (fun () -> M.iter ~axis:[|Some 0; None; None|] (fun a -> ()) x);
  test_op "mapi              " c (fun () -> M.mapi (fun i a -> a) x);
  test_op "map               " c (fun () -> M.map (fun a -> a) x);
  test_op "map (sin)         " c (fun () -> M.map (fun a -> sin a) x);
  test_op "pmap (sin)        " c (fun () -> M.pmap (fun a -> sin a) x);
  test_op "map (+1)          " c (fun () -> M.map (fun a -> a +. 1.) x);
  test_op "pmap (+1)         " c (fun () -> M.pmap (fun a -> a +. 1.) x);
  test_op "map (^2)          " c (fun () -> M.map (fun a -> a *. a) x);
  test_op "iteri_slice 0     " c (fun () -> M.iteri_slice [|0|] (fun i s -> ()) x);
  test_op "iter2i            " c (fun () -> M.iter2i (fun i a b -> ()) x y);
  test_op "iter2             " c (fun () -> M.iter2 (fun a b -> ()) x y);
  test_op "conj              " c (fun () -> M.conj z);
  print_endline (Bytes.make 60 '+');
