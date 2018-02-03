(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray


(** {6 Type definition} *)

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t
(** Default data type *)

type lapacke_layout = RowMajor | ColMajor
(** Layout type. *)

type lapacke_transpose = NoTrans | Trans | ConjTrans
(** Transpose type. *)

type lapacke_uplo = Upper | Lower
(** Upper or lower trangular. *)

type lapacke_diag = NonUnit | Unit
(** Diangonal type. *)

type lapacke_side = Left | Right
(** Side type. *)


(** {6 Basic functions} *)

val gbtrs : trans:lapacke_transpose -> kl:int -> ku:int -> n:int -> ab:('a, 'b) t -> ipiv:(int32, int32_elt) t -> b:('a, 'b) t -> unit
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gebal : ?job:char -> a:('a, 'b) t -> int * int * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gebak : job:char -> side:char -> ilo:int -> ihi:int -> scale:float Ctypes.ptr -> v:('a, 'b) t -> unit
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gebrd : a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gelqf : a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val geqlf : a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val geqrf : a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gerqf : a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val geqp3 : ?jpvt:(int32, int32_elt) t -> a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * (int32, int32_elt) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val geqrt : nb:int -> a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val geqrt3 : a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val getrf : a:('a, 'b) t -> ('a, 'b) t * (int32, int32_elt) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val tzrzf : a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val ormrz : side:char -> trans:char -> a:(float, 'a) t -> tau:(float, 'a) t -> c:(float, 'a) t -> (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gels : trans:char -> a:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gesv : a:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * (int32, int32_elt) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val getrs : trans:char -> a:('a, 'b) t -> ipiv:(int32, int32_elt) t -> b:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val getri : a:('a, 'b) t -> ipiv:(int32, int32_elt) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gesvx : fact:char -> trans:char -> a:('a, 'b) t -> af:('a, 'b) t -> ipiv:(int32, int32_elt) t -> equed:char -> r:('a, 'b) t -> c:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t * char * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * 'a * ('a, 'b) t * ('a, 'b) t * 'a
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gelsd : a:('a, 'b) t -> b:('a, 'b) t -> rcond:float -> ('a, 'b) t * int
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gelsy : a:('a, 'b) t -> b:('a, 'b) t -> rcond:float -> ('a, 'b) t * int
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gglse : a:('a, 'b) t -> b:('a, 'b) t -> c:('a, 'b) t -> d:('a, 'b) t -> ('a, 'b) t * 'a
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val geev : jobvl:char -> jobvr:char -> a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gesdd : ?jobz:char -> a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gesvd : ?jobu:char -> ?jobvt:char -> a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val ggsvd3 : ?jobu:char -> ?jobv:char -> ?jobq:char -> a:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t *  int * int * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val geevx : balanc:char -> jobvl:char -> jobvr:char -> sense:char -> a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t *  int * int * ('a, 'b) t * float * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val ggev : jobvl:char -> jobvr:char -> a:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gtsv : dl:('a, 'b) t -> d:('a, 'b) t -> du:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gttrf : dl:('a, 'b) t -> d:('a, 'b) t -> du:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * (int32, int32_elt) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gttrs : trans:char -> dl:('a, 'b) t -> d:('a, 'b) t -> du:('a, 'b) t -> du2:('a, 'b) t -> ipiv:(int32, int32_elt) t -> b:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val orglq : ?k:int -> a:(float, 'a) t -> tau:(float, 'a) t -> (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val unglq : ?k:int -> a:(Complex.t, 'a) t -> tau:(Complex.t, 'a) t -> (Complex.t, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val orgqr : ?k:int -> a:(float, 'a) t -> tau:(float, 'a) t -> (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val ungqr : ?k:int -> a:(Complex.t, 'a) t -> tau:(Complex.t, 'a) t -> (Complex.t, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val orgql : ?k:int -> a:(float, 'a) t -> tau:(float, 'a) t -> (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val orgrq : ?k:int -> a:(float, 'a) t -> tau:(float, 'a) t -> (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val ormlq : side:char -> trans:char -> a:(float, 'a) t -> tau:(float, 'a) t -> c:(float, 'a) t -> (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val ormqr : side:char -> trans:char -> a:(float, 'a) t -> tau:(float, 'a) t -> c:(float, 'a) t -> (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val ormql : side:char -> trans:char -> a:(float, 'a) t -> tau:(float, 'a) t -> c:(float, 'a) t -> (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val ormrq : side:char -> trans:char -> a:(float, 'a) t -> tau:(float, 'a) t -> c:(float, 'a) t -> (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gemqrt : side:char -> trans:char -> v:('a, 'b) t -> t:('a, 'b) t -> c:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val posv : uplo:char -> a:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val potrf : uplo:char -> a:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val potri : uplo:char -> a:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val potrs : uplo:char -> a:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val pstrf : uplo:char -> a:('a, 'b) t -> tol:'a -> ('a, 'b) t * (int32, int32_elt) t * int * int
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val ptsv : d:('a, 'b) t -> e:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val pttrf : d:('a, 'b) t -> e:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val pttrs : ?uplo:char -> d:('a, 'b) t -> e:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val trtri : uplo:char -> diag:char -> a:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val trtrs : uplo:char -> trans:char -> diag:char -> a:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val trcon : norm:char -> uplo:char -> diag:char -> a:('a, 'b) t -> float
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val trevc : side:char -> howmny:char -> select:(int32, int32_elt) t -> t:('a, 'b) t -> (int32, int32_elt) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val trrfs : uplo:char -> trans:char -> diag:char -> a:('a, 'b) t -> b:('a, 'b) t -> x:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val stev : jobz:char -> d:(float, 'a) t -> e:(float, 'a) t -> (float, 'a) t * (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val stebz : range:char -> order:char -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> d:(float, 'a) t -> e:(float, 'a) t -> (float, 'a) t * (int32, int32_elt) t * (int32, int32_elt) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val stegr : kind:('a, 'b) kind -> jobz:char -> range:char -> d:(float, 'b) t -> e:(float, 'b) t -> vl:float -> vu:float -> il:int -> iu:int -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val stein : kind:('a, 'b) kind -> d:(float, 'b) t -> e:(float, 'b) t -> w:(float, 'b) t -> iblock:(int32, int32_elt) t -> isplit:(int32, int32_elt) t -> ('a, 'b) t * (int32, int32_elt) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val syconv : uplo:char -> way:char -> a:('a, 'b) t -> ipiv:(int32, int32_elt) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val sysv : uplo:char -> a:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * (int32, int32_elt) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val sytrf : uplo:char -> a:('a, 'b) t -> ('a, 'b) t * (int32, int32_elt) t * int
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val sytrf_rook : uplo:char -> a:('a, 'b) t -> ('a, 'b) t * (int32, int32_elt) t * int
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val sytri : uplo:char -> a:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val sytrs : uplo:char -> a:('a, 'b) t -> ipiv:(int32, int32_elt) t -> b:('a, 'b) t -> ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val hesv : uplo:char -> a:(Complex.t, 'a) t -> b:(Complex.t, 'a) t -> (Complex.t, 'a) t * (Complex.t, 'a) t * (int32, int32_elt) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val hetrf : uplo:char -> a:('a, 'b) t -> ('a, 'b) t * (int32, int32_elt) t * int
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val hetrf_rook : uplo:char -> a:('a, 'b) t -> ('a, 'b) t * (int32, int32_elt) t * int
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val hetri : uplo:char -> a:(Complex.t, 'a) t -> ipiv:(int32, int32_elt) t -> (Complex.t, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val hetrs : uplo:char -> a:(Complex.t, 'a) t -> ipiv:(int32, int32_elt) t -> b:(Complex.t, 'a) t -> (Complex.t, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val syev : jobz:char -> uplo:char -> a:(float, 'a) t -> (float, 'a) t * (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val syevr : jobz:char -> range:char -> uplo:char -> a:(float, 'a) t -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> (float, 'a) t * (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val sygvd : ityp:int -> jobz:char -> uplo:char -> a:(float, 'a) t -> b:(float, 'a) t -> (float, 'a) t * (float, 'a) t * (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val bdsqr : uplo:char -> d:(float, 'b) t -> e:(float, 'b) t -> vt:('a, 'b) t -> u:('a, 'b) t -> c:('a, 'b) t -> (float, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val bdsdc : uplo:char -> compq:char -> d:(float, 'a) t -> e:(float, 'a) t -> (float, 'a) t * (float, 'a) t * (float, 'a) t * (float, 'a) t * (float, 'a) t * (int32, int32_elt) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gecon : norm:char -> a:('a, 'b) t -> anorm:float -> float
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gehrd : ilo:int -> ihi:int -> a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val orghr : ilo:int -> ihi:int -> a:(float, 'a) t -> tau:(float, 'a) t -> (float, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val unghr : ilo:int -> ihi:int -> a:(Complex.t, 'a) t -> tau:(Complex.t, 'a) t -> (Complex.t, 'a) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gees : jobvs:char -> a:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val gges : jobvsl:char -> jobvsr:char -> a:('a, 'b) t -> b:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val trexc : compq:char -> t:('a, 'b) t -> q:('a, 'b) t -> ifst:int -> ilst:int -> ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val trsen : job:char -> compq:char -> select:(int32, int32_elt) t -> t:('a, 'b) t -> q:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val tgsen : select:(int32, int32_elt) t -> a:('a, 'b) t -> b:('a, 'b) t -> q:('a, 'b) t -> z:('a, 'b) t -> ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t * ('a, 'b) t
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)

val trsyl : trana:char -> tranb:char -> isgn:int -> a:('a, 'b) t -> b:('a, 'b) t -> c:('a, 'b) t -> ('a, 'b) t * float
(**
Refer to `Intel MKL C Reference <https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines>`_
 *)
