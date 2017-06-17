(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* auto-generated lapacke interface file, timestamp:1497712512 *)

open Ctypes

val sbdsdc : layout:int -> uplo:char -> compq:char -> n:int -> d:(float ptr) -> e:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> q:(float ptr) -> iq:(int ptr) -> int 

val dbdsdc : layout:int -> uplo:char -> compq:char -> n:int -> d:(float ptr) -> e:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> q:(float ptr) -> iq:(int ptr) -> int 

val sbdsqr : layout:int -> uplo:char -> n:int -> ncvt:int -> nru:int -> ncc:int -> d:(float ptr) -> e:(float ptr) -> vt:(float ptr) -> ldvt:int -> u:(float ptr) -> ldu:int -> c:(float ptr) -> ldc:int -> int 

val dbdsqr : layout:int -> uplo:char -> n:int -> ncvt:int -> nru:int -> ncc:int -> d:(float ptr) -> e:(float ptr) -> vt:(float ptr) -> ldvt:int -> u:(float ptr) -> ldu:int -> c:(float ptr) -> ldc:int -> int 

val cbdsqr : layout:int -> uplo:char -> n:int -> ncvt:int -> nru:int -> ncc:int -> d:(float ptr) -> e:(float ptr) -> vt:(Complex.t ptr) -> ldvt:int -> u:(Complex.t ptr) -> ldu:int -> c:(Complex.t ptr) -> ldc:int -> int 

val zbdsqr : layout:int -> uplo:char -> n:int -> ncvt:int -> nru:int -> ncc:int -> d:(float ptr) -> e:(float ptr) -> vt:(Complex.t ptr) -> ldvt:int -> u:(Complex.t ptr) -> ldu:int -> c:(Complex.t ptr) -> ldc:int -> int 

val sbdsvdx : layout:int -> uplo:char -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int ptr) -> s:(float ptr) -> z:(float ptr) -> ldz:int -> superb:(int ptr) -> int 

val dbdsvdx : layout:int -> uplo:char -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int ptr) -> s:(float ptr) -> z:(float ptr) -> ldz:int -> superb:(int ptr) -> int 

val sdisna : job:char -> m:int -> n:int -> d:(float ptr) -> sep:(float ptr) -> int 

val ddisna : job:char -> m:int -> n:int -> d:(float ptr) -> sep:(float ptr) -> int 

val sgbbrd : layout:int -> vect:char -> m:int -> n:int -> ncc:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(float ptr) -> ldq:int -> pt:(float ptr) -> ldpt:int -> c:(float ptr) -> ldc:int -> int 

val dgbbrd : layout:int -> vect:char -> m:int -> n:int -> ncc:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(float ptr) -> ldq:int -> pt:(float ptr) -> ldpt:int -> c:(float ptr) -> ldc:int -> int 

val cgbbrd : layout:int -> vect:char -> m:int -> n:int -> ncc:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(Complex.t ptr) -> ldq:int -> pt:(Complex.t ptr) -> ldpt:int -> c:(Complex.t ptr) -> ldc:int -> int 

val zgbbrd : layout:int -> vect:char -> m:int -> n:int -> ncc:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(Complex.t ptr) -> ldq:int -> pt:(Complex.t ptr) -> ldpt:int -> c:(Complex.t ptr) -> ldc:int -> int 

val sgbcon : layout:int -> norm:char -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val dgbcon : layout:int -> norm:char -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val cgbcon : layout:int -> norm:char -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val zgbcon : layout:int -> norm:char -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val sgbequ : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val dgbequ : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val cgbequ : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val zgbequ : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val sgbequb : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val dgbequb : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val cgbequb : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val zgbequb : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val sgbrfs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dgbrfs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cgbrfs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zgbrfs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val sgbsv : layout:int -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dgbsv : layout:int -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val cgbsv : layout:int -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zgbsv : layout:int -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val sgbsvx : layout:int -> fact:char -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> ipiv:(int ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int 

val dgbsvx : layout:int -> fact:char -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> ipiv:(int ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int 

val cgbsvx : layout:int -> fact:char -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> ipiv:(int ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int 

val zgbsvx : layout:int -> fact:char -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> ipiv:(int ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int 

val sgbtrf : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> ipiv:(int ptr) -> int 

val dgbtrf : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(float ptr) -> ldab:int -> ipiv:(int ptr) -> int 

val cgbtrf : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int ptr) -> int 

val zgbtrf : layout:int -> m:int -> n:int -> kl:int -> ku:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int ptr) -> int 

val sgbtrs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dgbtrs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val cgbtrs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zgbtrs : layout:int -> trans:char -> n:int -> kl:int -> ku:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val sgebak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> scale:(float ptr) -> m:int -> v:(float ptr) -> ldv:int -> int 

val dgebak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> scale:(float ptr) -> m:int -> v:(float ptr) -> ldv:int -> int 

val cgebak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> scale:(float ptr) -> m:int -> v:(Complex.t ptr) -> ldv:int -> int 

val zgebak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> scale:(float ptr) -> m:int -> v:(Complex.t ptr) -> ldv:int -> int 

val sgebal : layout:int -> job:char -> n:int -> a:(float ptr) -> lda:int -> ilo:(int ptr) -> ihi:(int ptr) -> scale:(float ptr) -> int 

val dgebal : layout:int -> job:char -> n:int -> a:(float ptr) -> lda:int -> ilo:(int ptr) -> ihi:(int ptr) -> scale:(float ptr) -> int 

val cgebal : layout:int -> job:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ilo:(int ptr) -> ihi:(int ptr) -> scale:(float ptr) -> int 

val zgebal : layout:int -> job:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ilo:(int ptr) -> ihi:(int ptr) -> scale:(float ptr) -> int 

val sgebrd : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tauq:(float ptr) -> taup:(float ptr) -> int 

val dgebrd : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tauq:(float ptr) -> taup:(float ptr) -> int 

val cgebrd : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tauq:(Complex.t ptr) -> taup:(Complex.t ptr) -> int 

val zgebrd : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tauq:(Complex.t ptr) -> taup:(Complex.t ptr) -> int 

val sgecon : layout:int -> norm:char -> n:int -> a:(float ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int 

val dgecon : layout:int -> norm:char -> n:int -> a:(float ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int 

val cgecon : layout:int -> norm:char -> n:int -> a:(Complex.t ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int 

val zgecon : layout:int -> norm:char -> n:int -> a:(Complex.t ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int 

val sgeequ : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val dgeequ : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val cgeequ : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val zgeequ : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val sgeequb : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val dgeequb : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val cgeequb : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val zgeequb : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> r:(float ptr) -> c:(float ptr) -> rowcnd:(float ptr) -> colcnd:(float ptr) -> amax:(float ptr) -> int 

val sgees : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> sdim:(int ptr) -> wr:(float ptr) -> wi:(float ptr) -> vs:(float ptr) -> ldvs:int -> int 

val dgees : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> sdim:(int ptr) -> wr:(float ptr) -> wi:(float ptr) -> vs:(float ptr) -> ldvs:int -> int 

val cgees : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> sdim:(int ptr) -> w:(Complex.t ptr) -> vs:(Complex.t ptr) -> ldvs:int -> int 

val zgees : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> sdim:(int ptr) -> w:(Complex.t ptr) -> vs:(Complex.t ptr) -> ldvs:int -> int 

val sgeesx : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> sense:char -> n:int -> a:(float ptr) -> lda:int -> sdim:(int ptr) -> wr:(float ptr) -> wi:(float ptr) -> vs:(float ptr) -> ldvs:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val dgeesx : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> sense:char -> n:int -> a:(float ptr) -> lda:int -> sdim:(int ptr) -> wr:(float ptr) -> wi:(float ptr) -> vs:(float ptr) -> ldvs:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val cgeesx : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> sdim:(int ptr) -> w:(Complex.t ptr) -> vs:(Complex.t ptr) -> ldvs:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val zgeesx : layout:int -> jobvs:char -> sort:char -> select:(unit ptr) -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> sdim:(int ptr) -> w:(Complex.t ptr) -> vs:(Complex.t ptr) -> ldvs:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val sgeev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int 

val dgeev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int 

val cgeev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int 

val zgeev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int 

val sgeevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(float ptr) -> lda:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> ilo:(int ptr) -> ihi:(int ptr) -> scale:(float ptr) -> abnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val dgeevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(float ptr) -> lda:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> ilo:(int ptr) -> ihi:(int ptr) -> scale:(float ptr) -> abnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val cgeevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> ilo:(int ptr) -> ihi:(int ptr) -> scale:(float ptr) -> abnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val zgeevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> ilo:(int ptr) -> ihi:(int ptr) -> scale:(float ptr) -> abnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val sgehrd : layout:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dgehrd : layout:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val cgehrd : layout:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zgehrd : layout:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val sgejsv : layout:int -> joba:char -> jobu:char -> jobv:char -> jobr:char -> jobt:char -> jobp:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> sva:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> stat:(float ptr) -> istat:(int ptr) -> int 

val dgejsv : layout:int -> joba:char -> jobu:char -> jobv:char -> jobr:char -> jobt:char -> jobp:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> sva:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> stat:(float ptr) -> istat:(int ptr) -> int 

val cgejsv : layout:int -> joba:char -> jobu:char -> jobv:char -> jobr:char -> jobt:char -> jobp:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> sva:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> stat:(float ptr) -> istat:(int ptr) -> int 

val zgejsv : layout:int -> joba:char -> jobu:char -> jobv:char -> jobr:char -> jobt:char -> jobp:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> sva:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> stat:(float ptr) -> istat:(int ptr) -> int 

val sgelq2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dgelq2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val cgelq2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zgelq2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val sgelqf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dgelqf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val cgelqf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zgelqf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val sgels : layout:int -> trans:char -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val dgels : layout:int -> trans:char -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val cgels : layout:int -> trans:char -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val zgels : layout:int -> trans:char -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val sgelsd : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int ptr) -> int 

val dgelsd : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int ptr) -> int 

val cgelsd : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int ptr) -> int 

val zgelsd : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int ptr) -> int 

val sgelss : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int ptr) -> int 

val dgelss : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int ptr) -> int 

val cgelss : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int ptr) -> int 

val zgelss : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> s:(float ptr) -> rcond:float -> rank:(int ptr) -> int 

val sgelsy : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> jpvt:(int ptr) -> rcond:float -> rank:(int ptr) -> int 

val dgelsy : layout:int -> m:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> jpvt:(int ptr) -> rcond:float -> rank:(int ptr) -> int 

val cgelsy : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> jpvt:(int ptr) -> rcond:float -> rank:(int ptr) -> int 

val zgelsy : layout:int -> m:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> jpvt:(int ptr) -> rcond:float -> rank:(int ptr) -> int 

val sgeqlf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dgeqlf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val cgeqlf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zgeqlf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val sgeqp3 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> jpvt:(int ptr) -> tau:(float ptr) -> int 

val dgeqp3 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> jpvt:(int ptr) -> tau:(float ptr) -> int 

val cgeqp3 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> jpvt:(int ptr) -> tau:(Complex.t ptr) -> int 

val zgeqp3 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> jpvt:(int ptr) -> tau:(Complex.t ptr) -> int 

val sgeqr2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dgeqr2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val cgeqr2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zgeqr2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val sgeqrf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dgeqrf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val cgeqrf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zgeqrf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val sgeqrfp : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dgeqrfp : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val cgeqrfp : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zgeqrfp : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val sgerfs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dgerfs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cgerfs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zgerfs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val sgerqf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dgerqf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val cgerqf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zgerqf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val sgesdd : layout:int -> jobz:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> int 

val dgesdd : layout:int -> jobz:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> int 

val cgesdd : layout:int -> jobz:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> int 

val zgesdd : layout:int -> jobz:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> int 

val sgesv : layout:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dgesv : layout:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val cgesv : layout:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zgesv : layout:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val dsgesv : layout:int -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> iter:(int ptr) -> int 

val zcgesv : layout:int -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> iter:(int ptr) -> int 

val sgesvd : layout:int -> jobu:char -> jobvt:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> superb:(float ptr) -> int 

val dgesvd : layout:int -> jobu:char -> jobvt:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> superb:(float ptr) -> int 

val cgesvd : layout:int -> jobu:char -> jobvt:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> superb:(float ptr) -> int 

val zgesvd : layout:int -> jobu:char -> jobvt:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> superb:(float ptr) -> int 

val sgesvdx : layout:int -> jobu:char -> jobvt:char -> range:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int ptr) -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> superb:(int ptr) -> int 

val dgesvdx : layout:int -> jobu:char -> jobvt:char -> range:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int ptr) -> s:(float ptr) -> u:(float ptr) -> ldu:int -> vt:(float ptr) -> ldvt:int -> superb:(int ptr) -> int 

val cgesvdx : layout:int -> jobu:char -> jobvt:char -> range:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int ptr) -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> superb:(int ptr) -> int 

val zgesvdx : layout:int -> jobu:char -> jobvt:char -> range:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> ns:(int ptr) -> s:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> vt:(Complex.t ptr) -> ldvt:int -> superb:(int ptr) -> int 

val sgesvj : layout:int -> joba:char -> jobu:char -> jobv:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> sva:(float ptr) -> mv:int -> v:(float ptr) -> ldv:int -> stat:(float ptr) -> int 

val dgesvj : layout:int -> joba:char -> jobu:char -> jobv:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> sva:(float ptr) -> mv:int -> v:(float ptr) -> ldv:int -> stat:(float ptr) -> int 

val cgesvj : layout:int -> joba:char -> jobu:char -> jobv:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> sva:(float ptr) -> mv:int -> v:(Complex.t ptr) -> ldv:int -> stat:(float ptr) -> int 

val zgesvj : layout:int -> joba:char -> jobu:char -> jobv:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> sva:(float ptr) -> mv:int -> v:(Complex.t ptr) -> ldv:int -> stat:(float ptr) -> int 

val sgesvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int 

val dgesvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int 

val cgesvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int 

val zgesvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> equed:(char ptr) -> r:(float ptr) -> c:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> rpivot:(float ptr) -> int 

val sgetf2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val dgetf2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val cgetf2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zgetf2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val sgetrf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val dgetrf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val cgetrf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zgetrf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val sgetrf2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val dgetrf2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val cgetrf2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zgetrf2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val sgetri : layout:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val dgetri : layout:int -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val cgetri : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zgetri : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val sgetrs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dgetrs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val cgetrs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zgetrs : layout:int -> trans:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val sggbak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> lscale:(float ptr) -> rscale:(float ptr) -> m:int -> v:(float ptr) -> ldv:int -> int 

val dggbak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> lscale:(float ptr) -> rscale:(float ptr) -> m:int -> v:(float ptr) -> ldv:int -> int 

val cggbak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> lscale:(float ptr) -> rscale:(float ptr) -> m:int -> v:(Complex.t ptr) -> ldv:int -> int 

val zggbak : layout:int -> job:char -> side:char -> n:int -> ilo:int -> ihi:int -> lscale:(float ptr) -> rscale:(float ptr) -> m:int -> v:(Complex.t ptr) -> ldv:int -> int 

val sggbal : layout:int -> job:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> ilo:(int ptr) -> ihi:(int ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> int 

val dggbal : layout:int -> job:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> ilo:(int ptr) -> ihi:(int ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> int 

val cggbal : layout:int -> job:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> ilo:(int ptr) -> ihi:(int ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> int 

val zggbal : layout:int -> job:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> ilo:(int ptr) -> ihi:(int ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> int 

val sgges : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> int 

val dgges : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> int 

val cgges : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> int 

val zgges : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> int 

val sgges3 : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> int 

val dgges3 : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> int 

val cgges3 : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> int 

val zgges3 : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> int 

val sggesx : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> sense:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val dggesx : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> sense:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> sdim:(int ptr) -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vsl:(float ptr) -> ldvsl:int -> vsr:(float ptr) -> ldvsr:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val cggesx : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val zggesx : layout:int -> jobvsl:char -> jobvsr:char -> sort:char -> selctg:(unit ptr) -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> sdim:(int ptr) -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vsl:(Complex.t ptr) -> ldvsl:int -> vsr:(Complex.t ptr) -> ldvsr:int -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val sggev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int 

val dggev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int 

val cggev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int 

val zggev : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int 

val sggev3 : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int 

val dggev3 : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> int 

val cggev3 : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int 

val zggev3 : layout:int -> jobvl:char -> jobvr:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> int 

val sggevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> ilo:(int ptr) -> ihi:(int ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> abnrm:(float ptr) -> bbnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val dggevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> ilo:(int ptr) -> ihi:(int ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> abnrm:(float ptr) -> bbnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val cggevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> ilo:(int ptr) -> ihi:(int ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> abnrm:(float ptr) -> bbnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val zggevx : layout:int -> balanc:char -> jobvl:char -> jobvr:char -> sense:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> ilo:(int ptr) -> ihi:(int ptr) -> lscale:(float ptr) -> rscale:(float ptr) -> abnrm:(float ptr) -> bbnrm:(float ptr) -> rconde:(float ptr) -> rcondv:(float ptr) -> int 

val sggglm : layout:int -> n:int -> m:int -> p:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> d:(float ptr) -> x:(float ptr) -> y:(float ptr) -> int 

val dggglm : layout:int -> n:int -> m:int -> p:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> d:(float ptr) -> x:(float ptr) -> y:(float ptr) -> int 

val cggglm : layout:int -> n:int -> m:int -> p:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> d:(Complex.t ptr) -> x:(Complex.t ptr) -> y:(Complex.t ptr) -> int 

val zggglm : layout:int -> n:int -> m:int -> p:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> d:(Complex.t ptr) -> x:(Complex.t ptr) -> y:(Complex.t ptr) -> int 

val sgghrd : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int 

val dgghrd : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int 

val cgghrd : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int 

val zgghrd : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int 

val sgghd3 : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int 

val dgghd3 : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int 

val cgghd3 : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int 

val zgghd3 : layout:int -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int 

val sgglse : layout:int -> m:int -> n:int -> p:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> d:(float ptr) -> x:(float ptr) -> int 

val dgglse : layout:int -> m:int -> n:int -> p:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> d:(float ptr) -> x:(float ptr) -> int 

val cgglse : layout:int -> m:int -> n:int -> p:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> d:(Complex.t ptr) -> x:(Complex.t ptr) -> int 

val zgglse : layout:int -> m:int -> n:int -> p:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> d:(Complex.t ptr) -> x:(Complex.t ptr) -> int 

val sggqrf : layout:int -> n:int -> m:int -> p:int -> a:(float ptr) -> lda:int -> taua:(float ptr) -> b:(float ptr) -> ldb:int -> taub:(float ptr) -> int 

val dggqrf : layout:int -> n:int -> m:int -> p:int -> a:(float ptr) -> lda:int -> taua:(float ptr) -> b:(float ptr) -> ldb:int -> taub:(float ptr) -> int 

val cggqrf : layout:int -> n:int -> m:int -> p:int -> a:(Complex.t ptr) -> lda:int -> taua:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> taub:(Complex.t ptr) -> int 

val zggqrf : layout:int -> n:int -> m:int -> p:int -> a:(Complex.t ptr) -> lda:int -> taua:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> taub:(Complex.t ptr) -> int 

val sggrqf : layout:int -> m:int -> p:int -> n:int -> a:(float ptr) -> lda:int -> taua:(float ptr) -> b:(float ptr) -> ldb:int -> taub:(float ptr) -> int 

val dggrqf : layout:int -> m:int -> p:int -> n:int -> a:(float ptr) -> lda:int -> taua:(float ptr) -> b:(float ptr) -> ldb:int -> taub:(float ptr) -> int 

val cggrqf : layout:int -> m:int -> p:int -> n:int -> a:(Complex.t ptr) -> lda:int -> taua:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> taub:(Complex.t ptr) -> int 

val zggrqf : layout:int -> m:int -> p:int -> n:int -> a:(Complex.t ptr) -> lda:int -> taua:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> taub:(Complex.t ptr) -> int 

val sggsvd3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> n:int -> p:int -> k:(int ptr) -> l:(int ptr) -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alpha:(float ptr) -> beta:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> iwork:(int ptr) -> int 

val dggsvd3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> n:int -> p:int -> k:(int ptr) -> l:(int ptr) -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alpha:(float ptr) -> beta:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> iwork:(int ptr) -> int 

val cggsvd3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> n:int -> p:int -> k:(int ptr) -> l:(int ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(float ptr) -> beta:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> iwork:(int ptr) -> int 

val zggsvd3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> n:int -> p:int -> k:(int ptr) -> l:(int ptr) -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(float ptr) -> beta:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> iwork:(int ptr) -> int 

val sggsvp3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> tola:float -> tolb:float -> k:(int ptr) -> l:(int ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> int 

val dggsvp3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> tola:float -> tolb:float -> k:(int ptr) -> l:(int ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> int 

val cggsvp3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> tola:float -> tolb:float -> k:(int ptr) -> l:(int ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> int 

val zggsvp3 : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> tola:float -> tolb:float -> k:(int ptr) -> l:(int ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> int 

val sgtcon : norm:char -> n:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val dgtcon : norm:char -> n:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val cgtcon : norm:char -> n:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val zgtcon : norm:char -> n:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val sgtrfs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> dlf:(float ptr) -> df:(float ptr) -> duf:(float ptr) -> du2:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dgtrfs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> dlf:(float ptr) -> df:(float ptr) -> duf:(float ptr) -> du2:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cgtrfs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> dlf:(Complex.t ptr) -> df:(Complex.t ptr) -> duf:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zgtrfs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> dlf:(Complex.t ptr) -> df:(Complex.t ptr) -> duf:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val sgtsv : layout:int -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val dgtsv : layout:int -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val cgtsv : layout:int -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zgtsv : layout:int -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val sgtsvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> dlf:(float ptr) -> df:(float ptr) -> duf:(float ptr) -> du2:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dgtsvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> dlf:(float ptr) -> df:(float ptr) -> duf:(float ptr) -> du2:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cgtsvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> dlf:(Complex.t ptr) -> df:(Complex.t ptr) -> duf:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zgtsvx : layout:int -> fact:char -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> dlf:(Complex.t ptr) -> df:(Complex.t ptr) -> duf:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val sgttrf : n:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int ptr) -> int 

val dgttrf : n:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int ptr) -> int 

val cgttrf : n:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int ptr) -> int 

val zgttrf : n:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int ptr) -> int 

val sgttrs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dgttrs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(float ptr) -> d:(float ptr) -> du:(float ptr) -> du2:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val cgttrs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zgttrs : layout:int -> trans:char -> n:int -> nrhs:int -> dl:(Complex.t ptr) -> d:(Complex.t ptr) -> du:(Complex.t ptr) -> du2:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val chbev : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zhbev : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val chbevd : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zhbevd : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val chbevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> q:(Complex.t ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val zhbevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> q:(Complex.t ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val chbgst : layout:int -> vect:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> x:(Complex.t ptr) -> ldx:int -> int 

val zhbgst : layout:int -> vect:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> x:(Complex.t ptr) -> ldx:int -> int 

val chbgv : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zhbgv : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val chbgvd : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zhbgvd : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val chbgvx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> q:(Complex.t ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val zhbgvx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(Complex.t ptr) -> ldab:int -> bb:(Complex.t ptr) -> ldbb:int -> q:(Complex.t ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val chbtrd : layout:int -> vect:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(Complex.t ptr) -> ldq:int -> int 

val zhbtrd : layout:int -> vect:char -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(Complex.t ptr) -> ldq:int -> int 

val checon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val zhecon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val cheequb : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val zheequb : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val cheev : layout:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(float ptr) -> int 

val zheev : layout:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(float ptr) -> int 

val cheevd : layout:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(float ptr) -> int 

val zheevd : layout:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> w:(float ptr) -> int 

val cheevr : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> isuppz:(int ptr) -> int 

val zheevr : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> isuppz:(int ptr) -> int 

val cheevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val zheevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val chegst : layout:int -> ityp:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val zhegst : layout:int -> ityp:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val chegv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> w:(float ptr) -> int 

val zhegv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> w:(float ptr) -> int 

val chegvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> w:(float ptr) -> int 

val zhegvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> w:(float ptr) -> int 

val chegvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val zhegvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val cherfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zherfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val chesv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zhesv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val chesvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zhesvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val chetrd : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tau:(Complex.t ptr) -> int 

val zhetrd : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tau:(Complex.t ptr) -> int 

val chetrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zhetrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val chetri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zhetri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val chetrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zhetrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val chfrk : layout:int -> transr:char -> uplo:char -> trans:char -> n:int -> k:int -> alpha:float -> a:(Complex.t ptr) -> lda:int -> beta:float -> c:(Complex.t ptr) -> int 

val zhfrk : layout:int -> transr:char -> uplo:char -> trans:char -> n:int -> k:int -> alpha:float -> a:(Complex.t ptr) -> lda:int -> beta:float -> c:(Complex.t ptr) -> int 

val shgeqz : layout:int -> job:char -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(float ptr) -> ldh:int -> t:(float ptr) -> ldt:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int 

val dhgeqz : layout:int -> job:char -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(float ptr) -> ldh:int -> t:(float ptr) -> ldt:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> int 

val chgeqz : layout:int -> job:char -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(Complex.t ptr) -> ldh:int -> t:(Complex.t ptr) -> ldt:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int 

val zhgeqz : layout:int -> job:char -> compq:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(Complex.t ptr) -> ldh:int -> t:(Complex.t ptr) -> ldt:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> int 

val chpcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val zhpcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val chpev : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zhpev : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val chpevd : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zhpevd : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val chpevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val zhpevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val chpgst : layout:int -> ityp:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> int 

val zhpgst : layout:int -> ityp:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> int 

val chpgv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zhpgv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val chpgvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zhpgvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val chpgvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val zhpgvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> bp:(Complex.t ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> ifail:(int ptr) -> int 

val chprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zhprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val chpsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zhpsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val chpsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zhpsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val chptrd : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> d:(float ptr) -> e:(float ptr) -> tau:(Complex.t ptr) -> int 

val zhptrd : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> d:(float ptr) -> e:(float ptr) -> tau:(Complex.t ptr) -> int 

val chptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> int 

val zhptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> int 

val chptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> int 

val zhptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> int 

val chptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zhptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val shsein : layout:int -> job:char -> eigsrc:char -> initv:char -> select:(int ptr) -> n:int -> h:(float ptr) -> ldh:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> ifaill:(int ptr) -> ifailr:(int ptr) -> int 

val dhsein : layout:int -> job:char -> eigsrc:char -> initv:char -> select:(int ptr) -> n:int -> h:(float ptr) -> ldh:int -> wr:(float ptr) -> wi:(float ptr) -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> ifaill:(int ptr) -> ifailr:(int ptr) -> int 

val chsein : layout:int -> job:char -> eigsrc:char -> initv:char -> select:(int ptr) -> n:int -> h:(Complex.t ptr) -> ldh:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> ifaill:(int ptr) -> ifailr:(int ptr) -> int 

val zhsein : layout:int -> job:char -> eigsrc:char -> initv:char -> select:(int ptr) -> n:int -> h:(Complex.t ptr) -> ldh:int -> w:(Complex.t ptr) -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> ifaill:(int ptr) -> ifailr:(int ptr) -> int 

val shseqr : layout:int -> job:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(float ptr) -> ldh:int -> wr:(float ptr) -> wi:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dhseqr : layout:int -> job:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(float ptr) -> ldh:int -> wr:(float ptr) -> wi:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val chseqr : layout:int -> job:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(Complex.t ptr) -> ldh:int -> w:(Complex.t ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zhseqr : layout:int -> job:char -> compz:char -> n:int -> ilo:int -> ihi:int -> h:(Complex.t ptr) -> ldh:int -> w:(Complex.t ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val clacgv : n:int -> x:(Complex.t ptr) -> incx:int -> int 

val zlacgv : n:int -> x:(Complex.t ptr) -> incx:int -> int 

val slacn2 : n:int -> v:(float ptr) -> x:(float ptr) -> isgn:(int ptr) -> est:(float ptr) -> kase:(int ptr) -> isave:(int ptr) -> int 

val dlacn2 : n:int -> v:(float ptr) -> x:(float ptr) -> isgn:(int ptr) -> est:(float ptr) -> kase:(int ptr) -> isave:(int ptr) -> int 

val clacn2 : n:int -> v:(Complex.t ptr) -> x:(Complex.t ptr) -> est:(float ptr) -> kase:(int ptr) -> isave:(int ptr) -> int 

val zlacn2 : n:int -> v:(Complex.t ptr) -> x:(Complex.t ptr) -> est:(float ptr) -> kase:(int ptr) -> isave:(int ptr) -> int 

val slacpy : layout:int -> uplo:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val dlacpy : layout:int -> uplo:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val clacpy : layout:int -> uplo:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val zlacpy : layout:int -> uplo:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val clacp2 : layout:int -> uplo:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val zlacp2 : layout:int -> uplo:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val zlag2c : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> sa:(Complex.t ptr) -> ldsa:int -> int 

val slag2d : layout:int -> m:int -> n:int -> sa:(float ptr) -> ldsa:int -> a:(float ptr) -> lda:int -> int 

val dlag2s : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> sa:(float ptr) -> ldsa:int -> int 

val clag2z : layout:int -> m:int -> n:int -> sa:(Complex.t ptr) -> ldsa:int -> a:(Complex.t ptr) -> lda:int -> int 

val slagge : layout:int -> m:int -> n:int -> kl:int -> ku:int -> d:(float ptr) -> a:(float ptr) -> lda:int -> iseed:(int ptr) -> int 

val dlagge : layout:int -> m:int -> n:int -> kl:int -> ku:int -> d:(float ptr) -> a:(float ptr) -> lda:int -> iseed:(int ptr) -> int 

val clagge : layout:int -> m:int -> n:int -> kl:int -> ku:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int ptr) -> int 

val zlagge : layout:int -> m:int -> n:int -> kl:int -> ku:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int ptr) -> int 

val slarfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> c:(float ptr) -> ldc:int -> int 

val dlarfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> c:(float ptr) -> ldc:int -> int 

val clarfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> c:(Complex.t ptr) -> ldc:int -> int 

val zlarfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> c:(Complex.t ptr) -> ldc:int -> int 

val slarfg : n:int -> alpha:(float ptr) -> x:(float ptr) -> incx:int -> tau:(float ptr) -> int 

val dlarfg : n:int -> alpha:(float ptr) -> x:(float ptr) -> incx:int -> tau:(float ptr) -> int 

val clarfg : n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> tau:(Complex.t ptr) -> int 

val zlarfg : n:int -> alpha:(Complex.t ptr) -> x:(Complex.t ptr) -> incx:int -> tau:(Complex.t ptr) -> int 

val slarft : layout:int -> direct:char -> storev:char -> n:int -> k:int -> v:(float ptr) -> ldv:int -> tau:(float ptr) -> t:(float ptr) -> ldt:int -> int 

val dlarft : layout:int -> direct:char -> storev:char -> n:int -> k:int -> v:(float ptr) -> ldv:int -> tau:(float ptr) -> t:(float ptr) -> ldt:int -> int 

val clarft : layout:int -> direct:char -> storev:char -> n:int -> k:int -> v:(Complex.t ptr) -> ldv:int -> tau:(Complex.t ptr) -> t:(Complex.t ptr) -> ldt:int -> int 

val zlarft : layout:int -> direct:char -> storev:char -> n:int -> k:int -> v:(Complex.t ptr) -> ldv:int -> tau:(Complex.t ptr) -> t:(Complex.t ptr) -> ldt:int -> int 

val slarfx : layout:int -> side:char -> m:int -> n:int -> v:(float ptr) -> tau:float -> c:(float ptr) -> ldc:int -> work:(float ptr) -> int 

val dlarfx : layout:int -> side:char -> m:int -> n:int -> v:(float ptr) -> tau:float -> c:(float ptr) -> ldc:int -> work:(float ptr) -> int 

val clarfx : layout:int -> side:char -> m:int -> n:int -> v:(Complex.t ptr) -> tau:Complex.t -> c:(Complex.t ptr) -> ldc:int -> work:(Complex.t ptr) -> int 

val zlarfx : layout:int -> side:char -> m:int -> n:int -> v:(Complex.t ptr) -> tau:Complex.t -> c:(Complex.t ptr) -> ldc:int -> work:(Complex.t ptr) -> int 

val slarnv : idist:int -> iseed:(int ptr) -> n:int -> x:(float ptr) -> int 

val dlarnv : idist:int -> iseed:(int ptr) -> n:int -> x:(float ptr) -> int 

val clarnv : idist:int -> iseed:(int ptr) -> n:int -> x:(Complex.t ptr) -> int 

val zlarnv : idist:int -> iseed:(int ptr) -> n:int -> x:(Complex.t ptr) -> int 

val slascl : layout:int -> typ:char -> kl:int -> ku:int -> cfrom:float -> cto:float -> m:int -> n:int -> a:(float ptr) -> lda:int -> int 

val dlascl : layout:int -> typ:char -> kl:int -> ku:int -> cfrom:float -> cto:float -> m:int -> n:int -> a:(float ptr) -> lda:int -> int 

val clascl : layout:int -> typ:char -> kl:int -> ku:int -> cfrom:float -> cto:float -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val zlascl : layout:int -> typ:char -> kl:int -> ku:int -> cfrom:float -> cto:float -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val slaset : layout:int -> uplo:char -> m:int -> n:int -> alpha:float -> beta:float -> a:(float ptr) -> lda:int -> int 

val dlaset : layout:int -> uplo:char -> m:int -> n:int -> alpha:float -> beta:float -> a:(float ptr) -> lda:int -> int 

val claset : layout:int -> uplo:char -> m:int -> n:int -> alpha:Complex.t -> beta:Complex.t -> a:(Complex.t ptr) -> lda:int -> int 

val zlaset : layout:int -> uplo:char -> m:int -> n:int -> alpha:Complex.t -> beta:Complex.t -> a:(Complex.t ptr) -> lda:int -> int 

val slasrt : id:char -> n:int -> d:(float ptr) -> int 

val dlasrt : id:char -> n:int -> d:(float ptr) -> int 

val slaswp : layout:int -> n:int -> a:(float ptr) -> lda:int -> k1:int -> k2:int -> ipiv:(int ptr) -> incx:int -> int 

val dlaswp : layout:int -> n:int -> a:(float ptr) -> lda:int -> k1:int -> k2:int -> ipiv:(int ptr) -> incx:int -> int 

val claswp : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> k1:int -> k2:int -> ipiv:(int ptr) -> incx:int -> int 

val zlaswp : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> k1:int -> k2:int -> ipiv:(int ptr) -> incx:int -> int 

val slatms : layout:int -> m:int -> n:int -> dist:char -> iseed:(int ptr) -> sym:char -> d:(float ptr) -> mode:int -> cond:float -> dmax:float -> kl:int -> ku:int -> pack:char -> a:(float ptr) -> lda:int -> int 

val dlatms : layout:int -> m:int -> n:int -> dist:char -> iseed:(int ptr) -> sym:char -> d:(float ptr) -> mode:int -> cond:float -> dmax:float -> kl:int -> ku:int -> pack:char -> a:(float ptr) -> lda:int -> int 

val clatms : layout:int -> m:int -> n:int -> dist:char -> iseed:(int ptr) -> sym:char -> d:(float ptr) -> mode:int -> cond:float -> dmax:float -> kl:int -> ku:int -> pack:char -> a:(Complex.t ptr) -> lda:int -> int 

val zlatms : layout:int -> m:int -> n:int -> dist:char -> iseed:(int ptr) -> sym:char -> d:(float ptr) -> mode:int -> cond:float -> dmax:float -> kl:int -> ku:int -> pack:char -> a:(Complex.t ptr) -> lda:int -> int 

val slauum : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int 

val dlauum : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int 

val clauum : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val zlauum : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val sopgtr : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> tau:(float ptr) -> q:(float ptr) -> ldq:int -> int 

val dopgtr : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> tau:(float ptr) -> q:(float ptr) -> ldq:int -> int 

val sopmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> ap:(float ptr) -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val dopmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> ap:(float ptr) -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val sorgbr : layout:int -> vect:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dorgbr : layout:int -> vect:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val sorghr : layout:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dorghr : layout:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val sorglq : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dorglq : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val sorgql : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dorgql : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val sorgqr : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dorgqr : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val sorgrq : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dorgrq : layout:int -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val sorgtr : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dorgtr : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val sormbr : layout:int -> vect:char -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val dormbr : layout:int -> vect:char -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val sormhr : layout:int -> side:char -> trans:char -> m:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val dormhr : layout:int -> side:char -> trans:char -> m:int -> n:int -> ilo:int -> ihi:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val sormlq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val dormlq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val sormql : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val dormql : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val sormqr : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val dormqr : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val sormrq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val dormrq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val sormrz : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val dormrz : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val sormtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val dormtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> c:(float ptr) -> ldc:int -> int 

val spbcon : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> anorm:float -> rcond:(float ptr) -> int 

val dpbcon : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> anorm:float -> rcond:(float ptr) -> int 

val cpbcon : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> anorm:float -> rcond:(float ptr) -> int 

val zpbcon : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> anorm:float -> rcond:(float ptr) -> int 

val spbequ : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val dpbequ : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val cpbequ : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val zpbequ : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val spbrfs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dpbrfs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cpbrfs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zpbrfs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val spbstf : layout:int -> uplo:char -> n:int -> kb:int -> bb:(float ptr) -> ldbb:int -> int 

val dpbstf : layout:int -> uplo:char -> n:int -> kb:int -> bb:(float ptr) -> ldbb:int -> int 

val cpbstf : layout:int -> uplo:char -> n:int -> kb:int -> bb:(Complex.t ptr) -> ldbb:int -> int 

val zpbstf : layout:int -> uplo:char -> n:int -> kb:int -> bb:(Complex.t ptr) -> ldbb:int -> int 

val spbsv : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int 

val dpbsv : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int 

val cpbsv : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int 

val zpbsv : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int 

val spbsvx : layout:int -> fact:char -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dpbsvx : layout:int -> fact:char -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> afb:(float ptr) -> ldafb:int -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cpbsvx : layout:int -> fact:char -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zpbsvx : layout:int -> fact:char -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> afb:(Complex.t ptr) -> ldafb:int -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val spbtrf : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> int 

val dpbtrf : layout:int -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> int 

val cpbtrf : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> int 

val zpbtrf : layout:int -> uplo:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> int 

val spbtrs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int 

val dpbtrs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int 

val cpbtrs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int 

val zpbtrs : layout:int -> uplo:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int 

val spftrf : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> int 

val dpftrf : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> int 

val cpftrf : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> int 

val zpftrf : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> int 

val spftri : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> int 

val dpftri : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> int 

val cpftri : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> int 

val zpftri : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> int 

val spftrs : layout:int -> transr:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val dpftrs : layout:int -> transr:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val cpftrs : layout:int -> transr:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zpftrs : layout:int -> transr:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val spocon : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int 

val dpocon : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int 

val cpocon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int 

val zpocon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> anorm:float -> rcond:(float ptr) -> int 

val spoequ : layout:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val dpoequ : layout:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val cpoequ : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val zpoequ : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val spoequb : layout:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val dpoequb : layout:int -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val cpoequb : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val zpoequb : layout:int -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val sporfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dporfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cporfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zporfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val sposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val dposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val cposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val zposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val dsposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> iter:(int ptr) -> int 

val zcposv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> iter:(int ptr) -> int 

val sposvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dposvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cposvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zposvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val spotrf2 : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int 

val dpotrf2 : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int 

val cpotrf2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val zpotrf2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val spotrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int 

val dpotrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int 

val cpotrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val zpotrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val spotri : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int 

val dpotri : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> int 

val cpotri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val zpotri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val spotrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val dpotrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val cpotrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val zpotrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val sppcon : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> anorm:float -> rcond:(float ptr) -> int 

val dppcon : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> anorm:float -> rcond:(float ptr) -> int 

val cppcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> anorm:float -> rcond:(float ptr) -> int 

val zppcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> anorm:float -> rcond:(float ptr) -> int 

val sppequ : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val dppequ : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val cppequ : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val zppequ : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val spprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dpprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cpprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zpprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val sppsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val dppsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val cppsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zppsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val sppsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dppsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> equed:(char ptr) -> s:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cppsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zppsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> equed:(char ptr) -> s:(float ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val spptrf : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> int 

val dpptrf : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> int 

val cpptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> int 

val zpptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> int 

val spptri : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> int 

val dpptri : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> int 

val cpptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> int 

val zpptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> int 

val spptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val dpptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val cpptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zpptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val spstrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> piv:(int ptr) -> rank:(int ptr) -> tol:float -> int 

val dpstrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> piv:(int ptr) -> rank:(int ptr) -> tol:float -> int 

val cpstrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> piv:(int ptr) -> rank:(int ptr) -> tol:float -> int 

val zpstrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> piv:(int ptr) -> rank:(int ptr) -> tol:float -> int 

val sptcon : n:int -> d:(float ptr) -> e:(float ptr) -> anorm:float -> rcond:(float ptr) -> int 

val dptcon : n:int -> d:(float ptr) -> e:(float ptr) -> anorm:float -> rcond:(float ptr) -> int 

val cptcon : n:int -> d:(float ptr) -> e:(Complex.t ptr) -> anorm:float -> rcond:(float ptr) -> int 

val zptcon : n:int -> d:(float ptr) -> e:(Complex.t ptr) -> anorm:float -> rcond:(float ptr) -> int 

val spteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dpteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val cpteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zpteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val sptrfs : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> df:(float ptr) -> ef:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dptrfs : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> df:(float ptr) -> ef:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cptrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> df:(float ptr) -> ef:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zptrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> df:(float ptr) -> ef:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val sptsv : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val dptsv : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val cptsv : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zptsv : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val sptsvx : layout:int -> fact:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> df:(float ptr) -> ef:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dptsvx : layout:int -> fact:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> df:(float ptr) -> ef:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cptsvx : layout:int -> fact:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> df:(float ptr) -> ef:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zptsvx : layout:int -> fact:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> df:(float ptr) -> ef:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val spttrf : n:int -> d:(float ptr) -> e:(float ptr) -> int 

val dpttrf : n:int -> d:(float ptr) -> e:(float ptr) -> int 

val cpttrf : n:int -> d:(float ptr) -> e:(Complex.t ptr) -> int 

val zpttrf : n:int -> d:(float ptr) -> e:(Complex.t ptr) -> int 

val spttrs : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val dpttrs : layout:int -> n:int -> nrhs:int -> d:(float ptr) -> e:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val cpttrs : layout:int -> uplo:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zpttrs : layout:int -> uplo:char -> n:int -> nrhs:int -> d:(float ptr) -> e:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val ssbev : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dsbev : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val ssbevd : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dsbevd : layout:int -> jobz:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val ssbevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> q:(float ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val dsbevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> q:(float ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val ssbgst : layout:int -> vect:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> x:(float ptr) -> ldx:int -> int 

val dsbgst : layout:int -> vect:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> x:(float ptr) -> ldx:int -> int 

val ssbgv : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dsbgv : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val ssbgvd : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dsbgvd : layout:int -> jobz:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val ssbgvx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> q:(float ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val dsbgvx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ka:int -> kb:int -> ab:(float ptr) -> ldab:int -> bb:(float ptr) -> ldbb:int -> q:(float ptr) -> ldq:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val ssbtrd : layout:int -> vect:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(float ptr) -> ldq:int -> int 

val dsbtrd : layout:int -> vect:char -> uplo:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> d:(float ptr) -> e:(float ptr) -> q:(float ptr) -> ldq:int -> int 

val ssfrk : layout:int -> transr:char -> uplo:char -> trans:char -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> beta:float -> c:(float ptr) -> int 

val dsfrk : layout:int -> transr:char -> uplo:char -> trans:char -> n:int -> k:int -> alpha:float -> a:(float ptr) -> lda:int -> beta:float -> c:(float ptr) -> int 

val sspcon : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val dspcon : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val cspcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val zspcon : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val sspev : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dspev : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val sspevd : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dspevd : layout:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val sspevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val dspevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val sspgst : layout:int -> ityp:int -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> int 

val dspgst : layout:int -> ityp:int -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> int 

val sspgv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dspgv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val sspgvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dspgvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val sspgvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val dspgvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> ap:(float ptr) -> bp:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val ssprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dsprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val csprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zsprfs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val sspsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dspsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val cspsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zspsv : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val sspsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dspsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> afp:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val cspsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zspsvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> afp:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val ssptrd : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> d:(float ptr) -> e:(float ptr) -> tau:(float ptr) -> int 

val dsptrd : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> d:(float ptr) -> e:(float ptr) -> tau:(float ptr) -> int 

val ssptrf : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int ptr) -> int 

val dsptrf : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int ptr) -> int 

val csptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> int 

val zsptrf : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> int 

val ssptri : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int ptr) -> int 

val dsptri : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> ipiv:(int ptr) -> int 

val csptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> int 

val zsptri : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> int 

val ssptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dsptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(float ptr) -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val csptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zsptrs : layout:int -> uplo:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val sstebz : range:char -> order:char -> n:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> d:(float ptr) -> e:(float ptr) -> m:(int ptr) -> nsplit:(int ptr) -> w:(float ptr) -> iblock:(int ptr) -> isplit:(int ptr) -> int 

val dstebz : range:char -> order:char -> n:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> d:(float ptr) -> e:(float ptr) -> m:(int ptr) -> nsplit:(int ptr) -> w:(float ptr) -> iblock:(int ptr) -> isplit:(int ptr) -> int 

val sstedc : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dstedc : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val cstedc : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zstedc : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val sstegr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int ptr) -> int 

val dstegr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int ptr) -> int 

val cstegr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> isuppz:(int ptr) -> int 

val zstegr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> isuppz:(int ptr) -> int 

val sstein : layout:int -> n:int -> d:(float ptr) -> e:(float ptr) -> m:int -> w:(float ptr) -> iblock:(int ptr) -> isplit:(int ptr) -> z:(float ptr) -> ldz:int -> ifailv:(int ptr) -> int 

val dstein : layout:int -> n:int -> d:(float ptr) -> e:(float ptr) -> m:int -> w:(float ptr) -> iblock:(int ptr) -> isplit:(int ptr) -> z:(float ptr) -> ldz:int -> ifailv:(int ptr) -> int 

val cstein : layout:int -> n:int -> d:(float ptr) -> e:(float ptr) -> m:int -> w:(float ptr) -> iblock:(int ptr) -> isplit:(int ptr) -> z:(Complex.t ptr) -> ldz:int -> ifailv:(int ptr) -> int 

val zstein : layout:int -> n:int -> d:(float ptr) -> e:(float ptr) -> m:int -> w:(float ptr) -> iblock:(int ptr) -> isplit:(int ptr) -> z:(Complex.t ptr) -> ldz:int -> ifailv:(int ptr) -> int 

val sstemr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> nzc:int -> isuppz:(int ptr) -> tryrac:(int ptr) -> int 

val dstemr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> nzc:int -> isuppz:(int ptr) -> tryrac:(int ptr) -> int 

val cstemr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> nzc:int -> isuppz:(int ptr) -> tryrac:(int ptr) -> int 

val zstemr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> m:(int ptr) -> w:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> nzc:int -> isuppz:(int ptr) -> tryrac:(int ptr) -> int 

val ssteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dsteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val csteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val zsteqr : layout:int -> compz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(Complex.t ptr) -> ldz:int -> int 

val ssterf : n:int -> d:(float ptr) -> e:(float ptr) -> int 

val dsterf : n:int -> d:(float ptr) -> e:(float ptr) -> int 

val sstev : layout:int -> jobz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dstev : layout:int -> jobz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val sstevd : layout:int -> jobz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val dstevd : layout:int -> jobz:char -> n:int -> d:(float ptr) -> e:(float ptr) -> z:(float ptr) -> ldz:int -> int 

val sstevr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int ptr) -> int 

val dstevr : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int ptr) -> int 

val sstevx : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val dstevx : layout:int -> jobz:char -> range:char -> n:int -> d:(float ptr) -> e:(float ptr) -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val ssycon : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val dsycon : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val csycon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val zsycon : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> anorm:float -> rcond:(float ptr) -> int 

val ssyequb : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val dsyequb : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val csyequb : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val zsyequb : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> s:(float ptr) -> scond:(float ptr) -> amax:(float ptr) -> int 

val ssyev : layout:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> w:(float ptr) -> int 

val dsyev : layout:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> w:(float ptr) -> int 

val ssyevd : layout:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> w:(float ptr) -> int 

val dsyevd : layout:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> w:(float ptr) -> int 

val ssyevr : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int ptr) -> int 

val dsyevr : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> isuppz:(int ptr) -> int 

val ssyevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val dsyevx : layout:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val ssygst : layout:int -> ityp:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val dsygst : layout:int -> ityp:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val ssygv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> w:(float ptr) -> int 

val dsygv : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> w:(float ptr) -> int 

val ssygvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> w:(float ptr) -> int 

val dsygvd : layout:int -> ityp:int -> jobz:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> w:(float ptr) -> int 

val ssygvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val dsygvx : layout:int -> ityp:int -> jobz:char -> range:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> vl:float -> vu:float -> il:int -> iu:int -> abstol:float -> m:(int ptr) -> w:(float ptr) -> z:(float ptr) -> ldz:int -> ifail:(int ptr) -> int 

val ssyrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dsyrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val csyrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zsyrfs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val ssysv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dsysv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val csysv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zsysv : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val ssysvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dsysvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> af:(float ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val csysvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val zsysvx : layout:int -> fact:char -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> af:(Complex.t ptr) -> ldaf:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> rcond:(float ptr) -> ferr:(float ptr) -> berr:(float ptr) -> int 

val ssytrd : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tau:(float ptr) -> int 

val dsytrd : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> d:(float ptr) -> e:(float ptr) -> tau:(float ptr) -> int 

val ssytrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val dsytrf : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val csytrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zsytrf : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val ssytri : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val dsytri : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val csytri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zsytri : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val ssytrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dsytrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val csytrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zsytrs : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val stbcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> rcond:(float ptr) -> int 

val dtbcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> kd:int -> ab:(float ptr) -> ldab:int -> rcond:(float ptr) -> int 

val ctbcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> rcond:(float ptr) -> int 

val ztbcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> kd:int -> ab:(Complex.t ptr) -> ldab:int -> rcond:(float ptr) -> int 

val stbrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dtbrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val ctbrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val ztbrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val stbtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int 

val dtbtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(float ptr) -> ldab:int -> b:(float ptr) -> ldb:int -> int 

val ctbtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int 

val ztbtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> kd:int -> nrhs:int -> ab:(Complex.t ptr) -> ldab:int -> b:(Complex.t ptr) -> ldb:int -> int 

val stfsm : layout:int -> transr:char -> side:char -> uplo:char -> trans:char -> diag:char -> m:int -> n:int -> alpha:float -> a:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val dtfsm : layout:int -> transr:char -> side:char -> uplo:char -> trans:char -> diag:char -> m:int -> n:int -> alpha:float -> a:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val ctfsm : layout:int -> transr:char -> side:char -> uplo:char -> trans:char -> diag:char -> m:int -> n:int -> alpha:Complex.t -> a:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val ztfsm : layout:int -> transr:char -> side:char -> uplo:char -> trans:char -> diag:char -> m:int -> n:int -> alpha:Complex.t -> a:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val stftri : layout:int -> transr:char -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> int 

val dtftri : layout:int -> transr:char -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> int 

val ctftri : layout:int -> transr:char -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> int 

val ztftri : layout:int -> transr:char -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> int 

val stfttp : layout:int -> transr:char -> uplo:char -> n:int -> arf:(float ptr) -> ap:(float ptr) -> int 

val dtfttp : layout:int -> transr:char -> uplo:char -> n:int -> arf:(float ptr) -> ap:(float ptr) -> int 

val ctfttp : layout:int -> transr:char -> uplo:char -> n:int -> arf:(Complex.t ptr) -> ap:(Complex.t ptr) -> int 

val ztfttp : layout:int -> transr:char -> uplo:char -> n:int -> arf:(Complex.t ptr) -> ap:(Complex.t ptr) -> int 

val stfttr : layout:int -> transr:char -> uplo:char -> n:int -> arf:(float ptr) -> a:(float ptr) -> lda:int -> int 

val dtfttr : layout:int -> transr:char -> uplo:char -> n:int -> arf:(float ptr) -> a:(float ptr) -> lda:int -> int 

val ctfttr : layout:int -> transr:char -> uplo:char -> n:int -> arf:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> int 

val ztfttr : layout:int -> transr:char -> uplo:char -> n:int -> arf:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> int 

val stgevc : layout:int -> side:char -> howmny:char -> select:(int ptr) -> n:int -> s:(float ptr) -> lds:int -> p:(float ptr) -> ldp:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> int 

val dtgevc : layout:int -> side:char -> howmny:char -> select:(int ptr) -> n:int -> s:(float ptr) -> lds:int -> p:(float ptr) -> ldp:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> int 

val ctgevc : layout:int -> side:char -> howmny:char -> select:(int ptr) -> n:int -> s:(Complex.t ptr) -> lds:int -> p:(Complex.t ptr) -> ldp:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> int 

val ztgevc : layout:int -> side:char -> howmny:char -> select:(int ptr) -> n:int -> s:(Complex.t ptr) -> lds:int -> p:(Complex.t ptr) -> ldp:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> int 

val stgexc : layout:int -> wantq:int -> wantz:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> ifst:(int ptr) -> ilst:(int ptr) -> int 

val dtgexc : layout:int -> wantq:int -> wantz:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> ifst:(int ptr) -> ilst:(int ptr) -> int 

val ctgexc : layout:int -> wantq:int -> wantz:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> ifst:int -> ilst:int -> int 

val ztgexc : layout:int -> wantq:int -> wantz:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> ifst:int -> ilst:int -> int 

val stgsen : layout:int -> ijob:int -> wantq:int -> wantz:int -> select:(int ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> m:(int ptr) -> pl:(float ptr) -> pr:(float ptr) -> dif:(float ptr) -> int 

val dtgsen : layout:int -> ijob:int -> wantq:int -> wantz:int -> select:(int ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> alphar:(float ptr) -> alphai:(float ptr) -> beta:(float ptr) -> q:(float ptr) -> ldq:int -> z:(float ptr) -> ldz:int -> m:(int ptr) -> pl:(float ptr) -> pr:(float ptr) -> dif:(float ptr) -> int 

val ctgsen : layout:int -> ijob:int -> wantq:int -> wantz:int -> select:(int ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> m:(int ptr) -> pl:(float ptr) -> pr:(float ptr) -> dif:(float ptr) -> int 

val ztgsen : layout:int -> ijob:int -> wantq:int -> wantz:int -> select:(int ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> alpha:(Complex.t ptr) -> beta:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> z:(Complex.t ptr) -> ldz:int -> m:(int ptr) -> pl:(float ptr) -> pr:(float ptr) -> dif:(float ptr) -> int 

val stgsja : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> k:int -> l:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> tola:float -> tolb:float -> alpha:(float ptr) -> beta:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> ncycle:(int ptr) -> int 

val dtgsja : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> k:int -> l:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> tola:float -> tolb:float -> alpha:(float ptr) -> beta:(float ptr) -> u:(float ptr) -> ldu:int -> v:(float ptr) -> ldv:int -> q:(float ptr) -> ldq:int -> ncycle:(int ptr) -> int 

val ctgsja : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> k:int -> l:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> tola:float -> tolb:float -> alpha:(float ptr) -> beta:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> ncycle:(int ptr) -> int 

val ztgsja : layout:int -> jobu:char -> jobv:char -> jobq:char -> m:int -> p:int -> n:int -> k:int -> l:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> tola:float -> tolb:float -> alpha:(float ptr) -> beta:(float ptr) -> u:(Complex.t ptr) -> ldu:int -> v:(Complex.t ptr) -> ldv:int -> q:(Complex.t ptr) -> ldq:int -> ncycle:(int ptr) -> int 

val stgsna : layout:int -> job:char -> howmny:char -> select:(int ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> s:(float ptr) -> dif:(float ptr) -> mm:int -> m:(int ptr) -> int 

val dtgsna : layout:int -> job:char -> howmny:char -> select:(int ptr) -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> s:(float ptr) -> dif:(float ptr) -> mm:int -> m:(int ptr) -> int 

val ctgsna : layout:int -> job:char -> howmny:char -> select:(int ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> s:(float ptr) -> dif:(float ptr) -> mm:int -> m:(int ptr) -> int 

val ztgsna : layout:int -> job:char -> howmny:char -> select:(int ptr) -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> s:(float ptr) -> dif:(float ptr) -> mm:int -> m:(int ptr) -> int 

val stgsyl : layout:int -> trans:char -> ijob:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> ldc:int -> d:(float ptr) -> ldd:int -> e:(float ptr) -> lde:int -> f:(float ptr) -> ldf:int -> scale:(float ptr) -> dif:(float ptr) -> int 

val dtgsyl : layout:int -> trans:char -> ijob:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> ldc:int -> d:(float ptr) -> ldd:int -> e:(float ptr) -> lde:int -> f:(float ptr) -> ldf:int -> scale:(float ptr) -> dif:(float ptr) -> int 

val ctgsyl : layout:int -> trans:char -> ijob:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> ldc:int -> d:(Complex.t ptr) -> ldd:int -> e:(Complex.t ptr) -> lde:int -> f:(Complex.t ptr) -> ldf:int -> scale:(float ptr) -> dif:(float ptr) -> int 

val ztgsyl : layout:int -> trans:char -> ijob:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> ldc:int -> d:(Complex.t ptr) -> ldd:int -> e:(Complex.t ptr) -> lde:int -> f:(Complex.t ptr) -> ldf:int -> scale:(float ptr) -> dif:(float ptr) -> int 

val stpcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> ap:(float ptr) -> rcond:(float ptr) -> int 

val dtpcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> ap:(float ptr) -> rcond:(float ptr) -> int 

val ctpcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> ap:(Complex.t ptr) -> rcond:(float ptr) -> int 

val ztpcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> ap:(Complex.t ptr) -> rcond:(float ptr) -> int 

val stprfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dtprfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val ctprfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val ztprfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val stptri : layout:int -> uplo:char -> diag:char -> n:int -> ap:(float ptr) -> int 

val dtptri : layout:int -> uplo:char -> diag:char -> n:int -> ap:(float ptr) -> int 

val ctptri : layout:int -> uplo:char -> diag:char -> n:int -> ap:(Complex.t ptr) -> int 

val ztptri : layout:int -> uplo:char -> diag:char -> n:int -> ap:(Complex.t ptr) -> int 

val stptrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val dtptrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(float ptr) -> b:(float ptr) -> ldb:int -> int 

val ctptrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val ztptrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> ap:(Complex.t ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val stpttf : layout:int -> transr:char -> uplo:char -> n:int -> ap:(float ptr) -> arf:(float ptr) -> int 

val dtpttf : layout:int -> transr:char -> uplo:char -> n:int -> ap:(float ptr) -> arf:(float ptr) -> int 

val ctpttf : layout:int -> transr:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> arf:(Complex.t ptr) -> int 

val ztpttf : layout:int -> transr:char -> uplo:char -> n:int -> ap:(Complex.t ptr) -> arf:(Complex.t ptr) -> int 

val stpttr : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> a:(float ptr) -> lda:int -> int 

val dtpttr : layout:int -> uplo:char -> n:int -> ap:(float ptr) -> a:(float ptr) -> lda:int -> int 

val ctpttr : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> int 

val ztpttr : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> a:(Complex.t ptr) -> lda:int -> int 

val strcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> lda:int -> rcond:(float ptr) -> int 

val dtrcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> lda:int -> rcond:(float ptr) -> int 

val ctrcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> lda:int -> rcond:(float ptr) -> int 

val ztrcon : layout:int -> norm:char -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> lda:int -> rcond:(float ptr) -> int 

val strevc : layout:int -> side:char -> howmny:char -> select:(int ptr) -> n:int -> t:(float ptr) -> ldt:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> int 

val dtrevc : layout:int -> side:char -> howmny:char -> select:(int ptr) -> n:int -> t:(float ptr) -> ldt:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> int 

val ctrevc : layout:int -> side:char -> howmny:char -> select:(int ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> int 

val ztrevc : layout:int -> side:char -> howmny:char -> select:(int ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> mm:int -> m:(int ptr) -> int 

val strexc : layout:int -> compq:char -> n:int -> t:(float ptr) -> ldt:int -> q:(float ptr) -> ldq:int -> ifst:(int ptr) -> ilst:(int ptr) -> int 

val dtrexc : layout:int -> compq:char -> n:int -> t:(float ptr) -> ldt:int -> q:(float ptr) -> ldq:int -> ifst:(int ptr) -> ilst:(int ptr) -> int 

val ctrexc : layout:int -> compq:char -> n:int -> t:(Complex.t ptr) -> ldt:int -> q:(Complex.t ptr) -> ldq:int -> ifst:int -> ilst:int -> int 

val ztrexc : layout:int -> compq:char -> n:int -> t:(Complex.t ptr) -> ldt:int -> q:(Complex.t ptr) -> ldq:int -> ifst:int -> ilst:int -> int 

val strrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val dtrrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> x:(float ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val ctrrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val ztrrfs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> x:(Complex.t ptr) -> ldx:int -> ferr:(float ptr) -> berr:(float ptr) -> int 

val strsen : layout:int -> job:char -> compq:char -> select:(int ptr) -> n:int -> t:(float ptr) -> ldt:int -> q:(float ptr) -> ldq:int -> wr:(float ptr) -> wi:(float ptr) -> m:(int ptr) -> s:(float ptr) -> sep:(float ptr) -> int 

val dtrsen : layout:int -> job:char -> compq:char -> select:(int ptr) -> n:int -> t:(float ptr) -> ldt:int -> q:(float ptr) -> ldq:int -> wr:(float ptr) -> wi:(float ptr) -> m:(int ptr) -> s:(float ptr) -> sep:(float ptr) -> int 

val ctrsen : layout:int -> job:char -> compq:char -> select:(int ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> q:(Complex.t ptr) -> ldq:int -> w:(Complex.t ptr) -> m:(int ptr) -> s:(float ptr) -> sep:(float ptr) -> int 

val ztrsen : layout:int -> job:char -> compq:char -> select:(int ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> q:(Complex.t ptr) -> ldq:int -> w:(Complex.t ptr) -> m:(int ptr) -> s:(float ptr) -> sep:(float ptr) -> int 

val strsna : layout:int -> job:char -> howmny:char -> select:(int ptr) -> n:int -> t:(float ptr) -> ldt:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> s:(float ptr) -> sep:(float ptr) -> mm:int -> m:(int ptr) -> int 

val dtrsna : layout:int -> job:char -> howmny:char -> select:(int ptr) -> n:int -> t:(float ptr) -> ldt:int -> vl:(float ptr) -> ldvl:int -> vr:(float ptr) -> ldvr:int -> s:(float ptr) -> sep:(float ptr) -> mm:int -> m:(int ptr) -> int 

val ctrsna : layout:int -> job:char -> howmny:char -> select:(int ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> s:(float ptr) -> sep:(float ptr) -> mm:int -> m:(int ptr) -> int 

val ztrsna : layout:int -> job:char -> howmny:char -> select:(int ptr) -> n:int -> t:(Complex.t ptr) -> ldt:int -> vl:(Complex.t ptr) -> ldvl:int -> vr:(Complex.t ptr) -> ldvr:int -> s:(float ptr) -> sep:(float ptr) -> mm:int -> m:(int ptr) -> int 

val strsyl : layout:int -> trana:char -> tranb:char -> isgn:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> ldc:int -> scale:(float ptr) -> int 

val dtrsyl : layout:int -> trana:char -> tranb:char -> isgn:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> c:(float ptr) -> ldc:int -> scale:(float ptr) -> int 

val ctrsyl : layout:int -> trana:char -> tranb:char -> isgn:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> ldc:int -> scale:(float ptr) -> int 

val ztrsyl : layout:int -> trana:char -> tranb:char -> isgn:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> c:(Complex.t ptr) -> ldc:int -> scale:(float ptr) -> int 

val strtri : layout:int -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> lda:int -> int 

val dtrtri : layout:int -> uplo:char -> diag:char -> n:int -> a:(float ptr) -> lda:int -> int 

val ctrtri : layout:int -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val ztrtri : layout:int -> uplo:char -> diag:char -> n:int -> a:(Complex.t ptr) -> lda:int -> int 

val strtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val dtrtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val ctrtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val ztrtrs : layout:int -> uplo:char -> trans:char -> diag:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val strttf : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> arf:(float ptr) -> int 

val dtrttf : layout:int -> transr:char -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> arf:(float ptr) -> int 

val ctrttf : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> arf:(Complex.t ptr) -> int 

val ztrttf : layout:int -> transr:char -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> arf:(Complex.t ptr) -> int 

val strttp : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ap:(float ptr) -> int 

val dtrttp : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ap:(float ptr) -> int 

val ctrttp : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ap:(Complex.t ptr) -> int 

val ztrttp : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ap:(Complex.t ptr) -> int 

val stzrzf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val dtzrzf : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> tau:(float ptr) -> int 

val ctzrzf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val ztzrzf : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val cungbr : layout:int -> vect:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zungbr : layout:int -> vect:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val cunghr : layout:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zunghr : layout:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val cunglq : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zunglq : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val cungql : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zungql : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val cungqr : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zungqr : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val cungrq : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zungrq : layout:int -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val cungtr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val zungtr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> int 

val cunmbr : layout:int -> vect:char -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val zunmbr : layout:int -> vect:char -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val cunmhr : layout:int -> side:char -> trans:char -> m:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val zunmhr : layout:int -> side:char -> trans:char -> m:int -> n:int -> ilo:int -> ihi:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val cunmlq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val zunmlq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val cunmql : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val zunmql : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val cunmqr : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val zunmqr : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val cunmrq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val zunmrq : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val cunmrz : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val zunmrz : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val cunmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val zunmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val cupgtr : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> tau:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> int 

val zupgtr : layout:int -> uplo:char -> n:int -> ap:(Complex.t ptr) -> tau:(Complex.t ptr) -> q:(Complex.t ptr) -> ldq:int -> int 

val cupmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> ap:(Complex.t ptr) -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val zupmtr : layout:int -> side:char -> uplo:char -> trans:char -> m:int -> n:int -> ap:(Complex.t ptr) -> tau:(Complex.t ptr) -> c:(Complex.t ptr) -> ldc:int -> int 

val claghe : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int ptr) -> int 

val zlaghe : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int ptr) -> int 

val slagsy : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(float ptr) -> lda:int -> iseed:(int ptr) -> int 

val dlagsy : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(float ptr) -> lda:int -> iseed:(int ptr) -> int 

val clagsy : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int ptr) -> int 

val zlagsy : layout:int -> n:int -> k:int -> d:(float ptr) -> a:(Complex.t ptr) -> lda:int -> iseed:(int ptr) -> int 

val slapmr : layout:int -> forwrd:int -> m:int -> n:int -> x:(float ptr) -> ldx:int -> k:(int ptr) -> int 

val dlapmr : layout:int -> forwrd:int -> m:int -> n:int -> x:(float ptr) -> ldx:int -> k:(int ptr) -> int 

val clapmr : layout:int -> forwrd:int -> m:int -> n:int -> x:(Complex.t ptr) -> ldx:int -> k:(int ptr) -> int 

val zlapmr : layout:int -> forwrd:int -> m:int -> n:int -> x:(Complex.t ptr) -> ldx:int -> k:(int ptr) -> int 

val slapmt : layout:int -> forwrd:int -> m:int -> n:int -> x:(float ptr) -> ldx:int -> k:(int ptr) -> int 

val dlapmt : layout:int -> forwrd:int -> m:int -> n:int -> x:(float ptr) -> ldx:int -> k:(int ptr) -> int 

val clapmt : layout:int -> forwrd:int -> m:int -> n:int -> x:(Complex.t ptr) -> ldx:int -> k:(int ptr) -> int 

val zlapmt : layout:int -> forwrd:int -> m:int -> n:int -> x:(Complex.t ptr) -> ldx:int -> k:(int ptr) -> int 

val slartgp : f:float -> g:float -> cs:(float ptr) -> sn:(float ptr) -> r:(float ptr) -> int 

val dlartgp : f:float -> g:float -> cs:(float ptr) -> sn:(float ptr) -> r:(float ptr) -> int 

val slartgs : x:float -> y:float -> sigma:float -> cs:(float ptr) -> sn:(float ptr) -> int 

val dlartgs : x:float -> y:float -> sigma:float -> cs:(float ptr) -> sn:(float ptr) -> int 

val cbbcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> m:int -> p:int -> q:int -> theta:(float ptr) -> phi:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> v2t:(Complex.t ptr) -> ldv2t:int -> b11d:(float ptr) -> b11e:(float ptr) -> b12d:(float ptr) -> b12e:(float ptr) -> b21d:(float ptr) -> b21e:(float ptr) -> b22d:(float ptr) -> b22e:(float ptr) -> int 

val cheswapr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> i1:int -> i2:int -> int 

val chetri2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val chetri2x : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> nb:int -> int 

val chetrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val csyconv : layout:int -> uplo:char -> way:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> e:(Complex.t ptr) -> int 

val csyswapr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> i1:int -> i2:int -> int 

val csytri2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val csytri2x : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> nb:int -> int 

val csytrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val cunbdb : layout:int -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x12:(Complex.t ptr) -> ldx12:int -> x21:(Complex.t ptr) -> ldx21:int -> x22:(Complex.t ptr) -> ldx22:int -> theta:(float ptr) -> phi:(float ptr) -> taup1:(Complex.t ptr) -> taup2:(Complex.t ptr) -> tauq1:(Complex.t ptr) -> tauq2:(Complex.t ptr) -> int 

val cuncsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x12:(Complex.t ptr) -> ldx12:int -> x21:(Complex.t ptr) -> ldx21:int -> x22:(Complex.t ptr) -> ldx22:int -> theta:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> v2t:(Complex.t ptr) -> ldv2t:int -> int 

val cuncsd2by1 : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x21:(Complex.t ptr) -> ldx21:int -> theta:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> int 

val dbbcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> m:int -> p:int -> q:int -> theta:(float ptr) -> phi:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> v2t:(float ptr) -> ldv2t:int -> b11d:(float ptr) -> b11e:(float ptr) -> b12d:(float ptr) -> b12e:(float ptr) -> b21d:(float ptr) -> b21e:(float ptr) -> b22d:(float ptr) -> b22e:(float ptr) -> int 

val dorbdb : layout:int -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x12:(float ptr) -> ldx12:int -> x21:(float ptr) -> ldx21:int -> x22:(float ptr) -> ldx22:int -> theta:(float ptr) -> phi:(float ptr) -> taup1:(float ptr) -> taup2:(float ptr) -> tauq1:(float ptr) -> tauq2:(float ptr) -> int 

val dorcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x12:(float ptr) -> ldx12:int -> x21:(float ptr) -> ldx21:int -> x22:(float ptr) -> ldx22:int -> theta:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> v2t:(float ptr) -> ldv2t:int -> int 

val dorcsd2by1 : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x21:(float ptr) -> ldx21:int -> theta:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> int 

val dsyconv : layout:int -> uplo:char -> way:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> e:(float ptr) -> int 

val dsyswapr : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> i1:int -> i2:int -> int 

val dsytri2 : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val dsytri2x : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> nb:int -> int 

val dsytrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val sbbcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> m:int -> p:int -> q:int -> theta:(float ptr) -> phi:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> v2t:(float ptr) -> ldv2t:int -> b11d:(float ptr) -> b11e:(float ptr) -> b12d:(float ptr) -> b12e:(float ptr) -> b21d:(float ptr) -> b21e:(float ptr) -> b22d:(float ptr) -> b22e:(float ptr) -> int 

val sorbdb : layout:int -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x12:(float ptr) -> ldx12:int -> x21:(float ptr) -> ldx21:int -> x22:(float ptr) -> ldx22:int -> theta:(float ptr) -> phi:(float ptr) -> taup1:(float ptr) -> taup2:(float ptr) -> tauq1:(float ptr) -> tauq2:(float ptr) -> int 

val sorcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x12:(float ptr) -> ldx12:int -> x21:(float ptr) -> ldx21:int -> x22:(float ptr) -> ldx22:int -> theta:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> v2t:(float ptr) -> ldv2t:int -> int 

val sorcsd2by1 : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> m:int -> p:int -> q:int -> x11:(float ptr) -> ldx11:int -> x21:(float ptr) -> ldx21:int -> theta:(float ptr) -> u1:(float ptr) -> ldu1:int -> u2:(float ptr) -> ldu2:int -> v1t:(float ptr) -> ldv1t:int -> int 

val ssyconv : layout:int -> uplo:char -> way:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> e:(float ptr) -> int 

val ssyswapr : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> i1:int -> i2:int -> int 

val ssytri2 : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val ssytri2x : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> nb:int -> int 

val ssytrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val zbbcsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> m:int -> p:int -> q:int -> theta:(float ptr) -> phi:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> v2t:(Complex.t ptr) -> ldv2t:int -> b11d:(float ptr) -> b11e:(float ptr) -> b12d:(float ptr) -> b12e:(float ptr) -> b21d:(float ptr) -> b21e:(float ptr) -> b22d:(float ptr) -> b22e:(float ptr) -> int 

val zheswapr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> i1:int -> i2:int -> int 

val zhetri2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zhetri2x : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> nb:int -> int 

val zhetrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zsyconv : layout:int -> uplo:char -> way:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> e:(Complex.t ptr) -> int 

val zsyswapr : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> i1:int -> i2:int -> int 

val zsytri2 : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zsytri2x : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> nb:int -> int 

val zsytrs2 : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zunbdb : layout:int -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x12:(Complex.t ptr) -> ldx12:int -> x21:(Complex.t ptr) -> ldx21:int -> x22:(Complex.t ptr) -> ldx22:int -> theta:(float ptr) -> phi:(float ptr) -> taup1:(Complex.t ptr) -> taup2:(Complex.t ptr) -> tauq1:(Complex.t ptr) -> tauq2:(Complex.t ptr) -> int 

val zuncsd : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> jobv2t:char -> trans:char -> signs:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x12:(Complex.t ptr) -> ldx12:int -> x21:(Complex.t ptr) -> ldx21:int -> x22:(Complex.t ptr) -> ldx22:int -> theta:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> v2t:(Complex.t ptr) -> ldv2t:int -> int 

val zuncsd2by1 : layout:int -> jobu1:char -> jobu2:char -> jobv1t:char -> m:int -> p:int -> q:int -> x11:(Complex.t ptr) -> ldx11:int -> x21:(Complex.t ptr) -> ldx21:int -> theta:(float ptr) -> u1:(Complex.t ptr) -> ldu1:int -> u2:(Complex.t ptr) -> ldu2:int -> v1t:(Complex.t ptr) -> ldv1t:int -> int 

val sgemqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> nb:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> c:(float ptr) -> ldc:int -> int 

val dgemqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> nb:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> c:(float ptr) -> ldc:int -> int 

val cgemqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> nb:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> c:(Complex.t ptr) -> ldc:int -> int 

val zgemqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> nb:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> c:(Complex.t ptr) -> ldc:int -> int 

val sgeqrt : layout:int -> m:int -> n:int -> nb:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int 

val dgeqrt : layout:int -> m:int -> n:int -> nb:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int 

val cgeqrt : layout:int -> m:int -> n:int -> nb:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int 

val zgeqrt : layout:int -> m:int -> n:int -> nb:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int 

val sgeqrt2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int 

val dgeqrt2 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int 

val cgeqrt2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int 

val zgeqrt2 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int 

val sgeqrt3 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int 

val dgeqrt3 : layout:int -> m:int -> n:int -> a:(float ptr) -> lda:int -> t:(float ptr) -> ldt:int -> int 

val cgeqrt3 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int 

val zgeqrt3 : layout:int -> m:int -> n:int -> a:(Complex.t ptr) -> lda:int -> t:(Complex.t ptr) -> ldt:int -> int 

val stpmqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> nb:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val dtpmqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> nb:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val ctpmqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> nb:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val ztpmqrt : layout:int -> side:char -> trans:char -> m:int -> n:int -> k:int -> l:int -> nb:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val stpqrt : layout:int -> m:int -> n:int -> l:int -> nb:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> t:(float ptr) -> ldt:int -> int 

val dtpqrt : layout:int -> m:int -> n:int -> l:int -> nb:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> t:(float ptr) -> ldt:int -> int 

val ctpqrt : layout:int -> m:int -> n:int -> l:int -> nb:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> t:(Complex.t ptr) -> ldt:int -> int 

val ztpqrt : layout:int -> m:int -> n:int -> l:int -> nb:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> t:(Complex.t ptr) -> ldt:int -> int 

val stpqrt2 : layout:int -> m:int -> n:int -> l:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> t:(float ptr) -> ldt:int -> int 

val dtpqrt2 : layout:int -> m:int -> n:int -> l:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> t:(float ptr) -> ldt:int -> int 

val ctpqrt2 : layout:int -> m:int -> n:int -> l:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> t:(Complex.t ptr) -> ldt:int -> int 

val ztpqrt2 : layout:int -> m:int -> n:int -> l:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> t:(Complex.t ptr) -> ldt:int -> int 

val stprfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> l:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val dtprfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> l:int -> v:(float ptr) -> ldv:int -> t:(float ptr) -> ldt:int -> a:(float ptr) -> lda:int -> b:(float ptr) -> ldb:int -> int 

val ctprfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> l:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val ztprfb : layout:int -> side:char -> trans:char -> direct:char -> storev:char -> m:int -> n:int -> k:int -> l:int -> v:(Complex.t ptr) -> ldv:int -> t:(Complex.t ptr) -> ldt:int -> a:(Complex.t ptr) -> lda:int -> b:(Complex.t ptr) -> ldb:int -> int 

val ssysv_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dsysv_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val csysv_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zsysv_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val ssytrf_rook : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val dsytrf_rook : layout:int -> uplo:char -> n:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> int 

val csytrf_rook : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zsytrf_rook : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val ssytrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val dsytrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(float ptr) -> lda:int -> ipiv:(int ptr) -> b:(float ptr) -> ldb:int -> int 

val csytrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zsytrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val chetrf_rook : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val zhetrf_rook : layout:int -> uplo:char -> n:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> int 

val chetrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val zhetrs_rook : layout:int -> uplo:char -> n:int -> nrhs:int -> a:(Complex.t ptr) -> lda:int -> ipiv:(int ptr) -> b:(Complex.t ptr) -> ldb:int -> int 

val csyr : layout:int -> uplo:char -> n:int -> alpha:Complex.t -> x:(Complex.t ptr) -> incx:int -> a:(Complex.t ptr) -> lda:int -> int 

val zsyr : layout:int -> uplo:char -> n:int -> alpha:Complex.t -> x:(Complex.t ptr) -> incx:int -> a:(Complex.t ptr) -> lda:int -> int 

