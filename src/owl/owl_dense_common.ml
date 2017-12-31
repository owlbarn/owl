(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

(* FIXME: need to unify with the Stats module in the future *)
let rng = Random.State.make_self_init ()

(* define constants *)

let _zero : type a b. (a, b) kind -> a = function
  | Float32 -> 0.0
  | Float64 -> 0.0
  | Complex32 -> Complex.zero
  | Complex64 -> Complex.zero
  | Int8_signed -> 0
  | Int8_unsigned -> 0
  | Int16_signed -> 0
  | Int16_unsigned -> 0
  | Int32 -> 0l
  | Int64 -> 0L
  | Int -> 0
  | Nativeint -> 0n
  | Char -> '\000'

let _one : type a b. (a, b) kind -> a = function
  | Float32 -> 1.0
  | Float64 -> 1.0
  | Complex32 -> Complex.one
  | Complex64 -> Complex.one
  | Int8_signed -> 1
  | Int8_unsigned -> 1
  | Int16_signed -> 1
  | Int16_unsigned -> 1
  | Int32 -> 1l
  | Int64 -> 1L
  | Int -> 1
  | Nativeint -> 1n
  | Char -> '\001'

let _neg_one : type a b. (a, b) kind -> a = function
  | Float32 -> -1.0
  | Float64 -> -1.0
  | Complex32 -> Complex.({re=(-1.); im=0.})
  | Complex64 -> Complex.({re=(-1.); im=0.})
  | Int8_signed -> -1
  | Int8_unsigned -> -1
  | Int16_signed -> -1
  | Int16_unsigned -> -1
  | Int32 -> -1l
  | Int64 -> -1L
  | Int -> -1
  | Nativeint -> -1n
  | Char -> '\255'

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

let _owl_elt_to_str : type a b. (a, b) kind -> (a -> string) = function
  | Char           -> fun v -> Printf.sprintf "%c" v
  | Nativeint      -> fun v -> Printf.sprintf "%nd" v
  | Int8_signed    -> fun v -> Printf.sprintf "%i" v
  | Int8_unsigned  -> fun v -> Printf.sprintf "%i" v
  | Int16_signed   -> fun v -> Printf.sprintf "%i" v
  | Int16_unsigned -> fun v -> Printf.sprintf "%i" v
  | Int            -> fun v -> Printf.sprintf "%i" v
  | Int32          -> fun v -> Printf.sprintf "%ld" v
  | Int64          -> fun v -> Printf.sprintf "%Ld" v
  | Float32        -> fun v -> Printf.sprintf "%G" v
  | Float64        -> fun v -> Printf.sprintf "%G" v
  | Complex32      -> fun v -> Printf.sprintf "(%G, %Gi)" Complex.(v.re) Complex.(v.im)
  | Complex64      -> fun v -> Printf.sprintf "(%G, %Gi)" Complex.(v.re) Complex.(v.im)


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
  i is one-dimensional index;
  j is n-dimensional index;
  s is the stride.
  the space of j needs to be pre-allocated *)
let _index_1d_nd i j s =
  j.(0) <- i / s.(0);
  for k = 1 to Array.length s - 1 do
    j.(k) <- (i mod s.(k - 1)) / s.(k);
  done

(* c layout index translation: nd -> 1d
  j is n-dimensional index;
  s is the stride. *)
let _index_nd_1d j s =
  let i = ref 0 in
  Array.iteri (fun k a -> i := !i + (a * s.(k))) j;
  !i


(* basic operations on individual element *)

let _add_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32        -> ( +. )
  | Float64        -> ( +. )
  | Complex32      -> Complex.add
  | Complex64      -> Complex.add
  | Int8_signed    -> ( + )
  | Int8_unsigned  -> ( + )
  | Int16_signed   -> ( + )
  | Int16_unsigned -> ( + )
  | Int32          -> Int32.add
  | Int64          -> Int64.add
  | _              -> failwith "_add_elt: unsupported operation"

let _sub_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32        -> ( -. )
  | Float64        -> ( -. )
  | Complex32      -> Complex.sub
  | Complex64      -> Complex.sub
  | Int8_signed    -> ( - )
  | Int8_unsigned  -> ( - )
  | Int16_signed   -> ( - )
  | Int16_unsigned -> ( - )
  | Int32          -> Int32.sub
  | Int64          -> Int64.sub
  | _              -> failwith "_sub_elt: unsupported operation"

let _mul_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32        -> ( *. )
  | Float64        -> ( *. )
  | Complex32      -> Complex.mul
  | Complex64      -> Complex.mul
  | Int8_signed    -> ( * )
  | Int8_unsigned  -> ( * )
  | Int16_signed   -> ( * )
  | Int16_unsigned -> ( * )
  | Int32          -> Int32.mul
  | Int64          -> Int64.mul
  | _              -> failwith "_mul_elt: unsupported operation"

let _div_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32        -> ( /. )
  | Float64        -> ( /. )
  | Complex32      -> Complex.div
  | Complex64      -> Complex.div
  | Int8_signed    -> ( / )
  | Int8_unsigned  -> ( / )
  | Int16_signed   -> ( / )
  | Int16_unsigned -> ( / )
  | Int32          -> Int32.div
  | Int64          -> Int64.div
  | _              -> failwith "_div: unsupported operation"

let _inv_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> fun x -> 1. /. x
  | Float64   -> fun x -> 1. /. x
  | Complex32 -> Complex.inv
  | Complex64 -> Complex.inv
  | _         -> failwith "_inv_elt: unsupported operation"

let _neg_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32        -> fun x -> (-.x)
  | Float64        -> fun x -> (-.x)
  | Complex32      -> Complex.neg
  | Complex64      -> Complex.neg
  | Int8_signed    -> fun x -> -x
  | Int8_unsigned  -> fun x -> -x
  | Int16_signed   -> fun x -> -x
  | Int16_unsigned -> fun x -> -x
  | Int32          -> Int32.neg
  | Int64          -> Int64.neg
  | _              -> failwith "_inv_elt: unsupported operation"

let _abs_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32        -> abs_float
  | Float64        -> abs_float
  | Complex32      -> fun x -> Complex.({re = norm x; im = 0.})
  | Complex64      -> fun x -> Complex.({re = norm x; im = 0.})
  | Int8_signed    -> abs
  | Int8_unsigned  -> abs
  | Int16_signed   -> abs
  | Int16_unsigned -> abs
  | Int32          -> Int32.abs
  | Int64          -> Int64.abs
  | _              -> failwith "_abs_elt: unsupported operation"

let _log_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Pervasives.log
  | Float64   -> Pervasives.log
  | Complex32 -> Complex.log
  | Complex64 -> Complex.log
  | _         -> failwith "_log_elt: unsupported operation"

let _sqrt_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Pervasives.sqrt
  | Float64   -> Pervasives.sqrt
  | Complex32 -> Complex.sqrt
  | Complex64 -> Complex.sqrt
  | _         -> failwith "_sqrt_elt: unsupported operation"

let _mean_elt : type a b. (a, b) kind -> (a -> int -> a) = function
  | Float32        -> fun x n -> x /. (float_of_int n)
  | Float64        -> fun x n -> x /. (float_of_int n)
  | Complex32      -> fun x n -> Complex.(div x {re = float_of_int n; im = 0.})
  | Complex64      -> fun x n -> Complex.(div x {re = float_of_int n; im = 0.})
  | Int8_signed    -> fun x n -> x / n
  | Int8_unsigned  -> fun x n -> x / n
  | Int16_signed   -> fun x n -> x / n
  | Int16_unsigned -> fun x n -> x / n
  | Int32          -> fun x n -> Int32.(div x (of_int n))
  | Int64          -> fun x n -> Int64.(div x (of_int n))
  | _              -> failwith "_mean_elt: unsupported operation"

let _power_scalar_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( ** )
  | Float64   -> ( ** )
  | Complex32 -> Complex.pow
  | Complex64 -> Complex.pow
  | _         -> failwith "_power_scalar_elt: unsupported operation"

let _scale_elt : type a b. (a, b) kind -> (float -> a -> a) = function
  | Float32   -> fun a b -> a *. b
  | Float64   -> fun a b -> a *. b
  | Complex32 -> fun a b -> Complex.({re = a *. b.re; im = a *. b.im})
  | Complex64 -> fun a b -> Complex.({re = a *. b.re; im = a *. b.im})
  | _         -> failwith "_scale_elt: unsupported operation"

let _float_typ_elt : type a b. (a, b) kind -> (float -> a) = function
  | Float32        -> fun a -> a
  | Float64        -> fun a -> a
  | Complex32      -> fun a -> Complex.({re = a; im = 0.})
  | Complex64      -> fun a -> Complex.({re = a; im = 0.})
  | Int8_signed    -> int_of_float
  | Int8_unsigned  -> int_of_float
  | Int16_signed   -> int_of_float
  | Int16_unsigned -> int_of_float
  | Int32          -> fun a -> int_of_float a |> Int32.of_int
  | Int64          -> fun a -> int_of_float a |> Int64.of_int
  | _              -> failwith "_float_typ_elt: unsupported operation"

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


(* interface to eigen functions, types for interfacing to eigen *)

type ('a, 'b) eigen_mat = ('a, 'b, c_layout) Array2.t
type ('a, 'b) eigen_arr = ('a, 'b, c_layout) Genarray.t

type ('a, 'b) eigen_mat_op00 = ('a, 'b) eigen_mat -> ('a, 'b) eigen_mat
type ('a, 'b) eigen_mat_op01 = ('a, 'b) eigen_mat -> int -> int -> unit
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


(* interface to owl's c functions, types for interfacing to owl *)

type ('a, 'b) owl_arr = ('a, 'b, c_layout) Genarray.t

type ('a, 'b) owl_arr_op00 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int
type ('a, 'b) owl_arr_op01 = int -> ('a, 'b) owl_arr -> int
type ('a, 'b) owl_arr_op02 = int -> ('a, 'b) owl_arr -> float
type ('a, 'b) owl_arr_op03 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit
type ('a, 'b) owl_arr_op04 = int -> ('a, 'b) owl_arr -> 'a
type ('a, 'b) owl_arr_op05 = int -> 'a -> ('a, 'b) owl_arr -> 'a
type ('a, 'b) owl_arr_op06 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a
type ('a, 'b) owl_arr_op07 = int -> 'a -> 'a -> ('a, 'b) owl_arr -> unit
type ('a, 'b) owl_arr_op08 = int -> float -> 'a -> 'a -> ('a, 'b) owl_arr -> unit
type ('a, 'b) owl_arr_op09 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit
type ('a, 'b) owl_arr_op10 = int -> ('a, 'b) owl_arr -> 'a -> int
type ('a, 'b) owl_arr_op11 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit
type ('a, 'b) owl_arr_op12 = int -> ('a, 'b) owl_arr -> float -> int -> unit
type ('a, 'b) owl_arr_op13 = int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit
type ('a, 'b) owl_arr_op14 = int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit
type ('a, 'b) owl_arr_op15 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> float -> int
type ('a, 'b) owl_arr_op16 = int -> ('a, 'b) owl_arr -> 'a -> float -> int
type ('a, 'b) owl_arr_op17 = ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit
type ('a, 'b) owl_arr_op18 = int -> ?ofsx:int -> ?incx:int -> ?ofsy:int -> ?incy:int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit
type ('a, 'b, 'c, 'd) owl_arr_op19 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('c, 'd) owl_arr -> unit
type ('a, 'b) owl_arr_op20 = int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> int -> unit
type ('a, 'b) owl_arr_op21 = int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit

(* call functions in owl native c *)

external owl_float32_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "float32_copy" "float32_copy_impl"
external owl_float64_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "float64_copy" "float64_copy_impl"
external owl_complex32_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "complex32_copy" "complex32_copy_impl"
external owl_complex64_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "complex64_copy" "complex64_copy_impl"
external owl_char_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "char_copy" "char_copy_impl"
external owl_int8_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "int8_copy" "int8_copy_impl"
external owl_uint8_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "uint8_copy" "uint8_copy_impl"
external owl_int16_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "int16_copy" "int16_copy_impl"
external owl_uint16_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "uint16_copy" "uint16_copy_impl"
external owl_int32_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "int32_copy" "int32_copy_impl"
external owl_int64_copy : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "int64_copy" "int64_copy_impl"

let _owl_copy : type a b. (a, b) kind -> (a, b) owl_arr_op18 =
  fun k n ?(ofsx=0) ?(incx=1) ?(ofsy=0) ?(incy=1) x y ->
  match k with
  | Float32        -> owl_float32_copy n x ofsx incx y ofsy incy
  | Float64        -> owl_float64_copy n x ofsx incx y ofsy incy
  | Complex32      -> owl_complex32_copy n x ofsx incx y ofsy incy
  | Complex64      -> owl_complex64_copy n x ofsx incx y ofsy incy
  | Char           -> owl_char_copy n x ofsx incx y ofsy incy
  | Int8_signed    -> owl_int8_copy n x ofsx incx y ofsy incy
  | Int8_unsigned  -> owl_uint8_copy n x ofsx incx y ofsy incy
  | Int16_signed   -> owl_int16_copy n x ofsx incx y ofsy incy
  | Int16_unsigned -> owl_uint16_copy n x ofsx incx y ofsy incy
  | Int32          -> owl_int32_copy n x ofsx incx y ofsy incy
  | Int64          -> owl_int64_copy n x ofsx incx y ofsy incy
  | _              -> failwith "_owl_copy: unsupported operation"

external owl_float32_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "float32_less"
external owl_float64_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "float64_less"
external owl_complex32_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "complex32_less"
external owl_complex64_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "complex64_less"
external owl_int8_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int8_less"
external owl_uint8_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "uint8_less"
external owl_int16_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int16_less"
external owl_uint16_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "uint16_less"
external owl_int32_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int32_less"
external owl_int64_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int64_less"

let _owl_less : type a b. (a, b) kind -> (a, b) owl_arr_op00 = function
  | Float32        -> owl_float32_less
  | Float64        -> owl_float64_less
  | Complex32      -> owl_complex32_less
  | Complex64      -> owl_complex64_less
  | Int8_signed    -> owl_int8_less
  | Int8_unsigned  -> owl_uint8_less
  | Int16_signed   -> owl_int16_less
  | Int16_unsigned -> owl_uint16_less
  | Int32          -> owl_int32_less
  | Int64          -> owl_int64_less
  | _              -> failwith "_owl_less: unsupported operation"

external owl_float32_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "float32_greater"
external owl_float64_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "float64_greater"
external owl_complex32_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "complex32_greater"
external owl_complex64_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "complex64_greater"
external owl_int8_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int8_greater"
external owl_uint8_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "uint8_greater"
external owl_int16_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int16_greater"
external owl_uint16_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "uint16_greater"
external owl_int32_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int32_greater"
external owl_int64_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int64_greater"

let _owl_greater : type a b. (a, b) kind -> (a, b) owl_arr_op00 = function
  | Float32        -> owl_float32_greater
  | Float64        -> owl_float64_greater
  | Complex32      -> owl_complex32_greater
  | Complex64      -> owl_complex64_greater
  | Int8_signed    -> owl_int8_greater
  | Int8_unsigned  -> owl_uint8_greater
  | Int16_signed   -> owl_int16_greater
  | Int16_unsigned -> owl_uint16_greater
  | Int32          -> owl_int32_greater
  | Int64          -> owl_int64_greater
  | _              -> failwith "_owl_greater: unsupported operation"

external owl_float32_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "float32_less_equal"
external owl_float64_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "float64_less_equal"
external owl_complex32_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "complex32_less_equal"
external owl_complex64_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "complex64_less_equal"
external owl_int8_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int8_less_equal"
external owl_uint8_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "uint8_less_equal"
external owl_int16_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int16_less_equal"
external owl_uint16_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "uint16_less_equal"
external owl_int32_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int32_less_equal"
external owl_int64_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int64_less_equal"

let _owl_less_equal : type a b. (a, b) kind -> (a, b) owl_arr_op00 = function
  | Float32        -> owl_float32_less_equal
  | Float64        -> owl_float64_less_equal
  | Complex32      -> owl_complex32_less_equal
  | Complex64      -> owl_complex64_less_equal
  | Int8_signed    -> owl_int8_less_equal
  | Int8_unsigned  -> owl_uint8_less_equal
  | Int16_signed   -> owl_int16_less_equal
  | Int16_unsigned -> owl_uint16_less_equal
  | Int32          -> owl_int32_less_equal
  | Int64          -> owl_int64_less_equal
  | _              -> failwith "_owl_less_equal: unsupported operation"

external owl_float32_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "float32_greater_equal"
external owl_float64_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "float64_greater_equal"
external owl_complex32_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "complex32_greater_equal"
external owl_complex64_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "complex64_greater_equal"
external owl_int8_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int8_greater_equal"
external owl_uint8_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "uint8_greater_equal"
external owl_int16_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int16_greater_equal"
external owl_uint16_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "uint16_greater_equal"
external owl_int32_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int32_greater_equal"
external owl_int64_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int = "int64_greater_equal"

let _owl_greater_equal : type a b. (a, b) kind -> (a, b) owl_arr_op00 = function
  | Float32        -> owl_float32_greater_equal
  | Float64        -> owl_float64_greater_equal
  | Complex32      -> owl_complex32_greater_equal
  | Complex64      -> owl_complex64_greater_equal
  | Int8_signed    -> owl_int8_greater_equal
  | Int8_unsigned  -> owl_uint8_greater_equal
  | Int16_signed   -> owl_int16_greater_equal
  | Int16_unsigned -> owl_uint16_greater_equal
  | Int32          -> owl_int32_greater_equal
  | Int64          -> owl_int64_greater_equal
  | _              -> failwith "_owl_greater_equal: unsupported operation"

external owl_float32_is_zero : int -> ('a, 'b) owl_arr -> int = "float32_is_zero"
external owl_float64_is_zero : int -> ('a, 'b) owl_arr -> int = "float64_is_zero"
external owl_complex32_is_zero : int -> ('a, 'b) owl_arr -> int = "complex32_is_zero"
external owl_complex64_is_zero : int -> ('a, 'b) owl_arr -> int = "complex64_is_zero"
external owl_int8_is_zero : int -> ('a, 'b) owl_arr -> int = "int8_is_zero"
external owl_uint8_is_zero : int -> ('a, 'b) owl_arr -> int = "uint8_is_zero"
external owl_int16_is_zero : int -> ('a, 'b) owl_arr -> int = "int16_is_zero"
external owl_uint16_is_zero : int -> ('a, 'b) owl_arr -> int = "uint16_is_zero"
external owl_int32_is_zero : int -> ('a, 'b) owl_arr -> int = "int32_is_zero"
external owl_int64_is_zero : int -> ('a, 'b) owl_arr -> int = "int64_is_zero"

let _owl_is_zero : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32        -> owl_float32_is_zero
  | Float64        -> owl_float64_is_zero
  | Complex32      -> owl_complex32_is_zero
  | Complex64      -> owl_complex64_is_zero
  | Int8_signed    -> owl_int8_is_zero
  | Int8_unsigned  -> owl_uint8_is_zero
  | Int16_signed   -> owl_int16_is_zero
  | Int16_unsigned -> owl_uint16_is_zero
  | Int32          -> owl_int32_is_zero
  | Int64          -> owl_int64_is_zero
  | _              -> failwith "_owl_is_zero: unsupported operation"

external owl_float32_is_positive : int -> ('a, 'b) owl_arr -> int = "float32_is_positive"
external owl_float64_is_positive : int -> ('a, 'b) owl_arr -> int = "float64_is_positive"
external owl_complex32_is_positive : int -> ('a, 'b) owl_arr -> int = "complex32_is_positive"
external owl_complex64_is_positive : int -> ('a, 'b) owl_arr -> int = "complex64_is_positive"
external owl_int8_is_positive : int -> ('a, 'b) owl_arr -> int = "int8_is_positive"
external owl_uint8_is_positive : int -> ('a, 'b) owl_arr -> int = "uint8_is_positive"
external owl_int16_is_positive : int -> ('a, 'b) owl_arr -> int = "int16_is_positive"
external owl_uint16_is_positive : int -> ('a, 'b) owl_arr -> int = "uint16_is_positive"
external owl_int32_is_positive : int -> ('a, 'b) owl_arr -> int = "int32_is_positive"
external owl_int64_is_positive : int -> ('a, 'b) owl_arr -> int = "int64_is_positive"

let _owl_is_positive : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32        -> owl_float32_is_positive
  | Float64        -> owl_float64_is_positive
  | Complex32      -> owl_complex32_is_positive
  | Complex64      -> owl_complex64_is_positive
  | Int8_signed    -> owl_int8_is_positive
  | Int8_unsigned  -> owl_uint8_is_positive
  | Int16_signed   -> owl_int16_is_positive
  | Int16_unsigned -> owl_uint16_is_positive
  | Int32          -> owl_int32_is_positive
  | Int64          -> owl_int64_is_positive
  | _              -> failwith "_owl_is_positive: unsupported operation"

external owl_float32_is_negative : int -> ('a, 'b) owl_arr -> int = "float32_is_negative"
external owl_float64_is_negative : int -> ('a, 'b) owl_arr -> int = "float64_is_negative"
external owl_complex32_is_negative : int -> ('a, 'b) owl_arr -> int = "complex32_is_negative"
external owl_complex64_is_negative : int -> ('a, 'b) owl_arr -> int = "complex64_is_negative"
external owl_int8_is_negative : int -> ('a, 'b) owl_arr -> int = "int8_is_negative"
external owl_uint8_is_negative : int -> ('a, 'b) owl_arr -> int = "uint8_is_negative"
external owl_int16_is_negative : int -> ('a, 'b) owl_arr -> int = "int16_is_negative"
external owl_uint16_is_negative : int -> ('a, 'b) owl_arr -> int = "uint16_is_negative"
external owl_int32_is_negative : int -> ('a, 'b) owl_arr -> int = "int32_is_negative"
external owl_int64_is_negative : int -> ('a, 'b) owl_arr -> int = "int64_is_negative"

let _owl_is_negative : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32        -> owl_float32_is_negative
  | Float64        -> owl_float64_is_negative
  | Complex32      -> owl_complex32_is_negative
  | Complex64      -> owl_complex64_is_negative
  | Int8_signed    -> owl_int8_is_negative
  | Int8_unsigned  -> owl_uint8_is_negative
  | Int16_signed   -> owl_int16_is_negative
  | Int16_unsigned -> owl_uint16_is_negative
  | Int32          -> owl_int32_is_negative
  | Int64          -> owl_int64_is_negative
  | _              -> failwith "_owl_is_negative: unsupported operation"

external owl_float32_is_nonnegative : int -> ('a, 'b) owl_arr -> int = "float32_is_nonnegative"
external owl_float64_is_nonnegative : int -> ('a, 'b) owl_arr -> int = "float64_is_nonnegative"
external owl_complex32_is_nonnegative : int -> ('a, 'b) owl_arr -> int = "complex32_is_nonnegative"
external owl_complex64_is_nonnegative : int -> ('a, 'b) owl_arr -> int = "complex64_is_nonnegative"
external owl_int8_is_nonnegative : int -> ('a, 'b) owl_arr -> int = "int8_is_nonnegative"
external owl_uint8_is_nonnegative : int -> ('a, 'b) owl_arr -> int = "uint8_is_nonnegative"
external owl_int16_is_nonnegative : int -> ('a, 'b) owl_arr -> int = "int16_is_nonnegative"
external owl_uint16_is_nonnegative : int -> ('a, 'b) owl_arr -> int = "uint16_is_nonnegative"
external owl_int32_is_nonnegative : int -> ('a, 'b) owl_arr -> int = "int32_is_nonnegative"
external owl_int64_is_nonnegative : int -> ('a, 'b) owl_arr -> int = "int64_is_nonnegative"

let _owl_is_nonnegative : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32        -> owl_float32_is_nonnegative
  | Float64        -> owl_float64_is_nonnegative
  | Complex32      -> owl_complex32_is_nonnegative
  | Complex64      -> owl_complex64_is_nonnegative
  | Int8_signed    -> owl_int8_is_nonnegative
  | Int8_unsigned  -> owl_uint8_is_nonnegative
  | Int16_signed   -> owl_int16_is_nonnegative
  | Int16_unsigned -> owl_uint16_is_nonnegative
  | Int32          -> owl_int32_is_nonnegative
  | Int64          -> owl_int64_is_nonnegative
  | _              -> failwith "_owl_is_nonnegative: unsupported operation"

external owl_float32_is_nonpositive : int -> ('a, 'b) owl_arr -> int = "float32_is_nonpositive"
external owl_float64_is_nonpositive : int -> ('a, 'b) owl_arr -> int = "float64_is_nonpositive"
external owl_complex32_is_nonpositive : int -> ('a, 'b) owl_arr -> int = "complex32_is_nonpositive"
external owl_complex64_is_nonpositive : int -> ('a, 'b) owl_arr -> int = "complex64_is_nonpositive"
external owl_int8_is_nonpositive : int -> ('a, 'b) owl_arr -> int = "int8_is_nonpositive"
external owl_uint8_is_nonpositive : int -> ('a, 'b) owl_arr -> int = "uint8_is_nonpositive"
external owl_int16_is_nonpositive : int -> ('a, 'b) owl_arr -> int = "int16_is_nonpositive"
external owl_uint16_is_nonpositive : int -> ('a, 'b) owl_arr -> int = "uint16_is_nonpositive"
external owl_int32_is_nonpositive : int -> ('a, 'b) owl_arr -> int = "int32_is_nonpositive"
external owl_int64_is_nonpositive : int -> ('a, 'b) owl_arr -> int = "int64_is_nonpositive"

let _owl_is_nonpositive : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32        -> owl_float32_is_nonpositive
  | Float64        -> owl_float64_is_nonpositive
  | Complex32      -> owl_complex32_is_nonpositive
  | Complex64      -> owl_complex64_is_nonpositive
  | Int8_signed    -> owl_int8_is_nonpositive
  | Int8_unsigned  -> owl_uint8_is_nonpositive
  | Int16_signed   -> owl_int16_is_nonpositive
  | Int16_unsigned -> owl_uint16_is_nonpositive
  | Int32          -> owl_int32_is_nonpositive
  | Int64          -> owl_int64_is_nonpositive
  | _              -> failwith "_owl_is_nonpositive: unsupported operation"

external owl_float32_is_normal : int -> ('a, 'b) owl_arr -> int = "float32_is_normal"
external owl_float64_is_normal : int -> ('a, 'b) owl_arr -> int = "float64_is_normal"
external owl_complex32_is_normal : int -> ('a, 'b) owl_arr -> int = "complex32_is_normal"
external owl_complex64_is_normal : int -> ('a, 'b) owl_arr -> int = "complex64_is_normal"

let _owl_is_normal : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32   -> owl_float32_is_normal
  | Float64   -> owl_float64_is_normal
  | Complex32 -> owl_complex32_is_normal
  | Complex64 -> owl_complex64_is_normal
  | _         -> failwith "_owl_is_normal: unsupported operation"

external owl_float32_not_nan : int -> ('a, 'b) owl_arr -> int = "float32_not_nan"
external owl_float64_not_nan : int -> ('a, 'b) owl_arr -> int = "float64_not_nan"
external owl_complex32_not_nan : int -> ('a, 'b) owl_arr -> int = "complex32_not_nan"
external owl_complex64_not_nan : int -> ('a, 'b) owl_arr -> int = "complex64_not_nan"

let _owl_not_nan : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32   -> owl_float32_not_nan
  | Float64   -> owl_float64_not_nan
  | Complex32 -> owl_complex32_not_nan
  | Complex64 -> owl_complex64_not_nan
  | _         -> failwith "_owl_not_nan: unsupported operation"

external owl_float32_not_inf : int -> ('a, 'b) owl_arr -> int = "float32_not_inf"
external owl_float64_not_inf : int -> ('a, 'b) owl_arr -> int = "float64_not_inf"
external owl_complex32_not_inf : int -> ('a, 'b) owl_arr -> int = "complex32_not_inf"
external owl_complex64_not_inf : int -> ('a, 'b) owl_arr -> int = "complex64_not_inf"

let _owl_not_inf : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32   -> owl_float32_not_inf
  | Float64   -> owl_float64_not_inf
  | Complex32 -> owl_complex32_not_inf
  | Complex64 -> owl_complex64_not_inf
  | _         -> failwith "_owl_not_inf: unsupported operation"

external owl_float32_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_elt_equal"
external owl_float64_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_elt_equal"
external owl_complex32_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_elt_equal"
external owl_complex64_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_elt_equal"
external owl_int8_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_elt_equal"
external owl_uint8_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_elt_equal"
external owl_int16_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_elt_equal"
external owl_uint16_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_elt_equal"
external owl_int32_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_elt_equal"
external owl_int64_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_elt_equal"

let _owl_elt_equal : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_elt_equal l x y z
  | Float64        -> owl_float64_elt_equal l x y z
  | Complex32      -> owl_complex32_elt_equal l x y z
  | Complex64      -> owl_complex64_elt_equal l x y z
  | Int8_signed    -> owl_int8_elt_equal l x y z
  | Int8_unsigned  -> owl_uint8_elt_equal l x y z
  | Int16_signed   -> owl_int16_elt_equal l x y z
  | Int16_unsigned -> owl_uint16_elt_equal l x y z
  | Int32          -> owl_int32_elt_equal l x y z
  | Int64          -> owl_int64_elt_equal l x y z
  | _              -> failwith "_owl_elt_equal: unsupported operation"

external owl_float32_elt_not_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_elt_not_equal"
external owl_float64_elt_not_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_elt_not_equal"
external owl_complex32_elt_not_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_elt_not_equal"
external owl_complex64_elt_not_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_elt_not_equal"
external owl_int8_elt_not_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_elt_not_equal"
external owl_uint8_elt_not_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_elt_not_equal"
external owl_int16_elt_not_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_elt_not_equal"
external owl_uint16_elt_not_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_elt_not_equal"
external owl_int32_elt_not_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_elt_not_equal"
external owl_int64_elt_not_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_elt_not_equal"

let _owl_elt_not_equal : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_elt_not_equal l x y z
  | Float64        -> owl_float64_elt_not_equal l x y z
  | Complex32      -> owl_complex32_elt_not_equal l x y z
  | Complex64      -> owl_complex64_elt_not_equal l x y z
  | Int8_signed    -> owl_int8_elt_not_equal l x y z
  | Int8_unsigned  -> owl_uint8_elt_not_equal l x y z
  | Int16_signed   -> owl_int16_elt_not_equal l x y z
  | Int16_unsigned -> owl_uint16_elt_not_equal l x y z
  | Int32          -> owl_int32_elt_not_equal l x y z
  | Int64          -> owl_int64_elt_not_equal l x y z
  | _              -> failwith "_owl_elt_not_equal: unsupported operation"

external owl_float32_elt_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_elt_less"
external owl_float64_elt_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_elt_less"
external owl_complex32_elt_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_elt_less"
external owl_complex64_elt_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_elt_less"
external owl_int8_elt_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_elt_less"
external owl_uint8_elt_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_elt_less"
external owl_int16_elt_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_elt_less"
external owl_uint16_elt_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_elt_less"
external owl_int32_elt_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_elt_less"
external owl_int64_elt_less : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_elt_less"

let _owl_elt_less : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_elt_less l x y z
  | Float64        -> owl_float64_elt_less l x y z
  | Complex32      -> owl_complex32_elt_less l x y z
  | Complex64      -> owl_complex64_elt_less l x y z
  | Int8_signed    -> owl_int8_elt_less l x y z
  | Int8_unsigned  -> owl_uint8_elt_less l x y z
  | Int16_signed   -> owl_int16_elt_less l x y z
  | Int16_unsigned -> owl_uint16_elt_less l x y z
  | Int32          -> owl_int32_elt_less l x y z
  | Int64          -> owl_int64_elt_less l x y z
  | _              -> failwith "_owl_elt_less: unsupported operation"

external owl_float32_elt_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_elt_greater"
external owl_float64_elt_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_elt_greater"
external owl_complex32_elt_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_elt_greater"
external owl_complex64_elt_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_elt_greater"
external owl_int8_elt_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_elt_greater"
external owl_uint8_elt_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_elt_greater"
external owl_int16_elt_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_elt_greater"
external owl_uint16_elt_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_elt_greater"
external owl_int32_elt_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_elt_greater"
external owl_int64_elt_greater : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_elt_greater"

let _owl_elt_greater : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_elt_greater l x y z
  | Float64        -> owl_float64_elt_greater l x y z
  | Complex32      -> owl_complex32_elt_greater l x y z
  | Complex64      -> owl_complex64_elt_greater l x y z
  | Int8_signed    -> owl_int8_elt_greater l x y z
  | Int8_unsigned  -> owl_uint8_elt_greater l x y z
  | Int16_signed   -> owl_int16_elt_greater l x y z
  | Int16_unsigned -> owl_uint16_elt_greater l x y z
  | Int32          -> owl_int32_elt_greater l x y z
  | Int64          -> owl_int64_elt_greater l x y z
  | _              -> failwith "_owl_elt_greater: unsupported operation"

external owl_float32_elt_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_elt_less_equal"
external owl_float64_elt_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_elt_less_equal"
external owl_complex32_elt_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_elt_less_equal"
external owl_complex64_elt_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_elt_less_equal"
external owl_int8_elt_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_elt_less_equal"
external owl_uint8_elt_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_elt_less_equal"
external owl_int16_elt_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_elt_less_equal"
external owl_uint16_elt_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_elt_less_equal"
external owl_int32_elt_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_elt_less_equal"
external owl_int64_elt_less_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_elt_less_equal"

let _owl_elt_less_equal : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_elt_less_equal l x y z
  | Float64        -> owl_float64_elt_less_equal l x y z
  | Complex32      -> owl_complex32_elt_less_equal l x y z
  | Complex64      -> owl_complex64_elt_less_equal l x y z
  | Int8_signed    -> owl_int8_elt_less_equal l x y z
  | Int8_unsigned  -> owl_uint8_elt_less_equal l x y z
  | Int16_signed   -> owl_int16_elt_less_equal l x y z
  | Int16_unsigned -> owl_uint16_elt_less_equal l x y z
  | Int32          -> owl_int32_elt_less_equal l x y z
  | Int64          -> owl_int64_elt_less_equal l x y z
  | _              -> failwith "_owl_elt_less_equal: unsupported operation"

external owl_float32_elt_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_elt_greater_equal"
external owl_float64_elt_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_elt_greater_equal"
external owl_complex32_elt_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_elt_greater_equal"
external owl_complex64_elt_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_elt_greater_equal"
external owl_int8_elt_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_elt_greater_equal"
external owl_uint8_elt_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_elt_greater_equal"
external owl_int16_elt_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_elt_greater_equal"
external owl_uint16_elt_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_elt_greater_equal"
external owl_int32_elt_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_elt_greater_equal"
external owl_int64_elt_greater_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_elt_greater_equal"

let _owl_elt_greater_equal : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_elt_greater_equal l x y z
  | Float64        -> owl_float64_elt_greater_equal l x y z
  | Complex32      -> owl_complex32_elt_greater_equal l x y z
  | Complex64      -> owl_complex64_elt_greater_equal l x y z
  | Int8_signed    -> owl_int8_elt_greater_equal l x y z
  | Int8_unsigned  -> owl_uint8_elt_greater_equal l x y z
  | Int16_signed   -> owl_int16_elt_greater_equal l x y z
  | Int16_unsigned -> owl_uint16_elt_greater_equal l x y z
  | Int32          -> owl_int32_elt_greater_equal l x y z
  | Int64          -> owl_int64_elt_greater_equal l x y z
  | _              -> failwith "_owl_elt_greater_equal: unsupported operation"

external owl_float32_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float32_equal_scalar"
external owl_float64_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float64_equal_scalar"
external owl_complex32_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex32_equal_scalar"
external owl_complex64_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex64_equal_scalar"
external owl_int8_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int8_equal_scalar"
external owl_uint8_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint8_equal_scalar"
external owl_int16_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int16_equal_scalar"
external owl_uint16_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint16_equal_scalar"
external owl_int32_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int32_equal_scalar"
external owl_int64_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int64_equal_scalar"

let _owl_equal_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op10 = function
  | Float32        -> owl_float32_equal_scalar
  | Float64        -> owl_float64_equal_scalar
  | Complex32      -> owl_complex32_equal_scalar
  | Complex64      -> owl_complex64_equal_scalar
  | Int8_signed    -> owl_int8_equal_scalar
  | Int8_unsigned  -> owl_uint8_equal_scalar
  | Int16_signed   -> owl_int16_equal_scalar
  | Int16_unsigned -> owl_uint16_equal_scalar
  | Int32          -> owl_int32_equal_scalar
  | Int64          -> owl_int64_equal_scalar
  | _              -> failwith "_owl_equal_scalar: unsupported operation"

external owl_float32_not_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float32_not_equal_scalar"
external owl_float64_not_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float64_not_equal_scalar"
external owl_complex32_not_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex32_not_equal_scalar"
external owl_complex64_not_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex64_not_equal_scalar"
external owl_int8_not_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int8_not_equal_scalar"
external owl_uint8_not_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint8_not_equal_scalar"
external owl_int16_not_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int16_not_equal_scalar"
external owl_uint16_not_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint16_not_equal_scalar"
external owl_int32_not_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int32_not_equal_scalar"
external owl_int64_not_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int64_not_equal_scalar"

let _owl_not_equal_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op10 = function
  | Float32        -> owl_float32_not_equal_scalar
  | Float64        -> owl_float64_not_equal_scalar
  | Complex32      -> owl_complex32_not_equal_scalar
  | Complex64      -> owl_complex64_not_equal_scalar
  | Int8_signed    -> owl_int8_not_equal_scalar
  | Int8_unsigned  -> owl_uint8_not_equal_scalar
  | Int16_signed   -> owl_int16_not_equal_scalar
  | Int16_unsigned -> owl_uint16_not_equal_scalar
  | Int32          -> owl_int32_not_equal_scalar
  | Int64          -> owl_int64_not_equal_scalar
  | _              -> failwith "_owl_not_equal_scalar: unsupported operation"

external owl_float32_less_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float32_less_scalar"
external owl_float64_less_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float64_less_scalar"
external owl_complex32_less_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex32_less_scalar"
external owl_complex64_less_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex64_less_scalar"
external owl_int8_less_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int8_less_scalar"
external owl_uint8_less_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint8_less_scalar"
external owl_int16_less_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int16_less_scalar"
external owl_uint16_less_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint16_less_scalar"
external owl_int32_less_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int32_less_scalar"
external owl_int64_less_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int64_less_scalar"

let _owl_less_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op10 = function
  | Float32        -> owl_float32_less_scalar
  | Float64        -> owl_float64_less_scalar
  | Complex32      -> owl_complex32_less_scalar
  | Complex64      -> owl_complex64_less_scalar
  | Int8_signed    -> owl_int8_less_scalar
  | Int8_unsigned  -> owl_uint8_less_scalar
  | Int16_signed   -> owl_int16_less_scalar
  | Int16_unsigned -> owl_uint16_less_scalar
  | Int32          -> owl_int32_less_scalar
  | Int64          -> owl_int64_less_scalar
  | _              -> failwith "_owl_less_scalar: unsupported operation"

external owl_float32_greater_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float32_greater_scalar"
external owl_float64_greater_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float64_greater_scalar"
external owl_complex32_greater_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex32_greater_scalar"
external owl_complex64_greater_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex64_greater_scalar"
external owl_int8_greater_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int8_greater_scalar"
external owl_uint8_greater_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint8_greater_scalar"
external owl_int16_greater_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int16_greater_scalar"
external owl_uint16_greater_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint16_greater_scalar"
external owl_int32_greater_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int32_greater_scalar"
external owl_int64_greater_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int64_greater_scalar"

let _owl_greater_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op10 = function
  | Float32        -> owl_float32_greater_scalar
  | Float64        -> owl_float64_greater_scalar
  | Complex32      -> owl_complex32_greater_scalar
  | Complex64      -> owl_complex64_greater_scalar
  | Int8_signed    -> owl_int8_greater_scalar
  | Int8_unsigned  -> owl_uint8_greater_scalar
  | Int16_signed   -> owl_int16_greater_scalar
  | Int16_unsigned -> owl_uint16_greater_scalar
  | Int32          -> owl_int32_greater_scalar
  | Int64          -> owl_int64_greater_scalar
  | _              -> failwith "_owl_greater_scalar: unsupported operation"

external owl_float32_less_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float32_less_equal_scalar"
external owl_float64_less_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float64_less_equal_scalar"
external owl_complex32_less_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex32_less_equal_scalar"
external owl_complex64_less_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex64_less_equal_scalar"
external owl_int8_less_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int8_less_equal_scalar"
external owl_uint8_less_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint8_less_equal_scalar"
external owl_int16_less_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int16_less_equal_scalar"
external owl_uint16_less_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint16_less_equal_scalar"
external owl_int32_less_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int32_less_equal_scalar"
external owl_int64_less_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int64_less_equal_scalar"

let _owl_less_equal_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op10 = function
  | Float32        -> owl_float32_less_equal_scalar
  | Float64        -> owl_float64_less_equal_scalar
  | Complex32      -> owl_complex32_less_equal_scalar
  | Complex64      -> owl_complex64_less_equal_scalar
  | Int8_signed    -> owl_int8_less_equal_scalar
  | Int8_unsigned  -> owl_uint8_less_equal_scalar
  | Int16_signed   -> owl_int16_less_equal_scalar
  | Int16_unsigned -> owl_uint16_less_equal_scalar
  | Int32          -> owl_int32_less_equal_scalar
  | Int64          -> owl_int64_less_equal_scalar
  | _              -> failwith "_owl_less_equal_scalar: unsupported operation"

external owl_float32_greater_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float32_greater_equal_scalar"
external owl_float64_greater_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "float64_greater_equal_scalar"
external owl_complex32_greater_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex32_greater_equal_scalar"
external owl_complex64_greater_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "complex64_greater_equal_scalar"
external owl_int8_greater_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int8_greater_equal_scalar"
external owl_uint8_greater_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint8_greater_equal_scalar"
external owl_int16_greater_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int16_greater_equal_scalar"
external owl_uint16_greater_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "uint16_greater_equal_scalar"
external owl_int32_greater_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int32_greater_equal_scalar"
external owl_int64_greater_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> int = "int64_greater_equal_scalar"

let _owl_greater_equal_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op10 = function
  | Float32        -> owl_float32_greater_equal_scalar
  | Float64        -> owl_float64_greater_equal_scalar
  | Complex32      -> owl_complex32_greater_equal_scalar
  | Complex64      -> owl_complex64_greater_equal_scalar
  | Int8_signed    -> owl_int8_greater_equal_scalar
  | Int8_unsigned  -> owl_uint8_greater_equal_scalar
  | Int16_signed   -> owl_int16_greater_equal_scalar
  | Int16_unsigned -> owl_uint16_greater_equal_scalar
  | Int32          -> owl_int32_greater_equal_scalar
  | Int64          -> owl_int64_greater_equal_scalar
  | _              -> failwith "_owl_greater_equal_scalar: unsupported operation"

external owl_float32_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_elt_equal_scalar"
external owl_float64_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_elt_equal_scalar"
external owl_complex32_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_elt_equal_scalar"
external owl_complex64_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_elt_equal_scalar"
external owl_int8_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_elt_equal_scalar"
external owl_uint8_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_elt_equal_scalar"
external owl_int16_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_elt_equal_scalar"
external owl_uint16_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_elt_equal_scalar"
external owl_int32_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_elt_equal_scalar"
external owl_int64_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_elt_equal_scalar"

let _owl_elt_equal_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_elt_equal_scalar
  | Float64        -> owl_float64_elt_equal_scalar
  | Complex32      -> owl_complex32_elt_equal_scalar
  | Complex64      -> owl_complex64_elt_equal_scalar
  | Int8_signed    -> owl_int8_elt_equal_scalar
  | Int8_unsigned  -> owl_uint8_elt_equal_scalar
  | Int16_signed   -> owl_int16_elt_equal_scalar
  | Int16_unsigned -> owl_uint16_elt_equal_scalar
  | Int32          -> owl_int32_elt_equal_scalar
  | Int64          -> owl_int64_elt_equal_scalar
  | _              -> failwith "_owl_elt_equal_scalar: unsupported operation"

external owl_float32_elt_not_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_elt_not_equal_scalar"
external owl_float64_elt_not_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_elt_not_equal_scalar"
external owl_complex32_elt_not_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_elt_not_equal_scalar"
external owl_complex64_elt_not_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_elt_not_equal_scalar"
external owl_int8_elt_not_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_elt_not_equal_scalar"
external owl_uint8_elt_not_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_elt_not_equal_scalar"
external owl_int16_elt_not_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_elt_not_equal_scalar"
external owl_uint16_elt_not_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_elt_not_equal_scalar"
external owl_int32_elt_not_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_elt_not_equal_scalar"
external owl_int64_elt_not_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_elt_not_equal_scalar"

let _owl_elt_not_equal_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_elt_not_equal_scalar
  | Float64        -> owl_float64_elt_not_equal_scalar
  | Complex32      -> owl_complex32_elt_not_equal_scalar
  | Complex64      -> owl_complex64_elt_not_equal_scalar
  | Int8_signed    -> owl_int8_elt_not_equal_scalar
  | Int8_unsigned  -> owl_uint8_elt_not_equal_scalar
  | Int16_signed   -> owl_int16_elt_not_equal_scalar
  | Int16_unsigned -> owl_uint16_elt_not_equal_scalar
  | Int32          -> owl_int32_elt_not_equal_scalar
  | Int64          -> owl_int64_elt_not_equal_scalar
  | _              -> failwith "_owl_elt_not_equal_scalar: unsupported operation"

external owl_float32_elt_less_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_elt_less_scalar"
external owl_float64_elt_less_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_elt_less_scalar"
external owl_complex32_elt_less_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_elt_less_scalar"
external owl_complex64_elt_less_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_elt_less_scalar"
external owl_int8_elt_less_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_elt_less_scalar"
external owl_uint8_elt_less_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_elt_less_scalar"
external owl_int16_elt_less_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_elt_less_scalar"
external owl_uint16_elt_less_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_elt_less_scalar"
external owl_int32_elt_less_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_elt_less_scalar"
external owl_int64_elt_less_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_elt_less_scalar"

let _owl_elt_less_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_elt_less_scalar
  | Float64        -> owl_float64_elt_less_scalar
  | Complex32      -> owl_complex32_elt_less_scalar
  | Complex64      -> owl_complex64_elt_less_scalar
  | Int8_signed    -> owl_int8_elt_less_scalar
  | Int8_unsigned  -> owl_uint8_elt_less_scalar
  | Int16_signed   -> owl_int16_elt_less_scalar
  | Int16_unsigned -> owl_uint16_elt_less_scalar
  | Int32          -> owl_int32_elt_less_scalar
  | Int64          -> owl_int64_elt_less_scalar
  | _              -> failwith "_owl_elt_less_scalar: unsupported operation"

external owl_float32_elt_greater_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_elt_greater_scalar"
external owl_float64_elt_greater_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_elt_greater_scalar"
external owl_complex32_elt_greater_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_elt_greater_scalar"
external owl_complex64_elt_greater_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_elt_greater_scalar"
external owl_int8_elt_greater_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_elt_greater_scalar"
external owl_uint8_elt_greater_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_elt_greater_scalar"
external owl_int16_elt_greater_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_elt_greater_scalar"
external owl_uint16_elt_greater_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_elt_greater_scalar"
external owl_int32_elt_greater_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_elt_greater_scalar"
external owl_int64_elt_greater_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_elt_greater_scalar"

let _owl_elt_greater_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_elt_greater_scalar
  | Float64        -> owl_float64_elt_greater_scalar
  | Complex32      -> owl_complex32_elt_greater_scalar
  | Complex64      -> owl_complex64_elt_greater_scalar
  | Int8_signed    -> owl_int8_elt_greater_scalar
  | Int8_unsigned  -> owl_uint8_elt_greater_scalar
  | Int16_signed   -> owl_int16_elt_greater_scalar
  | Int16_unsigned -> owl_uint16_elt_greater_scalar
  | Int32          -> owl_int32_elt_greater_scalar
  | Int64          -> owl_int64_elt_greater_scalar
  | _              -> failwith "_owl_elt_greater_scalar: unsupported operation"

external owl_float32_elt_less_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_elt_less_equal_scalar"
external owl_float64_elt_less_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_elt_less_equal_scalar"
external owl_complex32_elt_less_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_elt_less_equal_scalar"
external owl_complex64_elt_less_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_elt_less_equal_scalar"
external owl_int8_elt_less_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_elt_less_equal_scalar"
external owl_uint8_elt_less_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_elt_less_equal_scalar"
external owl_int16_elt_less_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_elt_less_equal_scalar"
external owl_uint16_elt_less_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_elt_less_equal_scalar"
external owl_int32_elt_less_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_elt_less_equal_scalar"
external owl_int64_elt_less_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_elt_less_equal_scalar"

let _owl_elt_less_equal_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_elt_less_equal_scalar
  | Float64        -> owl_float64_elt_less_equal_scalar
  | Complex32      -> owl_complex32_elt_less_equal_scalar
  | Complex64      -> owl_complex64_elt_less_equal_scalar
  | Int8_signed    -> owl_int8_elt_less_equal_scalar
  | Int8_unsigned  -> owl_uint8_elt_less_equal_scalar
  | Int16_signed   -> owl_int16_elt_less_equal_scalar
  | Int16_unsigned -> owl_uint16_elt_less_equal_scalar
  | Int32          -> owl_int32_elt_less_equal_scalar
  | Int64          -> owl_int64_elt_less_equal_scalar
  | _              -> failwith "_owl_elt_less_equal_scalar: unsupported operation"

external owl_float32_elt_greater_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_elt_greater_equal_scalar"
external owl_float64_elt_greater_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_elt_greater_equal_scalar"
external owl_complex32_elt_greater_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_elt_greater_equal_scalar"
external owl_complex64_elt_greater_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_elt_greater_equal_scalar"
external owl_int8_elt_greater_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_elt_greater_equal_scalar"
external owl_uint8_elt_greater_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_elt_greater_equal_scalar"
external owl_int16_elt_greater_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_elt_greater_equal_scalar"
external owl_uint16_elt_greater_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_elt_greater_equal_scalar"
external owl_int32_elt_greater_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_elt_greater_equal_scalar"
external owl_int64_elt_greater_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_elt_greater_equal_scalar"

let _owl_elt_greater_equal_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_elt_greater_equal_scalar
  | Float64        -> owl_float64_elt_greater_equal_scalar
  | Complex32      -> owl_complex32_elt_greater_equal_scalar
  | Complex64      -> owl_complex64_elt_greater_equal_scalar
  | Int8_signed    -> owl_int8_elt_greater_equal_scalar
  | Int8_unsigned  -> owl_uint8_elt_greater_equal_scalar
  | Int16_signed   -> owl_int16_elt_greater_equal_scalar
  | Int16_unsigned -> owl_uint16_elt_greater_equal_scalar
  | Int32          -> owl_int32_elt_greater_equal_scalar
  | Int64          -> owl_int64_elt_greater_equal_scalar
  | _              -> failwith "_owl_elt_greater_equal_scalar: unsupported operation"

external owl_float32_nnz : int -> ('a, 'b) owl_arr -> int = "float32_nnz"
external owl_float64_nnz : int -> ('a, 'b) owl_arr -> int = "float64_nnz"
external owl_complex32_nnz : int -> ('a, 'b) owl_arr -> int = "complex32_nnz"
external owl_complex64_nnz : int -> ('a, 'b) owl_arr -> int = "complex64_nnz"
external owl_int8_nnz : int -> ('a, 'b) owl_arr -> int = "int8_nnz"
external owl_uint8_nnz : int -> ('a, 'b) owl_arr -> int = "uint8_nnz"
external owl_int16_nnz : int -> ('a, 'b) owl_arr -> int = "int16_nnz"
external owl_uint16_nnz : int -> ('a, 'b) owl_arr -> int = "uint16_nnz"
external owl_int32_nnz : int -> ('a, 'b) owl_arr -> int = "int32_nnz"
external owl_int64_nnz : int -> ('a, 'b) owl_arr -> int = "int64_nnz"

let _owl_nnz : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32        -> owl_float32_nnz
  | Float64        -> owl_float64_nnz
  | Complex32      -> owl_complex32_nnz
  | Complex64      -> owl_complex64_nnz
  | Int8_signed    -> owl_int8_nnz
  | Int8_unsigned  -> owl_uint8_nnz
  | Int16_signed   -> owl_int16_nnz
  | Int16_unsigned -> owl_uint16_nnz
  | Int32          -> owl_int32_nnz
  | Int64          -> owl_int64_nnz
  | _              -> failwith "_owl_nnz: unsupported operation"

external owl_float32_min_i : int -> ('a, 'b) owl_arr -> int = "float32_min_i"
external owl_float64_min_i : int -> ('a, 'b) owl_arr -> int = "float64_min_i"
external owl_complex32_min_i : int -> ('a, 'b) owl_arr -> int = "complex32_min_i"
external owl_complex64_min_i : int -> ('a, 'b) owl_arr -> int = "complex64_min_i"
external owl_int8_min_i : int -> ('a, 'b) owl_arr -> int = "int8_min_i"
external owl_uint8_min_i : int -> ('a, 'b) owl_arr -> int = "uint8_min_i"
external owl_int16_min_i : int -> ('a, 'b) owl_arr -> int = "int16_min_i"
external owl_uint16_min_i : int -> ('a, 'b) owl_arr -> int = "uint16_min_i"
external owl_int32_min_i : int -> ('a, 'b) owl_arr -> int = "int32_min_i"
external owl_int64_min_i : int -> ('a, 'b) owl_arr -> int = "int64_min_i"

let _owl_min_i : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32        -> owl_float32_min_i
  | Float64        -> owl_float64_min_i
  | Complex32      -> owl_complex32_min_i
  | Complex64      -> owl_complex64_min_i
  | Int8_signed    -> owl_int8_min_i
  | Int8_unsigned  -> owl_uint8_min_i
  | Int16_signed   -> owl_int16_min_i
  | Int16_unsigned -> owl_uint16_min_i
  | Int32          -> owl_int32_min_i
  | Int64          -> owl_int64_min_i
  | _              -> failwith "_owl_min_i: unsupported operation"

external owl_float32_min_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_min_along"
external owl_float64_min_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_min_along"
external owl_complex32_min_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_min_along"
external owl_complex64_min_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_min_along"
external owl_int8_min_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_min_along"
external owl_uint8_min_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_min_along"
external owl_int16_min_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_min_along"
external owl_uint16_min_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_min_along"
external owl_int32_min_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_min_along"
external owl_int64_min_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_min_along"

let _owl_min_along : type a b. (a, b) kind -> (a, b) owl_arr_op21 = function
  | Float32        -> owl_float32_min_along
  | Float64        -> owl_float64_min_along
  | Complex32      -> owl_complex32_min_along
  | Complex64      -> owl_complex64_min_along
  | Int8_signed    -> owl_int8_min_along
  | Int8_unsigned  -> owl_uint8_min_along
  | Int16_signed   -> owl_int16_min_along
  | Int16_unsigned -> owl_uint16_min_along
  | Int32          -> owl_int32_min_along
  | Int64          -> owl_int64_min_along
  | _              -> failwith "_owl_min_along: unsupported operation"

external owl_float32_max_i : int -> ('a, 'b) owl_arr -> int = "float32_max_i"
external owl_float64_max_i : int -> ('a, 'b) owl_arr -> int = "float64_max_i"
external owl_complex32_max_i : int -> ('a, 'b) owl_arr -> int = "complex32_max_i"
external owl_complex64_max_i : int -> ('a, 'b) owl_arr -> int = "complex64_max_i"
external owl_int8_max_i : int -> ('a, 'b) owl_arr -> int = "int8_max_i"
external owl_uint8_max_i : int -> ('a, 'b) owl_arr -> int = "uint8_max_i"
external owl_int16_max_i : int -> ('a, 'b) owl_arr -> int = "int16_max_i"
external owl_uint16_max_i : int -> ('a, 'b) owl_arr -> int = "uint16_max_i"
external owl_int32_max_i : int -> ('a, 'b) owl_arr -> int = "int32_max_i"
external owl_int64_max_i : int -> ('a, 'b) owl_arr -> int = "int64_max_i"

let _owl_max_i : type a b. (a, b) kind -> (a, b) owl_arr_op01 = function
  | Float32        -> owl_float32_max_i
  | Float64        -> owl_float64_max_i
  | Complex32      -> owl_complex32_max_i
  | Complex64      -> owl_complex64_max_i
  | Int8_signed    -> owl_int8_max_i
  | Int8_unsigned  -> owl_uint8_max_i
  | Int16_signed   -> owl_int16_max_i
  | Int16_unsigned -> owl_uint16_max_i
  | Int32          -> owl_int32_max_i
  | Int64          -> owl_int64_max_i
  | _              -> failwith "_owl_max_i: unsupported operation"

external owl_float32_max_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_max_along"
external owl_float64_max_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_max_along"
external owl_complex32_max_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_max_along"
external owl_complex64_max_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_max_along"
external owl_int8_max_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_max_along"
external owl_uint8_max_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_max_along"
external owl_int16_max_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_max_along"
external owl_uint16_max_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_max_along"
external owl_int32_max_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_max_along"
external owl_int64_max_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_max_along"

let _owl_max_along : type a b. (a, b) kind -> (a, b) owl_arr_op21 = function
  | Float32        -> owl_float32_max_along
  | Float64        -> owl_float64_max_along
  | Complex32      -> owl_complex32_max_along
  | Complex64      -> owl_complex64_max_along
  | Int8_signed    -> owl_int8_max_along
  | Int8_unsigned  -> owl_uint8_max_along
  | Int16_signed   -> owl_int16_max_along
  | Int16_unsigned -> owl_uint16_max_along
  | Int32          -> owl_int32_max_along
  | Int64          -> owl_int64_max_along
  | _              -> failwith "_owl_max_along: unsupported operation"

external owl_float32_neg : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "float32_neg" "float32_neg_impl"
external owl_float64_neg : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "float64_neg" "float64_neg_impl"
external owl_complex32_neg : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "complex32_neg" "complex32_neg_impl"
external owl_complex64_neg : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "complex64_neg" "complex64_neg_impl"
external owl_int8_neg : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "int8_neg" "int8_neg_impl"
external owl_uint8_neg : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "uint8_neg" "uint8_neg_impl"
external owl_int16_neg : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "int16_neg" "int16_neg_impl"
external owl_uint16_neg : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "uint16_neg" "uint16_neg_impl"
external owl_int32_neg : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "int32_neg" "int32_neg_impl"
external owl_int64_neg : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "int64_neg" "int64_neg_impl"

let _owl_neg : type a b. (a, b) kind -> (a, b) owl_arr_op18 =
  fun k n ?(ofsx=0) ?(incx=1) ?(ofsy=0) ?(incy=1) x y ->
  match k with
  | Float32        -> owl_float32_neg n x ofsx incx y ofsy incy
  | Float64        -> owl_float64_neg n x ofsx incx y ofsy incy
  | Complex32      -> owl_complex32_neg n x ofsx incx y ofsy incy
  | Complex64      -> owl_complex64_neg n x ofsx incx y ofsy incy
  | Int8_signed    -> owl_int8_neg n x ofsx incx y ofsy incy
  | Int8_unsigned  -> owl_uint8_neg n x ofsx incx y ofsy incy
  | Int16_signed   -> owl_int16_neg n x ofsx incx y ofsy incy
  | Int16_unsigned -> owl_uint16_neg n x ofsx incx y ofsy incy
  | Int32          -> owl_int32_neg n x ofsx incx y ofsy incy
  | Int64          -> owl_int64_neg n x ofsx incx y ofsy incy
  | _              -> failwith "_owl_neg: unsupported operation"

external owl_float32_reci : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_reci"
external owl_float64_reci : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_reci"
external owl_complex32_reci : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_reci"
external owl_complex64_reci : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_reci"

let _owl_reci : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_reci l x y
  | Float64   -> owl_float64_reci l x y
  | Complex32 -> owl_complex32_reci l x y
  | Complex64 -> owl_complex64_reci l x y
  | _         -> failwith "_owl_reci: unsupported operation"

external owl_float32_reci_tol : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_reci_tol"
external owl_float64_reci_tol : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_reci_tol"
external owl_complex32_reci_tol : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_reci_tol"
external owl_complex64_reci_tol : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_reci_tol"

let _owl_reci_tol : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_reci_tol
  | Float64   -> owl_float64_reci_tol
  | Complex32 -> owl_complex32_reci_tol
  | Complex64 -> owl_complex64_reci_tol
  | _         -> failwith "_owl_reci_tol: unsupported operation"

external owl_float32_abs : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_abs"
external owl_float64_abs : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_abs"
external owl_complex32_abs : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_abs"
external owl_complex64_abs : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_abs"

let _owl_abs : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_abs l x y
  | Float64   -> owl_float64_abs l x y
  | Complex32 -> owl_complex32_abs l x y
  | Complex64 -> owl_complex64_abs l x y
  | _         -> failwith "_owl_abs: unsupported operation"

external owl_float32_abs2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_abs2"
external owl_float64_abs2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_abs2"
external owl_complex32_abs2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_abs2"
external owl_complex64_abs2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_abs2"

let _owl_abs2 : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_abs2 l x y
  | Float64   -> owl_float64_abs2 l x y
  | Complex32 -> owl_complex32_abs2 l x y
  | Complex64 -> owl_complex64_abs2 l x y
  | _         -> failwith "_owl_abs2: unsupported operation"

external owl_float32_signum : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_signum"
external owl_float64_signum : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_signum"

let _owl_signum : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_signum l x y
  | Float64   -> owl_float64_signum l x y
  | _         -> failwith "_owl_signum: unsupported operation"

external owl_float32_sqr : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_sqr"
external owl_float64_sqr : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_sqr"
external owl_complex32_sqr : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_sqr"
external owl_complex64_sqr : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_sqr"

let _owl_sqr : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_sqr l x y
  | Float64   -> owl_float64_sqr l x y
  | Complex32 -> owl_complex32_sqr l x y
  | Complex64 -> owl_complex64_sqr l x y
  | _         -> failwith "_owl_sqr: unsupported operation"

external owl_float32_sqrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_sqrt"
external owl_float64_sqrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_sqrt"
external owl_complex32_sqrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_sqrt"
external owl_complex64_sqrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_sqrt"

let _owl_sqrt : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_sqrt l x y
  | Float64   -> owl_float64_sqrt l x y
  | Complex32 -> owl_complex32_sqrt l x y
  | Complex64 -> owl_complex64_sqrt l x y
  | _         -> failwith "_owl_sqrt: unsupported operation"

external owl_float32_cbrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_cbrt"
external owl_float64_cbrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_cbrt"
external owl_complex32_cbrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_cbrt"
external owl_complex64_cbrt : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_cbrt"

let _owl_cbrt : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_cbrt l x y
  | Float64   -> owl_float64_cbrt l x y
  | Complex32 -> owl_complex32_cbrt l x y
  | Complex64 -> owl_complex64_cbrt l x y
  | _         -> failwith "_owl_cbrt: unsupported operation"

external owl_float32_exp : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_exp"
external owl_float64_exp : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_exp"
external owl_complex32_exp : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_exp"
external owl_complex64_exp : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_exp"

let _owl_exp : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_exp l x y
  | Float64   -> owl_float64_exp l x y
  | Complex32 -> owl_complex32_exp l x y
  | Complex64 -> owl_complex64_exp l x y
  | _         -> failwith "_owl_exp: unsupported operation"

external owl_float32_exp2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_exp2"
external owl_float64_exp2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_exp2"
external owl_complex32_exp2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_exp2"
external owl_complex64_exp2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_exp2"

let _owl_exp2 : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_exp2 l x y
  | Float64   -> owl_float64_exp2 l x y
  | Complex32 -> owl_complex32_exp2 l x y
  | Complex64 -> owl_complex64_exp2 l x y
  | _         -> failwith "_owl_exp2: unsupported operation"

external owl_float32_exp10 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_exp10"
external owl_float64_exp10 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_exp10"
external owl_complex32_exp10 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_exp10"
external owl_complex64_exp10 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_exp10"

let _owl_exp10 : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_exp10 l x y
  | Float64   -> owl_float64_exp10 l x y
  | Complex32 -> owl_complex32_exp10 l x y
  | Complex64 -> owl_complex64_exp10 l x y
  | _         -> failwith "_owl_exp10: unsupported operation"

external owl_float32_expm1 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_expm1"
external owl_float64_expm1 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_expm1"
external owl_complex32_expm1 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_expm1"
external owl_complex64_expm1 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_expm1"

let _owl_expm1 : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_expm1 l x y
  | Float64   -> owl_float64_expm1 l x y
  | Complex32 -> owl_complex32_expm1 l x y
  | Complex64 -> owl_complex64_expm1 l x y
  | _         -> failwith "_owl_expm1: unsupported operation"

external owl_float32_log : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_log"
external owl_float64_log : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_log"
external owl_complex32_log : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_log"
external owl_complex64_log : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_log"

let _owl_log : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_log l x y
  | Float64   -> owl_float64_log l x y
  | Complex32 -> owl_complex32_log l x y
  | Complex64 -> owl_complex64_log l x y
  | _         -> failwith "_owl_log: unsupported operation"

external owl_float32_log10 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_log10"
external owl_float64_log10 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_log10"
external owl_complex32_log10 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_log10"
external owl_complex64_log10 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_log10"

let _owl_log10 : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_log10 l x y
  | Float64   -> owl_float64_log10 l x y
  | Complex32 -> owl_complex32_log10 l x y
  | Complex64 -> owl_complex64_log10 l x y
  | _         -> failwith "_owl_log10: unsupported operation"

external owl_float32_log2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_log2"
external owl_float64_log2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_log2"
external owl_complex32_log2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_log2"
external owl_complex64_log2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_log2"

let _owl_log2 : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_log2 l x y
  | Float64   -> owl_float64_log2 l x y
  | Complex32 -> owl_complex32_log2 l x y
  | Complex64 -> owl_complex64_log2 l x y
  | _         -> failwith "_owl_log2: unsupported operation"

external owl_float32_log1p : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_log1p"
external owl_float64_log1p : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_log1p"
external owl_complex32_log1p : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_log1p"
external owl_complex64_log1p : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_log1p"

let _owl_log1p : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_log1p l x y
  | Float64   -> owl_float64_log1p l x y
  | Complex32 -> owl_complex32_log1p l x y
  | Complex64 -> owl_complex64_log1p l x y
  | _         -> failwith "_owl_log1p: unsupported operation"

external owl_float32_sin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_sin"
external owl_float64_sin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_sin"
external owl_complex32_sin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_sin"
external owl_complex64_sin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_sin"

let _owl_sin : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_sin l x y
  | Float64   -> owl_float64_sin l x y
  | Complex32 -> owl_complex32_sin l x y
  | Complex64 -> owl_complex64_sin l x y
  | _         -> failwith "_owl_sin: unsupported operation"

external owl_float32_cos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_cos"
external owl_float64_cos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_cos"
external owl_complex32_cos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_cos"
external owl_complex64_cos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_cos"

let _owl_cos : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_cos l x y
  | Float64   -> owl_float64_cos l x y
  | Complex32 -> owl_complex32_cos l x y
  | Complex64 -> owl_complex64_cos l x y
  | _         -> failwith "_owl_cos: unsupported operation"

external owl_float32_tan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_tan"
external owl_float64_tan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_tan"
external owl_complex32_tan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_tan"
external owl_complex64_tan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_tan"

let _owl_tan : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_tan l x y
  | Float64   -> owl_float64_tan l x y
  | Complex32 -> owl_complex32_tan l x y
  | Complex64 -> owl_complex64_tan l x y
  | _         -> failwith "_owl_tan: unsupported operation"

external owl_float32_asin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_asin"
external owl_float64_asin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_asin"
external owl_complex32_asin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_asin"
external owl_complex64_asin : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_asin"

let _owl_asin : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_asin l x y
  | Float64   -> owl_float64_asin l x y
  | Complex32 -> owl_complex32_asin l x y
  | Complex64 -> owl_complex64_asin l x y
  | _         -> failwith "_owl_asin: unsupported operation"

external owl_float32_acos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_acos"
external owl_float64_acos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_acos"
external owl_complex32_acos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_acos"
external owl_complex64_acos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_acos"

let _owl_acos : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_acos l x y
  | Float64   -> owl_float64_acos l x y
  | Complex32 -> owl_complex32_acos l x y
  | Complex64 -> owl_complex64_acos l x y
  | _         -> failwith "_owl_acos: unsupported operation"

external owl_float32_atan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_atan"
external owl_float64_atan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_atan"
external owl_complex32_atan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_atan"
external owl_complex64_atan : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_atan"

let _owl_atan : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_atan l x y
  | Float64   -> owl_float64_atan l x y
  | Complex32 -> owl_complex32_atan l x y
  | Complex64 -> owl_complex64_atan l x y
  | _         -> failwith "_owl_atan: unsupported operation"

external owl_float32_sinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_sinh"
external owl_float64_sinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_sinh"
external owl_complex32_sinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_sinh"
external owl_complex64_sinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_sinh"

let _owl_sinh : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_sinh l x y
  | Float64   -> owl_float64_sinh l x y
  | Complex32 -> owl_complex32_sinh l x y
  | Complex64 -> owl_complex64_sinh l x y
  | _         -> failwith "_owl_sinh: unsupported operation"

external owl_float32_cosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_cosh"
external owl_float64_cosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_cosh"
external owl_complex32_cosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_cosh"
external owl_complex64_cosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_cosh"

let _owl_cosh : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_cosh l x y
  | Float64   -> owl_float64_cosh l x y
  | Complex32 -> owl_complex32_cosh l x y
  | Complex64 -> owl_complex64_cosh l x y
  | _         -> failwith "_owl_cosh: unsupported operation"

external owl_float32_tanh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_tanh"
external owl_float64_tanh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_tanh"
external owl_complex32_tanh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_tanh"
external owl_complex64_tanh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_tanh"

let _owl_tanh : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_tanh l x y
  | Float64   -> owl_float64_tanh l x y
  | Complex32 -> owl_complex32_tanh l x y
  | Complex64 -> owl_complex64_tanh l x y
  | _         -> failwith "_owl_tanh: unsupported operation"

external owl_float32_asinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_asinh"
external owl_float64_asinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_asinh"
external owl_complex32_asinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_asinh"
external owl_complex64_asinh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_asinh"

let _owl_asinh : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_asinh l x y
  | Float64   -> owl_float64_asinh l x y
  | Complex32 -> owl_complex32_asinh l x y
  | Complex64 -> owl_complex64_asinh l x y
  | _         -> failwith "_owl_asinh: unsupported operation"

external owl_float32_acosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_acosh"
external owl_float64_acosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_acosh"
external owl_complex32_acosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_acosh"
external owl_complex64_acosh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_acosh"

let _owl_acosh : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_acosh l x y
  | Float64   -> owl_float64_acosh l x y
  | Complex32 -> owl_complex32_acosh l x y
  | Complex64 -> owl_complex64_acosh l x y
  | _         -> failwith "_owl_acosh: unsupported operation"

external owl_float32_atanh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_atanh"
external owl_float64_atanh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_atanh"
external owl_complex32_atanh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_atanh"
external owl_complex64_atanh : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_atanh"

let _owl_atanh : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_atanh l x y
  | Float64   -> owl_float64_atanh l x y
  | Complex32 -> owl_complex32_atanh l x y
  | Complex64 -> owl_complex64_atanh l x y
  | _         -> failwith "_owl_atanh: unsupported operation"

external owl_float32_floor : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_floor"
external owl_float64_floor : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_floor"
external owl_complex32_floor : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_floor"
external owl_complex64_floor : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_floor"

let _owl_floor : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_floor l x y
  | Float64   -> owl_float64_floor l x y
  | Complex32 -> owl_complex32_floor l x y
  | Complex64 -> owl_complex64_floor l x y
  | _         -> failwith "_owl_floor: unsupported operation"

external owl_float32_ceil : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_ceil"
external owl_float64_ceil : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_ceil"
external owl_complex32_ceil : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_ceil"
external owl_complex64_ceil : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_ceil"

let _owl_ceil : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_ceil l x y
  | Float64   -> owl_float64_ceil l x y
  | Complex32 -> owl_complex32_ceil l x y
  | Complex64 -> owl_complex64_ceil l x y
  | _         -> failwith "_owl_ceil: unsupported operation"

external owl_float32_round : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_round"
external owl_float64_round : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_round"
external owl_complex32_round : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_round"
external owl_complex64_round : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_round"

let _owl_round : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_round l x y
  | Float64   -> owl_float64_round l x y
  | Complex32 -> owl_complex32_round l x y
  | Complex64 -> owl_complex64_round l x y
  | _         -> failwith "_owl_round: unsupported operation"

external owl_float32_trunc : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_trunc"
external owl_float64_trunc : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_trunc"
external owl_complex32_trunc : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_trunc"
external owl_complex64_trunc : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_trunc"

let _owl_trunc : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_trunc l x y
  | Float64   -> owl_float64_trunc l x y
  | Complex32 -> owl_complex32_trunc l x y
  | Complex64 -> owl_complex64_trunc l x y
  | _         -> failwith "_owl_trunc: unsupported operation"

external owl_float32_fix : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_fix"
external owl_float64_fix : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_fix"
external owl_complex32_fix : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_fix"
external owl_complex64_fix : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_fix"

let _owl_fix : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_fix l x y
  | Float64   -> owl_float64_fix l x y
  | Complex32 -> owl_complex32_fix l x y
  | Complex64 -> owl_complex64_fix l x y
  | _         -> failwith "_owl_fix: unsupported operation"

external owl_complex32_angle : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_angle"
external owl_complex64_angle : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_angle"

let _owl_angle : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Complex32 -> owl_complex32_angle l x y
  | Complex64 -> owl_complex64_angle l x y
  | _         -> failwith "_owl_angle: unsupported operation"

external owl_complex32_proj : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_proj"
external owl_complex64_proj : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_proj"

let _owl_proj : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Complex32 -> owl_complex32_proj l x y
  | Complex64 -> owl_complex64_proj l x y
  | _         -> failwith "_owl_proj: unsupported operation"

external owl_float32_erf : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_erf"
external owl_float64_erf : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_erf"

let _owl_erf : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_erf l x y
  | Float64   -> owl_float64_erf l x y
  | _         -> failwith "_owl_erf: unsupported operation"

external owl_float32_erfc : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_erfc"
external owl_float64_erfc : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_erfc"

let _owl_erfc : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_erfc l x y
  | Float64   -> owl_float64_erfc l x y
  | _         -> failwith "_owl_erfc: unsupported operation"

external owl_float32_logistic : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_logistic"
external owl_float64_logistic : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_logistic"

let _owl_logistic : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_logistic l x y
  | Float64   -> owl_float64_logistic l x y
  | _         -> failwith "_owl_logistic: unsupported operation"

external owl_float32_sigmoid : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_sigmoid"
external owl_float64_sigmoid : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_sigmoid"

let _owl_sigmoid : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_sigmoid l x y
  | Float64   -> owl_float64_sigmoid l x y
  | _         -> failwith "_owl_sigmoid: unsupported operation"

external owl_float32_elu : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_elu"
external owl_float64_elu : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_elu"

let _owl_elu : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_elu
  | Float64   -> owl_float64_elu
  | _         -> failwith "_owl_elu: unsupported operation"

external owl_float32_relu : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_relu"
external owl_float64_relu : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_relu"

let _owl_relu : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_relu l x y
  | Float64   -> owl_float64_relu l x y
  | _         -> failwith "_owl_relu: unsupported operation"

external owl_float32_leaky_relu : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_leaky_relu"
external owl_float64_leaky_relu : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_leaky_relu"

let _owl_leaky_relu : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_leaky_relu
  | Float64   -> owl_float64_leaky_relu
  | _         -> failwith "_owl_leaky_relu: unsupported operation"

external owl_float32_softplus : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_softplus"
external owl_float64_softplus : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_softplus"

let _owl_softplus : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_softplus l x y
  | Float64   -> owl_float64_softplus l x y
  | _         -> failwith "_owl_softplus: unsupported operation"

external owl_float32_softsign : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_softsign"
external owl_float64_softsign : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_softsign"

let _owl_softsign : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
  match k with
  | Float32   -> owl_float32_softsign l x y
  | Float64   -> owl_float64_softsign l x y
  | _         -> failwith "_owl_softsign: unsupported operation"

external owl_float32_l1norm : int -> (float, 'a) owl_arr -> float = "float32_l1norm"
external owl_float64_l1norm : int -> (float, 'a) owl_arr -> float = "float64_l1norm"
external owl_complex32_l1norm : int -> (Complex.t, 'a) owl_arr -> float = "complex32_l1norm"
external owl_complex64_l1norm : int -> (Complex.t, 'a) owl_arr -> float = "complex64_l1norm"

let _owl_l1norm : type a b. (a, b) kind -> (a, b) owl_arr_op02 = function
  | Float32   -> owl_float32_l1norm
  | Float64   -> owl_float64_l1norm
  | Complex32 -> owl_complex32_l1norm
  | Complex64 -> owl_complex64_l1norm
  | _         -> failwith "_owl_l1norm: unsupported operation"

external owl_float32_l1norm_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_l1norm_along"
external owl_float64_l1norm_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_l1norm_along"
external owl_complex32_l1norm_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_l1norm_along"
external owl_complex64_l1norm_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_l1norm_along"

let _owl_l1norm_along : type a b. (a, b) kind -> (a, b) owl_arr_op21 = function
  | Float32        -> owl_float32_l1norm_along
  | Float64        -> owl_float64_l1norm_along
  | Complex32      -> owl_complex32_l1norm_along
  | Complex64      -> owl_complex64_l1norm_along
  | _              -> failwith "_owl_l1norm_along: unsupported operation"

(* NOTE: same as sqr_nrm2, but slower *)
external owl_float32_l2norm_sqr : int -> (float, 'a) owl_arr -> float = "float32_l2norm_sqr"
external owl_float64_l2norm_sqr : int -> (float, 'a) owl_arr -> float = "float64_l2norm_sqr"
external owl_complex32_l2norm_sqr : int -> (Complex.t, 'a) owl_arr -> float = "complex32_l2norm_sqr"
external owl_complex64_l2norm_sqr : int -> (Complex.t, 'a) owl_arr -> float = "complex64_l2norm_sqr"

let _owl_l2norm_sqr : type a b. (a, b) kind -> (a, b) owl_arr_op02 = function
  | Float32   -> owl_float32_l2norm_sqr
  | Float64   -> owl_float64_l2norm_sqr
  | Complex32 -> owl_complex32_l2norm_sqr
  | Complex64 -> owl_complex64_l2norm_sqr
  | _         -> failwith "_owl_l2norm_sqr: unsupported operation"

external owl_float32_l2norm_sqr_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_l2norm_sqr_along"
external owl_float64_l2norm_sqr_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_l2norm_sqr_along"
external owl_complex32_l2norm_sqr_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_l2norm_sqr_along"
external owl_complex64_l2norm_sqr_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_l2norm_sqr_along"

let _owl_l2norm_sqr_along : type a b. (a, b) kind -> (a, b) owl_arr_op21 = function
  | Float32        -> owl_float32_l2norm_sqr_along
  | Float64        -> owl_float64_l2norm_sqr_along
  | Complex32      -> owl_complex32_l2norm_sqr_along
  | Complex64      -> owl_complex64_l2norm_sqr_along
  | _              -> failwith "_owl_l2norm_sqr_along: unsupported operation"

external owl_float32_sum : int -> ('a, 'b) owl_arr -> 'a = "float32_sum"
external owl_float64_sum : int -> ('a, 'b) owl_arr -> 'a = "float64_sum"
external owl_complex32_sum : int -> ('a, 'b) owl_arr -> 'a = "complex32_sum"
external owl_complex64_sum : int -> ('a, 'b) owl_arr -> 'a = "complex64_sum"
external owl_int8_sum : int -> ('a, 'b) owl_arr -> 'a = "int8_sum"
external owl_uint8_sum : int -> ('a, 'b) owl_arr -> 'a = "uint8_sum"
external owl_int16_sum : int -> ('a, 'b) owl_arr -> 'a = "int16_sum"
external owl_uint16_sum : int -> ('a, 'b) owl_arr -> 'a = "uint16_sum"
external owl_int32_sum : int -> ('a, 'b) owl_arr -> 'a = "int32_sum"
external owl_int64_sum : int -> ('a, 'b) owl_arr -> 'a = "int64_sum"

let _owl_sum : type a b. (a, b) kind -> (a, b) owl_arr_op04 = function
  | Float32        -> owl_float32_sum
  | Float64        -> owl_float64_sum
  | Complex32      -> owl_complex32_sum
  | Complex64      -> owl_complex64_sum
  | Int8_signed    -> owl_int8_sum
  | Int8_unsigned  -> owl_uint8_sum
  | Int16_signed   -> owl_int16_sum
  | Int16_unsigned -> owl_uint16_sum
  | Int32          -> owl_int32_sum
  | Int64          -> owl_int64_sum
  | _              -> failwith "_owl_sum: unsupported operation"

external owl_float32_sum_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_sum_along"
external owl_float64_sum_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_sum_along"
external owl_complex32_sum_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_sum_along"
external owl_complex64_sum_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_sum_along"
external owl_int8_sum_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_sum_along"
external owl_uint8_sum_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_sum_along"
external owl_int16_sum_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_sum_along"
external owl_uint16_sum_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_sum_along"
external owl_int32_sum_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_sum_along"
external owl_int64_sum_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_sum_along"

let _owl_sum_along : type a b. (a, b) kind -> (a, b) owl_arr_op21 = function
  | Float32        -> owl_float32_sum_along
  | Float64        -> owl_float64_sum_along
  | Complex32      -> owl_complex32_sum_along
  | Complex64      -> owl_complex64_sum_along
  | Int8_signed    -> owl_int8_sum_along
  | Int8_unsigned  -> owl_uint8_sum_along
  | Int16_signed   -> owl_int16_sum_along
  | Int16_unsigned -> owl_uint16_sum_along
  | Int32          -> owl_int32_sum_along
  | Int64          -> owl_int64_sum_along
  | _              -> failwith "_owl_sum_along: unsupported operation"

external owl_float32_prod : int -> ('a, 'b) owl_arr -> 'a = "float32_prod"
external owl_float64_prod : int -> ('a, 'b) owl_arr -> 'a = "float64_prod"
external owl_complex32_prod : int -> ('a, 'b) owl_arr -> 'a = "complex32_prod"
external owl_complex64_prod : int -> ('a, 'b) owl_arr -> 'a = "complex64_prod"
external owl_int8_prod : int -> ('a, 'b) owl_arr -> 'a = "int8_prod"
external owl_uint8_prod : int -> ('a, 'b) owl_arr -> 'a = "uint8_prod"
external owl_int16_prod : int -> ('a, 'b) owl_arr -> 'a = "int16_prod"
external owl_uint16_prod : int -> ('a, 'b) owl_arr -> 'a = "uint16_prod"
external owl_int32_prod : int -> ('a, 'b) owl_arr -> 'a = "int32_prod"
external owl_int64_prod : int -> ('a, 'b) owl_arr -> 'a = "int64_prod"

let _owl_prod : type a b. (a, b) kind -> (a, b) owl_arr_op04 = function
  | Float32        -> owl_float32_prod
  | Float64        -> owl_float64_prod
  | Complex32      -> owl_complex32_prod
  | Complex64      -> owl_complex64_prod
  | Int8_signed    -> owl_int8_prod
  | Int8_unsigned  -> owl_uint8_prod
  | Int16_signed   -> owl_int16_prod
  | Int16_unsigned -> owl_uint16_prod
  | Int32          -> owl_int32_prod
  | Int64          -> owl_int64_prod
  | _              -> failwith "_owl_prod: unsupported operation"

external owl_float32_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_prod_along"
external owl_float64_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_prod_along"
external owl_complex32_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_prod_along"
external owl_complex64_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_prod_along"
external owl_int8_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_prod_along"
external owl_uint8_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_prod_along"
external owl_int16_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_prod_along"
external owl_uint16_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_prod_along"
external owl_int32_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_prod_along"
external owl_int64_prod_along : int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_prod_along"

let _owl_prod_along : type a b. (a, b) kind -> (a, b) owl_arr_op21 = function
  | Float32        -> owl_float32_prod_along
  | Float64        -> owl_float64_prod_along
  | Complex32      -> owl_complex32_prod_along
  | Complex64      -> owl_complex64_prod_along
  | Int8_signed    -> owl_int8_prod_along
  | Int8_unsigned  -> owl_uint8_prod_along
  | Int16_signed   -> owl_int16_prod_along
  | Int16_unsigned -> owl_uint16_prod_along
  | Int32          -> owl_int32_prod_along
  | Int64          -> owl_int64_prod_along
  | _              -> failwith "_owl_prod_along: unsupported operation"

external owl_float32_ssqr : int -> float -> (float, 'a) owl_arr -> float = "float32_ssqr"
external owl_float64_ssqr : int -> float -> (float, 'a) owl_arr -> float = "float64_ssqr"
external owl_complex32_ssqr : int -> Complex.t -> (Complex.t, 'a) owl_arr -> Complex.t = "complex32_ssqr"
external owl_complex64_ssqr : int -> Complex.t -> (Complex.t, 'a) owl_arr -> Complex.t = "complex64_ssqr"

let _owl_ssqr : type a b. (a, b) kind -> (a, b) owl_arr_op05 = function
  | Float32   -> owl_float32_ssqr
  | Float64   -> owl_float64_ssqr
  | Complex32 -> owl_complex32_ssqr
  | Complex64 -> owl_complex64_ssqr
  | _         -> failwith "_owl_ssqr: unsupported operation"

external owl_float32_ssqr_diff : int -> (float, 'a) owl_arr -> (float, 'a) owl_arr -> float = "float32_ssqr_diff"
external owl_float64_ssqr_diff : int -> (float, 'a) owl_arr -> (float, 'a) owl_arr -> float = "float64_ssqr_diff"
external owl_complex32_ssqr_diff : int -> (Complex.t, 'a) owl_arr -> (Complex.t, 'a) owl_arr -> Complex.t = "complex32_ssqr_diff"
external owl_complex64_ssqr_diff : int -> (Complex.t, 'a) owl_arr -> (Complex.t, 'a) owl_arr -> Complex.t = "complex64_ssqr_diff"

let _owl_ssqr_diff : type a b. (a, b) kind -> (a, b) owl_arr_op06 = function
  | Float32   -> owl_float32_ssqr_diff
  | Float64   -> owl_float64_ssqr_diff
  | Complex32 -> owl_complex32_ssqr_diff
  | Complex64 -> owl_complex64_ssqr_diff
  | _         -> failwith "_owl_ssqr_diff: unsupported operation"

external owl_float32_log_sum_exp : int -> (float, 'a) owl_arr -> float = "float32_log_sum_exp"
external owl_float64_log_sum_exp : int -> (float, 'a) owl_arr -> float = "float64_log_sum_exp"

let _owl_log_sum_exp : type a b. (a, b) kind -> (a, b) owl_arr_op02 = function
  | Float32   -> owl_float32_log_sum_exp
  | Float64   -> owl_float64_log_sum_exp
  | _         -> failwith "_owl_log_sum_exp: unsupported operation"

external owl_float32_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_add"
external owl_float64_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_add"
external owl_complex32_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_add"
external owl_complex64_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_add"
external owl_int8_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_add"
external owl_uint8_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_add"
external owl_int16_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_add"
external owl_uint16_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_add"
external owl_int32_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_add"
external owl_int64_add : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_add"

let _owl_add : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_add l x y z
  | Float64        -> owl_float64_add l x y z
  | Complex32      -> owl_complex32_add l x y z
  | Complex64      -> owl_complex64_add l x y z
  | Int8_signed    -> owl_int8_add l x y z
  | Int8_unsigned  -> owl_uint8_add l x y z
  | Int16_signed   -> owl_int16_add l x y z
  | Int16_unsigned -> owl_uint16_add l x y z
  | Int32          -> owl_int32_add l x y z
  | Int64          -> owl_int64_add l x y z
  | _              -> failwith "_owl_add: unsupported operation"

external owl_float32_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_sub"
external owl_float64_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_sub"
external owl_complex32_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_sub"
external owl_complex64_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_sub"
external owl_int8_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_sub"
external owl_uint8_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_sub"
external owl_int16_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_sub"
external owl_uint16_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_sub"
external owl_int32_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_sub"
external owl_int64_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_sub"

let _owl_sub : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_sub l x y z
  | Float64        -> owl_float64_sub l x y z
  | Complex32      -> owl_complex32_sub l x y z
  | Complex64      -> owl_complex64_sub l x y z
  | Int8_signed    -> owl_int8_sub l x y z
  | Int8_unsigned  -> owl_uint8_sub l x y z
  | Int16_signed   -> owl_int16_sub l x y z
  | Int16_unsigned -> owl_uint16_sub l x y z
  | Int32          -> owl_int32_sub l x y z
  | Int64          -> owl_int64_sub l x y z
  | _              -> failwith "_owl_sub: unsupported operation"

external owl_float32_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_mul"
external owl_float64_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_mul"
external owl_complex32_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_mul"
external owl_complex64_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_mul"
external owl_int8_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_mul"
external owl_uint8_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_mul"
external owl_int16_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_mul"
external owl_uint16_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_mul"
external owl_int32_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_mul"
external owl_int64_mul : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_mul"

let _owl_mul : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_mul l x y z
  | Float64        -> owl_float64_mul l x y z
  | Complex32      -> owl_complex32_mul l x y z
  | Complex64      -> owl_complex64_mul l x y z
  | Int8_signed    -> owl_int8_mul l x y z
  | Int8_unsigned  -> owl_uint8_mul l x y z
  | Int16_signed   -> owl_int16_mul l x y z
  | Int16_unsigned -> owl_uint16_mul l x y z
  | Int32          -> owl_int32_mul l x y z
  | Int64          -> owl_int64_mul l x y z
  | _              -> failwith "_owl_mul: unsupported operation"

external owl_float32_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_div"
external owl_float64_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_div"
external owl_complex32_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_div"
external owl_complex64_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_div"
external owl_int8_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_div"
external owl_uint8_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_div"
external owl_int16_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_div"
external owl_uint16_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_div"
external owl_int32_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_div"
external owl_int64_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_div"

let _owl_div : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_div l x y z
  | Float64        -> owl_float64_div l x y z
  | Complex32      -> owl_complex32_div l x y z
  | Complex64      -> owl_complex64_div l x y z
  | Int8_signed    -> owl_int8_div l x y z
  | Int8_unsigned  -> owl_uint8_div l x y z
  | Int16_signed   -> owl_int16_div l x y z
  | Int16_unsigned -> owl_uint16_div l x y z
  | Int32          -> owl_int32_div l x y z
  | Int64          -> owl_int64_div l x y z
  | _              -> failwith "_owl_div: unsupported operation"

external owl_float32_add_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_add_scalar"
external owl_float64_add_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_add_scalar"
external owl_complex32_add_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_add_scalar"
external owl_complex64_add_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_add_scalar"
external owl_int8_add_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_add_scalar"
external owl_uint8_add_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_add_scalar"
external owl_int16_add_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_add_scalar"
external owl_uint16_add_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_add_scalar"
external owl_int32_add_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_add_scalar"
external owl_int64_add_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_add_scalar"

let _owl_add_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_add_scalar
  | Float64        -> owl_float64_add_scalar
  | Complex32      -> owl_complex32_add_scalar
  | Complex64      -> owl_complex64_add_scalar
  | Int8_signed    -> owl_int8_add_scalar
  | Int8_unsigned  -> owl_uint8_add_scalar
  | Int16_signed   -> owl_int16_add_scalar
  | Int16_unsigned -> owl_uint16_add_scalar
  | Int32          -> owl_int32_add_scalar
  | Int64          -> owl_int64_add_scalar
  | _              -> failwith "_owl_add_scalar: unsupported operation"

external owl_float32_mul_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_mul_scalar"
external owl_float64_mul_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_mul_scalar"
external owl_complex32_mul_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_mul_scalar"
external owl_complex64_mul_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_mul_scalar"
external owl_int8_mul_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_mul_scalar"
external owl_uint8_mul_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_mul_scalar"
external owl_int16_mul_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_mul_scalar"
external owl_uint16_mul_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_mul_scalar"
external owl_int32_mul_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_mul_scalar"
external owl_int64_mul_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_mul_scalar"

let _owl_mul_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_mul_scalar
  | Float64        -> owl_float64_mul_scalar
  | Complex32      -> owl_complex32_mul_scalar
  | Complex64      -> owl_complex64_mul_scalar
  | Int8_signed    -> owl_int8_mul_scalar
  | Int8_unsigned  -> owl_uint8_mul_scalar
  | Int16_signed   -> owl_int16_mul_scalar
  | Int16_unsigned -> owl_uint16_mul_scalar
  | Int32          -> owl_int32_mul_scalar
  | Int64          -> owl_int64_mul_scalar
  | _              -> failwith "_owl_mul_scalar: unsupported operation"

external owl_float32_div_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_div_scalar"
external owl_float64_div_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_div_scalar"
external owl_complex32_div_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_div_scalar"
external owl_complex64_div_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_div_scalar"
external owl_int8_div_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_div_scalar"
external owl_uint8_div_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_div_scalar"
external owl_int16_div_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_div_scalar"
external owl_uint16_div_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_div_scalar"
external owl_int32_div_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_div_scalar"
external owl_int64_div_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_div_scalar"

let _owl_div_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_div_scalar
  | Float64        -> owl_float64_div_scalar
  | Complex32      -> owl_complex32_div_scalar
  | Complex64      -> owl_complex64_div_scalar
  | Int8_signed    -> owl_int8_div_scalar
  | Int8_unsigned  -> owl_uint8_div_scalar
  | Int16_signed   -> owl_int16_div_scalar
  | Int16_unsigned -> owl_uint16_div_scalar
  | Int32          -> owl_int32_div_scalar
  | Int64          -> owl_int64_div_scalar
  | _              -> failwith "_owl_div_scalar: unsupported operation"

external owl_float32_scalar_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_scalar_sub"
external owl_float64_scalar_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_scalar_sub"
external owl_complex32_scalar_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_scalar_sub"
external owl_complex64_scalar_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_scalar_sub"
external owl_int8_scalar_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_scalar_sub"
external owl_uint8_scalar_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_scalar_sub"
external owl_int16_scalar_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_scalar_sub"
external owl_uint16_scalar_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_scalar_sub"
external owl_int32_scalar_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_scalar_sub"
external owl_int64_scalar_sub : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_scalar_sub"

let _owl_scalar_sub : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_scalar_sub
  | Float64        -> owl_float64_scalar_sub
  | Complex32      -> owl_complex32_scalar_sub
  | Complex64      -> owl_complex64_scalar_sub
  | Int8_signed    -> owl_int8_scalar_sub
  | Int8_unsigned  -> owl_uint8_scalar_sub
  | Int16_signed   -> owl_int16_scalar_sub
  | Int16_unsigned -> owl_uint16_scalar_sub
  | Int32          -> owl_int32_scalar_sub
  | Int64          -> owl_int64_scalar_sub
  | _              -> failwith "_owl_scalar_sub: unsupported operation"

external owl_float32_scalar_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_scalar_div"
external owl_float64_scalar_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_scalar_div"
external owl_complex32_scalar_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_scalar_div"
external owl_complex64_scalar_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_scalar_div"
external owl_int8_scalar_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int8_scalar_div"
external owl_uint8_scalar_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint8_scalar_div"
external owl_int16_scalar_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int16_scalar_div"
external owl_uint16_scalar_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "uint16_scalar_div"
external owl_int32_scalar_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int32_scalar_div"
external owl_int64_scalar_div : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "int64_scalar_div"

let _owl_scalar_div : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32        -> owl_float32_scalar_div
  | Float64        -> owl_float64_scalar_div
  | Complex32      -> owl_complex32_scalar_div
  | Complex64      -> owl_complex64_scalar_div
  | Int8_signed    -> owl_int8_scalar_div
  | Int8_unsigned  -> owl_uint8_scalar_div
  | Int16_signed   -> owl_int16_scalar_div
  | Int16_unsigned -> owl_uint16_scalar_div
  | Int32          -> owl_int32_scalar_div
  | Int64          -> owl_int64_scalar_div
  | _              -> failwith "_owl_scalar_div: unsupported operation"

external owl_float32_scalar_pow : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_scalar_pow"
external owl_float64_scalar_pow : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_scalar_pow"
external owl_complex32_scalar_pow : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_scalar_pow"
external owl_complex64_scalar_pow : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_scalar_pow"

let _owl_scalar_pow : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_scalar_pow
  | Float64   -> owl_float64_scalar_pow
  | Complex32 -> owl_complex32_scalar_pow
  | Complex64 -> owl_complex64_scalar_pow
  | _         -> failwith "_owl_scalar_pow: unsupported operation"

external owl_float32_pow_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_pow_scalar"
external owl_float64_pow_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_pow_scalar"
external owl_complex32_pow_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_pow_scalar"
external owl_complex64_pow_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_pow_scalar"

let _owl_pow_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_pow_scalar
  | Float64   -> owl_float64_pow_scalar
  | Complex32 -> owl_complex32_pow_scalar
  | Complex64 -> owl_complex64_pow_scalar
  | _         -> failwith "_owl_pow_scalar: unsupported operation"

external owl_float32_scalar_atan2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_scalar_atan2"
external owl_float64_scalar_atan2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_scalar_atan2"

let _owl_scalar_atan2 : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_scalar_atan2
  | Float64   -> owl_float64_scalar_atan2
  | _         -> failwith "_owl_scalar_atan2: unsupported operation"

external owl_float32_atan2_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_atan2_scalar"
external owl_float64_atan2_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_atan2_scalar"

let _owl_atan2_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_atan2_scalar
  | Float64   -> owl_float64_atan2_scalar
  | _         -> failwith "_owl_atan2_scalar: unsupported operation"

external owl_float32_pow : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_pow"
external owl_float64_pow : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_pow"
external owl_complex32_pow : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_pow"
external owl_complex64_pow : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_pow"

let _owl_pow : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_float32_pow l x y z
  | Float64   -> owl_float64_pow l x y z
  | Complex32 -> owl_complex32_pow l x y z
  | Complex64 -> owl_complex64_pow l x y z
  | _         -> failwith "_owl_pow: unsupported operation"

external owl_float32_atan2 : int -> ('a, 'b) owl_arr -> (float, 'c) owl_arr -> (float, 'c) owl_arr -> unit = "float32_atan2"
external owl_float64_atan2 : int -> ('a, 'b) owl_arr -> (float, 'c) owl_arr -> (float, 'c) owl_arr -> unit = "float64_atan2"

let _owl_atan2 : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_float32_atan2 l x y z
  | Float64   -> owl_float64_atan2 l x y z
  | _         -> failwith "_owl_atan2: unsupported operation"

external owl_float32_hypot : int -> ('a, 'b) owl_arr -> (float, 'c) owl_arr -> (float, 'c) owl_arr -> unit = "float32_hypot"
external owl_float64_hypot : int -> ('a, 'b) owl_arr -> (float, 'c) owl_arr -> (float, 'c) owl_arr -> unit = "float64_hypot"

let _owl_hypot : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_float32_hypot l x y z
  | Float64   -> owl_float64_hypot l x y z
  | _         -> failwith "_owl_hypot: unsupported operation"

external owl_float32_min2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_min2"
external owl_float64_min2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_min2"
external owl_complex32_min2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_min2"
external owl_complex64_min2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_min2"
external owl_int8_min2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_min2"
external owl_uint8_min2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_min2"
external owl_int16_min2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_min2"
external owl_uint16_min2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_min2"
external owl_int32_min2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_min2"
external owl_int64_min2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_min2"

let _owl_min2 : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_min2 l x y z
  | Float64        -> owl_float64_min2 l x y z
  | Complex32      -> owl_complex32_min2 l x y z
  | Complex64      -> owl_complex64_min2 l x y z
  | Int8_signed    -> owl_int8_min2 l x y z
  | Int8_unsigned  -> owl_uint8_min2 l x y z
  | Int16_signed   -> owl_int16_min2 l x y z
  | Int16_unsigned -> owl_uint16_min2 l x y z
  | Int32          -> owl_int32_min2 l x y z
  | Int64          -> owl_int64_min2 l x y z
  | _              -> failwith "_owl_min2: unsupported operation"

external owl_float32_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_max2"
external owl_float64_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_max2"
external owl_complex32_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_max2"
external owl_complex64_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_max2"
external owl_int8_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int8_max2"
external owl_uint8_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint8_max2"
external owl_int16_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int16_max2"
external owl_uint16_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "uint16_max2"
external owl_int32_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int32_max2"
external owl_int64_max2 : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "int64_max2"

let _owl_max2 : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32        -> owl_float32_max2 l x y z
  | Float64        -> owl_float64_max2 l x y z
  | Complex32      -> owl_complex32_max2 l x y z
  | Complex64      -> owl_complex64_max2 l x y z
  | Int8_signed    -> owl_int8_max2 l x y z
  | Int8_unsigned  -> owl_uint8_max2 l x y z
  | Int16_signed   -> owl_int16_max2 l x y z
  | Int16_unsigned -> owl_uint16_max2 l x y z
  | Int32          -> owl_int32_max2 l x y z
  | Int64          -> owl_int64_max2 l x y z
  | _              -> failwith "_owl_max2: unsupported operation"

external owl_float32_fmod : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_fmod"
external owl_float64_fmod : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_fmod"

let _owl_fmod : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_float32_fmod l x y z
  | Float64   -> owl_float64_fmod l x y z
  | _         -> failwith "_owl_fmod: unsupported operation"

external owl_float32_fmod_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_fmod_scalar"
external owl_float64_fmod_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_fmod_scalar"

let _owl_fmod_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_fmod_scalar
  | Float64   -> owl_float64_fmod_scalar
  | _         -> failwith "_owl_fmod_scalar: unsupported operation"

external owl_float32_scalar_fmod : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_scalar_fmod"
external owl_float64_scalar_fmod : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_scalar_fmod"

let _owl_scalar_fmod : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_scalar_fmod
  | Float64   -> owl_float64_scalar_fmod
  | _         -> failwith "_owl_scalar_fmod: unsupported operation"

external owl_float32_linspace : int -> float -> float -> (float, 'a) owl_arr -> unit = "float32_linspace"
external owl_float64_linspace : int -> float -> float -> (float, 'a) owl_arr -> unit = "float64_linspace"
external owl_complex32_linspace : int -> Complex.t -> Complex.t -> (Complex.t, 'a) owl_arr -> unit = "complex32_linspace"
external owl_complex64_linspace : int -> Complex.t -> Complex.t -> (Complex.t, 'a) owl_arr -> unit = "complex64_linspace"

let _owl_linspace : type a b. (a, b) kind -> (a, b) owl_arr_op07 = function
  | Float32   -> owl_float32_linspace
  | Float64   -> owl_float64_linspace
  | Complex32 -> owl_complex32_linspace
  | Complex64 -> owl_complex64_linspace
  | _         -> failwith "_owl_linspace: unsupported operation"

external owl_float32_logspace : int -> float -> float -> float -> (float, 'a) owl_arr -> unit = "float32_logspace"
external owl_float64_logspace : int -> float -> float -> float -> (float, 'a) owl_arr -> unit = "float64_logspace"
external owl_complex32_logspace : int -> float -> Complex.t -> Complex.t -> (Complex.t, 'a) owl_arr -> unit = "complex32_logspace"
external owl_complex64_logspace : int -> float -> Complex.t -> Complex.t -> (Complex.t, 'a) owl_arr -> unit = "complex64_logspace"

let _owl_logspace : type a b. (a, b) kind -> (a, b) owl_arr_op08 = function
  | Float32   -> owl_float32_logspace
  | Float64   -> owl_float64_logspace
  | Complex32 -> owl_complex32_logspace
  | Complex64 -> owl_complex64_logspace
  | _         -> failwith "_owl_logspace: unsupported operation"

external owl_complex32_conj : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "complex32_conj" "complex32_conj_impl"
external owl_complex64_conj : int -> ('a, 'b) owl_arr -> int -> int -> ('a, 'b) owl_arr -> int -> int -> unit = "complex64_conj" "complex64_conj_impl"

let _owl_conj : type a b. (a, b) kind -> (a, b) owl_arr_op18 =
  fun k n ?(ofsx=0) ?(incx=1) ?(ofsy=0) ?(incy=1) x y ->
  match k with
  | Float32   -> owl_float32_copy n x ofsx incx y ofsy incy
  | Float64   -> owl_float64_copy n x ofsx incx y ofsy incy
  | Complex32 -> owl_complex32_conj n x ofsx incx y ofsy incy
  | Complex64 -> owl_complex64_conj n x ofsx incx y ofsy incy
  | _         -> failwith "_owl_conj: unsupported operation"

external _owl_re_c2s : int -> (Complex.t, complex32_elt) owl_arr -> (float, float32_elt) owl_arr -> unit = "re_c2s"
external _owl_re_z2d : int -> (Complex.t, complex64_elt) owl_arr -> (float, float64_elt) owl_arr -> unit = "re_z2d"
external _owl_im_c2s : int -> (Complex.t, complex32_elt) owl_arr -> (float, float32_elt) owl_arr -> unit = "im_c2s"
external _owl_im_z2d : int -> (Complex.t, complex64_elt) owl_arr -> (float, float64_elt) owl_arr -> unit = "im_z2d"

external _owl_cast_s2d : int -> (float, float32_elt) owl_arr -> (float, float64_elt) owl_arr -> unit = "cast_s2d"
external _owl_cast_d2s : int -> (float, float64_elt) owl_arr -> (float, float32_elt) owl_arr -> unit = "cast_d2s"
external _owl_cast_c2z : int -> (Complex.t, complex32_elt) owl_arr -> (Complex.t, complex64_elt) owl_arr -> unit = "cast_c2z"
external _owl_cast_z2c : int -> (Complex.t, complex64_elt) owl_arr -> (Complex.t, complex32_elt) owl_arr -> unit = "cast_z2c"
external _owl_cast_s2c : int -> (float, float32_elt) owl_arr -> (Complex.t, complex32_elt) owl_arr -> unit = "cast_s2c"
external _owl_cast_d2z : int -> (float, float64_elt) owl_arr -> (Complex.t, complex64_elt) owl_arr -> unit = "cast_d2z"
external _owl_cast_s2z : int -> (float, float32_elt) owl_arr -> (Complex.t, complex64_elt) owl_arr -> unit = "cast_s2z"
external _owl_cast_d2c : int -> (float, float64_elt) owl_arr -> (Complex.t, complex32_elt) owl_arr -> unit = "cast_d2c"

external owl_float32_bernoulli : int -> ('a, 'b) owl_arr -> float -> int -> unit = "float32_bernoulli"
external owl_float64_bernoulli : int -> ('a, 'b) owl_arr -> float -> int -> unit = "float64_bernoulli"
external owl_complex32_bernoulli : int -> ('a, 'b) owl_arr -> float -> int -> unit = "complex32_bernoulli"
external owl_complex64_bernoulli : int -> ('a, 'b) owl_arr -> float -> int -> unit = "complex64_bernoulli"
external owl_int8_bernoulli : int -> ('a, 'b) owl_arr -> float -> int -> unit = "int8_bernoulli"
external owl_uint8_bernoulli : int -> ('a, 'b) owl_arr -> float -> int -> unit = "uint8_bernoulli"
external owl_int16_bernoulli : int -> ('a, 'b) owl_arr -> float -> int -> unit = "int16_bernoulli"
external owl_uint16_bernoulli : int -> ('a, 'b) owl_arr -> float -> int -> unit = "uint16_bernoulli"
external owl_int32_bernoulli : int -> ('a, 'b) owl_arr -> float -> int -> unit = "int32_bernoulli"
external owl_int64_bernoulli : int -> ('a, 'b) owl_arr -> float -> int -> unit = "int64_bernoulli"

let _owl_bernoulli : type a b. (a, b) kind -> (a, b) owl_arr_op12 = function
  | Float32        -> owl_float32_bernoulli
  | Float64        -> owl_float64_bernoulli
  | Complex32      -> owl_complex32_bernoulli
  | Complex64      -> owl_complex64_bernoulli
  | Int8_signed    -> owl_int8_bernoulli
  | Int8_unsigned  -> owl_uint8_bernoulli
  | Int16_signed   -> owl_int16_bernoulli
  | Int16_unsigned -> owl_uint16_bernoulli
  | Int32          -> owl_int32_bernoulli
  | Int64          -> owl_int64_bernoulli
  | _              -> failwith "_owl_bernoulli: unsupported operation"

external owl_float32_dropout : int -> ('a, 'b) owl_arr -> float -> int -> unit = "float32_dropout"
external owl_float64_dropout : int -> ('a, 'b) owl_arr -> float -> int -> unit = "float64_dropout"
external owl_complex32_dropout : int -> ('a, 'b) owl_arr -> float -> int -> unit = "complex32_dropout"
external owl_complex64_dropout : int -> ('a, 'b) owl_arr -> float -> int -> unit = "complex64_dropout"
external owl_int8_dropout : int -> ('a, 'b) owl_arr -> float -> int -> unit = "int8_dropout"
external owl_uint8_dropout : int -> ('a, 'b) owl_arr -> float -> int -> unit = "uint8_dropout"
external owl_int16_dropout : int -> ('a, 'b) owl_arr -> float -> int -> unit = "int16_dropout"
external owl_uint16_dropout : int -> ('a, 'b) owl_arr -> float -> int -> unit = "uint16_dropout"
external owl_int32_dropout : int -> ('a, 'b) owl_arr -> float -> int -> unit = "int32_dropout"
external owl_int64_dropout : int -> ('a, 'b) owl_arr -> float -> int -> unit = "int64_dropout"

let _owl_dropout : type a b. (a, b) kind -> (a, b) owl_arr_op12 = function
  | Float32        -> owl_float32_dropout
  | Float64        -> owl_float64_dropout
  | Complex32      -> owl_complex32_dropout
  | Complex64      -> owl_complex64_dropout
  | Int8_signed    -> owl_int8_dropout
  | Int8_unsigned  -> owl_uint8_dropout
  | Int16_signed   -> owl_int16_dropout
  | Int16_unsigned -> owl_uint16_dropout
  | Int32          -> owl_int32_dropout
  | Int64          -> owl_int64_dropout
  | _              -> failwith "_owl_dropout: unsupported operation"

external owl_float32_sequential : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "float32_sequential"
external owl_float64_sequential : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "float64_sequential"
external owl_complex32_sequential : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "complex32_sequential"
external owl_complex64_sequential : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "complex64_sequential"
external owl_int8_sequential : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "int8_sequential"
external owl_uint8_sequential : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "uint8_sequential"
external owl_int16_sequential : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "int16_sequential"
external owl_uint16_sequential : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "uint16_sequential"
external owl_int32_sequential : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "int32_sequential"
external owl_int64_sequential : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "int64_sequential"

let _owl_sequential : type a b. (a, b) kind -> (a, b) owl_arr_op13 = function
  | Float32        -> owl_float32_sequential
  | Float64        -> owl_float64_sequential
  | Complex32      -> owl_complex32_sequential
  | Complex64      -> owl_complex64_sequential
  | Int8_signed    -> owl_int8_sequential
  | Int8_unsigned  -> owl_uint8_sequential
  | Int16_signed   -> owl_int16_sequential
  | Int16_unsigned -> owl_uint16_sequential
  | Int32          -> owl_int32_sequential
  | Int64          -> owl_int64_sequential
  | _              -> failwith "_owl_sequential: unsupported operation"

external owl_float32_uniform : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "float32_uniform"
external owl_float64_uniform : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "float64_uniform"
external owl_complex32_uniform : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "complex32_uniform"
external owl_complex64_uniform : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "complex64_uniform"

let _owl_uniform : type a b. (a, b) kind -> (a, b) owl_arr_op13 = function
  | Float32        -> owl_float32_uniform
  | Float64        -> owl_float64_uniform
  | Complex32      -> owl_complex32_uniform
  | Complex64      -> owl_complex64_uniform
  | _              -> failwith "_owl_uniform: unsupported operation"

external owl_float32_gaussian : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "float32_gaussian"
external owl_float64_gaussian : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "float64_gaussian"
external owl_complex32_gaussian : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "complex32_gaussian"
external owl_complex64_gaussian : int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit = "complex64_gaussian"

let _owl_gaussian : type a b. (a, b) kind -> (a, b) owl_arr_op13 = function
  | Float32        -> owl_float32_gaussian
  | Float64        -> owl_float64_gaussian
  | Complex32      -> owl_complex32_gaussian
  | Complex64      -> owl_complex64_gaussian
  | _              -> failwith "_owl_gaussian: unsupported operation"

external owl_float32_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "float32_cumsum" "float32_cumsum_impl"
external owl_float64_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "float64_cumsum" "float64_cumsum_impl"
external owl_complex32_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "complex32_cumsum" "complex32_cumsum_impl"
external owl_complex64_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "complex64_cumsum" "complex64_cumsum_impl"
external owl_int8_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int8_cumsum" "int8_cumsum_impl"
external owl_uint8_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "uint8_cumsum" "uint8_cumsum_impl"
external owl_int16_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int16_cumsum" "int16_cumsum_impl"
external owl_uint16_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "uint16_cumsum" "uint16_cumsum_impl"
external owl_int32_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int32_cumsum" "int32_cumsum_impl"
external owl_int64_cumsum : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int64_cumsum" "int64_cumsum_impl"

let _owl_cumsum : type a b. (a, b) kind -> (a, b) owl_arr_op14 = function
  | Float32        -> owl_float32_cumsum
  | Float64        -> owl_float64_cumsum
  | Complex32      -> owl_complex32_cumsum
  | Complex64      -> owl_complex64_cumsum
  | Int8_signed    -> owl_int8_cumsum
  | Int8_unsigned  -> owl_uint8_cumsum
  | Int16_signed   -> owl_int16_cumsum
  | Int16_unsigned -> owl_uint16_cumsum
  | Int32          -> owl_int32_cumsum
  | Int64          -> owl_int64_cumsum
  | _              -> failwith "_owl_cumsum: unsupported operation"

external owl_float32_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "float32_cumprod" "float32_cumprod_impl"
external owl_float64_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "float64_cumprod" "float64_cumprod_impl"
external owl_complex32_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "complex32_cumprod" "complex32_cumprod_impl"
external owl_complex64_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "complex64_cumprod" "complex64_cumprod_impl"
external owl_int8_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int8_cumprod" "int8_cumprod_impl"
external owl_uint8_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "uint8_cumprod" "uint8_cumprod_impl"
external owl_int16_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int16_cumprod" "int16_cumprod_impl"
external owl_uint16_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "uint16_cumprod" "uint16_cumprod_impl"
external owl_int32_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int32_cumprod" "int32_cumprod_impl"
external owl_int64_cumprod : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int64_cumprod" "int64_cumprod_impl"

let _owl_cumprod : type a b. (a, b) kind -> (a, b) owl_arr_op14 = function
  | Float32        -> owl_float32_cumprod
  | Float64        -> owl_float64_cumprod
  | Complex32      -> owl_complex32_cumprod
  | Complex64      -> owl_complex64_cumprod
  | Int8_signed    -> owl_int8_cumprod
  | Int8_unsigned  -> owl_uint8_cumprod
  | Int16_signed   -> owl_int16_cumprod
  | Int16_unsigned -> owl_uint16_cumprod
  | Int32          -> owl_int32_cumprod
  | Int64          -> owl_int64_cumprod
  | _              -> failwith "_owl_cumprod: unsupported operation"

external owl_float32_cummin : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "float32_cummin" "float32_cummin_impl"
external owl_float64_cummin : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "float64_cummin" "float64_cummin_impl"
external owl_complex32_cummin : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "complex32_cummin" "complex32_cummin_impl"
external owl_complex64_cummin : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "complex64_cummin" "complex64_cummin_impl"
external owl_int8_cummin : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int8_cummin" "int8_cummin_impl"
external owl_uint8_cummin : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "uint8_cummin" "uint8_cummin_impl"
external owl_int16_cummin : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int16_cummin" "int16_cummin_impl"
external owl_uint16_cummin : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "uint16_cummin" "uint16_cummin_impl"
external owl_int32_cummin : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int32_cummin" "int32_cummin_impl"
external owl_int64_cummin : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int64_cummin" "int64_cummin_impl"

let _owl_cummin : type a b. (a, b) kind -> (a, b) owl_arr_op14 = function
  | Float32        -> owl_float32_cummin
  | Float64        -> owl_float64_cummin
  | Complex32      -> owl_complex32_cummin
  | Complex64      -> owl_complex64_cummin
  | Int8_signed    -> owl_int8_cummin
  | Int8_unsigned  -> owl_uint8_cummin
  | Int16_signed   -> owl_int16_cummin
  | Int16_unsigned -> owl_uint16_cummin
  | Int32          -> owl_int32_cummin
  | Int64          -> owl_int64_cummin
  | _              -> failwith "_owl_cummin: unsupported operation"

external owl_float32_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "float32_cummax" "float32_cummax_impl"
external owl_float64_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "float64_cummax" "float64_cummax_impl"
external owl_complex32_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "complex32_cummax" "complex32_cummax_impl"
external owl_complex64_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "complex64_cummax" "complex64_cummax_impl"
external owl_int8_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int8_cummax" "int8_cummax_impl"
external owl_uint8_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "uint8_cummax" "uint8_cummax_impl"
external owl_int16_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int16_cummax" "int16_cummax_impl"
external owl_uint16_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "uint16_cummax" "uint16_cummax_impl"
external owl_int32_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int32_cummax" "int32_cummax_impl"
external owl_int64_cummax : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int64_cummax" "int64_cummax_impl"

let _owl_cummax : type a b. (a, b) kind -> (a, b) owl_arr_op14 = function
  | Float32        -> owl_float32_cummax
  | Float64        -> owl_float64_cummax
  | Complex32      -> owl_complex32_cummax
  | Complex64      -> owl_complex64_cummax
  | Int8_signed    -> owl_int8_cummax
  | Int8_unsigned  -> owl_uint8_cummax
  | Int16_signed   -> owl_int16_cummax
  | Int16_unsigned -> owl_uint16_cummax
  | Int32          -> owl_int32_cummax
  | Int64          -> owl_int64_cummax
  | _              -> failwith "_owl_cummax: unsupported operation"

external owl_float32_modf : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_modf"
external owl_float64_modf : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_modf"
external owl_complex32_modf : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_modf"
external owl_complex64_modf : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_modf"

let _owl_modf : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_modf
  | Float64   -> owl_float64_modf
  | Complex32 -> owl_complex32_modf
  | Complex64 -> owl_complex64_modf
  | _         -> failwith "_owl_modf: unsupported operation"

external owl_float32_approx_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> float -> int = "float32_approx_equal"
external owl_float64_approx_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> float -> int = "float64_approx_equal"
external owl_complex32_approx_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> float -> int = "complex32_approx_equal"
external owl_complex64_approx_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> float -> int = "complex64_approx_equal"

let _owl_approx_equal : type a b. (a, b) kind -> (a, b) owl_arr_op15 = function
  | Float32   -> owl_float32_approx_equal
  | Float64   -> owl_float64_approx_equal
  | Complex32 -> owl_complex32_approx_equal
  | Complex64 -> owl_complex64_approx_equal
  | _         -> failwith "_owl_approx_equal: unsupported operation"

external owl_float32_approx_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> float -> int = "float32_approx_equal_scalar"
external owl_float64_approx_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> float -> int = "float64_approx_equal_scalar"
external owl_complex32_approx_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> float -> int = "complex32_approx_equal_scalar"
external owl_complex64_approx_equal_scalar : int -> ('a, 'b) owl_arr -> 'a -> float -> int = "complex64_approx_equal_scalar"

let _owl_approx_equal_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op16 = function
  | Float32   -> owl_float32_approx_equal_scalar
  | Float64   -> owl_float64_approx_equal_scalar
  | Complex32 -> owl_complex32_approx_equal_scalar
  | Complex64 -> owl_complex64_approx_equal_scalar
  | _         -> failwith "_owl_approx_equal_scalar: unsupported operation"

external owl_float32_approx_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_approx_elt_equal"
external owl_float64_approx_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float64_approx_elt_equal"
external owl_complex32_approx_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex32_approx_elt_equal"
external owl_complex64_approx_elt_equal : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "complex64_approx_elt_equal"

let _owl_approx_elt_equal : type a b. (a, b) kind -> (a, b) owl_arr_op03 = fun k l x y z ->
  match k with
  | Float32   -> owl_float32_approx_elt_equal l x y z
  | Float64   -> owl_float64_approx_elt_equal l x y z
  | Complex32 -> owl_complex32_approx_elt_equal l x y z
  | Complex64 -> owl_complex64_approx_elt_equal l x y z
  | _         -> failwith "_owl_approx_elt_equal: unsupported operation"

external owl_float32_approx_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float32_approx_elt_equal_scalar"
external owl_float64_approx_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "float64_approx_elt_equal_scalar"
external owl_complex32_approx_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex32_approx_elt_equal_scalar"
external owl_complex64_approx_elt_equal_scalar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit = "complex64_approx_elt_equal_scalar"

let _owl_approx_elt_equal_scalar : type a b. (a, b) kind -> (a, b) owl_arr_op11 = function
  | Float32   -> owl_float32_approx_elt_equal_scalar
  | Float64   -> owl_float64_approx_elt_equal_scalar
  | Complex32 -> owl_complex32_approx_elt_equal_scalar
  | Complex64 -> owl_complex64_approx_elt_equal_scalar
  | _         -> failwith "_owl_approx_elt_equal_scalar: unsupported operation"

external owl_float32_to_complex : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('c, 'd) owl_arr -> unit = "float32_to_complex"
external owl_float64_to_complex : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('c, 'd) owl_arr -> unit = "float64_to_complex"
external owl_complex32_to_complex : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('c, 'd) owl_arr -> unit = "complex32_to_complex"
external owl_complex64_to_complex : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('c, 'd) owl_arr -> unit = "complex64_to_complex"

let _owl_to_complex : type a b c d. (a, b) kind -> (c, d) kind -> (a, b, c, d) owl_arr_op19 =
  fun real_kind complex_kind l x y z ->
  match real_kind with
  | Float32   -> owl_float32_to_complex l x y z
  | Float64   -> owl_float64_to_complex l x y z
  | Complex32 -> owl_complex32_to_complex l x y z
  | Complex64 -> owl_complex64_to_complex l x y z
  | _         -> failwith "_owl_to_complex: unsupported operation"

external owl_float32_polar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('c, 'd) owl_arr -> unit = "float32_polar"
external owl_float64_polar : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('c, 'd) owl_arr -> unit = "float64_polar"

let _owl_polar : type a b c d. (a, b) kind -> (c, d) kind -> (a, b, c, d) owl_arr_op19 =
  fun real_kind complex_kind l x y z ->
  match real_kind with
  | Float32   -> owl_float32_polar l x y z
  | Float64   -> owl_float64_polar l x y z
  | _         -> failwith "_owl_polar: unsupported operation"

external owl_float32_clip_by_value : int -> float -> float -> (float, 'a) owl_arr -> unit = "float32_clip_by_value"
external owl_float64_clip_by_value : int -> float -> float -> (float, 'a) owl_arr -> unit = "float64_clip_by_value"
external owl_complex32_clip_by_value : int -> Complex.t -> Complex.t -> (Complex.t, 'a) owl_arr -> unit = "complex32_clip_by_value"
external owl_complex64_clip_by_value : int -> Complex.t -> Complex.t -> (Complex.t, 'a) owl_arr -> unit = "complex64_clip_by_value"

let _owl_clip_by_value : type a b. (a, b) kind -> (a, b) owl_arr_op07 = function
  | Float32   -> owl_float32_clip_by_value
  | Float64   -> owl_float64_clip_by_value
  | Complex32 -> owl_complex32_clip_by_value
  | Complex64 -> owl_complex64_clip_by_value
  | _         -> failwith "_owl_clip_by_value: unsupported operation"

external owl_float32_sort : int -> ('a, 'b) owl_arr -> unit = "float32_sort"
external owl_float64_sort : int -> ('a, 'b) owl_arr -> unit = "float64_sort"
external owl_complex32_sort : int -> ('a, 'b) owl_arr -> unit = "complex32_sort"
external owl_complex64_sort : int -> ('a, 'b) owl_arr -> unit = "complex64_sort"
external owl_int8_sort : int -> ('a, 'b) owl_arr -> unit = "int8_sort"
external owl_uint8_sort : int -> ('a, 'b) owl_arr -> unit = "uint8_sort"
external owl_int16_sort : int -> ('a, 'b) owl_arr -> unit = "int16_sort"
external owl_uint16_sort : int -> ('a, 'b) owl_arr -> unit = "uint16_sort"
external owl_int32_sort : int -> ('a, 'b) owl_arr -> unit = "int32_sort"
external owl_int64_sort : int -> ('a, 'b) owl_arr -> unit = "int64_sort"

let _owl_sort : type a b. (a, b) kind -> int -> (a, b) owl_arr -> unit = function
  | Float32        -> owl_float32_sort
  | Float64        -> owl_float64_sort
  | Complex32      -> owl_complex32_sort
  | Complex64      -> owl_complex64_sort
  | Int8_signed    -> owl_int8_sort
  | Int8_unsigned  -> owl_uint8_sort
  | Int16_signed   -> owl_int16_sort
  | Int16_unsigned -> owl_uint16_sort
  | Int32          -> owl_int32_sort
  | Int64          -> owl_int64_sort
  | _              -> failwith "_owl_sort: unsupported operation"

external owl_float32_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "float32_repeat" "float32_repeat_impl"
external owl_float64_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "float64_repeat" "float64_repeat_impl"
external owl_complex32_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "complex32_repeat" "complex32_repeat_impl"
external owl_complex64_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "complex64_repeat" "complex64_repeat_impl"
external owl_int8_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int8_repeat" "int8_repeat_impl"
external owl_uint8_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "uint8_repeat" "uint8_repeat_impl"
external owl_int16_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int16_repeat" "int16_repeat_impl"
external owl_uint16_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "uint16_repeat" "uint16_repeat_impl"
external owl_int32_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int32_repeat" "int32_repeat_impl"
external owl_int64_repeat : int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit = "int64_repeat" "int64_repeat_impl"

let _owl_repeat : type a b. (a, b) kind -> (a, b) owl_arr_op14 = function
  | Float32        -> owl_float32_repeat
  | Float64        -> owl_float64_repeat
  | Complex32      -> owl_complex32_repeat
  | Complex64      -> owl_complex64_repeat
  | Int8_signed    -> owl_int8_repeat
  | Int8_unsigned  -> owl_uint8_repeat
  | Int16_signed   -> owl_int16_repeat
  | Int16_unsigned -> owl_uint16_repeat
  | Int32          -> owl_int32_repeat
  | Int64          -> owl_int64_repeat
  | _              -> failwith "_owl_repeat: unsupported operation"

external owl_float32_broadcast_add : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_add" "float32_broadcast_add_impl"
external owl_float64_broadcast_add : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_add" "float64_broadcast_add_impl"
external owl_complex32_broadcast_add : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_add" "complex64_broadcast_add_impl"
external owl_complex64_broadcast_add : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_add" "complex64_broadcast_add_impl"
external owl_int8_broadcast_add : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_add" "int8_broadcast_add_impl"
external owl_uint8_broadcast_add : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_add" "uint8_broadcast_add_impl"
external owl_int16_broadcast_add : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_add" "int16_broadcast_add_impl"
external owl_uint16_broadcast_add : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_add" "uint16_broadcast_add_impl"
external owl_int32_broadcast_add : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_add" "int32_broadcast_add_impl"
external owl_int64_broadcast_add : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_add" "int64_broadcast_add_impl"

let _owl_broadcast_add : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_add
  | Float64        -> owl_float64_broadcast_add
  | Complex32      -> owl_complex32_broadcast_add
  | Complex64      -> owl_complex64_broadcast_add
  | Int8_signed    -> owl_int8_broadcast_add
  | Int8_unsigned  -> owl_uint8_broadcast_add
  | Int16_signed   -> owl_int16_broadcast_add
  | Int16_unsigned -> owl_uint16_broadcast_add
  | Int32          -> owl_int32_broadcast_add
  | Int64          -> owl_int64_broadcast_add
  | _              -> failwith "_owl_broadcast_add: unsupported operation"

external owl_float32_broadcast_sub : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_sub" "float32_broadcast_sub_impl"
external owl_float64_broadcast_sub : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_sub" "float64_broadcast_sub_impl"
external owl_complex32_broadcast_sub : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_sub" "complex64_broadcast_sub_impl"
external owl_complex64_broadcast_sub : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_sub" "complex64_broadcast_sub_impl"
external owl_int8_broadcast_sub : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_sub" "int8_broadcast_sub_impl"
external owl_uint8_broadcast_sub : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_sub" "uint8_broadcast_sub_impl"
external owl_int16_broadcast_sub : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_sub" "int16_broadcast_sub_impl"
external owl_uint16_broadcast_sub : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_sub" "uint16_broadcast_sub_impl"
external owl_int32_broadcast_sub : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_sub" "int32_broadcast_sub_impl"
external owl_int64_broadcast_sub : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_sub" "int64_broadcast_sub_impl"

let _owl_broadcast_sub : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_sub
  | Float64        -> owl_float64_broadcast_sub
  | Complex32      -> owl_complex32_broadcast_sub
  | Complex64      -> owl_complex64_broadcast_sub
  | Int8_signed    -> owl_int8_broadcast_sub
  | Int8_unsigned  -> owl_uint8_broadcast_sub
  | Int16_signed   -> owl_int16_broadcast_sub
  | Int16_unsigned -> owl_uint16_broadcast_sub
  | Int32          -> owl_int32_broadcast_sub
  | Int64          -> owl_int64_broadcast_sub
  | _              -> failwith "_owl_broadcast_sub: unsupported operation"

external owl_float32_broadcast_mul : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_mul" "float32_broadcast_mul_impl"
external owl_float64_broadcast_mul : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_mul" "float64_broadcast_mul_impl"
external owl_complex32_broadcast_mul : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_mul" "complex64_broadcast_mul_impl"
external owl_complex64_broadcast_mul : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_mul" "complex64_broadcast_mul_impl"
external owl_int8_broadcast_mul : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_mul" "int8_broadcast_mul_impl"
external owl_uint8_broadcast_mul : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_mul" "uint8_broadcast_mul_impl"
external owl_int16_broadcast_mul : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_mul" "int16_broadcast_mul_impl"
external owl_uint16_broadcast_mul : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_mul" "uint16_broadcast_mul_impl"
external owl_int32_broadcast_mul : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_mul" "int32_broadcast_mul_impl"
external owl_int64_broadcast_mul : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_mul" "int64_broadcast_mul_impl"

let _owl_broadcast_mul : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_mul
  | Float64        -> owl_float64_broadcast_mul
  | Complex32      -> owl_complex32_broadcast_mul
  | Complex64      -> owl_complex64_broadcast_mul
  | Int8_signed    -> owl_int8_broadcast_mul
  | Int8_unsigned  -> owl_uint8_broadcast_mul
  | Int16_signed   -> owl_int16_broadcast_mul
  | Int16_unsigned -> owl_uint16_broadcast_mul
  | Int32          -> owl_int32_broadcast_mul
  | Int64          -> owl_int64_broadcast_mul
  | _              -> failwith "_owl_broadcast_mul: unsupported operation"

external owl_float32_broadcast_div : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_div" "float32_broadcast_div_impl"
external owl_float64_broadcast_div : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_div" "float64_broadcast_div_impl"
external owl_complex32_broadcast_div : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_div" "complex64_broadcast_div_impl"
external owl_complex64_broadcast_div : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_div" "complex64_broadcast_div_impl"
external owl_int8_broadcast_div : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_div" "int8_broadcast_div_impl"
external owl_uint8_broadcast_div : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_div" "uint8_broadcast_div_impl"
external owl_int16_broadcast_div : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_div" "int16_broadcast_div_impl"
external owl_uint16_broadcast_div : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_div" "uint16_broadcast_div_impl"
external owl_int32_broadcast_div : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_div" "int32_broadcast_div_impl"
external owl_int64_broadcast_div : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_div" "int64_broadcast_div_impl"

let _owl_broadcast_div : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_div
  | Float64        -> owl_float64_broadcast_div
  | Complex32      -> owl_complex32_broadcast_div
  | Complex64      -> owl_complex64_broadcast_div
  | Int8_signed    -> owl_int8_broadcast_div
  | Int8_unsigned  -> owl_uint8_broadcast_div
  | Int16_signed   -> owl_int16_broadcast_div
  | Int16_unsigned -> owl_uint16_broadcast_div
  | Int32          -> owl_int32_broadcast_div
  | Int64          -> owl_int64_broadcast_div
  | _              -> failwith "_owl_broadcast_div: unsupported operation"

external owl_float32_broadcast_min2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_min2" "float32_broadcast_min2_impl"
external owl_float64_broadcast_min2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_min2" "float64_broadcast_min2_impl"
external owl_complex32_broadcast_min2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_min2" "complex64_broadcast_min2_impl"
external owl_complex64_broadcast_min2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_min2" "complex64_broadcast_min2_impl"
external owl_int8_broadcast_min2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_min2" "int8_broadcast_min2_impl"
external owl_uint8_broadcast_min2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_min2" "uint8_broadcast_min2_impl"
external owl_int16_broadcast_min2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_min2" "int16_broadcast_min2_impl"
external owl_uint16_broadcast_min2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_min2" "uint16_broadcast_min2_impl"
external owl_int32_broadcast_min2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_min2" "int32_broadcast_min2_impl"
external owl_int64_broadcast_min2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_min2" "int64_broadcast_min2_impl"

let _owl_broadcast_min2 : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_min2
  | Float64        -> owl_float64_broadcast_min2
  | Complex32      -> owl_complex32_broadcast_min2
  | Complex64      -> owl_complex64_broadcast_min2
  | Int8_signed    -> owl_int8_broadcast_min2
  | Int8_unsigned  -> owl_uint8_broadcast_min2
  | Int16_signed   -> owl_int16_broadcast_min2
  | Int16_unsigned -> owl_uint16_broadcast_min2
  | Int32          -> owl_int32_broadcast_min2
  | Int64          -> owl_int64_broadcast_min2
  | _              -> failwith "_owl_broadcast_min2: unsupported operation"

external owl_float32_broadcast_max2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_max2" "float32_broadcast_max2_impl"
external owl_float64_broadcast_max2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_max2" "float64_broadcast_max2_impl"
external owl_complex32_broadcast_max2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_max2" "complex64_broadcast_max2_impl"
external owl_complex64_broadcast_max2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_max2" "complex64_broadcast_max2_impl"
external owl_int8_broadcast_max2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_max2" "int8_broadcast_max2_impl"
external owl_uint8_broadcast_max2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_max2" "uint8_broadcast_max2_impl"
external owl_int16_broadcast_max2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_max2" "int16_broadcast_max2_impl"
external owl_uint16_broadcast_max2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_max2" "uint16_broadcast_max2_impl"
external owl_int32_broadcast_max2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_max2" "int32_broadcast_max2_impl"
external owl_int64_broadcast_max2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_max2" "int64_broadcast_max2_impl"

let _owl_broadcast_max2 : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_max2
  | Float64        -> owl_float64_broadcast_max2
  | Complex32      -> owl_complex32_broadcast_max2
  | Complex64      -> owl_complex64_broadcast_max2
  | Int8_signed    -> owl_int8_broadcast_max2
  | Int8_unsigned  -> owl_uint8_broadcast_max2
  | Int16_signed   -> owl_int16_broadcast_max2
  | Int16_unsigned -> owl_uint16_broadcast_max2
  | Int32          -> owl_int32_broadcast_max2
  | Int64          -> owl_int64_broadcast_max2
  | _              -> failwith "_owl_broadcast_max2: unsupported operation"

external owl_float32_broadcast_pow : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_pow" "float32_broadcast_pow_impl"
external owl_float64_broadcast_pow : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_pow" "float64_broadcast_pow_impl"
external owl_complex32_broadcast_pow : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_pow" "complex64_broadcast_pow_impl"
external owl_complex64_broadcast_pow : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_pow" "complex64_broadcast_pow_impl"

let _owl_broadcast_pow : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32   -> owl_float32_broadcast_pow
  | Float64   -> owl_float64_broadcast_pow
  | Complex32 -> owl_complex32_broadcast_pow
  | Complex64 -> owl_complex64_broadcast_pow
  | _         -> failwith "_owl_broadcast_pow: unsupported operation"

external owl_float32_broadcast_atan2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_atan2" "float32_broadcast_atan2_impl"
external owl_float64_broadcast_atan2 : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_atan2" "float64_broadcast_atan2_impl"

let _owl_broadcast_atan2 : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32   -> owl_float32_broadcast_atan2
  | Float64   -> owl_float64_broadcast_atan2
  | _         -> failwith "_owl_broadcast_atan2: unsupported operation"

external owl_float32_broadcast_hypot : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_hypot" "float32_broadcast_hypot_impl"
external owl_float64_broadcast_hypot : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_hypot" "float64_broadcast_hypot_impl"

let _owl_broadcast_hypot : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32   -> owl_float32_broadcast_hypot
  | Float64   -> owl_float64_broadcast_hypot
  | _         -> failwith "_owl_broadcast_hypot: unsupported operation"

external owl_float32_broadcast_fmod : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_fmod" "float32_broadcast_fmod_impl"
external owl_float64_broadcast_fmod : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_fmod" "float64_broadcast_fmod_impl"

let _owl_broadcast_fmod : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32   -> owl_float32_broadcast_fmod
  | Float64   -> owl_float64_broadcast_fmod
  | _         -> failwith "_owl_broadcast_fmod: unsupported operation"

external owl_float32_broadcast_elt_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_elt_equal" "float32_broadcast_elt_equal_impl"
external owl_float64_broadcast_elt_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_elt_equal" "float64_broadcast_elt_equal_impl"
external owl_complex32_broadcast_elt_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_elt_equal" "complex64_broadcast_elt_equal_impl"
external owl_complex64_broadcast_elt_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_elt_equal" "complex64_broadcast_elt_equal_impl"
external owl_int8_broadcast_elt_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_elt_equal" "int8_broadcast_elt_equal_impl"
external owl_uint8_broadcast_elt_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_elt_equal" "uint8_broadcast_elt_equal_impl"
external owl_int16_broadcast_elt_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_elt_equal" "int16_broadcast_elt_equal_impl"
external owl_uint16_broadcast_elt_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_elt_equal" "uint16_broadcast_elt_equal_impl"
external owl_int32_broadcast_elt_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_elt_equal" "int32_broadcast_elt_equal_impl"
external owl_int64_broadcast_elt_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_elt_equal" "int64_broadcast_elt_equal_impl"

let _owl_broadcast_elt_equal : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_elt_equal
  | Float64        -> owl_float64_broadcast_elt_equal
  | Complex32      -> owl_complex32_broadcast_elt_equal
  | Complex64      -> owl_complex64_broadcast_elt_equal
  | Int8_signed    -> owl_int8_broadcast_elt_equal
  | Int8_unsigned  -> owl_uint8_broadcast_elt_equal
  | Int16_signed   -> owl_int16_broadcast_elt_equal
  | Int16_unsigned -> owl_uint16_broadcast_elt_equal
  | Int32          -> owl_int32_broadcast_elt_equal
  | Int64          -> owl_int64_broadcast_elt_equal
  | _              -> failwith "_owl_broadcast_elt_equal: unsupported operation"

external owl_float32_broadcast_elt_not_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_elt_not_equal" "float32_broadcast_elt_not_equal_impl"
external owl_float64_broadcast_elt_not_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_elt_not_equal" "float64_broadcast_elt_not_equal_impl"
external owl_complex32_broadcast_elt_not_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_elt_not_equal" "complex64_broadcast_elt_not_equal_impl"
external owl_complex64_broadcast_elt_not_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_elt_not_equal" "complex64_broadcast_elt_not_equal_impl"
external owl_int8_broadcast_elt_not_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_elt_not_equal" "int8_broadcast_elt_not_equal_impl"
external owl_uint8_broadcast_elt_not_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_elt_not_equal" "uint8_broadcast_elt_not_equal_impl"
external owl_int16_broadcast_elt_not_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_elt_not_equal" "int16_broadcast_elt_not_equal_impl"
external owl_uint16_broadcast_elt_not_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_elt_not_equal" "uint16_broadcast_elt_not_equal_impl"
external owl_int32_broadcast_elt_not_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_elt_not_equal" "int32_broadcast_elt_not_equal_impl"
external owl_int64_broadcast_elt_not_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_elt_not_equal" "int64_broadcast_elt_not_equal_impl"

let _owl_broadcast_elt_not_equal : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_elt_not_equal
  | Float64        -> owl_float64_broadcast_elt_not_equal
  | Complex32      -> owl_complex32_broadcast_elt_not_equal
  | Complex64      -> owl_complex64_broadcast_elt_not_equal
  | Int8_signed    -> owl_int8_broadcast_elt_not_equal
  | Int8_unsigned  -> owl_uint8_broadcast_elt_not_equal
  | Int16_signed   -> owl_int16_broadcast_elt_not_equal
  | Int16_unsigned -> owl_uint16_broadcast_elt_not_equal
  | Int32          -> owl_int32_broadcast_elt_not_equal
  | Int64          -> owl_int64_broadcast_elt_not_equal
  | _              -> failwith "_owl_broadcast_elt_not_equal: unsupported operation"

external owl_float32_broadcast_elt_less : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_elt_less" "float32_broadcast_elt_less_impl"
external owl_float64_broadcast_elt_less : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_elt_less" "float64_broadcast_elt_less_impl"
external owl_complex32_broadcast_elt_less : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_elt_less" "complex64_broadcast_elt_less_impl"
external owl_complex64_broadcast_elt_less : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_elt_less" "complex64_broadcast_elt_less_impl"
external owl_int8_broadcast_elt_less : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_elt_less" "int8_broadcast_elt_less_impl"
external owl_uint8_broadcast_elt_less : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_elt_less" "uint8_broadcast_elt_less_impl"
external owl_int16_broadcast_elt_less : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_elt_less" "int16_broadcast_elt_less_impl"
external owl_uint16_broadcast_elt_less : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_elt_less" "uint16_broadcast_elt_less_impl"
external owl_int32_broadcast_elt_less : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_elt_less" "int32_broadcast_elt_less_impl"
external owl_int64_broadcast_elt_less : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_elt_less" "int64_broadcast_elt_less_impl"

let _owl_broadcast_elt_less : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_elt_less
  | Float64        -> owl_float64_broadcast_elt_less
  | Complex32      -> owl_complex32_broadcast_elt_less
  | Complex64      -> owl_complex64_broadcast_elt_less
  | Int8_signed    -> owl_int8_broadcast_elt_less
  | Int8_unsigned  -> owl_uint8_broadcast_elt_less
  | Int16_signed   -> owl_int16_broadcast_elt_less
  | Int16_unsigned -> owl_uint16_broadcast_elt_less
  | Int32          -> owl_int32_broadcast_elt_less
  | Int64          -> owl_int64_broadcast_elt_less
  | _              -> failwith "_owl_broadcast_elt_less: unsupported operation"

external owl_float32_broadcast_elt_greater : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_elt_greater" "float32_broadcast_elt_greater_impl"
external owl_float64_broadcast_elt_greater : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_elt_greater" "float64_broadcast_elt_greater_impl"
external owl_complex32_broadcast_elt_greater : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_elt_greater" "complex64_broadcast_elt_greater_impl"
external owl_complex64_broadcast_elt_greater : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_elt_greater" "complex64_broadcast_elt_greater_impl"
external owl_int8_broadcast_elt_greater : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_elt_greater" "int8_broadcast_elt_greater_impl"
external owl_uint8_broadcast_elt_greater : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_elt_greater" "uint8_broadcast_elt_greater_impl"
external owl_int16_broadcast_elt_greater : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_elt_greater" "int16_broadcast_elt_greater_impl"
external owl_uint16_broadcast_elt_greater : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_elt_greater" "uint16_broadcast_elt_greater_impl"
external owl_int32_broadcast_elt_greater : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_elt_greater" "int32_broadcast_elt_greater_impl"
external owl_int64_broadcast_elt_greater : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_elt_greater" "int64_broadcast_elt_greater_impl"

let _owl_broadcast_elt_greater : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_elt_greater
  | Float64        -> owl_float64_broadcast_elt_greater
  | Complex32      -> owl_complex32_broadcast_elt_greater
  | Complex64      -> owl_complex64_broadcast_elt_greater
  | Int8_signed    -> owl_int8_broadcast_elt_greater
  | Int8_unsigned  -> owl_uint8_broadcast_elt_greater
  | Int16_signed   -> owl_int16_broadcast_elt_greater
  | Int16_unsigned -> owl_uint16_broadcast_elt_greater
  | Int32          -> owl_int32_broadcast_elt_greater
  | Int64          -> owl_int64_broadcast_elt_greater
  | _              -> failwith "_owl_broadcast_elt_greater: unsupported operation"

external owl_float32_broadcast_elt_less_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_elt_less_equal" "float32_broadcast_elt_less_equal_impl"
external owl_float64_broadcast_elt_less_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_elt_less_equal" "float64_broadcast_elt_less_equal_impl"
external owl_complex32_broadcast_elt_less_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_elt_less_equal" "complex64_broadcast_elt_less_equal_impl"
external owl_complex64_broadcast_elt_less_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_elt_less_equal" "complex64_broadcast_elt_less_equal_impl"
external owl_int8_broadcast_elt_less_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_elt_less_equal" "int8_broadcast_elt_less_equal_impl"
external owl_uint8_broadcast_elt_less_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_elt_less_equal" "uint8_broadcast_elt_less_equal_impl"
external owl_int16_broadcast_elt_less_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_elt_less_equal" "int16_broadcast_elt_less_equal_impl"
external owl_uint16_broadcast_elt_less_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_elt_less_equal" "uint16_broadcast_elt_less_equal_impl"
external owl_int32_broadcast_elt_less_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_elt_less_equal" "int32_broadcast_elt_less_equal_impl"
external owl_int64_broadcast_elt_less_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_elt_less_equal" "int64_broadcast_elt_less_equal_impl"

let _owl_broadcast_elt_less_equal : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_elt_less_equal
  | Float64        -> owl_float64_broadcast_elt_less_equal
  | Complex32      -> owl_complex32_broadcast_elt_less_equal
  | Complex64      -> owl_complex64_broadcast_elt_less_equal
  | Int8_signed    -> owl_int8_broadcast_elt_less_equal
  | Int8_unsigned  -> owl_uint8_broadcast_elt_less_equal
  | Int16_signed   -> owl_int16_broadcast_elt_less_equal
  | Int16_unsigned -> owl_uint16_broadcast_elt_less_equal
  | Int32          -> owl_int32_broadcast_elt_less_equal
  | Int64          -> owl_int64_broadcast_elt_less_equal
  | _              -> failwith "_owl_broadcast_elt_less_equal: unsupported operation"

external owl_float32_broadcast_elt_greater_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_broadcast_elt_greater_equal" "float32_broadcast_elt_greater_equal_impl"
external owl_float64_broadcast_elt_greater_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_broadcast_elt_greater_equal" "float64_broadcast_elt_greater_equal_impl"
external owl_complex32_broadcast_elt_greater_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex32_broadcast_elt_greater_equal" "complex64_broadcast_elt_greater_equal_impl"
external owl_complex64_broadcast_elt_greater_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "complex64_broadcast_elt_greater_equal" "complex64_broadcast_elt_greater_equal_impl"
external owl_int8_broadcast_elt_greater_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int8_broadcast_elt_greater_equal" "int8_broadcast_elt_greater_equal_impl"
external owl_uint8_broadcast_elt_greater_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint8_broadcast_elt_greater_equal" "uint8_broadcast_elt_greater_equal_impl"
external owl_int16_broadcast_elt_greater_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int16_broadcast_elt_greater_equal" "int16_broadcast_elt_greater_equal_impl"
external owl_uint16_broadcast_elt_greater_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "uint16_broadcast_elt_greater_equal" "uint16_broadcast_elt_greater_equal_impl"
external owl_int32_broadcast_elt_greater_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int32_broadcast_elt_greater_equal" "int32_broadcast_elt_greater_equal_impl"
external owl_int64_broadcast_elt_greater_equal : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "int64_broadcast_elt_greater_equal" "int64_broadcast_elt_greater_equal_impl"

let _owl_broadcast_elt_greater_equal : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_broadcast_elt_greater_equal
  | Float64        -> owl_float64_broadcast_elt_greater_equal
  | Complex32      -> owl_complex32_broadcast_elt_greater_equal
  | Complex64      -> owl_complex64_broadcast_elt_greater_equal
  | Int8_signed    -> owl_int8_broadcast_elt_greater_equal
  | Int8_unsigned  -> owl_uint8_broadcast_elt_greater_equal
  | Int16_signed   -> owl_int16_broadcast_elt_greater_equal
  | Int16_unsigned -> owl_uint16_broadcast_elt_greater_equal
  | Int32          -> owl_int32_broadcast_elt_greater_equal
  | Int64          -> owl_int64_broadcast_elt_greater_equal
  | _              -> failwith "_owl_broadcast_elt_greater_equal: unsupported operation"

external owl_float32_dist_gaussian : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_dist_gaussian" "float32_dist_gaussian_impl"
external owl_float64_dist_gaussian : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_dist_gaussian" "float64_dist_gaussian_impl"

let _owl_dist_gaussian : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_dist_gaussian
  | Float64        -> owl_float64_dist_gaussian
  | _              -> failwith "_owl_dist_gaussian: unsupported operation"

  
(* ends here *)
