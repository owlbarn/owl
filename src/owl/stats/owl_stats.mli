(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Statistics: random number generators, PDF and CDF functions, and hypothesis
  tests. The module also includes some basic statistical functions such as mean,
  variance, skew, and etc.
 *)


(** {6 Randomisation functions} *)

val shuffle : 'a array -> 'a array
(** ``shuffle x`` return a new array of the shuffled ``x``.  *)

val choose : 'a array -> int -> 'a array
(** ``choose x n`` draw ``n`` samples from ``x`` without replecement.  *)

val sample : 'a array -> int -> 'a array
(** ``sample x n`` draw ``n`` samples from ``x`` with replacement.  *)


(** {6 Basic statistical functions} *)

val sum : float array -> float
(** ``sum x`` returns the summation of the elements in ``x``. *)

val mean : float array -> float
(** ``mean x`` returns the mean of the elements in ``x``. *)

val var : ?mean:float -> float array -> float
(** ``var x`` returns the variance of elements in ``x``. *)

val std : ?mean:float -> float array -> float
(** ``std x`` calculates the standard deviation of ``x``. *)

val sem : ?mean:float -> float array -> float
(** ``sem x`` calculates the standard error of ``x``, also referred to as standard
  error of the mean.
 *)

val absdev : ?mean:float -> float array -> float
(** ``absdev x`` calculates the average absolute deviation of ``x``. *)

val skew : ?mean:float -> ?sd:float -> float array -> float
(** ``skew x`` calculates the skewness (the third standardized moment) of ``x``. *)

val kurtosis : ?mean:float -> ?sd:float -> float array -> float
(** ``kurtosis x`` calculates the Pearson's kurtosis of ``x``, i.e. the fourth
  standardized moment of ``x``.
 *)

val central_moment : int -> float array -> float

val cov : ?m0:float -> ?m1:float -> float array -> float array -> float
(** ``cov x0 x1`` calculates the covariance of ``x0`` and ``x1``, the mean of ``x0``
  and ``x1`` can be specified by ``m0`` and ``m1`` respectively.
 *)

val corrcoef : float array -> float array -> float
(** ``corrcoef x y`` calculates the Pearson correlation of ``x`` and ``y``. Namely,
  ``corrcoef x y = cov(x, y) / (sigma_x * sigma_y)``.
 *)

val kendall_tau : float array -> float array -> float

val spearman_rho : float array -> float array -> float

val autocorrelation : ?lag:int -> float array -> float

val percentile : float array -> float -> float
(** ``percentile x p`` returns the ``p`` percentile of the data ``x``. ``p`` is between
  0. and 100. ``x`` does not need to be sorted beforehand.
 *)

val quantile : float array -> float -> float
(** ``quantile x p`` returns the ``p`` quantile of the data ``x``. ``p`` is between
  0. and 1. ``x`` does not need to be sorted beforehand.
 *)

val first_quartile : float array -> float
(** ``first_quartile x`` returns the first quartile of ``x``, i.e. 25 percentiles. *)

val third_quartile : float array -> float
(** ``third_quartile x`` returns the third quartile of ``x``, i.e. 75 percentiles. *)

val median : float array -> float
(** ``median x`` returns the median of ``x``. *)

val min : float array -> float
(** ``min x`` returns the minimum element in ``x``. *)

val max : float array -> float
(** ``max x`` returns the maximum element in ``x``. *)

val minmax : float array -> float * float
(** ``minmax x`` returns both ``(minimum, maximum)`` elements in ``x``. *)

val min_i : float array -> int

val max_i : float array -> int

val minmax_i : float array -> int * int

val sort : ?inc:bool -> float array -> float array

val argsort : ?inc:bool -> float array -> int array

val rank : ?ties_strategy:[ `Average | `Min | `Max ] -> float array -> float array
(** Computes sample's ranks.

    The ranking order is from the smallest one to the largest. For example
    ``rank [|54.; 74.; 55.; 86.; 56.|]`` returns ``[|1.; 4.; 2.; 5.; 3.|]``.
    Note that the ranking starts with one!

    ``ties_strategy`` controls which ranks are assigned to equal values:

    - ```Average`` the mean of ranks should be assigned to each value.
      {b Default}.
    - ```Min`` the minimum of ranks is assigned to each value.
    - ```Max`` the maximum of ranks is assigned to each value.
 *)

val histogram : float array -> int -> int array

val ecdf : float array -> float array * float array
(** ``ecdf x`` returns ``(x',f)`` which are the empirical cumulative distribution
  function ``f`` of ``x`` at points ``x'``. ``x'`` is just ``x`` sorted in increasing
  order with duplicates removed.
 *)

val z_score : mu:float -> sigma:float -> float array -> float array

val t_score : float array -> float array

val normlise_pdf : float array -> float array


(** {6 MCMC: Markov Chain Monte Carlo} *)

val metropolis_hastings : (float array -> float) -> float array -> int -> float array array
(** TODO: ``metropolis_hastings f p n`` is Metropolis-Hastings MCMC algorithm.
  f is pdf of the p
 *)

val gibbs_sampling : (float array -> int -> float) -> float array -> int -> float array array
(** TODO: ``gibbs_sampling f p n`` is Gibbs sampler. f is a sampler based on the full
  conditional function of all variables
 *)


(** {6 Hypothesis tests} *)

type hypothesis = {
  reject  : bool;    (* reject null hypothesis if ``true`` *)
  p_value : float;   (* p-value of the hypothesis test *)
  score   : float;   (* score has different meaning in different tests *)
}
(** record type contains the result of hypothesis tests. *)

type tail = BothSide | RightSide | LeftSide
(** Types of alternative hypothesis tests: one-side, left-side, or right-side. *)

val z_test : mu:float -> sigma:float -> ?alpha:float -> ?side:tail -> float array -> hypothesis
(** ``z_test ~mu ~sigma ~alpha ~side x`` returns a test decision for the null
  hypothesis that the data ``x`` comes from a normal distribution with mean ``mu``
  and a standard deviation ``sigma``, using the z-test of ``alpha`` significance
  level. The alternative hypothesis is that the mean is not ``mu``.

  The result ``(h,p,z)`` : ``h`` is ``true`` if the test rejects the null hypothesis at
  the ``alpha`` significance level, and ``false`` otherwise. ``p`` is the p-value and
  ``z`` is the z-score.
 *)

 val t_test : mu:float -> ?alpha:float -> ?side:tail -> float array -> hypothesis
(** ``t_test ~mu ~alpha ~side x`` returns a test decision of one-sample t-test
  which is a parametric test of the location parameter when the population
  standard deviation is unknown. ``mu`` is population mean, ``alpha`` is the
  significance level.
 *)

val t_test_paired : ?alpha:float -> ?side:tail -> float array -> float array -> hypothesis
(** ``t_test_paired ~alpha ~side x y`` returns a test decision for the null
  hypothesis that the data in ``x – y`` comes from a normal distribution with
  mean equal to zero and unknown variance, using the paired-sample t-test. *)

val t_test_unpaired : ?alpha:float -> ?side:tail -> ?equal_var:bool -> float array -> float array -> hypothesis
(** ``t_test_unpaired ~alpha ~side ~equal_var x y`` returns a test decision for
  the null hypothesis that the data in vectors ``x`` and ``y`` comes from
  independent random samples from normal distributions with equal means and
  equal but unknown variances, using the two-sample t-test. The alternative
  hypothesis is that the data in ``x`` and ``y`` comes from populations with
  unequal means.

  ``equal_var`` indicates whether two samples have the same variance. If the
  two variances are not the same, the test is referred to as Welche's t-test.
 *)

exception EXN_EMPTY_ARRAY

val ks_test : ?alpha:float -> float array -> (float -> float) -> hypothesis

(** ``ks_test ~alpha x f`` returns a test decision for the null
   hypothesis that the data in vector ``x`` comes from independent
   random samples of the distribution with CDF f. The alternative
   hypothesis is that the data in ``x`` comes from a different
   distribution.

   The result ``(h,p,d)`` : ``h`` is ``true`` if the test rejects the null
   hypothesis at the ``alpha`` significance level, and ``false``
   otherwise. ``p`` is the p-value and ``d`` is the Kolmogorov-Smirnov
   test statistic. *)


val ks2_test : ?alpha:float -> float array -> float array -> hypothesis

(** ``ks2_test ~alpha x y`` returns a test decision for the null
    hypothesis that the data in vectors ``x`` and ``y`` come from
    independent random samples of the same distribution. The
    alternative hypothesis is that the data in ``x`` and ``y`` are sampled
    from different distributions.

    The result ``(h,p,d)``: ``h`` is ``true`` if the test rejects the null
    hypothesis at the ``alpha`` significance level, and ``false``
    otherwise. ``p`` is the p-value and ``d`` is the Kolmogorov-Smirnov
    test statistic.
*)

val var_test : ?alpha:float -> ?side:tail -> variance:float -> float array -> hypothesis
(** ``var_test ~alpha ~side ~variance x`` returns a test decision for the null
  hypothesis that the data in ``x`` comes from a normal distribution with input
  ``variance``, using the chi-square variance test. The alternative hypothesis
  is that ``x`` comes from a normal distribution with a different variance.
 *)

val jb_test : ?alpha:float -> float array -> hypothesis
(** ``jb_test ~alpha x`` returns a test decision for the null hypothesis that the
  data ``x`` comes from a normal distribution with an unknown mean and variance,
  using the Jarque-Bera test.
 *)

val fisher_test : ?alpha:float -> ?side:tail -> int -> int -> int -> int -> hypothesis
(** ``fisher_test ~alpha ~side a b c d`` fisher's exact test for contingency table
    | ``a``, ``b`` |
    | ``c``, ``d`` |

    The result ``(h,p,z)`` : ``h`` is ``true`` if the test rejects the null hypothesis at
    the ``alpha`` significance level, and ``false`` otherwise. ``p`` is the p-value and
    ``z`` is prior odds ratio.
*)

val runs_test : ?alpha:float -> ?side:tail -> ?v:float -> float array -> hypothesis
(** ``runs_test ~alpha ~v x`` returns a test decision for the null hypothesis that
  the data ``x`` comes in random order, against the alternative that they do not,
  by runnign Wald–Wolfowitz runs test. The test is based on the number of runs
  of consecutive values above or below the mean of ``x``. ``~v`` is the reference
  value, the default value is the median of ``x``.
 *)

val mannwhitneyu : ?alpha:float -> ?side:tail -> float array -> float array -> hypothesis
(** ``mannwhitneyu ~alpha ~side x y`` Computes the Mann-Whitney rank test on
    samples x and y. If length of each sample less than 10 and no ties, then
    using exact test (see paper Ying Kuen Cheung and Jerome H. Klotz (1997)
    The Mann Whitney Wilcoxon distribution using linked list
    Statistica Sinica 7 805-813), else usning asymptotic normal distribution.
*)

val wilcoxon : ?alpha:float -> ?side:tail -> float array -> float array -> hypothesis


(** {6 Discrete random variables} *)

val uniform_int_rvs : a:int -> b:int -> int

val hypergeometric_rvs : good:int -> bad:int -> sample:int -> int

val hypergeometric_pdf : int -> good:int -> bad:int -> sample:int -> float

val hypergeometric_logpdf : int -> good:int -> bad:int -> sample:int -> float


(** {6 Continuous random variables} *)

val std_uniform_rvs : unit -> float

val uniform_rvs : a:float -> b:float -> float

val uniform_pdf : float -> a:float -> b:float -> float

val uniform_logpdf : float -> a:float -> b:float -> float

val uniform_cdf : float -> a:float -> b:float -> float

val uniform_logcdf : float -> a:float -> b:float -> float

val uniform_ppf : float -> a:float -> b:float -> float

val uniform_sf : float -> a:float -> b:float -> float

val uniform_logsf : float -> a:float -> b:float -> float

val uniform_isf : float -> a:float -> b:float -> float

val exponential_rvs : lambda:float -> float

val exponential_pdf : float -> lambda:float -> float

val exponential_logpdf : float -> lambda:float -> float

val exponential_cdf : float -> lambda:float -> float

val exponential_logcdf : float -> lambda:float -> float

val exponential_ppf : float -> lambda:float -> float

val exponential_sf : float -> lambda:float -> float

val exponential_logsf : float -> lambda:float -> float

val exponential_isf : float -> lambda:float -> float

val gaussian_rvs : mu:float -> sigma:float -> float

val gaussian_pdf : float -> mu:float -> sigma:float -> float

val gaussian_logpdf : float -> mu:float -> sigma:float -> float

val gaussian_cdf : float -> mu:float -> sigma:float -> float

val gaussian_logcdf : float -> mu:float -> sigma:float -> float

val gaussian_ppf : float -> mu:float -> sigma:float -> float

val gaussian_sf : float -> mu:float -> sigma:float -> float

val gaussian_logsf : float -> mu:float -> sigma:float -> float

val gaussian_isf : float -> mu:float -> sigma:float -> float

val gamma_rvs : shape:float -> scale:float -> float

val gamma_pdf : float -> shape:float -> scale:float -> float

val gamma_logpdf : float -> shape:float -> scale:float -> float

val gamma_cdf : float -> shape:float -> scale:float -> float

val gamma_logcdf : float -> shape:float -> scale:float -> float

val gamma_ppf : float -> shape:float -> scale:float -> float

val gamma_sf : float -> shape:float -> scale:float -> float

val gamma_logsf : float -> shape:float -> scale:float -> float

val gamma_isf : float -> shape:float -> scale:float -> float

val beta_rvs : a:float -> b:float -> float

val beta_pdf : float -> a:float -> b:float -> float

val beta_logpdf : float -> a:float -> b:float -> float

val beta_cdf : float -> a:float -> b:float -> float

val beta_logcdf : float -> a:float -> b:float -> float

val beta_ppf : float -> a:float -> b:float -> float

val beta_sf : float -> a:float -> b:float -> float

val beta_logsf : float -> a:float -> b:float -> float

val beta_isf : float -> a:float -> b:float -> float

val chi2_rvs : df:float -> float

val chi2_pdf : float -> df:float -> float

val chi2_logpdf : float -> df:float -> float

val chi2_cdf : float -> df:float -> float

val chi2_logcdf : float -> df:float -> float

val chi2_ppf : float -> df:float -> float

val chi2_sf : float -> df:float -> float

val chi2_logsf : float -> df:float -> float

val chi2_isf : float -> df:float -> float

val f_rvs : dfnum:float -> dfden:float -> float

val f_pdf : float -> dfnum:float -> dfden:float -> float

val f_logpdf : float -> dfnum:float -> dfden:float -> float

val f_cdf : float -> dfnum:float -> dfden:float -> float

val f_logcdf : float -> dfnum:float -> dfden:float -> float

val f_ppf : float -> dfnum:float -> dfden:float -> float

val f_sf : float -> dfnum:float -> dfden:float -> float

val f_logsf : float -> dfnum:float -> dfden:float -> float

val f_isf : float -> dfnum:float -> dfden:float -> float

val cauchy_rvs : loc:float -> scale:float -> float

val cauchy_pdf : float -> loc:float -> scale:float -> float

val cauchy_logpdf : float -> loc:float -> scale:float -> float

val cauchy_cdf : float -> loc:float -> scale:float -> float

val cauchy_logcdf : float -> loc:float -> scale:float -> float

val cauchy_ppf : float -> loc:float -> scale:float -> float

val cauchy_sf : float -> loc:float -> scale:float -> float

val cauchy_logsf : float -> loc:float -> scale:float -> float

val cauchy_isf : float -> loc:float -> scale:float -> float

val t_rvs : df:float -> loc:float -> scale:float -> float

val t_pdf : float -> df:float -> loc:float -> scale:float -> float

val t_logpdf : float -> df:float -> loc:float -> scale:float -> float

val t_cdf : float -> df:float -> loc:float -> scale:float -> float

val t_logcdf : float -> df:float -> loc:float -> scale:float -> float

val t_ppf : float -> df:float -> loc:float -> scale:float -> float

val t_sf : float -> df:float -> loc:float -> scale:float -> float

val t_logsf : float -> df:float -> loc:float -> scale:float -> float

val t_isf : float -> df:float -> loc:float -> scale:float -> float

val vonmises_rvs : mu:float -> kappa:float -> float

val vonmises_pdf : float -> mu:float -> kappa:float -> float

val vonmises_logpdf : float -> mu:float -> kappa:float -> float

val vonmises_cdf : float -> mu:float -> kappa:float -> float

val vonmises_logcdf : float -> mu:float -> kappa:float -> float

val vonmises_sf : float -> mu:float -> kappa:float -> float

val vonmises_logsf : float -> mu:float -> kappa:float -> float

val lomax_rvs : shape:float -> scale:float -> float

val lomax_pdf : float -> shape:float -> scale:float -> float

val lomax_logpdf : float -> shape:float -> scale:float -> float

val lomax_cdf : float -> shape:float -> scale:float -> float

val lomax_logcdf : float -> shape:float -> scale:float -> float

val lomax_ppf : float -> shape:float -> scale:float -> float

val lomax_sf : float -> shape:float -> scale:float -> float

val lomax_logsf : float -> shape:float -> scale:float -> float

val lomax_isf : float -> shape:float -> scale:float -> float

val weibull_rvs : shape:float -> scale:float -> float

val weibull_pdf : float -> shape:float -> scale:float -> float

val weibull_logpdf : float -> shape:float -> scale:float -> float

val weibull_cdf : float -> shape:float -> scale:float -> float

val weibull_logcdf : float -> shape:float -> scale:float -> float

val weibull_ppf : float -> shape:float -> scale:float -> float

val weibull_sf : float -> shape:float -> scale:float -> float

val weibull_logsf : float -> shape:float -> scale:float -> float

val weibull_isf : float -> shape:float -> scale:float -> float

val laplace_rvs : loc:float -> scale:float -> float

val laplace_pdf : float -> loc:float -> scale:float -> float

val laplace_logpdf : float -> loc:float -> scale:float -> float

val laplace_cdf : float -> loc:float -> scale:float -> float

val laplace_logcdf : float -> loc:float -> scale:float -> float

val laplace_ppf : float -> loc:float -> scale:float -> float

val laplace_sf : float -> loc:float -> scale:float -> float

val laplace_logsf : float -> loc:float -> scale:float -> float

val laplace_isf : float -> loc:float -> scale:float -> float

val gumbel1_rvs : a:float -> b:float -> float

val gumbel1_pdf : float -> a:float -> b:float -> float

val gumbel1_logpdf : float -> a:float -> b:float -> float

val gumbel1_cdf : float -> a:float -> b:float -> float

val gumbel1_logcdf : float -> a:float -> b:float -> float

val gumbel1_ppf : float -> a:float -> b:float -> float

val gumbel1_sf : float -> a:float -> b:float -> float

val gumbel1_logsf : float -> a:float -> b:float -> float

val gumbel1_isf : float -> a:float -> b:float -> float

val gumbel2_rvs : a:float -> b:float -> float

val gumbel2_pdf : float -> a:float -> b:float -> float

val gumbel2_logpdf : float -> a:float -> b:float -> float

val gumbel2_cdf : float -> a:float -> b:float -> float

val gumbel2_logcdf : float -> a:float -> b:float -> float

val gumbel2_ppf : float -> a:float -> b:float -> float

val gumbel2_sf : float -> a:float -> b:float -> float

val gumbel2_logsf : float -> a:float -> b:float -> float

val gumbel2_isf : float -> a:float -> b:float -> float

val logistic_rvs : loc:float -> scale:float -> float

val logistic_pdf : float -> loc:float -> scale:float -> float

val logistic_logpdf : float -> loc:float -> scale:float -> float

val logistic_cdf : float -> loc:float -> scale:float -> float

val logistic_logcdf : float -> loc:float -> scale:float -> float

val logistic_ppf : float -> loc:float -> scale:float -> float

val logistic_sf : float -> loc:float -> scale:float -> float

val logistic_logsf : float -> loc:float -> scale:float -> float

val logistic_isf : float -> loc:float -> scale:float -> float

val lognormal_rvs : mu:float -> sigma:float -> float

val lognormal_pdf : float -> mu:float -> sigma:float -> float

val lognormal_logpdf : float -> mu:float -> sigma:float -> float

val lognormal_cdf : float -> mu:float -> sigma:float -> float

val lognormal_logcdf : float -> mu:float -> sigma:float -> float

val lognormal_ppf : float -> mu:float -> sigma:float -> float

val lognormal_sf : float -> mu:float -> sigma:float -> float

val lognormal_logsf : float -> mu:float -> sigma:float -> float

val lognormal_isf : float -> mu:float -> sigma:float -> float

val rayleigh_rvs : sigma:float -> float

val rayleigh_pdf : float -> sigma:float -> float

val rayleigh_logpdf : float -> sigma:float -> float

val rayleigh_cdf : float -> sigma:float -> float

val rayleigh_logcdf : float -> sigma:float -> float

val rayleigh_ppf : float -> sigma:float -> float

val rayleigh_sf : float -> sigma:float -> float

val rayleigh_logsf : float -> sigma:float -> float

val rayleigh_isf : float -> sigma:float -> float



(* ends here *)
