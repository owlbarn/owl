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


let to_string = function
  | Reci x      -> Reci.to_string x
  | Abs x       -> Abs.to_string x
  | Abs2 x      -> Abs2.to_string x
  | Signum x    -> Signum.to_string x
  | Sqr x       -> Sqr.to_string x
  | Sqrt x      -> Sqrt.to_string x
  | Cbrt x      -> Cbrt.to_string x
  | Exp x       -> Exp.to_string x
  | Expm1 x     -> Expm1.to_string x
  | Log x       -> Log.to_string x
  | Log1p x     -> Log1p.to_string x
  | Sin x       -> Sin.to_string x
  | Cos x       -> Cos.to_string x
  | Tan x       -> Tan.to_string x
  | Asin x      -> Asin.to_string x
  | Acos x      -> Acos.to_string x
  | Atan x      -> Atan.to_string x
  | Sinh x      -> Sinh.to_string x
  | Cosh x      -> Cosh.to_string x
  | Tanh x      -> Tanh.to_string x
  | Asinh x     -> Asinh.to_string x
  | Acosh x     -> Acosh.to_string x
  | Atanh x     -> Atanh.to_string x
  | Erf x       -> Erf.to_string x
  | Erfc x      -> Erfc.to_string x
  | Logistic x  -> Logistic.to_string x
  | Relu x      -> Relu.to_string x
  | Softplus x  -> Softplus.to_string x
  | Softsign x  -> Softsign.to_string x
  | Sigmoid x   -> Sigmoid.to_string x
  | Elt_equal x -> Elt_equal.to_string x
  | Add x       -> Add.to_string x
  | Mul x       -> Mul.to_string x
  | Div x       -> Div.to_string x
  | Pow x       -> Pow.to_string x
  | Hypot x     -> Hypot.to_string x
  | Atan2 x     -> Atan2.to_string x
  | Max2 x      -> Max2.to_string x
  | Fmod x      -> Fmod.to_string x
  | Sum x       -> Sum.to_string x
  | Prod x      -> Prod.to_string x
  | Cumsum x    -> Cumsum.to_string x
  | Cumprod x   -> Cumprod.to_string x


let plot = function
  | Reci x      -> Reci.plot x
  | Abs x       -> Abs.plot x
  | Abs2 x      -> Abs2.plot x
  | Signum x    -> Signum.plot x
  | Sqr x       -> Sqr.plot x
  | Sqrt x      -> Sqrt.plot x
  | Cbrt x      -> Cbrt.plot x
  | Exp x       -> Exp.plot x
  | Expm1 x     -> Expm1.plot x
  | Log x       -> Log.plot x
  | Log1p x     -> Log1p.plot x
  | Sin x       -> Sin.plot x
  | Cos x       -> Cos.plot x
  | Tan x       -> Tan.plot x
  | Asin x      -> Asin.plot x
  | Acos x      -> Acos.plot x
  | Atan x      -> Atan.plot x
  | Sinh x      -> Sinh.plot x
  | Cosh x      -> Cosh.plot x
  | Tanh x      -> Tanh.plot x
  | Asinh x     -> Asinh.plot x
  | Acosh x     -> Acosh.plot x
  | Atanh x     -> Atanh.plot x
  | Erf x       -> Erf.plot x
  | Erfc x      -> Erfc.plot x
  | Logistic x  -> Logistic.plot x
  | Relu x      -> Relu.plot x
  | Softplus x  -> Softplus.plot x
  | Softsign x  -> Softsign.plot x
  | Sigmoid x   -> Sigmoid.plot x
  | Elt_equal x -> Elt_equal.plot x
  | Add x       -> Add.plot x
  | Mul x       -> Mul.plot x
  | Div x       -> Div.plot x
  | Pow x       -> Pow.plot x
  | Hypot x     -> Hypot.plot x
  | Atan2 x     -> Atan2.plot x
  | Max2 x      -> Max2.plot x
  | Fmod x      -> Fmod.plot x
  | Sum x       -> Sum.plot x
  | Prod x      -> Prod.plot x
  | Cumsum x    -> Cumsum.plot x
  | Cumprod x   -> Cumprod.plot x


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
|]
