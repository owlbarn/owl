(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


 open Owl
 open Owl_core_types

 module N = Dense.Ndarray.S

 open Bigarray

 external baseline_float32_cos : int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit = "float32_cos"


 let baseline_cos : type a b. (a, b) kind -> (a, b) owl_arr_op09 = fun k l x y ->
   match k with
   | Float32   -> baseline_float32_cos l x y
   | _         -> failwith "cos_baseline: unsupported operation"

 let n = 200
 let start = 1000
 let step = 3000


 type t = {
   mutable c_macro : string;
   mutable measure : float array array;
   mutable params  : int;
 }


 let make () = {
   c_macro = "OWL_OMP_THRESHOLD_COS";
   measure = [| [||]; [||] |];
   params  = max_int;
 }


 let tune t =
   (* Owl_log.info "AEOS: tune cos ...";
   (* Call C stub function to do measurement, then regression *)

   let sizes = Array.make n 0. in
   let val1  = Array.make n 0. in
   let val2  = Array.make n 0. in

   let sz = ref start in
   for i = 0 to n - 1 do
     let v1, _ = Owl_aeos_utils.timing
       (Owl_aeos_utils.eval_single_op Owl_ndarray._owl_cos !sz) "cos" in
     let v2, _ = Owl_aeos_utils.timing
       (Owl_aeos_utils.eval_single_op baseline_cos !sz) "cos_baseline" in
     val1.(i) <- v1;
     val2.(i) <- v2;

     sizes.(i) <- float_of_int !sz;
     sz := !sz + step
   done;
   t.measure.(0) <- val1;
   t.measure.(1) <- val2;

   t.params <- Owl_aeos_utils.regression ~p:true t.measure sizes; *)
   t.params <- 0;
   ()

 let to_string t =
   Printf.sprintf "#define %s %s" t.c_macro (string_of_int t.params)
