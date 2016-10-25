module CI = Cstubs_internals

external owl_stub_1_flock : int -> int -> int = "owl_stub_1_flock" 

external owl_stub_2_gsl_spmatrix_alloc : int -> int -> CI.voidp
  = "owl_stub_2_gsl_spmatrix_alloc" 

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
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x3))),
  "gsl_spmatrix_alloc" ->
  (fun x1 x2 -> CI.make_ptr x3 (owl_stub_2_gsl_spmatrix_alloc x1 x2))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Int))),
  "flock" -> owl_stub_1_flock
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

