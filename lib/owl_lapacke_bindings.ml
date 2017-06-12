(* auto-generated lapacke interface file *)

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

  let sgbrfsx = foreign "LAPACKE_sgbrfsx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgbrfsx = foreign "LAPACKE_dgbrfsx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgbrfsx = foreign "LAPACKE_cgbrfsx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> returning int )

  let zgbrfsx = foreign "LAPACKE_zgbrfsx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> returning int )

  let sgbsv = foreign "LAPACKE_sgbsv" ( int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr int @-> ptr float @-> int @-> returning int )

  let dgbsv = foreign "LAPACKE_dgbsv" ( int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr int @-> ptr double @-> int @-> returning int )

  let cgbsv = foreign "LAPACKE_cgbsv" ( int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr complex32 @-> int @-> returning int )

  let zgbsv = foreign "LAPACKE_zgbsv" ( int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr complex64 @-> int @-> returning int )

  let sgbsvx = foreign "LAPACKE_sgbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr char @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let dgbsvx = foreign "LAPACKE_dgbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr char @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let cgbsvx = foreign "LAPACKE_cgbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr char @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning int )

  let zgbsvx = foreign "LAPACKE_zgbsvx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr char @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning int )

  let sgbsvxx = foreign "LAPACKE_sgbsvxx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> ptr int @-> ptr char @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> returning int )

  let dgbsvxx = foreign "LAPACKE_dgbsvxx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> ptr int @-> ptr char @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> returning int )

  let cgbsvxx = foreign "LAPACKE_cgbsvxx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr int @-> ptr char @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> ptr float @-> int @-> ptr float @-> returning int )

  let zgbsvxx = foreign "LAPACKE_zgbsvxx" ( int @-> char @-> char @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr int @-> ptr char @-> ptr double @-> ptr double @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> ptr double @-> int @-> ptr double @-> returning int )

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

end