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

external owl_stub_9_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_9_c_eigen_spmat_d_print" 

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
  (fun x1 -> owl_stub_9_c_eigen_spmat_d_print (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x3 -> owl_stub_8_c_eigen_spmat_d_is_compressed (CI.cptr x3))
| Function (CI.Pointer x6, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x5 -> owl_stub_7_c_eigen_spmat_d_reset (CI.cptr x5))
| Function
    (CI.Pointer x8,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x7 x9 x10 x11 ->
    owl_stub_6_c_eigen_spmat_d_set (CI.cptr x7) x9 x10 x11)
| Function
    (CI.Pointer x13,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x12 x14 x15 -> owl_stub_5_c_eigen_spmat_d_get (CI.cptr x12) x14 x15)
| Function (CI.Pointer x17, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x16 -> owl_stub_4_c_eigen_spmat_d_cols (CI.cptr x16))
| Function (CI.Pointer x19, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x18 -> owl_stub_3_c_eigen_spmat_d_rows (CI.cptr x18))
| Function (CI.Pointer x21, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x20 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x20))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x24))),
  "c_eigen_spmat_d_new" ->
  (fun x22 x23 -> CI.make_ptr x24 (owl_stub_1_c_eigen_spmat_d_new x22 x23))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

