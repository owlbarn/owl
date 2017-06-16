(* auto-generated lapacke interface file, timestamp:1497624559 *)

open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct

  open F

  let sbdsdc = foreign "LAPACKE_sbdsdc" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr int @-> returning int )

  let dbdsdc = foreign "LAPACKE_dbdsdc" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr int @-> returning int )

  let sbdsqr = foreign "LAPACKE_sbdsqr" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dbdsqr = foreign "LAPACKE_dbdsqr" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cbdsqr = foreign "LAPACKE_cbdsqr" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zbdsqr = foreign "LAPACKE_zbdsqr" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sbdsvdx = foreign "LAPACKE_sbdsvdx" ( int @-> char @-> char @-> char @-> int @-> ptr float @-> ptr float @-> float @-> float @-> int @-> int @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dbdsvdx = foreign "LAPACKE_dbdsvdx" ( int @-> char @-> char @-> char @-> int @-> ptr double @-> ptr double @-> double @-> double @-> int @-> int @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let sdisna = foreign "LAPACKE_sdisna" ( char @-> int @-> int @-> ptr float @-> ptr float @-> returning int )

  let ddisna = foreign "LAPACKE_ddisna" ( char @-> int @-> int @-> ptr double @-> ptr double @-> returning int )

  let sgbbrd = foreign "LAPACKE_sgbbrd" ( int @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgbbrd = foreign "LAPACKE_dgbbrd" ( int @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgbbrd = foreign "LAPACKE_cgbbrd" ( int @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgbbrd = foreign "LAPACKE_zgbbrd" ( int @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgbcon = foreign "LAPACKE_sgbcon" ( int @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> float @-> ptr float @-> returning int )

  let dgbcon = foreign "LAPACKE_dgbcon" ( int @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> double @-> ptr double @-> returning int )

  let cgbcon = foreign "LAPACKE_cgbcon" ( int @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> float @-> ptr float @-> returning int )

  let zgbcon = foreign "LAPACKE_zgbcon" ( int @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> double @-> ptr double @-> returning int )

  let sgbequ = foreign "LAPACKE_sgbequ" ( int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgbequ = foreign "LAPACKE_dgbequ" ( int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgbequ = foreign "LAPACKE_cgbequ" ( int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zgbequ = foreign "LAPACKE_zgbequ" ( int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sgbequb = foreign "LAPACKE_sgbequb" ( int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgbequb = foreign "LAPACKE_dgbequb" ( int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgbequb = foreign "LAPACKE_cgbequb" ( int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zgbequb = foreign "LAPACKE_zgbequb" ( int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sgbrfs = foreign "LAPACKE_sgbrfs" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dgbrfs = foreign "LAPACKE_dgbrfs" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let cgbrfs = foreign "LAPACKE_cgbrfs" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zgbrfs = foreign "LAPACKE_zgbrfs" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let sgbsv = foreign "LAPACKE_sgbsv" ( int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> returning int )

  let dgbsv = foreign "LAPACKE_dgbsv" ( int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> returning int )

  let cgbsv = foreign "LAPACKE_cgbsv" ( int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zgbsv = foreign "LAPACKE_zgbsv" ( int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let sgbsvx = foreign "LAPACKE_sgbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr char @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgbsvx = foreign "LAPACKE_dgbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr char @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgbsvx = foreign "LAPACKE_cgbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr char @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zgbsvx = foreign "LAPACKE_zgbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr char @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sgbtrf = foreign "LAPACKE_sgbtrf" ( int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dgbtrf = foreign "LAPACKE_dgbtrf" ( int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let cgbtrf = foreign "LAPACKE_cgbtrf" ( int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zgbtrf = foreign "LAPACKE_zgbtrf" ( int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sgbtrs = foreign "LAPACKE_sgbtrs" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> returning int )

  let dgbtrs = foreign "LAPACKE_dgbtrs" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> returning int )

  let cgbtrs = foreign "LAPACKE_cgbtrs" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zgbtrs = foreign "LAPACKE_zgbtrs" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let sgebak = foreign "LAPACKE_sgebak" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgebak = foreign "LAPACKE_dgebak" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgebak = foreign "LAPACKE_cgebak" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgebak = foreign "LAPACKE_zgebak" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgebal = foreign "LAPACKE_sgebal" ( int @-> char @-> int @-> ptr float @-> int @-> ptr int @-> ptr int @-> ptr float @-> returning int )

  let dgebal = foreign "LAPACKE_dgebal" ( int @-> char @-> int @-> ptr double @-> int @-> ptr int @-> ptr int @-> ptr double @-> returning int )

  let cgebal = foreign "LAPACKE_cgebal" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr int @-> ptr float @-> returning int )

  let zgebal = foreign "LAPACKE_zgebal" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr int @-> ptr double @-> returning int )

  let sgebrd = foreign "LAPACKE_sgebrd" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgebrd = foreign "LAPACKE_dgebrd" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgebrd = foreign "LAPACKE_cgebrd" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> ptr complex32 @-> returning int )

  let zgebrd = foreign "LAPACKE_zgebrd" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> ptr complex64 @-> returning int )

  let sgecon = foreign "LAPACKE_sgecon" ( int @-> char @-> int @-> ptr float @-> int @-> float @-> ptr float @-> returning int )

  let dgecon = foreign "LAPACKE_dgecon" ( int @-> char @-> int @-> ptr double @-> int @-> double @-> ptr double @-> returning int )

  let cgecon = foreign "LAPACKE_cgecon" ( int @-> char @-> int @-> ptr complex32 @-> int @-> float @-> ptr float @-> returning int )

  let zgecon = foreign "LAPACKE_zgecon" ( int @-> char @-> int @-> ptr complex64 @-> int @-> double @-> ptr double @-> returning int )

  let sgeequ = foreign "LAPACKE_sgeequ" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgeequ = foreign "LAPACKE_dgeequ" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgeequ = foreign "LAPACKE_cgeequ" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zgeequ = foreign "LAPACKE_zgeequ" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sgeequb = foreign "LAPACKE_sgeequb" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgeequb = foreign "LAPACKE_dgeequb" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgeequb = foreign "LAPACKE_cgeequb" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zgeequb = foreign "LAPACKE_zgeequb" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sgees = foreign "LAPACKE_sgees" ( int @-> char @-> char @-> ptr void @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dgees = foreign "LAPACKE_dgees" ( int @-> char @-> char @-> ptr void @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let cgees = foreign "LAPACKE_cgees" ( int @-> char @-> char @-> ptr void @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zgees = foreign "LAPACKE_zgees" ( int @-> char @-> char @-> ptr void @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let sgeesx = foreign "LAPACKE_sgeesx" ( int @-> char @-> char @-> ptr void @-> char @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dgeesx = foreign "LAPACKE_dgeesx" ( int @-> char @-> char @-> ptr void @-> char @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let cgeesx = foreign "LAPACKE_cgeesx" ( int @-> char @-> char @-> ptr void @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zgeesx = foreign "LAPACKE_zgeesx" ( int @-> char @-> char @-> ptr void @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let sgeev = foreign "LAPACKE_sgeev" ( int @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgeev = foreign "LAPACKE_dgeev" ( int @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgeev = foreign "LAPACKE_cgeev" ( int @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgeev = foreign "LAPACKE_zgeev" ( int @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgeevx = foreign "LAPACKE_sgeevx" ( int @-> char @-> char @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgeevx = foreign "LAPACKE_dgeevx" ( int @-> char @-> char @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgeevx = foreign "LAPACKE_cgeevx" ( int @-> char @-> char @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zgeevx = foreign "LAPACKE_zgeevx" ( int @-> char @-> char @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sgehrd = foreign "LAPACKE_sgehrd" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgehrd = foreign "LAPACKE_dgehrd" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgehrd = foreign "LAPACKE_cgehrd" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zgehrd = foreign "LAPACKE_zgehrd" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let sgejsv = foreign "LAPACKE_sgejsv" ( int @-> char @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr int @-> returning int )

  let dgejsv = foreign "LAPACKE_dgejsv" ( int @-> char @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr int @-> returning int )

  let cgejsv = foreign "LAPACKE_cgejsv" ( int @-> char @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr int @-> returning int )

  let zgejsv = foreign "LAPACKE_zgejsv" ( int @-> char @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr int @-> returning int )

  let sgelq2 = foreign "LAPACKE_sgelq2" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgelq2 = foreign "LAPACKE_dgelq2" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgelq2 = foreign "LAPACKE_cgelq2" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zgelq2 = foreign "LAPACKE_zgelq2" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let sgelqf = foreign "LAPACKE_sgelqf" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgelqf = foreign "LAPACKE_dgelqf" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgelqf = foreign "LAPACKE_cgelqf" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zgelqf = foreign "LAPACKE_zgelqf" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let sgels = foreign "LAPACKE_sgels" ( int @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgels = foreign "LAPACKE_dgels" ( int @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgels = foreign "LAPACKE_cgels" ( int @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgels = foreign "LAPACKE_zgels" ( int @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgelsd = foreign "LAPACKE_sgelsd" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> float @-> ptr int @-> returning int )

  let dgelsd = foreign "LAPACKE_dgelsd" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> double @-> ptr int @-> returning int )

  let cgelsd = foreign "LAPACKE_cgelsd" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> float @-> ptr int @-> returning int )

  let zgelsd = foreign "LAPACKE_zgelsd" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> double @-> ptr int @-> returning int )

  let sgelss = foreign "LAPACKE_sgelss" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> float @-> ptr int @-> returning int )

  let dgelss = foreign "LAPACKE_dgelss" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> double @-> ptr int @-> returning int )

  let cgelss = foreign "LAPACKE_cgelss" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> float @-> ptr int @-> returning int )

  let zgelss = foreign "LAPACKE_zgelss" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> double @-> ptr int @-> returning int )

  let sgelsy = foreign "LAPACKE_sgelsy" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> float @-> ptr int @-> returning int )

  let dgelsy = foreign "LAPACKE_dgelsy" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> double @-> ptr int @-> returning int )

  let cgelsy = foreign "LAPACKE_cgelsy" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> float @-> ptr int @-> returning int )

  let zgelsy = foreign "LAPACKE_zgelsy" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> double @-> ptr int @-> returning int )

  let sgeqlf = foreign "LAPACKE_sgeqlf" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgeqlf = foreign "LAPACKE_dgeqlf" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgeqlf = foreign "LAPACKE_cgeqlf" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zgeqlf = foreign "LAPACKE_zgeqlf" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let sgeqp3 = foreign "LAPACKE_sgeqp3" ( int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> returning int )

  let dgeqp3 = foreign "LAPACKE_dgeqp3" ( int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> returning int )

  let cgeqp3 = foreign "LAPACKE_cgeqp3" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> returning int )

  let zgeqp3 = foreign "LAPACKE_zgeqp3" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> returning int )

  let sgeqpf = foreign "LAPACKE_sgeqpf" ( int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> returning int )

  let dgeqpf = foreign "LAPACKE_dgeqpf" ( int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> returning int )

  let cgeqpf = foreign "LAPACKE_cgeqpf" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> returning int )

  let zgeqpf = foreign "LAPACKE_zgeqpf" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> returning int )

  let sgeqr2 = foreign "LAPACKE_sgeqr2" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgeqr2 = foreign "LAPACKE_dgeqr2" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgeqr2 = foreign "LAPACKE_cgeqr2" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zgeqr2 = foreign "LAPACKE_zgeqr2" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let sgeqrf = foreign "LAPACKE_sgeqrf" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgeqrf = foreign "LAPACKE_dgeqrf" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgeqrf = foreign "LAPACKE_cgeqrf" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zgeqrf = foreign "LAPACKE_zgeqrf" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let sgeqrfp = foreign "LAPACKE_sgeqrfp" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgeqrfp = foreign "LAPACKE_dgeqrfp" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgeqrfp = foreign "LAPACKE_cgeqrfp" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zgeqrfp = foreign "LAPACKE_zgeqrfp" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let sgerfs = foreign "LAPACKE_sgerfs" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dgerfs = foreign "LAPACKE_dgerfs" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let cgerfs = foreign "LAPACKE_cgerfs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zgerfs = foreign "LAPACKE_zgerfs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let sgerqf = foreign "LAPACKE_sgerqf" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgerqf = foreign "LAPACKE_dgerqf" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgerqf = foreign "LAPACKE_cgerqf" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zgerqf = foreign "LAPACKE_zgerqf" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let sgesdd = foreign "LAPACKE_sgesdd" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgesdd = foreign "LAPACKE_dgesdd" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgesdd = foreign "LAPACKE_cgesdd" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgesdd = foreign "LAPACKE_zgesdd" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgesv = foreign "LAPACKE_sgesv" ( int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> returning int )

  let dgesv = foreign "LAPACKE_dgesv" ( int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> returning int )

  let cgesv = foreign "LAPACKE_cgesv" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zgesv = foreign "LAPACKE_zgesv" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let dsgesv = foreign "LAPACKE_dsgesv" ( int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let zcgesv = foreign "LAPACKE_zcgesv" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sgesvd = foreign "LAPACKE_sgesvd" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgesvd = foreign "LAPACKE_dgesvd" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgesvd = foreign "LAPACKE_cgesvd" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> returning int )

  let zgesvd = foreign "LAPACKE_zgesvd" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> returning int )

  let sgesvdx = foreign "LAPACKE_sgesvdx" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> float @-> float @-> int @-> int @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dgesvdx = foreign "LAPACKE_dgesvdx" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> double @-> double @-> int @-> int @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let cgesvdx = foreign "LAPACKE_cgesvdx" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> float @-> float @-> int @-> int @-> ptr int @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zgesvdx = foreign "LAPACKE_zgesvdx" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> double @-> double @-> int @-> int @-> ptr int @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sgesvj = foreign "LAPACKE_sgesvj" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgesvj = foreign "LAPACKE_dgesvj" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgesvj = foreign "LAPACKE_cgesvj" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> int @-> ptr complex32 @-> int @-> ptr float @-> returning int )

  let zgesvj = foreign "LAPACKE_zgesvj" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> int @-> ptr complex64 @-> int @-> ptr double @-> returning int )

  let sgesvx = foreign "LAPACKE_sgesvx" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr char @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgesvx = foreign "LAPACKE_dgesvx" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr char @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgesvx = foreign "LAPACKE_cgesvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr char @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zgesvx = foreign "LAPACKE_zgesvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr char @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sgetf2 = foreign "LAPACKE_sgetf2" ( int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dgetf2 = foreign "LAPACKE_dgetf2" ( int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let cgetf2 = foreign "LAPACKE_cgetf2" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zgetf2 = foreign "LAPACKE_zgetf2" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sgetrf = foreign "LAPACKE_sgetrf" ( int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dgetrf = foreign "LAPACKE_dgetrf" ( int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let cgetrf = foreign "LAPACKE_cgetrf" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zgetrf = foreign "LAPACKE_zgetrf" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sgetrf2 = foreign "LAPACKE_sgetrf2" ( int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dgetrf2 = foreign "LAPACKE_dgetrf2" ( int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let cgetrf2 = foreign "LAPACKE_cgetrf2" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zgetrf2 = foreign "LAPACKE_zgetrf2" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sgetri = foreign "LAPACKE_sgetri" ( int @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dgetri = foreign "LAPACKE_dgetri" ( int @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let cgetri = foreign "LAPACKE_cgetri" ( int @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zgetri = foreign "LAPACKE_zgetri" ( int @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sgetrs = foreign "LAPACKE_sgetrs" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> returning int )

  let dgetrs = foreign "LAPACKE_dgetrs" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> returning int )

  let cgetrs = foreign "LAPACKE_cgetrs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zgetrs = foreign "LAPACKE_zgetrs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let sggbak = foreign "LAPACKE_sggbak" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dggbak = foreign "LAPACKE_dggbak" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cggbak = foreign "LAPACKE_cggbak" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> ptr float @-> int @-> ptr complex32 @-> int @-> returning int )

  let zggbak = foreign "LAPACKE_zggbak" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> ptr double @-> int @-> ptr complex64 @-> int @-> returning int )

  let sggbal = foreign "LAPACKE_sggbal" ( int @-> char @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr int @-> ptr float @-> ptr float @-> returning int )

  let dggbal = foreign "LAPACKE_dggbal" ( int @-> char @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr int @-> ptr double @-> ptr double @-> returning int )

  let cggbal = foreign "LAPACKE_cggbal" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr int @-> ptr float @-> ptr float @-> returning int )

  let zggbal = foreign "LAPACKE_zggbal" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr int @-> ptr double @-> ptr double @-> returning int )

  let sgges = foreign "LAPACKE_sgges" ( int @-> char @-> char @-> char @-> ptr void @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgges = foreign "LAPACKE_dgges" ( int @-> char @-> char @-> char @-> ptr void @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgges = foreign "LAPACKE_cgges" ( int @-> char @-> char @-> char @-> ptr void @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgges = foreign "LAPACKE_zgges" ( int @-> char @-> char @-> char @-> ptr void @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgges3 = foreign "LAPACKE_sgges3" ( int @-> char @-> char @-> char @-> ptr void @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgges3 = foreign "LAPACKE_dgges3" ( int @-> char @-> char @-> char @-> ptr void @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgges3 = foreign "LAPACKE_cgges3" ( int @-> char @-> char @-> char @-> ptr void @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgges3 = foreign "LAPACKE_zgges3" ( int @-> char @-> char @-> char @-> ptr void @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sggesx = foreign "LAPACKE_sggesx" ( int @-> char @-> char @-> char @-> ptr void @-> char @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dggesx = foreign "LAPACKE_dggesx" ( int @-> char @-> char @-> char @-> ptr void @-> char @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let cggesx = foreign "LAPACKE_cggesx" ( int @-> char @-> char @-> char @-> ptr void @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zggesx = foreign "LAPACKE_zggesx" ( int @-> char @-> char @-> char @-> ptr void @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let sggev = foreign "LAPACKE_sggev" ( int @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dggev = foreign "LAPACKE_dggev" ( int @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cggev = foreign "LAPACKE_cggev" ( int @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zggev = foreign "LAPACKE_zggev" ( int @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sggev3 = foreign "LAPACKE_sggev3" ( int @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dggev3 = foreign "LAPACKE_dggev3" ( int @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cggev3 = foreign "LAPACKE_cggev3" ( int @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zggev3 = foreign "LAPACKE_zggev3" ( int @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sggevx = foreign "LAPACKE_sggevx" ( int @-> char @-> char @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dggevx = foreign "LAPACKE_dggevx" ( int @-> char @-> char @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cggevx = foreign "LAPACKE_cggevx" ( int @-> char @-> char @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zggevx = foreign "LAPACKE_zggevx" ( int @-> char @-> char @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sggglm = foreign "LAPACKE_sggglm" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dggglm = foreign "LAPACKE_dggglm" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cggglm = foreign "LAPACKE_cggglm" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> returning int )

  let zggglm = foreign "LAPACKE_zggglm" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> returning int )

  let sgghrd = foreign "LAPACKE_sgghrd" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgghrd = foreign "LAPACKE_dgghrd" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgghrd = foreign "LAPACKE_cgghrd" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgghrd = foreign "LAPACKE_zgghrd" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgghd3 = foreign "LAPACKE_sgghd3" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgghd3 = foreign "LAPACKE_dgghd3" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgghd3 = foreign "LAPACKE_cgghd3" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgghd3 = foreign "LAPACKE_zgghd3" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgglse = foreign "LAPACKE_sgglse" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgglse = foreign "LAPACKE_dgglse" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgglse = foreign "LAPACKE_cgglse" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> returning int )

  let zgglse = foreign "LAPACKE_zgglse" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> returning int )

  let sggqrf = foreign "LAPACKE_sggqrf" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> returning int )

  let dggqrf = foreign "LAPACKE_dggqrf" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> returning int )

  let cggqrf = foreign "LAPACKE_cggqrf" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zggqrf = foreign "LAPACKE_zggqrf" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let sggrqf = foreign "LAPACKE_sggrqf" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> returning int )

  let dggrqf = foreign "LAPACKE_dggrqf" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> returning int )

  let cggrqf = foreign "LAPACKE_cggrqf" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zggrqf = foreign "LAPACKE_zggrqf" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let sggsvd = foreign "LAPACKE_sggsvd" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr int @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dggsvd = foreign "LAPACKE_dggsvd" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr int @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let cggsvd = foreign "LAPACKE_cggsvd" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr int @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zggsvd = foreign "LAPACKE_zggsvd" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sggsvd3 = foreign "LAPACKE_sggsvd3" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr int @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dggsvd3 = foreign "LAPACKE_dggsvd3" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr int @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let cggsvd3 = foreign "LAPACKE_cggsvd3" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr int @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zggsvd3 = foreign "LAPACKE_zggsvd3" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sggsvp = foreign "LAPACKE_sggsvp" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> float @-> float @-> ptr int @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dggsvp = foreign "LAPACKE_dggsvp" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> double @-> double @-> ptr int @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cggsvp = foreign "LAPACKE_cggsvp" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> float @-> float @-> ptr int @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zggsvp = foreign "LAPACKE_zggsvp" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> double @-> double @-> ptr int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sggsvp3 = foreign "LAPACKE_sggsvp3" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> float @-> float @-> ptr int @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dggsvp3 = foreign "LAPACKE_dggsvp3" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> double @-> double @-> ptr int @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cggsvp3 = foreign "LAPACKE_cggsvp3" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> float @-> float @-> ptr int @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zggsvp3 = foreign "LAPACKE_zggsvp3" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> double @-> double @-> ptr int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgtcon = foreign "LAPACKE_sgtcon" ( char @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr int @-> float @-> ptr float @-> returning int )

  let dgtcon = foreign "LAPACKE_dgtcon" ( char @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr int @-> double @-> ptr double @-> returning int )

  let cgtcon = foreign "LAPACKE_cgtcon" ( char @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr int @-> float @-> ptr float @-> returning int )

  let zgtcon = foreign "LAPACKE_zgtcon" ( char @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr int @-> double @-> ptr double @-> returning int )

  let sgtrfs = foreign "LAPACKE_sgtrfs" ( int @-> char @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dgtrfs = foreign "LAPACKE_dgtrfs" ( int @-> char @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let cgtrfs = foreign "LAPACKE_cgtrfs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zgtrfs = foreign "LAPACKE_zgtrfs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let sgtsv = foreign "LAPACKE_sgtsv" ( int @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dgtsv = foreign "LAPACKE_dgtsv" ( int @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let cgtsv = foreign "LAPACKE_cgtsv" ( int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zgtsv = foreign "LAPACKE_zgtsv" ( int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let sgtsvx = foreign "LAPACKE_sgtsvx" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgtsvx = foreign "LAPACKE_dgtsvx" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgtsvx = foreign "LAPACKE_cgtsvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zgtsvx = foreign "LAPACKE_zgtsvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sgttrf = foreign "LAPACKE_sgttrf" ( int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr int @-> returning int )

  let dgttrf = foreign "LAPACKE_dgttrf" ( int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr int @-> returning int )

  let cgttrf = foreign "LAPACKE_cgttrf" ( int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr int @-> returning int )

  let zgttrf = foreign "LAPACKE_zgttrf" ( int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr int @-> returning int )

  let sgttrs = foreign "LAPACKE_sgttrs" ( int @-> char @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr int @-> ptr float @-> int @-> returning int )

  let dgttrs = foreign "LAPACKE_dgttrs" ( int @-> char @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr int @-> ptr double @-> int @-> returning int )

  let cgttrs = foreign "LAPACKE_cgttrs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zgttrs = foreign "LAPACKE_zgttrs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let chbev = foreign "LAPACKE_chbev" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zhbev = foreign "LAPACKE_zhbev" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let chbevd = foreign "LAPACKE_chbevd" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zhbevd = foreign "LAPACKE_zhbevd" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let chbevx = foreign "LAPACKE_chbevx" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zhbevx = foreign "LAPACKE_zhbevx" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let chbgst = foreign "LAPACKE_chbgst" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zhbgst = foreign "LAPACKE_zhbgst" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let chbgv = foreign "LAPACKE_chbgv" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zhbgv = foreign "LAPACKE_zhbgv" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let chbgvd = foreign "LAPACKE_chbgvd" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zhbgvd = foreign "LAPACKE_zhbgvd" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let chbgvx = foreign "LAPACKE_chbgvx" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zhbgvx = foreign "LAPACKE_zhbgvx" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let chbtrd = foreign "LAPACKE_chbtrd" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zhbtrd = foreign "LAPACKE_zhbtrd" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let checon = foreign "LAPACKE_checon" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> float @-> ptr float @-> returning int )

  let zhecon = foreign "LAPACKE_zhecon" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> double @-> ptr double @-> returning int )

  let cheequb = foreign "LAPACKE_cheequb" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zheequb = foreign "LAPACKE_zheequb" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cheev = foreign "LAPACKE_cheev" ( int @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr float @-> returning int )

  let zheev = foreign "LAPACKE_zheev" ( int @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr double @-> returning int )

  let cheevd = foreign "LAPACKE_cheevd" ( int @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr float @-> returning int )

  let zheevd = foreign "LAPACKE_zheevd" ( int @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr double @-> returning int )

  let cheevr = foreign "LAPACKE_cheevr" ( int @-> char @-> char @-> char @-> int @-> ptr complex32 @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zheevr = foreign "LAPACKE_zheevr" ( int @-> char @-> char @-> char @-> int @-> ptr complex64 @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let cheevx = foreign "LAPACKE_cheevx" ( int @-> char @-> char @-> char @-> int @-> ptr complex32 @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zheevx = foreign "LAPACKE_zheevx" ( int @-> char @-> char @-> char @-> int @-> ptr complex64 @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let chegst = foreign "LAPACKE_chegst" ( int @-> int @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zhegst = foreign "LAPACKE_zhegst" ( int @-> int @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let chegv = foreign "LAPACKE_chegv" ( int @-> int @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> returning int )

  let zhegv = foreign "LAPACKE_zhegv" ( int @-> int @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> returning int )

  let chegvd = foreign "LAPACKE_chegvd" ( int @-> int @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> returning int )

  let zhegvd = foreign "LAPACKE_zhegvd" ( int @-> int @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> returning int )

  let chegvx = foreign "LAPACKE_chegvx" ( int @-> int @-> char @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zhegvx = foreign "LAPACKE_zhegvx" ( int @-> int @-> char @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let cherfs = foreign "LAPACKE_cherfs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zherfs = foreign "LAPACKE_zherfs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let chesv = foreign "LAPACKE_chesv" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zhesv = foreign "LAPACKE_zhesv" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let chesvx = foreign "LAPACKE_chesvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zhesvx = foreign "LAPACKE_zhesvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let chetrd = foreign "LAPACKE_chetrd" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> returning int )

  let zhetrd = foreign "LAPACKE_zhetrd" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> returning int )

  let chetrf = foreign "LAPACKE_chetrf" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zhetrf = foreign "LAPACKE_zhetrf" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let chetri = foreign "LAPACKE_chetri" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zhetri = foreign "LAPACKE_zhetri" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let chetrs = foreign "LAPACKE_chetrs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zhetrs = foreign "LAPACKE_zhetrs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let chfrk = foreign "LAPACKE_chfrk" ( int @-> char @-> char @-> char @-> int @-> int @-> float @-> ptr complex32 @-> int @-> float @-> ptr complex32 @-> returning int )

  let zhfrk = foreign "LAPACKE_zhfrk" ( int @-> char @-> char @-> char @-> int @-> int @-> double @-> ptr complex64 @-> int @-> double @-> ptr complex64 @-> returning int )

  let shgeqz = foreign "LAPACKE_shgeqz" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dhgeqz = foreign "LAPACKE_dhgeqz" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let chgeqz = foreign "LAPACKE_chgeqz" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zhgeqz = foreign "LAPACKE_zhgeqz" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let chpcon = foreign "LAPACKE_chpcon" ( int @-> char @-> int @-> ptr complex32 @-> ptr int @-> float @-> ptr float @-> returning int )

  let zhpcon = foreign "LAPACKE_zhpcon" ( int @-> char @-> int @-> ptr complex64 @-> ptr int @-> double @-> ptr double @-> returning int )

  let chpev = foreign "LAPACKE_chpev" ( int @-> char @-> char @-> int @-> ptr complex32 @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zhpev = foreign "LAPACKE_zhpev" ( int @-> char @-> char @-> int @-> ptr complex64 @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let chpevd = foreign "LAPACKE_chpevd" ( int @-> char @-> char @-> int @-> ptr complex32 @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zhpevd = foreign "LAPACKE_zhpevd" ( int @-> char @-> char @-> int @-> ptr complex64 @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let chpevx = foreign "LAPACKE_chpevx" ( int @-> char @-> char @-> char @-> int @-> ptr complex32 @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zhpevx = foreign "LAPACKE_zhpevx" ( int @-> char @-> char @-> char @-> int @-> ptr complex64 @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let chpgst = foreign "LAPACKE_chpgst" ( int @-> int @-> char @-> int @-> ptr complex32 @-> ptr complex32 @-> returning int )

  let zhpgst = foreign "LAPACKE_zhpgst" ( int @-> int @-> char @-> int @-> ptr complex64 @-> ptr complex64 @-> returning int )

  let chpgv = foreign "LAPACKE_chpgv" ( int @-> int @-> char @-> char @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zhpgv = foreign "LAPACKE_zhpgv" ( int @-> int @-> char @-> char @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let chpgvd = foreign "LAPACKE_chpgvd" ( int @-> int @-> char @-> char @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zhpgvd = foreign "LAPACKE_zhpgvd" ( int @-> int @-> char @-> char @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let chpgvx = foreign "LAPACKE_chpgvx" ( int @-> int @-> char @-> char @-> char @-> int @-> ptr complex32 @-> ptr complex32 @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zhpgvx = foreign "LAPACKE_zhpgvx" ( int @-> int @-> char @-> char @-> char @-> int @-> ptr complex64 @-> ptr complex64 @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let chprfs = foreign "LAPACKE_chprfs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zhprfs = foreign "LAPACKE_zhprfs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let chpsv = foreign "LAPACKE_chpsv" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zhpsv = foreign "LAPACKE_zhpsv" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let chpsvx = foreign "LAPACKE_chpsvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zhpsvx = foreign "LAPACKE_zhpsvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let chptrd = foreign "LAPACKE_chptrd" ( int @-> char @-> int @-> ptr complex32 @-> ptr float @-> ptr float @-> ptr complex32 @-> returning int )

  let zhptrd = foreign "LAPACKE_zhptrd" ( int @-> char @-> int @-> ptr complex64 @-> ptr double @-> ptr double @-> ptr complex64 @-> returning int )

  let chptrf = foreign "LAPACKE_chptrf" ( int @-> char @-> int @-> ptr complex32 @-> ptr int @-> returning int )

  let zhptrf = foreign "LAPACKE_zhptrf" ( int @-> char @-> int @-> ptr complex64 @-> ptr int @-> returning int )

  let chptri = foreign "LAPACKE_chptri" ( int @-> char @-> int @-> ptr complex32 @-> ptr int @-> returning int )

  let zhptri = foreign "LAPACKE_zhptri" ( int @-> char @-> int @-> ptr complex64 @-> ptr int @-> returning int )

  let chptrs = foreign "LAPACKE_chptrs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zhptrs = foreign "LAPACKE_zhptrs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let shsein = foreign "LAPACKE_shsein" ( int @-> char @-> char @-> char @-> ptr int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> int @-> ptr int @-> ptr int @-> ptr int @-> returning int )

  let dhsein = foreign "LAPACKE_dhsein" ( int @-> char @-> char @-> char @-> ptr int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> int @-> ptr int @-> ptr int @-> ptr int @-> returning int )

  let chsein = foreign "LAPACKE_chsein" ( int @-> char @-> char @-> char @-> ptr int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> int @-> ptr int @-> ptr int @-> ptr int @-> returning int )

  let zhsein = foreign "LAPACKE_zhsein" ( int @-> char @-> char @-> char @-> ptr int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> int @-> ptr int @-> ptr int @-> ptr int @-> returning int )

  let shseqr = foreign "LAPACKE_shseqr" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dhseqr = foreign "LAPACKE_dhseqr" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let chseqr = foreign "LAPACKE_chseqr" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zhseqr = foreign "LAPACKE_zhseqr" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let clacgv = foreign "LAPACKE_clacgv" ( int @-> ptr complex32 @-> int @-> returning int )

  let zlacgv = foreign "LAPACKE_zlacgv" ( int @-> ptr complex64 @-> int @-> returning int )

  let slacn2 = foreign "LAPACKE_slacn2" ( int @-> ptr float @-> ptr float @-> ptr int @-> ptr float @-> ptr int @-> ptr int @-> returning int )

  let dlacn2 = foreign "LAPACKE_dlacn2" ( int @-> ptr double @-> ptr double @-> ptr int @-> ptr double @-> ptr int @-> ptr int @-> returning int )

  let clacn2 = foreign "LAPACKE_clacn2" ( int @-> ptr complex32 @-> ptr complex32 @-> ptr float @-> ptr int @-> ptr int @-> returning int )

  let zlacn2 = foreign "LAPACKE_zlacn2" ( int @-> ptr complex64 @-> ptr complex64 @-> ptr double @-> ptr int @-> ptr int @-> returning int )

  let slacpy = foreign "LAPACKE_slacpy" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dlacpy = foreign "LAPACKE_dlacpy" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let clacpy = foreign "LAPACKE_clacpy" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zlacpy = foreign "LAPACKE_zlacpy" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let clacp2 = foreign "LAPACKE_clacp2" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr complex32 @-> int @-> returning int )

  let zlacp2 = foreign "LAPACKE_zlacp2" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr complex64 @-> int @-> returning int )

  let zlag2c = foreign "LAPACKE_zlag2c" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex32 @-> int @-> returning int )

  let slag2d = foreign "LAPACKE_slag2d" ( int @-> int @-> int @-> ptr float @-> int @-> ptr double @-> int @-> returning int )

  let dlag2s = foreign "LAPACKE_dlag2s" ( int @-> int @-> int @-> ptr double @-> int @-> ptr float @-> int @-> returning int )

  let clag2z = foreign "LAPACKE_clag2z" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex64 @-> int @-> returning int )

  let slagge = foreign "LAPACKE_slagge" ( int @-> int @-> int @-> int @-> int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dlagge = foreign "LAPACKE_dlagge" ( int @-> int @-> int @-> int @-> int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let clagge = foreign "LAPACKE_clagge" ( int @-> int @-> int @-> int @-> int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zlagge = foreign "LAPACKE_zlagge" ( int @-> int @-> int @-> int @-> int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let slarfb = foreign "LAPACKE_slarfb" ( int @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dlarfb = foreign "LAPACKE_dlarfb" ( int @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let clarfb = foreign "LAPACKE_clarfb" ( int @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zlarfb = foreign "LAPACKE_zlarfb" ( int @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let slarfg = foreign "LAPACKE_slarfg" ( int @-> ptr float @-> ptr float @-> int @-> ptr float @-> returning int )

  let dlarfg = foreign "LAPACKE_dlarfg" ( int @-> ptr double @-> ptr double @-> int @-> ptr double @-> returning int )

  let clarfg = foreign "LAPACKE_clarfg" ( int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zlarfg = foreign "LAPACKE_zlarfg" ( int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let slarft = foreign "LAPACKE_slarft" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dlarft = foreign "LAPACKE_dlarft" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let clarft = foreign "LAPACKE_clarft" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zlarft = foreign "LAPACKE_zlarft" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let slarfx = foreign "LAPACKE_slarfx" ( int @-> char @-> int @-> int @-> ptr float @-> float @-> ptr float @-> int @-> ptr float @-> returning int )

  let dlarfx = foreign "LAPACKE_dlarfx" ( int @-> char @-> int @-> int @-> ptr double @-> double @-> ptr double @-> int @-> ptr double @-> returning int )

  let clarfx = foreign "LAPACKE_clarfx" ( int @-> char @-> int @-> int @-> ptr complex32 @-> complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zlarfx = foreign "LAPACKE_zlarfx" ( int @-> char @-> int @-> int @-> ptr complex64 @-> complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let slarnv = foreign "LAPACKE_slarnv" ( int @-> ptr int @-> int @-> ptr float @-> returning int )

  let dlarnv = foreign "LAPACKE_dlarnv" ( int @-> ptr int @-> int @-> ptr double @-> returning int )

  let clarnv = foreign "LAPACKE_clarnv" ( int @-> ptr int @-> int @-> ptr complex32 @-> returning int )

  let zlarnv = foreign "LAPACKE_zlarnv" ( int @-> ptr int @-> int @-> ptr complex64 @-> returning int )

  let slascl = foreign "LAPACKE_slascl" ( int @-> char @-> int @-> int @-> float @-> float @-> int @-> int @-> ptr float @-> int @-> returning int )

  let dlascl = foreign "LAPACKE_dlascl" ( int @-> char @-> int @-> int @-> double @-> double @-> int @-> int @-> ptr double @-> int @-> returning int )

  let clascl = foreign "LAPACKE_clascl" ( int @-> char @-> int @-> int @-> float @-> float @-> int @-> int @-> ptr complex32 @-> int @-> returning int )

  let zlascl = foreign "LAPACKE_zlascl" ( int @-> char @-> int @-> int @-> double @-> double @-> int @-> int @-> ptr complex64 @-> int @-> returning int )

  let slaset = foreign "LAPACKE_slaset" ( int @-> char @-> int @-> int @-> float @-> float @-> ptr float @-> int @-> returning int )

  let dlaset = foreign "LAPACKE_dlaset" ( int @-> char @-> int @-> int @-> double @-> double @-> ptr double @-> int @-> returning int )

  let claset = foreign "LAPACKE_claset" ( int @-> char @-> int @-> int @-> complex32 @-> complex32 @-> ptr complex32 @-> int @-> returning int )

  let zlaset = foreign "LAPACKE_zlaset" ( int @-> char @-> int @-> int @-> complex64 @-> complex64 @-> ptr complex64 @-> int @-> returning int )

  let slasrt = foreign "LAPACKE_slasrt" ( char @-> int @-> ptr float @-> returning int )

  let dlasrt = foreign "LAPACKE_dlasrt" ( char @-> int @-> ptr double @-> returning int )

  let slaswp = foreign "LAPACKE_slaswp" ( int @-> int @-> ptr float @-> int @-> int @-> int @-> ptr int @-> int @-> returning int )

  let dlaswp = foreign "LAPACKE_dlaswp" ( int @-> int @-> ptr double @-> int @-> int @-> int @-> ptr int @-> int @-> returning int )

  let claswp = foreign "LAPACKE_claswp" ( int @-> int @-> ptr complex32 @-> int @-> int @-> int @-> ptr int @-> int @-> returning int )

  let zlaswp = foreign "LAPACKE_zlaswp" ( int @-> int @-> ptr complex64 @-> int @-> int @-> int @-> ptr int @-> int @-> returning int )

  let slatms = foreign "LAPACKE_slatms" ( int @-> int @-> int @-> char @-> ptr int @-> char @-> ptr float @-> int @-> float @-> float @-> int @-> int @-> char @-> ptr float @-> int @-> returning int )

  let dlatms = foreign "LAPACKE_dlatms" ( int @-> int @-> int @-> char @-> ptr int @-> char @-> ptr double @-> int @-> double @-> double @-> int @-> int @-> char @-> ptr double @-> int @-> returning int )

  let clatms = foreign "LAPACKE_clatms" ( int @-> int @-> int @-> char @-> ptr int @-> char @-> ptr float @-> int @-> float @-> float @-> int @-> int @-> char @-> ptr complex32 @-> int @-> returning int )

  let zlatms = foreign "LAPACKE_zlatms" ( int @-> int @-> int @-> char @-> ptr int @-> char @-> ptr double @-> int @-> double @-> double @-> int @-> int @-> char @-> ptr complex64 @-> int @-> returning int )

  let slauum = foreign "LAPACKE_slauum" ( int @-> char @-> int @-> ptr float @-> int @-> returning int )

  let dlauum = foreign "LAPACKE_dlauum" ( int @-> char @-> int @-> ptr double @-> int @-> returning int )

  let clauum = foreign "LAPACKE_clauum" ( int @-> char @-> int @-> ptr complex32 @-> int @-> returning int )

  let zlauum = foreign "LAPACKE_zlauum" ( int @-> char @-> int @-> ptr complex64 @-> int @-> returning int )

  let sopgtr = foreign "LAPACKE_sopgtr" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dopgtr = foreign "LAPACKE_dopgtr" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let sopmtr = foreign "LAPACKE_sopmtr" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dopmtr = foreign "LAPACKE_dopmtr" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let sorgbr = foreign "LAPACKE_sorgbr" ( int @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dorgbr = foreign "LAPACKE_dorgbr" ( int @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let sorghr = foreign "LAPACKE_sorghr" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dorghr = foreign "LAPACKE_dorghr" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let sorglq = foreign "LAPACKE_sorglq" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dorglq = foreign "LAPACKE_dorglq" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let sorgql = foreign "LAPACKE_sorgql" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dorgql = foreign "LAPACKE_dorgql" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let sorgqr = foreign "LAPACKE_sorgqr" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dorgqr = foreign "LAPACKE_dorgqr" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let sorgrq = foreign "LAPACKE_sorgrq" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dorgrq = foreign "LAPACKE_dorgrq" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let sorgtr = foreign "LAPACKE_sorgtr" ( int @-> char @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dorgtr = foreign "LAPACKE_dorgtr" ( int @-> char @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let sormbr = foreign "LAPACKE_sormbr" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dormbr = foreign "LAPACKE_dormbr" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let sormhr = foreign "LAPACKE_sormhr" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dormhr = foreign "LAPACKE_dormhr" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let sormlq = foreign "LAPACKE_sormlq" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dormlq = foreign "LAPACKE_dormlq" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let sormql = foreign "LAPACKE_sormql" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dormql = foreign "LAPACKE_dormql" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let sormqr = foreign "LAPACKE_sormqr" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dormqr = foreign "LAPACKE_dormqr" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let sormrq = foreign "LAPACKE_sormrq" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dormrq = foreign "LAPACKE_dormrq" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let sormrz = foreign "LAPACKE_sormrz" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dormrz = foreign "LAPACKE_dormrz" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let sormtr = foreign "LAPACKE_sormtr" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dormtr = foreign "LAPACKE_dormtr" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let spbcon = foreign "LAPACKE_spbcon" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> float @-> ptr float @-> returning int )

  let dpbcon = foreign "LAPACKE_dpbcon" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> double @-> ptr double @-> returning int )

  let cpbcon = foreign "LAPACKE_cpbcon" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> float @-> ptr float @-> returning int )

  let zpbcon = foreign "LAPACKE_zpbcon" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> double @-> ptr double @-> returning int )

  let spbequ = foreign "LAPACKE_spbequ" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dpbequ = foreign "LAPACKE_dpbequ" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cpbequ = foreign "LAPACKE_cpbequ" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zpbequ = foreign "LAPACKE_zpbequ" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let spbrfs = foreign "LAPACKE_spbrfs" ( int @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dpbrfs = foreign "LAPACKE_dpbrfs" ( int @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let cpbrfs = foreign "LAPACKE_cpbrfs" ( int @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zpbrfs = foreign "LAPACKE_zpbrfs" ( int @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let spbstf = foreign "LAPACKE_spbstf" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> returning int )

  let dpbstf = foreign "LAPACKE_dpbstf" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> returning int )

  let cpbstf = foreign "LAPACKE_cpbstf" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> returning int )

  let zpbstf = foreign "LAPACKE_zpbstf" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> returning int )

  let spbsv = foreign "LAPACKE_spbsv" ( int @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dpbsv = foreign "LAPACKE_dpbsv" ( int @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cpbsv = foreign "LAPACKE_cpbsv" ( int @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zpbsv = foreign "LAPACKE_zpbsv" ( int @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let spbsvx = foreign "LAPACKE_spbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr char @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dpbsvx = foreign "LAPACKE_dpbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr char @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cpbsvx = foreign "LAPACKE_cpbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr char @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zpbsvx = foreign "LAPACKE_zpbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr char @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let spbtrf = foreign "LAPACKE_spbtrf" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> returning int )

  let dpbtrf = foreign "LAPACKE_dpbtrf" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> returning int )

  let cpbtrf = foreign "LAPACKE_cpbtrf" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> returning int )

  let zpbtrf = foreign "LAPACKE_zpbtrf" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> returning int )

  let spbtrs = foreign "LAPACKE_spbtrs" ( int @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dpbtrs = foreign "LAPACKE_dpbtrs" ( int @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cpbtrs = foreign "LAPACKE_cpbtrs" ( int @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zpbtrs = foreign "LAPACKE_zpbtrs" ( int @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let spftrf = foreign "LAPACKE_spftrf" ( int @-> char @-> char @-> int @-> ptr float @-> returning int )

  let dpftrf = foreign "LAPACKE_dpftrf" ( int @-> char @-> char @-> int @-> ptr double @-> returning int )

  let cpftrf = foreign "LAPACKE_cpftrf" ( int @-> char @-> char @-> int @-> ptr complex32 @-> returning int )

  let zpftrf = foreign "LAPACKE_zpftrf" ( int @-> char @-> char @-> int @-> ptr complex64 @-> returning int )

  let spftri = foreign "LAPACKE_spftri" ( int @-> char @-> char @-> int @-> ptr float @-> returning int )

  let dpftri = foreign "LAPACKE_dpftri" ( int @-> char @-> char @-> int @-> ptr double @-> returning int )

  let cpftri = foreign "LAPACKE_cpftri" ( int @-> char @-> char @-> int @-> ptr complex32 @-> returning int )

  let zpftri = foreign "LAPACKE_zpftri" ( int @-> char @-> char @-> int @-> ptr complex64 @-> returning int )

  let spftrs = foreign "LAPACKE_spftrs" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dpftrs = foreign "LAPACKE_dpftrs" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let cpftrs = foreign "LAPACKE_cpftrs" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zpftrs = foreign "LAPACKE_zpftrs" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let spocon = foreign "LAPACKE_spocon" ( int @-> char @-> int @-> ptr float @-> int @-> float @-> ptr float @-> returning int )

  let dpocon = foreign "LAPACKE_dpocon" ( int @-> char @-> int @-> ptr double @-> int @-> double @-> ptr double @-> returning int )

  let cpocon = foreign "LAPACKE_cpocon" ( int @-> char @-> int @-> ptr complex32 @-> int @-> float @-> ptr float @-> returning int )

  let zpocon = foreign "LAPACKE_zpocon" ( int @-> char @-> int @-> ptr complex64 @-> int @-> double @-> ptr double @-> returning int )

  let spoequ = foreign "LAPACKE_spoequ" ( int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dpoequ = foreign "LAPACKE_dpoequ" ( int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cpoequ = foreign "LAPACKE_cpoequ" ( int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zpoequ = foreign "LAPACKE_zpoequ" ( int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let spoequb = foreign "LAPACKE_spoequb" ( int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dpoequb = foreign "LAPACKE_dpoequb" ( int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cpoequb = foreign "LAPACKE_cpoequb" ( int @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zpoequb = foreign "LAPACKE_zpoequb" ( int @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sporfs = foreign "LAPACKE_sporfs" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dporfs = foreign "LAPACKE_dporfs" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let cporfs = foreign "LAPACKE_cporfs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zporfs = foreign "LAPACKE_zporfs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let sposv = foreign "LAPACKE_sposv" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dposv = foreign "LAPACKE_dposv" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cposv = foreign "LAPACKE_cposv" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zposv = foreign "LAPACKE_zposv" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let dsposv = foreign "LAPACKE_dsposv" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let zcposv = foreign "LAPACKE_zcposv" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sposvx = foreign "LAPACKE_sposvx" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr char @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dposvx = foreign "LAPACKE_dposvx" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr char @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cposvx = foreign "LAPACKE_cposvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr char @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zposvx = foreign "LAPACKE_zposvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr char @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let spotrf2 = foreign "LAPACKE_spotrf2" ( int @-> char @-> int @-> ptr float @-> int @-> returning int )

  let dpotrf2 = foreign "LAPACKE_dpotrf2" ( int @-> char @-> int @-> ptr double @-> int @-> returning int )

  let cpotrf2 = foreign "LAPACKE_cpotrf2" ( int @-> char @-> int @-> ptr complex32 @-> int @-> returning int )

  let zpotrf2 = foreign "LAPACKE_zpotrf2" ( int @-> char @-> int @-> ptr complex64 @-> int @-> returning int )

  let spotrf = foreign "LAPACKE_spotrf" ( int @-> char @-> int @-> ptr float @-> int @-> returning int )

  let dpotrf = foreign "LAPACKE_dpotrf" ( int @-> char @-> int @-> ptr double @-> int @-> returning int )

  let cpotrf = foreign "LAPACKE_cpotrf" ( int @-> char @-> int @-> ptr complex32 @-> int @-> returning int )

  let zpotrf = foreign "LAPACKE_zpotrf" ( int @-> char @-> int @-> ptr complex64 @-> int @-> returning int )

  let spotri = foreign "LAPACKE_spotri" ( int @-> char @-> int @-> ptr float @-> int @-> returning int )

  let dpotri = foreign "LAPACKE_dpotri" ( int @-> char @-> int @-> ptr double @-> int @-> returning int )

  let cpotri = foreign "LAPACKE_cpotri" ( int @-> char @-> int @-> ptr complex32 @-> int @-> returning int )

  let zpotri = foreign "LAPACKE_zpotri" ( int @-> char @-> int @-> ptr complex64 @-> int @-> returning int )

  let spotrs = foreign "LAPACKE_spotrs" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dpotrs = foreign "LAPACKE_dpotrs" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cpotrs = foreign "LAPACKE_cpotrs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zpotrs = foreign "LAPACKE_zpotrs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sppcon = foreign "LAPACKE_sppcon" ( int @-> char @-> int @-> ptr float @-> float @-> ptr float @-> returning int )

  let dppcon = foreign "LAPACKE_dppcon" ( int @-> char @-> int @-> ptr double @-> double @-> ptr double @-> returning int )

  let cppcon = foreign "LAPACKE_cppcon" ( int @-> char @-> int @-> ptr complex32 @-> float @-> ptr float @-> returning int )

  let zppcon = foreign "LAPACKE_zppcon" ( int @-> char @-> int @-> ptr complex64 @-> double @-> ptr double @-> returning int )

  let sppequ = foreign "LAPACKE_sppequ" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dppequ = foreign "LAPACKE_dppequ" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cppequ = foreign "LAPACKE_cppequ" ( int @-> char @-> int @-> ptr complex32 @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zppequ = foreign "LAPACKE_zppequ" ( int @-> char @-> int @-> ptr complex64 @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let spprfs = foreign "LAPACKE_spprfs" ( int @-> char @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dpprfs = foreign "LAPACKE_dpprfs" ( int @-> char @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let cpprfs = foreign "LAPACKE_cpprfs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zpprfs = foreign "LAPACKE_zpprfs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let sppsv = foreign "LAPACKE_sppsv" ( int @-> char @-> int @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dppsv = foreign "LAPACKE_dppsv" ( int @-> char @-> int @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let cppsv = foreign "LAPACKE_cppsv" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zppsv = foreign "LAPACKE_zppsv" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let sppsvx = foreign "LAPACKE_sppsvx" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> ptr float @-> ptr char @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dppsvx = foreign "LAPACKE_dppsvx" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> ptr double @-> ptr char @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cppsvx = foreign "LAPACKE_cppsvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr char @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zppsvx = foreign "LAPACKE_zppsvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr char @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let spptrf = foreign "LAPACKE_spptrf" ( int @-> char @-> int @-> ptr float @-> returning int )

  let dpptrf = foreign "LAPACKE_dpptrf" ( int @-> char @-> int @-> ptr double @-> returning int )

  let cpptrf = foreign "LAPACKE_cpptrf" ( int @-> char @-> int @-> ptr complex32 @-> returning int )

  let zpptrf = foreign "LAPACKE_zpptrf" ( int @-> char @-> int @-> ptr complex64 @-> returning int )

  let spptri = foreign "LAPACKE_spptri" ( int @-> char @-> int @-> ptr float @-> returning int )

  let dpptri = foreign "LAPACKE_dpptri" ( int @-> char @-> int @-> ptr double @-> returning int )

  let cpptri = foreign "LAPACKE_cpptri" ( int @-> char @-> int @-> ptr complex32 @-> returning int )

  let zpptri = foreign "LAPACKE_zpptri" ( int @-> char @-> int @-> ptr complex64 @-> returning int )

  let spptrs = foreign "LAPACKE_spptrs" ( int @-> char @-> int @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dpptrs = foreign "LAPACKE_dpptrs" ( int @-> char @-> int @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let cpptrs = foreign "LAPACKE_cpptrs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zpptrs = foreign "LAPACKE_zpptrs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let spstrf = foreign "LAPACKE_spstrf" ( int @-> char @-> int @-> ptr float @-> int @-> ptr int @-> ptr int @-> float @-> returning int )

  let dpstrf = foreign "LAPACKE_dpstrf" ( int @-> char @-> int @-> ptr double @-> int @-> ptr int @-> ptr int @-> double @-> returning int )

  let cpstrf = foreign "LAPACKE_cpstrf" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr int @-> float @-> returning int )

  let zpstrf = foreign "LAPACKE_zpstrf" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr int @-> double @-> returning int )

  let sptcon = foreign "LAPACKE_sptcon" ( int @-> ptr float @-> ptr float @-> float @-> ptr float @-> returning int )

  let dptcon = foreign "LAPACKE_dptcon" ( int @-> ptr double @-> ptr double @-> double @-> ptr double @-> returning int )

  let cptcon = foreign "LAPACKE_cptcon" ( int @-> ptr float @-> ptr complex32 @-> float @-> ptr float @-> returning int )

  let zptcon = foreign "LAPACKE_zptcon" ( int @-> ptr double @-> ptr complex64 @-> double @-> ptr double @-> returning int )

  let spteqr = foreign "LAPACKE_spteqr" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dpteqr = foreign "LAPACKE_dpteqr" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let cpteqr = foreign "LAPACKE_cpteqr" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zpteqr = foreign "LAPACKE_zpteqr" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let sptrfs = foreign "LAPACKE_sptrfs" ( int @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dptrfs = foreign "LAPACKE_dptrfs" ( int @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let cptrfs = foreign "LAPACKE_cptrfs" ( int @-> char @-> int @-> int @-> ptr float @-> ptr complex32 @-> ptr float @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zptrfs = foreign "LAPACKE_zptrfs" ( int @-> char @-> int @-> int @-> ptr double @-> ptr complex64 @-> ptr double @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let sptsv = foreign "LAPACKE_sptsv" ( int @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dptsv = foreign "LAPACKE_dptsv" ( int @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let cptsv = foreign "LAPACKE_cptsv" ( int @-> int @-> int @-> ptr float @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zptsv = foreign "LAPACKE_zptsv" ( int @-> int @-> int @-> ptr double @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let sptsvx = foreign "LAPACKE_sptsvx" ( int @-> char @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dptsvx = foreign "LAPACKE_dptsvx" ( int @-> char @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cptsvx = foreign "LAPACKE_cptsvx" ( int @-> char @-> int @-> int @-> ptr float @-> ptr complex32 @-> ptr float @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zptsvx = foreign "LAPACKE_zptsvx" ( int @-> char @-> int @-> int @-> ptr double @-> ptr complex64 @-> ptr double @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let spttrf = foreign "LAPACKE_spttrf" ( int @-> ptr float @-> ptr float @-> returning int )

  let dpttrf = foreign "LAPACKE_dpttrf" ( int @-> ptr double @-> ptr double @-> returning int )

  let cpttrf = foreign "LAPACKE_cpttrf" ( int @-> ptr float @-> ptr complex32 @-> returning int )

  let zpttrf = foreign "LAPACKE_zpttrf" ( int @-> ptr double @-> ptr complex64 @-> returning int )

  let spttrs = foreign "LAPACKE_spttrs" ( int @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dpttrs = foreign "LAPACKE_dpttrs" ( int @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let cpttrs = foreign "LAPACKE_cpttrs" ( int @-> char @-> int @-> int @-> ptr float @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zpttrs = foreign "LAPACKE_zpttrs" ( int @-> char @-> int @-> int @-> ptr double @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let ssbev = foreign "LAPACKE_ssbev" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dsbev = foreign "LAPACKE_dsbev" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let ssbevd = foreign "LAPACKE_ssbevd" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dsbevd = foreign "LAPACKE_dsbevd" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let ssbevx = foreign "LAPACKE_ssbevx" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dsbevx = foreign "LAPACKE_dsbevx" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let ssbgst = foreign "LAPACKE_ssbgst" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dsbgst = foreign "LAPACKE_dsbgst" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let ssbgv = foreign "LAPACKE_ssbgv" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dsbgv = foreign "LAPACKE_dsbgv" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let ssbgvd = foreign "LAPACKE_ssbgvd" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dsbgvd = foreign "LAPACKE_dsbgvd" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let ssbgvx = foreign "LAPACKE_ssbgvx" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dsbgvx = foreign "LAPACKE_dsbgvx" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let ssbtrd = foreign "LAPACKE_ssbtrd" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dsbtrd = foreign "LAPACKE_dsbtrd" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let ssfrk = foreign "LAPACKE_ssfrk" ( int @-> char @-> char @-> char @-> int @-> int @-> float @-> ptr float @-> int @-> float @-> ptr float @-> returning int )

  let dsfrk = foreign "LAPACKE_dsfrk" ( int @-> char @-> char @-> char @-> int @-> int @-> double @-> ptr double @-> int @-> double @-> ptr double @-> returning int )

  let sspcon = foreign "LAPACKE_sspcon" ( int @-> char @-> int @-> ptr float @-> ptr int @-> float @-> ptr float @-> returning int )

  let dspcon = foreign "LAPACKE_dspcon" ( int @-> char @-> int @-> ptr double @-> ptr int @-> double @-> ptr double @-> returning int )

  let cspcon = foreign "LAPACKE_cspcon" ( int @-> char @-> int @-> ptr complex32 @-> ptr int @-> float @-> ptr float @-> returning int )

  let zspcon = foreign "LAPACKE_zspcon" ( int @-> char @-> int @-> ptr complex64 @-> ptr int @-> double @-> ptr double @-> returning int )

  let sspev = foreign "LAPACKE_sspev" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dspev = foreign "LAPACKE_dspev" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let sspevd = foreign "LAPACKE_sspevd" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dspevd = foreign "LAPACKE_dspevd" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let sspevx = foreign "LAPACKE_sspevx" ( int @-> char @-> char @-> char @-> int @-> ptr float @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dspevx = foreign "LAPACKE_dspevx" ( int @-> char @-> char @-> char @-> int @-> ptr double @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let sspgst = foreign "LAPACKE_sspgst" ( int @-> int @-> char @-> int @-> ptr float @-> ptr float @-> returning int )

  let dspgst = foreign "LAPACKE_dspgst" ( int @-> int @-> char @-> int @-> ptr double @-> ptr double @-> returning int )

  let sspgv = foreign "LAPACKE_sspgv" ( int @-> int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dspgv = foreign "LAPACKE_dspgv" ( int @-> int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let sspgvd = foreign "LAPACKE_sspgvd" ( int @-> int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dspgvd = foreign "LAPACKE_dspgvd" ( int @-> int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let sspgvx = foreign "LAPACKE_sspgvx" ( int @-> int @-> char @-> char @-> char @-> int @-> ptr float @-> ptr float @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dspgvx = foreign "LAPACKE_dspgvx" ( int @-> int @-> char @-> char @-> char @-> int @-> ptr double @-> ptr double @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let ssprfs = foreign "LAPACKE_ssprfs" ( int @-> char @-> int @-> int @-> ptr float @-> ptr float @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dsprfs = foreign "LAPACKE_dsprfs" ( int @-> char @-> int @-> int @-> ptr double @-> ptr double @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let csprfs = foreign "LAPACKE_csprfs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zsprfs = foreign "LAPACKE_zsprfs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let sspsv = foreign "LAPACKE_sspsv" ( int @-> char @-> int @-> int @-> ptr float @-> ptr int @-> ptr float @-> int @-> returning int )

  let dspsv = foreign "LAPACKE_dspsv" ( int @-> char @-> int @-> int @-> ptr double @-> ptr int @-> ptr double @-> int @-> returning int )

  let cspsv = foreign "LAPACKE_cspsv" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zspsv = foreign "LAPACKE_zspsv" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let sspsvx = foreign "LAPACKE_sspsvx" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> ptr float @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dspsvx = foreign "LAPACKE_dspsvx" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> ptr double @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cspsvx = foreign "LAPACKE_cspsvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zspsvx = foreign "LAPACKE_zspsvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let ssptrd = foreign "LAPACKE_ssptrd" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dsptrd = foreign "LAPACKE_dsptrd" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let ssptrf = foreign "LAPACKE_ssptrf" ( int @-> char @-> int @-> ptr float @-> ptr int @-> returning int )

  let dsptrf = foreign "LAPACKE_dsptrf" ( int @-> char @-> int @-> ptr double @-> ptr int @-> returning int )

  let csptrf = foreign "LAPACKE_csptrf" ( int @-> char @-> int @-> ptr complex32 @-> ptr int @-> returning int )

  let zsptrf = foreign "LAPACKE_zsptrf" ( int @-> char @-> int @-> ptr complex64 @-> ptr int @-> returning int )

  let ssptri = foreign "LAPACKE_ssptri" ( int @-> char @-> int @-> ptr float @-> ptr int @-> returning int )

  let dsptri = foreign "LAPACKE_dsptri" ( int @-> char @-> int @-> ptr double @-> ptr int @-> returning int )

  let csptri = foreign "LAPACKE_csptri" ( int @-> char @-> int @-> ptr complex32 @-> ptr int @-> returning int )

  let zsptri = foreign "LAPACKE_zsptri" ( int @-> char @-> int @-> ptr complex64 @-> ptr int @-> returning int )

  let ssptrs = foreign "LAPACKE_ssptrs" ( int @-> char @-> int @-> int @-> ptr float @-> ptr int @-> ptr float @-> int @-> returning int )

  let dsptrs = foreign "LAPACKE_dsptrs" ( int @-> char @-> int @-> int @-> ptr double @-> ptr int @-> ptr double @-> int @-> returning int )

  let csptrs = foreign "LAPACKE_csptrs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zsptrs = foreign "LAPACKE_zsptrs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let sstebz = foreign "LAPACKE_sstebz" ( char @-> char @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr float @-> ptr float @-> ptr int @-> ptr int @-> ptr float @-> ptr int @-> ptr int @-> returning int )

  let dstebz = foreign "LAPACKE_dstebz" ( char @-> char @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr double @-> ptr double @-> ptr int @-> ptr int @-> ptr double @-> ptr int @-> ptr int @-> returning int )

  let sstedc = foreign "LAPACKE_sstedc" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dstedc = foreign "LAPACKE_dstedc" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let cstedc = foreign "LAPACKE_cstedc" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zstedc = foreign "LAPACKE_zstedc" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let sstegr = foreign "LAPACKE_sstegr" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dstegr = foreign "LAPACKE_dstegr" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let cstegr = foreign "LAPACKE_cstegr" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zstegr = foreign "LAPACKE_zstegr" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sstein = foreign "LAPACKE_sstein" ( int @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> ptr int @-> ptr int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dstein = foreign "LAPACKE_dstein" ( int @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> ptr int @-> ptr int @-> ptr double @-> int @-> ptr int @-> returning int )

  let cstein = foreign "LAPACKE_cstein" ( int @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> ptr int @-> ptr int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zstein = foreign "LAPACKE_zstein" ( int @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> ptr int @-> ptr int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let sstemr = foreign "LAPACKE_sstemr" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> float @-> float @-> int @-> int @-> ptr int @-> ptr float @-> ptr float @-> int @-> int @-> ptr int @-> ptr int @-> returning int )

  let dstemr = foreign "LAPACKE_dstemr" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> double @-> double @-> int @-> int @-> ptr int @-> ptr double @-> ptr double @-> int @-> int @-> ptr int @-> ptr int @-> returning int )

  let cstemr = foreign "LAPACKE_cstemr" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> float @-> float @-> int @-> int @-> ptr int @-> ptr float @-> ptr complex32 @-> int @-> int @-> ptr int @-> ptr int @-> returning int )

  let zstemr = foreign "LAPACKE_zstemr" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> double @-> double @-> int @-> int @-> ptr int @-> ptr double @-> ptr complex64 @-> int @-> int @-> ptr int @-> ptr int @-> returning int )

  let ssteqr = foreign "LAPACKE_ssteqr" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dsteqr = foreign "LAPACKE_dsteqr" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let csteqr = foreign "LAPACKE_csteqr" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> returning int )

  let zsteqr = foreign "LAPACKE_zsteqr" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> returning int )

  let ssterf = foreign "LAPACKE_ssterf" ( int @-> ptr float @-> ptr float @-> returning int )

  let dsterf = foreign "LAPACKE_dsterf" ( int @-> ptr double @-> ptr double @-> returning int )

  let sstev = foreign "LAPACKE_sstev" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dstev = foreign "LAPACKE_dstev" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let sstevd = foreign "LAPACKE_sstevd" ( int @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dstevd = foreign "LAPACKE_dstevd" ( int @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> returning int )

  let sstevr = foreign "LAPACKE_sstevr" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dstevr = foreign "LAPACKE_dstevr" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let sstevx = foreign "LAPACKE_sstevx" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dstevx = foreign "LAPACKE_dstevx" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let ssycon = foreign "LAPACKE_ssycon" ( int @-> char @-> int @-> ptr float @-> int @-> ptr int @-> float @-> ptr float @-> returning int )

  let dsycon = foreign "LAPACKE_dsycon" ( int @-> char @-> int @-> ptr double @-> int @-> ptr int @-> double @-> ptr double @-> returning int )

  let csycon = foreign "LAPACKE_csycon" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> float @-> ptr float @-> returning int )

  let zsycon = foreign "LAPACKE_zsycon" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> double @-> ptr double @-> returning int )

  let ssyequb = foreign "LAPACKE_ssyequb" ( int @-> char @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dsyequb = foreign "LAPACKE_dsyequb" ( int @-> char @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let csyequb = foreign "LAPACKE_csyequb" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zsyequb = foreign "LAPACKE_zsyequb" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let ssyev = foreign "LAPACKE_ssyev" ( int @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dsyev = foreign "LAPACKE_dsyev" ( int @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let ssyevd = foreign "LAPACKE_ssyevd" ( int @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dsyevd = foreign "LAPACKE_dsyevd" ( int @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let ssyevr = foreign "LAPACKE_ssyevr" ( int @-> char @-> char @-> char @-> int @-> ptr float @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dsyevr = foreign "LAPACKE_dsyevr" ( int @-> char @-> char @-> char @-> int @-> ptr double @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let ssyevx = foreign "LAPACKE_ssyevx" ( int @-> char @-> char @-> char @-> int @-> ptr float @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dsyevx = foreign "LAPACKE_dsyevx" ( int @-> char @-> char @-> char @-> int @-> ptr double @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let ssygst = foreign "LAPACKE_ssygst" ( int @-> int @-> char @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dsygst = foreign "LAPACKE_dsygst" ( int @-> int @-> char @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let ssygv = foreign "LAPACKE_ssygv" ( int @-> int @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dsygv = foreign "LAPACKE_dsygv" ( int @-> int @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let ssygvd = foreign "LAPACKE_ssygvd" ( int @-> int @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dsygvd = foreign "LAPACKE_dsygvd" ( int @-> int @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let ssygvx = foreign "LAPACKE_ssygvx" ( int @-> int @-> char @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> int @-> float @-> float @-> int @-> int @-> float @-> ptr int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dsygvx = foreign "LAPACKE_dsygvx" ( int @-> int @-> char @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> int @-> double @-> double @-> int @-> int @-> double @-> ptr int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let ssyrfs = foreign "LAPACKE_ssyrfs" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dsyrfs = foreign "LAPACKE_dsyrfs" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let csyrfs = foreign "LAPACKE_csyrfs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let zsyrfs = foreign "LAPACKE_zsyrfs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let ssysv = foreign "LAPACKE_ssysv" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> returning int )

  let dsysv = foreign "LAPACKE_dsysv" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> returning int )

  let csysv = foreign "LAPACKE_csysv" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zsysv = foreign "LAPACKE_zsysv" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let ssysvx = foreign "LAPACKE_ssysvx" ( int @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dsysvx = foreign "LAPACKE_dsysvx" ( int @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let csysvx = foreign "LAPACKE_csysvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zsysvx = foreign "LAPACKE_zsysvx" ( int @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let ssytrd = foreign "LAPACKE_ssytrd" ( int @-> char @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dsytrd = foreign "LAPACKE_dsytrd" ( int @-> char @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let ssytrf = foreign "LAPACKE_ssytrf" ( int @-> char @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dsytrf = foreign "LAPACKE_dsytrf" ( int @-> char @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let csytrf = foreign "LAPACKE_csytrf" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zsytrf = foreign "LAPACKE_zsytrf" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let ssytri = foreign "LAPACKE_ssytri" ( int @-> char @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dsytri = foreign "LAPACKE_dsytri" ( int @-> char @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let csytri = foreign "LAPACKE_csytri" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zsytri = foreign "LAPACKE_zsytri" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let ssytrs = foreign "LAPACKE_ssytrs" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> returning int )

  let dsytrs = foreign "LAPACKE_dsytrs" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> returning int )

  let csytrs = foreign "LAPACKE_csytrs" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zsytrs = foreign "LAPACKE_zsytrs" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let stbcon = foreign "LAPACKE_stbcon" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dtbcon = foreign "LAPACKE_dtbcon" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let ctbcon = foreign "LAPACKE_ctbcon" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr float @-> returning int )

  let ztbcon = foreign "LAPACKE_ztbcon" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr double @-> returning int )

  let stbrfs = foreign "LAPACKE_stbrfs" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dtbrfs = foreign "LAPACKE_dtbrfs" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let ctbrfs = foreign "LAPACKE_ctbrfs" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let ztbrfs = foreign "LAPACKE_ztbrfs" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let stbtrs = foreign "LAPACKE_stbtrs" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dtbtrs = foreign "LAPACKE_dtbtrs" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let ctbtrs = foreign "LAPACKE_ctbtrs" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let ztbtrs = foreign "LAPACKE_ztbtrs" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let stfsm = foreign "LAPACKE_stfsm" ( int @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> float @-> ptr float @-> ptr float @-> int @-> returning int )

  let dtfsm = foreign "LAPACKE_dtfsm" ( int @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> double @-> ptr double @-> ptr double @-> int @-> returning int )

  let ctfsm = foreign "LAPACKE_ctfsm" ( int @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let ztfsm = foreign "LAPACKE_ztfsm" ( int @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let stftri = foreign "LAPACKE_stftri" ( int @-> char @-> char @-> char @-> int @-> ptr float @-> returning int )

  let dtftri = foreign "LAPACKE_dtftri" ( int @-> char @-> char @-> char @-> int @-> ptr double @-> returning int )

  let ctftri = foreign "LAPACKE_ctftri" ( int @-> char @-> char @-> char @-> int @-> ptr complex32 @-> returning int )

  let ztftri = foreign "LAPACKE_ztftri" ( int @-> char @-> char @-> char @-> int @-> ptr complex64 @-> returning int )

  let stfttp = foreign "LAPACKE_stfttp" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> returning int )

  let dtfttp = foreign "LAPACKE_dtfttp" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> returning int )

  let ctfttp = foreign "LAPACKE_ctfttp" ( int @-> char @-> char @-> int @-> ptr complex32 @-> ptr complex32 @-> returning int )

  let ztfttp = foreign "LAPACKE_ztfttp" ( int @-> char @-> char @-> int @-> ptr complex64 @-> ptr complex64 @-> returning int )

  let stfttr = foreign "LAPACKE_stfttr" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dtfttr = foreign "LAPACKE_dtfttr" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let ctfttr = foreign "LAPACKE_ctfttr" ( int @-> char @-> char @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let ztfttr = foreign "LAPACKE_ztfttr" ( int @-> char @-> char @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let stgevc = foreign "LAPACKE_stgevc" ( int @-> char @-> char @-> ptr int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> int @-> ptr int @-> returning int )

  let dtgevc = foreign "LAPACKE_dtgevc" ( int @-> char @-> char @-> ptr int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> int @-> ptr int @-> returning int )

  let ctgevc = foreign "LAPACKE_ctgevc" ( int @-> char @-> char @-> ptr int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> int @-> ptr int @-> returning int )

  let ztgevc = foreign "LAPACKE_ztgevc" ( int @-> char @-> char @-> ptr int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> int @-> ptr int @-> returning int )

  let stgexc = foreign "LAPACKE_stgexc" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr int @-> returning int )

  let dtgexc = foreign "LAPACKE_dtgexc" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr int @-> returning int )

  let ctgexc = foreign "LAPACKE_ctgexc" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> int @-> int @-> returning int )

  let ztgexc = foreign "LAPACKE_ztgexc" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> int @-> int @-> returning int )

  let stgsen = foreign "LAPACKE_stgsen" ( int @-> int @-> int @-> int @-> ptr int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dtgsen = foreign "LAPACKE_dtgsen" ( int @-> int @-> int @-> int @-> ptr int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let ctgsen = foreign "LAPACKE_ctgsen" ( int @-> int @-> int @-> int @-> ptr int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let ztgsen = foreign "LAPACKE_ztgsen" ( int @-> int @-> int @-> int @-> ptr int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let stgsja = foreign "LAPACKE_stgsja" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> float @-> float @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dtgsja = foreign "LAPACKE_dtgsja" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> double @-> double @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let ctgsja = foreign "LAPACKE_ctgsja" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> float @-> float @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let ztgsja = foreign "LAPACKE_ztgsja" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> double @-> double @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let stgsna = foreign "LAPACKE_stgsna" ( int @-> char @-> char @-> ptr int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dtgsna = foreign "LAPACKE_dtgsna" ( int @-> char @-> char @-> ptr int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let ctgsna = foreign "LAPACKE_ctgsna" ( int @-> char @-> char @-> ptr int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let ztgsna = foreign "LAPACKE_ztgsna" ( int @-> char @-> char @-> ptr int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let stgsyl = foreign "LAPACKE_stgsyl" ( int @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dtgsyl = foreign "LAPACKE_dtgsyl" ( int @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let ctgsyl = foreign "LAPACKE_ctgsyl" ( int @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let ztgsyl = foreign "LAPACKE_ztgsyl" ( int @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let stpcon = foreign "LAPACKE_stpcon" ( int @-> char @-> char @-> char @-> int @-> ptr float @-> ptr float @-> returning int )

  let dtpcon = foreign "LAPACKE_dtpcon" ( int @-> char @-> char @-> char @-> int @-> ptr double @-> ptr double @-> returning int )

  let ctpcon = foreign "LAPACKE_ctpcon" ( int @-> char @-> char @-> char @-> int @-> ptr complex32 @-> ptr float @-> returning int )

  let ztpcon = foreign "LAPACKE_ztpcon" ( int @-> char @-> char @-> char @-> int @-> ptr complex64 @-> ptr double @-> returning int )

  let stprfs = foreign "LAPACKE_stprfs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dtprfs = foreign "LAPACKE_dtprfs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let ctprfs = foreign "LAPACKE_ctprfs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let ztprfs = foreign "LAPACKE_ztprfs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let stptri = foreign "LAPACKE_stptri" ( int @-> char @-> char @-> int @-> ptr float @-> returning int )

  let dtptri = foreign "LAPACKE_dtptri" ( int @-> char @-> char @-> int @-> ptr double @-> returning int )

  let ctptri = foreign "LAPACKE_ctptri" ( int @-> char @-> char @-> int @-> ptr complex32 @-> returning int )

  let ztptri = foreign "LAPACKE_ztptri" ( int @-> char @-> char @-> int @-> ptr complex64 @-> returning int )

  let stptrs = foreign "LAPACKE_stptrs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dtptrs = foreign "LAPACKE_dtptrs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let ctptrs = foreign "LAPACKE_ctptrs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let ztptrs = foreign "LAPACKE_ztptrs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let stpttf = foreign "LAPACKE_stpttf" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> returning int )

  let dtpttf = foreign "LAPACKE_dtpttf" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> returning int )

  let ctpttf = foreign "LAPACKE_ctpttf" ( int @-> char @-> char @-> int @-> ptr complex32 @-> ptr complex32 @-> returning int )

  let ztpttf = foreign "LAPACKE_ztpttf" ( int @-> char @-> char @-> int @-> ptr complex64 @-> ptr complex64 @-> returning int )

  let stpttr = foreign "LAPACKE_stpttr" ( int @-> char @-> int @-> ptr float @-> ptr float @-> int @-> returning int )

  let dtpttr = foreign "LAPACKE_dtpttr" ( int @-> char @-> int @-> ptr double @-> ptr double @-> int @-> returning int )

  let ctpttr = foreign "LAPACKE_ctpttr" ( int @-> char @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let ztpttr = foreign "LAPACKE_ztpttr" ( int @-> char @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let strcon = foreign "LAPACKE_strcon" ( int @-> char @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dtrcon = foreign "LAPACKE_dtrcon" ( int @-> char @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let ctrcon = foreign "LAPACKE_ctrcon" ( int @-> char @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr float @-> returning int )

  let ztrcon = foreign "LAPACKE_ztrcon" ( int @-> char @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr double @-> returning int )

  let strevc = foreign "LAPACKE_strevc" ( int @-> char @-> char @-> ptr int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> int @-> ptr int @-> returning int )

  let dtrevc = foreign "LAPACKE_dtrevc" ( int @-> char @-> char @-> ptr int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> int @-> ptr int @-> returning int )

  let ctrevc = foreign "LAPACKE_ctrevc" ( int @-> char @-> char @-> ptr int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> int @-> ptr int @-> returning int )

  let ztrevc = foreign "LAPACKE_ztrevc" ( int @-> char @-> char @-> ptr int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> int @-> ptr int @-> returning int )

  let strexc = foreign "LAPACKE_strexc" ( int @-> char @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr int @-> returning int )

  let dtrexc = foreign "LAPACKE_dtrexc" ( int @-> char @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr int @-> returning int )

  let ctrexc = foreign "LAPACKE_ctrexc" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> int @-> int @-> returning int )

  let ztrexc = foreign "LAPACKE_ztrexc" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> int @-> int @-> returning int )

  let strrfs = foreign "LAPACKE_strrfs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> returning int )

  let dtrrfs = foreign "LAPACKE_dtrrfs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> returning int )

  let ctrrfs = foreign "LAPACKE_ctrrfs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> returning int )

  let ztrrfs = foreign "LAPACKE_ztrrfs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> returning int )

  let strsen = foreign "LAPACKE_strsen" ( int @-> char @-> char @-> ptr int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr int @-> ptr float @-> ptr float @-> returning int )

  let dtrsen = foreign "LAPACKE_dtrsen" ( int @-> char @-> char @-> ptr int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr int @-> ptr double @-> ptr double @-> returning int )

  let ctrsen = foreign "LAPACKE_ctrsen" ( int @-> char @-> char @-> ptr int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr int @-> ptr float @-> ptr float @-> returning int )

  let ztrsen = foreign "LAPACKE_ztrsen" ( int @-> char @-> char @-> ptr int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr int @-> ptr double @-> ptr double @-> returning int )

  let strsna = foreign "LAPACKE_strsna" ( int @-> char @-> char @-> ptr int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dtrsna = foreign "LAPACKE_dtrsna" ( int @-> char @-> char @-> ptr int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let ctrsna = foreign "LAPACKE_ctrsna" ( int @-> char @-> char @-> ptr int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let ztrsna = foreign "LAPACKE_ztrsna" ( int @-> char @-> char @-> ptr int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let strsyl = foreign "LAPACKE_strsyl" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dtrsyl = foreign "LAPACKE_dtrsyl" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let ctrsyl = foreign "LAPACKE_ctrsyl" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> returning int )

  let ztrsyl = foreign "LAPACKE_ztrsyl" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> returning int )

  let strtri = foreign "LAPACKE_strtri" ( int @-> char @-> char @-> int @-> ptr float @-> int @-> returning int )

  let dtrtri = foreign "LAPACKE_dtrtri" ( int @-> char @-> char @-> int @-> ptr double @-> int @-> returning int )

  let ctrtri = foreign "LAPACKE_ctrtri" ( int @-> char @-> char @-> int @-> ptr complex32 @-> int @-> returning int )

  let ztrtri = foreign "LAPACKE_ztrtri" ( int @-> char @-> char @-> int @-> ptr complex64 @-> int @-> returning int )

  let strtrs = foreign "LAPACKE_strtrs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dtrtrs = foreign "LAPACKE_dtrtrs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let ctrtrs = foreign "LAPACKE_ctrtrs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let ztrtrs = foreign "LAPACKE_ztrtrs" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let strttf = foreign "LAPACKE_strttf" ( int @-> char @-> char @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dtrttf = foreign "LAPACKE_dtrttf" ( int @-> char @-> char @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let ctrttf = foreign "LAPACKE_ctrttf" ( int @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let ztrttf = foreign "LAPACKE_ztrttf" ( int @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let strttp = foreign "LAPACKE_strttp" ( int @-> char @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dtrttp = foreign "LAPACKE_dtrttp" ( int @-> char @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let ctrttp = foreign "LAPACKE_ctrttp" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let ztrttp = foreign "LAPACKE_ztrttp" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let stzrzf = foreign "LAPACKE_stzrzf" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> returning int )

  let dtzrzf = foreign "LAPACKE_dtzrzf" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> returning int )

  let ctzrzf = foreign "LAPACKE_ctzrzf" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let ztzrzf = foreign "LAPACKE_ztzrzf" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let cungbr = foreign "LAPACKE_cungbr" ( int @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zungbr = foreign "LAPACKE_zungbr" ( int @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let cunghr = foreign "LAPACKE_cunghr" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zunghr = foreign "LAPACKE_zunghr" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let cunglq = foreign "LAPACKE_cunglq" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zunglq = foreign "LAPACKE_zunglq" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let cungql = foreign "LAPACKE_cungql" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zungql = foreign "LAPACKE_zungql" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let cungqr = foreign "LAPACKE_cungqr" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zungqr = foreign "LAPACKE_zungqr" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let cungrq = foreign "LAPACKE_cungrq" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zungrq = foreign "LAPACKE_zungrq" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let cungtr = foreign "LAPACKE_cungtr" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning int )

  let zungtr = foreign "LAPACKE_zungtr" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning int )

  let cunmbr = foreign "LAPACKE_cunmbr" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zunmbr = foreign "LAPACKE_zunmbr" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let cunmhr = foreign "LAPACKE_cunmhr" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zunmhr = foreign "LAPACKE_zunmhr" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let cunmlq = foreign "LAPACKE_cunmlq" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zunmlq = foreign "LAPACKE_zunmlq" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let cunmql = foreign "LAPACKE_cunmql" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zunmql = foreign "LAPACKE_zunmql" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let cunmqr = foreign "LAPACKE_cunmqr" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zunmqr = foreign "LAPACKE_zunmqr" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let cunmrq = foreign "LAPACKE_cunmrq" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zunmrq = foreign "LAPACKE_zunmrq" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let cunmrz = foreign "LAPACKE_cunmrz" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zunmrz = foreign "LAPACKE_zunmrz" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let cunmtr = foreign "LAPACKE_cunmtr" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zunmtr = foreign "LAPACKE_zunmtr" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let cupgtr = foreign "LAPACKE_cupgtr" ( int @-> char @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zupgtr = foreign "LAPACKE_zupgtr" ( int @-> char @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let cupmtr = foreign "LAPACKE_cupmtr" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> returning int )

  let zupmtr = foreign "LAPACKE_zupmtr" ( int @-> char @-> char @-> char @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> returning int )

  let claghe = foreign "LAPACKE_claghe" ( int @-> int @-> int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zlaghe = foreign "LAPACKE_zlaghe" ( int @-> int @-> int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let slagsy = foreign "LAPACKE_slagsy" ( int @-> int @-> int @-> ptr float @-> ptr float @-> int @-> ptr int @-> returning int )

  let dlagsy = foreign "LAPACKE_dlagsy" ( int @-> int @-> int @-> ptr double @-> ptr double @-> int @-> ptr int @-> returning int )

  let clagsy = foreign "LAPACKE_clagsy" ( int @-> int @-> int @-> ptr float @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zlagsy = foreign "LAPACKE_zlagsy" ( int @-> int @-> int @-> ptr double @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let slapmr = foreign "LAPACKE_slapmr" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dlapmr = foreign "LAPACKE_dlapmr" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let clapmr = foreign "LAPACKE_clapmr" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zlapmr = foreign "LAPACKE_zlapmr" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let slapmt = foreign "LAPACKE_slapmt" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dlapmt = foreign "LAPACKE_dlapmt" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let clapmt = foreign "LAPACKE_clapmt" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zlapmt = foreign "LAPACKE_zlapmt" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let slartgp = foreign "LAPACKE_slartgp" ( float @-> float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dlartgp = foreign "LAPACKE_dlartgp" ( double @-> double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let slartgs = foreign "LAPACKE_slartgs" ( float @-> float @-> float @-> ptr float @-> ptr float @-> returning int )

  let dlartgs = foreign "LAPACKE_dlartgs" ( double @-> double @-> double @-> ptr double @-> ptr double @-> returning int )

  let cbbcsd = foreign "LAPACKE_cbbcsd" ( int @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let cheswapr = foreign "LAPACKE_cheswapr" ( int @-> char @-> int @-> ptr complex32 @-> int @-> int @-> int @-> returning int )

  let chetri2 = foreign "LAPACKE_chetri2" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let chetri2x = foreign "LAPACKE_chetri2x" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> int @-> returning int )

  let chetrs2 = foreign "LAPACKE_chetrs2" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let csyconv = foreign "LAPACKE_csyconv" ( int @-> char @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> returning int )

  let csyswapr = foreign "LAPACKE_csyswapr" ( int @-> char @-> int @-> ptr complex32 @-> int @-> int @-> int @-> returning int )

  let csytri2 = foreign "LAPACKE_csytri2" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let csytri2x = foreign "LAPACKE_csytri2x" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> int @-> returning int )

  let csytrs2 = foreign "LAPACKE_csytrs2" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let cunbdb = foreign "LAPACKE_cunbdb" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> returning int )

  let cuncsd = foreign "LAPACKE_cuncsd" ( int @-> char @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let cuncsd2by1 = foreign "LAPACKE_cuncsd2by1" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let dbbcsd = foreign "LAPACKE_dbbcsd" ( int @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let dorbdb = foreign "LAPACKE_dorbdb" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let dorcsd = foreign "LAPACKE_dorcsd" ( int @-> char @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let dorcsd2by1 = foreign "LAPACKE_dorcsd2by1" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let dsyconv = foreign "LAPACKE_dsyconv" ( int @-> char @-> char @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> returning int )

  let dsyswapr = foreign "LAPACKE_dsyswapr" ( int @-> char @-> int @-> ptr double @-> int @-> int @-> int @-> returning int )

  let dsytri2 = foreign "LAPACKE_dsytri2" ( int @-> char @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let dsytri2x = foreign "LAPACKE_dsytri2x" ( int @-> char @-> int @-> ptr double @-> int @-> ptr int @-> int @-> returning int )

  let dsytrs2 = foreign "LAPACKE_dsytrs2" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> returning int )

  let sbbcsd = foreign "LAPACKE_sbbcsd" ( int @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let sorbdb = foreign "LAPACKE_sorbdb" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let sorcsd = foreign "LAPACKE_sorcsd" ( int @-> char @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let sorcsd2by1 = foreign "LAPACKE_sorcsd2by1" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let ssyconv = foreign "LAPACKE_ssyconv" ( int @-> char @-> char @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> returning int )

  let ssyswapr = foreign "LAPACKE_ssyswapr" ( int @-> char @-> int @-> ptr float @-> int @-> int @-> int @-> returning int )

  let ssytri2 = foreign "LAPACKE_ssytri2" ( int @-> char @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let ssytri2x = foreign "LAPACKE_ssytri2x" ( int @-> char @-> int @-> ptr float @-> int @-> ptr int @-> int @-> returning int )

  let ssytrs2 = foreign "LAPACKE_ssytrs2" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> returning int )

  let zbbcsd = foreign "LAPACKE_zbbcsd" ( int @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let zheswapr = foreign "LAPACKE_zheswapr" ( int @-> char @-> int @-> ptr complex64 @-> int @-> int @-> int @-> returning int )

  let zhetri2 = foreign "LAPACKE_zhetri2" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let zhetri2x = foreign "LAPACKE_zhetri2x" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> int @-> returning int )

  let zhetrs2 = foreign "LAPACKE_zhetrs2" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let zsyconv = foreign "LAPACKE_zsyconv" ( int @-> char @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> returning int )

  let zsyswapr = foreign "LAPACKE_zsyswapr" ( int @-> char @-> int @-> ptr complex64 @-> int @-> int @-> int @-> returning int )

  let zsytri2 = foreign "LAPACKE_zsytri2" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let zsytri2x = foreign "LAPACKE_zsytri2x" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> int @-> returning int )

  let zsytrs2 = foreign "LAPACKE_zsytrs2" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let zunbdb = foreign "LAPACKE_zunbdb" ( int @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> returning int )

  let zuncsd = foreign "LAPACKE_zuncsd" ( int @-> char @-> char @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let zuncsd2by1 = foreign "LAPACKE_zuncsd2by1" ( int @-> char @-> char @-> char @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgemqrt = foreign "LAPACKE_sgemqrt" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgemqrt = foreign "LAPACKE_dgemqrt" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgemqrt = foreign "LAPACKE_cgemqrt" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgemqrt = foreign "LAPACKE_zgemqrt" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgeqrt = foreign "LAPACKE_sgeqrt" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgeqrt = foreign "LAPACKE_dgeqrt" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgeqrt = foreign "LAPACKE_cgeqrt" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgeqrt = foreign "LAPACKE_zgeqrt" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgeqrt2 = foreign "LAPACKE_sgeqrt2" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgeqrt2 = foreign "LAPACKE_dgeqrt2" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgeqrt2 = foreign "LAPACKE_cgeqrt2" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgeqrt2 = foreign "LAPACKE_zgeqrt2" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let sgeqrt3 = foreign "LAPACKE_sgeqrt3" ( int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dgeqrt3 = foreign "LAPACKE_dgeqrt3" ( int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cgeqrt3 = foreign "LAPACKE_cgeqrt3" ( int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zgeqrt3 = foreign "LAPACKE_zgeqrt3" ( int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let stpmqrt = foreign "LAPACKE_stpmqrt" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dtpmqrt = foreign "LAPACKE_dtpmqrt" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let ctpmqrt = foreign "LAPACKE_ctpmqrt" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let ztpmqrt = foreign "LAPACKE_ztpmqrt" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let stpqrt = foreign "LAPACKE_stpqrt" ( int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dtpqrt = foreign "LAPACKE_dtpqrt" ( int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let ctpqrt = foreign "LAPACKE_ctpqrt" ( int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let ztpqrt = foreign "LAPACKE_ztpqrt" ( int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let stpqrt2 = foreign "LAPACKE_stpqrt2" ( int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dtpqrt2 = foreign "LAPACKE_dtpqrt2" ( int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let ctpqrt2 = foreign "LAPACKE_ctpqrt2" ( int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let ztpqrt2 = foreign "LAPACKE_ztpqrt2" ( int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let stprfb = foreign "LAPACKE_stprfb" ( int @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dtprfb = foreign "LAPACKE_dtprfb" ( int @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let ctprfb = foreign "LAPACKE_ctprfb" ( int @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let ztprfb = foreign "LAPACKE_ztprfb" ( int @-> char @-> char @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

  let ssysv_rook = foreign "LAPACKE_ssysv_rook" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> returning int )

  let dsysv_rook = foreign "LAPACKE_dsysv_rook" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> returning int )

  let csysv_rook = foreign "LAPACKE_csysv_rook" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zsysv_rook = foreign "LAPACKE_zsysv_rook" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let ssytrf_rook = foreign "LAPACKE_ssytrf_rook" ( int @-> char @-> int @-> ptr float @-> int @-> ptr int @-> returning int )

  let dsytrf_rook = foreign "LAPACKE_dsytrf_rook" ( int @-> char @-> int @-> ptr double @-> int @-> ptr int @-> returning int )

  let csytrf_rook = foreign "LAPACKE_csytrf_rook" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zsytrf_rook = foreign "LAPACKE_zsytrf_rook" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let ssytrs_rook = foreign "LAPACKE_ssytrs_rook" ( int @-> char @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> returning int )

  let dsytrs_rook = foreign "LAPACKE_dsytrs_rook" ( int @-> char @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> returning int )

  let csytrs_rook = foreign "LAPACKE_csytrs_rook" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zsytrs_rook = foreign "LAPACKE_zsytrs_rook" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let chetrf_rook = foreign "LAPACKE_chetrf_rook" ( int @-> char @-> int @-> ptr complex32 @-> int @-> ptr int @-> returning int )

  let zhetrf_rook = foreign "LAPACKE_zhetrf_rook" ( int @-> char @-> int @-> ptr complex64 @-> int @-> ptr int @-> returning int )

  let chetrs_rook = foreign "LAPACKE_chetrs_rook" ( int @-> char @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zhetrs_rook = foreign "LAPACKE_zhetrs_rook" ( int @-> char @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let csyr = foreign "LAPACKE_csyr" ( int @-> char @-> int @-> complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

  let zsyr = foreign "LAPACKE_zsyr" ( int @-> char @-> int @-> complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning int )

end