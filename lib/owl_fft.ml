(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let _fft_real_rad2 x =
  let open Gsl_fft in
  let y = Owl_dense_real.to_array x in
  let z = { layout = Real; data = y } in
  Gsl_fft.Real.transform_rad2 z;
  let d = unpack z in
  let _, n = Owl_dense_real.shape x in
  let z = Owl_dense_complex.empty 1 n in
  print_int n;
  for j = 0 to n - 1 do
    let i = 2 * j in
    let re, im = d.(i), d.(i + 1) in
    Owl_dense_complex.set z 0 j Complex.({re; im})
  done;
  z

let _fft_real_radn x = _fft_real_rad2 x

let fft x =
  let _, n = Owl_dense_real.shape x in
  match (n mod 2) = 0 with
  | true  -> _fft_real_rad2 x
  | false -> _fft_real_radn x

let ifft = None
