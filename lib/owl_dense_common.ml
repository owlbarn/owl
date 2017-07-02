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

let _size_in_bytes = Eigen.Utils.size_in_bytes

let ndarray_to_c_mat x =
  let shape = Genarray.dims x in
  let n = Array.fold_right (fun c a -> c * a) shape 1 in
  reshape_2 x 1 n

(* calculate the stride of a ndarray, s is the shape
  for [x] of shape [|2;3;4|], the return is [|12;4;1|]
 *)
let _calc_stride s =
  let d = Array.length s in
  let r = Array.make d 1 in
  for i = 1 to d - 1 do
    r.(d - i - 1) <- s.(d - i) * r.(d - i)
  done;
  r

(* calculate the slice size in each dimension, s is the shape.
  for [x] of shape [|2;3;4|], the return is [|24;12;4|]
*)
let _calc_slice s =
  let d = Array.length s in
  let r = Array.make d s.(d-1) in
  for i = d - 2 downto 0 do
    r.(i) <- s.(i) * r.(i+1)
  done;
  r

(* c layout index translation: 1d -> nd
  i is one-dimensional index; j is n-dimensional index; s is the stride.
  the space of j needs to be pre-allocated *)
let _index_1d_nd i j s =
  j.(0) <- i / s.(0);
  for k = 1 to Array.length s - 1 do
    j.(k) <- (i mod s.(k - 1)) / s.(k);
  done

(* c layout index translation: nd -> 1d
  j is n-dimensional index; s is the stride. *)
let _index_nd_1d j s =
  let i = ref 0 in
  Array.iteri (fun k a -> i := !i + (a * s.(k))) j;
  !i


(* basic operations on individual element *)

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

let _log_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Pervasives.log
  | Float64   -> Pervasives.log
  | Complex32 -> Complex.log
  | Complex64 -> Complex.log
  | _         -> failwith "_log_elt: unsupported operation"

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


(* interface to eigen functions, types for interfacing to eigen *)

type ('a, 'b) eigen_mat = ('a, 'b, c_layout) Array2.t
type ('a, 'b) eigen_arr = ('a, 'b, c_layout) Genarray.t

type ('a, 'b) eigen_mat_op00 = ('a, 'b) eigen_mat -> ('a, 'b) eigen_mat
type ('a, 'b) eigen_mat_op01 = ('a, 'b) eigen_mat -> int -> int -> unit
type ('a, 'b) eigen_mat_op02 = ('a, 'b) eigen_mat -> ('a, 'b) eigen_mat -> ('a, 'b) eigen_mat
type ('a, 'b) eigen_mat_op03 = int -> ('a, 'b) eigen_mat -> ('a, 'b) eigen_mat -> unit
type ('a, 'b) eigen_arr_op00 = ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
type ('a, 'b) eigen_arr_op01 = ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
type ('a, 'b) eigen_arr_op02 = ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
type ('a, 'b) eigen_arr_op03 = ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
type ('a, 'b) eigen_arr_op04 = ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
type ('a, 'b) eigen_arr_op05 = ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
type ('a, 'b) eigen_arr_op06 = ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> (int64, int64_elt) eigen_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
type ('a, 'b) eigen_arr_op07 = ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
type ('a, 'b) eigen_arr_op08 = ('a, 'b) eigen_arr -> ('a, 'b) eigen_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

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

let _eigen_gemm : type a b . (a, b) kind -> (a, b) eigen_mat_op02 = function
  | Float32   -> Eigen.Dense.S.gemm
  | Float64   -> Eigen.Dense.D.gemm
  | Complex32 -> Eigen.Dense.C.gemm
  | Complex64 -> Eigen.Dense.Z.gemm
  | _         -> failwith "_eigen_gemm: unsupported operation"

let _eigen_inv : type a b . (a, b) kind -> (a, b) eigen_mat_op00 = function
  | Float32   -> Eigen.Dense.S.inv
  | Float64   -> Eigen.Dense.D.inv
  | Complex32 -> Eigen.Dense.C.inv
  | Complex64 -> Eigen.Dense.Z.inv
  | _         -> failwith "_eigen_inv: unsupported operation"

let _eigen_spatial_conv : type a b . (a, b) kind -> (a, b) eigen_arr_op00 = function
  | Float32   -> Eigen.Tensor.S.spatial_conv
  | Float64   -> Eigen.Tensor.D.spatial_conv
  | _         -> failwith "_eigen_spatial_conv: unsupported operation"

let _eigen_spatial_conv_backward_input : type a b . (a, b) kind -> (a, b) eigen_arr_op01 = function
  | Float32   -> Eigen.Tensor.S.spatial_conv_backward_input
  | Float64   -> Eigen.Tensor.D.spatial_conv_backward_input
  | _         -> failwith "_eigen_spatial_conv_backward_input: unsupported operation"

let _eigen_spatial_conv_backward_kernel : type a b . (a, b) kind -> (a, b) eigen_arr_op01 = function
  | Float32   -> Eigen.Tensor.S.spatial_conv_backward_kernel
  | Float64   -> Eigen.Tensor.D.spatial_conv_backward_kernel
  | _         -> failwith "_eigen_spatial_conv_backward_kernel: unsupported operation"

let _eigen_cuboid_conv : type a b . (a, b) kind -> (a, b) eigen_arr_op02 = function
  | Float32   -> Eigen.Tensor.S.cuboid_conv
  | Float64   -> Eigen.Tensor.D.cuboid_conv
  | _         -> failwith "_eigen_cuboid_conv: unsupported operation"

let _eigen_cuboid_conv_backward_input : type a b . (a, b) kind -> (a, b) eigen_arr_op03 = function
  | Float32   -> Eigen.Tensor.S.cuboid_conv_backward_input
  | Float64   -> Eigen.Tensor.D.cuboid_conv_backward_input
  | _         -> failwith "cuboid_conv_backward_input: unsupported operation"

let _eigen_cuboid_conv_backward_kernel : type a b . (a, b) kind -> (a, b) eigen_arr_op03 = function
  | Float32   -> Eigen.Tensor.S.cuboid_conv_backward_kernel
  | Float64   -> Eigen.Tensor.D.cuboid_conv_backward_kernel
  | _         -> failwith "_eigen_cuboid_conv_backward_kernel: unsupported operation"

let _eigen_spatial_max_pooling : type a b . (a, b) kind -> (a, b) eigen_arr_op04 = function
  | Float32   -> Eigen.Tensor.S.spatial_max_pooling
  | Float64   -> Eigen.Tensor.D.spatial_max_pooling
  | _         -> failwith "_eigen_spatial_max_pooling: unsupported operation"

let _eigen_spatial_avg_pooling : type a b . (a, b) kind -> (a, b) eigen_arr_op04 = function
  | Float32   -> Eigen.Tensor.S.spatial_avg_pooling
  | Float64   -> Eigen.Tensor.D.spatial_avg_pooling
  | _         -> failwith "_eigen_spatial_avg_pooling: unsupported operation"

let _eigen_cuboid_max_pooling : type a b . (a, b) kind -> (a, b) eigen_arr_op05 = function
  | Float32   -> Eigen.Tensor.S.cuboid_max_pooling
  | Float64   -> Eigen.Tensor.D.cuboid_max_pooling
  | _         -> failwith "_eigen_cuboid_max_pooling: unsupported operation"

let _eigen_cuboid_avg_pooling : type a b . (a, b) kind -> (a, b) eigen_arr_op05 = function
  | Float32   -> Eigen.Tensor.S.cuboid_avg_pooling
  | Float64   -> Eigen.Tensor.D.cuboid_avg_pooling
  | _         -> failwith "_eigen_cuboid_avg_pooling: unsupported operation"

let _eigen_spatial_max_pooling_argmax : type a b . (a, b) kind -> (a, b) eigen_arr_op06 = function
  | Float32   -> Eigen.Tensor.S.spatial_max_pooling_argmax
  | Float64   -> Eigen.Tensor.D.spatial_max_pooling_argmax
  | _         -> failwith "_eigen_spatial_max_pooling_argmax: unsupported operation"

let _eigen_spatial_max_pooling_backward : type a b . (a, b) kind -> (a, b) eigen_arr_op07 = function
  | Float32   -> Eigen.Tensor.S.spatial_max_pooling_backward
  | Float64   -> Eigen.Tensor.D.spatial_max_pooling_backward
  | _         -> failwith "_eigen_spatial_max_pooling_backward: unsupported operation"

let _eigen_spatial_avg_pooling_backward : type a b . (a, b) kind -> (a, b) eigen_arr_op08 = function
  | Float32   -> Eigen.Tensor.S.spatial_avg_pooling_backward
  | Float64   -> Eigen.Tensor.D.spatial_avg_pooling_backward
  | _         -> failwith "_eigen_spatial_avg_pooling_backward: unsupported operation"

let _eigen_rowwise_op : type a b . (a, b) kind -> (a, b) eigen_mat_op03 = function
  | Float32   -> Eigen.Dense.S.rowwise_op
  | Float64   -> Eigen.Dense.D.rowwise_op
  | Complex32 -> Eigen.Dense.C.rowwise_op
  | Complex64 -> Eigen.Dense.Z.rowwise_op
  | _         -> failwith "_eigen_rowwise_op: unsupported operation"

let _eigen_colwise_op : type a b . (a, b) kind -> (a, b) eigen_mat_op03 = function
  | Float32   -> Eigen.Dense.S.colwise_op
  | Float64   -> Eigen.Dense.D.colwise_op
  | Complex32 -> Eigen.Dense.C.colwise_op
  | Complex64 -> Eigen.Dense.Z.colwise_op
  | _         -> failwith "_eigen_colwise_op: unsupported operation"


(* interface to owl's c functions, types for interfacing to owl *)

type ('a, 'b) owl_vec = ('a, 'b, c_layout) Array1.t
type ('a, 'b) owl_mat = ('a, 'b, c_layout) Array2.t

type ('a, 'b) owl_vec_op00 = int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int
type ('a, 'b) owl_vec_op01 = int -> ('a, 'b) owl_vec -> int
type ('a, 'b) owl_vec_op02 = int -> ('a, 'b) owl_vec -> float
type ('a, 'b) owl_vec_op03 = int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit
type ('a, 'b) owl_vec_op04 = int -> ('a, 'b) owl_vec -> 'a
type ('a, 'b) owl_vec_op05 = int -> 'a -> ('a, 'b) owl_vec -> 'a
type ('a, 'b) owl_vec_op06 = int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a
type ('a, 'b) owl_vec_op07 = int -> 'a -> 'a -> ('a, 'b) owl_vec -> unit
type ('a, 'b) owl_vec_op08 = int -> float -> 'a -> 'a -> ('a, 'b) owl_vec -> unit
type ('a, 'b) owl_vec_op09 = int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit
type ('a, 'b) owl_vec_op10 = int -> ('a, 'b) owl_vec -> 'a -> int
type ('a, 'b) owl_vec_op11 = int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit
type ('a, 'b) owl_vec_op12 = int -> ('a, 'b) owl_vec -> float -> int -> unit
type ('a, 'b) owl_vec_op13 = int -> ('a, 'b) owl_vec -> 'a -> 'a -> unit
type ('a, 'b) owl_vec_op14 = int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> unit
type ('a, 'b) owl_vec_op15 = int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> float -> int
type ('a, 'b) owl_vec_op16 = int -> ('a, 'b) owl_vec -> 'a -> float -> int
type ('a, 'b, 'c, 'd) owl_vec_op17 = int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('c, 'd) owl_vec -> unit
type ('a, 'b) owl_vec_op99 = int -> ?ofsx:int -> ?incx:int -> ?ofsy:int -> ?incy:int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit
type ('a, 'b) owl_mat_op00 = ('a, 'b) owl_mat -> unit


(* call functions in owl native c *)

let _owl_elt_to_str : type a b. (a, b) kind -> (a -> bytes) = function
  | Int8_signed    -> fun v -> Printf.sprintf "%i" v
  | Int8_unsigned  -> fun v -> Printf.sprintf "%i" v
  | Int16_signed   -> fun v -> Printf.sprintf "%i" v
  | Int16_unsigned -> fun v -> Printf.sprintf "%i" v
  | Int32          -> fun v -> Printf.sprintf "%ld" v
  | Int64          -> fun v -> Printf.sprintf "%Ld" v
  | Float32        -> fun v -> Printf.sprintf "%G" v
  | Float64        -> fun v -> Printf.sprintf "%G" v
  | Complex32      -> fun v -> Printf.sprintf "(%G, %Gi)" Complex.(v.re) Complex.(v.im)
  | Complex64      -> fun v -> Printf.sprintf "(%G, %Gi)" Complex.(v.re) Complex.(v.im)
  | _         -> failwith "_owl_print_elt: unsupported operation"

let _owl_print_mat : type a b. (a, b) kind -> (a, b) owl_mat_op00 = function
  | Float32   -> Format.printf "%a\n" Owl_pretty.pp_fmat
  | Float64   -> Format.printf "%a\n" Owl_pretty.pp_fmat
  | Complex32 -> Format.printf "%a\n" Owl_pretty.pp_cmat
  | Complex64 -> Format.printf "%a\n" Owl_pretty.pp_cmat
  | _         -> failwith "_owl_print_mat: unsupported operation"

let _owl_print_mat_toplevel : type a b. (a, b) kind -> (a, b) owl_mat_op00 = function
  | Int32     -> Format.printf "%a\n" Owl_pretty.Toplevel.pp_imat
  | Float32   -> Format.printf "%a\n" Owl_pretty.Toplevel.pp_fmat
  | Float64   -> Format.printf "%a\n" Owl_pretty.Toplevel.pp_fmat
  | Complex32 -> Format.printf "%a\n" Owl_pretty.Toplevel.pp_cmat
  | Complex64 -> Format.printf "%a\n" Owl_pretty.Toplevel.pp_cmat
  | _         -> fun _ -> () (* Format.printf "I don't know how to pprint it :(\n" *)

let _owl_uniform_fun : type a b. (a, b) kind -> (float -> a) = function
  | Float32   -> fun s -> Owl_stats.Rnd.uniform () *. s
  | Float64   -> fun s -> Owl_stats.Rnd.uniform () *. s
  | Complex32 -> fun s -> Complex.({re = Owl_stats.Rnd.uniform () *. s; im = Owl_stats.Rnd.uniform () *. s})
  | Complex64 -> fun s -> Complex.({re = Owl_stats.Rnd.uniform () *. s; im = Owl_stats.Rnd.uniform () *. s})
  | _         -> failwith "_owl_uniform: unsupported operation"

let _owl_gaussian_fun : type a b. (a, b) kind -> (float -> a) = function
  | Float32   -> fun s -> Owl_stats.Rnd.gaussian ~sigma:s ()
  | Float64   -> fun s -> Owl_stats.Rnd.gaussian ~sigma:s ()
  | Complex32 -> fun s -> Complex.({re = Owl_stats.Rnd.gaussian ~sigma:s (); im = Owl_stats.Rnd.gaussian ~sigma:s ()})
  | Complex64 -> fun s -> Complex.({re = Owl_stats.Rnd.gaussian ~sigma:s (); im = Owl_stats.Rnd.gaussian ~sigma:s ()})
  | _         -> failwith "_owl_gaussian: unsupported operation"

external owl_real_float_less : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_float_less"
external owl_real_double_less : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_double_less"
external owl_complex_float_less : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_float_less"
external owl_complex_double_less : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_double_less"

let _owl_less : type a b. (a, b) kind -> (a, b) owl_vec_op00 = function
  | Float32   -> owl_real_float_less
  | Float64   -> owl_real_double_less
  | Complex32 -> owl_complex_float_less
  | Complex64 -> owl_complex_double_less
  | _         -> failwith "_owl_less: unsupported operation"

external owl_real_float_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_float_greater"
external owl_real_double_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_double_greater"
external owl_complex_float_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_float_greater"
external owl_complex_double_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_double_greater"

let _owl_greater : type a b. (a, b) kind -> (a, b) owl_vec_op00 = function
  | Float32   -> owl_real_float_greater
  | Float64   -> owl_real_double_greater
  | Complex32 -> owl_complex_float_greater
  | Complex64 -> owl_complex_double_greater
  | _         -> failwith "_owl_greater: unsupported operation"

external owl_real_float_less_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_float_less_equal"
external owl_real_double_less_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_double_less_equal"
external owl_complex_float_less_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_float_less_equal"
external owl_complex_double_less_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_double_less_equal"

let _owl_less_equal : type a b. (a, b) kind -> (a, b) owl_vec_op00 = function
  | Float32   -> owl_real_float_less_equal
  | Float64   -> owl_real_double_less_equal
  | Complex32 -> owl_complex_float_less_equal
  | Complex64 -> owl_complex_double_less_equal
  | _         -> failwith "_owl_less_equal: unsupported operation"

external owl_real_float_greater_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_float_greater_equal"
external owl_real_double_greater_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "real_double_greater_equal"
external owl_complex_float_greater_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_float_greater_equal"
external owl_complex_double_greater_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> int = "complex_double_greater_equal"

let _owl_greater_equal : type a b. (a, b) kind -> (a, b) owl_vec_op00 = function
  | Float32   -> owl_real_float_greater_equal
  | Float64   -> owl_real_double_greater_equal
  | Complex32 -> owl_complex_float_greater_equal
  | Complex64 -> owl_complex_double_greater_equal
  | _         -> failwith "_owl_greater_equal: unsupported operation"

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

external owl_real_float_is_normal : int -> ('a, 'b) owl_vec -> int = "real_float_is_normal"
external owl_real_double_is_normal : int -> ('a, 'b) owl_vec -> int = "real_double_is_normal"
external owl_complex_float_is_normal : int -> ('a, 'b) owl_vec -> int = "complex_float_is_normal"
external owl_complex_double_is_normal : int -> ('a, 'b) owl_vec -> int = "complex_double_is_normal"

let _owl_is_normal : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_is_normal
  | Float64   -> owl_real_double_is_normal
  | Complex32 -> owl_complex_float_is_normal
  | Complex64 -> owl_complex_double_is_normal
  | _         -> failwith "_owl_is_normal: unsupported operation"

external owl_real_float_not_nan : int -> ('a, 'b) owl_vec -> int = "real_float_not_nan"
external owl_real_double_not_nan : int -> ('a, 'b) owl_vec -> int = "real_double_not_nan"
external owl_complex_float_not_nan : int -> ('a, 'b) owl_vec -> int = "complex_float_not_nan"
external owl_complex_double_not_nan : int -> ('a, 'b) owl_vec -> int = "complex_double_not_nan"

let _owl_not_nan : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_not_nan
  | Float64   -> owl_real_double_not_nan
  | Complex32 -> owl_complex_float_not_nan
  | Complex64 -> owl_complex_double_not_nan
  | _         -> failwith "_owl_not_nan: unsupported operation"

external owl_real_float_not_inf : int -> ('a, 'b) owl_vec -> int = "real_float_not_inf"
external owl_real_double_not_inf : int -> ('a, 'b) owl_vec -> int = "real_double_not_inf"
external owl_complex_float_not_inf : int -> ('a, 'b) owl_vec -> int = "complex_float_not_inf"
external owl_complex_double_not_inf : int -> ('a, 'b) owl_vec -> int = "complex_double_not_inf"

let _owl_not_inf : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_not_inf
  | Float64   -> owl_real_double_not_inf
  | Complex32 -> owl_complex_float_not_inf
  | Complex64 -> owl_complex_double_not_inf
  | _         -> failwith "_owl_not_inf: unsupported operation"

external owl_real_float_elt_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_elt_equal"
external owl_real_double_elt_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_elt_equal"
external owl_complex_float_elt_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_elt_equal"
external owl_complex_double_elt_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_elt_equal"

let _owl_elt_equal : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_elt_equal l x y z
  | Float64   -> owl_real_double_elt_equal l x y z
  | Complex32 -> owl_complex_float_elt_equal l x y z
  | Complex64 -> owl_complex_double_elt_equal l x y z
  | _         -> failwith "_owl_elt_equal: unsupported operation"

external owl_real_float_elt_not_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_elt_not_equal"
external owl_real_double_elt_not_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_elt_not_equal"
external owl_complex_float_elt_not_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_elt_not_equal"
external owl_complex_double_elt_not_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_elt_not_equal"

let _owl_elt_not_equal : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_elt_not_equal l x y z
  | Float64   -> owl_real_double_elt_not_equal l x y z
  | Complex32 -> owl_complex_float_elt_not_equal l x y z
  | Complex64 -> owl_complex_double_elt_not_equal l x y z
  | _         -> failwith "_owl_elt_not_equal: unsupported operation"

external owl_real_float_elt_less : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_elt_less"
external owl_real_double_elt_less : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_elt_less"
external owl_complex_float_elt_less : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_elt_less"
external owl_complex_double_elt_less : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_elt_less"

let _owl_elt_less : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_elt_less l x y z
  | Float64   -> owl_real_double_elt_less l x y z
  | Complex32 -> owl_complex_float_elt_less l x y z
  | Complex64 -> owl_complex_double_elt_less l x y z
  | _         -> failwith "_owl_elt_less: unsupported operation"

external owl_real_float_elt_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_elt_greater"
external owl_real_double_elt_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_elt_greater"
external owl_complex_float_elt_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_elt_greater"
external owl_complex_double_elt_greater : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_elt_greater"

let _owl_elt_greater : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_elt_greater l x y z
  | Float64   -> owl_real_double_elt_greater l x y z
  | Complex32 -> owl_complex_float_elt_greater l x y z
  | Complex64 -> owl_complex_double_elt_greater l x y z
  | _         -> failwith "_owl_elt_greater: unsupported operation"

external owl_real_float_elt_less_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_elt_less_equal"
external owl_real_double_elt_less_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_elt_less_equal"
external owl_complex_float_elt_less_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_elt_less_equal"
external owl_complex_double_elt_less_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_elt_less_equal"

let _owl_elt_less_equal : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_elt_less_equal l x y z
  | Float64   -> owl_real_double_elt_less_equal l x y z
  | Complex32 -> owl_complex_float_elt_less_equal l x y z
  | Complex64 -> owl_complex_double_elt_less_equal l x y z
  | _         -> failwith "_owl_elt_less_equal: unsupported operation"

external owl_real_float_elt_greater_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_elt_greater_equal"
external owl_real_double_elt_greater_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_elt_greater_equal"
external owl_complex_float_elt_greater_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_elt_greater_equal"
external owl_complex_double_elt_greater_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_elt_greater_equal"

let _owl_elt_greater_equal : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_elt_greater_equal l x y z
  | Float64   -> owl_real_double_elt_greater_equal l x y z
  | Complex32 -> owl_complex_float_elt_greater_equal l x y z
  | Complex64 -> owl_complex_double_elt_greater_equal l x y z
  | _         -> failwith "_owl_elt_greater_equal: unsupported operation"

external owl_real_float_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_float_equal_scalar"
external owl_real_double_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_double_equal_scalar"
external owl_complex_float_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_float_equal_scalar"
external owl_complex_double_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_double_equal_scalar"

let _owl_equal_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op10 = function
  | Float32   -> owl_real_float_equal_scalar
  | Float64   -> owl_real_double_equal_scalar
  | Complex32 -> owl_complex_float_equal_scalar
  | Complex64 -> owl_complex_double_equal_scalar
  | _         -> failwith "_owl_equal_scalar: unsupported operation"

external owl_real_float_not_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_float_not_equal_scalar"
external owl_real_double_not_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_double_not_equal_scalar"
external owl_complex_float_not_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_float_not_equal_scalar"
external owl_complex_double_not_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_double_not_equal_scalar"

let _owl_not_equal_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op10 = function
  | Float32   -> owl_real_float_not_equal_scalar
  | Float64   -> owl_real_double_not_equal_scalar
  | Complex32 -> owl_complex_float_not_equal_scalar
  | Complex64 -> owl_complex_double_not_equal_scalar
  | _         -> failwith "_owl_not_equal_scalar: unsupported operation"

external owl_real_float_less_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_float_less_scalar"
external owl_real_double_less_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_double_less_scalar"
external owl_complex_float_less_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_float_less_scalar"
external owl_complex_double_less_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_double_less_scalar"

let _owl_less_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op10 = function
  | Float32   -> owl_real_float_less_scalar
  | Float64   -> owl_real_double_less_scalar
  | Complex32 -> owl_complex_float_less_scalar
  | Complex64 -> owl_complex_double_less_scalar
  | _         -> failwith "_owl_less_scalar: unsupported operation"

external owl_real_float_greater_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_float_greater_scalar"
external owl_real_double_greater_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_double_greater_scalar"
external owl_complex_float_greater_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_float_greater_scalar"
external owl_complex_double_greater_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_double_greater_scalar"

let _owl_greater_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op10 = function
  | Float32   -> owl_real_float_greater_scalar
  | Float64   -> owl_real_double_greater_scalar
  | Complex32 -> owl_complex_float_greater_scalar
  | Complex64 -> owl_complex_double_greater_scalar
  | _         -> failwith "_owl_greater_scalar: unsupported operation"

external owl_real_float_less_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_float_less_equal_scalar"
external owl_real_double_less_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_double_less_equal_scalar"
external owl_complex_float_less_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_float_less_equal_scalar"
external owl_complex_double_less_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_double_less_equal_scalar"

let _owl_less_equal_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op10 = function
  | Float32   -> owl_real_float_less_equal_scalar
  | Float64   -> owl_real_double_less_equal_scalar
  | Complex32 -> owl_complex_float_less_equal_scalar
  | Complex64 -> owl_complex_double_less_equal_scalar
  | _         -> failwith "_owl_less_equal_scalar: unsupported operation"

external owl_real_float_greater_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_float_greater_equal_scalar"
external owl_real_double_greater_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "real_double_greater_equal_scalar"
external owl_complex_float_greater_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_float_greater_equal_scalar"
external owl_complex_double_greater_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> int = "complex_double_greater_equal_scalar"

let _owl_greater_equal_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op10 = function
  | Float32   -> owl_real_float_greater_equal_scalar
  | Float64   -> owl_real_double_greater_equal_scalar
  | Complex32 -> owl_complex_float_greater_equal_scalar
  | Complex64 -> owl_complex_double_greater_equal_scalar
  | _         -> failwith "_owl_greater_equal_scalar: unsupported operation"

external owl_real_float_elt_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_elt_equal_scalar"
external owl_real_double_elt_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_elt_equal_scalar"
external owl_complex_float_elt_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_float_elt_equal_scalar"
external owl_complex_double_elt_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_double_elt_equal_scalar"

let _owl_elt_equal_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_elt_equal_scalar
  | Float64   -> owl_real_double_elt_equal_scalar
  | Complex32 -> owl_complex_float_elt_equal_scalar
  | Complex64 -> owl_complex_double_elt_equal_scalar
  | _         -> failwith "_owl_elt_equal_scalar: unsupported operation"

external owl_real_float_elt_not_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_elt_not_equal_scalar"
external owl_real_double_elt_not_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_elt_not_equal_scalar"
external owl_complex_float_elt_not_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_float_elt_not_equal_scalar"
external owl_complex_double_elt_not_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_double_elt_not_equal_scalar"

let _owl_elt_not_equal_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_elt_not_equal_scalar
  | Float64   -> owl_real_double_elt_not_equal_scalar
  | Complex32 -> owl_complex_float_elt_not_equal_scalar
  | Complex64 -> owl_complex_double_elt_not_equal_scalar
  | _         -> failwith "_owl_elt_not_equal_scalar: unsupported operation"

external owl_real_float_elt_less_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_elt_less_scalar"
external owl_real_double_elt_less_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_elt_less_scalar"
external owl_complex_float_elt_less_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_float_elt_less_scalar"
external owl_complex_double_elt_less_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_double_elt_less_scalar"

let _owl_elt_less_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_elt_less_scalar
  | Float64   -> owl_real_double_elt_less_scalar
  | Complex32 -> owl_complex_float_elt_less_scalar
  | Complex64 -> owl_complex_double_elt_less_scalar
  | _         -> failwith "_owl_elt_less_scalar: unsupported operation"

external owl_real_float_elt_greater_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_elt_greater_scalar"
external owl_real_double_elt_greater_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_elt_greater_scalar"
external owl_complex_float_elt_greater_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_float_elt_greater_scalar"
external owl_complex_double_elt_greater_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_double_elt_greater_scalar"

let _owl_elt_greater_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_elt_greater_scalar
  | Float64   -> owl_real_double_elt_greater_scalar
  | Complex32 -> owl_complex_float_elt_greater_scalar
  | Complex64 -> owl_complex_double_elt_greater_scalar
  | _         -> failwith "_owl_elt_greater_scalar: unsupported operation"

external owl_real_float_elt_less_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_elt_less_equal_scalar"
external owl_real_double_elt_less_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_elt_less_equal_scalar"
external owl_complex_float_elt_less_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_float_elt_less_equal_scalar"
external owl_complex_double_elt_less_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_double_elt_less_equal_scalar"

let _owl_elt_less_equal_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_elt_less_equal_scalar
  | Float64   -> owl_real_double_elt_less_equal_scalar
  | Complex32 -> owl_complex_float_elt_less_equal_scalar
  | Complex64 -> owl_complex_double_elt_less_equal_scalar
  | _         -> failwith "_owl_elt_less_equal_scalar: unsupported operation"

external owl_real_float_elt_greater_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_elt_greater_equal_scalar"
external owl_real_double_elt_greater_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_elt_greater_equal_scalar"
external owl_complex_float_elt_greater_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_float_elt_greater_equal_scalar"
external owl_complex_double_elt_greater_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_double_elt_greater_equal_scalar"

let _owl_elt_greater_equal_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_elt_greater_equal_scalar
  | Float64   -> owl_real_double_elt_greater_equal_scalar
  | Complex32 -> owl_complex_float_elt_greater_equal_scalar
  | Complex64 -> owl_complex_double_elt_greater_equal_scalar
  | _         -> failwith "_owl_elt_greater_equal_scalar: unsupported operation"

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

external owl_real_float_min_i : int -> ('a, 'b) owl_vec -> int = "real_float_min_i"
external owl_real_double_min_i : int -> ('a, 'b) owl_vec -> int = "real_double_min_i"
external owl_complex_float_min_i : int -> ('a, 'b) owl_vec -> int = "complex_float_min_i"
external owl_complex_double_min_i : int -> ('a, 'b) owl_vec -> int = "complex_double_min_i"

let _owl_min_i : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_min_i
  | Float64   -> owl_real_double_min_i
  | Complex32 -> owl_complex_float_min_i
  | Complex64 -> owl_complex_double_min_i
  | _         -> failwith "_owl_min_i: unsupported operation"

external owl_real_float_max_i : int -> ('a, 'b) owl_vec -> int = "real_float_max_i"
external owl_real_double_max_i : int -> ('a, 'b) owl_vec -> int = "real_double_max_i"
external owl_complex_float_max_i : int -> ('a, 'b) owl_vec -> int = "complex_float_max_i"
external owl_complex_double_max_i : int -> ('a, 'b) owl_vec -> int = "complex_double_max_i"

let _owl_max_i : type a b. (a, b) kind -> (a, b) owl_vec_op01 = function
  | Float32   -> owl_real_float_max_i
  | Float64   -> owl_real_double_max_i
  | Complex32 -> owl_complex_float_max_i
  | Complex64 -> owl_complex_double_max_i
  | _         -> failwith "_owl_max_i: unsupported operation"

external owl_real_float_neg : int -> ('a, 'b) owl_vec -> int -> int -> ('a, 'b) owl_vec -> int -> int -> unit = "real_float_neg" "real_float_neg_impl"
external owl_real_double_neg : int -> ('a, 'b) owl_vec -> int -> int -> ('a, 'b) owl_vec -> int -> int -> unit = "real_double_neg" "real_double_neg_impl"
external owl_complex_float_neg : int -> ('a, 'b) owl_vec -> int -> int -> ('a, 'b) owl_vec -> int -> int -> unit = "complex_float_neg" "complex_float_neg_impl"
external owl_complex_double_neg : int -> ('a, 'b) owl_vec -> int -> int -> ('a, 'b) owl_vec -> int -> int -> unit = "complex_double_neg" "complex_double_neg_impl"

let _owl_neg : type a b. (a, b) kind -> (a, b) owl_vec_op99 =
  fun k n ?(ofsx=0) ?(incx=1) ?(ofsy=0) ?(incy=1) x y ->
  match k with
  | Float32   -> owl_real_float_neg n x ofsx incx y ofsy incy
  | Float64   -> owl_real_double_neg n x ofsx incx y ofsy incy
  | Complex32 -> owl_complex_float_neg n x ofsx incx y ofsy incy
  | Complex64 -> owl_complex_double_neg n x ofsx incx y ofsy incy
  | _         -> failwith "_owl_neg: unsupported operation"

external owl_real_float_reci : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_reci"
external owl_real_double_reci : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_reci"

let _owl_reci : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_reci l x y
  | Float64   -> owl_real_double_reci l x y
  | _         -> failwith "_owl_reci: unsupported operation"

external owl_real_float_abs : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_abs"
external owl_real_double_abs : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_abs"
external owl_complex_float_abs : int -> (Complex.t, complex32_elt) owl_vec -> (float, float32_elt) owl_vec -> unit = "complex_float_abs"
external owl_complex_double_abs : int -> (Complex.t, complex64_elt) owl_vec -> (float, float64_elt) owl_vec -> unit = "complex_double_abs"

let _owl_abs : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_abs l x y
  | Float64   -> owl_real_double_abs l x y
  | _         -> failwith "_owl_abs: unsupported operation"

external owl_real_float_abs2 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_abs2"
external owl_real_double_abs2 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_abs2"
external owl_complex_float_abs2 : int -> (Complex.t, complex32_elt) owl_vec -> (float, float32_elt) owl_vec -> unit = "complex_float_abs2"
external owl_complex_double_abs2 : int -> (Complex.t, complex64_elt) owl_vec -> (float, float64_elt) owl_vec -> unit = "complex_double_abs2"

let _owl_abs2 : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_abs2 l x y
  | Float64   -> owl_real_double_abs2 l x y
  | _         -> failwith "_owl_abs2: unsupported operation"

external owl_real_float_signum : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_signum"
external owl_real_double_signum : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_signum"

let _owl_signum : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_signum l x y
  | Float64   -> owl_real_double_signum l x y
  | _         -> failwith "_owl_signum: unsupported operation"

external owl_real_float_sqr : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_sqr"
external owl_real_double_sqr : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_sqr"
external owl_complex_float_sqr : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_sqr"
external owl_complex_double_sqr : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_sqr"

let _owl_sqr : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_sqr l x y
  | Float64   -> owl_real_double_sqr l x y
  | Complex32 -> owl_complex_float_sqr l x y
  | Complex64 -> owl_complex_double_sqr l x y
  | _         -> failwith "_owl_sqr: unsupported operation"

external owl_real_float_sqrt : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_sqrt"
external owl_real_double_sqrt : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_sqrt"
external owl_complex_float_sqrt : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_sqrt"
external owl_complex_double_sqrt : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_sqrt"

let _owl_sqrt : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_sqrt l x y
  | Float64   -> owl_real_double_sqrt l x y
  | Complex32 -> owl_complex_float_sqrt l x y
  | Complex64 -> owl_complex_double_sqrt l x y
  | _         -> failwith "_owl_sqrt: unsupported operation"

external owl_real_float_cbrt : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_cbrt"
external owl_real_double_cbrt : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_cbrt"
external owl_complex_float_cbrt : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_cbrt"
external owl_complex_double_cbrt : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_cbrt"

let _owl_cbrt : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_cbrt l x y
  | Float64   -> owl_real_double_cbrt l x y
  | Complex32 -> owl_complex_float_cbrt l x y
  | Complex64 -> owl_complex_double_cbrt l x y
  | _         -> failwith "_owl_cbrt: unsupported operation"

external owl_real_float_exp : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_exp"
external owl_real_double_exp : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_exp"
external owl_complex_float_exp : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_exp"
external owl_complex_double_exp : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_exp"

let _owl_exp : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_exp l x y
  | Float64   -> owl_real_double_exp l x y
  | Complex32 -> owl_complex_float_exp l x y
  | Complex64 -> owl_complex_double_exp l x y
  | _         -> failwith "_owl_exp: unsupported operation"

external owl_real_float_exp2 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_exp2"
external owl_real_double_exp2 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_exp2"
external owl_complex_float_exp2 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_exp2"
external owl_complex_double_exp2 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_exp2"

let _owl_exp2 : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_exp2 l x y
  | Float64   -> owl_real_double_exp2 l x y
  | Complex32 -> owl_complex_float_exp2 l x y
  | Complex64 -> owl_complex_double_exp2 l x y
  | _         -> failwith "_owl_exp2: unsupported operation"

external owl_real_float_exp10 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_exp10"
external owl_real_double_exp10 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_exp10"
external owl_complex_float_exp10 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_exp10"
external owl_complex_double_exp10 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_exp10"

let _owl_exp10 : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_exp10 l x y
  | Float64   -> owl_real_double_exp10 l x y
  | Complex32 -> owl_complex_float_exp10 l x y
  | Complex64 -> owl_complex_double_exp10 l x y
  | _         -> failwith "_owl_exp10: unsupported operation"

external owl_real_float_expm1 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_expm1"
external owl_real_double_expm1 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_expm1"
external owl_complex_float_expm1 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_expm1"
external owl_complex_double_expm1 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_expm1"

let _owl_expm1 : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_expm1 l x y
  | Float64   -> owl_real_double_expm1 l x y
  | Complex32 -> owl_complex_float_expm1 l x y
  | Complex64 -> owl_complex_double_expm1 l x y
  | _         -> failwith "_owl_expm1: unsupported operation"

external owl_real_float_log : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_log"
external owl_real_double_log : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_log"
external owl_complex_float_log : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_log"
external owl_complex_double_log : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_log"

let _owl_log : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_log l x y
  | Float64   -> owl_real_double_log l x y
  | Complex32 -> owl_complex_float_log l x y
  | Complex64 -> owl_complex_double_log l x y
  | _         -> failwith "_owl_log: unsupported operation"

external owl_real_float_log10 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_log10"
external owl_real_double_log10 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_log10"
external owl_complex_float_log10 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_log10"
external owl_complex_double_log10 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_log10"

let _owl_log10 : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_log10 l x y
  | Float64   -> owl_real_double_log10 l x y
  | Complex32 -> owl_complex_float_log10 l x y
  | Complex64 -> owl_complex_double_log10 l x y
  | _         -> failwith "_owl_log10: unsupported operation"

external owl_real_float_log2 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_log2"
external owl_real_double_log2 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_log2"
external owl_complex_float_log2 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_log2"
external owl_complex_double_log2 : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_log2"

let _owl_log2 : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_log2 l x y
  | Float64   -> owl_real_double_log2 l x y
  | Complex32 -> owl_complex_float_log2 l x y
  | Complex64 -> owl_complex_double_log2 l x y
  | _         -> failwith "_owl_log2: unsupported operation"

external owl_real_float_log1p : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_log1p"
external owl_real_double_log1p : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_log1p"
external owl_complex_float_log1p : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_log1p"
external owl_complex_double_log1p : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_log1p"

let _owl_log1p : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_log1p l x y
  | Float64   -> owl_real_double_log1p l x y
  | Complex32 -> owl_complex_float_log1p l x y
  | Complex64 -> owl_complex_double_log1p l x y
  | _         -> failwith "_owl_log1p: unsupported operation"

external owl_real_float_sin : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_sin"
external owl_real_double_sin : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_sin"
external owl_complex_float_sin : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_sin"
external owl_complex_double_sin : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_sin"

let _owl_sin : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_sin l x y
  | Float64   -> owl_real_double_sin l x y
  | Complex32 -> owl_complex_float_sin l x y
  | Complex64 -> owl_complex_double_sin l x y
  | _         -> failwith "_owl_sin: unsupported operation"

external owl_real_float_cos : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_cos"
external owl_real_double_cos : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_cos"
external owl_complex_float_cos : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_cos"
external owl_complex_double_cos : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_cos"

let _owl_cos : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_cos l x y
  | Float64   -> owl_real_double_cos l x y
  | Complex32 -> owl_complex_float_cos l x y
  | Complex64 -> owl_complex_double_cos l x y
  | _         -> failwith "_owl_cos: unsupported operation"

external owl_real_float_tan : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_tan"
external owl_real_double_tan : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_tan"
external owl_complex_float_tan : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_tan"
external owl_complex_double_tan : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_tan"

let _owl_tan : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_tan l x y
  | Float64   -> owl_real_double_tan l x y
  | Complex32 -> owl_complex_float_tan l x y
  | Complex64 -> owl_complex_double_tan l x y
  | _         -> failwith "_owl_tan: unsupported operation"

external owl_real_float_asin : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_asin"
external owl_real_double_asin : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_asin"
external owl_complex_float_asin : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_asin"
external owl_complex_double_asin : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_asin"

let _owl_asin : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_asin l x y
  | Float64   -> owl_real_double_asin l x y
  | Complex32 -> owl_complex_float_asin l x y
  | Complex64 -> owl_complex_double_asin l x y
  | _         -> failwith "_owl_asin: unsupported operation"

external owl_real_float_acos : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_acos"
external owl_real_double_acos : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_acos"
external owl_complex_float_acos : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_acos"
external owl_complex_double_acos : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_acos"

let _owl_acos : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_acos l x y
  | Float64   -> owl_real_double_acos l x y
  | Complex32 -> owl_complex_float_acos l x y
  | Complex64 -> owl_complex_double_acos l x y
  | _         -> failwith "_owl_acos: unsupported operation"

external owl_real_float_atan : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_atan"
external owl_real_double_atan : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_atan"
external owl_complex_float_atan : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_atan"
external owl_complex_double_atan : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_atan"

let _owl_atan : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_atan l x y
  | Float64   -> owl_real_double_atan l x y
  | Complex32 -> owl_complex_float_atan l x y
  | Complex64 -> owl_complex_double_atan l x y
  | _         -> failwith "_owl_atan: unsupported operation"

external owl_real_float_sinh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_sinh"
external owl_real_double_sinh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_sinh"
external owl_complex_float_sinh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_sinh"
external owl_complex_double_sinh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_sinh"

let _owl_sinh : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_sinh l x y
  | Float64   -> owl_real_double_sinh l x y
  | Complex32 -> owl_complex_float_sinh l x y
  | Complex64 -> owl_complex_double_sinh l x y
  | _         -> failwith "_owl_sinh: unsupported operation"

external owl_real_float_cosh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_cosh"
external owl_real_double_cosh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_cosh"
external owl_complex_float_cosh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_cosh"
external owl_complex_double_cosh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_cosh"

let _owl_cosh : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_cosh l x y
  | Float64   -> owl_real_double_cosh l x y
  | Complex32 -> owl_complex_float_cosh l x y
  | Complex64 -> owl_complex_double_cosh l x y
  | _         -> failwith "_owl_cosh: unsupported operation"

external owl_real_float_tanh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_tanh"
external owl_real_double_tanh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_tanh"
external owl_complex_float_tanh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_tanh"
external owl_complex_double_tanh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_tanh"

let _owl_tanh : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_tanh l x y
  | Float64   -> owl_real_double_tanh l x y
  | Complex32 -> owl_complex_float_tanh l x y
  | Complex64 -> owl_complex_double_tanh l x y
  | _         -> failwith "_owl_tanh: unsupported operation"

external owl_real_float_asinh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_asinh"
external owl_real_double_asinh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_asinh"
external owl_complex_float_asinh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_asinh"
external owl_complex_double_asinh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_asinh"

let _owl_asinh : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_asinh l x y
  | Float64   -> owl_real_double_asinh l x y
  | Complex32 -> owl_complex_float_asinh l x y
  | Complex64 -> owl_complex_double_asinh l x y
  | _         -> failwith "_owl_asinh: unsupported operation"

external owl_real_float_acosh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_acosh"
external owl_real_double_acosh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_acosh"
external owl_complex_float_acosh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_acosh"
external owl_complex_double_acosh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_acosh"

let _owl_acosh : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_acosh l x y
  | Float64   -> owl_real_double_acosh l x y
  | Complex32 -> owl_complex_float_acosh l x y
  | Complex64 -> owl_complex_double_acosh l x y
  | _         -> failwith "_owl_acosh: unsupported operation"

external owl_real_float_atanh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_atanh"
external owl_real_double_atanh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_atanh"
external owl_complex_float_atanh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_atanh"
external owl_complex_double_atanh : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_atanh"

let _owl_atanh : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_atanh l x y
  | Float64   -> owl_real_double_atanh l x y
  | Complex32 -> owl_complex_float_atanh l x y
  | Complex64 -> owl_complex_double_atanh l x y
  | _         -> failwith "_owl_atanh: unsupported operation"

external owl_real_float_floor : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_floor"
external owl_real_double_floor : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_floor"
external owl_complex_float_floor : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_floor"
external owl_complex_double_floor : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_floor"

let _owl_floor : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_floor l x y
  | Float64   -> owl_real_double_floor l x y
  | Complex32 -> owl_complex_float_floor l x y
  | Complex64 -> owl_complex_double_floor l x y
  | _         -> failwith "_owl_floor: unsupported operation"

external owl_real_float_ceil : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_ceil"
external owl_real_double_ceil : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_ceil"
external owl_complex_float_ceil : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_ceil"
external owl_complex_double_ceil : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_ceil"

let _owl_ceil : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_ceil l x y
  | Float64   -> owl_real_double_ceil l x y
  | Complex32 -> owl_complex_float_ceil l x y
  | Complex64 -> owl_complex_double_ceil l x y
  | _         -> failwith "_owl_ceil: unsupported operation"

external owl_real_float_round : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_round"
external owl_real_double_round : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_round"
external owl_complex_float_round : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_round"
external owl_complex_double_round : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_round"

let _owl_round : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_round l x y
  | Float64   -> owl_real_double_round l x y
  | Complex32 -> owl_complex_float_round l x y
  | Complex64 -> owl_complex_double_round l x y
  | _         -> failwith "_owl_round: unsupported operation"

external owl_real_float_trunc : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_trunc"
external owl_real_double_trunc : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_trunc"
external owl_complex_float_trunc : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_trunc"
external owl_complex_double_trunc : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_trunc"

let _owl_trunc : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_trunc l x y
  | Float64   -> owl_real_double_trunc l x y
  | Complex32 -> owl_complex_float_trunc l x y
  | Complex64 -> owl_complex_double_trunc l x y
  | _         -> failwith "_owl_trunc: unsupported operation"

external owl_real_float_erf : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_erf"
external owl_real_double_erf : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_erf"

let _owl_erf : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_erf l x y
  | Float64   -> owl_real_double_erf l x y
  | _         -> failwith "_owl_erf: unsupported operation"

external owl_real_float_erfc : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_erfc"
external owl_real_double_erfc : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_erfc"

let _owl_erfc : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_erfc l x y
  | Float64   -> owl_real_double_erfc l x y
  | _         -> failwith "_owl_erfc: unsupported operation"

external owl_real_float_logistic : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_logistic"
external owl_real_double_logistic : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_logistic"

let _owl_logistic : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_logistic l x y
  | Float64   -> owl_real_double_logistic l x y
  | _         -> failwith "_owl_logistic: unsupported operation"

external owl_real_float_sigmoid : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_sigmoid"
external owl_real_double_sigmoid : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_sigmoid"

let _owl_sigmoid : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_sigmoid l x y
  | Float64   -> owl_real_double_sigmoid l x y
  | _         -> failwith "_owl_sigmoid: unsupported operation"

external owl_real_float_elu : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_elu"
external owl_real_double_elu : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_elu"

let _owl_elu : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_elu
  | Float64   -> owl_real_double_elu
  | _         -> failwith "_owl_elu: unsupported operation"

external owl_real_float_relu : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_relu"
external owl_real_double_relu : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_relu"

let _owl_relu : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_relu l x y
  | Float64   -> owl_real_double_relu l x y
  | _         -> failwith "_owl_relu: unsupported operation"

external owl_real_float_leaky_relu : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_leaky_relu"
external owl_real_double_leaky_relu : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_leaky_relu"

let _owl_leaky_relu : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_leaky_relu
  | Float64   -> owl_real_double_leaky_relu
  | _         -> failwith "_owl_leaky_relu: unsupported operation"

external owl_real_float_softplus : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_softplus"
external owl_real_double_softplus : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_softplus"

let _owl_softplus : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_softplus l x y
  | Float64   -> owl_real_double_softplus l x y
  | _         -> failwith "_owl_softplus: unsupported operation"

external owl_real_float_softsign : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_softsign"
external owl_real_double_softsign : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_softsign"

let _owl_softsign : type a b. (a, b) kind -> (a, b) owl_vec_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_real_float_softsign l x y
  | Float64   -> owl_real_double_softsign l x y
  | _         -> failwith "_owl_softsign: unsupported operation"

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

external owl_real_float_sum : int -> (float, 'a) owl_vec -> float = "real_float_sum"
external owl_real_double_sum : int -> (float, 'a) owl_vec -> float = "real_double_sum"
external owl_complex_float_sum : int -> (Complex.t, 'a) owl_vec -> Complex.t = "complex_float_sum"
external owl_complex_double_sum : int -> (Complex.t, 'a) owl_vec -> Complex.t = "complex_double_sum"

let _owl_sum : type a b. (a, b) kind -> (a, b) owl_vec_op04 = function
  | Float32   -> owl_real_float_sum
  | Float64   -> owl_real_double_sum
  | Complex32 -> owl_complex_float_sum
  | Complex64 -> owl_complex_double_sum
  | _         -> failwith "_owl_sum: unsupported operation"

external owl_real_float_prod : int -> (float, 'a) owl_vec -> float = "real_float_prod"
external owl_real_double_prod : int -> (float, 'a) owl_vec -> float = "real_double_prod"
external owl_complex_float_prod : int -> (Complex.t, 'a) owl_vec -> Complex.t = "complex_float_prod"
external owl_complex_double_prod : int -> (Complex.t, 'a) owl_vec -> Complex.t = "complex_double_prod"

let _owl_prod : type a b. (a, b) kind -> (a, b) owl_vec_op04 = function
  | Float32   -> owl_real_float_prod
  | Float64   -> owl_real_double_prod
  | Complex32 -> owl_complex_float_prod
  | Complex64 -> owl_complex_double_prod
  | _         -> failwith "_owl_prod: unsupported operation"

external owl_real_float_ssqr : int -> float -> (float, 'a) owl_vec -> float = "real_float_ssqr"
external owl_real_double_ssqr : int -> float -> (float, 'a) owl_vec -> float = "real_double_ssqr"
external owl_complex_float_ssqr : int -> Complex.t -> (Complex.t, 'a) owl_vec -> Complex.t = "complex_float_ssqr"
external owl_complex_double_ssqr : int -> Complex.t -> (Complex.t, 'a) owl_vec -> Complex.t = "complex_double_ssqr"

let _owl_ssqr : type a b. (a, b) kind -> (a, b) owl_vec_op05 = function
  | Float32   -> owl_real_float_ssqr
  | Float64   -> owl_real_double_ssqr
  | Complex32 -> owl_complex_float_ssqr
  | Complex64 -> owl_complex_double_ssqr
  | _         -> failwith "_owl_ssqr: unsupported operation"

external owl_real_float_ssqr_diff : int -> (float, 'a) owl_vec -> (float, 'a) owl_vec -> float = "real_float_ssqr_diff"
external owl_real_double_ssqr_diff : int -> (float, 'a) owl_vec -> (float, 'a) owl_vec -> float = "real_double_ssqr_diff"
external owl_complex_float_ssqr_diff : int -> (Complex.t, 'a) owl_vec -> (Complex.t, 'a) owl_vec -> Complex.t = "complex_float_ssqr_diff"
external owl_complex_double_ssqr_diff : int -> (Complex.t, 'a) owl_vec -> (Complex.t, 'a) owl_vec -> Complex.t = "complex_double_ssqr_diff"

let _owl_ssqr_diff : type a b. (a, b) kind -> (a, b) owl_vec_op06 = function
  | Float32   -> owl_real_float_ssqr_diff
  | Float64   -> owl_real_double_ssqr_diff
  | Complex32 -> owl_complex_float_ssqr_diff
  | Complex64 -> owl_complex_double_ssqr_diff
  | _         -> failwith "_owl_ssqr_diff: unsupported operation"

external owl_real_float_log_sum_exp : int -> (float, 'a) owl_vec -> float = "real_float_log_sum_exp"
external owl_real_double_log_sum_exp : int -> (float, 'a) owl_vec -> float = "real_double_log_sum_exp"

let _owl_log_sum_exp : type a b. (a, b) kind -> (a, b) owl_vec_op02 = function
  | Float32   -> owl_real_float_log_sum_exp
  | Float64   -> owl_real_double_log_sum_exp
  | _         -> failwith "_owl_log_sum_exp: unsupported operation"

external owl_real_float_pow : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_pow"
external owl_real_double_pow : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_pow"
external owl_complex_float_pow : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_pow"
external owl_complex_double_pow : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_pow"

let _owl_pow : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_pow l x y z
  | Float64   -> owl_real_double_pow l x y z
  | Complex32 -> owl_complex_float_pow l x y z
  | Complex64 -> owl_complex_double_pow l x y z
  | _         -> failwith "_owl_pow: unsupported operation"

external owl_real_float_atan2 : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> (float, 'c) owl_vec -> unit = "real_float_atan2"
external owl_real_double_atan2 : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> (float, 'c) owl_vec -> unit = "real_double_atan2"

let _owl_atan2 : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_atan2 l x y z
  | Float64   -> owl_real_double_atan2 l x y z
  | _         -> failwith "_owl_atan2: unsupported operation"

external owl_real_float_hypot : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> (float, 'c) owl_vec -> unit = "real_float_hypot"
external owl_real_double_hypot : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> (float, 'c) owl_vec -> unit = "real_double_hypot"

let _owl_hypot : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_hypot l x y z
  | Float64   -> owl_real_double_hypot l x y z
  | _         -> failwith "_owl_hypot: unsupported operation"

external owl_real_float_min2 : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> (float, 'c) owl_vec -> unit = "real_float_min2"
external owl_real_double_min2 : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> (float, 'c) owl_vec -> unit = "real_double_min2"

let _owl_min2 : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_min2 l x y z
  | Float64   -> owl_real_double_min2 l x y z
  | _         -> failwith "_owl_min2: unsupported operation"

external owl_real_float_max2 : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> (float, 'c) owl_vec -> unit = "real_float_max2"
external owl_real_double_max2 : int -> ('a, 'b) owl_vec -> (float, 'c) owl_vec -> (float, 'c) owl_vec -> unit = "real_double_max2"

let _owl_max2 : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_max2 l x y z
  | Float64   -> owl_real_double_max2 l x y z
  | _         -> failwith "_owl_max2: unsupported operation"

external owl_real_float_fmod : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_fmod"
external owl_real_double_fmod : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_fmod"

let _owl_fmod : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_fmod l x y z
  | Float64   -> owl_real_double_fmod l x y z
  | _         -> failwith "_owl_fmod: unsupported operation"

external owl_real_float_fmod_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_fmod_scalar"
external owl_real_double_fmod_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_fmod_scalar"

let _owl_fmod_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_fmod_scalar
  | Float64   -> owl_real_double_fmod_scalar
  | _         -> failwith "_owl_fmod_scalar: unsupported operation"

external owl_real_float_scalar_fmod : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_scalar_fmod"
external owl_real_double_scalar_fmod : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_scalar_fmod"

let _owl_scalar_fmod : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_scalar_fmod
  | Float64   -> owl_real_double_scalar_fmod
  | _         -> failwith "_owl_scalar_fmod: unsupported operation"

external owl_real_float_linspace : int -> float -> float -> (float, 'a) owl_vec -> unit = "real_float_linspace"
external owl_real_double_linspace : int -> float -> float -> (float, 'a) owl_vec -> unit = "real_double_linspace"
external owl_complex_float_linspace : int -> Complex.t -> Complex.t -> (Complex.t, 'a) owl_vec -> unit = "complex_float_linspace"
external owl_complex_double_linspace : int -> Complex.t -> Complex.t -> (Complex.t, 'a) owl_vec -> unit = "complex_double_linspace"

let _owl_linspace : type a b. (a, b) kind -> (a, b) owl_vec_op07 = function
  | Float32   -> owl_real_float_linspace
  | Float64   -> owl_real_double_linspace
  | Complex32 -> owl_complex_float_linspace
  | Complex64 -> owl_complex_double_linspace
  | _         -> failwith "_owl_linspace: unsupported operation"

external owl_real_float_logspace : int -> float -> float -> float -> (float, 'a) owl_vec -> unit = "real_float_logspace"
external owl_real_double_logspace : int -> float -> float -> float -> (float, 'a) owl_vec -> unit = "real_double_logspace"
external owl_complex_float_logspace : int -> float -> Complex.t -> Complex.t -> (Complex.t, 'a) owl_vec -> unit = "complex_float_logspace"
external owl_complex_double_logspace : int -> float -> Complex.t -> Complex.t -> (Complex.t, 'a) owl_vec -> unit = "complex_double_logspace"

let _owl_logspace : type a b. (a, b) kind -> (a, b) owl_vec_op08 = function
  | Float32   -> owl_real_float_logspace
  | Float64   -> owl_real_double_logspace
  | Complex32 -> owl_complex_float_logspace
  | Complex64 -> owl_complex_double_logspace
  | _         -> failwith "_owl_logspace: unsupported operation"

external owl_complex_float_conj : int -> ('a, 'b) owl_vec -> int -> int -> ('a, 'b) owl_vec -> int -> int -> unit = "complex_float_conj" "complex_float_conj_impl"
external owl_complex_double_conj : int -> ('a, 'b) owl_vec -> int -> int -> ('a, 'b) owl_vec -> int -> int -> unit = "complex_double_conj" "complex_double_conj_impl"

let _owl_conj : type a b. (a, b) kind -> (a, b) owl_vec_op99 =
  fun k n ?(ofsx=0) ?(incx=1) ?(ofsy=0) ?(incy=1) x y ->
  match k with
  | Float32     -> ()
  | Float64     -> ()
  | Complex32   -> owl_complex_float_conj n x ofsx incx y ofsy incy
  | Complex64   -> owl_complex_double_conj n x ofsx incx y ofsy incy
  | _         -> failwith "_owl_conj: unsupported operation"

let _owl_copy : type a b. (a, b) kind -> (a, b) owl_vec_op99 =
  fun k n ?(ofsx=0) ?(incx=1) ?(ofsy=0) ?(incy=1) x y ->
  match k with
  | Float32   ->
    let x = Array1.sub x ofsx (Array1.dim x - ofsx) in
    let y = Array1.sub y ofsy (Array1.dim y - ofsy) in
    Owl_cblas.scopy n x incx y incy
  | Float64   ->
    let x = Array1.sub x ofsx (Array1.dim x - ofsx) in
    let y = Array1.sub y ofsy (Array1.dim y - ofsy) in
    Owl_cblas.dcopy n x incx y incy
  | Complex32 ->
    let x = Array1.sub x ofsx (Array1.dim x - ofsx) in
    let y = Array1.sub y ofsy (Array1.dim y - ofsy) in
    Owl_cblas.ccopy n x incx y incy
  | Complex64 ->
    let x = Array1.sub x ofsx (Array1.dim x - ofsx) in
    let y = Array1.sub y ofsy (Array1.dim y - ofsy) in
    Owl_cblas.zcopy n x incx y incy
  | _ -> failwith "_owl_copy: unsupported operation"

external _owl_re_c2s : int -> (Complex.t, complex32_elt) owl_vec -> (float, float32_elt) owl_vec -> unit = "re_c2s"
external _owl_re_z2d : int -> (Complex.t, complex64_elt) owl_vec -> (float, float64_elt) owl_vec -> unit = "re_z2d"
external _owl_im_c2s : int -> (Complex.t, complex32_elt) owl_vec -> (float, float32_elt) owl_vec -> unit = "im_c2s"
external _owl_im_z2d : int -> (Complex.t, complex64_elt) owl_vec -> (float, float64_elt) owl_vec -> unit = "im_z2d"

external _owl_cast_s2d : int -> (float, float32_elt) owl_vec -> (float, float64_elt) owl_vec -> unit = "cast_s2d"
external _owl_cast_d2s : int -> (float, float64_elt) owl_vec -> (float, float32_elt) owl_vec -> unit = "cast_d2s"
external _owl_cast_c2z : int -> (Complex.t, complex32_elt) owl_vec -> (Complex.t, complex64_elt) owl_vec -> unit = "cast_c2z"
external _owl_cast_z2c : int -> (Complex.t, complex64_elt) owl_vec -> (Complex.t, complex32_elt) owl_vec -> unit = "cast_z2c"
external _owl_cast_s2c : int -> (float, float32_elt) owl_vec -> (Complex.t, complex32_elt) owl_vec -> unit = "cast_s2c"
external _owl_cast_d2z : int -> (float, float64_elt) owl_vec -> (Complex.t, complex64_elt) owl_vec -> unit = "cast_d2z"
external _owl_cast_s2z : int -> (float, float32_elt) owl_vec -> (Complex.t, complex64_elt) owl_vec -> unit = "cast_s2z"
external _owl_cast_d2c : int -> (float, float64_elt) owl_vec -> (Complex.t, complex32_elt) owl_vec -> unit = "cast_d2c"

external owl_real_float_bernoulli : int -> ('a, 'b) owl_vec -> float -> int -> unit = "real_float_bernoulli"
external owl_real_double_bernoulli : int -> ('a, 'b) owl_vec -> float -> int -> unit = "real_double_bernoulli"
external owl_complex_float_bernoulli : int -> ('a, 'b) owl_vec -> float -> int -> unit = "complex_float_bernoulli"
external owl_complex_double_bernoulli : int -> ('a, 'b) owl_vec -> float -> int -> unit = "complex_double_bernoulli"

let _owl_bernoulli : type a b. (a, b) kind -> (a, b) owl_vec_op12 = function
  | Float32   -> owl_real_float_bernoulli
  | Float64   -> owl_real_double_bernoulli
  | Complex32 -> owl_complex_float_bernoulli
  | Complex64 -> owl_complex_double_bernoulli
  | _         -> failwith "_owl_bernoulli: unsupported operation"

external owl_real_float_sequential : int -> ('a, 'b) owl_vec -> 'a -> 'a -> unit = "real_float_sequential"
external owl_real_double_sequential : int -> ('a, 'b) owl_vec -> 'a -> 'a -> unit = "real_double_sequential"
external owl_complex_float_sequential : int -> ('a, 'b) owl_vec -> 'a -> 'a -> unit = "complex_float_sequential"
external owl_complex_double_sequential : int -> ('a, 'b) owl_vec -> 'a -> 'a -> unit = "complex_double_sequential"

let _owl_sequential : type a b. (a, b) kind -> (a, b) owl_vec_op13 = function
  | Float32   -> owl_real_float_sequential
  | Float64   -> owl_real_double_sequential
  | Complex32 -> owl_complex_float_sequential
  | Complex64 -> owl_complex_double_sequential
  | _         -> failwith "_owl_sequential: unsupported operation"

external owl_real_float_cumsum : int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> unit = "real_float_cumsum" "real_float_cumsum_impl"
external owl_real_double_cumsum : int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> unit = "real_double_cumsum" "real_double_cumsum_impl"
external owl_complex_float_cumsum : int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> unit = "complex_float_cumsum" "complex_float_cumsum_impl"
external owl_complex_double_cumsum : int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> unit = "complex_double_cumsum" "complex_double_cumsum_impl"

let _owl_cumsum : type a b. (a, b) kind -> (a, b) owl_vec_op14 = function
  | Float32   -> owl_real_float_cumsum
  | Float64   -> owl_real_double_cumsum
  | Complex32 -> owl_complex_float_cumsum
  | Complex64 -> owl_complex_double_cumsum
  | _         -> failwith "_owl_cumsum: unsupported operation"

external owl_real_float_cumprod : int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> unit = "real_float_cumprod" "real_float_cumprod_impl"
external owl_real_double_cumprod : int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> unit = "real_double_cumprod" "real_double_cumprod_impl"
external owl_complex_float_cumprod : int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> unit = "complex_float_cumprod" "complex_float_cumprod_impl"
external owl_complex_double_cumprod : int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> ('a, 'b) owl_vec -> int -> int -> int -> unit = "complex_double_cumprod" "complex_double_cumprod_impl"

let _owl_cumprod : type a b. (a, b) kind -> (a, b) owl_vec_op14 = function
  | Float32   -> owl_real_float_cumprod
  | Float64   -> owl_real_double_cumprod
  | Complex32 -> owl_complex_float_cumprod
  | Complex64 -> owl_complex_double_cumprod
  | _         -> failwith "_owl_cumprod: unsupported operation"

external owl_real_float_modf : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_modf"
external owl_real_double_modf : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_modf"
external owl_complex_float_modf : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_float_modf"
external owl_complex_double_modf : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_double_modf"

let _owl_modf : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_modf
  | Float64   -> owl_real_double_modf
  | Complex32 -> owl_complex_float_modf
  | Complex64 -> owl_complex_double_modf
  | _         -> failwith "_owl_modf: unsupported operation"

external owl_real_float_approx_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> float -> int = "real_float_approx_equal"
external owl_real_double_approx_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> float -> int = "real_double_approx_equal"
external owl_complex_float_approx_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> float -> int = "complex_float_approx_equal"
external owl_complex_double_approx_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> float -> int = "complex_double_approx_equal"

let _owl_approx_equal : type a b. (a, b) kind -> (a, b) owl_vec_op15 = function
  | Float32   -> owl_real_float_approx_equal
  | Float64   -> owl_real_double_approx_equal
  | Complex32 -> owl_complex_float_approx_equal
  | Complex64 -> owl_complex_double_approx_equal
  | _         -> failwith "_owl_approx_equal: unsupported operation"

external owl_real_float_approx_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> float -> int = "real_float_approx_equal_scalar"
external owl_real_double_approx_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> float -> int = "real_double_approx_equal_scalar"
external owl_complex_float_approx_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> float -> int = "complex_float_approx_equal_scalar"
external owl_complex_double_approx_equal_scalar : int -> ('a, 'b) owl_vec -> 'a -> float -> int = "complex_double_approx_equal_scalar"

let _owl_approx_equal_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op16 = function
  | Float32   -> owl_real_float_approx_equal_scalar
  | Float64   -> owl_real_double_approx_equal_scalar
  | Complex32 -> owl_complex_float_approx_equal_scalar
  | Complex64 -> owl_complex_double_approx_equal_scalar
  | _         -> failwith "_owl_approx_equal_scalar: unsupported operation"

external owl_real_float_approx_elt_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_float_approx_elt_equal"
external owl_real_double_approx_elt_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "real_double_approx_elt_equal"
external owl_complex_float_approx_elt_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_float_approx_elt_equal"
external owl_complex_double_approx_elt_equal : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> unit = "complex_double_approx_elt_equal"

let _owl_approx_elt_equal : type a b. (a, b) kind -> (a, b) owl_vec_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_real_float_approx_elt_equal l x y z
  | Float64   -> owl_real_double_approx_elt_equal l x y z
  | Complex32 -> owl_complex_float_approx_elt_equal l x y z
  | Complex64 -> owl_complex_double_approx_elt_equal l x y z
  | _         -> failwith "_owl_approx_elt_equal: unsupported operation"

external owl_real_float_approx_elt_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_float_approx_elt_equal_scalar"
external owl_real_double_approx_elt_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "real_double_approx_elt_equal_scalar"
external owl_complex_float_approx_elt_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_float_approx_elt_equal_scalar"
external owl_complex_double_approx_elt_equal_scalar : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> 'a -> unit = "complex_double_approx_elt_equal_scalar"

let _owl_approx_elt_equal_scalar : type a b. (a, b) kind -> (a, b) owl_vec_op11 = function
  | Float32   -> owl_real_float_approx_elt_equal_scalar
  | Float64   -> owl_real_double_approx_elt_equal_scalar
  | Complex32 -> owl_complex_float_approx_elt_equal_scalar
  | Complex64 -> owl_complex_double_approx_elt_equal_scalar
  | _         -> failwith "_owl_approx_elt_equal_scalar: unsupported operation"

external owl_real_float_to_complex : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('c, 'd) owl_vec -> unit = "real_float_to_complex"
external owl_real_double_to_complex : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('c, 'd) owl_vec -> unit = "real_double_to_complex"
external owl_complex_float_to_complex : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('c, 'd) owl_vec -> unit = "complex_float_to_complex"
external owl_complex_double_to_complex : int -> ('a, 'b) owl_vec -> ('a, 'b) owl_vec -> ('c, 'd) owl_vec -> unit = "complex_double_to_complex"

let _owl_to_complex : type a b c d. (a, b) kind -> (c, d) kind -> (a, b, c, d) owl_vec_op17 =
  fun real_kind complex_kind l x y z ->
  match real_kind with
  | Float32   -> owl_real_float_to_complex l x y z
  | Float64   -> owl_real_double_to_complex l x y z
  | Complex32 -> owl_complex_float_to_complex l x y z
  | Complex64 -> owl_complex_double_to_complex l x y z
  | _         -> failwith "_owl_to_complex: unsupported operation"


(* ends here *)
