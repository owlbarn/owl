module CI = Cstubs_internals

external owl_stub_1_c_eigen_spmat_d_new : int -> int -> CI.voidp
  = "owl_stub_1_c_eigen_spmat_d_new" 

external owl_stub_2_c_eigen_spmat_d_rows : _ CI.fatptr -> int
  = "owl_stub_2_c_eigen_spmat_d_rows" 

external owl_stub_3_c_eigen_spmat_d_cols : _ CI.fatptr -> int
  = "owl_stub_3_c_eigen_spmat_d_cols" 

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
| Function (CI.Pointer x2, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x1 -> owl_stub_3_c_eigen_spmat_d_cols (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x3 -> owl_stub_2_c_eigen_spmat_d_rows (CI.cptr x3))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x7))),
  "c_eigen_spmat_d_new" ->
  (fun x5 x6 -> CI.make_ptr x7 (owl_stub_1_c_eigen_spmat_d_new x5 x6))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

