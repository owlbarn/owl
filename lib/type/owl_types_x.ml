(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray


type flt = Flt

type cpx = Cpx

type mat = Mat

type vec = Vec

type arr = Arr

type num = Num

type p32 = P32

type p64 = P64

type dns = Dns

type sps = Sps


type dms = (float, float32_elt, c_layout) Array2.t

type dmd = (float, float64_elt, c_layout) Array2.t

type dmc = (Complex.t, complex32_elt, c_layout) Array2.t

type dmz = (Complex.t, complex64_elt, c_layout) Array2.t

type das = (float, float32_elt, c_layout) Genarray.t

type dad = (float, float64_elt, c_layout) Genarray.t

type dac = (Complex.t, complex32_elt, c_layout) Genarray.t

type daz = (Complex.t, complex64_elt, c_layout) Genarray.t

type sms = (float, float32_elt) Owl_sparse_matrix.t

type smd = (float, float64_elt) Owl_sparse_matrix.t

type smc = (Complex.t, complex32_elt) Owl_sparse_matrix.t

type smz = (Complex.t, complex64_elt) Owl_sparse_matrix.t

type sas = (float, float32_elt) Owl_sparse_ndarray.t

type sad = (float, float64_elt) Owl_sparse_ndarray.t

type sac = (Complex.t, complex32_elt) Owl_sparse_ndarray.t

type saz = (Complex.t, complex64_elt) Owl_sparse_ndarray.t


type ('a, 'b, 'c, 'd) t =
  | F : float -> (dns, num, flt, p64) t
  | C : Complex.t -> (dns, num, cpx, p64) t
  | DMS : dms -> (dns, mat, flt, p32) t
  | DMD : dmd -> (dns, mat, flt, p64) t
  | DMC : dmc -> (dns, mat, cpx, p32) t
  | DMZ : dmz -> (dns, mat, cpx, p64) t
  | DAS : das -> (dns, arr, flt, p32) t
  | DAD : dad -> (dns, arr, flt, p64) t
  | DAC : dac -> (dns, arr, cpx, p32) t
  | DAZ : daz -> (dns, arr, cpx, p64) t
  | SMS : sms -> (sps, mat, flt, p32) t
  | SMD : smd -> (sps, mat, flt, p64) t
  | SMC : sms -> (sps, mat, cpx, p32) t
  | SMZ : smd -> (sps, mat, cpx, p64) t
  | SAS : sas -> (sps, arr, flt, p32) t
  | SAD : sad -> (sps, arr, flt, p64) t
  | SAC : sac -> (sps, arr, cpx, p32) t
  | SAZ : saz -> (sps, arr, cpx, p64) t

type ('a, 'b) elt =
  | Flt32 : (flt, p32) elt
  | Flt64 : (flt, p64) elt
  | Cpx32 : (cpx, p32) elt
  | Cpx64 : (cpx, p64) elt

type ('a, 'b) box =
  | DM : (dns, mat) box
  | DA : (dns, mat) box
  | SM : (sps, arr) box
  | SA : (sps, arr) box


(* ends here *)
