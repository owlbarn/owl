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
    (CI.Pointer x2,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x1 x3 x4 -> owl_stub_5_c_eigen_spmat_d_get (CI.cptr x1) x3 x4)
| Function (CI.Pointer x6, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x5 -> owl_stub_4_c_eigen_spmat_d_cols (CI.cptr x5))
| Function (CI.Pointer x8, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x7 -> owl_stub_3_c_eigen_spmat_d_rows (CI.cptr x7))
| Function (CI.Pointer x10, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x9 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x9))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x13))),
  "c_eigen_spmat_d_new" ->
  (fun x11 x12 -> CI.make_ptr x13 (owl_stub_1_c_eigen_spmat_d_new x11 x12))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

