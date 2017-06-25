(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** auto-generated cblas interface file, timestamp:1498396302 *)

open Ctypes

val sdsdot : n:int -> alpha:float -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> float 

val dsdot : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> float 

val sdot : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> float 

val ddot : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> float 

val cdotu : n:int -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> dotu:(Complex.t ptr) -> unit 

val cdotc : n:int -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> dotc:(Complex.t ptr) -> unit 

val zdotu : n:int -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> dotu:(Complex.t ptr) -> unit 

val zdotc : n:int -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> dotc:(Complex.t ptr) -> unit 

val snrm2 : n:int -> x:(float ptr) -> incx:int -> float 

val sasum : n:int -> x:(float ptr) -> incx:int -> float 

val dnrm2 : n:int -> x:(float ptr) -> incx:int -> float 

val dasum : n:int -> x:(float ptr) -> incx:int -> float 

val scnrm2 : n:int -> x:(Complex.t ptr) -> incx:int -> float 

val scasum : n:int -> x:(Complex.t ptr) -> incx:int -> float 

val dznrm2 : n:int -> x:(Complex.t ptr) -> incx:int -> float 

val dzasum : n:int -> x:(Complex.t ptr) -> incx:int -> float 

val isamax : n:int -> x:(float ptr) -> incx:int -> Unsigned.size_t 

val idamax : n:int -> x:(float ptr) -> incx:int -> Unsigned.size_t 

val icamax : n:int -> x:(Complex.t ptr) -> incx:int -> Unsigned.size_t 

val izamax : n:int -> x:(Complex.t ptr) -> incx:int -> Unsigned.size_t 

val sswap : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> unit 

val scopy : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> unit 

val saxpy : n:int -> alpha:float -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> unit 

val dswap : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> unit 

val dcopy : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> unit 

val daxpy : n:int -> alpha:float -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> unit 

val cswap : n:int -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> unit 

val ccopy : n:int -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> unit 

val caxpy : n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> unit 

val zswap : n:int -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> unit 

val zcopy : n:int -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> unit 

val zaxpy : n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> unit 

val srotg : a:(float ptr) -> b:(float ptr) -> c:(float ptr) -> s:(float ptr) -> unit 

val srotmg : d1:(float ptr) -> d2:(float ptr) -> b1:(float ptr) -> b2:float -> p:(float ptr) -> unit 

val srot : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> c:float -> s:float -> unit 

val srotm : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> p:(float ptr) -> unit 

val drotg : a:(float ptr) -> b:(float ptr) -> c:(float ptr) -> s:(float ptr) -> unit 

val drotmg : d1:(float ptr) -> d2:(float ptr) -> b1:(float ptr) -> b2:float -> p:(float ptr) -> unit 

val drot : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> c:float -> s:float -> unit 

val drotm : n:int -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> p:(float ptr) -> unit 

val sscal : n:int -> alpha:float -> x:(float ptr) -> incx:int -> unit 

val dscal : n:int -> alpha:float -> x:(float ptr) -> incx:int -> unit 

val cscal : n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> unit 

val zscal : n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> unit 

val csscal : n:int -> alpha:float -> x:(Complex.t ptr) -> incx:int -> unit 

val zdscal : n:int -> alpha:float -> x:(Complex.t ptr) -> incx:int -> unit 

val sgemv : order:int -> transa:int -> m:int -> n:int -> alpha:float -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> beta:float -> y:(float ptr) -> incy:int -> unit 

val sgbmv : order:int -> transa:int -> m:int -> n:int -> kl:int -> ku:int -> alpha:float -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> beta:float -> y:(float ptr) -> incy:int -> unit 

val strmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> unit 

val stbmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> unit 

val stpmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> ap:(float ptr) -> x:(float ptr) -> incx:int -> unit 

val strsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> unit 

val stbsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> unit 

val stpsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> ap:(float ptr) -> x:(float ptr) -> incx:int -> unit 

val dgemv : order:int -> transa:int -> m:int -> n:int -> alpha:float -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> beta:float -> y:(float ptr) -> incy:int -> unit 

val dgbmv : order:int -> transa:int -> m:int -> n:int -> kl:int -> ku:int -> alpha:float -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> beta:float -> y:(float ptr) -> incy:int -> unit 

val dtrmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> unit 

val dtbmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> unit 

val dtpmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> ap:(float ptr) -> x:(float ptr) -> incx:int -> unit 

val dtrsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> unit 

val dtbsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> unit 

val dtpsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> ap:(float ptr) -> x:(float ptr) -> incx:int -> unit 

val cgemv : order:int -> transa:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> beta:(Complex.t ptr) -> y:(Complex.t ptr) -> incy:int -> unit 

val cgbmv : order:int -> transa:int -> m:int -> n:int -> kl:int -> ku:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> beta:(Complex.t ptr) -> y:(Complex.t ptr) -> incy:int -> unit 

val ctrmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> unit 

val ctbmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> unit 

val ctpmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> ap:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> unit 

val ctrsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> unit 

val ctbsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> unit 

val ctpsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> ap:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> unit 

val zgemv : order:int -> transa:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> beta:(Complex.t ptr) -> y:(Complex.t ptr) -> incy:int -> unit 

val zgbmv : order:int -> transa:int -> m:int -> n:int -> kl:int -> ku:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> beta:(Complex.t ptr) -> y:(Complex.t ptr) -> incy:int -> unit 

val ztrmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> unit 

val ztbmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> unit 

val ztpmv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> ap:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> unit 

val ztrsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> unit 

val ztbsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> unit 

val ztpsv : order:int -> uplo:int -> transa:int -> diag:int -> n:int -> ap:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> unit 

val ssymv : order:int -> uplo:int -> n:int -> alpha:float -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> beta:float -> y:(float ptr) -> incy:int -> unit 

val ssbmv : order:int -> uplo:int -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> beta:float -> y:(float ptr) -> incy:int -> unit 

val sspmv : order:int -> uplo:int -> n:int -> alpha:float -> ap:(float ptr) -> x:(float ptr) -> incx:int -> beta:float -> y:(float ptr) -> incy:int -> unit 

val sger : order:int -> m:int -> n:int -> alpha:float -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> a:(float ptr) -> lda:int -> unit 

val ssyr : order:int -> uplo:int -> n:int -> alpha:float -> x:(float ptr) -> incx:int -> a:(float ptr) -> lda:int -> unit 

val sspr : order:int -> uplo:int -> n:int -> alpha:float -> x:(float ptr) -> incx:int -> ap:(float ptr) -> unit 

val ssyr2 : order:int -> uplo:int -> n:int -> alpha:float -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> a:(float ptr) -> lda:int -> unit 

val sspr2 : order:int -> uplo:int -> n:int -> alpha:float -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> a:(float ptr) -> unit 

val dsymv : order:int -> uplo:int -> n:int -> alpha:float -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> beta:float -> y:(float ptr) -> incy:int -> unit 

val dsbmv : order:int -> uplo:int -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> x:(float ptr) -> incx:int -> beta:float -> y:(float ptr) -> incy:int -> unit 

val dspmv : order:int -> uplo:int -> n:int -> alpha:float -> ap:(float ptr) -> x:(float ptr) -> incx:int -> beta:float -> y:(float ptr) -> incy:int -> unit 

val dger : order:int -> m:int -> n:int -> alpha:float -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> a:(float ptr) -> lda:int -> unit 

val dsyr : order:int -> uplo:int -> n:int -> alpha:float -> x:(float ptr) -> incx:int -> a:(float ptr) -> lda:int -> unit 

val dspr : order:int -> uplo:int -> n:int -> alpha:float -> x:(float ptr) -> incx:int -> ap:(float ptr) -> unit 

val dsyr2 : order:int -> uplo:int -> n:int -> alpha:float -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> a:(float ptr) -> lda:int -> unit 

val dspr2 : order:int -> uplo:int -> n:int -> alpha:float -> x:(float ptr) -> incx:int -> y:(float ptr) -> incy:int -> a:(float ptr) -> unit 

val chemv : order:int -> uplo:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> beta:(Complex.t ptr) -> y:(Complex.t ptr) -> incy:int -> unit 

val chbmv : order:int -> uplo:int -> n:int -> k:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> beta:(Complex.t ptr) -> y:(Complex.t ptr) -> incy:int -> unit 

val chpmv : order:int -> uplo:int -> n:int -> alpha:(Complex.t ptr) -> ap:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> beta:(Complex.t ptr) -> y:(Complex.t ptr) -> incy:int -> unit 

val cgeru : order:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> a:(Complex.t ptr) -> lda:int -> unit 

val cgerc : order:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> a:(Complex.t ptr) -> lda:int -> unit 

val cher : order:int -> uplo:int -> n:int -> alpha:float -> x:(Complex.t ptr) -> incx:int -> a:(Complex.t ptr) -> lda:int -> unit 

val chpr : order:int -> uplo:int -> n:int -> alpha:float -> x:(Complex.t ptr) -> incx:int -> a:(Complex.t ptr) -> unit 

val cher2 : order:int -> uplo:int -> n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> a:(Complex.t ptr) -> lda:int -> unit 

val chpr2 : order:int -> uplo:int -> n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> ap:(Complex.t ptr) -> unit 

val zhemv : order:int -> uplo:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> beta:(Complex.t ptr) -> y:(Complex.t ptr) -> incy:int -> unit 

val zhbmv : order:int -> uplo:int -> n:int -> k:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> x:(Complex.t ptr) -> incx:int -> beta:(Complex.t ptr) -> y:(Complex.t ptr) -> incy:int -> unit 

val zhpmv : order:int -> uplo:int -> n:int -> alpha:(Complex.t ptr) -> ap:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> beta:(Complex.t ptr) -> y:(Complex.t ptr) -> incy:int -> unit 

val zgeru : order:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> a:(Complex.t ptr) -> lda:int -> unit 

val zgerc : order:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> a:(Complex.t ptr) -> lda:int -> unit 

val zher : order:int -> uplo:int -> n:int -> alpha:float -> x:(Complex.t ptr) -> incx:int -> a:(Complex.t ptr) -> lda:int -> unit 

val zhpr : order:int -> uplo:int -> n:int -> alpha:float -> x:(Complex.t ptr) -> incx:int -> a:(Complex.t ptr) -> unit 

val zher2 : order:int -> uplo:int -> n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> a:(Complex.t ptr) -> lda:int -> unit 

val zhpr2 : order:int -> uplo:int -> n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> y:(Complex.t ptr) -> incy:int -> ap:(Complex.t ptr) -> unit 

val sgemm : order:int -> transa:int -> transb:int -> m:int -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> beta:float -> c:(float ptr) -> ldc:int -> unit 

val ssymm : order:int -> side:int -> uplo:int -> m:int -> n:int -> alpha:float -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> beta:float -> c:(float ptr) -> ldc:int -> unit 

val ssyrk : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> beta:float -> c:(float ptr) -> ldc:int -> unit 

val ssyr2k : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> beta:float -> c:(float ptr) -> ldc:int -> unit 

val strmm : order:int -> side:int -> uplo:int -> transa:int -> diag:int -> m:int -> n:int -> alpha:float -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> unit 

val strsm : order:int -> side:int -> uplo:int -> transa:int -> diag:int -> m:int -> n:int -> alpha:float -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> unit 

val dgemm : order:int -> transa:int -> transb:int -> m:int -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> beta:float -> c:(float ptr) -> ldc:int -> unit 

val dsymm : order:int -> side:int -> uplo:int -> m:int -> n:int -> alpha:float -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> beta:float -> c:(float ptr) -> ldc:int -> unit 

val dsyrk : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> beta:float -> c:(float ptr) -> ldc:int -> unit 

val dsyr2k : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> beta:float -> c:(float ptr) -> ldc:int -> unit 

val dtrmm : order:int -> side:int -> uplo:int -> transa:int -> diag:int -> m:int -> n:int -> alpha:float -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> unit 

val dtrsm : order:int -> side:int -> uplo:int -> transa:int -> diag:int -> m:int -> n:int -> alpha:float -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> unit 

val cgemm : order:int -> transa:int -> transb:int -> m:int -> n:int -> k:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> beta:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> unit 

val csymm : order:int -> side:int -> uplo:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> beta:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> unit 

val csyrk : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> beta:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> unit 

val csyr2k : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> beta:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> unit 

val ctrmm : order:int -> side:int -> uplo:int -> transa:int -> diag:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> unit 

val ctrsm : order:int -> side:int -> uplo:int -> transa:int -> diag:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> unit 

val zgemm : order:int -> transa:int -> transb:int -> m:int -> n:int -> k:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> beta:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> unit 

val zsymm : order:int -> side:int -> uplo:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> beta:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> unit 

val zsyrk : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> beta:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> unit 

val zsyr2k : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> beta:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> unit 

val ztrmm : order:int -> side:int -> uplo:int -> transa:int -> diag:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> unit 

val ztrsm : order:int -> side:int -> uplo:int -> transa:int -> diag:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> unit 

val chemm : order:int -> side:int -> uplo:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> beta:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> unit 

val cherk : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:float -> a:(Complex.t ptr) -> lda:int -> beta:float -> c:(Complex.t ptr) -> ldc:int -> unit 

val cher2k : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> beta:float -> c:(Complex.t ptr) -> ldc:int -> unit 

val zhemm : order:int -> side:int -> uplo:int -> m:int -> n:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> beta:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> unit 

val zherk : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:float -> a:(Complex.t ptr) -> lda:int -> beta:float -> c:(Complex.t ptr) -> ldc:int -> unit 

val zher2k : order:int -> uplo:int -> trans:int -> n:int -> k:int -> alpha:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> beta:float -> c:(Complex.t ptr) -> ldc:int -> unit 

