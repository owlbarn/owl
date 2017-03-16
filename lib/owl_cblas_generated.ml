module CI = Cstubs_internals

external owl_stub_1_cblas_scopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_1_cblas_scopy" 

external owl_stub_2_cblas_dcopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_2_cblas_dcopy" 

external owl_stub_3_cblas_ccopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_3_cblas_ccopy" 

external owl_stub_4_cblas_zcopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_4_cblas_zcopy" 

type 'a result = 'a
type 'a return = 'a
type 'a fn =
 | Returns  : 'a CI.typ   -> 'a return fn
 | Function : 'a CI.typ * 'b fn  -> ('a -> 'b) fn
let map_result f x = f x
let returning t = Returns t
let (@->) f p = Function (f, p)
let foreign : type a b. string -> (a -> b) fn -> (a -> b) =
  fun name t -> match t, name with
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x3,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x6, Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zcopy" ->
  (fun x1 x2 x4 x5 x7 ->
    owl_stub_4_cblas_zcopy x1 (CI.cptr x2) x4 (CI.cptr x5) x7)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x10,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x13,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_ccopy" ->
  (fun x8 x9 x11 x12 x14 ->
    owl_stub_3_cblas_ccopy x8 (CI.cptr x9) x11 (CI.cptr x12) x14)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x17,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x20,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dcopy" ->
  (fun x15 x16 x18 x19 x21 ->
    owl_stub_2_cblas_dcopy x15 (CI.cptr x16) x18 (CI.cptr x19) x21)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x24,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x27,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_scopy" ->
  (fun x22 x23 x25 x26 x28 ->
    owl_stub_1_cblas_scopy x22 (CI.cptr x23) x25 (CI.cptr x26) x28)
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

