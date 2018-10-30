(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_aeos_tuner_map
open Owl_aeos_tuner_fold


type tuner =
  | Reci    of Reci.t
  | Exp     of Exp.t
  | Sin     of Sin.t
  | Cos     of Cos.t
  | Add     of Add.t
  | Div     of Div.t
  | Atan2   of Atan2.t
  | Fmod    of Fmod.t
  | Sum     of Sum.t
  | Prod    of Prod.t
  | Cumsum  of Cumsum.t
  | Cumprod of Cumprod.t


let tuning = function
  | Reci x    -> Reci.tune x
  | Exp x     -> Exp.tune x
  | Sin x     -> Sin.tune x
  | Cos x     -> Cos.tune x
  | Add x     -> Add.tune x
  | Div x     -> Div.tune x
  | Atan2 x   -> Atan2.tune x
  | Fmod x    -> Fmod.tune x
  | Sum x     -> Sum.tune x
  | Prod x    -> Prod.tune x
  | Cumsum x  -> Cumsum.tune x
  | Cumprod x -> Cumprod.tune x


let to_string = function
  | Reci x    -> Reci.to_string x
  | Exp x     -> Exp.to_string x
  | Sin x     -> Sin.to_string x
  | Cos x     -> Cos.to_string x
  | Add x     -> Add.to_string x
  | Div x     -> Div.to_string x
  | Atan2 x   -> Atan2.to_string x
  | Fmod x    -> Fmod.to_string x
  | Sum x     -> Sum.to_string x
  | Prod x    -> Prod.to_string x
  | Cumsum x  -> Cumsum.to_string x
  | Cumprod x -> Cumprod.to_string x


let plot = function
  | Reci x    -> Reci.plot x
  | Exp x     -> Exp.plot x
  | Sin x     -> Sin.plot x
  | Cos x     -> Cos.plot x
  | Add x     -> Add.plot x
  | Div x     -> Div.plot x
  | Atan2 x   -> Atan2.plot x
  | Fmod x    -> Fmod.plot x
  | Sum x     -> Sum.plot x
  | Prod x    -> Prod.plot x
  | Cumsum x  -> Cumsum.plot x
  | Cumprod x -> Cumprod.plot x


let all = [|
  Reci    (Reci.make ());
  Exp     (Exp.make ());
  Sin     (Sin.make ());
  Cos     (Cos.make ());
  Add     (Add.make ());
  Div     (Div.make ());
  Atan2   (Atan2.make ());
  Fmod    (Fmod.make ());
  Sum     (Sum.make ());
  Prod    (Prod.make ());
  Cumsum  (Cumsum.make ());
  Cumprod (Cumprod.make ());
|]
