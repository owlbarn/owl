(* auto-generated lapacke interface file, timestamp:1497375673 *)

open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct

  open F

  let sbdsdc = foreign "LAPACKE_sbdsdc" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr int @-> returning int )

  let dbdsdc = foreign "LAPACKE_dbdsdc" ( int @-> char @-> char @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> ptr int @-> returning int )

  let sbdsqr = foreign "LAPACKE_sbdsqr" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning int )

  let dbdsqr = foreign "LAPACKE_dbdsqr" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr double @-> ptr double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning int )

  let cbdsqr = foreign "LAPACKE_cbdsqr" ( int @-> char @-> int @-> int @-> int @-> int @-> ptr float @-> ptr float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning int )

end