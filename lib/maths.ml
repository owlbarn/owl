(** [
  random generators
  ]  *)

type t = Gsl.Rng.t


(** [ Constants ]  *)

let e = Gsl.Math.e

let pi = Gsl.Math.pi

let euler = Gsl.Math.euler


(** [ Set up random environment ]  *)

let rng =
  let r = Gsl.Rng.make Gsl.Rng.CMRG in
  let s = Nativeint.of_float (Unix.gettimeofday () *. 1000000.) in
  Gsl.Rng.set r s; r

let seed s = Gsl.Rng.set rng (Nativeint.of_int s)

let uniform_int ?(a=0) ?(b=65535) ()=
  (Gsl.Rng.uniform_int rng (b - a + 1)) + a


(** [ Continuous random variables ]  *)

let uniform () = Gsl.Rng.uniform rng

let gaussian ?(sigma=1.) () = Gsl.Randist.gaussian_ziggurat rng sigma

let gaussian_pdf x sigma = Gsl.Randist.gaussian_pdf x sigma

let gaussian_P x sigma = Gsl.Cdf.gaussian_P x sigma

let gaussian_Q x sigma = Gsl.Cdf.gaussian_Q x sigma

let gaussian_Pinv x sigma = Gsl.Cdf.gaussian_Pinv x sigma

let gaussian_Qinv x sigma = Gsl.Cdf.gaussian_Qinv x sigma

let gaussian_tail a sigma = Gsl.Randist.gaussian_tail rng a sigma

let gaussian_tail_pdf x a sigma = Gsl.Randist.gaussian_tail_pdf x a sigma

let bivariate_gaussian sigma_x sigma_y rho = Gsl.Randist.bivariate_gaussian rng sigma_x sigma_y rho

let bivariate_gaussian_pdf x y sigma_x sigma_y rho = Gsl.Randist.bivariate_gaussian_pdf x y sigma_x sigma_y rho

let exponential mu = Gsl.Randist.exponential rng mu

let exponential_pdf x mu = Gsl.Randist.exponential_pdf x mu

let exponential_P x mu = Gsl.Cdf.exponential_P x mu

let exponential_Q x mu = Gsl.Cdf.exponential_Q x mu

let exponential_Pinv p mu = Gsl.Cdf.exponential_Pinv p mu

let exponential_Qinv q mu = Gsl.Cdf.exponential_Qinv q mu

let laplace a = Gsl.Randist.laplace rng a

let laplace_pdf x a = Gsl.Randist.laplace_pdf x a

let laplace_P x a = Gsl.Cdf.laplace_P x a

let laplace_Q x a = Gsl.Cdf.laplace_Q x a

let laplace_Pinv p a = Gsl.Cdf.laplace_Pinv p a

let laplace_Qinv q a = Gsl.Cdf.laplace_Qinv q a

let exppow a b = Gsl.Randist.exppow rng a b

let exppow_pdf x a b = Gsl.Randist.exppow_pdf x a b

let exppow_P x a b = Gsl.Cdf.exppow_P x a b

let exppow_Q x a b = Gsl.Cdf.exppow_Q x a b

let cauchy a = Gsl.Randist.cauchy rng a

let cauchy_pdf x a = Gsl.Randist.cauchy_pdf x a

let cauchy_P x a = Gsl.Cdf.cauchy_P x a

let cauchy_Q x a = Gsl.Cdf.cauchy_Q x a

let cauchy_Pinv p a = Gsl.Cdf.cauchy_Pinv p a

let cauchy_Qinv q a = Gsl.Cdf.cauchy_Qinv q a

let rayleigh sigma = Gsl.Randist.rayleigh rng sigma

let rayleigh_pdf x sigma = Gsl.Randist.rayleigh_pdf x sigma

let rayleigh_P x sigma = Gsl.Cdf.rayleigh_P x sigma

let rayleigh_Q x sigma = Gsl.Cdf.rayleigh_Q x sigma

let rayleigh_Pinv p sigma = Gsl.Cdf.rayleigh_Pinv p sigma

let rayleigh_Qinv q sigma = Gsl.Cdf.rayleigh_Qinv q sigma

let rayleigh_tail a sigma = Gsl.Randist.rayleigh_tail rng a sigma

let rayleigh_tail_pdf x a sigma = Gsl.Randist.rayleigh_tail_pdf x a sigma

let landau () = Gsl.Randist.landau rng

let landau_pdf x = Gsl.Randist.landau_pdf x

let levy c alpha = Gsl.Randist.levy rng c alpha

let levy_skew c alpha beta = Gsl.Randist.levy_skew rng c alpha beta

let gamma a b = Gsl.Randist.gamma rng a b

let gamma_pdf x a b = Gsl.Randist.gamma_pdf x a b

let gamma_P x a b = Gsl.Cdf.gamma_P x a b

let gamma_Q x a b = Gsl.Cdf.gamma_Q x a b

let gamma_Pinv p a b = Gsl.Cdf.gamma_Pinv p a b

let gamma_Qinv q a b = Gsl.Cdf.gamma_Qinv q a b

let flat a b = Gsl.Randist.flat rng a b  (* TODO: use this to replace uniform *)

let flat_pdf x a b = Gsl.Randist.flat_pdf x a b

let flat_P x a b = Gsl.Cdf.flat_P x a b

let flat_Q x a b = Gsl.Cdf.flat_Q x a b

let flat_Pinv p a b = Gsl.Cdf.flat_Pinv p a b

let flat_Qinv q a b = Gsl.Cdf.flat_Qinv q a b

let lognormal zata sigma = Gsl.Randist.lognormal rng zata sigma

let lognormal_pdf x zeta sigma = Gsl.Randist.lognormal_pdf x zeta sigma

let lognormal_P x zeta sigma = Gsl.Cdf.lognormal_P x zeta sigma

let lognormal_Q x zeta sigma = Gsl.Cdf.lognormal_Q x zeta sigma

let lognormal_Pinv p zeta sigma = Gsl.Cdf.lognormal_Pinv p zeta sigma

let lognormal_Qinv q zeta sigma = Gsl.Cdf.lognormal_Qinv q zeta sigma

let chisq nu = Gsl.Randist.chisq rng nu

let chisq_pdf x nu = Gsl.Randist.chisq_pdf x nu

let chisq_P x nu = Gsl.Cdf.chisq_P x nu

let chisq_Q x nu = Gsl.Cdf.chisq_Q x nu

let chisq_Pinv p nu = Gsl.Cdf.chisq_Pinv p nu

let chisq_Qinv q nu = Gsl.Cdf.chisq_Qinv q nu

let dirichlet alpha theta = Gsl.Randist.dirichlet rng alpha theta

let dirichlet_pdf alpha theta = Gsl.Randist.dirichlet_pdf alpha theta

let dirichlet_lnpdf alpha theta = Gsl.Randist.dirichlet_lnpdf alpha theta

let fdist nu1 nu2 = Gsl.Randist.fdist rng nu1 nu2

let fdist_pdf x nu1 nu2 = Gsl.Randist.fdist_pdf x nu1 nu2

let fdist_P x nu1 nu2 = Gsl.Cdf.fdist_P x nu1 nu2

let fdist_Q x nu1 nu2 = Gsl.Cdf.fdist_Q x nu1 nu2

let fdist_Pinv p nu1 nu2 = Gsl.Cdf.fdist_Pinv p nu1 nu2

let fdist_Qinv q nu1 nu2 = Gsl.Cdf.fdist_Qinv q nu1 nu2

let tdist nu = Gsl.Randist.tdist rng nu

let tdist_pdf x nu = Gsl.Randist.tdist_pdf x nu

let tdist_P x nu = Gsl.Cdf.tdist_P x nu

let tdist_Q x nu = Gsl.Cdf.tdist_Q x nu

let tdist_Pinv p nu = Gsl.Cdf.tdist_Pinv p nu

let tdist_Qinv q nu = Gsl.Cdf.tdist_Qinv q nu

let beta a b = Gsl.Randist.beta rng a b

let beta_pdf x a b = Gsl.Randist.beta_pdf x a b

let beta_P x a b = Gsl.Cdf.beta_P x a b

let beta_Q x a b = Gsl.Cdf.beta_Q x a b

let beta_Pinv p a b = Gsl.Cdf.beta_Pinv p a b

let beta_Qinv q a b = Gsl.Cdf.beta_Qinv q a b

let logistic a = Gsl.Randist.logistic rng a

let logistic_pdf x a = Gsl.Randist.logistic_pdf x a

let logistic_P x a = Gsl.Cdf.logistic_P x a

let logistic_Q x a = Gsl.Cdf.logistic_Q x a

let logistic_Pinv p a = Gsl.Cdf.logistic_Pinv p a

let logistic_Qinv q a = Gsl.Cdf.logistic_Qinv q a

let pareto a b = Gsl.Randist.pareto rng a b

let pareto_pdf x a b = Gsl.Randist.pareto_pdf x a b

let pareto_P x a b = Gsl.Cdf.pareto_P x a b

let pareto_Q x a b = Gsl.Cdf.pareto_Q x a b

let pareto_Pinv p a b = Gsl.Cdf.pareto_Pinv p a b

let pareto_Qinv q a b = Gsl.Cdf.pareto_Qinv q a b

let dir_2d () = Gsl.Randist.dir_2d rng

let dir_2d_trig_method () = Gsl.Randist.dir_2d_trig_method rng

let dir_3d () = Gsl.Randist.dir_3d rng

let dir_nd n =
  let x = Array.make n 0. in
  Gsl.Randist.dir_nd rng x; x

let weibull a b = Gsl.Randist.weibull rng a b

let weibull_pdf x a b = Gsl.Randist.weibull_pdf x a b

let weibull_P x a b = Gsl.Cdf.weibull_P x a b

let weibull_Q x a b = Gsl.Cdf.weibull_Q x a b

let weibull_Pinv p a b = Gsl.Cdf.weibull_Pinv p a b

let weibull_Qinv q a b = Gsl.Cdf.weibull_Qinv q a b

let gumbel1 a b = Gsl.Randist.gumbel1 rng a b

let gumbel1_pdf x a b = Gsl.Randist.gumbel1_pdf x a b

let gumbel1_P x a b = Gsl.Cdf.gumbel1_P x a b

let gumbel1_Q x a b = Gsl.Cdf.gumbel1_Q x a b

let gumbel1_Pinv p a b = Gsl.Cdf.gumbel1_Pinv p a b

let gumbel1_Qinv q a b = Gsl.Cdf.gumbel1_Qinv q a b

let gumbel2 a b = Gsl.Randist.gumbel2 rng a b

let gumbel2_pdf x a b = Gsl.Randist.gumbel2_pdf x a b

let gumbel2_P x a b = Gsl.Cdf.gumbel2_P x a b

let gumbel2_Q x a b = Gsl.Cdf.gumbel2_Q x a b

let gumbel2_Pinv p a b = Gsl.Cdf.gumbel2_Pinv p a b

let gumbel2_Qinv q a b = Gsl.Cdf.gumbel2_Qinv q a b


(** [ Discrete random variables ]  *)

let poisson mu = Gsl.Randist.poisson rng mu

let poisson_pdf x mu = Gsl.Randist.poisson_pdf x mu

let poisson_P x mu = Gsl.Cdf.poisson_P x mu

let poisson_Q x mu = Gsl.Cdf.poisson_Q x mu

let bernoulli p = Gsl.Randist.bernoulli rng p

let bernoulli_pdf x p = Gsl.Randist.bernoulli_pdf x p

let binomial p n = Gsl.Randist.binomial rng p n

let binomial_pdf x p n = Gsl.Randist.binomial_pdf x p n

let binomial_P x p n = Gsl.Cdf.binomial_P x p n

let binomial_Q x p n = Gsl.Cdf.binomial_Q x p n

let multinomial n p = Gsl.Randist.multinomial rng n p

let multinomial_pdf p n = Gsl.Randist.multinomial_pdf p n

let multinomial_lnpdf p n = Gsl.Randist.multinomial_lnpdf p n

let negative_binomial p n = Gsl.Randist.negative_binomial rng p n

let negative_binomial_pdf x p n = Gsl.Randist.negative_binomial_pdf x p n

let negative_binomial_P x p n = Gsl.Cdf.negative_binomial_P x p n

let negative_binomial_Q x p n = Gsl.Cdf.negative_binomial_Q x p n

let pascal p n = Gsl.Randist.pascal rng p n

let pascal_pdf x p n = Gsl.Randist.pascal_pdf x p n

let pascal_P x p n = Gsl.Cdf.pascal_P x p n

let pascal_Q x p n = Gsl.Cdf.pascal_Q x p n

let geometric p = Gsl.Randist.geometric rng p

let geometric_pdf x p = Gsl.Randist.geometric_pdf x p

let geometric_P x p = Gsl.Cdf.geometric_P x p

let geometric_Q x p = Gsl.Cdf.geometric_Q x p

let hypergeometric n1 n2 t = Gsl.Randist.hypergeometric rng n1 n2 t

let hypergeometric_pdf x n1 n2 t = Gsl.Randist.hypergeometric_pdf x n1 n2 t

let hypergeometric_P x n1 n2 t = Gsl.Cdf.hypergeometric_P x n1 n2 t

let hypergeometric_Q x n1 n2 t = Gsl.Cdf.hypergeometric_Q x n1 n2 t

let logarithmic p = Gsl.Randist.logarithmic rng p

let logarithmic_pdf x p = Gsl.Randist.logarithmic_pdf x p


(** [ Randomisation function ]  *)

let shuffle x =
  let y = Array.copy x in
  Gsl.Randist.shuffle rng y; y

let choose x n =
  let y = Array.make n x.(0) in
  Gsl.Randist.choose rng x y; y

let sample x n =
  let y = Array.make n x.(0) in
  Gsl.Randist.sample rng x y; y


(** [ Statistics function ]  *)

let mean ?w x = Gsl.Stats.mean ?w x

let variance ?w ?mean x = Gsl.Stats.variance ?w ?mean x

let std ?w ?mean x = Gsl.Stats.sd ?w ?mean x

let absdev ?w ?mean x = Gsl.Stats.absdev ?w ?mean x

let skew ?w ?mean ?sd x =
  match mean, sd with
  | Some m, Some sd -> Gsl.Stats.skew_m_sd ?w ~mean:m ~sd:sd x
  | None, None -> Gsl.Stats.skew x
  | _, _ -> failwith "not enough arguments"

let kurtosis ?w ?mean ?sd x =
  match mean, sd with
  | Some m, Some sd -> Gsl.Stats.kurtosis_m_sd ?w ~mean:m ~sd:sd x
  | None, None -> Gsl.Stats.kurtosis x
  | _, _ -> failwith "not enough arguments"

let autocorrelation = None

let covariance ?mean0 ?mean1 x0 x1 =
  match mean0, mean1 with
  | Some m0, Some m1 -> Gsl.Stats.covariance_m m0 x0 m1 x1
  | Some m0, None -> Gsl.Stats.covariance_m m0 x0 (mean x1) x1
  | None, Some m1 -> Gsl.Stats.covariance_m (mean x0) x0 m1 x1
  | None, None -> Gsl.Stats.covariance x0 x1

let max x = Gsl.Stats.max x

let min x = Gsl.Stats.min x

let minmax x = Gsl.Stats.minmax x

let max_i x =
  let i = Gsl.Stats.max_index x in
  x.(i), i

let min_i x =
  let i = Gsl.Stats.min_index x in
  x.(i), i

let minmax_i x =
let i, j = Gsl.Stats.minmax_index x in
x.(i), i, x.(j), j


(** [ Basic and advanced math functions ] *)

let abs x = if x < 0. then (0.-.x) else x

let sqrt x = sqrt x

let pow x y = x ** y

let exp x = Gsl.Sf.exp x

let expm1 x = Gsl.Sf.expm1 x

let exp_mult x y = Gsl.Sf.exp_mult x y

let exprel x = Gsl.Sf.exprel x

let ln x = Gsl.Sf.log x

let ln1p x = Gsl.Sf.log_1plusx x

let ln_abs x = Gsl.Sf.log_abs x

let log2 x = (ln x) /. Gsl.Math.ln2

let log10 x = (ln x) /. Gsl.Math.ln10

let log base x = (ln x) /. (ln base)

let sin x = Gsl.Sf.sin x

let cos x = Gsl.Sf.cos x

let tan x = tan x

let cot x = 1. /. (tan x)

let sec x = 1. /. (cos x)

let csc x = 1. /. (sin x)

let asin x = asin x

let acos x = acos x

let atan x = atan x

let acot x = (Gsl.Math.pi /. 2.) -. (atan x)

let asec = None

let acsc = None

let sinc x = Gsl.Sf.sinc x

let sinh x = sinh x

let cosh x = cosh x

let acosh x = Gsl.Math.acosh x

let asinh x = Gsl.Math.asinh x

let atanh x = Gsl.Math.atanh x

let lnsinh x = Gsl.Sf.lnsinh x

let lncosh x = Gsl.Sf.lncosh x

let hypot x y = Gsl.Sf.hypot x y

let rect_of_polar ~r ~theta =
  let open Gsl.Fun in
  let x, y = Gsl.Sf.rect_of_polar ~r ~theta in
  x.res, y.res

let polar_of_rect ~x ~y =
  let open Gsl.Fun in
  let a, b = Gsl.Sf.polar_of_rect ~x ~y in
  a.res, b.res

let angle_restrict_symm x = Gsl.Sf.angle_restrict_symm x

let angle_restrict_pos x = Gsl.Sf.angle_restrict_pos x

let airy_Ai x = Gsl.Sf.airy_Ai x Gsl.Fun.DOUBLE

let airy_Bi x = Gsl.Sf.airy_Ai x Gsl.Fun.DOUBLE

let airy_Ai_scaled x = Gsl.Sf.airy_Ai_scaled x Gsl.Fun.DOUBLE

let airy_Bi_scaled x = Gsl.Sf.airy_Bi_scaled x Gsl.Fun.DOUBLE

let airy_Ai_deriv x = Gsl.Sf.airy_Ai_deriv x Gsl.Fun.DOUBLE

let airy_Bi_deriv x = Gsl.Sf.airy_Ai_deriv x Gsl.Fun.DOUBLE

let airy_Ai_deriv x = Gsl.Sf.airy_Ai_deriv_scaled x Gsl.Fun.DOUBLE

let airy_Bi_deriv x = Gsl.Sf.airy_Bi_deriv_scaled x Gsl.Fun.DOUBLE

let airy_zero_Ai x = Gsl.Sf.airy_zero_Ai x

let airy_zero_Bi x = Gsl.Sf.airy_zero_Ai x

let bessel_J0 x = Gsl.Sf.bessel_J0 x

let bessel_J1 x = Gsl.Sf.bessel_J1 x

let bessel_Jn n x = Gsl.Sf.bessel_Jn n x

let bessel_Jn_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_Jn_array nmin x y; y

let bessel_Y0 x = Gsl.Sf.bessel_Y0 x

let bessel_Y1 x = Gsl.Sf.bessel_Y1 x

let bessel_Yn n x = Gsl.Sf.bessel_Yn n x

let bessel_Yn_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_Yn_array nmin x y; y

let bessel_I0 x = Gsl.Sf.bessel_I0 x

let bessel_I1 x = Gsl.Sf.bessel_I1 x

let bessel_In n x = Gsl.Sf.bessel_In n x

let bessel_In_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_In_array nmin x y; y

let bessel_K0 x = Gsl.Sf.bessel_K0 x

let bessel_K1 x = Gsl.Sf.bessel_K1 x

let bessel_Kn n x = Gsl.Sf.bessel_Kn n x

let bessel_Kn_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_Kn_array nmin x y; y

let bessel_I0_scaled x = Gsl.Sf.bessel_I0_scaled x

let bessel_I1_scaled x = Gsl.Sf.bessel_I1_scaled x

let bessel_In_scaled n x = Gsl.Sf.bessel_In_scaled n x

let bessel_In_scaled_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_In_scaled_array nmin x y; y

let bessel_K0_scaled x = Gsl.Sf.bessel_K0_scaled x

let bessel_K1_scaled x = Gsl.Sf.bessel_K1_scaled x

let bessel_Kn_scaled n x = Gsl.Sf.bessel_Kn_scaled n x

let bessel_Kn_scaled_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_Kn_scaled_array nmin x y; y

let bessel_j0 x = Gsl.Sf.bessel_j0 x

let bessel_j1 x = Gsl.Sf.bessel_j1 x

let bessel_j2 x = Gsl.Sf.bessel_j2 x

let bessel_jl l x = Gsl.Sf.bessel_jl l x

let bessel_jl_array l x =
  let y = Array.make (l + 1) 0. in
  Gsl.Sf.bessel_jl_array l x y; y

let bessel_jl_steed_array l x =
  let y = Array.make (l + 1) 0. in
  Gsl.Sf.bessel_jl_steed_array x y; y

let bessel_y0 x = Gsl.Sf.bessel_y0 x

let bessel_y1 x = Gsl.Sf.bessel_y1 x

let bessel_y2 x = Gsl.Sf.bessel_y2 x

let bessel_yl l x = Gsl.Sf.bessel_yl l x

let bessel_yl_array l x =
  let y = Array.make (l + 1) 0. in
  Gsl.Sf.bessel_yl_array l x y; y

let bessel_i0_scaled x = Gsl.Sf.bessel_i0_scaled x

let bessel_i1_scaled x = Gsl.Sf.bessel_i1_scaled x

let bessel_il_scaled l x = Gsl.Sf.bessel_il_scaled l x

let bessel_il_array_scaled l x =
  let y = Array.make (l + 1) 0. in
  Gsl.Sf.bessel_il_scaled_array l x y; y

let bessel_k0_scaled x = Gsl.Sf.bessel_k0_scaled x

let bessel_k1_scaled x = Gsl.Sf.bessel_k1_scaled x

let bessel_kl_scaled l x = Gsl.Sf.bessel_kl_scaled l x

let bessel_kl_array_scaled l x =
  let y = Array.make (l + 1) 0. in
  Gsl.Sf.bessel_kl_scaled_array l x y; y

let bessel_Jnu nu x = Gsl.Sf.bessel_Jnu nu x

let bessel_Ynu nu x = Gsl.Sf.bessel_Ynu nu x

let bessel_Inu nu x = Gsl.Sf.bessel_Inu nu x

let bessel_Inu_scaled nu x = Gsl.Sf.bessel_Inu_scaled nu x

let bessel_Knu nu x = Gsl.Sf.bessel_Knu nu x

let bessel_lnKnu nu x = Gsl.Sf.bessel_lnKnu nu x

let bessel_Knu_scaled nu x = Gsl.Sf.bessel_Knu_scaled nu x

let bessel_zero_J0 x = Gsl.Sf.bessel_zero_J0 x

let bessel_zero_J1 x = Gsl.Sf.bessel_zero_J1 x

let bessel_zero_Jnu nu x = Gsl.Sf.bessel_zero_Jnu nu x

let clausen x = Gsl.Sf.clausen x

let dawson x = Gsl.Sf.dawson x

let debye_1 x = Gsl.Sf.debye_1 x

let debye_2 x = Gsl.Sf.debye_2 x

let debye_3 x = Gsl.Sf.debye_3 x

let debye_4 x = Gsl.Sf.debye_4 x

let debye_5 x = Gsl.Sf.debye_5 x

let debye_6 x = Gsl.Sf.debye_6 x

let dilog x = Gsl.Sf.dilog x

let ellint_Kcomp x = Gsl.Sf.ellint_Kcomp x Gsl.Fun.DOUBLE

let ellint_Ecomp x = Gsl.Sf.ellint_Ecomp x Gsl.Fun.DOUBLE

let ellint_Pcomp x n = Gsl.Sf.ellint_Pcomp x n Gsl.Fun.DOUBLE

let ellint_Dcomp x = Gsl.Sf.ellint_Dcomp x Gsl.Fun.DOUBLE

let ellint_F phi x =  Gsl.Sf.ellint_F phi x Gsl.Fun.DOUBLE

let ellint_E phi x =  Gsl.Sf.ellint_E phi x Gsl.Fun.DOUBLE

let ellint_P phi x n =  Gsl.Sf.ellint_P phi x n Gsl.Fun.DOUBLE

let ellint_D phi x =  Gsl.Sf.ellint_D phi x Gsl.Fun.DOUBLE

let ellint_RC x y = Gsl.Sf.ellint_RC x y Gsl.Fun.DOUBLE

let ellint_RD x y z = Gsl.Sf.ellint_RD x y z Gsl.Fun.DOUBLE

let ellint_RF x y z = Gsl.Sf.ellint_RF x y z Gsl.Fun.DOUBLE

let ellint_RJ x y z p = Gsl.Sf.ellint_RJ x y z p Gsl.Fun.DOUBLE

let expint_E1 x = Gsl.Sf.expint_E1 x

let expint_E2 x = Gsl.Sf.expint_E2 x

let expint_Ei x = Gsl.Sf.expint_Ei x

let expint_E1_scaled x = Gsl.Sf.expint_E1_scaled x

let expint_E2_scaled x = Gsl.Sf.expint_E2_scaled x

let expint_Ei_scaled x = Gsl.Sf.expint_Ei_scaled x

let expint_3 x = Gsl.Sf.expint_3 x

let shi x = Gsl.Sf.shi x

let chi x = Gsl.Sf.chi x

let si x = Gsl.Sf.si x

let ci x = Gsl.Sf.ci x

let atanint x = Gsl.Sf.atanint x

let fermi_dirac_m1 x = Gsl.Sf.fermi_dirac_m1 x

let fermi_dirac_0 x = Gsl.Sf.fermi_dirac_0 x

let fermi_dirac_1 x = Gsl.Sf.fermi_dirac_1 x

let fermi_dirac_2 x = Gsl.Sf.fermi_dirac_2 x

let fermi_dirac_int j x = Gsl.Sf.fermi_dirac_int j x

let fermi_dirac_mhalf x = Gsl.Sf.fermi_dirac_mhalf x

let fermi_dirac_half x = Gsl.Sf.fermi_dirac_half x

let fermi_dirac_3half x = Gsl.Sf.fermi_dirac_3half x

let fermi_dirac_inc_0 x b = Gsl.Sf.fermi_dirac_inc_0 x b

let gammaf x = Gsl.Sf.gamma x

let lngamma x = Gsl.Sf.lngamma x

let gammastar x = Gsl.Sf.gammastar x

let gammainv x = Gsl.Sf.gammainv x

let gamma_inc a x = Gsl.Sf.gamma_inc a x

let gamma_inc_Q a x  = Gsl.Sf.gamma_inc_Q a x

let gamma_inc_P a x  = Gsl.Sf.gamma_inc_P a x

let factorial x = Gsl.Sf.fact x

let double_factorial x = Gsl.Sf.doublefact x

let ln_factorial x = Gsl.Sf.lnfact x

let ln_double_factorial x = Gsl.Sf.lndoublefact x

let combination n x = Gsl.Sf.choose n x

let ln_combination n x = Gsl.Sf.lnchoose n x

let taylorcoeff n x = Gsl.Sf.taylorcoeff n x

let poch a x = Gsl.Sf.poch a x

let lnpoch a x = Gsl.Sf.lnpoch a x

let pochrel a x = Gsl.Sf.pochrel a x

let betaf x y = Gsl.Sf.beta x y

let lnbeta x y = Gsl.Sf.lnbeta x y

let beta_inc a b x = Gsl.Sf.beta_inc a b x

let laguerre_1 a x = Gsl.Sf.laguerre_1 a x

let laguerre_2 a x = Gsl.Sf.laguerre_2 a x

let laguerre_3 a x = Gsl.Sf.laguerre_3 a x

let laguerre_n n a x = Gsl.Sf.laguerre_n n a x

let lambert_w0 x = Gsl.Sf.lambert_W0 x

let lambert_w1 x = Gsl.Sf.lambert_Wm1 x

let legendre_P1 x = Gsl.Sf.legendre_P1 x

let legendre_P2 x = Gsl.Sf.legendre_P2 x

let legendre_P3 x = Gsl.Sf.legendre_P3 x

let legendre_Pl l x = Gsl.Sf.legendre_Pl l x

let legendre_Pl_array l x =
  let y = Array.make l 0. in
  Gsl.Sf.legendre_Pl_array x y; y

let legendre_Q0 x = Gsl.Sf.legendre_Q0 x

let legendre_Q1 x = Gsl.Sf.legendre_Q1 x

let legendre_Ql l x = Gsl.Sf.legendre_Ql l x

let psi x = Gsl.Sf.psi x

let psi_int n = Gsl.Sf.psi_int n

let psi_1 x = Gsl.Sf.psi_1 x

let psi_1piy n = Gsl.Sf.psi_1piy n

let psi_1_pint n = Gsl.Sf.psi_int n

let psi_n n x = Gsl.Sf.psi_n n x

let synchrotron_1 x = Gsl.Sf.synchrotron_1 x

let synchrotron_2 x = Gsl.Sf.synchrotron_2 x

let transport_2 x = Gsl.Sf.transport_2 x

let transport_3 x = Gsl.Sf.transport_3 x

let transport_4 x = Gsl.Sf.transport_4 x

let transport_5 x = Gsl.Sf.transport_5 x

let zeta x = Gsl.Sf.zeta x

let zeta_int x = Gsl.Sf.zeta_int x

let hzeta x y = Gsl.Sf.hzeta x y

let eta x = Gsl.Sf.eta x

let eta_int x = Gsl.Sf.eta_int x



(* ends here *)
