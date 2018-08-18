(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** LAPACKE interface: low-level interface to the LAPACKE functions *)

(** auto-generated lapacke interface file, timestamp:1498396312 *)

open Ctypes

val sbdsdc : layout:int -> uplo:char -> compq:char -> n:int -> d:(float ptr) -> e:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> q:(float ptr) -> iq:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dbdsdc : layout:int -> uplo:char -> compq:char -> n:int -> d:(float ptr) -> e:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> q:(float ptr) -> iq:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sbdsqr : layout:int -> uplo:char -> n:int -> ncvt:int -> nru:int -> ncc:int -> d:(float ptr) -> e:(float ptr) -> vt:(float ptr) -> ldvt:int -> u:(float ptr) -> ldu:int -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dbdsqr : layout:int -> uplo:char -> n:int -> ncvt:int -> nru:int -> ncc:int -> d:(float ptr) -> e:(float ptr) -> vt:(float ptr) -> ldvt:int -> u:(float ptr) -> ldu:int -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cbdsqr : layout:int -> uplo:char -> n:int -> ncvt:int -> nru:int -> ncc:int -> d:(float ptr) -> e:(float ptr) -> vt:(Complex.t ptr) -> ldvt:int -> u:(Complex.t ptr) -> ldu:int -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zbdsqr : layout:int -> uplo:char -> n:int -> ncvt:int -> nru:int -> ncc:int -> d:(float ptr) -> e:(float ptr) -> vt:(Complex.t ptr) -> ldvt:int -> u:(Complex.t ptr) -> ldu:int -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sbdsvdx : layout:int -> uplo:char -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int32 ptr) -> s:(float ptr) -> z:(float ptr) -> ldz:int -> superb:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dbdsvdx : layout:int -> uplo:char -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int32 ptr) -> s:(float ptr) -> z:(float ptr) -> ldz:int -> superb:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sdisna : job:char -> m:int -> n:int -> d:(float ptr) -> sep:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ddisna : job:char -> m:int -> n:int -> d:(float ptr) -> sep:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgbbrd : layout:int -> vect:char -> m:int -> n:int -> ncc:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(float ptr) -> ldq:int -> pt:(float ptr) -> ldpt:int -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgbbrd : layout:int -> vect:char -> m:int -> n:int -> ncc:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(float ptr) -> ldq:int -> pt:(float ptr) -> ldpt:int -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgbbrd : layout:int -> vect:char -> m:int -> n:int -> ncc:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(Complex.t ptr) -> ldq:int -> pt:(Complex.t ptr) -> ldpt:int -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgbbrd : layout:int -> vect:char -> m:int -> n:int -> ncc:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(Complex.t ptr) -> ldq:int -> pt:(Complex.t ptr) -> ldpt:int -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgbcon : layout:int -> norm:char -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgbcon : layout:int -> norm:char -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgbcon : layout:int -> norm:char -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgbcon : layout:int -> norm:char -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgbequ : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgbequ : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgbequ : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgbequ : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgbequb : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgbequb : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgbequb : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgbequb : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgbrfs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgbrfs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgbrfs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgbrfs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgbsv : layout:int -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgbsv : layout:int -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgbsv : layout:int -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgbsv : layout:int -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgbsvx : layout:int -> fact:char -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> ipiv:(int32 ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgbsvx : layout:int -> fact:char -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> ipiv:(int32 ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgbsvx : layout:int -> fact:char -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> ipiv:(int32 ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgbsvx : layout:int -> fact:char -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> ipiv:(int32 ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgbtrf : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgbtrf : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgbtrf : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgbtrf : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgbtrs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgbtrs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgbtrs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgbtrs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgebak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> scale:(float ptr) -> m:int -> v:(float ptr) -> ldv:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgebak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> scale:(float ptr) -> m:int -> v:(float ptr) -> ldv:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgebak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> scale:(float ptr) -> m:int -> v:(Complex.t ptr) -> ldv:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgebak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> scale:(float ptr) -> m:int -> v:(Complex.t ptr) -> ldv:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgebal : layout:int -> job:char -> n:int -> a:(float ptr) -> lda:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> scale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgebal : layout:int -> job:char -> n:int -> a:(float ptr) -> lda:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> scale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgebal : layout:int -> job:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> scale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgebal : layout:int -> job:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> scale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgebrd : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tauq:(float ptr) -> taup:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgebrd : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tauq:(float ptr) -> taup:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgebrd : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tauq:(Complex.t ptr) -> taup:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgebrd : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tauq:(Complex.t ptr) -> taup:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgecon : layout:int -> norm:char -> n:int -> a:(float ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgecon : layout:int -> norm:char -> n:int -> a:(float ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgecon : layout:int -> norm:char -> n:int -> a:(Complex.t ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgecon : layout:int -> norm:char -> n:int -> a:(Complex.t ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeequ : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeequ : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeequ : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeequ : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeequb : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeequb : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeequb : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeequb : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgees : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> sdim:(int32 ptr) -> wr:(float ptr) -> wi:(float ptr) -> vs:(float ptr) -> ldvs:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgees : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> sdim:(int32 ptr) -> wr:(float ptr) -> wi:(float ptr) -> vs:(float ptr) -> ldvs:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgees : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> sdim:(int32 ptr) -> w:(Complex.t ptr) -> vs:(Complex.t ptr) -> ldvs:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgees : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> sdim:(int32 ptr) -> w:(Complex.t ptr) -> vs:(Complex.t ptr) -> ldvs:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeesx : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> sense:char -> n:int -> a:(float ptr) -> lda:int -> sdim:(int32 ptr) -> wr:(float ptr) -> wi:(float ptr) -> vs:(float ptr) -> ldvs:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeesx : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> sense:char -> n:int -> a:(float ptr) -> lda:int -> sdim:(int32 ptr) -> wr:(float ptr) -> wi:(float ptr) -> vs:(float ptr) -> ldvs:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeesx : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> sdim:(int32 ptr) -> w:(Complex.t ptr) -> vs:(Complex.t ptr) -> ldvs:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeesx : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> sdim:(int32 ptr) -> w:(Complex.t ptr) -> vs:(Complex.t ptr) -> ldvs:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(float ptr) -> lda:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> scale:(float ptr) -> abnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(float ptr) -> lda:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> scale:(float ptr) -> abnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> scale:(float ptr) -> abnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> scale:(float ptr) -> abnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgehrd : layout:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgehrd : layout:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgehrd : layout:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgehrd : layout:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgejsv : layout:int -> joba:char -> jobu:char -> jobv:char -> jobr:char -> jobt:char -> jobp:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> sva:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> stat:(float ptr) -> istat:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgejsv : layout:int -> joba:char -> jobu:char -> jobv:char -> jobr:char -> jobt:char -> jobp:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> sva:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> stat:(float ptr) -> istat:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgejsv : layout:int -> joba:char -> jobu:char -> jobv:char -> jobr:char -> jobt:char -> jobp:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> sva:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> stat:(float ptr) -> istat:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgejsv : layout:int -> joba:char -> jobu:char -> jobv:char -> jobr:char -> jobt:char -> jobp:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> sva:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> stat:(float ptr) -> istat:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgelq2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgelq2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgelq2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgelq2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgelqf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgelqf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgelqf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgelqf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgels : layout:int -> trans:char -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgels : layout:int -> trans:char -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgels : layout:int -> trans:char -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgels : layout:int -> trans:char -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgelsd : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgelsd : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgelsd : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgelsd : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgelss : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgelss : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgelss : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgelss : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgelsy : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> jpvt:(int32 ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgelsy : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> jpvt:(int32 ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgelsy : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> jpvt:(int32 ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgelsy : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> jpvt:(int32 ptr) -> rcond:float -> rank:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeqlf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeqlf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeqlf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeqlf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeqp3 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> jpvt:(int32 ptr) -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeqp3 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> jpvt:(int32 ptr) -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeqp3 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> jpvt:(int32 ptr) -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeqp3 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> jpvt:(int32 ptr) -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeqr2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeqr2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeqr2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeqr2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeqrf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeqrf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeqrf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeqrf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeqrfp : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeqrfp : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeqrfp : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeqrfp : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgerfs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgerfs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgerfs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgerfs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgerqf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgerqf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgerqf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgerqf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgesdd : layout:int -> jobz:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgesdd : layout:int -> jobz:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgesdd : layout:int -> jobz:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgesdd : layout:int -> jobz:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgesv : layout:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgesv : layout:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgesv : layout:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgesv : layout:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsgesv : layout:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> iter:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zcgesv : layout:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> iter:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgesvd : layout:int -> jobu:char -> jobvt:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> superb:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgesvd : layout:int -> jobu:char -> jobvt:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> superb:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgesvd : layout:int -> jobu:char -> jobvt:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> superb:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgesvd : layout:int -> jobu:char -> jobvt:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> superb:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgesvdx : layout:int -> jobu:char -> jobvt:char -> range:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int32 ptr) -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> superb:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgesvdx : layout:int -> jobu:char -> jobvt:char -> range:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int32 ptr) -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> superb:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgesvdx : layout:int -> jobu:char -> jobvt:char -> range:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int32 ptr) -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> superb:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgesvdx : layout:int -> jobu:char -> jobvt:char -> range:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int32 ptr) -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> superb:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgesvj : layout:int -> joba:char -> jobu:char -> jobv:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> sva:(float ptr) -> mv:int -> v:(float ptr) -> ldv:int -> stat:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgesvj : layout:int -> joba:char -> jobu:char -> jobv:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> sva:(float ptr) -> mv:int -> v:(float ptr) -> ldv:int -> stat:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgesvj : layout:int -> joba:char -> jobu:char -> jobv:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> sva:(float ptr) -> mv:int -> v:(Complex.t ptr) -> ldv:int -> stat:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgesvj : layout:int -> joba:char -> jobu:char -> jobv:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> sva:(float ptr) -> mv:int -> v:(Complex.t ptr) -> ldv:int -> stat:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgesvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int32 ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgesvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int32 ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgesvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgesvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgetf2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgetf2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgetf2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgetf2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgetrf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgetrf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgetrf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgetrf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgetrf2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgetrf2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgetrf2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgetrf2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgetri : layout:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgetri : layout:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgetri : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgetri : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgetrs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgetrs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgetrs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgetrs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggbak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> lscale:(float ptr) -> rscale:(float ptr) -> m:int -> v:(float ptr) -> ldv:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggbak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> lscale:(float ptr) -> rscale:(float ptr) -> m:int -> v:(float ptr) -> ldv:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggbak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> lscale:(float ptr) -> rscale:(float ptr) -> m:int -> v:(Complex.t ptr) -> ldv:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggbak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> lscale:(float ptr) -> rscale:(float ptr) -> m:int -> v:(Complex.t ptr) -> ldv:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggbal : layout:int -> job:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggbal : layout:int -> job:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggbal : layout:int -> job:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggbal : layout:int -> job:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgges : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int32 ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgges : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int32 ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgges : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int32 ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgges : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int32 ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgges3 : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int32 ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgges3 : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int32 ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgges3 : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int32 ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgges3 : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int32 ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggesx : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> sense:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int32 ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggesx : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> sense:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int32 ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggesx : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int32 ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggesx : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int32 ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggev3 : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggev3 : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggev3 : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggev3 : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> abnrm:(float ptr) -> bbnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> abnrm:(float ptr) -> bbnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> abnrm:(float ptr) -> bbnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> ilo:(int32 ptr) -> ihi:(int32 ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> abnrm:(float ptr) -> bbnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggglm : layout:int -> n:int -> m:int -> p:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> d:(float ptr) -> x:(float ptr) -> y:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggglm : layout:int -> n:int -> m:int -> p:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> d:(float ptr) -> x:(float ptr) -> y:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggglm : layout:int -> n:int -> m:int -> p:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> d:(Complex.t ptr) -> x:(Complex.t ptr) -> y:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggglm : layout:int -> n:int -> m:int -> p:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> d:(Complex.t ptr) -> x:(Complex.t ptr) -> y:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgghrd : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgghrd : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgghrd : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgghrd : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgghd3 : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgghd3 : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgghd3 : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgghd3 : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgglse : layout:int -> m:int -> n:int -> p:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> d:(float ptr) -> x:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgglse : layout:int -> m:int -> n:int -> p:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> d:(float ptr) -> x:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgglse : layout:int -> m:int -> n:int -> p:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> d:(Complex.t ptr) -> x:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgglse : layout:int -> m:int -> n:int -> p:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> d:(Complex.t ptr) -> x:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggqrf : layout:int -> n:int -> m:int -> p:int -> a:(float ptr) -> lda:int -> taua:(float ptr) -> b:(float ptr) -> ldb:int -> taub:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggqrf : layout:int -> n:int -> m:int -> p:int -> a:(float ptr) -> lda:int -> taua:(float ptr) -> b:(float ptr) -> ldb:int -> taub:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggqrf : layout:int -> n:int -> m:int -> p:int -> a:(Complex.t ptr) -> lda:int -> taua:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> taub:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggqrf : layout:int -> n:int -> m:int -> p:int -> a:(Complex.t ptr) -> lda:int -> taua:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> taub:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggrqf : layout:int -> m:int -> p:int -> n:int -> a:(float ptr) -> lda:int -> taua:(float ptr) -> b:(float ptr) -> ldb:int -> taub:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggrqf : layout:int -> m:int -> p:int -> n:int -> a:(float ptr) -> lda:int -> taua:(float ptr) -> b:(float ptr) -> ldb:int -> taub:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggrqf : layout:int -> m:int -> p:int -> n:int -> a:(Complex.t ptr) -> lda:int -> taua:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> taub:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggrqf : layout:int -> m:int -> p:int -> n:int -> a:(Complex.t ptr) -> lda:int -> taua:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> taub:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggsvd3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> n:int -> p:int -> k:(int32 ptr) -> l:(int32 ptr) -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alpha:(float ptr) -> beta:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> iwork:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggsvd3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> n:int -> p:int -> k:(int32 ptr) -> l:(int32 ptr) -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alpha:(float ptr) -> beta:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> iwork:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggsvd3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> n:int -> p:int -> k:(int32 ptr) -> l:(int32 ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(float ptr) -> beta:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> iwork:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggsvd3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> n:int -> p:int -> k:(int32 ptr) -> l:(int32 ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(float ptr) -> beta:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> iwork:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sggsvp3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> tola:float -> tolb:float -> k:(int32 ptr) -> l:(int32 ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dggsvp3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> tola:float -> tolb:float -> k:(int32 ptr) -> l:(int32 ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cggsvp3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> tola:float -> tolb:float -> k:(int32 ptr) -> l:(int32 ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zggsvp3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> tola:float -> tolb:float -> k:(int32 ptr) -> l:(int32 ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgtcon : norm:char -> n:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgtcon : norm:char -> n:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgtcon : norm:char -> n:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgtcon : norm:char -> n:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgtrfs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> dlf:(float ptr) -> df:(float ptr) -> duf:(float ptr) -> du2:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgtrfs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> dlf:(float ptr) -> df:(float ptr) -> duf:(float ptr) -> du2:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgtrfs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> dlf:(Complex.t ptr) -> df:(Complex.t ptr) -> duf:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgtrfs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> dlf:(Complex.t ptr) -> df:(Complex.t ptr) -> duf:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgtsv : layout:int -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgtsv : layout:int -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgtsv : layout:int -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgtsv : layout:int -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgtsvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> dlf:(float ptr) -> df:(float ptr) -> duf:(float ptr) -> du2:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgtsvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> dlf:(float ptr) -> df:(float ptr) -> duf:(float ptr) -> du2:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgtsvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> dlf:(Complex.t ptr) -> df:(Complex.t ptr) -> duf:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgtsvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> dlf:(Complex.t ptr) -> df:(Complex.t ptr) -> duf:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgttrf : n:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgttrf : n:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgttrf : n:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgttrf : n:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgttrs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgttrs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgttrs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgttrs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chbev : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhbev : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chbevd : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhbevd : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chbevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> q:(Complex.t ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhbevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> q:(Complex.t ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chbgst : layout:int -> vect:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> x:(Complex.t ptr) -> ldx:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhbgst : layout:int -> vect:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> x:(Complex.t ptr) -> ldx:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chbgv : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhbgv : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chbgvd : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhbgvd : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chbgvx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> q:(Complex.t ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhbgvx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> q:(Complex.t ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chbtrd : layout:int -> vect:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(Complex.t ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhbtrd : layout:int -> vect:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(Complex.t ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val checon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhecon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cheequb : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zheequb : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cheev : layout:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zheev : layout:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cheevd : layout:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zheevd : layout:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cheevr : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> isuppz:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zheevr : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> isuppz:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cheevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zheevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chegst : layout:int -> ityp:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhegst : layout:int -> ityp:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chegv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhegv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chegvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhegvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chegvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhegvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cherfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zherfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chesv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhesv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chesvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhesvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chetrd : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhetrd : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chetrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhetrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chetri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhetri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chetrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhetrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chfrk : layout:int -> transr:char -> uplo:char -> trans:char -> n:int -> k:int -> alpha:float -> a:(Complex.t ptr) -> lda:int -> beta:float -> c:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhfrk : layout:int -> transr:char -> uplo:char -> trans:char -> n:int -> k:int -> alpha:float -> a:(Complex.t ptr) -> lda:int -> beta:float -> c:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val shgeqz : layout:int -> job:char -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(float ptr) -> ldh:int -> t:(float ptr) -> ldt:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dhgeqz : layout:int -> job:char -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(float ptr) -> ldh:int -> t:(float ptr) -> ldt:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chgeqz : layout:int -> job:char -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(Complex.t ptr) -> ldh:int -> t:(Complex.t ptr) -> ldt:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhgeqz : layout:int -> job:char -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(Complex.t ptr) -> ldh:int -> t:(Complex.t ptr) -> ldt:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chpcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhpcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chpev : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhpev : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chpevd : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhpevd : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chpevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhpevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chpgst : layout:int -> ityp:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhpgst : layout:int -> ityp:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chpgv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhpgv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chpgvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhpgvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chpgvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhpgvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chpsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhpsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chpsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhpsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chptrd : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> d:(float ptr) -> e:(float ptr) -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhptrd : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> d:(float ptr) -> e:(float ptr) -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val shsein : layout:int -> job:char -> eigsrc:char -> initv:char -> select:(int32 ptr) -> n:int -> h:(float ptr) -> ldh:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> ifaill:(int32 ptr) -> ifailr:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dhsein : layout:int -> job:char -> eigsrc:char -> initv:char -> select:(int32 ptr) -> n:int -> h:(float ptr) -> ldh:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> ifaill:(int32 ptr) -> ifailr:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chsein : layout:int -> job:char -> eigsrc:char -> initv:char -> select:(int32 ptr) -> n:int -> h:(Complex.t ptr) -> ldh:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> ifaill:(int32 ptr) -> ifailr:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhsein : layout:int -> job:char -> eigsrc:char -> initv:char -> select:(int32 ptr) -> n:int -> h:(Complex.t ptr) -> ldh:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> ifaill:(int32 ptr) -> ifailr:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val shseqr : layout:int -> job:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(float ptr) -> ldh:int -> wr:(float ptr) -> wi:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dhseqr : layout:int -> job:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(float ptr) -> ldh:int -> wr:(float ptr) -> wi:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chseqr : layout:int -> job:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(Complex.t ptr) -> ldh:int -> w:(Complex.t ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhseqr : layout:int -> job:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(Complex.t ptr) -> ldh:int -> w:(Complex.t ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clacgv : n:int -> x:(Complex.t ptr) -> incx:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlacgv : n:int -> x:(Complex.t ptr) -> incx:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slacn2 : n:int -> v:(float ptr) -> x:(float ptr) -> isgn:(int32 ptr) -> est:(float ptr) -> kase:(int32 ptr) -> isave:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlacn2 : n:int -> v:(float ptr) -> x:(float ptr) -> isgn:(int32 ptr) -> est:(float ptr) -> kase:(int32 ptr) -> isave:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clacn2 : n:int -> v:(Complex.t ptr) -> x:(Complex.t ptr) -> est:(float ptr) -> kase:(int32 ptr) -> isave:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlacn2 : n:int -> v:(Complex.t ptr) -> x:(Complex.t ptr) -> est:(float ptr) -> kase:(int32 ptr) -> isave:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slacpy : layout:int -> uplo:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlacpy : layout:int -> uplo:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clacpy : layout:int -> uplo:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlacpy : layout:int -> uplo:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clacp2 : layout:int -> uplo:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlacp2 : layout:int -> uplo:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlag2c : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> sa:(Complex.t ptr) -> ldsa:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slag2d : layout:int -> m:int -> n:int -> sa:(float ptr) -> ldsa:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlag2s : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> sa:(float ptr) -> ldsa:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clag2z : layout:int -> m:int -> n:int -> sa:(Complex.t ptr) -> ldsa:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slagge : layout:int -> m:int -> n:int -> kl:int -> ku:int -> d:(float ptr) -> a:(float ptr) -> lda:int -> iseed:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlagge : layout:int -> m:int -> n:int -> kl:int -> ku:int -> d:(float ptr) -> a:(float ptr) -> lda:int -> iseed:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clagge : layout:int -> m:int -> n:int -> kl:int -> ku:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlagge : layout:int -> m:int -> n:int -> kl:int -> ku:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slarfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlarfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clarfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlarfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slarfg : n:int -> alpha:(float ptr) -> x:(float ptr) -> incx:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlarfg : n:int -> alpha:(float ptr) -> x:(float ptr) -> incx:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clarfg : n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlarfg : n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slarft : layout:int -> direct:char -> storev:char -> n:int -> k:int -> v:(float ptr) -> ldv:int -> tau:(float ptr) -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlarft : layout:int -> direct:char -> storev:char -> n:int -> k:int -> v:(float ptr) -> ldv:int -> tau:(float ptr) -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clarft : layout:int -> direct:char -> storev:char -> n:int -> k:int -> v:(Complex.t ptr) -> ldv:int -> tau:(Complex.t ptr) -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlarft : layout:int -> direct:char -> storev:char -> n:int -> k:int -> v:(Complex.t ptr) -> ldv:int -> tau:(Complex.t ptr) -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slarfx : layout:int -> side:char -> m:int -> n:int -> v:(float ptr) -> tau:float -> c:(float ptr) -> ldc:int -> work:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlarfx : layout:int -> side:char -> m:int -> n:int -> v:(float ptr) -> tau:float -> c:(float ptr) -> ldc:int -> work:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clarfx : layout:int -> side:char -> m:int -> n:int -> v:(Complex.t ptr) -> tau:Complex.t -> c:(Complex.t ptr) -> ldc:int -> work:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlarfx : layout:int -> side:char -> m:int -> n:int -> v:(Complex.t ptr) -> tau:Complex.t -> c:(Complex.t ptr) -> ldc:int -> work:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slarnv : idist:int -> iseed:(int32 ptr) -> n:int -> x:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlarnv : idist:int -> iseed:(int32 ptr) -> n:int -> x:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clarnv : idist:int -> iseed:(int32 ptr) -> n:int -> x:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlarnv : idist:int -> iseed:(int32 ptr) -> n:int -> x:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slascl : layout:int -> typ:char -> kl:int -> ku:int -> cfrom:float -> cto:float -> m:int -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlascl : layout:int -> typ:char -> kl:int -> ku:int -> cfrom:float -> cto:float -> m:int -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clascl : layout:int -> typ:char -> kl:int -> ku:int -> cfrom:float -> cto:float -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlascl : layout:int -> typ:char -> kl:int -> ku:int -> cfrom:float -> cto:float -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slaset : layout:int -> uplo:char -> m:int -> n:int -> alpha:float -> beta:float -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlaset : layout:int -> uplo:char -> m:int -> n:int -> alpha:float -> beta:float -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val claset : layout:int -> uplo:char -> m:int -> n:int -> alpha:Complex.t -> beta:Complex.t -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlaset : layout:int -> uplo:char -> m:int -> n:int -> alpha:Complex.t -> beta:Complex.t -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slasrt : id:char -> n:int -> d:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlasrt : id:char -> n:int -> d:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slaswp : layout:int -> n:int -> a:(float ptr) -> lda:int -> k1:int -> k2:int -> ipiv:(int32 ptr) -> incx:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlaswp : layout:int -> n:int -> a:(float ptr) -> lda:int -> k1:int -> k2:int -> ipiv:(int32 ptr) -> incx:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val claswp : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> k1:int -> k2:int -> ipiv:(int32 ptr) -> incx:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlaswp : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> k1:int -> k2:int -> ipiv:(int32 ptr) -> incx:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slatms : layout:int -> m:int -> n:int -> dist:char -> iseed:(int32 ptr) -> sym:char -> d:(float ptr) -> mode:int -> cond:float -> dmax:float -> kl:int -> ku:int -> pack:char -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlatms : layout:int -> m:int -> n:int -> dist:char -> iseed:(int32 ptr) -> sym:char -> d:(float ptr) -> mode:int -> cond:float -> dmax:float -> kl:int -> ku:int -> pack:char -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clatms : layout:int -> m:int -> n:int -> dist:char -> iseed:(int32 ptr) -> sym:char -> d:(float ptr) -> mode:int -> cond:float -> dmax:float -> kl:int -> ku:int -> pack:char -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlatms : layout:int -> m:int -> n:int -> dist:char -> iseed:(int32 ptr) -> sym:char -> d:(float ptr) -> mode:int -> cond:float -> dmax:float -> kl:int -> ku:int -> pack:char -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slauum : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlauum : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clauum : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlauum : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sopgtr : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> tau:(float ptr) -> q:(float ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dopgtr : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> tau:(float ptr) -> q:(float ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sopmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> ap:(float ptr) -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dopmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> ap:(float ptr) -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sorgbr : layout:int -> vect:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dorgbr : layout:int -> vect:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sorghr : layout:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dorghr : layout:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sorglq : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dorglq : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sorgql : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dorgql : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sorgqr : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dorgqr : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sorgrq : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dorgrq : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sorgtr : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dorgtr : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sormbr : layout:int -> vect:char -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dormbr : layout:int -> vect:char -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sormhr : layout:int -> side:char -> trans:char -> m:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dormhr : layout:int -> side:char -> trans:char -> m:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sormlq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dormlq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sormql : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dormql : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sormqr : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dormqr : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sormrq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dormrq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sormrz : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dormrz : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sormtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dormtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spbcon : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpbcon : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpbcon : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpbcon : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spbequ : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpbequ : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpbequ : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpbequ : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spbrfs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpbrfs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpbrfs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpbrfs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spbstf : layout:int -> uplo:char -> n:int -> kb:int -> bb:(float ptr) -> ldbb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpbstf : layout:int -> uplo:char -> n:int -> kb:int -> bb:(float ptr) -> ldbb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpbstf : layout:int -> uplo:char -> n:int -> kb:int -> bb:(Complex.t ptr) -> ldbb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpbstf : layout:int -> uplo:char -> n:int -> kb:int -> bb:(Complex.t ptr) -> ldbb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spbsv : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpbsv : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpbsv : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpbsv : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spbsvx : layout:int -> fact:char -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpbsvx : layout:int -> fact:char -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpbsvx : layout:int -> fact:char -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpbsvx : layout:int -> fact:char -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spbtrf : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpbtrf : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpbtrf : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpbtrf : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spbtrs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpbtrs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpbtrs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpbtrs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spftrf : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpftrf : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpftrf : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpftrf : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spftri : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpftri : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpftri : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpftri : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spftrs : layout:int -> transr:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpftrs : layout:int -> transr:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpftrs : layout:int -> transr:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpftrs : layout:int -> transr:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spocon : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpocon : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpocon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpocon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spoequ : layout:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpoequ : layout:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpoequ : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpoequ : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spoequb : layout:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpoequb : layout:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpoequb : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpoequb : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sporfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dporfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cporfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zporfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> iter:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zcposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> iter:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sposvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dposvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cposvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zposvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spotrf2 : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpotrf2 : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpotrf2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpotrf2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spotrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpotrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpotrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpotrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spotri : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpotri : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpotri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpotri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spotrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpotrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpotrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpotrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sppcon : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dppcon : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cppcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zppcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sppequ : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dppequ : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cppequ : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zppequ : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sppsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dppsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cppsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zppsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sppsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dppsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cppsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zppsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spptrf : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpptrf : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spptri : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpptri : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spstrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> piv:(int32 ptr) -> rank:(int32 ptr) -> tol:float -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpstrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> piv:(int32 ptr) -> rank:(int32 ptr) -> tol:float -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpstrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> piv:(int32 ptr) -> rank:(int32 ptr) -> tol:float -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpstrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> piv:(int32 ptr) -> rank:(int32 ptr) -> tol:float -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sptcon : n:int -> d:(float ptr) -> e:(float ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dptcon : n:int -> d:(float ptr) -> e:(float ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cptcon : n:int -> d:(float ptr) -> e:(Complex.t ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zptcon : n:int -> d:(float ptr) -> e:(Complex.t ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sptrfs : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> df:(float ptr) -> ef:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dptrfs : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> df:(float ptr) -> ef:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cptrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> df:(float ptr) -> ef:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zptrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> df:(float ptr) -> ef:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sptsv : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dptsv : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cptsv : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zptsv : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sptsvx : layout:int -> fact:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> df:(float ptr) -> ef:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dptsvx : layout:int -> fact:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> df:(float ptr) -> ef:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cptsvx : layout:int -> fact:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> df:(float ptr) -> ef:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zptsvx : layout:int -> fact:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> df:(float ptr) -> ef:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spttrf : n:int -> d:(float ptr) -> e:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpttrf : n:int -> d:(float ptr) -> e:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpttrf : n:int -> d:(float ptr) -> e:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpttrf : n:int -> d:(float ptr) -> e:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val spttrs : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dpttrs : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cpttrs : layout:int -> uplo:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zpttrs : layout:int -> uplo:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssbev : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsbev : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssbevd : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsbevd : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssbevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> q:(float ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsbevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> q:(float ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssbgst : layout:int -> vect:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> x:(float ptr) -> ldx:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsbgst : layout:int -> vect:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> x:(float ptr) -> ldx:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssbgv : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsbgv : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssbgvd : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsbgvd : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssbgvx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> q:(float ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsbgvx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> q:(float ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssbtrd : layout:int -> vect:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(float ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsbtrd : layout:int -> vect:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(float ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssfrk : layout:int -> transr:char -> uplo:char -> trans:char -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> beta:float -> c:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsfrk : layout:int -> transr:char -> uplo:char -> trans:char -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> beta:float -> c:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sspcon : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dspcon : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cspcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zspcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sspev : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dspev : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sspevd : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dspevd : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sspevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dspevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sspgst : layout:int -> ityp:int -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dspgst : layout:int -> ityp:int -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sspgv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dspgv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sspgvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dspgvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sspgvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dspgvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sspsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dspsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cspsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zspsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sspsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dspsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cspsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zspsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssptrd : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> d:(float ptr) -> e:(float ptr) -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsptrd : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> d:(float ptr) -> e:(float ptr) -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssptrf : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsptrf : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssptri : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsptri : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sstebz : range:char -> order:char -> n:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> d:(float ptr) -> e:(float ptr) -> m:(int32 ptr) -> nsplit:(int32 ptr) -> w:(float ptr) -> iblock:(int32 ptr) -> isplit:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dstebz : range:char -> order:char -> n:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> d:(float ptr) -> e:(float ptr) -> m:(int32 ptr) -> nsplit:(int32 ptr) -> w:(float ptr) -> iblock:(int32 ptr) -> isplit:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sstedc : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dstedc : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cstedc : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zstedc : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sstegr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dstegr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cstegr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> isuppz:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zstegr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> isuppz:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sstein : layout:int -> n:int -> d:(float ptr) -> e:(float ptr) -> m:int -> w:(float ptr) -> iblock:(int32 ptr) -> isplit:(int32 ptr) -> z:(float ptr) -> ldz:int -> ifailv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dstein : layout:int -> n:int -> d:(float ptr) -> e:(float ptr) -> m:int -> w:(float ptr) -> iblock:(int32 ptr) -> isplit:(int32 ptr) -> z:(float ptr) -> ldz:int -> ifailv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cstein : layout:int -> n:int -> d:(float ptr) -> e:(float ptr) -> m:int -> w:(float ptr) -> iblock:(int32 ptr) -> isplit:(int32 ptr) -> z:(Complex.t ptr) -> ldz:int -> ifailv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zstein : layout:int -> n:int -> d:(float ptr) -> e:(float ptr) -> m:int -> w:(float ptr) -> iblock:(int32 ptr) -> isplit:(int32 ptr) -> z:(Complex.t ptr) -> ldz:int -> ifailv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sstemr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> nzc:int -> isuppz:(int32 ptr) -> tryrac:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dstemr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> nzc:int -> isuppz:(int32 ptr) -> tryrac:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cstemr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> nzc:int -> isuppz:(int32 ptr) -> tryrac:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zstemr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> m:(int32 ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> nzc:int -> isuppz:(int32 ptr) -> tryrac:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssterf : n:int -> d:(float ptr) -> e:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsterf : n:int -> d:(float ptr) -> e:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sstev : layout:int -> jobz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dstev : layout:int -> jobz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sstevd : layout:int -> jobz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dstevd : layout:int -> jobz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sstevr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dstevr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sstevx : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dstevx : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssycon : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsycon : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csycon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsycon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> anorm:float -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssyequb : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsyequb : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csyequb : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsyequb : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssyev : layout:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsyev : layout:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssyevd : layout:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsyevd : layout:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssyevr : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsyevr : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssyevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsyevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssygst : layout:int -> ityp:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsygst : layout:int -> ityp:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssygv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsygv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssygvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsygvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> w:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssygvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsygvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int32 ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssyrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsyrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csyrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsyrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssysv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsysv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csysv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsysv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssysvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsysvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csysvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsysvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssytrd : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsytrd : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssytrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsytrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csytrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsytrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssytri : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsytri : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csytri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsytri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssytrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsytrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csytrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsytrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stbcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtbcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctbcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztbcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stbrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtbrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctbrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztbrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stbtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtbtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctbtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztbtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stfsm : layout:int -> transr:char -> side:char -> uplo:char -> trans:char -> diag:char -> m:int -> n:int -> alpha:float -> a:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtfsm : layout:int -> transr:char -> side:char -> uplo:char -> trans:char -> diag:char -> m:int -> n:int -> alpha:float -> a:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctfsm : layout:int -> transr:char -> side:char -> uplo:char -> trans:char -> diag:char -> m:int -> n:int -> alpha:Complex.t -> a:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztfsm : layout:int -> transr:char -> side:char -> uplo:char -> trans:char -> diag:char -> m:int -> n:int -> alpha:Complex.t -> a:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stftri : layout:int -> transr:char -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtftri : layout:int -> transr:char -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctftri : layout:int -> transr:char -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztftri : layout:int -> transr:char -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stfttp : layout:int -> transr:char -> uplo:char -> n:int -> arf:(float ptr) -> ap:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtfttp : layout:int -> transr:char -> uplo:char -> n:int -> arf:(float ptr) -> ap:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctfttp : layout:int -> transr:char -> uplo:char -> n:int -> arf:(Complex.t ptr) -> ap:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztfttp : layout:int -> transr:char -> uplo:char -> n:int -> arf:(Complex.t ptr) -> ap:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stfttr : layout:int -> transr:char -> uplo:char -> n:int -> arf:(float ptr) -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtfttr : layout:int -> transr:char -> uplo:char -> n:int -> arf:(float ptr) -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctfttr : layout:int -> transr:char -> uplo:char -> n:int -> arf:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztfttr : layout:int -> transr:char -> uplo:char -> n:int -> arf:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stgevc : layout:int -> side:char -> howmny:char -> select:(int32 ptr) -> n:int -> s:(float ptr) -> lds:int -> p:(float ptr) -> ldp:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtgevc : layout:int -> side:char -> howmny:char -> select:(int32 ptr) -> n:int -> s:(float ptr) -> lds:int -> p:(float ptr) -> ldp:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctgevc : layout:int -> side:char -> howmny:char -> select:(int32 ptr) -> n:int -> s:(Complex.t ptr) -> lds:int -> p:(Complex.t ptr) -> ldp:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztgevc : layout:int -> side:char -> howmny:char -> select:(int32 ptr) -> n:int -> s:(Complex.t ptr) -> lds:int -> p:(Complex.t ptr) -> ldp:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stgexc : layout:int -> wantq:int -> wantz:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> ifst:(int32 ptr) -> ilst:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtgexc : layout:int -> wantq:int -> wantz:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> ifst:(int32 ptr) -> ilst:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctgexc : layout:int -> wantq:int -> wantz:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> ifst:int -> ilst:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztgexc : layout:int -> wantq:int -> wantz:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> ifst:int -> ilst:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stgsen : layout:int -> ijob:int -> wantq:int -> wantz:int -> select:(int32 ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> m:(int32 ptr) -> pl:(float ptr) -> pr:(float ptr) -> dif:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtgsen : layout:int -> ijob:int -> wantq:int -> wantz:int -> select:(int32 ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> m:(int32 ptr) -> pl:(float ptr) -> pr:(float ptr) -> dif:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctgsen : layout:int -> ijob:int -> wantq:int -> wantz:int -> select:(int32 ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> m:(int32 ptr) -> pl:(float ptr) -> pr:(float ptr) -> dif:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztgsen : layout:int -> ijob:int -> wantq:int -> wantz:int -> select:(int32 ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> m:(int32 ptr) -> pl:(float ptr) -> pr:(float ptr) -> dif:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stgsja : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> k:int -> l:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> tola:float -> tolb:float -> alpha:(float ptr) -> beta:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> ncycle:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtgsja : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> k:int -> l:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> tola:float -> tolb:float -> alpha:(float ptr) -> beta:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> ncycle:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctgsja : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> k:int -> l:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> tola:float -> tolb:float -> alpha:(float ptr) -> beta:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> ncycle:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztgsja : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> k:int -> l:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> tola:float -> tolb:float -> alpha:(float ptr) -> beta:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> ncycle:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stgsna : layout:int -> job:char -> howmny:char -> select:(int32 ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> s:(float ptr) -> dif:(float ptr) -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtgsna : layout:int -> job:char -> howmny:char -> select:(int32 ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> s:(float ptr) -> dif:(float ptr) -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctgsna : layout:int -> job:char -> howmny:char -> select:(int32 ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> s:(float ptr) -> dif:(float ptr) -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztgsna : layout:int -> job:char -> howmny:char -> select:(int32 ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> s:(float ptr) -> dif:(float ptr) -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stgsyl : layout:int -> trans:char -> ijob:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> ldc:int -> d:(float ptr) -> ldd:int -> e:(float ptr) -> lde:int -> f:(float ptr) -> ldf:int -> scale:(float ptr) -> dif:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtgsyl : layout:int -> trans:char -> ijob:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> ldc:int -> d:(float ptr) -> ldd:int -> e:(float ptr) -> lde:int -> f:(float ptr) -> ldf:int -> scale:(float ptr) -> dif:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctgsyl : layout:int -> trans:char -> ijob:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> ldc:int -> d:(Complex.t ptr) -> ldd:int -> e:(Complex.t ptr) -> lde:int -> f:(Complex.t ptr) -> ldf:int -> scale:(float ptr) -> dif:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztgsyl : layout:int -> trans:char -> ijob:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> ldc:int -> d:(Complex.t ptr) -> ldd:int -> e:(Complex.t ptr) -> lde:int -> f:(Complex.t ptr) -> ldf:int -> scale:(float ptr) -> dif:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stpcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> ap:(float ptr) -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtpcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> ap:(float ptr) -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctpcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> ap:(Complex.t ptr) -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztpcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> ap:(Complex.t ptr) -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stprfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtprfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctprfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztprfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stptri : layout:int -> uplo:char -> diag:char -> n:int -> ap:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtptri : layout:int -> uplo:char -> diag:char -> n:int -> ap:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctptri : layout:int -> uplo:char -> diag:char -> n:int -> ap:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztptri : layout:int -> uplo:char -> diag:char -> n:int -> ap:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stptrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtptrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctptrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztptrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stpttf : layout:int -> transr:char -> uplo:char -> n:int -> ap:(float ptr) -> arf:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtpttf : layout:int -> transr:char -> uplo:char -> n:int -> ap:(float ptr) -> arf:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctpttf : layout:int -> transr:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> arf:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztpttf : layout:int -> transr:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> arf:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stpttr : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtpttr : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctpttr : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztpttr : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> lda:int -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> lda:int -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> lda:int -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> lda:int -> rcond:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strevc : layout:int -> side:char -> howmny:char -> select:(int32 ptr) -> n:int -> t:(float ptr) -> ldt:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrevc : layout:int -> side:char -> howmny:char -> select:(int32 ptr) -> n:int -> t:(float ptr) -> ldt:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrevc : layout:int -> side:char -> howmny:char -> select:(int32 ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrevc : layout:int -> side:char -> howmny:char -> select:(int32 ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strexc : layout:int -> compq:char -> n:int -> t:(float ptr) -> ldt:int -> q:(float ptr) -> ldq:int -> ifst:(int32 ptr) -> ilst:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrexc : layout:int -> compq:char -> n:int -> t:(float ptr) -> ldt:int -> q:(float ptr) -> ldq:int -> ifst:(int32 ptr) -> ilst:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrexc : layout:int -> compq:char -> n:int -> t:(Complex.t ptr) -> ldt:int -> q:(Complex.t ptr) -> ldq:int -> ifst:int -> ilst:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrexc : layout:int -> compq:char -> n:int -> t:(Complex.t ptr) -> ldt:int -> q:(Complex.t ptr) -> ldq:int -> ifst:int -> ilst:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strsen : layout:int -> job:char -> compq:char -> select:(int32 ptr) -> n:int -> t:(float ptr) -> ldt:int -> q:(float ptr) -> ldq:int -> wr:(float ptr) -> wi:(float ptr) -> m:(int32 ptr) -> s:(float ptr) -> sep:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrsen : layout:int -> job:char -> compq:char -> select:(int32 ptr) -> n:int -> t:(float ptr) -> ldt:int -> q:(float ptr) -> ldq:int -> wr:(float ptr) -> wi:(float ptr) -> m:(int32 ptr) -> s:(float ptr) -> sep:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrsen : layout:int -> job:char -> compq:char -> select:(int32 ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> q:(Complex.t ptr) -> ldq:int -> w:(Complex.t ptr) -> m:(int32 ptr) -> s:(float ptr) -> sep:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrsen : layout:int -> job:char -> compq:char -> select:(int32 ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> q:(Complex.t ptr) -> ldq:int -> w:(Complex.t ptr) -> m:(int32 ptr) -> s:(float ptr) -> sep:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strsna : layout:int -> job:char -> howmny:char -> select:(int32 ptr) -> n:int -> t:(float ptr) -> ldt:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> s:(float ptr) -> sep:(float ptr) -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrsna : layout:int -> job:char -> howmny:char -> select:(int32 ptr) -> n:int -> t:(float ptr) -> ldt:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> s:(float ptr) -> sep:(float ptr) -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrsna : layout:int -> job:char -> howmny:char -> select:(int32 ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> s:(float ptr) -> sep:(float ptr) -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrsna : layout:int -> job:char -> howmny:char -> select:(int32 ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> s:(float ptr) -> sep:(float ptr) -> mm:int -> m:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strsyl : layout:int -> trana:char -> tranb:char -> isgn:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> ldc:int -> scale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrsyl : layout:int -> trana:char -> tranb:char -> isgn:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> ldc:int -> scale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrsyl : layout:int -> trana:char -> tranb:char -> isgn:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> ldc:int -> scale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrsyl : layout:int -> trana:char -> tranb:char -> isgn:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> ldc:int -> scale:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strtri : layout:int -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrtri : layout:int -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrtri : layout:int -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrtri : layout:int -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strttf : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> arf:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrttf : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> arf:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrttf : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> arf:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrttf : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> arf:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val strttp : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ap:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtrttp : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ap:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctrttp : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ap:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztrttp : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ap:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stzrzf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtzrzf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctzrzf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztzrzf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cungbr : layout:int -> vect:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zungbr : layout:int -> vect:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunghr : layout:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunghr : layout:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunglq : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunglq : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cungql : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zungql : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cungqr : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zungqr : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cungrq : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zungrq : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cungtr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zungtr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunmbr : layout:int -> vect:char -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunmbr : layout:int -> vect:char -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunmhr : layout:int -> side:char -> trans:char -> m:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunmhr : layout:int -> side:char -> trans:char -> m:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunmlq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunmlq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunmql : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunmql : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunmqr : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunmqr : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunmrq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunmrq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunmrz : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunmrz : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cupgtr : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> tau:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zupgtr : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> tau:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cupmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> ap:(Complex.t ptr) -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zupmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> ap:(Complex.t ptr) -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val claghe : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlaghe : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slagsy : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(float ptr) -> lda:int -> iseed:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlagsy : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(float ptr) -> lda:int -> iseed:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clagsy : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlagsy : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slapmr : layout:int -> forwrd:int -> m:int -> n:int -> x:(float ptr) -> ldx:int -> k:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlapmr : layout:int -> forwrd:int -> m:int -> n:int -> x:(float ptr) -> ldx:int -> k:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clapmr : layout:int -> forwrd:int -> m:int -> n:int -> x:(Complex.t ptr) -> ldx:int -> k:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlapmr : layout:int -> forwrd:int -> m:int -> n:int -> x:(Complex.t ptr) -> ldx:int -> k:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slapmt : layout:int -> forwrd:int -> m:int -> n:int -> x:(float ptr) -> ldx:int -> k:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlapmt : layout:int -> forwrd:int -> m:int -> n:int -> x:(float ptr) -> ldx:int -> k:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val clapmt : layout:int -> forwrd:int -> m:int -> n:int -> x:(Complex.t ptr) -> ldx:int -> k:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zlapmt : layout:int -> forwrd:int -> m:int -> n:int -> x:(Complex.t ptr) -> ldx:int -> k:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slartgp : f:float -> g:float -> cs:(float ptr) -> sn:(float ptr) -> r:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlartgp : f:float -> g:float -> cs:(float ptr) -> sn:(float ptr) -> r:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val slartgs : x:float -> y:float -> sigma:float -> cs:(float ptr) -> sn:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dlartgs : x:float -> y:float -> sigma:float -> cs:(float ptr) -> sn:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cbbcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> m:int -> p:int -> q:int -> theta:(float ptr) -> phi:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> v2t:(Complex.t ptr) -> ldv2t:int -> b11d:(float ptr) -> b11e:(float ptr) -> b12d:(float ptr) -> b12e:(float ptr) -> b21d:(float ptr) -> b21e:(float ptr) -> b22d:(float ptr) -> b22e:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cheswapr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> i1:int -> i2:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chetri2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chetri2x : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> nb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chetrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csyconv : layout:int -> uplo:char -> way:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> e:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csyswapr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> i1:int -> i2:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csytri2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csytri2x : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> nb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csytrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cunbdb : layout:int -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x12:(Complex.t ptr) -> ldx12:int -> x21:(Complex.t ptr) -> ldx21:int -> x22:(Complex.t ptr) -> ldx22:int -> theta:(float ptr) -> phi:(float ptr) -> taup1:(Complex.t ptr) -> taup2:(Complex.t ptr) -> tauq1:(Complex.t ptr) -> tauq2:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cuncsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x12:(Complex.t ptr) -> ldx12:int -> x21:(Complex.t ptr) -> ldx21:int -> x22:(Complex.t ptr) -> ldx22:int -> theta:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> v2t:(Complex.t ptr) -> ldv2t:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cuncsd2by1 : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x21:(Complex.t ptr) -> ldx21:int -> theta:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dbbcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> m:int -> p:int -> q:int -> theta:(float ptr) -> phi:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> v2t:(float ptr) -> ldv2t:int -> b11d:(float ptr) -> b11e:(float ptr) -> b12d:(float ptr) -> b12e:(float ptr) -> b21d:(float ptr) -> b21e:(float ptr) -> b22d:(float ptr) -> b22e:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dorbdb : layout:int -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x12:(float ptr) -> ldx12:int -> x21:(float ptr) -> ldx21:int -> x22:(float ptr) -> ldx22:int -> theta:(float ptr) -> phi:(float ptr) -> taup1:(float ptr) -> taup2:(float ptr) -> tauq1:(float ptr) -> tauq2:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dorcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x12:(float ptr) -> ldx12:int -> x21:(float ptr) -> ldx21:int -> x22:(float ptr) -> ldx22:int -> theta:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> v2t:(float ptr) -> ldv2t:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dorcsd2by1 : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x21:(float ptr) -> ldx21:int -> theta:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsyconv : layout:int -> uplo:char -> way:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> e:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsyswapr : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> i1:int -> i2:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsytri2 : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsytri2x : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> nb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsytrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sbbcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> m:int -> p:int -> q:int -> theta:(float ptr) -> phi:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> v2t:(float ptr) -> ldv2t:int -> b11d:(float ptr) -> b11e:(float ptr) -> b12d:(float ptr) -> b12e:(float ptr) -> b21d:(float ptr) -> b21e:(float ptr) -> b22d:(float ptr) -> b22e:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sorbdb : layout:int -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x12:(float ptr) -> ldx12:int -> x21:(float ptr) -> ldx21:int -> x22:(float ptr) -> ldx22:int -> theta:(float ptr) -> phi:(float ptr) -> taup1:(float ptr) -> taup2:(float ptr) -> tauq1:(float ptr) -> tauq2:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sorcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x12:(float ptr) -> ldx12:int -> x21:(float ptr) -> ldx21:int -> x22:(float ptr) -> ldx22:int -> theta:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> v2t:(float ptr) -> ldv2t:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sorcsd2by1 : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x21:(float ptr) -> ldx21:int -> theta:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssyconv : layout:int -> uplo:char -> way:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> e:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssyswapr : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> i1:int -> i2:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssytri2 : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssytri2x : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> nb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssytrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zbbcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> m:int -> p:int -> q:int -> theta:(float ptr) -> phi:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> v2t:(Complex.t ptr) -> ldv2t:int -> b11d:(float ptr) -> b11e:(float ptr) -> b12d:(float ptr) -> b12e:(float ptr) -> b21d:(float ptr) -> b21e:(float ptr) -> b22d:(float ptr) -> b22e:(float ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zheswapr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> i1:int -> i2:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhetri2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhetri2x : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> nb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhetrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsyconv : layout:int -> uplo:char -> way:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> e:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsyswapr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> i1:int -> i2:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsytri2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsytri2x : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> nb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsytrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zunbdb : layout:int -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x12:(Complex.t ptr) -> ldx12:int -> x21:(Complex.t ptr) -> ldx21:int -> x22:(Complex.t ptr) -> ldx22:int -> theta:(float ptr) -> phi:(float ptr) -> taup1:(Complex.t ptr) -> taup2:(Complex.t ptr) -> tauq1:(Complex.t ptr) -> tauq2:(Complex.t ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zuncsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x12:(Complex.t ptr) -> ldx12:int -> x21:(Complex.t ptr) -> ldx21:int -> x22:(Complex.t ptr) -> ldx22:int -> theta:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> v2t:(Complex.t ptr) -> ldv2t:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zuncsd2by1 : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x21:(Complex.t ptr) -> ldx21:int -> theta:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgemqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> nb:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgemqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> nb:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> c:(float ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgemqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> nb:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgemqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> nb:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> c:(Complex.t ptr) -> ldc:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeqrt : layout:int -> m:int -> n:int -> nb:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeqrt : layout:int -> m:int -> n:int -> nb:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeqrt : layout:int -> m:int -> n:int -> nb:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeqrt : layout:int -> m:int -> n:int -> nb:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeqrt2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeqrt2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeqrt2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeqrt2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val sgeqrt3 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dgeqrt3 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val cgeqrt3 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zgeqrt3 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stpmqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> nb:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtpmqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> nb:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctpmqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> nb:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztpmqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> nb:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stpqrt : layout:int -> m:int -> n:int -> l:int -> nb:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtpqrt : layout:int -> m:int -> n:int -> l:int -> nb:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctpqrt : layout:int -> m:int -> n:int -> l:int -> nb:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztpqrt : layout:int -> m:int -> n:int -> l:int -> nb:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stpqrt2 : layout:int -> m:int -> n:int -> l:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtpqrt2 : layout:int -> m:int -> n:int -> l:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> t:(float ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctpqrt2 : layout:int -> m:int -> n:int -> l:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztpqrt2 : layout:int -> m:int -> n:int -> l:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> t:(Complex.t ptr) -> ldt:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val stprfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> l:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dtprfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> l:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ctprfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> l:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ztprfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> l:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssysv_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsysv_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csysv_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsysv_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssytrf_rook : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsytrf_rook : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csytrf_rook : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsytrf_rook : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val ssytrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val dsytrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(float ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csytrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsytrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chetrf_rook : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhetrf_rook : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val chetrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zhetrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int32 ptr) -> b:(Complex.t ptr) -> ldb:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val csyr : layout:int -> uplo:char -> n:int -> alpha:Complex.t -> x:(Complex.t ptr) -> incx:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)

val zsyr : layout:int -> uplo:char -> n:int -> alpha:Complex.t -> x:(Complex.t ptr) -> incx:int -> a:(Complex.t ptr) -> lda:int -> int
(** Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_ *)
