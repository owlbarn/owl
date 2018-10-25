(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

 open Owl_aeos_tuner_map
 open Owl_aeos_tuner_fold

 type tuner =
   | Sin of Sin.t
   | Cos of Cos.t
   | Add of Add.t
   | Div of Div.t
   | Atan2 of Atan2.t
   | Sum of Sum.t


let tuning = function
  | Sin x -> Sin.tune x
  | Cos x -> Cos.tune x
  | Add x -> Add.tune x
  | Div x -> Div.tune x
  | Atan2 x -> Atan2.tune x
  | Sum x -> Sum.tune x


let to_string = function
  | Sin x -> Sin.to_string x
  | Cos x -> Cos.to_string x
  | Add x -> Add.to_string x
  | Div x -> Div.to_string x
  | Atan2 x -> Atan2.to_string x
  | Sum x -> Sum.to_string x


let all = [|
  Sin   (Sin.make ());
  Cos   (Cos.make ());
  Add   (Add.make ());
  Atan2 (Atan2.make ());
  Div   (Div.make ());
  Sum   (Sum.make ());
|]
