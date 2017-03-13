(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

(* FIXME: need to unify with the Stats module in the future *)
let rng = Random.State.make_self_init ()

(* define constants *)

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

let _pos_inf : type a b. (a, b) kind -> a = function
  | Float32   -> infinity
  | Float64   -> infinity
  | Complex32 -> Complex.({re = infinity; im = infinity})
  | Complex64 -> Complex.({re = infinity; im = infinity})
  | _         -> failwith "_pos_inf: unsupported operation"

let _neg_inf : type a b. (a, b) kind -> a = function
  | Float32   -> neg_infinity
  | Float64   -> neg_infinity
  | Complex32 -> Complex.({re = neg_infinity; im = neg_infinity})
  | Complex64 -> Complex.({re = neg_infinity; im = neg_infinity})
  | _         -> failwith "_neg_inf: unsupported operation"

(* some transformation and helper functions *)

let _change_layout = Eigen.Utils.change_layout

let _size_in_bytes = Eigen.Utils.size_in_bytes

let ndarray_to_fortran_vec x =
  let shape = Genarray.dims x in
  let n = Array.fold_right (fun c a -> c * a) shape 1 in
  let y = _change_layout x fortran_layout in
  Bigarray.reshape_1 y n

let fortran_vec_to_ndarray x shape =
  let y = Bigarray.genarray_of_array1 x in
  let y = _change_layout y c_layout in
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
type ('a, 'b) lcm_mat = ('a, 'b, fortran_layout) Array2.t

type ('a, 'b) lcm_vec_op00 = (('a, 'b) lcm_vec) Lacaml.Common.Types.Vec.unop
type ('a, 'b) lcm_vec_op01 = ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> 'a
type ('a, 'b) lcm_vec_op02 = ?stable:bool -> ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> float
type ('a, 'b) lcm_vec_op03 = ?n:int -> ?c:'a -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> 'a
type ('a, 'b) lcm_vec_op04 = float -> int -> ('a, 'b) lcm_vec
type ('a, 'b) lcm_vec_op05 = (('a, 'b) lcm_vec) Lacaml.Common.Types.Vec.binop
type ('a, 'b) lcm_vec_op06 = ('a -> 'a) -> ?n:int -> ?ofsy:int -> ?incy:int -> ?y:('a, 'b) lcm_vec -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> ('a, 'b) lcm_vec
type ('a, 'b) lcm_vec_op07 = ('a -> unit) -> ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> unit
type ('a, 'b) lcm_vec_op08 = (int -> 'a -> unit) -> ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> unit
type ('a, 'b) lcm_vec_op09 = ?n:int -> 'a -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> unit
type ('a, 'b) lcm_vec_op10 = ?n:int -> ?ofsy:int -> ?incy:int -> ?y:('a, 'b) lcm_vec -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> ('a, 'b) lcm_vec
type ('a, 'b) lcm_vec_op11 = ?cmp:('a -> 'a -> int) -> ?decr:bool -> ?n:int -> ?ofsp:int -> ?incp:int -> ?p:Lacaml_common.int_vec -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> unit
type ('a, 'b) lcm_vec_op12 = ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) lcm_vec -> ?ofsy:int -> ?incy:int -> ('a, 'b) lcm_vec -> 'a

type ('a, 'b) lcm_mat_op00 = ('a, 'b) lcm_mat -> 'a array array
type ('a, 'b) lcm_mat_op01 = int -> int -> ('a, 'b) lcm_mat

(* call functions in lacaml *)

let _to_arrays : type a b . (a, b) kind -> (a, b) lcm_mat_op00 = function
  | Float32   -> Lacaml.S.Mat.to_array
  | Float64   -> Lacaml.D.Mat.to_array
  | Complex32 -> Lacaml.C.Mat.to_array
  | Complex64 -> Lacaml.Z.Mat.to_array
  | _         -> failwith "_to_arrays: unsupported operation"

let _make0 : type a b. (a, b) kind -> (a, b) lcm_mat_op01 = function
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

let _inv_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> fun x -> 1. /. x
  | Float64   -> fun x -> 1. /. x
  | Complex32 -> Complex.inv
  | Complex64 -> Complex.inv
  | _         -> failwith "_inv_elt: unsupported operation"

let _neg_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> fun x -> (-.x)
  | Float64   -> fun x -> (-.x)
  | Complex32 -> Complex.neg
  | Complex64 -> Complex.neg
  | _         -> failwith "_inv_elt: unsupported operation"

let _abs_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> abs_float
  | Float64   -> abs_float
  | Complex32 -> fun x -> Complex.({re = norm x; im = 0.})
  | Complex64 -> fun x -> Complex.({re = norm x; im = 0.})
  | _         -> failwith "_abs_elt: unsupported operation"

let _average_elt : type a b. (a, b) kind -> (a -> int -> a) = function
  | Float32   -> fun x n -> x /. (float_of_int n)
  | Float64   -> fun x n -> x /. (float_of_int n)
  | Complex32 -> fun x n -> Complex.(div x {re = float_of_int n; im = 0.})
  | Complex64 -> fun x n -> Complex.(div x {re = float_of_int n; im = 0.})
  | _         -> failwith "_average_elt: unsupported operation"

let _power_scalar_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( ** )
  | Float64   -> ( ** )
  | Complex32 -> Complex.pow
  | Complex64 -> Complex.pow
  | _         -> failwith "_power_scalar_elt: unsupported operation"

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

(* FIXME *)
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
  | _         -> failwith "_neg: unsupported operation"

let _sum : type a b. (a, b) kind -> (a, b) lcm_vec_op01 = function
  | Float32   -> Lacaml.S.Vec.sum
  | Float64   -> Lacaml.D.Vec.sum
  | Complex32 -> Lacaml.C.Vec.sum
  | Complex64 -> Lacaml.Z.Vec.sum
  | _         -> failwith "_sum: unsupported operation"

let _prod : type a b. (a, b) kind -> (a, b) lcm_vec_op01 = function
  | Float32   -> Lacaml.S.Vec.prod
  | Float64   -> Lacaml.D.Vec.prod
  | Complex32 -> Lacaml.C.Vec.prod
  | Complex64 -> Lacaml.Z.Vec.prod
  | _         -> failwith "_prod: unsupported operation"

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

let _ssqr_diff : type a b. (a, b) kind -> (a, b) lcm_vec_op12 = function
  | Float32   -> Lacaml.S.Vec.ssqr_diff
  | Float64   -> Lacaml.D.Vec.ssqr_diff
  | Complex32 -> Lacaml.C.Vec.ssqr_diff
  | Complex64 -> Lacaml.Z.Vec.ssqr_diff
  | _         -> failwith "_ssqr_diff: unsupported operation"

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
  | Float32   -> fun s -> Lacaml.S.Vec.random ~rnd_state:rng ~from:0. ~range:s
  | Float64   -> fun s -> Lacaml.D.Vec.random ~rnd_state:rng ~from:0. ~range:s
  | Complex32 -> fun s -> Lacaml.C.Vec.random ~rnd_state:rng ~re_from:0. ~re_range:s ~im_from:0. ~im_range:s
  | Complex64 -> fun s -> Lacaml.Z.Vec.random ~rnd_state:rng ~re_from:0. ~re_range:s ~im_from:0. ~im_range:s
  | _         -> failwith "_uniform: unsupported operation"

let _linspace : type a b. (a, b) kind -> a -> a -> int -> (a, b) lcm_vec =
  fun k a b n -> match k with
  | Float32   -> Lacaml.S.Vec.linspace a b n
  | Float64   -> Lacaml.D.Vec.linspace a b n
  | Complex32 -> Lacaml.C.Vec.linspace a b n
  | Complex64 -> Lacaml.Z.Vec.linspace a b n
  | _         -> failwith "_linspace: unsupported operation"

let _log_sum_exp : type a b. (a, b) kind -> (a, b) lcm_vec_op01 = function
  | Float32   -> Lacaml.S.Vec.log_sum_exp
  | Float64   -> Lacaml.D.Vec.log_sum_exp
  | _         -> failwith "_log_sum_exp: unsupported operation"

let _rev : type a b. (a, b) kind -> (a, b) lcm_vec -> (a, b) lcm_vec = function
  | Float32   -> Lacaml.S.Vec.rev
  | Float64   -> Lacaml.D.Vec.rev
  | Complex32 -> Lacaml.C.Vec.rev
  | Complex64 -> Lacaml.Z.Vec.rev
  | _         -> failwith "_rev: unsupported operation"

let _sort : type a b. (a, b) kind -> (a, b) lcm_vec_op11 = function
  | Float32   -> Lacaml.S.Vec.sort
  | Float64   -> Lacaml.D.Vec.sort
  | Complex32 -> Lacaml.C.Vec.sort
  | Complex64 -> Lacaml.Z.Vec.sort
  | _         -> failwith "_sort: unsupported operation"


(* interface to eigen functions, types for interfacing to eigen *)

type ('a, 'b) eigen_mat = ('a, 'b, c_layout) Array2.t

type ('a, 'b) eigen_mat_op00 = ('a, 'b) eigen_mat -> ('a, 'b) eigen_mat
type ('a, 'b) eigen_mat_op01 = ('a, 'b) eigen_mat -> int -> int -> unit
type ('a, 'b) eigen_mat_op02 = ('a, 'b) eigen_mat -> ('a, 'b) eigen_mat -> ('a, 'b) eigen_mat

(* call functions in eigen *)

let _eigen_transpose : type a b . (a, b) kind -> (a, b) eigen_mat_op00 = function
  | Float32   -> Eigen.Dense.S.transpose
  | Float64   -> Eigen.Dense.D.transpose
  | Complex32 -> Eigen.Dense.C.transpose
  | Complex64 -> Eigen.Dense.Z.transpose
  | _         -> failwith "_eigen_transpose: unsupported operation"

let _eigen_swap_rows : type a b . (a, b) kind -> (a, b) eigen_mat_op01 = function
  | Float32   -> Eigen.Dense.S.swap_rows
  | Float64   -> Eigen.Dense.D.swap_rows
  | Complex32 -> Eigen.Dense.C.swap_rows
  | Complex64 -> Eigen.Dense.Z.swap_rows
  | _         -> failwith "_eigen_swap_rows: unsupported operation"

let _eigen_swap_cols : type a b . (a, b) kind -> (a, b) eigen_mat_op01 = function
  | Float32   -> Eigen.Dense.S.swap_cols
  | Float64   -> Eigen.Dense.D.swap_cols
  | Complex32 -> Eigen.Dense.C.swap_cols
  | Complex64 -> Eigen.Dense.Z.swap_cols
  | _         -> failwith "_eigen_swap_cols: unsupported operation"

let _eigen_dot : type a b . (a, b) kind -> (a, b) eigen_mat_op02 = function
  | Float32   -> Eigen.Dense.S.dot
  | Float64   -> Eigen.Dense.D.dot
  | Complex32 -> Eigen.Dense.C.dot
  | Complex64 -> Eigen.Dense.Z.dot
  | _         -> failwith "_eigen_dot: unsupported operation"


(* interface to owl's c functions, types for interfacing to owl *)

type ('a, 'b) owl_vec = ('a, 'b, c_layout) Array1.t
type ('a, 'b) owl_mat = ('a, 'b, c_layout) Array2.t

type ('a, 'b) owl_vec_op00 = int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int
type ('a, 'b) owl_vec_op01 = int -> ('a, 'b) owl_vec -> int
type ('a, 'b) owl_vec_op02 = int -> ('a, 'b) owl_vec -> float
type ('a, 'b) owl_mat_op00 = ('a, 'b) owl_mat -> unit

(* call functions in owl native c *)

let _owl_elt_to_str : type a b. (a, b) kind -> (a -> bytes) = function
  | Float32   -> fun v -> Printf.sprintf "%G" v
  | Float64   -> fun v -> Printf.sprintf "%G" v
  | Int32     -> fun v -> Printf.sprintf "%i" (Int32.to_int v)
  | Int64     -> fun v -> Printf.sprintf "%i" (Int64.to_int v)
  | Complex32 -> fun v -> Printf.sprintf "(%G, %Gi)" Complex.(v.re) Complex.(v.im)
  | Complex64 -> fun v -> Printf.sprintf "(%G, %Gi)" Complex.(v.re) Complex.(v.im)
  | _         -> failwith "_owl_print_elt: unsupported operation"

let _owl_print_mat : type a b. (a, b) kind -> (a, b) owl_mat_op00 = function
  | Float32   -> Format.printf "%a\n" Owl_pretty.pp_fmat
  | Float64   -> Format.printf "%a\n" Owl_pretty.pp_fmat
  | Complex32 -> Format.printf "%a\n" Owl_pretty.pp_cmat
  | Complex64 -> Format.printf "%a\n" Owl_pretty.pp_cmat
  | _         -> failwith "_owl_print_mat: unsupported operation"

let _owl_print_mat_toplevel : type a b. (a, b) kind -> (a, b) owl_mat_op00 = function
  | Float32   -> Format.printf "%a\n" Owl_pretty.Toplevel.pp_fmat
  | Float64   -> Format.printf "%a\n" Owl_pretty.Toplevel.pp_fmat
  | Complex32 -> Format.printf "%a\n" Owl_pretty.Toplevel.pp_cmat
  | Complex64 -> Format.printf "%a\n" Owl_pretty.Toplevel.pp_cmat
  | _         -> failwith "_owl_print_mat_toplevel: unsupported operation"

let _owl_uniform : type a b. (a, b) kind -> (float -> a) = function
  | Float32   -> fun s -> Owl_stats.Rnd.uniform () *. s
  | Float64   -> fun s -> Owl_stats.Rnd.uniform () *. s
  | Complex32 -> fun s -> Complex.({re = Owl_stats.Rnd.uniform () *. s; im = Owl_stats.Rnd.uniform () *. s})
  | Complex64 -> fun s -> Complex.({re = Owl_stats.Rnd.uniform () *. s; im = Owl_stats.Rnd.uniform () *. s})
  | _         -> failwith "_owl_uniform: unsupported operation"

let _owl_gaussian : type a b. (a, b) kind -> (float -> a) = function
  | Float32   -> fun s -> Owl_stats.Rnd.gaussian ~sigma:s ()
  | Float64   -> fun s -> Owl_stats.Rnd.gaussian ~sigma:s ()
  | Complex32 -> fun s -> Complex.({re = Owl_stats.Rnd.gaussian ~sigma:s (); im = Owl_stats.Rnd.gaussian ~sigma:s ()})
  | Complex64 -> fun s -> Complex.({re = Owl_stats.Rnd.gaussian ~sigma:s (); im = Owl_stats.Rnd.gaussian ~sigma:s ()})
  | _         -> failwith "_owl_gaussian: unsupported operation"

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

external owl_real_float_is_zero : int -> ('a, 'b) owl_vec -> int = "real_float_is_zero"
external owl_real_double_is_zero : int -> ('a, 'b) owl_vec -> int = "real_double_is_zero"
external owl_complex_float_is_zero : int -> ('a, 'b) owl_vec -> int = "complex_float_is_zero"
external owl_complex_double_is_zero : int -> ('a, 'b) owl_vec -> int = "complex_double_is_zero"

let _owl_is_zero : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_is_zero
  | Float64   -> owl_real_double_is_zero
  | Complex32 -> owl_complex_float_is_zero
  | Complex64 -> owl_complex_double_is_zero
  | _         -> failwith "_owl_is_zero: unsupported operation"

external owl_real_float_is_positive : int -> ('a, 'b) owl_vec -> int = "real_float_is_positive"
external owl_real_double_is_positive : int -> ('a, 'b) owl_vec -> int = "real_double_is_positive"
external owl_complex_float_is_positive : int -> ('a, 'b) owl_vec -> int = "complex_float_is_positive"
external owl_complex_double_is_positive : int -> ('a, 'b) owl_vec -> int = "complex_double_is_positive"

let _owl_is_positive : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_is_positive
  | Float64   -> owl_real_double_is_positive
  | Complex32 -> owl_complex_float_is_positive
  | Complex64 -> owl_complex_double_is_positive
  | _         -> failwith "_owl_is_positive: unsupported operation"

external owl_real_float_is_negative : int -> ('a, 'b) owl_vec -> int = "real_float_is_negative"
external owl_real_double_is_negative : int -> ('a, 'b) owl_vec -> int = "real_double_is_negative"
external owl_complex_float_is_negative : int -> ('a, 'b) owl_vec -> int = "complex_float_is_negative"
external owl_complex_double_is_negative : int -> ('a, 'b) owl_vec -> int = "complex_double_is_negative"

let _owl_is_negative : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_is_negative
  | Float64   -> owl_real_double_is_negative
  | Complex32 -> owl_complex_float_is_negative
  | Complex64 -> owl_complex_double_is_negative
  | _         -> failwith "_owl_is_negative: unsupported operation"

external owl_real_float_is_nonnegative : int -> ('a, 'b) owl_vec -> int = "real_float_is_nonnegative"
external owl_real_double_is_nonnegative : int -> ('a, 'b) owl_vec -> int = "real_double_is_nonnegative"
external owl_complex_float_is_nonnegative : int -> ('a, 'b) owl_vec -> int = "complex_float_is_nonnegative"
external owl_complex_double_is_nonnegative : int -> ('a, 'b) owl_vec -> int = "complex_double_is_nonnegative"

let _owl_is_nonnegative : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_is_nonnegative
  | Float64   -> owl_real_double_is_nonnegative
  | Complex32 -> owl_complex_float_is_nonnegative
  | Complex64 -> owl_complex_double_is_nonnegative
  | _         -> failwith "_owl_is_nonnegative: unsupported operation"

external owl_real_float_is_nonpositive : int -> ('a, 'b) owl_vec -> int = "real_float_is_nonpositive"
external owl_real_double_is_nonpositive : int -> ('a, 'b) owl_vec -> int = "real_double_is_nonpositive"
external owl_complex_float_is_nonpositive : int -> ('a, 'b) owl_vec -> int = "complex_float_is_nonpositive"
external owl_complex_double_is_nonpositive : int -> ('a, 'b) owl_vec -> int = "complex_double_is_nonpositive"

let _owl_is_nonpositive : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_is_nonpositive
  | Float64   -> owl_real_double_is_nonpositive
  | Complex32 -> owl_complex_float_is_nonpositive
  | Complex64 -> owl_complex_double_is_nonpositive
  | _         -> failwith "_owl_is_nonpositive: unsupported operation"

external owl_real_float_nnz : int -> ('a, 'b) owl_vec -> int = "real_float_nnz"
external owl_real_double_nnz : int -> ('a, 'b) owl_vec -> int = "real_double_nnz"
external owl_complex_float_nnz : int -> ('a, 'b) owl_vec -> int = "complex_float_nnz"
external owl_complex_double_nnz : int -> ('a, 'b) owl_vec -> int = "complex_double_nnz"

let _owl_nnz : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_nnz
  | Float64   -> owl_real_double_nnz
  | Complex32 -> owl_complex_float_nnz
  | Complex64 -> owl_complex_double_nnz
  | _         -> failwith "_owl_nnz: unsupported operation"

external owl_real_float_sigmoid : int -> ('a, 'b) owl_vec -> int = "real_float_sigmoid"
external owl_real_double_sigmoid : int -> ('a, 'b) owl_vec -> int = "real_double_sigmoid"

let _owl_sigmoid : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_sigmoid
  | Float64   -> owl_real_double_sigmoid
  | _         -> failwith "_owl_sigmoid: unsupported operation"

external owl_real_float_abs : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> int = "real_float_abs"
external owl_real_double_abs : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> int = "real_double_abs"
external owl_complex_float_abs : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> int = "complex_float_abs"
external owl_complex_double_abs : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> int = "complex_double_abs"

(* FIXME: return type polymorphism ... *)
let _owl_abs : type a b c. (a, b) kind -> int -> (a, b) owl_vec -> int = fun k l x ->
  match k with
  | Float32   -> let y = Array1.create Float32 c_layout l in owl_real_float_abs l x y
  | Float64   -> let y = Array1.create Float64 c_layout l in owl_real_double_abs l x y
  | Complex32 -> let y = Array1.create Float32 c_layout l in owl_complex_float_abs l x y
  | Complex64 -> let y = Array1.create Float64 c_layout l in owl_complex_double_abs l x y
  | _         -> failwith "_owl_abs: unsupported operation"

external owl_real_float_l1norm : int -> (float, 'a) owl_vec -> float = "real_float_l1norm"
external owl_real_double_l1norm : int -> (float, 'a) owl_vec -> float = "real_double_l1norm"
external owl_complex_float_l1norm : int -> (Complex.t, 'a) owl_vec -> float = "complex_float_l1norm"
external owl_complex_double_l1norm : int -> (Complex.t, 'a) owl_vec -> float = "complex_double_l1norm"

let _owl_l1norm : type a b. (a, b) kind -> (a, b) owl_vec_op02 = function
  | Float32   -> owl_real_float_l1norm
  | Float64   -> owl_real_double_l1norm
  | Complex32 -> owl_complex_float_l1norm
  | Complex64 -> owl_complex_double_l1norm
  | _         -> failwith "_owl_l1norm: unsupported operation"

(* NOTE: same as sqr_nrm2, but slower *)
external owl_real_float_l2norm_sqr : int -> (float, 'a) owl_vec -> float = "real_float_l2norm_sqr"
external owl_real_double_l2norm_sqr : int -> (float, 'a) owl_vec -> float = "real_double_l2norm_sqr"
external owl_complex_float_l2norm_sqr : int -> (Complex.t, 'a) owl_vec -> float = "complex_float_l2norm_sqr"
external owl_complex_double_l2norm_sqr : int -> (Complex.t, 'a) owl_vec -> float = "complex_double_l2norm_sqr"

let _owl_l2norm_sqr : type a b. (a, b) kind -> (a, b) owl_vec_op02 = function
  | Float32   -> owl_real_float_l2norm_sqr
  | Float64   -> owl_real_double_l2norm_sqr
  | Complex32 -> owl_complex_float_l2norm_sqr
  | Complex64 -> owl_complex_double_l2norm_sqr
  | _         -> failwith "_owl_l2norm_sqr: unsupported operation"

external owl_real_float_min_i : int -> ('a, 'b) owl_vec -> int = "real_float_min_i"
external owl_real_double_min_i : int -> ('a, 'b) owl_vec -> int = "real_double_min_i"

let _owl_min_i : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_min_i
  | Float64   -> owl_real_double_min_i
  | _         -> failwith "_owl_min_i: unsupported operation"

external owl_real_float_max_i : int -> ('a, 'b) owl_vec -> int = "real_float_max_i"
external owl_real_double_max_i : int -> ('a, 'b) owl_vec -> int = "real_double_max_i"

let _owl_max_i : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_max_i
  | Float64   -> owl_real_double_max_i
  | _         -> failwith "_owl_max_i: unsupported operation"


(* ends here *)
