(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_aeos_tuner_map
open Owl_aeos_tuner_fold


type tuner =
  | Reci      of Reci.t
  | Abs       of Abs.t
  | Abs2      of Abs2.t
  | Signum    of Signum.t
  | Sqr       of Sqr.t
  | Sqrt      of Sqrt.t
  | Cbrt      of Cbrt.t
  | Exp       of Exp.t
  | Expm1     of Expm1.t
  | Log       of Log.t
  | Log1p     of Log1p.t
  | Sin       of Sin.t
  | Cos       of Cos.t
  | Tan       of Tan.t
  | Asin      of Asin.t
  | Acos      of Acos.t
  | Atan      of Atan.t
  | Sinh      of Sinh.t
  | Cosh      of Cosh.t
  | Tanh      of Tanh.t
  | Asinh     of Asinh.t
  | Acosh     of Acosh.t
  | Atanh     of Atanh.t
  | Erf       of Erf.t
  | Erfc      of Erfc.t
  | Logistic  of Logistic.t
  | Relu      of Relu.t
  | Softplus  of Softplus.t
  | Softsign  of Softsign.t
  | Sigmoid   of Sigmoid.t
  | Elt_equal of Elt_equal.t
  | Add       of Add.t
  | Mul       of Mul.t
  | Div       of Div.t
  | Pow       of Pow.t
  | Hypot     of Hypot.t
  | Atan2     of Atan2.t
  | Max2      of Max2.t
  | Fmod      of Fmod.t
  | Sum       of Sum.t
  | Prod      of Prod.t
  | Cumsum    of Cumsum.t
  | Cumprod   of Cumprod.t
  | Cummax    of Cummax.t
  | Diff      of Diff.t
  | Repeat    of Repeat.t


let tuning = function
  | Reci x      -> Reci.tune x
  | Abs x       -> Abs.tune x
  | Abs2 x      -> Abs2.tune x
  | Signum x    -> Signum.tune x
  | Sqr x       -> Sqr.tune x
  | Sqrt x      -> Sqrt.tune x
  | Cbrt x      -> Cbrt.tune x
  | Exp x       -> Exp.tune x
  | Expm1 x     -> Expm1.tune x
  | Log x       -> Log.tune x
  | Log1p x     -> Log1p.tune x
  | Sin x       -> Sin.tune x
  | Cos x       -> Cos.tune x
  | Tan x       -> Tan.tune x
  | Asin x      -> Asin.tune x
  | Acos x      -> Acos.tune x
  | Atan x      -> Atan.tune x
  | Sinh x      -> Sinh.tune x
  | Cosh x      -> Cosh.tune x
  | Tanh x      -> Tanh.tune x
  | Asinh x     -> Asinh.tune x
  | Acosh x     -> Acosh.tune x
  | Atanh x     -> Atanh.tune x
  | Erf x       -> Erf.tune x
  | Erfc x      -> Erfc.tune x
  | Logistic x  -> Logistic.tune x
  | Relu x      -> Relu.tune x
  | Softplus x  -> Softplus.tune x
  | Softsign x  -> Softsign.tune x
  | Sigmoid x   -> Sigmoid.tune x
  | Elt_equal x -> Elt_equal.tune x
  | Add x       -> Add.tune x
  | Mul x       -> Mul.tune x
  | Div x       -> Div.tune x
  | Pow x       -> Pow.tune x
  | Hypot x     -> Hypot.tune x
  | Atan2 x     -> Atan2.tune x
  | Max2 x      -> Max2.tune x
  | Fmod x      -> Fmod.tune x
  | Sum x       -> Sum.tune x
  | Prod x      -> Prod.tune x
  | Cumsum x    -> Cumsum.tune x
  | Cumprod x   -> Cumprod.tune x
  | Cummax x    -> Cummax.tune x
  | Diff x      -> Diff.tune x
  | Repeat x    -> Repeat.tune x


let to_string_array = function
  | Reci x      -> [|Reci.to_string x|]
  | Abs x       -> [|Abs.to_string x|]
  | Abs2 x      -> [|Abs2.to_string x|]
  | Signum x    -> [|Signum.to_string x|]
  | Sqr x       -> [|Sqr.to_string x|]
  | Sqrt x      -> [|Sqrt.to_string x|]
  | Cbrt x      -> [|Cbrt.to_string x|]
  | Exp x       -> [|Exp.to_string x|]
  | Expm1 x     -> [|Expm1.to_string x|]
  | Log x       -> [|Log.to_string x|]
  | Log1p x     -> [|Log1p.to_string x|]
  | Sin x       -> [|Sin.to_string x|]
  | Cos x       -> [|Cos.to_string x|]
  | Tan x       -> [|Tan.to_string x|]
  | Asin x      -> [|Asin.to_string x|]
  | Acos x      -> [|Acos.to_string x|]
  | Atan x      -> [|Atan.to_string x|]
  | Sinh x      -> [|Sinh.to_string x|]
  | Cosh x      -> [|Cosh.to_string x|]
  | Tanh x      -> [|Tanh.to_string x|]
  | Asinh x     -> [|Asinh.to_string x|]
  | Acosh x     -> [|Acosh.to_string x|]
  | Atanh x     -> [|Atanh.to_string x|]
  | Erf x       -> [|Erf.to_string x|]
  | Erfc x      -> [|Erfc.to_string x|]
  | Logistic x  -> [|Logistic.to_string x|]
  | Relu x      -> [|Relu.to_string x|]
  | Softplus x  -> [|Softplus.to_string x|]
  | Softsign x  -> [|Softsign.to_string x|]
  | Sigmoid x   -> [|Sigmoid.to_string x|]
  | Elt_equal x -> [|Elt_equal.to_string x|]
  | Add x       -> [|Add.to_string x|]
  | Mul x       -> [|Mul.to_string x|]
  | Div x       -> [|Div.to_string x|]
  | Pow x       -> [|Pow.to_string x|]
  | Hypot x     -> [|Hypot.to_string x|]
  | Atan2 x     -> [|Atan2.to_string x|]
  | Max2 x      -> [|Max2.to_string x|]
  | Fmod x      -> [|Fmod.to_string x|]
  | Sum x       -> [|Sum.to_string x|]
  | Prod x      -> [|Prod.to_string x|]
  | Cumsum x    -> [|Cumsum.to_string x|]
  | Cumprod x   -> [|Cumprod.to_string x|]
  | Cummax x    -> [|Cummax.to_string x|]
  | Diff x      -> [|Diff.to_string x|]
  | Repeat x    -> [|Repeat.to_string x|]


let save_data = function
  | Reci x      -> Reci.save_data x
  | Abs x       -> Abs.save_data x
  | Abs2 x      -> Abs2.save_data x
  | Signum x    -> Signum.save_data x
  | Sqr x       -> Sqr.save_data x
  | Sqrt x      -> Sqrt.save_data x
  | Cbrt x      -> Cbrt.save_data x
  | Exp x       -> Exp.save_data x
  | Expm1 x     -> Expm1.save_data x
  | Log x       -> Log.save_data x
  | Log1p x     -> Log1p.save_data x
  | Sin x       -> Sin.save_data x
  | Cos x       -> Cos.save_data x
  | Tan x       -> Tan.save_data x
  | Asin x      -> Asin.save_data x
  | Acos x      -> Acos.save_data x
  | Atan x      -> Atan.save_data x
  | Sinh x      -> Sinh.save_data x
  | Cosh x      -> Cosh.save_data x
  | Tanh x      -> Tanh.save_data x
  | Asinh x     -> Asinh.save_data x
  | Acosh x     -> Acosh.save_data x
  | Atanh x     -> Atanh.save_data x
  | Erf x       -> Erf.save_data x
  | Erfc x      -> Erfc.save_data x
  | Logistic x  -> Logistic.save_data x
  | Relu x      -> Relu.save_data x
  | Softplus x  -> Softplus.save_data x
  | Softsign x  -> Softsign.save_data x
  | Sigmoid x   -> Sigmoid.save_data x
  | Elt_equal x -> Elt_equal.save_data x
  | Add x       -> Add.save_data x
  | Mul x       -> Mul.save_data x
  | Div x       -> Div.save_data x
  | Pow x       -> Pow.save_data x
  | Hypot x     -> Hypot.save_data x
  | Atan2 x     -> Atan2.save_data x
  | Max2 x      -> Max2.save_data x
  | Fmod x      -> Fmod.save_data x
  | Sum x       -> Sum.save_data x
  | Prod x      -> Prod.save_data x
  | Cumsum x    -> Cumsum.save_data x
  | Cumprod x   -> Cumprod.save_data x
  | Cummax x    -> Cummax.save_data x
  | Diff x      -> Diff.save_data x
  | Repeat x    -> Repeat.save_data x


let get_params = function
  | Reci x      -> [|x.param|]
  | Abs x       -> [|x.param|]
  | Abs2 x      -> [|x.param|]
  | Signum x    -> [|x.param|]
  | Sqr x       -> [|x.param|]
  | Sqrt x      -> [|x.param|]
  | Cbrt x      -> [|x.param|]
  | Exp x       -> [|x.param|]
  | Expm1 x     -> [|x.param|]
  | Log x       -> [|x.param|]
  | Log1p x     -> [|x.param|]
  | Sin x       -> [|x.param|]
  | Cos x       -> [|x.param|]
  | Tan x       -> [|x.param|]
  | Asin x      -> [|x.param|]
  | Acos x      -> [|x.param|]
  | Atan x      -> [|x.param|]
  | Sinh x      -> [|x.param|]
  | Cosh x      -> [|x.param|]
  | Tanh x      -> [|x.param|]
  | Asinh x     -> [|x.param|]
  | Acosh x     -> [|x.param|]
  | Atanh x     -> [|x.param|]
  | Erf x       -> [|x.param|]
  | Erfc x      -> [|x.param|]
  | Logistic x  -> [|x.param|]
  | Relu x      -> [|x.param|]
  | Softplus x  -> [|x.param|]
  | Softsign x  -> [|x.param|]
  | Sigmoid x   -> [|x.param|]
  | Elt_equal x -> [|x.param|]
  | Add x       -> [|x.param|]
  | Mul x       -> [|x.param|]
  | Div x       -> [|x.param|]
  | Pow x       -> [|x.param|]
  | Hypot x     -> [|x.param|]
  | Atan2 x     -> [|x.param|]
  | Max2 x      -> [|x.param|]
  | Fmod x      -> [|x.param|]
  | Sum x       -> [|x.param|]
  | Prod x      -> [|x.param|]
  | Cumsum x    -> [|x.param|]
  | Cumprod x   -> [|x.param|]
  | Cummax x    -> [|x.param|]
  | Diff x      -> [|x.param|]
  | Repeat x    -> [|x.param|]


let all = [|
  Reci      (Reci.make ());
  Abs       (Abs.make ());
  Abs2      (Abs2.make ());
  Signum    (Signum.make ());
  Sqr       (Sqr.make ());
  Sqrt      (Sqrt.make ());
  Cbrt      (Cbrt.make ());
  Exp       (Exp.make ());
  Expm1     (Expm1.make ());
  Log       (Log.make ());
  Log1p     (Log1p.make ());
  Sin       (Sin.make ());
  Cos       (Cos.make ());
  Tan       (Tan.make ());
  Asin      (Asin.make ());
  Acos      (Acos.make ());
  Atan      (Atan.make ());
  Sinh      (Sinh.make ());
  Cosh      (Cosh.make ());
  Tanh      (Tanh.make ());
  Asinh     (Asinh.make ());
  Acosh     (Acosh.make ());
  Atanh     (Atanh.make ());
  Erf       (Erf.make ());
  Erfc      (Erfc.make ());
  Logistic  (Logistic.make ());
  Relu      (Relu.make ());
  Softplus  (Softplus.make ());
  Softsign  (Softsign.make ());
  Sigmoid   (Sigmoid.make ());
  Add       (Add.make ());
  Div       (Div.make ());
  Atan2     (Atan2.make ());
  Fmod      (Fmod.make ());
  Sum       (Sum.make ());
  Prod      (Prod.make ());
  Cumsum    (Cumsum.make ());
  Cumprod   (Cumprod.make ());
  Cummax    (Cummax.make ());
  Diff      (Diff.make ());
  Repeat    (Repeat.make ());
|]
