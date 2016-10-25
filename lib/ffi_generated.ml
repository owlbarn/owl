module CI = Cstubs_internals

external owl_stub_1_flock : int -> int -> int = "owl_stub_1_flock" 

external owl_stub_2_gsl_spmatrix_alloc : int -> int -> CI.voidp
  = "owl_stub_2_gsl_spmatrix_alloc" 

external owl_stub_3_gsl_spmatrix_alloc_nzmax
  : int -> int -> int -> int -> CI.voidp
  = "owl_stub_3_gsl_spmatrix_alloc_nzmax" 

external owl_stub_4_gsl_spmatrix_set
  : _ CI.fatptr -> int -> int -> Complex.t -> int
  = "owl_stub_4_gsl_spmatrix_set" 

external owl_stub_5_gsl_spmatrix_get : _ CI.fatptr -> int -> int -> Complex.t
  = "owl_stub_5_gsl_spmatrix_get" 

external owl_stub_6_gsl_spmatrix_set_zero : _ CI.fatptr -> int
  = "owl_stub_6_gsl_spmatrix_set_zero" 

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
  "gsl_spmatrix_set_zero" ->
  (fun x1 -> owl_stub_6_gsl_spmatrix_set_zero (CI.cptr x1))
| Function
    (CI.Pointer x4,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Complex64)))),
  "gsl_spmatrix_get" ->
  (fun x3 x5 x6 -> owl_stub_5_gsl_spmatrix_get (CI.cptr x3) x5 x6)
| Function
    (CI.Pointer x8,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Complex64, Returns (CI.Primitive CI.Int))))),
  "gsl_spmatrix_set" ->
  (fun x7 x9 x10 x11 -> owl_stub_4_gsl_spmatrix_set (CI.cptr x7) x9 x10 x11)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Int, Returns (CI.Pointer x16))))),
  "gsl_spmatrix_alloc_nzmax" ->
  (fun x12 x13 x14 x15 ->
    CI.make_ptr x16 (owl_stub_3_gsl_spmatrix_alloc_nzmax x12 x13 x14 x15))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x19))),
  "gsl_spmatrix_alloc" ->
  (fun x17 x18 -> CI.make_ptr x19 (owl_stub_2_gsl_spmatrix_alloc x17 x18))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Int))),
  "flock" -> owl_stub_1_flock
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

