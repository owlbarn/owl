(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Please refer to: Intel Math Kernel Library implements the BLAS
  url: https://software.intel.com/en-us/mkl-developer-reference-c
 *)

open Ctypes

type ('a, 'b) t = ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t

type cblas_layout = CblasRowMajor | CblasColMajor
let cblas_layout = function CblasRowMajor -> 101 | CblasColMajor -> 102

type cblas_transpose = CblasNoTrans | CblasTrans | CblasConjTrans
let cblas_transpose = function CblasNoTrans -> 111 | CblasTrans -> 112 | CblasConjTrans -> 113

type cblas_uplo = CblasUpper | CblasLower
let cblas_uplo = function CblasUpper -> 121 | CblasLower -> 122

type cblas_diag = CblasNonUnit | CblasUnit
let cblas_diag = function CblasNonUnit -> 131 | CblasUnit -> 132

type cblas_side = CblasLeft | CblasRight
let cblas_side = function CblasLeft -> 141 | CblasRight -> 142


module C = Owl_cblas_generated


(* Level 1 BLAS *)


(* Computes the parameters for a Givens rotation. *)

let rotg a b =
  let a = allocate double a in
  let b = allocate double b in
  let c = allocate double 0. in
  let s = allocate double 0. in
  C.drotg ~a ~b ~c ~s;
  !@a, !@b, !@c, !@s


(* Computes the parameters for a modified Givens rotation. *)

let rotmg
  : type a b. (a, b) Bigarray.kind -> float -> float -> float -> float -> float * float * float * (a, b) t
  = fun k d1 d2 b1 b2 ->
  match k with
  | Bigarray.Float32 -> (
      let d1 = allocate float d1 in
      let d2 = allocate float d2 in
      let b1 = allocate float b1 in
      let p  = Bigarray.(Array1.create Float32 C_layout 5) in
      let _p = bigarray_start Ctypes_static.Array1 p in
      C.srotmg ~d1 ~d2 ~b1 ~b2 ~p:_p;
      !@d1, !@d2, !@b1, p
    )
  | Bigarray.Float64 -> (
      let d1 = allocate double d1 in
      let d2 = allocate double d2 in
      let b1 = allocate double b1 in
      let p  = Bigarray.(Array1.create Float64 C_layout 5) in
      let _p = bigarray_start Ctypes_static.Array1 p in
      C.drotmg ~d1 ~d2 ~b1 ~b2 ~p:_p;
      !@d1, !@d2, !@b1, p
    )
  | _                -> failwith "owl_cblas:rotmg"


(* Performs modified Givens rotation of points in the plane *)

let rotm
  : type a b. int -> (a, b) t -> int -> (a, b) t -> int -> (a, b) t -> unit
  = fun n x incx y incy p ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _p = bigarray_start Ctypes_static.Array1 p in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32 -> C.srotm ~n ~x:_x ~incx ~y:_y ~incy ~p:_p
    | Bigarray.Float64 -> C.drotm ~n ~x:_x ~incx ~y:_y ~incy ~p:_p
    | _                -> failwith "owl_cblas:rotm"
  in ()


(* Performs rotation of points in the plane. *)

let rot
  : type a b. int -> (a, b) t -> int -> (a, b) t -> int -> float -> float -> unit
  = fun n x incx y incy c s ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32 -> C.srot ~n ~x:_x ~incx ~y:_y ~incy ~c ~s
    | Bigarray.Float64 -> C.drot ~n ~x:_x ~incx ~y:_y ~incy ~c ~s
    | _                -> failwith "owl_cblas:rot"
  in ()


(* Swaps a vector with another vector. *)

let swap
  : type a b. int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun n x incx y incy ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32   -> C.sswap ~n ~x:_x ~incx ~y:_y ~incy
    | Bigarray.Float64   -> C.dswap ~n ~x:_x ~incx ~y:_y ~incy
    | Bigarray.Complex32 -> C.cswap ~n ~x:_x ~incx ~y:_y ~incy
    | Bigarray.Complex64 -> C.zswap ~n ~x:_x ~incx ~y:_y ~incy
    | _                  -> failwith "owl_cblas:swap"
  in ()


(* Computes the product of a vector by a scalar. *)

let scal
  : type a b. int -> a -> (a, b) t -> int -> unit
  = fun n a x incx ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32   -> C.sscal ~n ~alpha:a ~x:_x ~incx
    | Bigarray.Float64   -> C.dscal ~n ~alpha:a ~x:_x ~incx
    | Bigarray.Complex32 -> C.cscal ~n ~alpha:(allocate complex32 a) ~x:_x ~incx
    | Bigarray.Complex64 -> C.zscal ~n ~alpha:(allocate complex64 a) ~x:_x ~incx
    | _                  -> failwith "owl_cblas:scal"
  in ()

let cszd_scal
  : type a. int -> float -> (Complex.t, a) t -> int -> unit
  = fun n a x incx ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Complex32 -> C.csscal ~n ~alpha:a ~x:_x ~incx
    | Bigarray.Complex64 -> C.zdscal ~n ~alpha:a ~x:_x ~incx
  in ()


(* Copies vector to another vector. *)

let copy
  : type a b. int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun n x incx y incy ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32   -> C.scopy ~n ~x:_x ~incx ~y:_y ~incy
    | Bigarray.Float64   -> C.dcopy ~n ~x:_x ~incx ~y:_y ~incy
    | Bigarray.Complex32 -> C.ccopy ~n ~x:_x ~incx ~y:_y ~incy
    | Bigarray.Complex64 -> C.zcopy ~n ~x:_x ~incx ~y:_y ~incy
    | _                  -> failwith "owl_cblas:copy"
  in ()


(* Computes a vector-scalar product and adds the result to a vector. *)

let axpy
  : type a b. int -> a -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun n a x incx y incy ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ = match Bigarray.Array1.kind x with
    | Bigarray.Float32   -> C.saxpy ~n ~alpha:a ~x:_x ~incx ~y:_y ~incy
    | Bigarray.Float64   -> C.daxpy ~n ~alpha:a ~x:_x ~incx ~y:_y ~incy
    | Bigarray.Complex32 -> C.caxpy ~n ~alpha:(allocate complex32 a) ~x:_x ~incx ~y:_y ~incy
    | Bigarray.Complex64 -> C.zaxpy ~n ~alpha:(allocate complex64 a) ~x:_x ~incx ~y:_y ~incy
    | _                  -> failwith "owl_cblas:axpy"
  in ()


(* Computes a vector-vector dot product. *)

let dot
  : type a b. ?conj:bool -> int -> (a, b) t -> int -> (a, b) t -> int -> a
  = fun ?(conj=false) n x incx y incy ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.sdot ~n ~x:_x ~incx ~y:_y ~incy
  | Bigarray.Float64   -> C.ddot ~n ~x:_x ~incx ~y:_y ~incy
  | Bigarray.Complex32 -> (
      let _z = allocate complex32 Complex.zero in
      if conj = true then C.cdotc ~n ~x:_x ~incx ~y:_y ~incy ~dotc:_z
      else C.cdotu ~n ~x:_x ~incx ~y:_y ~incy ~dotu:_z;
      !@_z
    )
  | Bigarray.Complex64 -> (
      let _z = allocate complex32 Complex.zero in
      if conj = true then C.zdotc ~n ~x:_x ~incx ~y:_y ~incy ~dotc:_z
      else C.zdotu ~n ~x:_x ~incx ~y:_y ~incy ~dotu:_z;
      !@_z
    )
  | _                  -> failwith "owl_cblas:dot"


(* Computes a vector-vector dot product with double precision. *)

let sdsdot n a x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.sdsdot ~n ~alpha:a ~x:_x ~incx ~y:_y ~incy

let dsdot n x incx y incy =
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  C.dsdot ~n ~x:_x ~incx ~y:_y ~incy


(* Computes the Euclidean norm of a vector. *)

let nrm2
  : type a b. int -> (a, b) t -> int -> float
  = fun n x incx ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.snrm2 ~n ~x:_x ~incx
  | Bigarray.Float64   -> C.dnrm2 ~n ~x:_x ~incx
  | Bigarray.Complex32 -> C.scnrm2 ~n ~x:_x ~incx
  | Bigarray.Complex64 -> C.dznrm2 ~n ~x:_x ~incx
  | _                  -> failwith "owl_cblas:nrm2"


(* Computes the sum of magnitudes of the vector elements. *)

let asum
  : type a b. int -> (a, b) t -> int -> float
  = fun n x incx ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.sasum ~n ~x:_x ~incx
  | Bigarray.Float64   -> C.sasum ~n ~x:_x ~incx
  | Bigarray.Complex32 -> C.scasum ~n ~x:_x ~incx
  | Bigarray.Complex64 -> C.dzasum ~n ~x:_x ~incx
  | _                  -> failwith "owl_cblas:asum"


(* Finds the index of the element with maximum absolute value. *)

let amax
  : type a b. int -> (a, b) t -> int -> int
  = fun n x incx ->
  let _x = bigarray_start Ctypes_static.Array1 x in
  let i = match Bigarray.Array1.kind x with
    | Bigarray.Float32   -> C.isamax ~n ~x:_x ~incx
    | Bigarray.Float64   -> C.idamax ~n ~x:_x ~incx
    | Bigarray.Complex32 -> C.icamax ~n ~x:_x ~incx
    | Bigarray.Complex64 -> C.izamax ~n ~x:_x ~incx
    | _                  -> failwith "owl_cblas:amax"
  in
  Unsigned.Size_t.to_int i


(* Level 2 BLAS *)


(* Computes a matrix-vector product using a general matrix *)

let gemv
  : type a b. cblas_layout -> cblas_transpose -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout trans m n alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> 
    C.sgemv ~order:_layout ~transa:_trans ~m ~n ~alpha ~a:_a ~lda ~x:_x ~incx ~beta ~y:_y ~incy
  | Bigarray.Float64   -> C.dgemv ~order:_layout ~transa:_trans ~m ~n ~alpha ~a:_a ~lda ~x:_x ~incx ~beta ~y:_y ~incy
  | Bigarray.Complex32 -> C.cgemv ~order:_layout ~transa:_trans ~m ~n ~alpha:(allocate complex32 alpha) ~a:_a ~lda ~x:_x ~incx ~beta:(allocate complex32 beta) ~y:_y ~incy
  | Bigarray.Complex64 -> C.zgemv ~order:_layout ~transa:_trans ~m ~n ~alpha:(allocate complex64 alpha) ~a:_a ~lda ~x:_x ~incx ~beta:(allocate complex64 beta) ~y:_y ~incy
  | _                  -> failwith "owl_cblas:gemv"


(* Computes a matrix-vector product using a general band matrix *)

let gbmv
  : type a b. cblas_layout -> cblas_transpose -> int -> int -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout trans m n kl ku alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.sgbmv ~order:_layout ~transa:_trans ~m ~n ~kl ~ku ~alpha ~a:_a ~lda ~x:_x ~incx ~beta ~y:_y ~incy
  | Bigarray.Float64   -> C.dgbmv ~order:_layout ~transa:_trans ~m ~n ~kl ~ku ~alpha ~a:_a ~lda ~x:_x ~incx ~beta ~y:_y ~incy
  | Bigarray.Complex32 -> C.cgbmv ~order:_layout ~transa:_trans ~m ~n ~kl ~ku ~alpha:(allocate complex32 alpha) ~a:_a ~lda ~x:_x ~incx ~beta:(allocate complex32 beta) ~y:_y ~incy
  | Bigarray.Complex64 -> C.cgbmv ~order:_layout ~transa:_trans ~m ~n ~kl ~ku ~alpha:(allocate complex64 alpha) ~a:_a ~lda ~x:_x ~incx ~beta:(allocate complex64 beta) ~y:_y ~incy
  | _                  -> failwith "owl_cblas:gbmv"


(* Computes a matrix-vector product using a triangular matrix. *)

let trmv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n a lda x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.strmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Float64   -> C.dtrmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Complex32 -> C.ctrmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Complex64 -> C.ztrmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~a:_a ~lda ~x:_x ~incx
  | _                  -> failwith "owl_cblas:trmv"


(* Computes a matrix-vector product using a triangular band matrix. *)

let tbmv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n k a lda x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.stbmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~k ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Float64   -> C.dtbmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~k ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Complex32 -> C.ctbmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~k ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Complex64 -> C.ztbmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~k ~a:_a ~lda ~x:_x ~incx
  | _                  -> failwith "owl_cblas:tbmv"


(* Computes a matrix-vector product using a triangular packed matrix. *)

let tpmv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> (a, b) t -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n ap x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.stpmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~ap:_ap ~x:_x ~incx
  | Bigarray.Float64   -> C.dtpmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~ap:_ap ~x:_x ~incx
  | Bigarray.Complex32 -> C.ctpmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~ap:_ap ~x:_x ~incx
  | Bigarray.Complex64 -> C.ztpmv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~ap:_ap ~x:_x ~incx
  | _                  -> failwith "owl_cblas:tpmv"


(* Solves a system of linear equations whose coefficients are in a triangular matrix. *)

let trsv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n a lda x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.strsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Float64   -> C.dtrsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Complex32 -> C.ctrsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Complex64 -> C.ztrsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~a:_a ~lda ~x:_x ~incx
  | _                  -> failwith "owl_cblas:trsv"


(* Solves a system of linear equations whose coefficients are in a triangular band matrix. *)

let tbsv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n k a lda x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.stbsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~k ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Float64   -> C.dtbsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~k ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Complex32 -> C.ctbsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~k ~a:_a ~lda ~x:_x ~incx
  | Bigarray.Complex64 -> C.ztbsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~k ~a:_a ~lda ~x:_x ~incx
  | _                  -> failwith "owl_cblas:tbsv"


(* Solves a system of linear equations whose coefficients are in a triangular packed matrix. *)

let tpsv
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> (a, b) t -> (a, b) t -> int -> unit
  = fun layout uplo trans diag n ap x incx ->
  let _layout = cblas_layout layout in
  let _trans = cblas_transpose trans in
  let _uplo = cblas_uplo uplo in
  let _diag = cblas_diag diag in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.stpsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~ap:_ap ~x:_x ~incx
  | Bigarray.Float64   -> C.dtpsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~ap:_ap ~x:_x ~incx
  | Bigarray.Complex32 -> C.ctpsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~ap:_ap ~x:_x ~incx
  | Bigarray.Complex64 -> C.ztpsv ~order:_layout ~uplo:_uplo ~transa:_trans ~diag:_diag ~n ~ap:_ap ~x:_x ~incx
  | _                  -> failwith "owl_cblas:tpsv"


(* Computes a matrix-vector product for a symmetric matrix. *)

let symv
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (float, a) t -> int -> (float, a) t -> int -> float -> (float, a) t -> int -> unit
  = fun layout uplo n alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.ssymv ~order:_layout ~uplo:_uplo ~n ~alpha ~a:_a ~lda ~x:_x ~incx ~beta ~y:_y ~incy
  | Bigarray.Float64 -> C.dsymv ~order:_layout ~uplo:_uplo ~n ~alpha ~a:_a ~lda ~x:_x ~incx ~beta ~y:_y ~incy


(* Computes a matrix-vector product using a symmetric band matrix. *)

let sbmv
  : type a. cblas_layout -> cblas_uplo -> int -> int -> float -> (float, a) t -> int -> (float, a) t -> int -> float -> (float, a) t -> int -> unit
  = fun layout uplo n k alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.ssbmv ~order:_layout ~uplo:_uplo ~n ~k ~alpha ~a:_a ~lda ~x:_x ~incx ~beta ~y:_y ~incy
  | Bigarray.Float64 -> C.dsbmv ~order:_layout ~uplo:_uplo ~n ~k ~alpha ~a:_a ~lda ~x:_x ~incx ~beta ~y:_y ~incy


(* Computes a matrix-vector product using a symmetric packed matrix. *)

let spmv
  : type a. cblas_layout -> cblas_uplo -> int -> int -> float -> (float, a) t -> (float, a) t -> int -> float -> (float, a) t -> int -> unit
  = fun layout uplo n _k alpha ap x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.sspmv ~order:_layout ~uplo:_uplo ~n ~alpha ~ap:_ap ~x:_x ~incx ~beta ~y:_y ~incy
  | Bigarray.Float64 -> C.dspmv ~order:_layout ~uplo:_uplo ~n ~alpha ~ap:_ap ~x:_x ~incx ~beta ~y:_y ~incy


(* Performs a rank-1 update of a general matrix. *)

let ger
  : type a b. ?conj:bool -> cblas_layout -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun ?(conj=false) layout m n alpha x incx y incy a lda ->
  let _layout = cblas_layout layout in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32   -> C.sger ~order:_layout ~m ~n ~alpha ~x:_x ~incx ~y:_y ~incy ~a:_a ~lda
  | Bigarray.Float64   -> C.dger ~order:_layout ~m ~n ~alpha ~x:_x ~incx ~y:_y ~incy ~a:_a ~lda
  | Bigarray.Complex32 ->
    if conj = true then C.cgerc ~order:_layout ~m ~n ~alpha:(allocate complex32 alpha) ~x:_x ~incx ~y:_y ~incy ~a:_a ~lda
      else C.cgeru ~order:_layout ~m ~n ~alpha:(allocate complex32 alpha) ~x:_x ~incx ~y:_y ~incy ~a:_a ~lda
  | Bigarray.Complex64 ->
      if conj = true then C.zgerc ~order:_layout ~m ~n ~alpha:(allocate complex64 alpha) ~x:_x ~incx ~y:_y ~incy ~a:_a ~lda
      else C.zgeru ~order:_layout ~m ~n ~alpha:(allocate complex64 alpha) ~x:_x ~incx ~y:_y ~incy ~a:_a ~lda
  | _                  -> failwith "owl_cblas:ger"


(* Performs a rank-1 update of a symmetric matrix. *)

let syr
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (float, a) t -> int -> (float, a) t -> int -> unit
  = fun layout uplo n alpha x incx a lda ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.ssyr ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~a:_a ~lda
  | Bigarray.Float64 -> C.dsyr ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~a:_a ~lda


(* Performs a rank-1 update of a symmetric packed matrix. *)

let spr
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (float, a) t -> int -> (float, a) t -> unit
  = fun layout uplo n alpha x incx ap ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.sspr ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~ap:_ap
  | Bigarray.Float64 -> C.dspr ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~ap:_ap


(* Performs a rank-2 update of symmetric matrix. *)

let syr2
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (float, a) t -> int -> (float, a) t -> int -> (float, a) t -> int -> unit
  = fun layout uplo n alpha x incx y incy a lda ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.ssyr2 ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~y:_y ~incy ~a:_a ~lda
  | Bigarray.Float64 -> C.dsyr2 ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~y:_y ~incy ~a:_a ~lda


(* Performs a rank-2 update of a symmetric packed matrix. *)

let spr2
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (float, a) t -> int -> (float, a) t -> int -> (float, a) t -> unit
  = fun layout uplo n alpha x incx y incy a ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Float32 -> C.sspr2 ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~y:_y ~incy ~a:_a
  | Bigarray.Float64 -> C.dspr2 ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~y:_y ~incy ~a:_a


(* Computes a matrix-vector product using a Hermitian matrix. *)

let hemv
  : type a. cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> Complex.t -> (Complex.t, a) t -> int -> unit
  = fun layout uplo n alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.chemv ~order:_layout ~uplo:_uplo ~n ~alpha:_alpha ~a:_a ~lda ~x:_x ~incx ~beta:_beta ~y:_y ~incy
  | Bigarray.Complex64 -> C.zhemv ~order:_layout ~uplo:_uplo ~n ~alpha:_alpha ~a:_a ~lda ~x:_x ~incx ~beta:_beta ~y:_y ~incy


(* Computes a matrix-vector product using a Hermitian band matrix. *)

let hbmv
  : type a. cblas_layout -> cblas_uplo -> int -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> Complex.t -> (Complex.t, a) t -> int -> unit
  = fun layout uplo n k alpha a lda x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.chbmv ~order:_layout ~uplo:_uplo ~n ~k ~alpha:_alpha  ~a:_a ~lda ~x:_x ~incx ~beta:_beta ~y:_y ~incy
  | Bigarray.Complex64 -> C.zhbmv ~order:_layout ~uplo:_uplo ~n ~k ~alpha:_alpha  ~a:_a ~lda ~x:_x ~incx ~beta:_beta ~y:_y ~incy


(* Computes a matrix-vector product using a Hermitian packed matrix. *)

let hpmv
  : type a. cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, a) t -> (Complex.t, a) t -> int -> Complex.t -> (Complex.t, a) t -> int -> unit
  = fun layout uplo n alpha ap x incx beta y incy ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _beta = allocate complex64 beta in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.chpmv ~order:_layout ~uplo:_uplo ~n ~alpha:_alpha ~ap:_ap ~x:_x ~incx ~beta:_beta ~y:_y ~incy
  | Bigarray.Complex64 -> C.zhpmv ~order:_layout ~uplo:_uplo  ~n ~alpha:_alpha ~ap:_ap ~x:_x ~incx ~beta:_beta ~y:_y ~incy


(* Performs a rank-1 update of a Hermitian matrix. *)

let her
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> unit
  = fun layout uplo n alpha x incx a lda ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.cher ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~a:_a ~lda
  | Bigarray.Complex64 -> C.zher  ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~a:_a ~lda


(* Performs a rank-1 update of a Hermitian packed matrix. *)

let hpr
  : type a. cblas_layout -> cblas_uplo -> int -> float -> (Complex.t, a) t -> int -> (Complex.t, a) t -> unit
  = fun layout uplo n alpha x incx a ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.chpr ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~a:_a
  | Bigarray.Complex64 -> C.zhpr ~order:_layout ~uplo:_uplo ~n ~alpha ~x:_x ~incx ~a:_a


(* Performs a rank-2 update of a Hermitian matrix. *)

let her2
  : type a. cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> unit
  = fun layout uplo n alpha x incx y incy a lda ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _a = bigarray_start Ctypes_static.Array1 a in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.cher2 ~order:_layout ~uplo:_uplo ~n ~alpha:_alpha ~x:_x ~incx ~y:_y ~incy ~a:_a ~lda
  | Bigarray.Complex64 -> C.zher2 ~order:_layout ~uplo:_uplo ~n ~alpha:_alpha ~x:_x ~incx ~y:_y ~incy ~a:_a ~lda



(* Performs a rank-2 update of a Hermitian packed matrix. *)

let hpr2
  : type a. cblas_layout -> cblas_uplo -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> (Complex.t, a) t -> unit
  = fun layout uplo n alpha x incx y incy ap ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _alpha = allocate complex64 alpha in
  let _x = bigarray_start Ctypes_static.Array1 x in
  let _y = bigarray_start Ctypes_static.Array1 y in
  let _ap = bigarray_start Ctypes_static.Array1 ap in
  match Bigarray.Array1.kind x with
  | Bigarray.Complex32 -> C.chpr2 ~order:_layout ~uplo:_uplo ~n ~alpha:_alpha ~x:_x ~incx ~y:_y ~incy ~ap:_ap
  | Bigarray.Complex64 -> C.zhpr2 ~order:_layout ~uplo:_uplo ~n ~alpha:_alpha ~x:_x ~incx ~y:_y ~incy ~ap:_ap


(* Level 3 BLAS *)


(* Computes a matrix-matrix product with general matrices. *)

let gemm
  : type a b. cblas_layout -> cblas_transpose -> cblas_transpose -> int -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout transa transb m n k alpha a lda b ldb beta c ldc ->
  let _layout = cblas_layout layout in
  let _transa = cblas_transpose transa in
  let _transb = cblas_transpose transb in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.sgemm ~order:_layout ~transa:_transa ~transb:_transb ~m ~n ~k ~alpha ~a:_a ~lda ~b:_b ~ldb ~beta ~c:_c ~ldc
  | Bigarray.Float64   -> C.dgemm  ~order:_layout ~transa:_transa ~transb:_transb ~m ~n ~k ~alpha ~a:_a ~lda ~b:_b ~ldb ~beta ~c:_c ~ldc
  | Bigarray.Complex32 -> C.cgemm ~order:_layout ~transa:_transa ~transb:_transb ~m ~n ~k ~alpha:(allocate complex32 alpha) ~a:_a ~lda ~b:_b ~ldb ~beta:(allocate complex32 alpha) ~c:_c ~ldc
  | Bigarray.Complex64 -> C.zgemm ~order:_layout ~transa:_transa ~transb:_transb ~m ~n ~k ~alpha:(allocate complex64 alpha) ~a:_a ~lda ~b:_b ~ldb ~beta:(allocate complex64 alpha) ~c:_c ~ldc
  | _                  -> failwith "owl_cblas:gemm"


(* Computes a matrix-matrix product where one input matrix is symmetric. *)

let symm
  : type a b. cblas_layout -> cblas_side -> cblas_uplo -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout side uplo m n alpha a lda b ldb beta c ldc ->
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.ssymm ~order:_layout ~side:_side ~uplo:_uplo ~m ~n ~alpha ~a:_a ~lda ~b:_b ~ldb ~beta ~c:_c ~ldc
  | Bigarray.Float64   -> C.dsymm ~order:_layout ~side:_side ~uplo:_uplo ~m ~n ~alpha ~a:_a ~lda ~b:_b ~ldb ~beta ~c:_c ~ldc
  | Bigarray.Complex32 -> C.csymm ~order:_layout ~side:_side ~uplo:_uplo ~m ~n ~alpha:(allocate complex32 alpha) ~a:_a ~lda ~b:_b ~ldb ~beta:(allocate complex32 beta) ~c:_c ~ldc
  | Bigarray.Complex64 -> C.zsymm ~order:_layout ~side:_side ~uplo:_uplo ~m ~n ~alpha:(allocate complex64 alpha) ~a:_a ~lda ~b:_b ~ldb ~beta:(allocate complex64 beta) ~c:_c ~ldc
  | _                  -> failwith "owl_cblas:symm"


(* Performs a symmetric rank-k update. *)

let syrk
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> a -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout uplo trans n k alpha a lda beta c ldc ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.ssyrk ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha ~a:_a ~lda ~beta ~c:_c ~ldc
  | Bigarray.Float64   -> C.dsyrk ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha ~a:_a ~lda ~beta ~c:_c ~ldc
  | Bigarray.Complex32 -> C.csyrk ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha:(allocate complex32 alpha) ~a:_a ~lda ~beta:(allocate complex32 beta) ~c:_c ~ldc
  | Bigarray.Complex64 -> C.zsyrk ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha:(allocate complex64 alpha) ~a:_a ~lda ~beta:(allocate complex64 beta) ~c:_c ~ldc
  | _                  -> failwith "owl_cblas:syrk"


(* Performs a symmetric rank-2k update. *)

let syr2k
  : type a b. cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> a -> (a, b) t -> int -> unit
  = fun layout uplo trans n k alpha a lda b ldb beta c ldc ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.ssyr2k ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha ~a:_a ~lda ~b:_b ~ldb ~beta ~c:_c ~ldc
  | Bigarray.Float64   -> C.dsyr2k ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha ~a:_a ~lda ~b:_b ~ldb ~beta ~c:_c ~ldc
  | Bigarray.Complex32 -> C.csyr2k ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha:(allocate complex32 alpha) ~a:_a ~lda ~b:_b ~ldb ~beta:(allocate complex32 beta) ~c:_c ~ldc
  | Bigarray.Complex64 -> C.zsyr2k ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha:(allocate complex64 alpha) ~a:_a ~lda ~b:_b ~ldb ~beta:(allocate complex64 beta) ~c:_c ~ldc
  | _                  -> failwith "owl_cblas:syr2k"


(* Computes a matrix-matrix product where one input matrix is triangular. *)

let trmm
  : type a b. cblas_layout -> cblas_side -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout side uplo transa diag m n alpha a lda b ldb ->
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.strmm ~order:_layout ~side:_side ~uplo:_uplo ~transa:_transa ~diag:_diag ~m ~n ~alpha ~a:_a ~lda ~b:_b ~ldb
  | Bigarray.Float64   -> C.dtrmm  ~order:_layout ~side:_side ~uplo:_uplo ~transa:_transa ~diag:_diag ~m ~n ~alpha ~a:_a ~lda ~b:_b ~ldb
  | Bigarray.Complex32 -> C.ctrmm ~order:_layout ~side:_side ~uplo:_uplo ~transa:_transa ~diag:_diag ~m ~n ~alpha:(allocate complex32 alpha) ~a:_a ~lda ~b:_b ~ldb
  | Bigarray.Complex64 -> C.ztrmm  ~order:_layout ~side:_side ~uplo:_uplo ~transa:_transa ~diag:_diag ~m ~n ~alpha:(allocate complex64 alpha) ~a:_a ~lda ~b:_b ~ldb
  | _                  -> failwith "owl_cblas:trmm"


(* Solves a triangular matrix equation. *)

let trsm
  : type a b. cblas_layout -> cblas_side -> cblas_uplo -> cblas_transpose -> cblas_diag -> int -> int -> a -> (a, b) t -> int -> (a, b) t -> int -> unit
  = fun layout side uplo transa diag m n alpha a lda b ldb ->
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _transa = cblas_transpose transa in
  let _diag = cblas_diag diag in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  match Bigarray.Array1.kind a with
  | Bigarray.Float32   -> C.strsm ~order:_layout ~side:_side ~uplo:_uplo ~transa:_transa ~diag:_diag ~m ~n ~alpha ~a:_a ~lda ~b:_b ~ldb
  | Bigarray.Float64   -> C.dtrsm ~order:_layout ~side:_side ~uplo:_uplo ~transa:_transa ~diag:_diag ~m ~n ~alpha ~a:_a ~lda ~b:_b ~ldb
 | Bigarray.Complex32 -> C.ctrsm ~order:_layout ~side:_side ~uplo:_uplo ~transa:_transa ~diag:_diag ~m ~n ~alpha:(allocate complex32 alpha) ~a:_a ~lda ~b:_b ~ldb
  | Bigarray.Complex64 -> C.ztrsm ~order:_layout ~side:_side ~uplo:_uplo ~transa:_transa ~diag:_diag ~m ~n ~alpha:(allocate complex64 alpha) ~a:_a ~lda ~b:_b ~ldb
  | _                  -> failwith "owl_cblas:trsm"


(* Computes a matrix-matrix product where one input matrix is Hermitian. *)

let hemm
  : type a. cblas_layout -> cblas_side -> cblas_uplo -> int -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> Complex.t -> (Complex.t, a) t -> int -> unit
  = fun layout side uplo m n alpha a lda b ldb beta c ldc ->
  let _layout = cblas_layout layout in
  let _side = cblas_side side in
  let _uplo = cblas_uplo uplo in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Complex32 -> C.chemm ~order:_layout ~side:_side ~uplo:_uplo ~m ~n ~alpha:(allocate complex32 alpha) ~a:_a ~lda ~b:_b ~ldb ~beta:(allocate complex32 beta) ~c:_c ~ldc
  | Bigarray.Complex64 -> C.zhemm ~order:_layout ~side:_side ~uplo:_uplo ~m ~n ~alpha:(allocate complex64 alpha) ~a:_a ~lda ~b:_b ~ldb ~beta:(allocate complex64 beta) ~c:_c ~ldc


(* Performs a Hermitian rank-k update. *)

let herk
  : type a. cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> float -> (Complex.t, a) t -> int -> float -> (Complex.t, a) t -> int -> unit
  = fun layout uplo trans n k alpha a lda beta c ldc ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Complex32 -> C.cherk ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha ~a:_a ~lda ~beta ~c:_c ~ldc
  | Bigarray.Complex64 -> C.zherk ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha ~a:_a ~lda ~beta ~c:_c ~ldc


(* Performs a Hermitian rank-2k update. *)

let her2k
  : type a. cblas_layout -> cblas_uplo -> cblas_transpose -> int -> int -> Complex.t -> (Complex.t, a) t -> int -> (Complex.t, a) t -> int -> float -> (Complex.t, a) t -> int -> unit
  = fun layout uplo trans n k alpha a lda b ldb beta c ldc ->
  let _layout = cblas_layout layout in
  let _uplo = cblas_uplo uplo in
  let _trans = cblas_transpose trans in
  let _alpha = allocate complex32 alpha in
  let _a = bigarray_start Ctypes_static.Array1 a in
  let _b = bigarray_start Ctypes_static.Array1 b in
  let _c = bigarray_start Ctypes_static.Array1 c in
  match Bigarray.Array1.kind a with
  | Bigarray.Complex32 -> C.cher2k ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha:(allocate complex32 alpha) ~a:_a ~lda ~b:_b ~ldb ~beta ~c:_c ~ldc
  | Bigarray.Complex64 -> C.zher2k ~order:_layout ~uplo:_uplo ~trans:_trans ~n ~k ~alpha:(allocate complex64 alpha) ~a:_a ~lda ~b:_b ~ldb ~beta ~c:_c ~ldc
