(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Define the types shared by various modules *)

open Bigarray


(* type of slice definition *)

type index =
  | I of int       (* single index *)
  | L of int list  (* list of indices *)
  | R of int list  (* index range *)

type slice = index list

(* type of slice definition for internal use in owl_slicing module *)

type index_ =
  | I_ of int
  | L_ of int array
  | R_ of int array

type slice_ = index_ array

(* type of padding in conv?d and maxpool operations *)

type padding = SAME | VALID


(* define some constants *)

let _zero : type a b. (a, b) kind -> a = function
  | Float32 -> 0.0 | Complex32 -> Complex.zero
  | Float64 -> 0.0 | Complex64 -> Complex.zero
  | Int8_signed -> 0 | Int8_unsigned -> 0
  | Int16_signed -> 0 | Int16_unsigned -> 0
  | Int32 -> 0l | Int64 -> 0L
  | Int -> 0 | Nativeint -> 0n
  | Char -> '\000'

let _one : type a b. (a, b) kind -> a = function
  | Float32 -> 1.0 | Complex32 -> Complex.one
  | Float64 -> 1.0 | Complex64 -> Complex.one
  | Int8_signed -> 1 | Int8_unsigned -> 1
  | Int16_signed -> 1 | Int16_unsigned -> 1
  | Int32 -> 1l | Int64 -> 1L
  | Int -> 1 | Nativeint -> 1n
  | Char -> '\001'

let _pos_inf : type a b. (a, b) kind -> a = function
  | Float32   -> infinity
  | Float64   -> infinity
  | Complex32 -> Complex.({re = infinity; im = infinity})
  | Complex64 -> Complex.({re = infinity; im = infinity})
  | _         -> failwith "_pos_inf: unsupported operation"

let _neg_inf : type a b. (a, b) kind -> a = function
  | Float32   -> neg_infinity
  | Float64   -> neg_infinity
  | Complex32 -> Complex.({re = neg_infinity; im = neg_infinity})
  | Complex64 -> Complex.({re = neg_infinity; im = neg_infinity})
  | _         -> failwith "_neg_inf: unsupported operation"


(* Module Signature for Ndarray *)

module type NdarraySig = sig

  type arr

  type elt = float

  (* creation and operation functions *)

  val empty : int array -> arr

  val zeros : int array -> arr

  val ones : int array -> arr

  val uniform : ?a:elt -> ?b:elt -> int array -> arr

  val gaussian : ?mu:elt -> ?sigma:elt -> int array -> arr

  val bernoulli : ?p:float -> int array -> arr

  val shape : arr -> int array

  val numel : arr -> int

  val get : arr -> int array -> elt

  val set : arr -> int array -> elt -> unit

  val get_fancy : index list -> arr -> arr

  val set_fancy : index list -> arr -> arr -> unit

  val copy : arr -> arr

  val reset : arr -> unit

  val reshape : arr -> int array -> arr

  val tile : arr -> int array -> arr

  val repeat : ?axis:int -> arr -> int -> arr

  val concatenate : ?axis:int -> arr array -> arr

  val split : ?axis:int -> int array -> arr -> arr array

  val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:(elt -> string) -> arr -> unit

  val draw_along_dim0 : arr -> int -> arr * int array

  (* mathematical functions *)

  val abs : arr -> arr

  val neg : arr -> arr

  val floor : arr -> arr

  val ceil : arr -> arr

  val round : arr -> arr

  val sqr : arr -> arr

  val sqrt : arr -> arr

  val log : arr -> arr

  val log2 : arr -> arr

  val log10 : arr -> arr

  val exp : arr -> arr

  val sin : arr -> arr

  val cos : arr -> arr

  val tan : arr -> arr

  val sinh : arr -> arr

  val cosh : arr -> arr

  val tanh : arr -> arr

  val asin : arr -> arr

  val acos : arr -> arr

  val atan : arr -> arr

  val asinh : arr -> arr

  val acosh : arr -> arr

  val atanh : arr -> arr

  val sum : ?axis:int -> arr -> arr

  val sum_slices : ?axis:int -> arr -> arr

  val signum : arr -> arr

  val sigmoid : arr -> arr

  val relu : arr -> arr

  val min' : arr -> elt

  val max' : arr -> elt

  val sum' : arr -> elt

  val l1norm' : arr -> elt

  val l2norm' : arr -> elt

  val l2norm_sqr' : arr -> elt

  val clip_by_l2norm : elt -> arr -> arr

  val pow : arr -> arr -> arr

  val scalar_pow : elt -> arr -> arr

  val pow_scalar : arr -> elt -> arr

  val atan2 : arr -> arr -> arr

  val scalar_atan2 : elt -> arr -> arr

  val atan2_scalar : arr -> elt -> arr

  val add : arr -> arr -> arr

  val sub : arr -> arr -> arr

  val mul : arr -> arr -> arr

  val div : arr -> arr -> arr

  val add_scalar : arr -> elt -> arr

  val sub_scalar : arr -> elt -> arr

  val mul_scalar : arr -> elt -> arr

  val div_scalar : arr -> elt -> arr

  val scalar_add : elt -> arr -> arr

  val scalar_sub : elt -> arr -> arr

  val scalar_mul : elt -> arr -> arr

  val scalar_div : elt -> arr -> arr

  val elt_greater_equal_scalar : arr -> elt -> arr

  (* Neural network related functions *)

  val conv1d : ?padding:padding -> arr -> arr -> int array -> arr

  val conv2d : ?padding:padding -> arr -> arr -> int array -> arr

  val conv3d : ?padding:padding -> arr -> arr -> int array -> arr

  val max_pool1d : ?padding:padding -> arr -> int array -> int array -> arr

  val max_pool2d : ?padding:padding -> arr -> int array -> int array -> arr

  val max_pool3d : ?padding:padding -> arr -> int array -> int array -> arr

  val avg_pool1d : ?padding:padding -> arr -> int array -> int array -> arr

  val avg_pool2d : ?padding:padding -> arr -> int array -> int array -> arr

  val avg_pool3d : ?padding:padding -> arr -> int array -> int array -> arr

  val conv1d_backward_input : arr -> arr -> int array -> arr -> arr

  val conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr

  val conv2d_backward_input : arr -> arr -> int array -> arr -> arr

  val conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr

  val conv3d_backward_input : arr -> arr -> int array -> arr -> arr

  val conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr

  val max_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr

  val max_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr

  val avg_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr

  val avg_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr

  (* matrix functions *)

  val row_num : arr -> int

  val col_num : arr -> int

  val row : arr -> int -> arr

  val rows : arr -> int array -> arr

  val copy_row_to : arr -> arr -> int -> unit

  val copy_col_to : arr -> arr -> int -> unit

  val dot : arr -> arr -> arr

  val inv : arr -> arr

  val trace : arr -> elt

  val transpose : ?axis:int array -> arr -> arr

  val to_rows : arr -> arr array

  val of_rows : arr array -> arr

  val of_arrays : elt array array -> arr

  val draw_rows : ?replacement:bool -> arr -> int -> arr * int array

  val draw_rows2 : ?replacement:bool -> arr -> arr -> int -> arr * arr * int array

end


module type NdarraySig_Ext = sig

  include NdarraySig

  val equal : arr -> arr -> bool

  val not_equal : arr -> arr -> bool

  val less : arr -> arr -> bool

  val greater : arr -> arr -> bool

  val less_equal : arr -> arr -> bool

  val greater_equal : arr -> arr -> bool

  val elt_equal : arr -> arr -> arr

  val elt_not_equal : arr -> arr -> arr

  val elt_less : arr -> arr -> arr

  val elt_greater : arr -> arr -> arr

  val elt_less_equal : arr -> arr -> arr

  val elt_greater_equal : arr -> arr -> arr

  val elt_equal_scalar : arr -> elt -> arr

  val elt_not_equal_scalar : arr -> elt -> arr

  val elt_less_scalar : arr -> elt -> arr

  val elt_greater_scalar : arr -> elt -> arr

  val elt_less_equal_scalar : arr -> elt -> arr

  val elt_greater_equal_scalar : arr -> elt -> arr

  val is_zero : arr -> bool

  val is_positive : arr -> bool

  val is_negative : arr -> bool

  val is_nonpositive : arr -> bool

  val is_nonnegative : arr -> bool

end


module type InpureSig = sig

  include NdarraySig_Ext

  val hypot : arr -> arr -> arr

  val fmod : arr -> arr -> arr

  val min2 : arr -> arr -> arr

  val max2 : arr -> arr -> arr

  val add_ : arr -> arr -> unit

  val sub_ : arr -> arr -> unit

  val mul_ : arr -> arr -> unit

  val div_ : arr -> arr -> unit

  val pow_ : arr -> arr -> unit

  val atan2_ : arr -> arr -> unit

  val hypot_ : arr -> arr -> unit

  val fmod_ : arr -> arr -> unit

  val min2_ : arr -> arr -> unit

  val max2_ : arr -> arr -> unit

  val add_scalar_ : arr -> elt -> unit

  val sub_scalar_ : arr -> elt -> unit

  val mul_scalar_ : arr -> elt -> unit

  val div_scalar_ : arr -> elt -> unit

  val pow_scalar_ : arr -> elt -> unit

  val atan2_scalar_ : arr -> elt -> unit

  val fmod_scalar_ : arr -> elt -> unit

  val scalar_add_ : elt -> arr -> unit

  val scalar_sub_ : elt -> arr -> unit

  val scalar_mul_ : elt -> arr -> unit

  val scalar_div_ : elt -> arr -> unit

  val scalar_pow_ : elt -> arr -> unit

  val scalar_atan2_ : elt -> arr -> unit

  val scalar_fmod_ : elt -> arr -> unit

  val abs_ : arr -> unit

  val neg_ : arr -> unit

  val conj_ : arr -> unit

  val reci_ : arr -> unit

  val signum_ : arr -> unit

  val sqr_ : arr -> unit

  val sqrt_ : arr -> unit

  val cbrt_ : arr -> unit

  val exp_ : arr -> unit

  val exp2_ : arr -> unit

  val exp10_ : arr -> unit

  val expm1_ : arr -> unit

  val log_ : arr -> unit

  val log2_ : arr -> unit

  val log10_ : arr -> unit

  val log1p_ : arr -> unit

  val sin_ : arr -> unit

  val cos_ : arr -> unit

  val tan_ : arr -> unit

  val asin_ : arr -> unit

  val acos_ : arr -> unit

  val atan_ : arr -> unit

  val sinh_ : arr -> unit

  val cosh_ : arr -> unit

  val tanh_ : arr -> unit

  val asinh_ : arr -> unit

  val acosh_ : arr -> unit

  val atanh_ : arr -> unit

  val floor_ : arr -> unit

  val ceil_ : arr -> unit

  val round_ : arr -> unit

  val trunc_ : arr -> unit

  val fix_ : arr -> unit

  val erf_ : arr -> unit

  val erfc_ : arr -> unit

  val relu_ : arr -> unit

  val softplus_ : arr -> unit

  val softsign_ : arr -> unit

  val softmax_ : arr -> unit

  val sigmoid_ : arr -> unit

  val sum : ?axis:int -> arr -> arr

  val prod : ?axis:int -> arr -> arr

  val min : ?axis:int -> arr -> arr

  val max : ?axis:int -> arr -> arr

  val mean : ?axis:int -> arr -> arr

  val var : ?axis:int -> arr -> arr

  val std : ?axis:int -> arr -> arr

  val l1norm : ?axis:int -> arr -> arr

  val l2norm : ?axis:int -> arr -> arr

  val cumsum_ : ?axis:int -> arr -> unit

  val cumprod_ : ?axis:int -> arr -> unit

  val cummin_ : ?axis:int -> arr -> unit

  val cummax_ : ?axis:int -> arr -> unit

  val dropout_ : ?rate:float -> arr -> unit

  val prod' : arr -> elt

  val mean' : arr -> elt

  val var' : arr -> elt

  val std' : arr -> elt

  val elt_equal_ : arr -> arr -> unit

  val elt_not_equal_ : arr -> arr -> unit

  val elt_less_ : arr -> arr -> unit

  val elt_greater_ : arr -> arr -> unit

  val elt_less_equal_ : arr -> arr -> unit

  val elt_greater_equal_ : arr -> arr -> unit

  val elt_equal_scalar_ : arr -> elt -> unit

  val elt_not_equal_scalar_ : arr -> elt -> unit

  val elt_less_scalar_ : arr -> elt -> unit

  val elt_greater_scalar_ : arr -> elt -> unit

  val elt_less_equal_scalar_ : arr -> elt -> unit

  val elt_greater_equal_scalar_ : arr -> elt -> unit

end


module type StatsSig = sig

  include InpureSig

  val uniform_rvs : a:arr -> b:arr -> n:int -> arr

  val uniform_pdf : a:arr -> b:arr -> arr -> arr

  val uniform_logpdf : a:arr -> b:arr -> arr -> arr

  val uniform_cdf : a:arr -> b:arr -> arr -> arr

  val uniform_logcdf : a:arr -> b:arr -> arr -> arr

  val uniform_ppf : a:arr -> b:arr -> arr -> arr

  val uniform_sf : a:arr -> b:arr -> arr -> arr

  val uniform_logsf : a:arr -> b:arr -> arr -> arr

  val uniform_isf : a:arr -> b:arr -> arr -> arr

  val gaussian_rvs : mu:arr -> sigma:arr -> n:int -> arr

  val gaussian_pdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_logpdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_cdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_logcdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_ppf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_sf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_logsf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_isf : mu:arr -> sigma:arr -> arr -> arr

  val exponential_rvs : lambda:arr -> n:int -> arr

  val exponential_pdf : lambda:arr -> arr -> arr

  val exponential_logpdf : lambda:arr -> arr -> arr

  val exponential_cdf : lambda:arr -> arr -> arr

  val exponential_logcdf : lambda:arr -> arr -> arr

  val exponential_ppf : lambda:arr -> arr -> arr

  val exponential_sf : lambda:arr -> arr -> arr

  val exponential_logsf : lambda:arr -> arr -> arr

  val exponential_isf : lambda:arr -> arr -> arr

  val gamma_rvs : shape:arr -> scale:arr -> n:int -> arr

  val gamma_pdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_logpdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_cdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_logcdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_ppf : shape:arr -> scale:arr -> arr -> arr

  val gamma_sf : shape:arr -> scale:arr -> arr -> arr

  val gamma_logsf : shape:arr -> scale:arr -> arr -> arr

  val gamma_isf : shape:arr -> scale:arr -> arr -> arr

  val beta_rvs : a:arr -> b:arr -> n:int -> arr

  val beta_pdf : a:arr -> b:arr -> arr -> arr

  val beta_logpdf : a:arr -> b:arr -> arr -> arr

  val beta_cdf : a:arr -> b:arr -> arr -> arr

  val beta_logcdf : a:arr -> b:arr -> arr -> arr

  val beta_ppf : a:arr -> b:arr -> arr -> arr

  val beta_sf : a:arr -> b:arr -> arr -> arr

  val beta_logsf : a:arr -> b:arr -> arr -> arr

  val beta_isf : a:arr -> b:arr -> arr -> arr

  val chi2_rvs : df:arr -> n:int -> arr

  val chi2_pdf : df:arr -> arr -> arr

  val chi2_logpdf : df:arr -> arr -> arr

  val chi2_cdf : df:arr -> arr -> arr

  val chi2_logcdf : df:arr -> arr -> arr

  val chi2_ppf : df:arr -> arr -> arr

  val chi2_sf : df:arr -> arr -> arr

  val chi2_logsf : df:arr -> arr -> arr

  val chi2_isf : df:arr -> arr -> arr

  val f_rvs : dfnum:arr -> dfden:arr -> n:int -> arr

  val f_pdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_logpdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_cdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_logcdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_ppf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_sf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_logsf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_isf : dfnum:arr -> dfden:arr -> arr -> arr

  val cauchy_rvs : loc:arr -> scale:arr -> n:int -> arr

  val cauchy_pdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_logpdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_cdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_logcdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_ppf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_sf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_logsf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_isf : loc:arr -> scale:arr -> arr -> arr

  val lomax_rvs : shape:arr -> scale:arr -> n:int -> arr

  val lomax_pdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_logpdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_cdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_logcdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_ppf : shape:arr -> scale:arr -> arr -> arr

  val lomax_sf : shape:arr -> scale:arr -> arr -> arr

  val lomax_logsf : shape:arr -> scale:arr -> arr -> arr

  val lomax_isf : shape:arr -> scale:arr -> arr -> arr

  val weibull_rvs : shape:arr -> scale:arr -> n:int -> arr

  val weibull_pdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_logpdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_cdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_logcdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_ppf : shape:arr -> scale:arr -> arr -> arr

  val weibull_sf : shape:arr -> scale:arr -> arr -> arr

  val weibull_logsf : shape:arr -> scale:arr -> arr -> arr

  val weibull_isf : shape:arr -> scale:arr -> arr -> arr

  val laplace_rvs : loc:arr -> scale:arr -> n:int -> arr

  val laplace_pdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_logpdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_cdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_logcdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_ppf : loc:arr -> scale:arr -> arr -> arr

  val laplace_sf : loc:arr -> scale:arr -> arr -> arr

  val laplace_logsf : loc:arr -> scale:arr -> arr -> arr

  val laplace_isf : loc:arr -> scale:arr -> arr -> arr

  val gumbel1_rvs : a:arr -> b:arr -> n:int -> arr

  val gumbel1_pdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_logpdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_cdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_logcdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_ppf : a:arr -> b:arr -> arr -> arr

  val gumbel1_sf : a:arr -> b:arr -> arr -> arr

  val gumbel1_logsf : a:arr -> b:arr -> arr -> arr

  val gumbel1_isf : a:arr -> b:arr -> arr -> arr

  val gumbel2_rvs : a:arr -> b:arr -> n:int -> arr

  val gumbel2_pdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_logpdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_cdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_logcdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_ppf : a:arr -> b:arr -> arr -> arr

  val gumbel2_sf : a:arr -> b:arr -> arr -> arr

  val gumbel2_logsf : a:arr -> b:arr -> arr -> arr

  val gumbel2_isf : a:arr -> b:arr -> arr -> arr

  val logistic_rvs : loc:arr -> scale:arr -> n:int -> arr

  val logistic_pdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_logpdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_cdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_logcdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_ppf : loc:arr -> scale:arr -> arr -> arr

  val logistic_sf : loc:arr -> scale:arr -> arr -> arr

  val logistic_logsf : loc:arr -> scale:arr -> arr -> arr

  val logistic_isf : loc:arr -> scale:arr -> arr -> arr

  val lognormal_rvs : mu:arr -> sigma:arr -> n:int -> arr

  val lognormal_pdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_logpdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_cdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_logcdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_ppf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_sf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_logsf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_isf : mu:arr -> sigma:arr -> arr -> arr

  val rayleigh_rvs : sigma:arr -> n:int -> arr

  val rayleigh_pdf : sigma:arr -> arr -> arr

  val rayleigh_logpdf : sigma:arr -> arr -> arr

  val rayleigh_cdf : sigma:arr -> arr -> arr

  val rayleigh_logcdf : sigma:arr -> arr -> arr

  val rayleigh_ppf : sigma:arr -> arr -> arr

  val rayleigh_sf : sigma:arr -> arr -> arr

  val rayleigh_logsf : sigma:arr -> arr -> arr

  val rayleigh_isf : sigma:arr -> arr -> arr

end



(* ends here *)
