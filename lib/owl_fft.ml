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

let _fft_halfcomplex_inv_rad2 x =
  let m, n = Owl_dense_complex.shape x in
  let y = Owl_dense_complex.empty m n in
  let v = Array.make (2 * n) 0. in
  Owl_dense_complex.iteri_rows (fun i u ->
    Owl_dense_complex.iteri (fun _ q c ->
      let p = 2 * q in
      v.(p) <- Complex.(c.re);
      v.(p + 1) <- Complex.(c.im);
    ) u;
    let z = Gsl_fft.({ layout = Halfcomplex_rad2; data = v }) in
    Gsl_fft.Halfcomplex.inverse_rad2 z;
    let d = Gsl_fft.unpack z in
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = d.(k), d.(k + 1) in
      Owl_dense_complex.set y i j Complex.({re; im})
    done
  ) x;
  y

let _fft_halfcomplex_inv_radn x =
  let m, n = Owl_dense_complex.shape x in
  let y = Owl_dense_complex.empty m n in
  let v = Array.make (2 * n) 0. in
  let w0 = Gsl_fft.Halfcomplex.make_wavetable n in
  let w1 = Gsl_fft.Real.make_workspace n in
  Owl_dense_complex.iteri_rows (fun i u ->
    Owl_dense_complex.iteri (fun _ q c ->
      let p = 2 * q in
      v.(p) <- Complex.(c.re);
      v.(p + 1) <- Complex.(c.im);
    ) u;
    let z = Gsl_fft.({ layout = Halfcomplex; data = v }) in
    Gsl_fft.Halfcomplex.inverse z w0 w1;
    let d = Gsl_fft.unpack z in
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = d.(k), d.(k + 1) in
      Owl_dense_complex.set y i j Complex.({re; im})
    done
  ) x;
  y

let _fft_complex_inv_rad2 x =
  let m, n = Owl_dense_complex.shape x in
  let y = Owl_dense_complex.empty m n in
  let v = Array.make (2 * n) 0. in
  Owl_dense_complex.iteri_rows (fun i u ->
    Owl_dense_complex.iteri (fun _ q c ->
      let p = 2 * q in
      v.(p) <- Complex.(c.re);
      v.(p + 1) <- Complex.(c.im);
    ) u;
    Gsl_fft.Complex.inverse_rad2 v;
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = v.(k), v.(k + 1) in
      Owl_dense_complex.set y i j Complex.({re; im})
    done
  ) x;
  y

let _fft_complex_inv_radn x =
  let m, n = Owl_dense_complex.shape x in
  let y = Owl_dense_complex.empty m n in
  let v = Array.make (2 * n) 0. in
  let w0 = Gsl_fft.Complex.make_wavetable n in
  let w1 = Gsl_fft.Complex.make_workspace n in
  Owl_dense_complex.iteri_rows (fun i u ->
    Owl_dense_complex.iteri (fun _ q c ->
      let p = 2 * q in
      v.(p) <- Complex.(c.re);
      v.(p + 1) <- Complex.(c.im);
    ) u;
    Gsl_fft.Complex.inverse v w0 w1;
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = v.(k), v.(k + 1) in
      Owl_dense_complex.set y i j Complex.({re; im})
    done
  ) x;
  y

let ifft x =
  let _, n = Owl_dense_complex.shape x in
  match (_is_power_of_two n) with
  | true  -> _fft_complex_inv_rad2 x
  | false -> _fft_complex_inv_radn x
