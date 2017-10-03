(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_s


type t =
  | F     of float
  | Arr   of arr
  | Trace of trace
and trace = {
  op     : trace_op;
  input  : t array;
  output : t array option;
}
and trace_op =
  | Noop
  | Add
  | Sub
  | Mul
  | Div


let pack_input = function
  | Trace x -> Trace x
  | x       -> Trace {
      op     = Noop;
      input  = [|x|];
      output = Some [|x|];
    }


let pack_op op input output =
  let input = Array.map pack_input input in
  Trace {
    op;
    input;
    output;
  }


let add x y = pack_op Add [|x; y|] None


let sub x y = pack_op Sub [|x; y|] None


let mul x y = pack_op Mul [|x; y|] None


let div x y = pack_op Div [|x; y|] None



(* ends here *)
