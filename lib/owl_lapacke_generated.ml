module CI = Cstubs_internals

external owl_stub_1_LAPACKE_sbdsdc
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr ->
    _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int = "owl_stub_1_LAPACKE_sbdsdc_byte12" "owl_stub_1_LAPACKE_sbdsdc" 

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
       (CI.Primitive CI.Char,
        Function
          (CI.Primitive CI.Char,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x6,
                 Function
                   (CI.Pointer x8,
                    Function
                      (CI.Pointer x10,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x13,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x16,
                                   Function
                                     (CI.Pointer x18,
                                      Returns (CI.Primitive CI.Int))))))))))))),
  "LAPACKE_sbdsdc" ->
  (fun x1 x2 x3 x4 x5 x7 x9 x11 x12 x14 x15 x17 ->
    owl_stub_1_LAPACKE_sbdsdc x1 x2 x3 x4 (CI.cptr x5) (CI.cptr x7)
    (CI.cptr x9) x11 (CI.cptr x12) x14 (CI.cptr x15) (CI.cptr x17))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

