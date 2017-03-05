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


(* constructor information *)

let type_info = function
  | F _   -> "(scalar, float)"
  | C _   -> "(scalar, complex)"
  | DMS _ -> "(dense, matrix, float, 32-bit)"
  | DMD _ -> "(dense, matrix, float, 64-bit)"
  | DMC _ -> "(dense, matrix, complex, 32-bit)"
  | DMZ _ -> "(dense, matrix, complex, 64-bit)"
  | DAS _ -> "(dense, ndarray, float, 32-bit)"
  | DAD _ -> "(dense, ndarray, float, 64-bit)"
  | DAC _ -> "(dense, ndarray, complex, 32-bit)"
  | DAZ _ -> "(dense, ndarray, complex, 64-bit)"
  | SMS _ -> "(sparse, matrix, float, 32-bit)"
  | SMD _ -> "(sparse, matrix, float, 64-bit)"
  | SMC _ -> "(sparse, matrix, complex, 32-bit)"
  | SMZ _ -> "(sparse, matrix, complex, 64-bit)"
  | SAS _ -> "(sparse, ndarray, float, 32-bit)"
  | SAD _ -> "(sparse, ndarray, float, 64-bit)"
  | SAC _ -> "(sparse, ndarray, complex, 32-bit)"
  | SAZ _ -> "(sparse, ndarray, complex, 64-bit)"


(* pack and unpack functions *)

let pack_flt x = F x
let unpack_flt = function F x -> x | _ -> failwith "unpack_flt: unknown type."

let pack_cpx x = C x
let unpack_cpx = function C x -> x | _ -> failwith "unpack_cpx: unknown type."

let pack_das x = DAS x
let unpack_das = function DAS x -> x | _ -> failwith "unpack_das: unknown type."

let pack_dad x = DAD x
let unpack_dad = function DAD x -> x | _ -> failwith "unpack_dad: unknown type."

let pack_dac x = DAC x
let unpack_dac = function DAC x -> x | _ -> failwith "unpack_dac: unknown type."

let pack_daz x = DAZ x
let unpack_daz = function DAZ x -> x | _ -> failwith "unpack_daz: unknown type."

let pack_dms x = DMS x
let unpack_dms = function DMS x -> x | _ -> failwith "unpack_dms: unknown type."

let pack_dmd x = DMD x
let unpack_dmd = function DMD x -> x | _ -> failwith "unpack_dmd: unknown type."

let pack_dmc x = DMC x
let unpack_dmc = function DMC x -> x | _ -> failwith "unpack_dmc: unknown type."

let pack_dmz x = DMZ x
let unpack_dmz = function DMZ x -> x | _ -> failwith "unpack_dmz: unknown type."


(* ends here *)
