module CI = Cstubs_internals

external owl_stub_1_c_eigen_spmat_d_new : int -> int -> CI.voidp
  = "owl_stub_1_c_eigen_spmat_d_new" 

external owl_stub_2_c_eigen_spmat_d_delete : _ CI.fatptr -> unit
  = "owl_stub_2_c_eigen_spmat_d_delete" 

external owl_stub_3_c_eigen_spmat_d_rows : _ CI.fatptr -> int
  = "owl_stub_3_c_eigen_spmat_d_rows" 

external owl_stub_4_c_eigen_spmat_d_cols : _ CI.fatptr -> int
  = "owl_stub_4_c_eigen_spmat_d_cols" 

external owl_stub_5_c_eigen_spmat_d_get : _ CI.fatptr -> int -> int -> float
  = "owl_stub_5_c_eigen_spmat_d_get" 

external owl_stub_6_c_eigen_spmat_d_set
  : _ CI.fatptr -> int -> int -> float -> unit
  = "owl_stub_6_c_eigen_spmat_d_set" 

external owl_stub_7_c_eigen_spmat_d_reset : _ CI.fatptr -> unit
  = "owl_stub_7_c_eigen_spmat_d_reset" 

external owl_stub_8_c_eigen_spmat_d_is_compressed : _ CI.fatptr -> int
  = "owl_stub_8_c_eigen_spmat_d_is_compressed" 

external owl_stub_9_c_eigen_spmat_d_compress : _ CI.fatptr -> unit
  = "owl_stub_9_c_eigen_spmat_d_compress" 

external owl_stub_10_c_eigen_spmat_d_uncompress : _ CI.fatptr -> unit
  = "owl_stub_10_c_eigen_spmat_d_uncompress" 

external owl_stub_11_c_eigen_spmat_d_reshape
  : _ CI.fatptr -> int -> int -> unit = "owl_stub_11_c_eigen_spmat_d_reshape" 

external owl_stub_12_c_eigen_spmat_d_clone : _ CI.fatptr -> CI.voidp
  = "owl_stub_12_c_eigen_spmat_d_clone" 

external owl_stub_13_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_13_c_eigen_spmat_d_print" 

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
| Function (CI.Pointer x2, Returns CI.Void), "c_eigen_spmat_d_print" ->
  (fun x1 -> owl_stub_13_c_eigen_spmat_d_print (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Pointer x5)), "c_eigen_spmat_d_clone" ->
  (fun x3 -> CI.make_ptr x5 (owl_stub_12_c_eigen_spmat_d_clone (CI.cptr x3)))
| Function
    (CI.Pointer x7,
     Function
       (CI.Primitive CI.Int, Function (CI.Primitive CI.Int, Returns CI.Void))),
  "c_eigen_spmat_d_reshape" ->
  (fun x6 x8 x9 -> owl_stub_11_c_eigen_spmat_d_reshape (CI.cptr x6) x8 x9)
| Function (CI.Pointer x11, Returns CI.Void), "c_eigen_spmat_d_uncompress" ->
  (fun x10 -> owl_stub_10_c_eigen_spmat_d_uncompress (CI.cptr x10))
| Function (CI.Pointer x13, Returns CI.Void), "c_eigen_spmat_d_compress" ->
  (fun x12 -> owl_stub_9_c_eigen_spmat_d_compress (CI.cptr x12))
| Function (CI.Pointer x15, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x14 -> owl_stub_8_c_eigen_spmat_d_is_compressed (CI.cptr x14))
| Function (CI.Pointer x17, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x16 -> owl_stub_7_c_eigen_spmat_d_reset (CI.cptr x16))
| Function
    (CI.Pointer x19,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x18 x20 x21 x22 ->
    owl_stub_6_c_eigen_spmat_d_set (CI.cptr x18) x20 x21 x22)
| Function
    (CI.Pointer x24,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x23 x25 x26 -> owl_stub_5_c_eigen_spmat_d_get (CI.cptr x23) x25 x26)
| Function (CI.Pointer x28, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x27 -> owl_stub_4_c_eigen_spmat_d_cols (CI.cptr x27))
| Function (CI.Pointer x30, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x29 -> owl_stub_3_c_eigen_spmat_d_rows (CI.cptr x29))
| Function (CI.Pointer x32, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x31 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x31))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x35))),
  "c_eigen_spmat_d_new" ->
  (fun x33 x34 -> CI.make_ptr x35 (owl_stub_1_c_eigen_spmat_d_new x33 x34))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

