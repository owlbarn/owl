(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Fast Fourier Transforms (FFTs) *)

type rmat = Owl_dense_real.mat

type cmat = Owl_dense_complex.mat

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

let _fft_complex_rad2 x =
  let m, n = Owl_dense_complex.shape x in
  let y = Owl_dense_complex.empty m n in
  let v = Array.make (2 * n) 0. in
  Owl_dense_complex.iteri_rows (fun i u ->
    Owl_dense_complex.iteri (fun _ q c ->
      let p = 2 * q in
      v.(p) <- Complex.(c.re);
      v.(p + 1) <- Complex.(c.im);
    ) u;
    Gsl_fft.Complex.forward_rad2 v;
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = v.(k), v.(k + 1) in
      Owl_dense_complex.set y i j Complex.({re; im})
    done
  ) x;
  y

let _fft_complex_radn x =
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
    Gsl_fft.Complex.forward v w0 w1;
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = v.(k), v.(k + 1) in
      Owl_dense_complex.set y i j Complex.({re; im})
    done
  ) x;
  y

let fft_complex x =
  let _, n = Owl_dense_complex.shape x in
  match (_is_power_of_two n) with
  | true  -> _fft_complex_rad2 x
  | false -> _fft_complex_radn x

let fft2 x =
  fft x |> Owl_dense_complex.transpose |> fft_complex |> Owl_dense_complex.transpose

let fft2_complex x =
  fft_complex x |> Owl_dense_complex.transpose |> fft_complex |> Owl_dense_complex.transpose

let ifft2 x =
  Owl_dense_complex.transpose x |> ifft |> Owl_dense_complex.transpose |> ifft

let fftn = None

let iffn = None

(* swap the left half of a matrix with the right one in place *)
let _swap_left_right x =
  let n = Owl_dense_complex.col_num x in
  let b = n / 2 - 1 in
  for a = 0 to b do
    Gsl.Matrix_complex.swap_columns x (b - a) (n - a - 1)
  done

let fftshift x =
  let y = Owl_dense_complex.clone x in
  let z = match Owl_dense_complex.row_num y with
  | 1 -> (_swap_left_right y; y)
  | _ -> (
    let _ = _swap_left_right y in
    let y = Owl_dense_complex.transpose y in
    let _ = _swap_left_right y in
    Owl_dense_complex.transpose y
  )
  in z


let ifftshift = None


(* ends here *)
