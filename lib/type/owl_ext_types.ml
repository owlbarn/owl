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


type ('a, 'b, 'c, 'd) typ =
  | TYP_F   : float -> (dns, num, flt, p64) typ
  | TYP_C   : Complex.t -> (dns, num, cpx, p64) typ
  | TYP_DMS : dms -> (dns, mat, flt, p32) typ
  | TYP_DMD : dmd -> (dns, mat, flt, p64) typ
  | TYP_DMC : dmc -> (dns, mat, cpx, p32) typ
  | TYP_DMZ : dmz -> (dns, mat, cpx, p64) typ
  | TYP_DAS : das -> (dns, arr, flt, p32) typ
  | TYP_DAD : dad -> (dns, arr, flt, p64) typ
  | TYP_DAC : dac -> (dns, arr, cpx, p32) typ
  | TYP_DAZ : daz -> (dns, arr, cpx, p64) typ
  | TYP_SMS : sms -> (sps, mat, flt, p32) typ
  | TYP_SMD : smd -> (sps, mat, flt, p64) typ
  | TYP_SMC : sms -> (sps, mat, cpx, p32) typ
  | TYP_SMZ : smd -> (sps, mat, cpx, p64) typ
  | TYP_SAS : sas -> (sps, arr, flt, p32) typ
  | TYP_SAD : sad -> (sps, arr, flt, p64) typ
  | TYP_SAC : sac -> (sps, arr, cpx, p32) typ
  | TYP_SAZ : saz -> (sps, arr, cpx, p64) typ

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


type ext_typ =
  | F   of float
  | C   of Complex.t
  | DMS of dms
  | DMD of dmd
  | DMC of dmc
  | DMZ of dmz
  | DAS of das
  | DAD of dad
  | DAC of dac
  | DAZ of daz
  | SMS of sms
  | SMD of smd
  | SMC of sms
  | SMZ of smd
  | SAS of sas
  | SAD of sad
  | SAC of sac
  | SAZ of saz



(* ends here *)
