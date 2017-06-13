(* auto-generated lapacke interface file, timestamp:1497381661 *)

open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct

  open F

  let sbdsdc = foreign "LAPACKE_sbdsdc" ( int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr int @-> returning int )

end