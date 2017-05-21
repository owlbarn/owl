(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_ext_types


(* error handling *)

let error_uniop op x =
  let s = type_info x in
  failwith (op ^ " : " ^ s)


(* trivial cases *)

module F = struct

  module M = Owl_maths

  let abs x = F M.(abs x)
  let abs2 x = F M.(x *. x)
  let neg x = F M.(neg x)
  let reci x = F M.(reci x)
  let signum x = F M.(signum x)
  let sqr x = F (x *. x)
  let sqrt x = F M.(sqrt x)
  let exp x = F M.(exp x)
  let expm1 x = F M.(expm1 x)
  let log x = F M.(log x)
  let log10 x = F M.(log10 x)
  let log2 x = F M.(log2 x)
  let log1p x = F M.(log1p x)
  let sin x = F M.(sin x)
  let cos x = F M.(cos x)
  let tan x = F M.(tan x)
  let asin x = F M.(asin x)
  let acos x = F M.(acos x)
  let atan x = F M.(atan x)
  let sinh x = F M.(sinh x)
  let cosh x = F M.(cosh x)
  let tanh x = F M.(tanh x)
  let asinh x = F M.(asinh x)
  let acosh x = F M.(acosh x)
  let atanh x = F M.(atanh x)
  let floor x = F M.(floor x)
  let ceil x = F M.(ceil x)
  let round x = F M.(round x)
  let trunc x = F M.(trunc x)
  let relu x = F M.(relu x)
  let sigmoid x = F M.(sigmoid x)

end


module C = struct

  module M = Complex

  let re x = F M.(x.re)
  let im x = F M.(x.im)
  let abs x = F M.(norm x)
  let abs2 x = F M.(norm2 x)
  let conj x = C M.(conj x)
  let neg x = C M.(neg x)
  let reci x = C M.(inv x)

end


module DAS = struct

  module M = Owl_ext_dense_ndarray.S

  let min x = M.min x
  let max x = M.max x
  let minmax x = M.minmax x
  let min_i x = M.min_i x
  let max_i x = M.max_i x
  let minmax_i x = M.minmax_i x
  let sum x = M.sum x
  let prod x = M.prod x
  let abs x = M.abs x
  let abs2 x = M.abs2 x
  let neg x = M.neg x
  let reci x = M.reci x
  let signum x = M.signum x
  let sqr x = M.sqr x
  let sqrt x = M.sqrt x
  let cbrt x = M.cbrt x
  let exp x = M.exp x
  let exp2 x = M.exp2 x
  let expm1 x = M.expm1 x
  let log x = M.log x
  let log10 x = M.log10 x
  let log2 x = M.log2 x
  let log1p x = M.log1p x
  let sin x = M.sin x
  let cos x = M.cos x
  let tan x = M.tan x
  let asin x = M.asin x
  let acos x = M.acos x
  let atan x = M.atan x
  let sinh x = M.sinh x
  let cosh x = M.cosh x
  let tanh x = M.tanh x
  let asinh x = M.asinh x
  let acosh x = M.acosh x
  let atanh x = M.atanh x
  let floor x = M.floor x
  let ceil x = M.ceil x
  let round x = M.round x
  let trunc x = M.trunc x
  let erf x = M.erf x
  let erfc x = M.erfc x
  let logistic x = M.logistic x
  let relu x = M.relu x
  let softplus x = M.softplus x
  let softsign x = M.softsign x
  let softmax x = M.softmax x
  let sigmoid x = M.sigmoid x
  let log_sum_exp x = M.log_sum_exp x
  let l1norm x = M.l1norm x
  let l2norm x = M.l2norm x
  let l2norm_sqr x = M.l2norm_sqr x

end


module DAD = struct

  module M = Owl_ext_dense_ndarray.D

  let min x = M.min x
  let max x = M.max x
  let minmax x = M.minmax x
  let min_i x = M.min_i x
  let max_i x = M.max_i x
  let minmax_i x = M.minmax_i x
  let sum x = M.sum x
  let prod x = M.prod x
  let abs x = M.abs x
  let abs2 x = M.abs2 x
  let neg x = M.neg x
  let reci x = M.reci x
  let signum x = M.signum x
  let sqr x = M.sqr x
  let sqrt x = M.sqrt x
  let cbrt x = M.cbrt x
  let exp x = M.exp x
  let exp2 x = M.exp2 x
  let expm1 x = M.expm1 x
  let log x = M.log x
  let log10 x = M.log10 x
  let log2 x = M.log2 x
  let log1p x = M.log1p x
  let sin x = M.sin x
  let cos x = M.cos x
  let tan x = M.tan x
  let asin x = M.asin x
  let acos x = M.acos x
  let atan x = M.atan x
  let sinh x = M.sinh x
  let cosh x = M.cosh x
  let tanh x = M.tanh x
  let asinh x = M.asinh x
  let acosh x = M.acosh x
  let atanh x = M.atanh x
  let floor x = M.floor x
  let ceil x = M.ceil x
  let round x = M.round x
  let trunc x = M.trunc x
  let erf x = M.erf x
  let erfc x = M.erfc x
  let logistic x = M.logistic x
  let relu x = M.relu x
  let softplus x = M.softplus x
  let softsign x = M.softsign x
  let softmax x = M.softmax x
  let sigmoid x = M.sigmoid x
  let log_sum_exp x = M.log_sum_exp x
  let l1norm x = M.l1norm x
  let l2norm x = M.l2norm x
  let l2norm_sqr x = M.l2norm_sqr x

end


module DMS = struct

  module M = Owl_ext_dense_matrix.S

  let min x = M.min x
  let max x = M.max x
  let minmax x = M.minmax x
  let min_i x = M.min_i x
  let max_i x = M.max_i x
  let minmax_i x = M.minmax_i x
  let inv x = M.inv x
  let trace x = M.trace x
  let sum x = M.sum x
  let prod x = M.prod x
  let abs x = M.abs x
  let abs2 x = M.abs2 x
  let neg x = M.neg x
  let reci x = M.reci x
  let signum x = M.signum x
  let sqr x = M.sqr x
  let sqrt x = M.sqrt x
  let cbrt x = M.cbrt x
  let exp x = M.exp x
  let exp2 x = M.exp2 x
  let expm1 x = M.expm1 x
  let log x = M.log x
  let log10 x = M.log10 x
  let log2 x = M.log2 x
  let log1p x = M.log1p x
  let sin x = M.sin x
  let cos x = M.cos x
  let tan x = M.tan x
  let asin x = M.asin x
  let acos x = M.acos x
  let atan x = M.atan x
  let sinh x = M.sinh x
  let cosh x = M.cosh x
  let tanh x = M.tanh x
  let asinh x = M.asinh x
  let acosh x = M.acosh x
  let atanh x = M.atanh x
  let floor x = M.floor x
  let ceil x = M.ceil x
  let round x = M.round x
  let trunc x = M.trunc x
  let erf x = M.erf x
  let erfc x = M.erfc x
  let logistic x = M.logistic x
  let relu x = M.relu x
  let softplus x = M.softplus x
  let softsign x = M.softsign x
  let softmax x = M.softmax x
  let sigmoid x = M.sigmoid x
  let log_sum_exp x = M.log_sum_exp x
  let l1norm x = M.l1norm x
  let l2norm x = M.l2norm x
  let l2norm_sqr x = M.l2norm_sqr x

end


module DMD = struct

  module M = Owl_ext_dense_matrix.D

  let min x = M.min x
  let max x = M.max x
  let minmax x = M.minmax x
  let min_i x = M.min_i x
  let max_i x = M.max_i x
  let minmax_i x = M.minmax_i x
  let inv x = M.inv x
  let trace x = M.trace x
  let sum x = M.sum x
  let prod x = M.prod x
  let abs x = M.abs x
  let abs2 x = M.abs2 x
  let neg x = M.neg x
  let reci x = M.reci x
  let signum x = M.signum x
  let sqr x = M.sqr x
  let sqrt x = M.sqrt x
  let cbrt x = M.cbrt x
  let exp x = M.exp x
  let exp2 x = M.exp2 x
  let expm1 x = M.expm1 x
  let log x = M.log x
  let log10 x = M.log10 x
  let log2 x = M.log2 x
  let log1p x = M.log1p x
  let sin x = M.sin x
  let cos x = M.cos x
  let tan x = M.tan x
  let asin x = M.asin x
  let acos x = M.acos x
  let atan x = M.atan x
  let sinh x = M.sinh x
  let cosh x = M.cosh x
  let tanh x = M.tanh x
  let asinh x = M.asinh x
  let acosh x = M.acosh x
  let atanh x = M.atanh x
  let floor x = M.floor x
  let ceil x = M.ceil x
  let round x = M.round x
  let trunc x = M.trunc x
  let erf x = M.erf x
  let erfc x = M.erfc x
  let logistic x = M.logistic x
  let relu x = M.relu x
  let softplus x = M.softplus x
  let softsign x = M.softsign x
  let softmax x = M.softmax x
  let sigmoid x = M.sigmoid x
  let log_sum_exp x = M.log_sum_exp x
  let l1norm x = M.l1norm x
  let l2norm x = M.l2norm x
  let l2norm_sqr x = M.l2norm_sqr x

end


module DAC = struct

  module M = Owl_ext_dense_ndarray.C

  let re x = M.re x
  let im x = M.im x
  let sum x = M.sum x
  let prod x = M.prod x
  let abs x = M.abs x
  let abs2 x = M.abs2 x
  let conj x = M.conj x
  let neg x = M.neg x
  let reci x = M.reci x
  let l1norm x = M.l1norm x
  let l2norm x = M.l2norm x
  let l2norm_sqr x = M.l2norm_sqr x

end


module DAZ = struct

  module M = Owl_ext_dense_ndarray.Z

  let re x = M.re x
  let im x = M.im x
  let sum x = M.sum x
  let prod x = M.prod x
  let abs x = M.abs x
  let abs2 x = M.abs2 x
  let conj x = M.conj x
  let neg x = M.neg x
  let reci x = M.reci x
  let l1norm x = M.l1norm x
  let l2norm x = M.l2norm x
  let l2norm_sqr x = M.l2norm_sqr x

end


module DMC = struct

  module M = Owl_ext_dense_matrix.C

  let re x = M.re x
  let im x = M.im x
  let inv x = M.inv x
  let trace x = M.trace x
  let sum x = M.sum x
  let prod x = M.prod x
  let abs x = M.abs x
  let abs2 x = M.abs2 x
  let conj x = M.conj x
  let neg x = M.neg x
  let reci x = M.reci x
  let l1norm x = M.l1norm x
  let l2norm x = M.l2norm x
  let l2norm_sqr x = M.l2norm_sqr x

end


module DMZ = struct

  module M = Owl_ext_dense_matrix.Z

  let re x = M.re x
  let im x = M.im x
  let inv x = M.inv x
  let trace x = M.trace x
  let sum x = M.sum x
  let prod x = M.prod x
  let abs x = M.abs x
  let abs2 x = M.abs2 x
  let conj x = M.conj x
  let neg x = M.neg x
  let reci x = M.reci x
  let l1norm x = M.l1norm x
  let l2norm x = M.l2norm x
  let l2norm_sqr x = M.l2norm_sqr x

end


(* overload uniary operators *)

let re x = match x with
  | C x   -> C.re x
  | DAC _ -> DAC.re x
  | DAZ _ -> DAZ.re x
  | DMC _ -> DMC.re x
  | DMZ _ -> DMZ.re x
  | _     -> error_uniop "re" x

let im x = match x with
  | C x   -> C.im x
  | DAC _ -> DAC.im x
  | DAZ _ -> DAZ.im x
  | DMC _ -> DMC.im x
  | DMZ _ -> DMZ.im x
  | _     -> error_uniop "im" x

let conj x = match x with
  | C x   -> C.conj x
  | DAC _ -> DAC.conj x
  | DAZ _ -> DAZ.conj x
  | DMC _ -> DMC.conj x
  | DMZ _ -> DMZ.conj x
  | _     -> error_uniop "conj" x

let min x = match x with
  | DAS _ -> DAS.min x
  | DAD _ -> DAD.min x
  | DMS _ -> DMS.min x
  | DMD _ -> DMD.min x
  | _     -> error_uniop "min" x

let max x = match x with
  | DAS _ -> DAS.max x
  | DAD _ -> DAD.max x
  | DMS _ -> DMS.max x
  | DMD _ -> DMD.max x
  | _     -> error_uniop "max" x

let minmax x = match x with
  | DAS _ -> DAS.minmax x
  | DAD _ -> DAD.minmax x
  | DMS _ -> DMS.minmax x
  | DMD _ -> DMD.minmax x
  | _     -> error_uniop "minmax" x

let min_i x = match x with
  | DAS _ -> DAS.min_i x
  | DAD _ -> DAD.min_i x
  | DMS _ -> DMS.min_i x
  | DMD _ -> DMD.min_i x
  | _     -> error_uniop "min_i" x

let max_i x = match x with
  | DAS _ -> DAS.max_i x
  | DAD _ -> DAD.max_i x
  | DMS _ -> DMS.max_i x
  | DMD _ -> DMD.max_i x
  | _     -> error_uniop "max_i" x

let minmax_i x = match x with
  | DAS _ -> DAS.minmax_i x
  | DAD _ -> DAD.minmax_i x
  | DMS _ -> DMS.minmax_i x
  | DMD _ -> DMD.minmax_i x
  | _     -> error_uniop "minmax_i" x

let inv x = match x with
  | DMS _ -> DMS.inv x
  | DMD _ -> DMD.inv x
  | DMC _ -> DMC.inv x
  | DMZ _ -> DMZ.inv x
  | _     -> error_uniop "inv" x

let trace x = match x with
  | DMS _ -> DMS.trace x
  | DMD _ -> DMD.trace x
  | DMC _ -> DMC.trace x
  | DMZ _ -> DMZ.trace x
  | _     -> error_uniop "trace" x

let sum x = match x with
  | DAS _ -> DAS.sum x
  | DAD _ -> DAD.sum x
  | DMS _ -> DMS.sum x
  | DMD _ -> DMD.sum x
  | DAC _ -> DAC.sum x
  | DAZ _ -> DAZ.sum x
  | DMC _ -> DMC.sum x
  | DMZ _ -> DMZ.sum x
  | _     -> error_uniop "sum" x

let prod x = match x with
  | DAS _ -> DAS.prod x
  | DAD _ -> DAD.prod x
  | DMS _ -> DMS.prod x
  | DMD _ -> DMD.prod x
  | DAC _ -> DAC.prod x
  | DAZ _ -> DAZ.prod x
  | DMC _ -> DMC.prod x
  | DMZ _ -> DMZ.prod x
  | _     -> error_uniop "prod" x

let abs x = match x with
  | F x   -> F.abs x
  | C x   -> C.abs x
  | DAS _ -> DAS.abs x
  | DAD _ -> DAD.abs x
  | DMS _ -> DMS.abs x
  | DMD _ -> DMD.abs x
  | DAC _ -> DAC.abs x
  | DAZ _ -> DAZ.abs x
  | DMC _ -> DMC.abs x
  | DMZ _ -> DMZ.abs x
  | _     -> error_uniop "abs" x

let abs2 x = match x with
  | F x   -> F.abs2 x
  | C x   -> C.abs2 x
  | DAS _ -> DAS.abs2 x
  | DAD _ -> DAD.abs2 x
  | DMS _ -> DMS.abs2 x
  | DMD _ -> DMD.abs2 x
  | DAC _ -> DAC.abs2 x
  | DAZ _ -> DAZ.abs2 x
  | DMC _ -> DMC.abs2 x
  | DMZ _ -> DMZ.abs2 x
  | _     -> error_uniop "abs2" x

let neg x = match x with
  | F x   -> F.neg x
  | C x   -> C.neg x
  | DAS _ -> DAS.neg x
  | DAD _ -> DAD.neg x
  | DMS _ -> DMS.neg x
  | DMD _ -> DMD.neg x
  | DAC _ -> DAC.neg x
  | DAZ _ -> DAZ.neg x
  | DMC _ -> DMC.neg x
  | DMZ _ -> DMZ.neg x
  | _     -> error_uniop "neg" x

let reci x = match x with
  | F x   -> F.reci x
  | C x   -> C.reci x
  | DAS _ -> DAS.reci x
  | DAD _ -> DAD.reci x
  | DMS _ -> DMS.reci x
  | DMD _ -> DMD.reci x
  | _     -> error_uniop "reci" x

let signum x = match x with
  | F x   -> F.signum x
  | DAS _ -> DAS.signum x
  | DAD _ -> DAD.signum x
  | DMS _ -> DMS.signum x
  | DMD _ -> DMD.signum x
  | _     -> error_uniop "signum" x

let sqr x = match x with
  | F x   -> F.sqr x
  | DAS _ -> DAS.sqr x
  | DAD _ -> DAD.sqr x
  | DMS _ -> DMS.sqr x
  | DMD _ -> DMD.sqr x
  | _     -> error_uniop "sqr" x

let sqrt x = match x with
  | F x   -> F.sqrt x
  | DAS _ -> DAS.sqrt x
  | DAD _ -> DAD.sqrt x
  | DMS _ -> DMS.sqrt x
  | DMD _ -> DMD.sqrt x
  | _     -> error_uniop "sqrt" x

let cbrt x = match x with
  | DAS _ -> DAS.cbrt x
  | DAD _ -> DAD.cbrt x
  | DMS _ -> DMS.cbrt x
  | DMD _ -> DMD.cbrt x
  | _     -> error_uniop "cbrt" x

let exp x = match x with
  | F x   -> F.exp x
  | DAS _ -> DAS.exp x
  | DAD _ -> DAD.exp x
  | DMS _ -> DMS.exp x
  | DMD _ -> DMD.exp x
  | _     -> error_uniop "exp" x

let exp2 x = match x with
  | DAS _ -> DAS.exp2 x
  | DAD _ -> DAD.exp2 x
  | DMS _ -> DMS.exp2 x
  | DMD _ -> DMD.exp2 x
  | _     -> error_uniop "exp2" x

let expm1 x = match x with
  | F x   -> F.expm1 x
  | DAS _ -> DAS.expm1 x
  | DAD _ -> DAD.expm1 x
  | DMS _ -> DMS.expm1 x
  | DMD _ -> DMD.expm1 x
  | _     -> error_uniop "expm1" x

let log x = match x with
  | F x   -> F.log x
  | DAS _ -> DAS.log x
  | DAD _ -> DAD.log x
  | DMS _ -> DMS.log x
  | DMD _ -> DMD.log x
  | _     -> error_uniop "log" x

let log10 x = match x with
  | F x   -> F.log10 x
  | DAS _ -> DAS.log10 x
  | DAD _ -> DAD.log10 x
  | DMS _ -> DMS.log10 x
  | DMD _ -> DMD.log10 x
  | _     -> error_uniop "log10" x

let log2 x = match x with
  | F x   -> F.log2 x
  | DAS _ -> DAS.log2 x
  | DAD _ -> DAD.log2 x
  | DMS _ -> DMS.log2 x
  | DMD _ -> DMD.log2 x
  | _     -> error_uniop "log2" x

let log1p x = match x with
  | F x   -> F.log1p x
  | DAS _ -> DAS.log1p x
  | DAD _ -> DAD.log1p x
  | DMS _ -> DMS.log1p x
  | DMD _ -> DMD.log1p x
  | _     -> error_uniop "log1p" x

let sin x = match x with
  | F x   -> F.sin x
  | DAS _ -> DAS.sin x
  | DAD _ -> DAD.sin x
  | DMS _ -> DMS.sin x
  | DMD _ -> DMD.sin x
  | _     -> error_uniop "sin" x

let cos x = match x with
  | F x   -> F.cos x
  | DAS _ -> DAS.cos x
  | DAD _ -> DAD.cos x
  | DMS _ -> DMS.cos x
  | DMD _ -> DMD.cos x
  | _     -> error_uniop "cos" x

let tan x = match x with
  | F x   -> F.tan x
  | DAS _ -> DAS.tan x
  | DAD _ -> DAD.tan x
  | DMS _ -> DMS.tan x
  | DMD _ -> DMD.tan x
  | _     -> error_uniop "tan" x

let asin x = match x with
  | F x   -> F.asin x
  | DAS _ -> DAS.asin x
  | DAD _ -> DAD.asin x
  | DMS _ -> DMS.asin x
  | DMD _ -> DMD.asin x
  | _     -> error_uniop "asin" x

let acos x = match x with
  | F x   -> F.acos x
  | DAS _ -> DAS.acos x
  | DAD _ -> DAD.acos x
  | DMS _ -> DMS.acos x
  | DMD _ -> DMD.acos x
  | _     -> error_uniop "acos" x

let atan x = match x with
  | F x   -> F.atan x
  | DAS _ -> DAS.atan x
  | DAD _ -> DAD.atan x
  | DMS _ -> DMS.atan x
  | DMD _ -> DMD.atan x
  | _     -> error_uniop "atan" x

let sinh x = match x with
  | F x   -> F.sinh x
  | DAS _ -> DAS.sinh x
  | DAD _ -> DAD.sinh x
  | DMS _ -> DMS.sinh x
  | DMD _ -> DMD.sinh x
  | _     -> error_uniop "sinh" x

let cosh x = match x with
  | F x   -> F.cosh x
  | DAS _ -> DAS.cosh x
  | DAD _ -> DAD.cosh x
  | DMS _ -> DMS.cosh x
  | DMD _ -> DMD.cosh x
  | _     -> error_uniop "cosh" x

let tanh x = match x with
  | F x   -> F.tanh x
  | DAS _ -> DAS.tanh x
  | DAD _ -> DAD.tanh x
  | DMS _ -> DMS.tanh x
  | DMD _ -> DMD.tanh x
  | _     -> error_uniop "tanh" x

let asinh x = match x with
  | F x   -> F.asinh x
  | DAS _ -> DAS.asinh x
  | DAD _ -> DAD.asinh x
  | DMS _ -> DMS.asinh x
  | DMD _ -> DMD.asinh x
  | _     -> error_uniop "asinh" x

let acosh x = match x with
  | F x   -> F.acosh x
  | DAS _ -> DAS.acosh x
  | DAD _ -> DAD.acosh x
  | DMS _ -> DMS.acosh x
  | DMD _ -> DMD.acosh x
  | _     -> error_uniop "acosh" x

let atanh x = match x with
  | F x   -> F.atanh x
  | DAS _ -> DAS.atanh x
  | DAD _ -> DAD.atanh x
  | DMS _ -> DMS.atanh x
  | DMD _ -> DMD.atanh x
  | _     -> error_uniop "atanh" x

let floor x = match x with
  | F x   -> F.floor x
  | DAS _ -> DAS.floor x
  | DAD _ -> DAD.floor x
  | DMS _ -> DMS.floor x
  | DMD _ -> DMD.floor x
  | _     -> error_uniop "floor" x

let ceil x = match x with
  | F x   -> F.ceil x
  | DAS _ -> DAS.ceil x
  | DAD _ -> DAD.ceil x
  | DMS _ -> DMS.ceil x
  | DMD _ -> DMD.ceil x
  | _     -> error_uniop "ceil" x

let round x = match x with
  | F x   -> F.round x
  | DAS _ -> DAS.round x
  | DAD _ -> DAD.round x
  | DMS _ -> DMS.round x
  | DMD _ -> DMD.round x
  | _     -> error_uniop "round" x

let trunc x = match x with
  | F x   -> F.trunc x
  | DAS _ -> DAS.trunc x
  | DAD _ -> DAD.trunc x
  | DMS _ -> DMS.trunc x
  | DMD _ -> DMD.trunc x
  | _     -> error_uniop "trunc" x

let erf x = match x with
  | DAS _ -> DAS.erf x
  | DAD _ -> DAD.erf x
  | DMS _ -> DMS.erf x
  | DMD _ -> DMD.erf x
  | _     -> error_uniop "erf" x

let erfc x = match x with
  | DAS _ -> DAS.erfc x
  | DAD _ -> DAD.erfc x
  | DMS _ -> DMS.erfc x
  | DMD _ -> DMD.erfc x
  | _     -> error_uniop "erfc" x

let logistic x = match x with
  | DAS _ -> DAS.logistic x
  | DAD _ -> DAD.logistic x
  | DMS _ -> DMS.logistic x
  | DMD _ -> DMD.logistic x
  | _     -> error_uniop "logistic" x

let relu x = match x with
  | F x   -> F.relu x
  | DAS _ -> DAS.relu x
  | DAD _ -> DAD.relu x
  | DMS _ -> DMS.relu x
  | DMD _ -> DMD.relu x
  | _     -> error_uniop "relu" x

let softplus x = match x with
  | DAS _ -> DAS.softplus x
  | DAD _ -> DAD.softplus x
  | DMS _ -> DMS.softplus x
  | DMD _ -> DMD.softplus x
  | _     -> error_uniop "softplus" x

let softsign x = match x with
  | DAS _ -> DAS.softsign x
  | DAD _ -> DAD.softsign x
  | DMS _ -> DMS.softsign x
  | DMD _ -> DMD.softsign x
  | _     -> error_uniop "softsign" x

let softmax x = match x with
  | DAS _ -> DAS.softmax x
  | DAD _ -> DAD.softmax x
  | DMS _ -> DMS.softmax x
  | DMD _ -> DMD.softmax x
  | _     -> error_uniop "softmax" x

let sigmoid x = match x with
  | F x   -> F.sigmoid x
  | DAS _ -> DAS.sigmoid x
  | DAD _ -> DAD.sigmoid x
  | DMS _ -> DMS.sigmoid x
  | DMD _ -> DMD.sigmoid x
  | _     -> error_uniop "sigmoid" x

let log_sum_exp x = match x with
  | DAS _ -> DAS.log_sum_exp x
  | DAD _ -> DAD.log_sum_exp x
  | DMS _ -> DMS.log_sum_exp x
  | DMD _ -> DMD.log_sum_exp x
  | _     -> error_uniop "log_sum_exp" x

let l1norm x = match x with
  | DAS _ -> DAS.l1norm x
  | DAD _ -> DAD.l1norm x
  | DMS _ -> DMS.l1norm x
  | DMD _ -> DMD.l1norm x
  | DAC _ -> DAC.l1norm x
  | DAZ _ -> DAZ.l1norm x
  | DMC _ -> DMC.l1norm x
  | DMZ _ -> DMZ.l1norm x
  | _     -> error_uniop "l1norm" x

let l2norm x = match x with
  | DAS _ -> DAS.l2norm x
  | DAD _ -> DAD.l2norm x
  | DMS _ -> DMS.l2norm x
  | DMD _ -> DMD.l2norm x
  | DAC _ -> DAC.l2norm x
  | DAZ _ -> DAZ.l2norm x
  | DMC _ -> DMC.l2norm x
  | DMZ _ -> DMZ.l2norm x
  | _     -> error_uniop "l2norm" x

let l2norm_sqr x = match x with
  | DAS _ -> DAS.l2norm_sqr x
  | DAD _ -> DAD.l2norm_sqr x
  | DMS _ -> DMS.l2norm_sqr x
  | DMD _ -> DMD.l2norm_sqr x
  | DAC _ -> DAC.l2norm_sqr x
  | DAZ _ -> DAZ.l2norm_sqr x
  | DMC _ -> DMC.l2norm_sqr x
  | DMZ _ -> DMZ.l2norm_sqr x
  | _     -> error_uniop "l2norm_sqr" x

(* ends here *)
