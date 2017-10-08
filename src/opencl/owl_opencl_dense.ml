(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* math operator definitions *)

let sin x = Owl_opencl_operand.(pack_op (Map "owl_opencl_float32_sin") [|x|])

let cos x = Owl_opencl_operand.(pack_op (Map "owl_opencl_float32_cos") [|x|])


(* ends here *)
