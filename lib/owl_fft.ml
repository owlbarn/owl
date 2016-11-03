(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let _is_power_of_two x = x land (x - 1) = 0

let _fft_real_rad2 x =
  let m, n = Owl_dense_real.shape x in
  let y = Owl_dense_complex.empty m n in
  Owl_dense_real.iteri_rows (fun i v ->
    let v = Owl_dense_real.to_array v in
    let z = Gsl_fft.({ layout = Real; data = v }) in
    Gsl_fft.Real.transform_rad2 z;
    let d = Gsl_fft.unpack z in
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = d.(k), d.(k + 1) in
      Owl_dense_complex.set y i j Complex.({re; im})
    done
  ) x;
  y

let _fft_real_radn x =
  let m, n = Owl_dense_real.shape x in
  let y = Owl_dense_complex.empty m n in
  let w0 = Gsl_fft.Real.make_wavetable n in
  let w1 = Gsl_fft.Real.make_workspace n in
  Owl_dense_real.iteri_rows (fun i v ->
    let v = Owl_dense_real.to_array v in
    let z = Gsl_fft.({ layout = Real; data = v }) in
    Gsl_fft.Real.transform z w0 w1;
    let d = Gsl_fft.unpack z in
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = d.(k), d.(k + 1) in
      Owl_dense_complex.set y i j Complex.({re; im})
    done
  ) x;
  y

let fft x =
  let _, n = Owl_dense_real.shape x in
  match (_is_power_of_two n) with
  | true  -> _fft_real_rad2 x
  | false -> _fft_real_radn x

let ifft = None
