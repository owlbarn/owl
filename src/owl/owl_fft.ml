(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Fast Fourier Transforms (FFTs) *)

type rmat = Owl_dense.Matrix.D.mat

type cmat = Owl_dense.Matrix.Z.mat

let _is_power_of_two x = x land (x - 1) = 0

let _fft_real_rad2 x =
  let m, n = Owl_dense_matrix_d.shape x in
  let y = Owl_dense_matrix_z.empty m n in
  Owl_dense_matrix_d.iteri_rows (fun i v ->
    let v = Owl_dense_matrix_d.to_array v in
    let z = Gsl.Fft.({ layout = Real; data = v }) in
    Gsl.Fft.Real.transform_rad2 z;
    let d = Gsl.Fft.unpack z in
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = d.(k), d.(k + 1) in
      Owl_dense_matrix_z.set y i j Complex.({re; im})
    done
  ) x;
  y

let _fft_real_radn x =
  let m, n = Owl_dense_matrix_d.shape x in
  let y = Owl_dense_matrix_z.empty m n in
  let w0 = Gsl.Fft.Real.make_wavetable n in
  let w1 = Gsl.Fft.Real.make_workspace n in
  Owl_dense_matrix_d.iteri_rows (fun i v ->
    let v = Owl_dense_matrix_d.to_array v in
    let z = Gsl.Fft.({ layout = Real; data = v }) in
    Gsl.Fft.Real.transform z w0 w1;
    let d = Gsl.Fft.unpack z in
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = d.(k), d.(k + 1) in
      Owl_dense_matrix_z.set y i j Complex.({re; im})
    done
  ) x;
  y

let fft x =
  let _, n = Owl_dense_matrix_d.shape x in
  match (_is_power_of_two n) with
  | true  -> _fft_real_rad2 x
  | false -> _fft_real_radn x

let _fft_complex_inv_rad2 x =
  let m, n = Owl_dense_matrix_z.shape x in
  let y = Owl_dense_matrix_z.empty m n in
  let v = Array.make (2 * n) 0. in
  Owl_dense_matrix_z.iteri_rows (fun i u ->
    Owl_dense_matrix_z.iteri (fun _ q c ->
      let p = 2 * q in
      v.(p) <- Complex.(c.re);
      v.(p + 1) <- Complex.(c.im);
    ) u;
    Gsl.Fft.Complex.inverse_rad2 v;
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = v.(k), v.(k + 1) in
      Owl_dense_matrix_z.set y i j Complex.({re; im})
    done
  ) x;
  y

let _fft_complex_inv_radn x =
  let m, n = Owl_dense_matrix_z.shape x in
  let y = Owl_dense_matrix_z.empty m n in
  let v = Array.make (2 * n) 0. in
  let w0 = Gsl.Fft.Complex.make_wavetable n in
  let w1 = Gsl.Fft.Complex.make_workspace n in
  Owl_dense_matrix_z.iteri_rows (fun i u ->
    Owl_dense_matrix_z.iteri (fun _ q c ->
      let p = 2 * q in
      v.(p) <- Complex.(c.re);
      v.(p + 1) <- Complex.(c.im);
    ) u;
    Gsl.Fft.Complex.inverse v w0 w1;
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = v.(k), v.(k + 1) in
      Owl_dense_matrix_z.set y i j Complex.({re; im})
    done
  ) x;
  y

let ifft x =
  let _, n = Owl_dense_matrix_z.shape x in
  match (_is_power_of_two n) with
  | true  -> _fft_complex_inv_rad2 x
  | false -> _fft_complex_inv_radn x

let _fft_complex_rad2 x =
  let m, n = Owl_dense_matrix_z.shape x in
  let y = Owl_dense_matrix_z.empty m n in
  let v = Array.make (2 * n) 0. in
  Owl_dense_matrix_z.iteri_rows (fun i u ->
    Owl_dense_matrix_z.iteri (fun _ q c ->
      let p = 2 * q in
      v.(p) <- Complex.(c.re);
      v.(p + 1) <- Complex.(c.im);
    ) u;
    Gsl.Fft.Complex.forward_rad2 v;
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = v.(k), v.(k + 1) in
      Owl_dense_matrix_z.set y i j Complex.({re; im})
    done
  ) x;
  y

let _fft_complex_radn x =
  let m, n = Owl_dense_matrix_z.shape x in
  let y = Owl_dense_matrix_z.empty m n in
  let v = Array.make (2 * n) 0. in
  let w0 = Gsl.Fft.Complex.make_wavetable n in
  let w1 = Gsl.Fft.Complex.make_workspace n in
  Owl_dense_matrix_z.iteri_rows (fun i u ->
    Owl_dense_matrix_z.iteri (fun _ q c ->
      let p = 2 * q in
      v.(p) <- Complex.(c.re);
      v.(p + 1) <- Complex.(c.im);
    ) u;
    Gsl.Fft.Complex.forward v w0 w1;
    for j = 0 to n - 1 do
      let k = 2 * j in
      let re, im = v.(k), v.(k + 1) in
      Owl_dense_matrix_z.set y i j Complex.({re; im})
    done
  ) x;
  y

let fft_complex x =
  let _, n = Owl_dense_matrix_z.shape x in
  match (_is_power_of_two n) with
  | true  -> _fft_complex_rad2 x
  | false -> _fft_complex_radn x

let fft2 x =
  fft x |> Owl_dense_matrix_z.transpose |> fft_complex |> Owl_dense_matrix_z.transpose

let fft2_complex x =
  fft_complex x |> Owl_dense_matrix_z.transpose |> fft_complex |> Owl_dense_matrix_z.transpose

let ifft2 x =
  Owl_dense_matrix_z.transpose x |> ifft |> Owl_dense_matrix_z.transpose |> ifft

(* swap the left half of a matrix with the right one in place *)
let _swap_left_right x =
  let n = Owl_dense_matrix_z.col_num x in
  let c = n / 2 in
  let a = Array.init c (fun i -> i) in
  let b = Array.init (n - c) (fun i -> c + i) in
  Owl_dense_matrix_z.cols x (Array.append b a)

let fftshift x =
  let y = Owl_dense_matrix_z.copy x in
  let z = match Owl_dense_matrix_z.row_num y with
  | 1 -> _swap_left_right y
  | _ -> (
    _swap_left_right y
    |> Owl_dense_matrix_z.transpose
    |> _swap_left_right
    |> Owl_dense_matrix_z.transpose
  )
  in z

let _swap_right_left x =
  let n = Owl_dense_matrix_z.col_num x in
  let c = (n / 2) + (n mod 2) in
  let a = Array.init c (fun i -> i) in
  let b = Array.init (n - c) (fun i -> c + i) in
  Owl_dense_matrix_z.cols x (Array.append b a)

let ifftshift x =
  let y = Owl_dense_matrix_z.copy x in
  let z = match Owl_dense_matrix_z.row_num y with
  | 1 -> _swap_right_left y
  | _ -> (
    _swap_left_right y
    |> Owl_dense_matrix_z.transpose
    |> _swap_left_right
    |> Owl_dense_matrix_z.transpose
  )
  in z

(* place holder for ndarray fft *)
let fftn = None

(* place holder for ndarray fft inverse *)
let iffn = None

let conv = None

let conv2 = None

let wavelet = None

(* ends here *)
