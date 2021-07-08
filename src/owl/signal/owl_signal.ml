(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Signal processing helpers *)

open Owl_dense

let hamming m =
  let open Ndarray in
  let range =
    (D.sequential [| m |] |> D.mul_scalar) (Owl_const.pi *. 2.0 /. Int.to_float (m - 1))
  in
  let inter = D.cos range in
  let mulv = D.mul_scalar inter (-0.46) in
  D.add_scalar mulv 0.54


let hann m =
  let open Ndarray in
  let range =
    (D.sequential [| m |] |> D.mul_scalar) (Owl_const.pi *. 2.0 /. Int.to_float (m - 1))
  in
  let inter = D.cos range in
  let mulv = D.mul_scalar inter (-0.5) in
  D.add_scalar mulv 0.5


let blackman m =
  let open Ndarray in
  let pi = Owl_const.pi in
  let tpi = 2.0 *. pi in
  let fpi = 4.0 *. pi in
  let range1 = D.linspace 0. tpi m in
  let range2 = D.linspace 0. fpi m in
  let inter1 = D.cos range1 in
  let inter2 = D.cos range2 in
  let mulv1 = D.mul_scalar inter1 (-0.5) in
  let mulv2 = D.mul_scalar inter2 0.08 in
  let mulvf = D.add mulv1 mulv2 in
  let ans = D.add_scalar mulvf 0.42 in
  ans


let resize r x =
  (*zero pad the array to 2*x length*)
  let open Ndarray in
  let z = Array.make ((2 * x) - Array.length r) 0. in
  let y = Array.append r z in
  D.of_array y [| 2 * x |] |> Generic.cast_d2z


let dtft r x =
  (*dtft for upper unit circle (i.e whole if false)*)
  let open Ndarray in
  let a = resize r x in
  let b = Owl_fft.D.fft a in
  Z.get_slice [ [ 0; x - 1 ] ] b


let dtftw r x =
  (*dtft for full circle (i.e whole is true)*)
  let a = resize r x in
  Owl_fft.D.fft a


let freqz ?(n = 512) ?(whole = false) b a =
  (*b represents numerator array while a represent denominator array*)
  if whole
  then (
    let x = dtftw a n in
    let y = dtftw b n in
    Ndarray.D.linspace (-1.0 *. Owl_const.pi) Owl_const.pi (n + 1), Ndarray.Z.div y x)
  else (
    let x = dtft a n in
    let y = dtft b n in
    Ndarray.D.linspace 0. Owl_const.pi (n + 1), Ndarray.Z.div y x)
