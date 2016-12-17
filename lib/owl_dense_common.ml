(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

(* some transformation and helper functions *)

let ndarray_to_fortran_vec x =
  let shape = Genarray.dims x in
  let n = Array.fold_right (fun c a -> c * a) shape 1 in
  let y = Genarray.change_layout x fortran_layout in
  Bigarray.reshape_1 y n

let fortran_vec_to_ndarray x shape =
  let y = Bigarray.genarray_of_array1 x in
  let y = Genarray.change_layout y c_layout in
  Bigarray.reshape y shape

let c_mat_to_ndarray x = None

let ndarray_to_c_mat x =
  let shape = Genarray.dims x in
  let n = Array.fold_right (fun c a -> c * a) shape 1 in
  let y = reshape_2 x 1 n in
  y

(* calculate the stride of a ndarray, s is the shape *)
let _calc_stride s =
  let d = Array.length s in
  let r = Array.make d 1 in
  for i = 1 to d - 1 do
    r.(d - i - 1) <- s.(d - i) * r.(d - i)
  done;
  r

(* c layout index translation: 1d -> nd
  i is one-dimensional index; j is n-dimensional index; s is the stride.
  the space needs to be pre-allocated *)
let _index_1d_nd i j s =
  j.(0) <- i / s.(0);
  for k = 1 to Array.length s - 1 do
    j.(k) <- (i mod s.(k - 1)) / s.(k);
  done

(* c layout index translation: nd -> 1d
  j is n-dimensional index; s is the stride.
  the space needs to be pre-allocated *)
let _index_nd_1d j s =
  let i = ref 0 in
  Array.iteri (fun k a -> i := !i + (a * s.(k))) j;
  !i


(* interface to lacaml functions, types for interfacing to lacaml *)

type ('a, 'b) lcm_vec = ('a, 'b, fortran_layout) Array1.t

type ('a, 'b) lcm_vec_op00 = (('a, 'b) lcm_vec) Lacaml.Common.Types.Vec.unop
type ('a, 'b) lcm_vec_op01 = ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> 'a
type ('a, 'b) lcm_vec_op02 = ?stable:bool -> ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> float
type ('a, 'b) lcm_vec_op03 = ?n:int -> ?c:'a -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> 'a
type ('a, 'b) lcm_vec_op04 = ?rnd_state:Random.State.t -> ?from:'a -> ?range:'a -> int -> ('a, 'b) lcm_vec
type ('a, 'b) lcm_vec_op05 = (('a, 'b) lcm_vec) Lacaml.Common.Types.Vec.binop
type ('a, 'b) lcm_vec_op06 = ('a -> 'a) -> ?n:int -> ?ofsy:int -> ?incy:int -> ?y:('a, 'b) lcm_vec -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> ('a, 'b) lcm_vec
type ('a, 'b) lcm_vec_op07 = ('a -> unit) -> ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> unit
type ('a, 'b) lcm_vec_op08 = (int -> 'a -> unit) -> ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> unit
type ('a, 'b) lcm_vec_op09 = ?n:int -> 'a -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> unit
type ('a, 'b) lcm_vec_op10 = ?n:int -> ?ofsy:int -> ?incy:int -> ?y:('a, 'b) lcm_vec -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> ('a, 'b) lcm_vec

(* call functions in lacaml *)

let _zero : type a b. (a, b) kind -> a = function
    | Float32 -> 0.0 | Complex32 -> Complex.zero
    | Float64 -> 0.0 | Complex64 -> Complex.zero
    | Int8_signed -> 0 | Int8_unsigned -> 0
    | Int16_signed -> 0 | Int16_unsigned -> 0
    | Int32 -> 0l | Int64 -> 0L
    | Int -> 0 | Nativeint -> 0n
    | Char -> '\000'

let _one : type a b. (a, b) kind -> a = function
    | Float32 -> 1.0 | Complex32 -> Complex.one
    | Float64 -> 1.0 | Complex64 -> Complex.one
    | Int8_signed -> 1 | Int8_unsigned -> 1
    | Int16_signed -> 1 | Int16_unsigned -> 1
    | Int32 -> 1l | Int64 -> 1L
    | Int -> 1 | Nativeint -> 1n
    | Char -> '\001'

let _make0 : type a b. (a, b) kind -> (int -> int -> (a, b, fortran_layout) Array2.t) = function
  | Float32   -> Lacaml.S.Mat.make0
  | Float64   -> Lacaml.D.Mat.make0
  | Complex32 -> Lacaml.C.Mat.make0
  | Complex64 -> Lacaml.Z.Mat.make0
  | _         -> failwith "_make0: unsupported operation"

let _add_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( +. )
  | Float64   -> ( +. )
  | Complex32 -> Complex.add
  | Complex64 -> Complex.add
  | _         -> failwith "_add_elt: unsupported operation"

let _sub_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( -. )
  | Float64   -> ( -. )
  | Complex32 -> Complex.sub
  | Complex64 -> Complex.sub
  | _         -> failwith "_sub_elt: unsupported operation"

let _mul_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( *. )
  | Float64   -> ( *. )
  | Complex32 -> Complex.mul
  | Complex64 -> Complex.mul
  | _         -> failwith "_mul_elt: unsupported operation"

let _div_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( /. )
  | Float64   -> ( /. )
  | Complex32 -> Complex.div
  | Complex64 -> Complex.div
  | _         -> failwith "_div: unsupported operation"

let _add : type a b. (a, b) kind -> (a, b) lcm_vec_op05 = function
  | Float32   -> Lacaml.S.Vec.add
  | Float64   -> Lacaml.D.Vec.add
  | Complex32 -> Lacaml.C.Vec.add
  | Complex64 -> Lacaml.Z.Vec.add
  | _         -> failwith "_add: unsupported operation"

let _sub : type a b. (a, b) kind -> (a, b) lcm_vec_op05 = function
  | Float32   -> Lacaml.S.Vec.sub
  | Float64   -> Lacaml.D.Vec.sub
  | Complex32 -> Lacaml.C.Vec.sub
  | Complex64 -> Lacaml.Z.Vec.sub
  | _         -> failwith "_sub: unsupported operation"

let _mul : type a b. (a, b) kind -> (a, b) lcm_vec_op05 = function
  | Float32   -> Lacaml.S.Vec.mul
  | Float64   -> Lacaml.D.Vec.mul
  | Complex32 -> Lacaml.C.Vec.mul
  | Complex64 -> Lacaml.Z.Vec.mul
  | _         -> failwith "_mul: unsupported operation"

let _div : type a b. (a, b) kind -> (a, b) lcm_vec_op05 = function
  | Float32   -> Lacaml.S.Vec.div
  | Float64   -> Lacaml.D.Vec.div
  | Complex32 -> Lacaml.C.Vec.div
  | Complex64 -> Lacaml.Z.Vec.div
  | _         -> failwith "_div: unsupported operation"

let _min : type a b. (a, b) kind -> (a, b) lcm_vec_op01 = function
  | Float32   -> Lacaml.S.Vec.min
  | Float64   -> Lacaml.D.Vec.min
  | Complex32 -> Lacaml.C.Vec.min
  | Complex64 -> Lacaml.Z.Vec.min
  | _         -> failwith "_min: unsupported operation"

let _max : type a b. (a, b) kind -> (a, b) lcm_vec_op01 = function
  | Float32   -> Lacaml.S.Vec.max
  | Float64   -> Lacaml.D.Vec.max
  | Complex32 -> Lacaml.C.Vec.max
  | Complex64 -> Lacaml.Z.Vec.max
  | _         -> failwith "_max: unsupported operation"

let _abs : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.abs
  | Float64   -> Lacaml.D.Vec.abs
  | Complex32 -> failwith "_abs: unsupported operation"
  | Complex64 -> failwith "_abs: unsupported operation"
  | _         -> failwith "_abs: unsupported operation"

let _neg : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.neg
  | Float64   -> Lacaml.D.Vec.neg
  | Complex32 -> Lacaml.C.Vec.neg
  | Complex64 -> Lacaml.Z.Vec.neg
  | _         -> failwith "_abs: unsupported operation"

let _sum : type a b. (a, b) kind -> (a, b) lcm_vec_op01 = function
  | Float32   -> Lacaml.S.Vec.sum
  | Float64   -> Lacaml.D.Vec.sum
  | Complex32 -> Lacaml.C.Vec.sum
  | Complex64 -> Lacaml.Z.Vec.sum
  | _         -> failwith "_abs: unsupported operation"

let _sqr_nrm2 : type a b. (a, b) kind -> (a, b) lcm_vec_op02 = function
  | Float32   -> Lacaml.S.Vec.sqr_nrm2
  | Float64   -> Lacaml.D.Vec.sqr_nrm2
  | Complex32 -> Lacaml.C.Vec.sqr_nrm2
  | Complex64 -> Lacaml.Z.Vec.sqr_nrm2
  | _         -> failwith "_sqr_nrm2: unsupported operation"

let _ssqr : type a b. (a, b) kind -> (a, b) lcm_vec_op03 = function
  | Float32   -> Lacaml.S.Vec.ssqr
  | Float64   -> Lacaml.D.Vec.ssqr
  | Complex32 -> Lacaml.C.Vec.ssqr
  | Complex64 -> Lacaml.Z.Vec.ssqr
  | _         -> failwith "_ssqr: unsupported operation"

let _add_scalar : type a b. (a, b) kind -> (a -> (a, b) lcm_vec_op00) = function
  | Float32   -> Lacaml.S.Vec.add_const
  | Float64   -> Lacaml.D.Vec.add_const
  | Complex32 -> Lacaml.C.Vec.add_const
  | Complex64 -> Lacaml.Z.Vec.add_const
  | _         -> failwith "_add_scalar: unsupported operation"

let _map_op : type a b. (a, b) kind -> (a, b) lcm_vec_op06 = function
  | Float32   -> Lacaml.S.Vec.map
  | Float64   -> Lacaml.D.Vec.map
  | Complex32 -> Lacaml.C.Vec.map
  | Complex64 -> Lacaml.Z.Vec.map
  | _         -> failwith "_map_op: unsupported operation"

let _iter_op : type a b. (a, b) kind -> (a, b) lcm_vec_op07 = function
  | Float32   -> Lacaml.S.Vec.iter
  | Float64   -> Lacaml.D.Vec.iter
  | Complex32 -> Lacaml.C.Vec.iter
  | Complex64 -> Lacaml.Z.Vec.iter
  | _         -> failwith "_iter_op: unsupported operation"

let _iteri_op : type a b. (a, b) kind -> (a, b) lcm_vec_op08 = function
  | Float32   -> Lacaml.S.Vec.iteri
  | Float64   -> Lacaml.D.Vec.iteri
  | Complex32 -> Lacaml.C.Vec.iteri
  | Complex64 -> Lacaml.Z.Vec.iteri
  | _         -> failwith "_iteri_op: unsupported operation"

let _mul_scalar : type a b. (a, b) kind -> (a, b) lcm_vec_op09 = function
  | Float32   -> Lacaml.S.scal
  | Float64   -> Lacaml.D.scal
  | Complex32 -> Lacaml.C.scal
  | Complex64 -> Lacaml.Z.scal
  | _         -> failwith "_mul_scalar: unsupported operation"

let _signum : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.signum
  | Float64   -> Lacaml.D.Vec.signum
  | _         -> failwith "_signum: unsupported operation"

let _sqr : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.sqr
  | Float64   -> Lacaml.D.Vec.sqr
  | _         -> failwith "_sqr: unsupported operation"

let _sqrt : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.sqrt
  | Float64   -> Lacaml.D.Vec.sqrt
  | _         -> failwith "_sqrt: unsupported operation"

let _cbrt : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.cbrt
  | Float64   -> Lacaml.D.Vec.cbrt
  | _         -> failwith "_cbrt: unsupported operation"

let _exp : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.exp
  | Float64   -> Lacaml.D.Vec.exp
  | _         -> failwith "_exp: unsupported operation"

let _exp2 : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.exp2
  | Float64   -> Lacaml.D.Vec.exp2
  | _         -> failwith "_exp2: unsupported operation"

let _expm1 : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.expm1
  | Float64   -> Lacaml.D.Vec.expm1
  | _         -> failwith "_expm1: unsupported operation"

let _log : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.log
  | Float64   -> Lacaml.D.Vec.log
  | _         -> failwith "_log: unsupported operation"

let _log10 : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.log10
  | Float64   -> Lacaml.D.Vec.log10
  | _         -> failwith "_log10: unsupported operation"

let _log2 : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.log2
  | Float64   -> Lacaml.D.Vec.log2
  | _         -> failwith "_log2: unsupported operation"

let _log1p : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.log1p
  | Float64   -> Lacaml.D.Vec.log1p
  | _         -> failwith "_log1p: unsupported operation"

let _sin : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.sin
  | Float64   -> Lacaml.D.Vec.sin
  | _         -> failwith "_sin: unsupported operation"

let _cos : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.cos
  | Float64   -> Lacaml.D.Vec.cos
  | _         -> failwith "_cos: unsupported operation"

let _tan : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.tan
  | Float64   -> Lacaml.D.Vec.tan
  | _         -> failwith "_tan: unsupported operation"

let _asin : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.asin
  | Float64   -> Lacaml.D.Vec.asin
  | _         -> failwith "_asin: unsupported operation"

let _acos : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.acos
  | Float64   -> Lacaml.D.Vec.acos
  | _         -> failwith "_acos: unsupported operation"

let _atan : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.atan
  | Float64   -> Lacaml.D.Vec.atan
  | _         -> failwith "_atan: unsupported operation"

let _sinh : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.sinh
  | Float64   -> Lacaml.D.Vec.sinh
  | _         -> failwith "_sinh: unsupported operation"

let _cosh : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.cosh
  | Float64   -> Lacaml.D.Vec.cosh
  | _         -> failwith "_cosh: unsupported operation"

let _tanh : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.tanh
  | Float64   -> Lacaml.D.Vec.tanh
  | _         -> failwith "_tanh: unsupported operation"

let _asinh : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.asinh
  | Float64   -> Lacaml.D.Vec.asinh
  | _         -> failwith "_asinh: unsupported operation"

let _acosh : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.acosh
  | Float64   -> Lacaml.D.Vec.acosh
  | _         -> failwith "_acosh: unsupported operation"

let _atanh : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.atanh
  | Float64   -> Lacaml.D.Vec.atanh
  | _         -> failwith "_atanh: unsupported operation"

let _floor : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.floor
  | Float64   -> Lacaml.D.Vec.floor
  | _         -> failwith "_floor: unsupported operation"

let _ceil : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.ceil
  | Float64   -> Lacaml.D.Vec.ceil
  | _         -> failwith "_ceil: unsupported operation"

let _round : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.round
  | Float64   -> Lacaml.D.Vec.round
  | _         -> failwith "_round: unsupported operation"

let _trunc : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.trunc
  | Float64   -> Lacaml.D.Vec.trunc
  | _         -> failwith "_trunc: unsupported operation"

let _erf : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.erf
  | Float64   -> Lacaml.D.Vec.erf
  | _         -> failwith "_erf: unsupported operation"

let _erfc : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.erfc
  | Float64   -> Lacaml.D.Vec.erfc
  | _         -> failwith "_erfc: unsupported operation"

let _logistic : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.logistic
  | Float64   -> Lacaml.D.Vec.logistic
  | _         -> failwith "_logistic: unsupported operation"

let _relu : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.relu
  | Float64   -> Lacaml.D.Vec.relu
  | _         -> failwith "_relu: unsupported operation"

let _softplus : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.softplus
  | Float64   -> Lacaml.D.Vec.softplus
  | _         -> failwith "_softplus: unsupported operation"

let _softsign : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.softsign
  | Float64   -> Lacaml.D.Vec.softsign
  | _         -> failwith "_softsign: unsupported operation"

let _reci : type a b. (a, b) kind -> (a, b) lcm_vec_op00 = function
  | Float32   -> Lacaml.S.Vec.reci
  | Float64   -> Lacaml.D.Vec.reci
  | Complex32 -> Lacaml.C.Vec.reci
  | Complex64 -> Lacaml.Z.Vec.reci
  | _         -> failwith "_reci: unsupported operation"

let _pow : type a b. (a, b) kind -> (a, b) lcm_vec_op05 = function
  | Float32   -> Lacaml.S.Vec.pow
  | Float64   -> Lacaml.D.Vec.pow
  | _         -> failwith "_pow: unsupported operation"

let _atan2 : type a b. (a, b) kind -> (a, b) lcm_vec_op05 = function
  | Float32   -> Lacaml.S.Vec.atan2
  | Float64   -> Lacaml.D.Vec.atan2
  | _         -> failwith "_atan2: unsupported operation"

let _hypot : type a b. (a, b) kind -> (a, b) lcm_vec_op05 = function
  | Float32   -> Lacaml.S.Vec.hypot
  | Float64   -> Lacaml.D.Vec.hypot
  | _         -> failwith "_hypot: unsupported operation"

let _min2 : type a b. (a, b) kind -> (a, b) lcm_vec_op05 = function
  | Float32   -> Lacaml.S.Vec.min2
  | Float64   -> Lacaml.D.Vec.min2
  | _         -> failwith "_min2: unsupported operation"

let _max2 : type a b. (a, b) kind -> (a, b) lcm_vec_op05 = function
  | Float32   -> Lacaml.S.Vec.max2
  | Float64   -> Lacaml.D.Vec.max2
  | _         -> failwith "_max2: unsupported operation"

let _copy : type a b. (a, b) kind -> (a, b) lcm_vec_op10 = function
  | Float32   -> Lacaml.S.copy
  | Float64   -> Lacaml.D.copy
  | Complex32 -> Lacaml.C.copy
  | Complex64 -> Lacaml.Z.copy
  | _         -> failwith "_copy: unsupported operation"

let _uniform : type a b. (a, b) kind -> (a, b) lcm_vec_op04 = function
  | Float32   -> Lacaml.S.Vec.random
  | Float64   -> Lacaml.D.Vec.random
  | _         -> failwith "_uniform: unsupported operation"


(* interface to gsl functions, types for interfacing to gsl *)

type ('a, 'b) gsl_mat = ('a, 'b, c_layout) Array2.t

type ('a, 'b) gsl_mat_op00 = ('a, 'b) gsl_mat -> bool
type ('a, 'b) gsl_mat_op01 = ('a, 'b) gsl_mat -> ('a, 'b) gsl_mat -> unit
type ('a, 'b) gsl_mat_op02 = ('a, 'b) gsl_mat -> int -> int -> unit
type ('a, 'b) gsl_mat_op03 = ('a, 'b) gsl_mat -> 'a
type ('a, 'b) gsl_mat_op04 = ('a, 'b) gsl_mat -> 'a * int * int
type ('a, 'b) gsl_mat_op05 = ('a, 'b) gsl_mat -> 'a * 'a
type ('a, 'b) gsl_mat_op06 = ('a, 'b) gsl_mat -> ('a * int * int) * ('a * int * int)
type ('a, 'b) gsl_mat_op07 = ('a, 'b) gsl_mat -> unit

(* call functions in gsl *)

let _gsl_transpose_copy : type a b. (a, b) kind -> (a, b) gsl_mat_op01 = function
  | Float32   -> Gsl.Matrix.Single.transpose
  | Float64   -> Gsl.Matrix.transpose
  | Complex32 -> Gsl.Matrix_complex.Single.transpose
  | Complex64 -> Gsl.Matrix_complex.transpose
  | _         -> failwith "_gsl_transpose_copy: unsupported operation"

let _gsl_transpose_in_place : type a b. (a, b) kind -> (a, b) gsl_mat_op07 = function
  | Float32   -> Gsl.Matrix.Single.transpose_in_place
  | Float64   -> Gsl.Matrix.transpose_in_place
  | Complex32 -> Gsl.Matrix_complex.Single.transpose_in_place
  | Complex64 -> Gsl.Matrix_complex.transpose_in_place
  | _         -> failwith "_gsl_transpose_in_place: unsupported operation"

let _gsl_swap_rows : type a b. (a, b) kind -> (a, b) gsl_mat_op02 = function
  | Float32   -> Gsl.Matrix.Single.swap_rows
  | Float64   -> Gsl.Matrix.swap_rows
  | Complex32 -> Gsl.Matrix_complex.Single.swap_rows
  | Complex64 -> Gsl.Matrix_complex.swap_rows
  | _         -> failwith "_gsl_swap_rows: unsupported operation"

let _gsl_swap_cols : type a b. (a, b) kind -> (a, b) gsl_mat_op02 = function
  | Float32   -> Gsl.Matrix.Single.swap_columns
  | Float64   -> Gsl.Matrix.swap_columns
  | Complex32 -> Gsl.Matrix_complex.Single.swap_columns
  | Complex64 -> Gsl.Matrix_complex.swap_columns
  | _         -> failwith "_gsl_swap_cols: unsupported operation"

let _gsl_isnull : type a b. (a, b) kind -> (a, b) gsl_mat_op00 = function
  | Float32   -> Owl_foreign.Dense_real_float.ml_gsl_matrix_isnull
  | Float64   -> Owl_foreign.Dense_real_double.ml_gsl_matrix_isnull
  | Complex32 -> Owl_foreign.Dense_complex_float.ml_gsl_matrix_isnull
  | Complex64 -> Owl_foreign.Dense_complex_double.ml_gsl_matrix_isnull
  | _         -> failwith "_gsl_isnull: unsupported operation"

let _gsl_ispos : type a b. (a, b) kind -> (a, b) gsl_mat_op00 = function
  | Float32   -> Owl_foreign.Dense_real_float.ml_gsl_matrix_ispos
  | Float64   -> Owl_foreign.Dense_real_double.ml_gsl_matrix_ispos
  | Complex32 -> Owl_foreign.Dense_complex_float.ml_gsl_matrix_ispos
  | Complex64 -> Owl_foreign.Dense_complex_double.ml_gsl_matrix_ispos
  | _         -> failwith "_gsl_ispos: unsupported operation"

let _gsl_isneg : type a b. (a, b) kind -> (a, b) gsl_mat_op00 = function
  | Float32   -> Owl_foreign.Dense_real_float.ml_gsl_matrix_isneg
  | Float64   -> Owl_foreign.Dense_real_double.ml_gsl_matrix_isneg
  | Complex32 -> Owl_foreign.Dense_complex_float.ml_gsl_matrix_isneg
  | Complex64 -> Owl_foreign.Dense_complex_double.ml_gsl_matrix_isneg
  | _         -> failwith "_gsl_isneg: unsupported operation"

let _gsl_isnonneg : type a b. (a, b) kind -> (a, b) gsl_mat_op00 = function
  | Float32   -> Owl_foreign.Dense_real_float.ml_gsl_matrix_isnonneg
  | Float64   -> Owl_foreign.Dense_real_double.ml_gsl_matrix_isnonneg
  | Complex32 -> Owl_foreign.Dense_complex_float.ml_gsl_matrix_isnonneg
  | Complex64 -> Owl_foreign.Dense_complex_double.ml_gsl_matrix_isnonneg
  | _         -> failwith "_gsl_isnonneg: unsupported operation"

let _gsl_min : type a b. (a, b) kind -> (a, b) gsl_mat_op03 = function
  | Float32   -> Owl_foreign.Dense_real_float.ml_gsl_matrix_min
  | Float64   -> Owl_foreign.Dense_real_double.ml_gsl_matrix_min
  | _         -> failwith "_gsl_min: unsupported operation"

let _gsl_max : type a b. (a, b) kind -> (a, b) gsl_mat_op03 = function
  | Float32   -> Owl_foreign.Dense_real_float.ml_gsl_matrix_max
  | Float64   -> Owl_foreign.Dense_real_double.ml_gsl_matrix_max
  | _         -> failwith "_gsl_max: unsupported operation"

let _gsl_minmax : type a b. (a, b) kind -> (a, b) gsl_mat_op05 = function
  | Float32   -> Owl_foreign.Dense_real_float.ml_gsl_matrix_minmax
  | Float64   -> Owl_foreign.Dense_real_double.ml_gsl_matrix_minmax
  | _         -> failwith "_gsl_minmax: unsupported operation"

let _gsl_min_index : type a b. (a, b) kind -> (a, b) gsl_mat_op04 = function
  | Float32   -> Owl_foreign.Dense_real_float.ml_gsl_matrix_min_index
  | Float64   -> Owl_foreign.Dense_real_double.ml_gsl_matrix_min_index
  | _         -> failwith "_gsl_min_index: unsupported operation"

let _gsl_max_index : type a b. (a, b) kind -> (a, b) gsl_mat_op04 = function
  | Float32   -> Owl_foreign.Dense_real_float.ml_gsl_matrix_max_index
  | Float64   -> Owl_foreign.Dense_real_double.ml_gsl_matrix_max_index
  | _         -> failwith "_gsl_max_index: unsupported operation"

let _gsl_minmax_index : type a b. (a, b) kind -> (a, b) gsl_mat_op06 = function
  | Float32   -> Owl_foreign.Dense_real_float.ml_gsl_matrix_minmax_index
  | Float64   -> Owl_foreign.Dense_real_double.ml_gsl_matrix_minmax_index
  | _         -> failwith "_gsl_minmax_index: unsupported operation"


(* experimental: interface to owl's native c code *)
(* interface to owl's c functions, types for interfacing to owl *)

type ('a, 'b) owl_vec = ('a, 'b, c_layout) Array1.t

type ('a, 'b) owl_vec_op00 = int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int

(* call functions in owl native c *)

external owl_real_float_is_smaller : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_float_is_smaller"
external owl_real_double_is_smaller : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_double_is_smaller"
external owl_complex_float_is_smaller : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_float_is_smaller"
external owl_complex_double_is_smaller : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_double_is_smaller"

let _owl_is_smaller : type a b. (a, b) kind -> (a, b) owl_vec_op00 = function
  | Float32   -> owl_real_float_is_smaller
  | Float64   -> owl_real_double_is_smaller
  | Complex32 -> owl_complex_float_is_smaller
  | Complex64 -> owl_complex_double_is_smaller
  | _         -> failwith "_owl_is_smaller: unsupported operation"

external owl_real_float_is_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_float_is_greater"
external owl_real_double_is_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_double_is_greater"
external owl_complex_float_is_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_float_is_greater"
external owl_complex_double_is_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_double_is_greater"

let _owl_is_greater : type a b. (a, b) kind -> (a, b) owl_vec_op00 = function
  | Float32   -> owl_real_float_is_greater
  | Float64   -> owl_real_double_is_greater
  | Complex32 -> owl_complex_float_is_greater
  | Complex64 -> owl_complex_double_is_greater
  | _         -> failwith "_owl_is_greater: unsupported operation"

external owl_real_float_equal_or_smaller : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_float_equal_or_smaller"
external owl_real_double_equal_or_smaller : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_double_equal_or_smaller"
external owl_complex_float_equal_or_smaller : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_float_equal_or_smaller"
external owl_complex_double_equal_or_smaller : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_double_equal_or_smaller"

let _owl_equal_or_smaller : type a b. (a, b) kind -> (a, b) owl_vec_op00 = function
  | Float32   -> owl_real_float_equal_or_smaller
  | Float64   -> owl_real_double_equal_or_smaller
  | Complex32 -> owl_complex_float_equal_or_smaller
  | Complex64 -> owl_complex_double_equal_or_smaller
  | _         -> failwith "_owl_equal_or_smaller: unsupported operation"

external owl_real_float_equal_or_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_float_equal_or_greater"
external owl_real_double_equal_or_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_double_equal_or_greater"
external owl_complex_float_equal_or_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_float_equal_or_greater"
external owl_complex_double_equal_or_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_double_equal_or_greater"

let _owl_equal_or_greater : type a b. (a, b) kind -> (a, b) owl_vec_op00 = function
  | Float32   -> owl_real_float_equal_or_greater
  | Float64   -> owl_real_double_equal_or_greater
  | Complex32 -> owl_complex_float_equal_or_greater
  | Complex64 -> owl_complex_double_equal_or_greater
  | _         -> failwith "_owl_equal_or_greater: unsupported operation"
