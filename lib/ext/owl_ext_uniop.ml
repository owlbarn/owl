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
  let neg x = F M.(neg x)
  let reci x = F M.(reci x)
  let signum x = F M.(signum x)
  let sqr x = F (x *. x)
  let sqrt x = F M.(sqrt x)

end


module C = struct

  module M = Complex

end


module DAS = struct

  module M = Owl_ext_dense_ndarray_s

  let min x = M.min x
  let max x = M.max x
  let minmx x = M.minmax x
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

  module M = Owl_ext_dense_ndarray_d

  let min x = M.min x
  let max x = M.max x
  let minmx x = M.minmax x
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

  module M = Owl_ext_dense_matrix_s

  let min x = M.min x
  let max x = M.max x
  let minmx x = M.minmax x
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


module DMD = struct

  module M = Owl_ext_dense_matrix_d

  let min x = M.min x
  let max x = M.max x
  let minmx x = M.minmax x
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


module DAC = struct

  module M = Owl_ext_dense_ndarray_c

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

  module M = Owl_ext_dense_ndarray_z

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

  module M = Owl_ext_dense_matrix_c

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


module DMZ = struct

  module M = Owl_ext_dense_matrix_z

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


(* overload uniary operators *)

let abs x = match x with
  | DAS _ -> DAS.abs x
  | DAD _ -> DAD.abs x
  | DMS _ -> DMS.abs x
  | DMD _ -> DMD.abs x
  | _     -> error_uniop "abs" x


(* ends here *)
