
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


type ('a, 'b, 'c, 'd) t =
  | F : float -> (num, flt, p64, dns) t
  | C : Complex.t -> (num, cpx, p64, dns) t
  | DMS : dms -> (mat, flt, p32, dns) t
  | DMD : dmd -> (mat, flt, p64, dns) t
  | DMC : dmc -> (mat, cpx, p32, dns) t
  | DMZ : dmz -> (mat, cpx, p64, dns) t
  | DAS : das -> (arr, flt, p32, dns) t
  | DAD : dad -> (arr, flt, p64, dns) t
  | DAC : dac -> (arr, cpx, p32, dns) t
  | DAZ : daz -> (arr, cpx, p64, dns) t



(** some experiment code *)

let print_info : type a b c d . (a, b, c, d) t -> unit = function
  | F x -> Printf.printf "%g\n" x
  | C x -> Printf.printf "re=%g; im=%g\n" x.re x.im
  | DMS x -> Owl_dense_matrix.pp_dsmat x
  | DMD x -> Owl_dense_matrix.pp_dsmat x
  | _ -> failwith "unknown"

let im : type a b c d . (a, b, c, d) t -> (a, flt, c, d) t = function
  | F x -> F 0.
  | C x -> F x.im
  | DMZ x -> DMD (Owl_dense_real.ones 3 3)
  | _ -> failwith "unknown"
