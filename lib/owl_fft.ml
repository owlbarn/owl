(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let _fft_real_rad2 x =
  let open Gsl_fft in
  let m, n = Owl_dense_real.shape x in
  let y = Owl_dense_complex.empty m n in
  Owl_dense_real.iteri_rows (fun i v ->
    let v = Owl_dense_real.to_array v in
    let z = { layout = Real; data = v } in
    Gsl_fft.Real.transform_rad2 z;
    let d = unpack z in
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = d.(k), d.(k + 1) in
      Owl_dense_complex.set y i j Complex.({re; im})
    done
  ) x;
  y

let _fft_real_radn x = _fft_real_rad2 x

let fft x =
  let _, n = Owl_dense_real.shape x in
  match (n mod 2) = 0 with
  | true  -> _fft_real_rad2 x
  | false -> _fft_real_radn x

let ifft = None
