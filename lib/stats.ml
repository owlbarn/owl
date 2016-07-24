(** [
  random generators
  ]  *)

type t = Gsl.Rng.t


(** [ Set up random environment ]  *)

let rng =
  let r = Gsl.Rng.make Gsl.Rng.MT19937 in
  let s = Nativeint.of_float (Unix.gettimeofday () *. 1000000.) in
  Gsl.Rng.set r s; r

let seed s = Gsl.Rng.set rng (Nativeint.of_int s)

let uniform_int ?(a=0) ?(b=65535) ()=
  (Gsl.Rng.uniform_int rng (b - a + 1)) + a


(** [ Continuous random variables ]  *)

(* TODO: change the order of the arguments in _pdf functions *)

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

let central_moment n x =
  let m = float_of_int n in
  let u = mean x in
  let x = Array.map (fun x -> (x -. u) ** m) x in
  let a = Array.fold_left (+.) 0. x in
  a /. (float_of_int (Array.length x))

let correlation x0 x1 = Gsl.Stats.correlation x0 x1

let pearson_r x0 x1 = correlation x0 x1

let sort ?(inc=true) x =
  let y = Array.copy x in
  let c = if inc then 1 else (-1) in
  Array.sort (fun a b ->
    if a < b then (-c)
    else if a > b then c
    else 0
  ) y; y

let rank x =
  let _index a x =
    let y = ref [||] in
    let _ = Array.iteri (fun i z ->
      if z = a then y := Array.append !y [|float_of_int (i + 1)|]
    ) x in !y
  in
  let y = sort ~inc:true x in
  let y = Array.map (fun z ->
    let i = _index z y in
    let a = Array.fold_left (+.) 0. i in
    let b = float_of_int (Array.length i) in
    a /. b
  ) x in y

let autocorrelation ?(lag=1) x =
  let n = Array.length x in
  let y = mean x in
  let a = ref 0. in
  let _ = for i = 0 to (n - lag - 1) do
    a := !a +. ((x.(i) -. y) *. (x.(i+lag) -. y))
  done in
  let b = ref 0. in
  let _ = for i = 0 to (n - 1) do
    b := !b +. (x.(i) -. y) ** 2.
  done in
  (!a /. !b)

let covariance ?mean0 ?mean1 x0 x1 =
  match mean0, mean1 with
  | Some m0, Some m1 -> Gsl.Stats.covariance_m m0 x0 m1 x1
  | Some m0, None -> Gsl.Stats.covariance_m m0 x0 (mean x1) x1
  | None, Some m1 -> Gsl.Stats.covariance_m (mean x0) x0 m1 x1
  | None, None -> Gsl.Stats.covariance x0 x1

let kendall_tau = None

let spearman_rho x0 x1 =
  let r0 = rank x0 in
  let r1 = rank x1 in
  let a = covariance r0 r1 in
  let b = (std r0) *. (std r1) in
  a /. b

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

let metropolis_hastings f p n =
  let stepsize = 0.1 in    (* be careful about step size, try 0.01 *)
  let a, b = 1000, 10 in
  let s = Array.make n p in
  for i = 0 to a + b * n - 1 do
    let p' = Array.map (fun x -> gaussian ~sigma:stepsize () +. x) p in
    let y, y' = f p, f p' in
    let p' = (
      if y' >= y then p'
      else if (flat 0. 1.) < (y' /. y) then p'
      else Array.copy p ) in
    Array.iteri (fun i x -> p.(i) <- x) p';
    if (i >= a) && (i mod b = 0) then
      s.( (i - a) / b ) <- (Array.copy p)
  done; s

let gibbs_sampling f p n =
  let a, b = 1000, 10 in
  let m = a + b * n in
  let s = Array.make n p in
  let c = Array.length p in
  for i = 1 to m - 1 do
    for j = 0 to c - 1 do
      p.(j) <- f p j
    done;
    if (i >= a) && (i mod b = 0) then
      s.( (i - a) / b ) <- (Array.copy p)
  done; s





(* ends here *)
