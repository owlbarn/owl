
open Bigarray

type flt = Flt

type cpx = Cpx

type mat = Mat

type vec = Vec

type arr = Arr

type num = Num

type p32 = P32

type p64 = P64


type ms = (float, float32_elt, c_layout) Array2.t

type md = (float, float64_elt, c_layout) Array2.t

type mc = (Complex.t, complex32_elt, c_layout) Array2.t

type mz = (Complex.t, complex64_elt, c_layout) Array2.t

type ns = (float, float32_elt, c_layout) Genarray.t

type nd = (float, float64_elt, c_layout) Genarray.t

type nc = (Complex.t, complex32_elt, c_layout) Genarray.t

type nz = (Complex.t, complex64_elt, c_layout) Genarray.t


type ('a, 'b, 'c) t =
  | F : float -> (num, flt, p64) t
  | C : Complex.t -> (num, cpx, p64) t
  | MS : ms -> (mat, flt, p32) t
  | MD : md -> (mat, flt, p64) t
  | MC : mc -> (mat, cpx, p32) t
  | MZ : mz -> (mat, cpx, p64) t
  | NS : ns -> (arr, flt, p32) t
  | ND : nd -> (arr, flt, p64) t
  | NC : nc -> (arr, cpx, p32) t
  | NZ : nz -> (arr, cpx, p64) t

let print_info : type a b c . (a, b, c) t -> unit = function
  | F x -> Printf.printf "%g\n" x
  | C x -> Printf.printf "re=%g; im=%g\n" x.re x.im
  | MS x -> Owl_dense_matrix.pp_dsmat x
  | MD x -> Owl_dense_matrix.pp_dsmat x
  | _ -> failwith "unknown"

let im : type a b c . (a, b, c) t -> (a, flt, c) t = function
  | F x -> F 0.
  | C x -> F x.im
  | MZ x -> MD (Owl_dense_real.ones 3 3)
  | _ -> failwith "unknown"
