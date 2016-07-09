(** [
  random generators
  ]  *)

type t = Gsl.Rng.t

let rng =
  let r = Gsl.Rng.make Gsl.Rng.CMRG in
  let s = Nativeint.of_float (Unix.gettimeofday () *. 1000000.) in
  Gsl.Rng.set r s; r

let seed s = Gsl.Rng.set rng (Nativeint.of_int s)

let uniform_int ?(a=0) ?(b=65535) ()=
  (Gsl.Rng.uniform_int rng (b - a + 1)) + a

(* continuous random variables *)

let uniform () = Gsl.Rng.uniform rng

let gaussian ?(sigma=1.) () = Gsl.Randist.gaussian rng sigma

let gaussian_pdf x sigma = Gsl.Randist.gaussian_pdf x sigma

let gaussian_tail a sigma = Gsl.Randist.gaussian_tail rng a sigma

let gaussian_tail_pdf x a sigma = Gsl.Randist.gaussian_tail_pdf x a sigma

let bivariate_gaussian sigma_x sigma_y rho = Gsl.Randist.bivariate_gaussian rng sigma_x sigma_y rho

let bivariate_gaussian_pdf x y sigma_x sigma_y rho = Gsl.Randist.bivariate_gaussian_pdf x y sigma_x sigma_y rho

let exponential mu = Gsl.Randist.exponential rng mu

let exponential_pdf x mu = Gsl.Randist.exponential_pdf x mu

let laplace a = Gsl.Randist.laplace rng a

let laplace_pdf x a = Gsl.Randist.laplace_pdf x a

let exppow a b = Gsl.Randist.exppow rng a b

let exppow_pdf x a b = Gsl.Randist.exppow_pdf x a b

let cauchy a = Gsl.Randist.cauchy rng a

let cauchy_pdf x a = Gsl.Randist.cauchy_pdf x a

let rayleigh sigma = Gsl.Randist.rayleigh rng sigma

let rayleigh_pdf x sigma = Gsl.Randist.rayleigh_pdf x sigma

let rayleigh_tail a sigma = Gsl.Randist.rayleigh_tail rng a sigma

let rayleigh_tail_pdf x a sigma = Gsl.Randist.rayleigh_tail_pdf x a sigma

let landau () = Gsl.Randist.landau rng

let landau_pdf x = Gsl.Randist.landau_pdf x

let levy c alpha = Gsl.Randist.levy rng c alpha

let levy_skew c alpha beta = Gsl.Randist.levy_skew rng c alpha beta

let gamma a b = Gsl.Randist.gamma rng a b

let gamma_pdf x a b = Gsl.Randist.gamma_pdf x a b

let flat a b = Gsl.Randist.flat rng a b  (* TODO: use this to replace uniform *)

let flat_pdf x a b = Gsl.Randist.flat_pdf x a b

let lognormal zata sigma = Gsl.Randist.lognormal rng zata sigma

let lognormal_pdf x zeta sigma = Gsl.Randist.lognormal_pdf x zeta sigma

let chisq nu = Gsl.Randist.chisq rng nu

let chisq_pdf x nu = Gsl.Randist.chisq_pdf x nu

let dirichlet alpha theta = Gsl.Randist.dirichlet rng alpha theta

let dirichlet_pdf alpha theta = Gsl.Randist.dirichlet_pdf alpha theta

let dirichlet_lnpdf alpha theta = Gsl.Randist.dirichlet_lnpdf alpha theta

let fdist nu1 nu2 = Gsl.Randist.fdist rng nu1 nu2

let fdist_pdf x nu1 nu2 = Gsl.Randist.fdist_pdf x nu1 nu2

let beta a b = Gsl.Randist.beta rng a b

let beta_pdf x a b = Gsl.Randist.beta x a b

let logistic a = Gsl.Randist.logistic rng a

let logistic_pdf x a = Gsl.Randist.logistic_pdf x a

let pareto a b = Gsl.Randist.pareto rng a b

let pareto_pdf x a b = Gsl.Randist.pareto_pdf x a b

let dir_2d () = Gsl.Randist.dir_2d rng

let dir_2d_trig_method () = Gsl.Randist.dir_2d_trig_method rng

let dir_3d () = Gsl.Randist.dir_3d rng

let dir_nd x = Gsl.Randist.dir_nd rng x

let weibull a b = Gsl.Randist.weibull rng a b

let weibull_pdf x a b = Gsl.Randist.weibull_pdf x a b

let gumbel1 a b = Gsl.Randist.gumbel1 rng a b

let gumbel1_pdf x a b = Gsl.Randist.gumbel1_pdf x a b

let gumbel2 a b = Gsl.Randist.gumbel2 rng a b

let gumbel2_pdf x a b = Gsl.Randist.gumbel2_pdf x a b

(* discrete random variables *)

let poisson mu = Gsl.Randist.poisson rng mu

let poisson_pdf x mu = Gsl.Randist.poisson_pdf x mu

let bernoulli p = Gsl.Randist.bernoulli rng p

let bernoulli_pdf x p = Gsl.Randist.bernoulli_pdf x p

let binomial p n = Gsl.Randist.binomial rng p n

let binomial_pdf x p n = Gsl.Randist.binomial_pdf x p n

let multinomial n p = Gsl.Randist.multinomial rng n p

let multinomial_pdf p n = Gsl.Randist.multinomial_pdf p n

let multinomial_lnpdf p n = Gsl.Randist.multinomial_lnpdf p n

let negative_binomial p n = Gsl.Randist.negative_binomial rng p n

let negative_binomial_pdf x p n = Gsl.Randist.negative_binomial_pdf x p n

let pascal p n = Gsl.Randist.pascal rng p n

let pascal_pdf x p n = Gsl.Randist.pascal_pdf x p n

let geometric p = Gsl.Randist.geometric rng p

let geometric_pdf x p = Gsl.Randist.geometric_pdf x p

let hypergeometric n1 n2 t = Gsl.Randist.hypergeometric rng n1 n2 t

let hypergeometric_pdf x n1 n2 t = Gsl.Randist.hypergeometric_pdf x n1 n2 t

let logarithmic p = Gsl.Randist.logarithmic rng p

let logarithmic_pdf x p = Gsl.Randist.logarithmic_pdf x p

(* randomisation function *)

let shuffle x = Gsl.Randist.shuffle rng x

let choose x y =  Gsl.Randist.choose rng x y

let sample x y = Gsl.Randist.sample rng x y
