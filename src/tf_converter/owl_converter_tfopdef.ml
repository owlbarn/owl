(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_converter_types
open Owl_converter_attr


(* There should a unified naming rules, so that it's "Add", not "aDd" or something else. Also, TF nodes might also need to be typed later. *)


let nil_def = { name = "Nil"; input_arg = [||]; output_arg = [||]; attr = [||]}


let add_def =
  let input_arg = [|
    make_argdef ~typ_attr:"T" "x";
    make_argdef ~typ_attr:"T" "y";
  |]
  in
  let output_arg = [|
    make_argdef ~typ_attr:"T" "z";
  |]
  in
  let attr = [|
    make_tfop_attr "T" "type"
  |]
  in
  { name = "Add"; input_arg = input_arg; output_arg = output_arg; attr = attr }


let get_tfop = function
| "Add" -> add_def
| _     -> nil_def
