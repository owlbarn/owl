(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(**
Statistics: random number generators, PDF and CDF functions, and hypothesis
tests. The module also includes some basic statistical functions such as mean,
variance, skew, and etc.
 *)

(** {5 Randomisation functions} *)

val shuffle : 'a array -> 'a array
(** [shuffle x] return a new array of the shuffled [x].  *)

val choose : 'a array -> int -> 'a array
(** [choose x n] draw [n] samples from [x] without replecement.  *)

val sample : 'a array -> int -> 'a array
(** [sample x n] draw [n] samples from [x] with replacement.  *)

(** {5 Basic statistical functions} *)

val sum : float array -> float
(** [sum x] returns the summation of the elements in [x]. *)

val mean : float array -> float
(** [mean x] returns the mean of the elements in [x]. *)

val var : ?mean:float -> float array -> float
(** [var x] returns the variance of elements in [x]. *)

val std : ?mean:float -> float array -> float
(** [std x] calculates the standard deviation of [x]. *)

val sem : ?mean:float -> float array -> float
(**
[sem x] calculates the standard error of [x], also referred to as
standard error of the mean.
 *)

val absdev : ?mean:float -> float array -> float
(** [absdev x] calculates the average absolute deviation of [x]. *)

val skew : ?mean:float -> ?sd:float -> float array -> float
(** [skew x] calculates the skewness (the third standardized moment) of [x]. *)

val kurtosis : ?mean:float -> ?sd:float -> float array -> float
(**
[kurtosis x] calculates the Pearson's kurtosis of [x], i.e. the fourth
standardized moment of [x].
 *)

val central_moment : int -> float array -> float
(** [central_moment n x] calculates the [n] th central moment of [x]. *)

val cov : ?m0:float -> ?m1:float -> float array -> float array -> float
(**
[cov x0 x1] calculates the covariance of [x0] and [x1], the mean of
[x0] and [x1] can be specified by [m0] and [m1] respectively.
 *)

(** [concordant x y] calculates the number of concordant pairs in the 
    given arrays [x] and [y]. A pair of observations \((x_i, y_i)\) and 
    \((x_j, y_j)\) is concordant if both elements in one pair are either 
    greater than or less than both elements in the other pair, i.e., 
    \((x_i > x_j) \land (y_i > y_j)\) or \((x_i < x_j) \land (y_i < y_j)\).
    
    The function returns the count of such pairs.

    @param x The first array of observations.
    @param y The second array of observations.
    @return The number of concordant pairs.
*)
val concordant : 'a array -> 'b array -> int

(** [discordant x y] calculates the number of discordant pairs in the 
    given arrays [x] and [y]. A pair of observations \((x_i, y_i)\) and 
    \((x_j, y_j)\) is discordant if one element in one pair is greater 
    than the corresponding element in the other pair, and the other 
    element is smaller, i.e., \((x_i > x_j) \land (y_i < y_j)\) or 
    \((x_i < x_j) \land (y_i > y_j)\).
    
    The function returns the count of such pairs.

    @param x The first array of observations.
    @param y The second array of observations.
    @return The number of discordant pairs.
*)
val discordant : 'a array -> 'b array -> int

val corrcoef : float array -> float array -> float
(**
[corrcoef x y] calculates the Pearson correlation of [x] and [y]. Namely,
[corrcoef x y = cov(x, y) / (sigma_x * sigma_y)].
 *)

val kendall_tau : float array -> float array -> float
(** [kendall_tau x y] calculates the Kendall Tau correlation between [x] and [y]. *)

val spearman_rho : float array -> float array -> float
(** [spearman_rho x y] calculates the Spearman Rho correlation between [x] and [y]. *)

val autocorrelation : ?lag:int -> float array -> float
(** [autocorrelation ~lag x] calculates the autocorrelation of [x] with the given [lag]. *)

val percentile : float array -> float -> float
(** [percentile x p] returns the [p] percentile of the data [x]. [p] is between
0. and 100. [x] does not need to be sorted beforehand.
 *)

val quantile : float array -> float -> float
(** [quantile x p] returns the [p] quantile of the data
    [x]. [x] does not need to be sorted beforehand. When computing
    several quantiles on the same data, it is more efficient to
    "pre-apply" the function, as in ``let f = quantile x in List.map f
    [ 0.1 ; 0.5 ]``, in which case the data is sorted only once.

    Raises Invalid_argument if [p] is not between 0 and 1.
*)

val first_quartile : float array -> float
(** [first_quartile x] returns the first quartile of [x], i.e. 25 percentiles. *)

val third_quartile : float array -> float
(** [third_quartile x] returns the third quartile of [x], i.e. 75 percentiles. *)

val interquartile : float array -> float
(** [interquartile x] returns the interquartile range of [x]
    which is defined as the first quartile subtracted from the third quartile.
*)

val median : float array -> float
(** [median x] returns the median of [x]. *)

val min : float array -> float
(** [min x] returns the minimum element in [x]. *)

val max : float array -> float
(** [max x] returns the maximum element in [x]. *)

val minmax : float array -> float * float
(** [minmax x] returns both [(minimum, maximum)] elements in [x]. *)

val min_i : float array -> int
(** [min_i x] returns the index of the minimum in [x]. *)

val max_i : float array -> int
(** [max_i x] returns the index of the maximum in [x]. *)

val minmax_i : float array -> int * int
(** [minmax_i x] returns the indices of both minimum and maximum in [x]. *)

val sort : ?inc:bool -> float array -> float array
(**
[sort x] sorts the elements in the [x] in increasing order if
[inc = true], otherwise in decreasing order if [inc=false]. By default,
[inc] is [true]. Note a copy is returned, the original data is not modified.
 *)

val argsort : ?inc:bool -> float array -> int array
(**
[argsort x] sorts the elements in [x] and returns the indices mapping of
the elements in the current array to their original position in [x].

The sorting is in increasing order if [inc = true], otherwise in decreasing
order if [inc=false]. By default, [inc] is [true].
 *)

val rank : ?ties_strategy:[ `Average | `Min | `Max ] -> float array -> float array
(**
Computes sample's ranks.

The ranking order is from the smallest one to the largest. For example
[rank [|54.; 74.; 55.; 86.; 56.|]] returns [[|1.; 4.; 2.; 5.; 3.|]].
Note that the ranking starts with one!

[ties_strategy] controls which ranks are assigned to equal values:

- [Average] the mean of ranks should be assigned to each value.
  {b Default}.
- [Min] the minimum of ranks is assigned to each value.
- [Max] the maximum of ranks is assigned to each value.
 *)

type histogram = Owl_base_stats.histogram
(**
Type for computed histograms, with optional weighted counts and normalized
counts.
*)

val histogram
  :  [ `Bins of float array | `N of int ]
  -> ?weights:float array
  -> float array
  -> histogram
(**
[histogram bins x] creates a histogram from values in [x]. If bins matches
[ `N n] it will construct [n] equally spaced bins from the minimum to
the maximum in [x]. If bins matches [ `Bins b], [b] is taken as the
sorted array of boundaries of adjacent bin intervals. Bin boundaries are taken
as left-inclusive, right-exclusive, except for the last bin which is also
right-inclusive. Values outside the bins are dropped silently.

[histogram bins ~weights x] creates a weighted histogram with the given
[weights] which must match [x] in length. The bare counts are also
provided.

Returns a histogram including the [n+1] bin boundaries, [n] counts and
weighted counts if applicable, but without normalisation.
*)

val histogram_sorted
  :  [ `Bins of float array | `N of int ]
  -> ?weights:float array
  -> float array
  -> histogram
(**
[histogram_sorted bins x] is like [histogram] but assumes that [x] is sorted
already. This increases efficiency if there are less bins than data. Undefined
results if [x] is not in fact sorted.
*)

val normalise : histogram -> histogram
(** [normalize hist] calculates a probability mass function using
[hist.weighted_counts] if present, otherwise using [hist.counts]. The
result is stored in the [normalised_counts] field and sums to one. *)

val normalise_density : histogram -> histogram
(** [normalize_density hist] calculates a probability density function using
[hist.weighted_counts] if present, otherwise using [hist.counts]. The
result is normalized as a density that is piecewise constant over the bin
intervals. That is, the sum over density times corresponding bin width is
one. If bins are infinitely wide, their density is 0 and the sum over width
times density of all finite bins is the total weight in the finite bins. The
result is stored in the [density] field. *)

val pp_hist : Format.formatter -> histogram -> unit
  [@@ocaml.toplevel_printer]
(** Pretty-print summary information on a histogram record *)

val ecdf : float array -> float array * float array
(**
[ecdf x] returns [(x',f)] which are the empirical cumulative distribution
function [f] of [x] at points [x']. [x'] is just [x] sorted in increasing
order with duplicates removed.
The function does not support [nan] values in the array [x].
 *)

val z_score : mu:float -> sigma:float -> float array -> float array
(** [z_score x] calculates the z score of a given array [x]. *)

val t_score : float array -> float array
(** [t_score x] calculates the t score of a given array [x]. *)

val normalise_pdf : float array -> float array
(** [normalise_pdf arr] takes an array of floats [arr] representing a probability density function (PDF)
    and returns a new array where the values are normalized so that the sum of the array equals 1.

    @param arr The input array representing the unnormalized PDF.
    @return A new array of the same length as [arr], with values normalized to ensure the sum is 1.
*)

val tukey_fences : ?k:float -> float array -> float * float
(**
[tukey_fences ?k x] returns a tuple of the lower and upper boundaries for
values that are not outliers. [k] defaults to the standard coefficient of
[1.5]. For first and third quartiles [Q1] and `Q3`, the range is computed
as follows:

{math 
  (Q1 - k*(Q3-Q1), Q3 + k*(Q3-Q1))}
*)

val gaussian_kde
  :  ?bandwidth:[ `Silverman | `Scott ]
  -> ?n_points:int
  -> float array
  -> float array * float array
(**
[gaussian_kde x] is a Gaussian kernel density estimator. The estimation of
the pdf runs in `O(sample_size * n_points)`, and returns an array tuple
[(a, b)] where [a] is a uniformly spaced points from the sample range at
which the density function was estimated, and [b] is the estimates at these
points.

Bandwidth selection rules is as follows:
  * Silverman: use `rule-of-thumb` for choosing the bandwidth. It defaults to [0.9 * min(SD, IQR / 1.34) * n^-0.2].
  * Scott: same as Silverman, but with a factor, equal to [1.06].

The default bandwidth value is [Scott].
 *)

(** {5 MCMC: Markov Chain Monte Carlo} *)

val metropolis_hastings
  :  (float array -> float)
  -> float array
  -> int
  -> float array array
(** [metropolis_hastings target_density initial_state num_samples] performs
    the Metropolis-Hastings algorithm to generate samples from a target
    distribution.

    The Metropolis-Hastings algorithm is a Markov Chain Monte Carlo (MCMC) 
    method that generates a sequence of samples from a probability distribution 
    for which direct sampling is difficult. The algorithm uses a proposal 
    distribution to explore the state space, accepting or rejecting proposed 
    moves based on the ratio of the target densities.

    @param target_density A function that computes the density (up to a normalizing constant) 
    of the target distribution at a given point.
    @param initial_state The starting point of the Markov chain, represented as an array of floats.
    @param num_samples The number of samples to generate.
    @return A 2D array where each row represents a sample generated by the Metropolis-Hastings 
    algorithm.
*)

val gibbs_sampling
  :  (float array -> int -> float)
  -> float array
  -> int
  -> float array array
(** [gibbs_sampling conditional_sampler initial_state num_samples] performs
    Gibbs sampling to generate samples from a multivariate distribution.

    Gibbs sampling is a Markov Chain Monte Carlo (MCMC) algorithm used to 
    generate samples from a joint distribution when direct sampling is difficult.
    It works by iteratively sampling each variable from its conditional distribution,
    given the current values of all other variables.

    @param conditional_sampler A function that takes the current state of the variables 
    (as a float array) and the index of the variable to sample, and returns a new value 
    for that variable sampled from its conditional distribution.
    @param initial_state The starting point of the Markov chain, represented as an array of floats.
    @param num_samples The number of samples to generate.
    @return A 2D array where each row represents a sample generated by the Gibbs sampling algorithm.
*)


(** {5 Hypothesis tests} *)

type hypothesis =
  { reject : bool
  ; (* reject null hypothesis if [true] *)
    p_value : float
  ; (* p-value of the hypothesis test *)
    score : float (* score has different meaning in different tests *)
  }
(** Record type contains the result of a hypothesis test. *)

type tail =
  | BothSide
  | RightSide
  | LeftSide
      (** Types of alternative hypothesis tests: one-side, left-side, or right-side. *)

val pp_hypothesis : Format.formatter -> hypothesis -> unit
  [@@ocaml.toplevel_printer]
(** Pretty printer of hypothesis type *)

val z_test
  :  mu:float
  -> sigma:float
  -> ?alpha:float
  -> ?side:tail
  -> float array
  -> hypothesis
(**
[z_test ~mu ~sigma ~alpha ~side x] returns a test decision for the null
hypothesis that the data [x] comes from a normal distribution with mean [mu]
and a standard deviation [sigma], using the z-test of [alpha] significance
level. The alternative hypothesis is that the mean is not [mu].

The result [(h,p,z)] : [h] is [true] if the test rejects the null hypothesis at
the [alpha] significance level, and [false] otherwise. [p] is the p-value and
[z] is the z-score.
 *)

val t_test : mu:float -> ?alpha:float -> ?side:tail -> float array -> hypothesis
(**
[t_test ~mu ~alpha ~side x] returns a test decision of one-sample t-test
which is a parametric test of the location parameter when the population
standard deviation is unknown. [mu] is population mean, [alpha] is the
significance level.
 *)

val t_test_paired : ?alpha:float -> ?side:tail -> float array -> float array -> hypothesis
(**
[t_test_paired ~alpha ~side x y] returns a test decision for the null
hypothesis that the data in [x – y] comes from a normal distribution with
mean equal to zero and unknown variance, using the paired-sample t-test. *)

val t_test_unpaired
  :  ?alpha:float
  -> ?side:tail
  -> ?equal_var:bool
  -> float array
  -> float array
  -> hypothesis
(**
[t_test_unpaired ~alpha ~side ~equal_var x y] returns a test decision for
the null hypothesis that the data in vectors [x] and [y] comes from
independent random samples from normal distributions with equal means and
equal but unknown variances, using the two-sample t-test. The alternative
hypothesis is that the data in [x] and [y] comes from populations with
unequal means.

[equal_var] indicates whether two samples have the same variance. If the
two variances are not the same, the test is referred to as Welche's t-test.
 *)

val ks_test : ?alpha:float -> float array -> (float -> float) -> hypothesis
(**
[ks_test ~alpha x f] returns a test decision for the null
hypothesis that the data in vector [x] comes from independent
random samples of the distribution with CDF f. The alternative
hypothesis is that the data in [x] comes from a different
distribution.

The result [(h,p,d)] : [h] is [true] if the test rejects the null
hypothesis at the [alpha] significance level, and [false]
otherwise. [p] is the p-value and [d] is the Kolmogorov-Smirnov
test statistic.
*)

val ks2_test : ?alpha:float -> float array -> float array -> hypothesis
(**
[ks2_test ~alpha x y] returns a test decision for the null
hypothesis that the data in vectors [x] and [y] come from
independent random samples of the same distribution. The
alternative hypothesis is that the data in [x] and [y] are sampled
from different distributions.

The result [(h,p,d)]: [h] is [true] if the test rejects the null
hypothesis at the [alpha] significance level, and [false]
otherwise. [p] is the p-value and [d] is the Kolmogorov-Smirnov
test statistic.
*)

val var_test : ?alpha:float -> ?side:tail -> variance:float -> float array -> hypothesis
(**
[var_test ~alpha ~side ~variance x] returns a test decision for the null
hypothesis that the data in [x] comes from a normal distribution with input
[variance], using the chi-square variance test. The alternative hypothesis
is that [x] comes from a normal distribution with a different variance.
 *)

val jb_test : ?alpha:float -> float array -> hypothesis
(**
[jb_test ~alpha x] returns a test decision for the null hypothesis that the
data [x] comes from a normal distribution with an unknown mean and variance,
using the Jarque-Bera test.
 *)

val fisher_test : ?alpha:float -> ?side:tail -> int -> int -> int -> int -> hypothesis
(**
[fisher_test ~alpha ~side a b c d] fisher's exact test for contingency table
| [a], [b] |
| [c], [d] |

The result [(h,p,z)] : [h] is [true] if the test rejects the null hypothesis at
the [alpha] significance level, and [false] otherwise. [p] is the p-value and
[z] is prior odds ratio.
*)

val runs_test : ?alpha:float -> ?side:tail -> ?v:float -> float array -> hypothesis
(**
[runs_test ~alpha ~v x] returns a test decision for the null hypothesis that
the data [x] comes in random order, against the alternative that they do not,
by running Wald–Wolfowitz runs test. The test is based on the number of runs
of consecutive values above or below the mean of [x]. [~v] is the reference
value, the default value is the median of [x].
 *)

val mannwhitneyu : ?alpha:float -> ?side:tail -> float array -> float array -> hypothesis
(**
[mannwhitneyu ~alpha ~side x y] Computes the Mann-Whitney rank test on
samples x and y. If length of each sample less than 10 and no ties, then
using exact test (see paper Ying Kuen Cheung and Jerome H. Klotz (1997)
The Mann Whitney Wilcoxon distribution using linked list
Statistica Sinica 7 805-813), else usning asymptotic normal distribution.
*)

val wilcoxon : ?alpha:float -> ?side:tail -> float array -> float array -> hypothesis
(** [wilcoxon ?alpha ?side x y] performs the Wilcoxon signed-rank test on the paired samples 
    [x] and [y].

    The Wilcoxon signed-rank test is a non-parametric statistical hypothesis test 
    used to compare two related samples, matched samples, or repeated measurements 
    on a single sample to assess whether their population mean ranks differ.

    @param alpha The significance level for the test, typically set to 0.05 by default. 
    This parameter is optional.
    @param side Specifies the alternative hypothesis. It determines whether the test 
    is one-sided or two-sided. The default is usually a two-sided test.
    @param x The first array of sample data.
    @param y The second array of sample data.
    @return A hypothesis type, indicating whether to reject the null hypothesis 
    or not based on the test.
*)


(** {5 Discrete random variables} *)

(**
    The [_rvs] functions generate random numbers according to
    the specified distribution.  [_pdf] are "density" functions
    that return the probability of the element specified by the
    arguments, while [_cdf] functions are cumulative distribution
    functions that return the probability of all elements
    less than or equal to the chosen element, and [_sf] functions
    are survival functions returning one minus the corresponding CDF
    function.  `log` versions of functions return the
    result for the natural logarithm of a chosen element.
 *)

val uniform_int_rvs : a:int -> b:int -> int
(**
[uniform_rvs ~a ~b] returns a random uniformly distributed integer
between [a] and [b], inclusive.  *)

val binomial_rvs : p:float -> n:int -> int
(**
[binomial_rvs p n] returns a random integer representing the number of
successes in [n] trials with probability of success [p] on each trial.
*)

val binomial_pdf : int -> p:float -> n:int -> float
(**
[binomial_pdf k ~p ~n] returns the binomially distributed probability
of [k] successes in [n] trials with probability [p] of success on
each trial.
*)

val binomial_logpdf : int -> p:float -> n:int -> float
(**
[binomial_logpdf k ~p ~n] returns the log-binomially distributed probability
of [k] successes in [n] trials with probability [p] of success on
each trial.
*)

val binomial_cdf : int -> p:float -> n:int -> float
(**
[binomial_cdf k ~p ~n] returns the binomially distributed cumulative
probability of less than or equal to [k] successes in [n] trials,
with probability [p] on each trial.
*)

val binomial_logcdf : int -> p:float -> n:int -> float
(**
[binomial_logcdf k ~p ~n] returns the log-binomially distributed cumulative
probability of less than or equal to [k] successes in [n] trials,
with probability [p] on each trial.
*)

val binomial_sf : int -> p:float -> n:int -> float
(**
[binomial_sf k ~p ~n] is the binomial survival function, i.e.
[1 - (binomial_cdf k ~p ~n)].
*)

val binomial_logsf : int -> p:float -> n:int -> float
(**
[binomial_loggf k ~p ~n] is the logbinomial survival function, i.e.
[1 - (binomial_logcdf k ~p ~n)].
*)

val hypergeometric_rvs : good:int -> bad:int -> sample:int -> int
(**
[hypergeometric_rvs ~good ~bad ~sample] returns a random hypergeometrically
distributed integer representing the number of successes in a sample (without
replacement) of size [~sample] from a population with [~good] successful
elements and [~bad] unsuccessful elements.
*)

val hypergeometric_pdf : int -> good:int -> bad:int -> sample:int -> float
(**
[hypergeometric_pdf k ~good ~bad ~sample] returns the hypergeometrically
distributed probability of [k] successes in a sample (without replacement) of
[~sample] elements from a population containing [~good] successful elements
and [~bad] unsuccessful ones.
*)

val hypergeometric_logpdf : int -> good:int -> bad:int -> sample:int -> float
(**
[hypergeometric_logpdf k ~good ~bad ~sample] returns a value equivalent to a
log-transformed result from [hypergeometric_pdf].
*)

val multinomial_rvs : int -> p:float array -> int array
(**
[multinomial_rvs n ~p] generates random numbers of multinomial distribution
from [n] trials. The probability mass function is as follows.

{math
  P(x) = \frac{n!}{{x_1}! \cdot\cdot\cdot {x_k}!} p_{1}^{x_1} \cdot\cdot\cdot p_{k}^{x_k}
}

[p] is the probability mass of [k] categories. The elements in [p] should
all be positive (result is undefined if there are negative values), but they 
don't need to sum to 1: the result is the same whether or not [p] is normalized. 
For implementation details, refer to :cite:`davis1993computer`.
 *)

val multinomial_pdf : int array -> p:float array -> float
(**
[multinomial_rvs x ~p] return the probability of [x] given the probability
mass of a multinomial distribution.
 *)

val multinomial_logpdf : int array -> p:float array -> float
(**
[multinomial_rvs x ~p] returns the logarithm probability of [x] given the
probability mass of a multinomial distribution.
 *)

val categorical_rvs : float array -> int
(**
[categorical_rvs p] returns the value of a random variable which follows the
categorical distribution. This is equavalent to only one trial from
[multinomial_rvs] function, so it is just a simple wrapping.
 *)

(** {5 Continuous random variables} *)
val std_uniform_rvs : unit -> float
(** [std_uniform_rvs ()] generates a random variate from the standard uniform 
    distribution over the interval \[0, 1\).

    @return A float representing a random sample from the standard uniform distribution.
*)

val uniform_rvs : a:float -> b:float -> float
(** [uniform_rvs ~a ~b] generates a random variate from the uniform distribution 
    over the interval \[a, b\).

    @param a The lower bound of the interval.
    @param b The upper bound of the interval.
    @return A float representing a random sample from the uniform distribution over \[a, b\).
*)

val uniform_pdf : float -> a:float -> b:float -> float
(** [uniform_pdf x ~a ~b] computes the probability density function (PDF) 
    of the uniform distribution at the point [x] over the interval \[a, b\).

    @param x The point at which to evaluate the PDF.
    @param a The lower bound of the interval.
    @param b The upper bound of the interval.
    @return The PDF value at [x].
*)

val uniform_logpdf : float -> a:float -> b:float -> float
(** [uniform_logpdf x ~a ~b] computes the natural logarithm of the probability density function 
    (log-PDF) of the uniform distribution at the point [x] over the interval \[a, b\).

    @param x The point at which to evaluate the log-PDF.
    @param a The lower bound of the interval.
    @param b The upper bound of the interval.
    @return The log-PDF value at [x].
*)

val uniform_cdf : float -> a:float -> b:float -> float
(** [uniform_cdf x ~a ~b] computes the cumulative distribution function (CDF) 
    of the uniform distribution at the point [x] over the interval \[a, b\).

    @param x The point at which to evaluate the CDF.
    @param a The lower bound of the interval.
    @param b The upper bound of the interval.
    @return The CDF value at [x].
*)

val uniform_logcdf : float -> a:float -> b:float -> float
(** [uniform_logcdf x ~a ~b] computes the natural logarithm of the cumulative distribution function 
    (log-CDF) of the uniform distribution at the point [x] over the interval \[a, b\).

    @param x The point at which to evaluate the log-CDF.
    @param a The lower bound of the interval.
    @param b The upper bound of the interval.
    @return The log-CDF value at [x].
*)

val uniform_ppf : float -> a:float -> b:float -> float
(** [uniform_ppf q ~a ~b] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the uniform distribution 
    for a given probability [q] over the interval \[a, b\).

    @param q The probability for which to compute the corresponding quantile.
    @param a The lower bound of the interval.
    @param b The upper bound of the interval.
    @return The quantile corresponding to [q].
*)

val uniform_sf : float -> a:float -> b:float -> float
(** [uniform_sf x ~a ~b] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the uniform distribution 
    at the point [x] over the interval \[a, b\).

    @param x The point at which to evaluate the SF.
    @param a The lower bound of the interval.
    @param b The upper bound of the interval.
    @return The SF value at [x].
*)

val uniform_logsf : float -> a:float -> b:float -> float
(** [uniform_logsf x ~a ~b] computes the natural logarithm of the survival function 
    (log-SF) of the uniform distribution at the point [x] over the interval \[a, b\).

    @param x The point at which to evaluate the log-SF.
    @param a The lower bound of the interval.
    @param b The upper bound of the interval.
    @return The log-SF value at [x].
*)

val uniform_isf : float -> a:float -> b:float -> float
(** [uniform_isf q ~a ~b] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the uniform distribution 
    for a given probability [q] over the interval \[a, b\).

    @param q The probability for which to compute the corresponding value from the ISF.
    @param a The lower bound of the interval.
    @param b The upper bound of the interval.
    @return The value corresponding to [q] from the ISF.
*)

val exponential_rvs : lambda:float -> float
(** [exponential_rvs ~lambda] generates a random variate from the exponential 
    distribution with rate parameter [lambda].

    @param lambda The rate parameter of the exponential distribution (must be positive).
    @return A float representing a random sample from the exponential distribution.
*)

val exponential_pdf : float -> lambda:float -> float
(** [exponential_pdf x ~lambda] computes the probability density function (PDF) 
    of the exponential distribution at the point [x] with rate parameter [lambda].

    @param x The point at which to evaluate the PDF.
    @param lambda The rate parameter of the exponential distribution (must be positive).
    @return The PDF value at [x].
*)

val exponential_logpdf : float -> lambda:float -> float
(** [exponential_logpdf x ~lambda] computes the natural logarithm of the probability density function 
    (log-PDF) of the exponential distribution at the point [x] with rate parameter [lambda].

    @param x The point at which to evaluate the log-PDF.
    @param lambda The rate parameter of the exponential distribution (must be positive).
    @return The log-PDF value at [x].
*)

val exponential_cdf : float -> lambda:float -> float
(** [exponential_cdf x ~lambda] computes the cumulative distribution function (CDF) 
    of the exponential distribution at the point [x] with rate parameter [lambda].

    @param x The point at which to evaluate the CDF.
    @param lambda The rate parameter of the exponential distribution (must be positive).
    @return The CDF value at [x].
*)

val exponential_logcdf : float -> lambda:float -> float
(** [exponential_logcdf x ~lambda] computes the natural logarithm of the cumulative distribution function 
    (log-CDF) of the exponential distribution at the point [x] with rate parameter [lambda].

    @param x The point at which to evaluate the log-CDF.
    @param lambda The rate parameter of the exponential distribution (must be positive).
    @return The log-CDF value at [x].
*)

val exponential_ppf : float -> lambda:float -> float
(** [exponential_ppf q ~lambda] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the exponential distribution 
    for a given probability [q] with rate parameter [lambda].

    @param q The probability for which to compute the corresponding quantile.
    @param lambda The rate parameter of the exponential distribution (must be positive).
    @return The quantile corresponding to [q].
*)

val exponential_sf : float -> lambda:float -> float
(** [exponential_sf x ~lambda] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the exponential distribution 
    at the point [x] with rate parameter [lambda].

    @param x The point at which to evaluate the SF.
    @param lambda The rate parameter of the exponential distribution (must be positive).
    @return The SF value at [x].
*)

val exponential_logsf : float -> lambda:float -> float
(** [exponential_logsf x ~lambda] computes the natural logarithm of the survival function 
    (log-SF) of the exponential distribution at the point [x] with rate parameter [lambda].

    @param x The point at which to evaluate the log-SF.
    @param lambda The rate parameter of the exponential distribution (must be positive).
    @return The log-SF value at [x].
*)

val exponential_isf : float -> lambda:float -> float
(** [exponential_isf q ~lambda] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the exponential distribution 
    for a given probability [q] with rate parameter [lambda].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param lambda The rate parameter of the exponential distribution (must be positive).
    @return The value corresponding to [q] from the ISF.
*)


val exponpow_rvs : a:float -> b:float -> float
(**
{math 
  p(x) dx = (1/(2 a Gamma(1+1/b))) * exp(-|x/a|^b) dx}

 *)

 val exponpow_pdf : float -> a:float -> b:float -> float
(** [exponpow_pdf x ~a ~b] computes the probability density function (PDF) 
    of the exponential power distribution at the point [x] with shape 
    parameters [a] and [b].

    @param x The point at which to evaluate the PDF.
    @param a The scale parameter of the distribution.
    @param b The shape parameter of the distribution.
    @return The PDF value at [x].
*)

val exponpow_logpdf : float -> a:float -> b:float -> float
(** [exponpow_logpdf x ~a ~b] computes the natural logarithm of the probability 
    density function (log-PDF) of the exponential power distribution at the point 
    [x] with shape parameters [a] and [b].

    @param x The point at which to evaluate the log-PDF.
    @param a The scale parameter of the distribution.
    @param b The shape parameter of the distribution.
    @return The log-PDF value at [x].
*)

val exponpow_cdf : float -> a:float -> b:float -> float
(** [exponpow_cdf x ~a ~b] computes the cumulative distribution function (CDF) 
    of the exponential power distribution at the point [x] with shape parameters 
    [a] and [b].

    @param x The point at which to evaluate the CDF.
    @param a The scale parameter of the distribution.
    @param b The shape parameter of the distribution.
    @return The CDF value at [x].
*)

val exponpow_logcdf : float -> a:float -> b:float -> float
(** [exponpow_logcdf x ~a ~b] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the exponential power distribution at the 
    point [x] with shape parameters [a] and [b].

    @param x The point at which to evaluate the log-CDF.
    @param a The scale parameter of the distribution.
    @param b The shape parameter of the distribution.
    @return The log-CDF value at [x].
*)

val exponpow_sf : float -> a:float -> b:float -> float
(** [exponpow_sf x ~a ~b] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the exponential power 
    distribution at the point [x] with shape parameters [a] and [b].

    @param x The point at which to evaluate the SF.
    @param a The scale parameter of the distribution.
    @param b The shape parameter of the distribution.
    @return The SF value at [x].
*)

val exponpow_logsf : float -> a:float -> b:float -> float
(** [exponpow_logsf x ~a ~b] computes the natural logarithm of the survival function 
    (log-SF) of the exponential power distribution at the point [x] with shape 
    parameters [a] and [b].

    @param x The point at which to evaluate the log-SF.
    @param a The scale parameter of the distribution.
    @param b The shape parameter of the distribution.
    @return The log-SF value at [x].
*)

val gaussian_rvs : mu:float -> sigma:float -> float
(** [gaussian_rvs ~mu ~sigma] generates a random variate from the Gaussian 
    (normal) distribution with mean [mu] and standard deviation [sigma].

    @param mu The mean of the distribution.
    @param sigma The standard deviation of the distribution.
    @return A float representing a random sample from the Gaussian distribution.
*)

val gaussian_pdf : float -> mu:float -> sigma:float -> float
(** [gaussian_pdf x ~mu ~sigma] computes the probability density function (PDF) 
    of the Gaussian (normal) distribution at the point [x] with mean [mu] and 
    standard deviation [sigma].

    @param x The point at which to evaluate the PDF.
    @param mu The mean of the distribution.
    @param sigma The standard deviation of the distribution.
    @return The PDF value at [x].
*)

val gaussian_logpdf : float -> mu:float -> sigma:float -> float
(** [gaussian_logpdf x ~mu ~sigma] computes the natural logarithm of the probability 
    density function (log-PDF) of the Gaussian (normal) distribution at the point 
    [x] with mean [mu] and standard deviation [sigma].

    @param x The point at which to evaluate the log-PDF.
    @param mu The mean of the distribution.
    @param sigma The standard deviation of the distribution.
    @return The log-PDF value at [x].
*)

val gaussian_cdf : float -> mu:float -> sigma:float -> float
(** [gaussian_cdf x ~mu ~sigma] computes the cumulative distribution function (CDF) 
    of the Gaussian (normal) distribution at the point [x] with mean [mu] and 
    standard deviation [sigma].

    @param x The point at which to evaluate the CDF.
    @param mu The mean of the distribution.
    @param sigma The standard deviation of the distribution.
    @return The CDF value at [x].
*)

val gaussian_logcdf : float -> mu:float -> sigma:float -> float
(** [gaussian_logcdf x ~mu ~sigma] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the Gaussian (normal) distribution at the 
    point [x] with mean [mu] and standard deviation [sigma].

    @param x The point at which to evaluate the log-CDF.
    @param mu The mean of the distribution.
    @param sigma The standard deviation of the distribution.
    @return The log-CDF value at [x].
*)

val gaussian_ppf : float -> mu:float -> sigma:float -> float
(** [gaussian_ppf q ~mu ~sigma] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the Gaussian (normal) distribution 
    for a given probability [q] with mean [mu] and standard deviation [sigma].

    @param q The probability for which to compute the corresponding quantile.
    @param mu The mean of the distribution.
    @param sigma The standard deviation of the distribution.
    @return The quantile corresponding to [q].
*)

val gaussian_sf : float -> mu:float -> sigma:float -> float
(** [gaussian_sf x ~mu ~sigma] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the Gaussian (normal) distribution 
    at the point [x] with mean [mu] and standard deviation [sigma].

    @param x The point at which to evaluate the SF.
    @param mu The mean of the distribution.
    @param sigma The standard deviation of the distribution.
    @return The SF value at [x].
*)

val gaussian_logsf : float -> mu:float -> sigma:float -> float
(** [gaussian_logsf x ~mu ~sigma] computes the natural logarithm of the survival function 
    (log-SF) of the Gaussian (normal) distribution at the point [x] with mean [mu] and 
    standard deviation [sigma].

    @param x The point at which to evaluate the log-SF.
    @param mu The mean of the distribution.
    @param sigma The standard deviation of the distribution.
    @return The log-SF value at [x].
*)

val gaussian_isf : float -> mu:float -> sigma:float -> float
(** [gaussian_isf q ~mu ~sigma] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the Gaussian (normal) distribution 
    for a given probability [q] with mean [mu] and standard deviation [sigma].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param mu The mean of the distribution.
    @param sigma The standard deviation of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val gamma_rvs : shape:float -> scale:float -> float
(** [gamma_rvs ~shape ~scale] generates a random variate from the gamma 
    distribution with shape parameter [shape] and scale parameter [scale].

    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return A float representing a random sample from the gamma distribution.
*)

val gamma_pdf : float -> shape:float -> scale:float -> float
(** [gamma_pdf x ~shape ~scale] computes the probability density function (PDF) 
    of the gamma distribution at the point [x] with shape parameter [shape] and 
    scale parameter [scale].

    @param x The point at which to evaluate the PDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The PDF value at [x].
*)

val gamma_logpdf : float -> shape:float -> scale:float -> float
(** [gamma_logpdf x ~shape ~scale] computes the natural logarithm of the probability 
    density function (log-PDF) of the gamma distribution at the point [x] with shape 
    parameter [shape] and scale parameter [scale].

    @param x The point at which to evaluate the log-PDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-PDF value at [x].
*)

val gamma_cdf : float -> shape:float -> scale:float -> float
(** [gamma_cdf x ~shape ~scale] computes the cumulative distribution function (CDF) 
    of the gamma distribution at the point [x] with shape parameter [shape] and 
    scale parameter [scale].

    @param x The point at which to evaluate the CDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The CDF value at [x].
*)

val gamma_logcdf : float -> shape:float -> scale:float -> float
(** [gamma_logcdf x ~shape ~scale] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the gamma distribution at the point [x] with 
    shape parameter [shape] and scale parameter [scale].

    @param x The point at which to evaluate the log-CDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-CDF value at [x].
*)

val gamma_ppf : float -> shape:float -> scale:float -> float
(** [gamma_ppf q ~shape ~scale] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the gamma distribution 
    for a given probability [q] with shape parameter [shape] and scale parameter [scale].

    @param q The probability for which to compute the corresponding quantile.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val gamma_sf : float -> shape:float -> scale:float -> float
(** [gamma_sf x ~shape ~scale] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the gamma distribution 
    at the point [x] with shape parameter [shape] and scale parameter [scale].

    @param x The point at which to evaluate the SF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The SF value at [x].
*)

val gamma_logsf : float -> shape:float -> scale:float -> float
(** [gamma_logsf x ~shape ~scale] computes the natural logarithm of the survival function 
    (log-SF) of the gamma distribution at the point [x] with shape parameter [shape] and 
    scale parameter [scale].

    @param x The point at which to evaluate the log-SF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-SF value at [x].
*)

val gamma_isf : float -> shape:float -> scale:float -> float
(** [gamma_isf q ~shape ~scale] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the gamma distribution 
    for a given probability [q] with shape parameter [shape] and scale parameter [scale].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val beta_rvs : a:float -> b:float -> float
(** [beta_rvs ~a ~b] generates a random variate from the beta distribution 
    with shape parameters [a] and [b].

    @param a The first shape parameter of the distribution.
    @param b The second shape parameter of the distribution.
    @return A float representing a random sample from the beta distribution.
*)

val beta_pdf : float -> a:float -> b:float -> float
(** [beta_pdf x ~a ~b] computes the probability density function (PDF) 
    of the beta distribution at the point [x] with shape parameters [a] and [b].

    @param x The point at which to evaluate the PDF.
    @param a The first shape parameter of the distribution.
    @param b The second shape parameter of the distribution.
    @return The PDF value at [x].
*)

val beta_logpdf : float -> a:float -> b:float -> float
(** [beta_logpdf x ~a ~b] computes the natural logarithm of the probability 
    density function (log-PDF) of the beta distribution at the point [x] 
    with shape parameters [a] and [b].

    @param x The point at which to evaluate the log-PDF.
    @param a The first shape parameter of the distribution.
    @param b The second shape parameter of the distribution.
    @return The log-PDF value at [x].
*)

val beta_cdf : float -> a:float -> b:float -> float
(** [beta_cdf x ~a ~b] computes the cumulative distribution function (CDF) 
    of the beta distribution at the point [x] with shape parameters [a] and 
    [b].

    @param x The point at which to evaluate the CDF.
    @param a The first shape parameter of the distribution.
    @param b The second shape parameter of the distribution.
    @return The CDF value at [x].
*)

val beta_logcdf : float -> a:float -> b:float -> float
(** [beta_logcdf x ~a ~b] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the beta distribution at the point [x] 
    with shape parameters [a] and [b].

    @param x The point at which to evaluate the log-CDF.
    @param a The first shape parameter of the distribution.
    @param b The second shape parameter of the distribution.
    @return The log-CDF value at [x].
*)

val beta_ppf : float -> a:float -> b:float -> float
(** [beta_ppf q ~a ~b] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the beta distribution 
    for a given probability [q] with shape parameters [a] and [b].

    @param q The probability for which to compute the corresponding quantile.
    @param a The first shape parameter of the distribution.
    @param b The second shape parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val beta_sf : float -> a:float -> b:float -> float
(** [beta_sf x ~a ~b] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the beta distribution 
    at the point [x] with shape parameters [a] and [b].

    @param x The point at which to evaluate the SF.
    @param a The first shape parameter of the distribution.
    @param b The second shape parameter of the distribution.
    @return The SF value at [x].
*)

val beta_logsf : float -> a:float -> b:float -> float
(** [beta_logsf x ~a ~b] computes the natural logarithm of the survival function 
    (log-SF) of the beta distribution at the point [x] with shape parameters [a] 
    and [b].

    @param x The point at which to evaluate the log-SF.
    @param a The first shape parameter of the distribution.
    @param b The second shape parameter of the distribution.
    @return The log-SF value at [x].
*)

val beta_isf : float -> a:float -> b:float -> float
(** [beta_isf q ~a ~b] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the beta distribution 
    for a given probability [q] with shape parameters [a] and [b].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param a The first shape parameter of the distribution.
    @param b The second shape parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val chi2_rvs : df:float -> float
(** [chi2_rvs ~df] generates a random variate from the chi-square 
    distribution with degrees of freedom [df].

    @param df The degrees of freedom of the distribution.
    @return A float representing a random sample from the chi-square distribution.
*)

val chi2_pdf : float -> df:float -> float
(** [chi2_pdf x ~df] computes the probability density function (PDF) 
    of the chi-square distribution at the point [x] with degrees of freedom [df].

    @param x The point at which to evaluate the PDF.
    @param df The degrees of freedom of the distribution.
    @return The PDF value at [x].
*)

val chi2_logpdf : float -> df:float -> float
(** [chi2_logpdf x ~df] computes the natural logarithm of the probability 
    density function (log-PDF) of the chi-square distribution at the point 
    [x] with degrees of freedom [df].

    @param x The point at which to evaluate the log-PDF.
    @param df The degrees of freedom of the distribution.
    @return The log-PDF value at [x].
*)

val chi2_cdf : float -> df:float -> float
(** [chi2_cdf x ~df] computes the cumulative distribution function (CDF) 
    of the chi-square distribution at the point [x] with degrees of freedom [df].

    @param x The point at which to evaluate the CDF.
    @param df The degrees of freedom of the distribution.
    @return The CDF value at [x].
*)

val chi2_logcdf : float -> df:float -> float
(** [chi2_logcdf x ~df] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the chi-square distribution at the 
    point [x] with degrees of freedom [df].

    @param x The point at which to evaluate the log-CDF.
    @param df The degrees of freedom of the distribution.
    @return The log-CDF value at [x].
*)

val chi2_ppf : float -> df:float -> float
(** [chi2_ppf q ~df] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the chi-square distribution 
    for a given probability [q] with degrees of freedom [df].

    @param q The probability for which to compute the corresponding quantile.
    @param df The degrees of freedom of the distribution.
    @return The quantile corresponding to [q].
*)

val chi2_sf : float -> df:float -> float
(** [chi2_sf x ~df] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the chi-square distribution 
    at the point [x] with degrees of freedom [df].

    @param x The point at which to evaluate the SF.
    @param df The degrees of freedom of the distribution.
    @return The SF value at [x].
*)

val chi2_logsf : float -> df:float -> float
(** [chi2_logsf x ~df] computes the natural logarithm of the survival function 
    (log-SF) of the chi-square distribution at the point [x] with degrees of 
    freedom [df].

    @param x The point at which to evaluate the log-SF.
    @param df The degrees of freedom of the distribution.
    @return The log-SF value at [x].
*)

val chi2_isf : float -> df:float -> float
(** [chi2_isf q ~df] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the chi-square distribution 
    for a given probability [q] with degrees of freedom [df].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param df The degrees of freedom of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val f_rvs : dfnum:float -> dfden:float -> float
(** [f_rvs ~dfnum ~dfden] generates a random variate from the F-distribution 
    with numerator degrees of freedom [dfnum] and denominator degrees of freedom [dfden].

    The F-distribution is commonly used in the analysis of variance (ANOVA) 
    and in the comparison of two variances.

    @param dfnum The numerator degrees of freedom.
    @param dfden The denominator degrees of freedom.
    @return A float representing a random sample from the F-distribution.
*)

val f_pdf : float -> dfnum:float -> dfden:float -> float
(** [f_pdf x ~dfnum ~dfden] computes the probability density function (PDF) 
    of the F-distribution at the point [x] with numerator degrees of freedom [dfnum] 
    and denominator degrees of freedom [dfden].

    @param x The point at which to evaluate the PDF.
    @param dfnum The numerator degrees of freedom.
    @param dfden The denominator degrees of freedom.
    @return The PDF value at [x].
*)

val f_logpdf : float -> dfnum:float -> dfden:float -> float
(** [f_logpdf x ~dfnum ~dfden] computes the natural logarithm of the probability 
    density function (log-PDF) of the F-distribution at the point [x] with numerator 
    degrees of freedom [dfnum] and denominator degrees of freedom [dfden].

    @param x The point at which to evaluate the log-PDF.
    @param dfnum The numerator degrees of freedom.
    @param dfden The denominator degrees of freedom.
    @return The log-PDF value at [x].
*)

val f_cdf : float -> dfnum:float -> dfden:float -> float
(** [f_cdf x ~dfnum ~dfden] computes the cumulative distribution function (CDF) 
    of the F-distribution at the point [x] with numerator degrees of freedom [dfnum] 
    and denominator degrees of freedom [dfden].

    @param x The point at which to evaluate the CDF.
    @param dfnum The numerator degrees of freedom.
    @param dfden The denominator degrees of freedom.
    @return The CDF value at [x].
*)

val f_logcdf : float -> dfnum:float -> dfden:float -> float
(** [f_logcdf x ~dfnum ~dfden] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the F-distribution at the point [x] with 
    numerator degrees of freedom [dfnum] and denominator degrees of freedom [dfden].

    @param x The point at which to evaluate the log-CDF.
    @param dfnum The numerator degrees of freedom.
    @param dfden The denominator degrees of freedom.
    @return The log-CDF value at [x].
*)

val f_ppf : float -> dfnum:float -> dfden:float -> float
(** [f_ppf q ~dfnum ~dfden] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the F-distribution for a given 
    probability [q] with numerator degrees of freedom [dfnum] and denominator 
    degrees of freedom [dfden].

    @param q The probability for which to compute the corresponding quantile.
    @param dfnum The numerator degrees of freedom.
    @param dfden The denominator degrees of freedom.
    @return The quantile corresponding to [q].
*)

val f_sf : float -> dfnum:float -> dfden:float -> float
(** [f_sf x ~dfnum ~dfden] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the F-distribution 
    at the point [x] with numerator degrees of freedom [dfnum] and denominator 
    degrees of freedom [dfden].

    @param x The point at which to evaluate the SF.
    @param dfnum The numerator degrees of freedom.
    @param dfden The denominator degrees of freedom.
    @return The SF value at [x].
*)

val f_logsf : float -> dfnum:float -> dfden:float -> float
(** [f_logsf x ~dfnum ~dfden] computes the natural logarithm of the survival function 
    (log-SF) of the F-distribution at the point [x] with numerator degrees of freedom 
    [dfnum] and denominator degrees of freedom [dfden].

    @param x The point at which to evaluate the log-SF.
    @param dfnum The numerator degrees of freedom.
    @param dfden The denominator degrees of freedom.
    @return The log-SF value at [x].
*)

val f_isf : float -> dfnum:float -> dfden:float -> float
(** [f_isf q ~dfnum ~dfden] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the F-distribution 
    for a given probability [q] with numerator degrees of freedom [dfnum] 
    and denominator degrees of freedom [dfden].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param dfnum The numerator degrees of freedom.
    @param dfden The denominator degrees of freedom.
    @return The value corresponding to [q] from the ISF.
*)

val cauchy_rvs : loc:float -> scale:float -> float
(** [cauchy_rvs ~loc ~scale] generates a random variate from the Cauchy distribution 
    with location parameter [loc] and scale parameter [scale].

    The Cauchy distribution is a continuous probability distribution with 
    heavy tails, often used in robust statistical methods.

    @param loc The location parameter of the distribution (the peak of the curve).
    @param scale The scale parameter of the distribution (half-width at half-maximum).
    @return A float representing a random sample from the Cauchy distribution.
*)

val cauchy_pdf : float -> loc:float -> scale:float -> float
(** [cauchy_pdf x ~loc ~scale] computes the probability density function (PDF) 
    of the Cauchy distribution at the point [x] with location parameter [loc] 
    and scale parameter [scale].

    @param x The point at which to evaluate the PDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The PDF value at [x].
*)

val cauchy_logpdf : float -> loc:float -> scale:float -> float
(** [cauchy_logpdf x ~loc ~scale] computes the natural logarithm of the probability 
    density function (log-PDF) of the Cauchy distribution at the point [x] with location 
    parameter [loc] and scale parameter [scale].

    @param x The point at which to evaluate the log-PDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-PDF value at [x].
*)

val cauchy_cdf : float -> loc:float -> scale:float -> float
(** [cauchy_cdf x ~loc ~scale] computes the cumulative distribution function (CDF) 
    of the Cauchy distribution at the point [x] with location parameter [loc] 
    and scale parameter [scale].

    @param x The point at which to evaluate the CDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The CDF value at [x].
*)

val cauchy_logcdf : float -> loc:float -> scale:float -> float
(** [cauchy_logcdf x ~loc ~scale] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the Cauchy distribution at the point [x] 
    with location parameter [loc] and scale parameter [scale].

    @param x The point at which to evaluate the log-CDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-CDF value at [x].
*)

val cauchy_ppf : float -> loc:float -> scale:float -> float
(** [cauchy_ppf q ~loc ~scale] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the Cauchy distribution for a given 
    probability [q] with location parameter [loc] and scale parameter [scale].

    @param q The probability for which to compute the corresponding quantile.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val cauchy_sf : float -> loc:float -> scale:float -> float
(** [cauchy_sf x ~loc ~scale] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the Cauchy distribution 
    at the point [x] with location parameter [loc] and scale parameter [scale].

    @param x The point at which to evaluate the SF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The SF value at [x].
*)

val cauchy_logsf : float -> loc:float -> scale:float -> float
(** [cauchy_logsf x ~loc ~scale] computes the natural logarithm of the survival function 
    (log-SF) of the Cauchy distribution at the point [x] with location parameter [loc] 
    and scale parameter [scale].

    @param x The point at which to evaluate the log-SF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-SF value at [x].
*)

val cauchy_isf : float -> loc:float -> scale:float -> float
(** [cauchy_isf q ~loc ~scale] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the Cauchy distribution 
    for a given probability [q] with location parameter [loc] and scale parameter [scale].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val t_rvs : df:float -> loc:float -> scale:float -> float
(** [t_rvs ~df ~loc ~scale] generates a random variate from the Student's t-distribution 
    with [df] degrees of freedom, location parameter [loc], and scale parameter [scale].

    The Student's t-distribution is commonly used in statistics for small sample sizes 
    or when the population standard deviation is unknown.

    @param df The degrees of freedom of the distribution.
    @param loc The location parameter of the distribution (the mean).
    @param scale The scale parameter of the distribution (the standard deviation).
    @return A float representing a random sample from the t-distribution.
*)

val t_pdf : float -> df:float -> loc:float -> scale:float -> float
(** [t_pdf x ~df ~loc ~scale] computes the probability density function (PDF) 
    of the Student's t-distribution at the point [x] with [df] degrees of freedom, 
    location parameter [loc], and scale parameter [scale].

    @param x The point at which to evaluate the PDF.
    @param df The degrees of freedom of the distribution.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The PDF value at [x].
*)

val t_logpdf : float -> df:float -> loc:float -> scale:float -> float
(** [t_logpdf x ~df ~loc ~scale] computes the natural logarithm of the probability 
    density function (log-PDF) of the Student's t-distribution at the point [x] with 
    [df] degrees of freedom, location parameter [loc], and scale parameter [scale].

    @param x The point at which to evaluate the log-PDF.
    @param df The degrees of freedom of the distribution.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-PDF value at [x].
*)

val t_cdf : float -> df:float -> loc:float -> scale:float -> float
(** [t_cdf x ~df ~loc ~scale] computes the cumulative distribution function (CDF) 
    of the Student's t-distribution at the point [x] with [df] degrees of freedom, 
    location parameter [loc], and scale parameter [scale].

    @param x The point at which to evaluate the CDF.
    @param df The degrees of freedom of the distribution.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The CDF value at [x].
*)

val t_logcdf : float -> df:float -> loc:float -> scale:float -> float
(** [t_logcdf x ~df ~loc ~scale] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the Student's t-distribution at the point [x] 
    with [df] degrees of freedom, location parameter [loc], and scale parameter [scale].

    @param x The point at which to evaluate the log-CDF.
    @param df The degrees of freedom of the distribution.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-CDF value at [x].
*)

val t_ppf : float -> df:float -> loc:float -> scale:float -> float
(** [t_ppf q ~df ~loc ~scale] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the Student's t-distribution 
    for a given probability [q] with [df] degrees of freedom, location parameter [loc], 
    and scale parameter [scale].

    @param q The probability for which to compute the corresponding quantile.
    @param df The degrees of freedom of the distribution.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val t_sf : float -> df:float -> loc:float -> scale:float -> float
(** [t_sf x ~df ~loc ~scale] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the Student's t-distribution 
    at the point [x] with [df] degrees of freedom, location parameter [loc], 
    and scale parameter [scale].

    @param x The point at which to evaluate the SF.
    @param df The degrees of freedom of the distribution.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The SF value at [x].
*)

val t_logsf : float -> df:float -> loc:float -> scale:float -> float
(** [t_logsf x ~df ~loc ~scale] computes the natural logarithm of the survival function 
    (log-SF) of the Student's t-distribution at the point [x] with [df] degrees of freedom, 
    location parameter [loc], and scale parameter [scale].

    @param x The point at which to evaluate the log-SF.
    @param df The degrees of freedom of the distribution.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-SF value at [x].
*)

val t_isf : float -> df:float -> loc:float -> scale:float -> float
(** [t_isf q ~df ~loc ~scale] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the Student's t-distribution 
    for a given probability [q] with [df] degrees of freedom, location parameter [loc], 
    and scale parameter [scale].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param df The degrees of freedom of the distribution.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val vonmises_rvs : mu:float -> kappa:float -> float
(** [vonmises_rvs ~mu ~kappa] generates a random variate from the von Mises distribution 
    with mean direction [mu] and concentration parameter [kappa].

    The von Mises distribution is often used as a circular analogue of the normal distribution 
    for data measured in angles or on a circle.

    @param mu The mean direction of the distribution.
    @param kappa The concentration parameter of the distribution, where larger values indicate 
    higher concentration around the mean direction.
    @return A float representing a random sample from the von Mises distribution.
*)

val vonmises_pdf : float -> mu:float -> kappa:float -> float
(** [vonmises_pdf x ~mu ~kappa] computes the probability density function (PDF) 
    of the von Mises distribution at the point [x] with mean direction [mu] 
    and concentration parameter [kappa].

    @param x The point at which to evaluate the PDF.
    @param mu The mean direction of the distribution.
    @param kappa The concentration parameter of the distribution.
    @return The PDF value at [x].
*)

val vonmises_logpdf : float -> mu:float -> kappa:float -> float
(** [vonmises_logpdf x ~mu ~kappa] computes the natural logarithm of the probability 
    density function (log-PDF) of the von Mises distribution at the point [x] 
    with mean direction [mu] and concentration parameter [kappa].

    @param x The point at which to evaluate the log-PDF.
    @param mu The mean direction of the distribution.
    @param kappa The concentration parameter of the distribution.
    @return The log-PDF value at [x].
*)

val vonmises_cdf : float -> mu:float -> kappa:float -> float
(** [vonmises_cdf x ~mu ~kappa] computes the cumulative distribution function (CDF) 
    of the von Mises distribution at the point [x] with mean direction [mu] 
    and concentration parameter [kappa].

    @param x The point at which to evaluate the CDF.
    @param mu The mean direction of the distribution.
    @param kappa The concentration parameter of the distribution.
    @return The CDF value at [x].
*)

val vonmises_logcdf : float -> mu:float -> kappa:float -> float
(** [vonmises_logcdf x ~mu ~kappa] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the von Mises distribution at the point [x] 
    with mean direction [mu] and concentration parameter [kappa].

    @param x The point at which to evaluate the log-CDF.
    @param mu The mean direction of the distribution.
    @param kappa The concentration parameter of the distribution.
    @return The log-CDF value at [x].
*)

val vonmises_sf : float -> mu:float -> kappa:float -> float
(** [vonmises_sf x ~mu ~kappa] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the von Mises distribution 
    at the point [x] with mean direction [mu] and concentration parameter [kappa].

    @param x The point at which to evaluate the SF.
    @param mu The mean direction of the distribution.
    @param kappa The concentration parameter of the distribution.
    @return The SF value at [x].
*)

val vonmises_logsf : float -> mu:float -> kappa:float -> float
(** [vonmises_logsf x ~mu ~kappa] computes the natural logarithm of the survival function 
    (log-SF) of the von Mises distribution at the point [x] with mean direction [mu] 
    and concentration parameter [kappa].

    @param x The point at which to evaluate the log-SF.
    @param mu The mean direction of the distribution.
    @param kappa The concentration parameter of the distribution.
    @return The log-SF value at [x].
*)

val lomax_rvs : shape:float -> scale:float -> float
(** [lomax_rvs ~shape ~scale] generates a random variate from the Lomax distribution, 
    also known as the Pareto distribution of the second kind, with shape parameter [shape] 
    and scale parameter [scale].

    The Lomax distribution is often used in survival analysis and heavy-tailed modeling.

    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return A float representing a random sample from the Lomax distribution.
*)

val lomax_pdf : float -> shape:float -> scale:float -> float
(** [lomax_pdf x ~shape ~scale] computes the probability density function (PDF) 
    of the Lomax distribution at the point [x] with shape parameter [shape] 
    and scale parameter [scale].

    @param x The point at which to evaluate the PDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The PDF value at [x].
*)

val lomax_logpdf : float -> shape:float -> scale:float -> float
(** [lomax_logpdf x ~shape ~scale] computes the natural logarithm of the probability 
    density function (log-PDF) of the Lomax distribution at the point [x] with shape 
    parameter [shape] and scale parameter [scale].

    @param x The point at which to evaluate the log-PDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-PDF value at [x].
*)

val lomax_cdf : float -> shape:float -> scale:float -> float
(** [lomax_cdf x ~shape ~scale] computes the cumulative distribution function (CDF) 
    of the Lomax distribution at the point [x] with shape parameter [shape] 
    and scale parameter [scale].

    @param x The point at which to evaluate the CDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The CDF value at [x].
*)

val lomax_logcdf : float -> shape:float -> scale:float -> float
(** [lomax_logcdf x ~shape ~scale] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the Lomax distribution at the point [x] 
    with shape parameter [shape] and scale parameter [scale].

    @param x The point at which to evaluate the log-CDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-CDF value at [x].
*)

val lomax_ppf : float -> shape:float -> scale:float -> float
(** [lomax_ppf q ~shape ~scale] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the Lomax distribution for a given 
    probability [q] with shape parameter [shape] and scale parameter [scale].

    @param q The probability for which to compute the corresponding quantile.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val lomax_sf : float -> shape:float -> scale:float -> float
(** [lomax_sf x ~shape ~scale] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the Lomax distribution 
    at the point [x] with shape parameter [shape] and scale parameter [scale].

    @param x The point at which to evaluate the SF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The SF value at [x].
*)

val lomax_logsf : float -> shape:float -> scale:float -> float
(** [lomax_logsf x ~shape ~scale] computes the natural logarithm of the survival function 
    (log-SF) of the Lomax distribution at the point [x] with shape parameter [shape] 
    and scale parameter [scale].

    @param x The point at which to evaluate the log-SF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-SF value at [x].
*)

val lomax_isf : float -> shape:float -> scale:float -> float
(** [lomax_isf q ~shape ~scale] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the Lomax distribution 
    for a given probability [q] with shape parameter [shape] and scale parameter [scale].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val weibull_rvs : shape:float -> scale:float -> float
(** [weibull_rvs ~shape ~scale] generates a random variate from the Weibull distribution 
    with shape parameter [shape] and scale parameter [scale].

    The Weibull distribution is commonly used in reliability analysis and modeling life data.

    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return A float representing a random sample from the Weibull distribution.
*)

val weibull_pdf : float -> shape:float -> scale:float -> float
(** [weibull_pdf x ~shape ~scale] computes the probability density function (PDF) 
    of the Weibull distribution at the point [x] with shape parameter [shape] 
    and scale parameter [scale].

    @param x The point at which to evaluate the PDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The PDF value at [x].
*)

val weibull_logpdf : float -> shape:float -> scale:float -> float
(** [weibull_logpdf x ~shape ~scale] computes the natural logarithm of the probability 
    density function (log-PDF) of the Weibull distribution at the point [x] with shape 
    parameter [shape] and scale parameter [scale].

    @param x The point at which to evaluate the log-PDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-PDF value at [x].
*)

val weibull_cdf : float -> shape:float -> scale:float -> float
(** [weibull_cdf x ~shape ~scale] computes the cumulative distribution function (CDF) 
    of the Weibull distribution at the point [x] with shape parameter [shape] 
    and scale parameter [scale].

    @param x The point at which to evaluate the CDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The CDF value at [x].
*)

val weibull_logcdf : float -> shape:float -> scale:float -> float
(** [weibull_logcdf x ~shape ~scale] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the Weibull distribution at the point [x] with 
    shape parameter [shape] and scale parameter [scale].

    @param x The point at which to evaluate the log-CDF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-CDF value at [x].
*)

val weibull_ppf : float -> shape:float -> scale:float -> float
(** [weibull_ppf q ~shape ~scale] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the Weibull distribution for a given 
    probability [q] with shape parameter [shape] and scale parameter [scale].

    @param q The probability for which to compute the corresponding quantile.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val weibull_sf : float -> shape:float -> scale:float -> float
(** [weibull_sf x ~shape ~scale] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the Weibull distribution 
    at the point [x] with shape parameter [shape] and scale parameter [scale].

    @param x The point at which to evaluate the SF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The SF value at [x].
*)

val weibull_logsf : float -> shape:float -> scale:float -> float
(** [weibull_logsf x ~shape ~scale] computes the natural logarithm of the survival function 
    (log-SF) of the Weibull distribution at the point [x] with shape parameter [shape] 
    and scale parameter [scale].

    @param x The point at which to evaluate the log-SF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-SF value at [x].
*)

val weibull_isf : float -> shape:float -> scale:float -> float
(** [weibull_isf q ~shape ~scale] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the Weibull distribution 
    for a given probability [q] with shape parameter [shape] and scale parameter [scale].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param shape The shape parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val laplace_rvs : loc:float -> scale:float -> float
(** [laplace_rvs ~loc ~scale] generates a random variate from the Laplace distribution, 
    also known as the double exponential distribution, with location parameter [loc] 
    and scale parameter [scale].

    The Laplace distribution is often used in statistical methods for detecting outliers.

    @param loc The location parameter of the distribution (the mean).
    @param scale The scale parameter of the distribution (the standard deviation).
    @return A float representing a random sample from the Laplace distribution.
*)

val laplace_pdf : float -> loc:float -> scale:float -> float
(** [laplace_pdf x ~loc ~scale] computes the probability density function (PDF) 
    of the Laplace distribution at the point [x] with location parameter [loc] 
    and scale parameter [scale].

    @param x The point at which to evaluate the PDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The PDF value at [x].
*)

val laplace_logpdf : float -> loc:float -> scale:float -> float
(** [laplace_logpdf x ~loc ~scale] computes the natural logarithm of the probability 
    density function (log-PDF) of the Laplace distribution at the point [x] with location 
    parameter [loc] and scale parameter [scale].

    @param x The point at which to evaluate the log-PDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-PDF value at [x].
*)

val laplace_cdf : float -> loc:float -> scale:float -> float
(** [laplace_cdf x ~loc ~scale] computes the cumulative distribution function (CDF) 
    of the Laplace distribution at the point [x] with location parameter [loc] 
    and scale parameter [scale].

    @param x The point at which to evaluate the CDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The CDF value at [x].
*)

val laplace_logcdf : float -> loc:float -> scale:float -> float
(** [laplace_logcdf x ~loc ~scale] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the Laplace distribution at the point [x] 
    with location parameter [loc] and scale parameter [scale].

    @param x The point at which to evaluate the log-CDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-CDF value at [x].
*)

val laplace_ppf : float -> loc:float -> scale:float -> float
(** [laplace_ppf q ~loc ~scale] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the Laplace distribution for a given 
    probability [q] with location parameter [loc] and scale parameter [scale].

    @param q The probability for which to compute the corresponding quantile.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val laplace_sf : float -> loc:float -> scale:float -> float
(** [laplace_sf x ~loc ~scale] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the Laplace distribution 
    at the point [x] with location parameter [loc] and scale parameter [scale].

    @param x The point at which to evaluate the SF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The SF value at [x].
*)

val laplace_logsf : float -> loc:float -> scale:float -> float
(** [laplace_logsf x ~loc ~scale] computes the natural logarithm of the survival function 
    (log-SF) of the Laplace distribution at the point [x] with location parameter [loc] 
    and scale parameter [scale].

    @param x The point at which to evaluate the log-SF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-SF value at [x].
*)

val laplace_isf : float -> loc:float -> scale:float -> float
(** [laplace_isf q ~loc ~scale] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the Laplace distribution 
    for a given probability [q] with location parameter [loc] and scale parameter [scale].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val gumbel1_rvs : a:float -> b:float -> float
(** [gumbel1_rvs ~a ~b] generates a random variate from the Gumbel Type I distribution 
    with location parameter [a] and scale parameter [b].

    The Gumbel distribution is commonly used to model the distribution of the maximum 
    (or the minimum) of a number of samples of various distributions.

    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return A float representing a random sample from the Gumbel Type I distribution.
*)

val gumbel1_pdf : float -> a:float -> b:float -> float
(** [gumbel1_pdf x ~a ~b] computes the probability density function (PDF) 
    of the Gumbel Type I distribution at the point [x] with location parameter [a] 
    and scale parameter [b].

    @param x The point at which to evaluate the PDF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The PDF value at [x].
*)

val gumbel1_logpdf : float -> a:float -> b:float -> float
(** [gumbel1_logpdf x ~a ~b] computes the natural logarithm of the probability 
    density function (log-PDF) of the Gumbel Type I distribution at the point [x] 
    with location parameter [a] and scale parameter [b].

    @param x The point at which to evaluate the log-PDF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The log-PDF value at [x].
*)

val gumbel1_cdf : float -> a:float -> b:float -> float
(** [gumbel1_cdf x ~a ~b] computes the cumulative distribution function (CDF) 
    of the Gumbel Type I distribution at the point [x] with location parameter [a] 
    and scale parameter [b].

    @param x The point at which to evaluate the CDF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The CDF value at [x].
*)

val gumbel1_logcdf : float -> a:float -> b:float -> float
(** [gumbel1_logcdf x ~a ~b] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the Gumbel Type I distribution at the point [x] 
    with location parameter [a] and scale parameter [b].

    @param x The point at which to evaluate the log-CDF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The log-CDF value at [x].
*)

val gumbel1_ppf : float -> a:float -> b:float -> float
(** [gumbel1_ppf q ~a ~b] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the Gumbel Type I distribution 
    for a given probability [q] with location parameter [a] and scale parameter [b].

    @param q The probability for which to compute the corresponding quantile.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val gumbel1_sf : float -> a:float -> b:float -> float
(** [gumbel1_sf x ~a ~b] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the Gumbel Type I distribution 
    at the point [x] with location parameter [a] and scale parameter [b].

    @param x The point at which to evaluate the SF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The SF value at [x].
*)

val gumbel1_logsf : float -> a:float -> b:float -> float
(** [gumbel1_logsf x ~a ~b] computes the natural logarithm of the survival function 
    (log-SF) of the Gumbel Type I distribution at the point [x] with location parameter [a] 
    and scale parameter [b].

    @param x The point at which to evaluate the log-SF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The log-SF value at [x].
*)

val gumbel1_isf : float -> a:float -> b:float -> float
(** [gumbel1_isf q ~a ~b] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the Gumbel Type I distribution 
    for a given probability [q] with location parameter [a] and scale parameter [b].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val gumbel2_rvs : a:float -> b:float -> float
(** [gumbel2_rvs ~a ~b] generates a random variate from the Gumbel Type II distribution 
    with location parameter [a] and scale parameter [b].

    The Gumbel Type II distribution is used for modeling extreme values in various fields.

    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return A float representing a random sample from the Gumbel Type II distribution.
*)

val gumbel2_pdf : float -> a:float -> b:float -> float
(** [gumbel2_pdf x ~a ~b] computes the probability density function (PDF) 
    of the Gumbel Type II distribution at the point [x] with location parameter [a] 
    and scale parameter [b].

    @param x The point at which to evaluate the PDF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The PDF value at [x].
*)

val gumbel2_logpdf : float -> a:float -> b:float -> float
(** [gumbel2_logpdf x ~a ~b] computes the natural logarithm of the probability 
    density function (log-PDF) of the Gumbel Type II distribution at the point [x] 
    with location parameter [a] and scale parameter [b].

    @param x The point at which to evaluate the log-PDF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The log-PDF value at [x].
*)

val gumbel2_cdf : float -> a:float -> b:float -> float
(** [gumbel2_cdf x ~a ~b] computes the cumulative distribution function (CDF) 
    of the Gumbel Type II distribution at the point [x] with location parameter [a] 
    and scale parameter [b].

    @param x The point at which to evaluate the CDF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The CDF value at [x].
*)

val gumbel2_logcdf : float -> a:float -> b:float -> float
(** [gumbel2_logcdf x ~a ~b] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the Gumbel Type II distribution at the point [x] 
    with location parameter [a] and scale parameter [b].

    @param x The point at which to evaluate the log-CDF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The log-CDF value at [x].
*)

val gumbel2_ppf : float -> a:float -> b:float -> float
(** [gumbel2_ppf q ~a ~b] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the Gumbel Type II distribution 
    for a given probability [q] with location parameter [a] and scale parameter [b].

    @param q The probability for which to compute the corresponding quantile.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val gumbel2_sf : float -> a:float -> b:float -> float
(** [gumbel2_sf x ~a ~b] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the Gumbel Type II distribution 
    at the point [x] with location parameter [a] and scale parameter [b].

    @param x The point at which to evaluate the SF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The SF value at [x].
*)

val gumbel2_logsf : float -> a:float -> b:float -> float
(** [gumbel2_logsf x ~a ~b] computes the natural logarithm of the survival function 
    (log-SF) of the Gumbel Type II distribution at the point [x] with location parameter [a] 
    and scale parameter [b].

    @param x The point at which to evaluate the log-SF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The log-SF value at [x].
*)

val gumbel2_isf : float -> a:float -> b:float -> float
(** [gumbel2_isf q ~a ~b] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the Gumbel Type II distribution 
    for a given probability [q] with location parameter [a] and scale parameter [b].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param a The location parameter of the distribution.
    @param b The scale parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val logistic_rvs : loc:float -> scale:float -> float
(** [logistic_rvs ~loc ~scale] generates a random variate from the logistic distribution 
    with location parameter [loc] and scale parameter [scale].

    The logistic distribution is often used in logistic regression and as a growth model.

    @param loc The location parameter of the distribution (the mean).
    @param scale The scale parameter of the distribution (related to the standard deviation).
    @return A float representing a random sample from the logistic distribution.
*)

val logistic_pdf : float -> loc:float -> scale:float -> float
(** [logistic_pdf x ~loc ~scale] computes the probability density function (PDF) 
    of the logistic distribution at the point [x] with location parameter [loc] 
    and scale parameter [scale].

    @param x The point at which to evaluate the PDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The PDF value at [x].
*)

val logistic_logpdf : float -> loc:float -> scale:float -> float
(** [logistic_logpdf x ~loc ~scale] computes the natural logarithm of the probability 
    density function (log-PDF) of the logistic distribution at the point [x] with location 
    parameter [loc] and scale parameter [scale].

    @param x The point at which to evaluate the log-PDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-PDF value at [x].
*)

val logistic_cdf : float -> loc:float -> scale:float -> float
(** [logistic_cdf x ~loc ~scale] computes the cumulative distribution function (CDF) 
    of the logistic distribution at the point [x] with location parameter [loc] 
    and scale parameter [scale].

    @param x The point at which to evaluate the CDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The CDF value at [x].
*)

val logistic_logcdf : float -> loc:float -> scale:float -> float
(** [logistic_logcdf x ~loc ~scale] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the logistic distribution at the point [x] 
    with location parameter [loc] and scale parameter [scale].

    @param x The point at which to evaluate the log-CDF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-CDF value at [x].
*)

val logistic_ppf : float -> loc:float -> scale:float -> float
(** [logistic_ppf q ~loc ~scale] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the logistic distribution 
    for a given probability [q] with location parameter [loc] and scale parameter [scale].

    @param q The probability for which to compute the corresponding quantile.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val logistic_sf : float -> loc:float -> scale:float -> float
(** [logistic_sf x ~loc ~scale] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the logistic distribution 
    at the point [x] with location parameter [loc] and scale parameter [scale].

    @param x The point at which to evaluate the SF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The SF value at [x].
*)

val logistic_logsf : float -> loc:float -> scale:float -> float
(** [logistic_logsf x ~loc ~scale] computes the natural logarithm of the survival function 
    (log-SF) of the logistic distribution at the point [x] with location parameter [loc] 
    and scale parameter [scale].

    @param x The point at which to evaluate the log-SF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The log-SF value at [x].
*)

val logistic_isf : float -> loc:float -> scale:float -> float
(** [logistic_isf q ~loc ~scale] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the logistic distribution 
    for a given probability [q] with location parameter [loc] and scale parameter [scale].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param loc The location parameter of the distribution.
    @param scale The scale parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)

val lognormal_rvs : mu:float -> sigma:float -> float
(** [lognormal_rvs ~mu ~sigma] generates a random variate from the log-normal distribution 
    with parameters [mu] (mean of the underlying normal distribution) and [sigma] 
    (standard deviation of the underlying normal distribution).

    The log-normal distribution is commonly used to model positive-valued data 
    with a distribution that is skewed to the right.

    @param mu The mean of the underlying normal distribution.
    @param sigma The standard deviation of the underlying normal distribution.
    @return A float representing a random sample from the log-normal distribution.
*)

val lognormal_pdf : float -> mu:float -> sigma:float -> float
(** [lognormal_pdf x ~mu ~sigma] computes the probability density function (PDF) 
    of the log-normal distribution at the point [x] with parameters [mu] 
    (mean of the underlying normal distribution) and [sigma] (standard deviation 
    of the underlying normal distribution).

    @param x The point at which to evaluate the PDF.
    @param mu The mean of the underlying normal distribution.
    @param sigma The standard deviation of the underlying normal distribution.
    @return The PDF value at [x].
*)

val lognormal_logpdf : float -> mu:float -> sigma:float -> float
(** [lognormal_logpdf x ~mu ~sigma] computes the natural logarithm of the probability 
    density function (log-PDF) of the log-normal distribution at the point [x] 
    with parameters [mu] and [sigma].

    @param x The point at which to evaluate the log-PDF.
    @param mu The mean of the underlying normal distribution.
    @param sigma The standard deviation of the underlying normal distribution.
    @return The log-PDF value at [x].
*)

val lognormal_cdf : float -> mu:float -> sigma:float -> float
(** [lognormal_cdf x ~mu ~sigma] computes the cumulative distribution function (CDF) 
    of the log-normal distribution at the point [x] with parameters [mu] and [sigma].

    @param x The point at which to evaluate the CDF.
    @param mu The mean of the underlying normal distribution.
    @param sigma The standard deviation of the underlying normal distribution.
    @return The CDF value at [x].
*)

val lognormal_logcdf : float -> mu:float -> sigma:float -> float
(** [lognormal_logcdf x ~mu ~sigma] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the log-normal distribution at the point [x] 
    with parameters [mu] and [sigma].

    @param x The point at which to evaluate the log-CDF.
    @param mu The mean of the underlying normal distribution.
    @param sigma The standard deviation of the underlying normal distribution.
    @return The log-CDF value at [x].
*)

val lognormal_ppf : float -> mu:float -> sigma:float -> float
(** [lognormal_ppf q ~mu ~sigma] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the log-normal distribution 
    for a given probability [q] with parameters [mu] and [sigma].

    @param q The probability for which to compute the corresponding quantile.
    @param mu The mean of the underlying normal distribution.
    @param sigma The standard deviation of the underlying normal distribution.
    @return The quantile corresponding to [q].
*)

val lognormal_sf : float -> mu:float -> sigma:float -> float
(** [lognormal_sf x ~mu ~sigma] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the log-normal distribution 
    at the point [x] with parameters [mu] and [sigma].

    @param x The point at which to evaluate the SF.
    @param mu The mean of the underlying normal distribution.
    @param sigma The standard deviation of the underlying normal distribution.
    @return The SF value at [x].
*)

val lognormal_logsf : float -> mu:float -> sigma:float -> float
(** [lognormal_logsf x ~mu ~sigma] computes the natural logarithm of the survival function 
    (log-SF) of the log-normal distribution at the point [x] with parameters [mu] and [sigma].

    @param x The point at which to evaluate the log-SF.
    @param mu The mean of the underlying normal distribution.
    @param sigma The standard deviation of the underlying normal distribution.
    @return The log-SF value at [x].
*)

val lognormal_isf : float -> mu:float -> sigma:float -> float
(** [lognormal_isf q ~mu ~sigma] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the log-normal distribution 
    for a given probability [q] with parameters [mu] and [sigma].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param mu The mean of the underlying normal distribution.
    @param sigma The standard deviation of the underlying normal distribution.
    @return The value corresponding to [q] from the ISF.
*)

val rayleigh_rvs : sigma:float -> float
(** [rayleigh_rvs ~sigma] generates a random variate from the Rayleigh distribution 
    with scale parameter [sigma].

    The Rayleigh distribution is commonly used to model the magnitude of a vector 
    in two-dimensional space with Gaussian-distributed components.

    @param sigma The scale parameter of the distribution.
    @return A float representing a random sample from the Rayleigh distribution.
*)

val rayleigh_pdf : float -> sigma:float -> float
(** [rayleigh_pdf x ~sigma] computes the probability density function (PDF) 
    of the Rayleigh distribution at the point [x] with scale parameter [sigma].

    @param x The point at which to evaluate the PDF.
    @param sigma The scale parameter of the distribution.
    @return The PDF value at [x].
*)

val rayleigh_logpdf : float -> sigma:float -> float
(** [rayleigh_logpdf x ~sigma] computes the natural logarithm of the probability 
    density function (log-PDF) of the Rayleigh distribution at the point [x] 
    with scale parameter [sigma].

    @param x The point at which to evaluate the log-PDF.
    @param sigma The scale parameter of the distribution.
    @return The log-PDF value at [x].
*)

val rayleigh_cdf : float -> sigma:float -> float
(** [rayleigh_cdf x ~sigma] computes the cumulative distribution function (CDF) 
    of the Rayleigh distribution at the point [x] with scale parameter [sigma].

    @param x The point at which to evaluate the CDF.
    @param sigma The scale parameter of the distribution.
    @return The CDF value at [x].
*)

val rayleigh_logcdf : float -> sigma:float -> float
(** [rayleigh_logcdf x ~sigma] computes the natural logarithm of the cumulative 
    distribution function (log-CDF) of the Rayleigh distribution at the point [x] 
    with scale parameter [sigma].

    @param x The point at which to evaluate the log-CDF.
    @param sigma The scale parameter of the distribution.
    @return The log-CDF value at [x].
*)

val rayleigh_ppf : float -> sigma:float -> float
(** [rayleigh_ppf q ~sigma] computes the percent-point function (PPF), also known 
    as the quantile function or inverse CDF, of the Rayleigh distribution 
    for a given probability [q] with scale parameter [sigma].

    @param q The probability for which to compute the corresponding quantile.
    @param sigma The scale parameter of the distribution.
    @return The quantile corresponding to [q].
*)

val rayleigh_sf : float -> sigma:float -> float
(** [rayleigh_sf x ~sigma] computes the survival function (SF), which is one minus 
    the cumulative distribution function (1 - CDF), of the Rayleigh distribution 
    at the point [x] with scale parameter [sigma].

    @param x The point at which to evaluate the SF.
    @param sigma The scale parameter of the distribution.
    @return The SF value at [x].
*)

val rayleigh_logsf : float -> sigma:float -> float
(** [rayleigh_logsf x ~sigma] computes the natural logarithm of the survival function 
    (log-SF) of the Rayleigh distribution at the point [x] with scale parameter [sigma].

    @param x The point at which to evaluate the log-SF.
    @param sigma The scale parameter of the distribution.
    @return The log-SF value at [x].
*)

val rayleigh_isf : float -> sigma:float -> float
(** [rayleigh_isf q ~sigma] computes the inverse survival function (ISF), 
    which is the inverse of the survival function (SF), of the Rayleigh distribution 
    for a given probability [q] with scale parameter [sigma].

    @param q The probability for which to compute the corresponding value from the ISF.
    @param sigma The scale parameter of the distribution.
    @return The value corresponding to [q] from the ISF.
*)


val dirichlet_rvs : alpha:float array -> float array
(**
[dirichlet_rvs ~alpha] returns random variables of [K-1] order Dirichlet
distribution, follows the following probability dense function.
 
{math f(x_1,...,x_K; \alpha_1,...,\alpha_K) = \frac{1}{\mathbf{B(\alpha)}} \prod_{i=1}^K x_i^{\alpha_i - 1}  }

The normalising constant is the multivariate Beta function, which can be
expressed in terms of the gamma function:

{math
\mathbf{B(\alpha)} = \frac{\prod_{i=1}^K \Gamma(\alpha_i)}{\Gamma(\sum_{i=1}^K \alpha_i)}
}

Note that [x] is a standard K-1 simplex, i.e.
{m \sum_i^K x_i = 1} and {m x_i \ge 0, \forall x_i \in [1,K]}.

 *)

val dirichlet_pdf : float array -> alpha:float array -> float
(** [dirichlet_pdf x ~alpha] computes the probability density function (PDF) 
    of the Dirichlet distribution for the input vector [x] with concentration 
    parameters [alpha].

    The Dirichlet distribution is a multivariate generalization of the Beta distribution 
    and is commonly used as a prior distribution in Bayesian statistics, particularly 
    in the context of categorical data and multinomial distributions.

    @param x The input vector for which to evaluate the PDF, typically representing 
    proportions that sum to 1.
    @param alpha The concentration parameters of the distribution, where each element 
    must be greater than 0.
    @return The PDF value for the given input vector [x].
*)

val dirichlet_logpdf : float array -> alpha:float array -> float
(** [dirichlet_logpdf x ~alpha] computes the natural logarithm of the probability 
    density function (log-PDF) of the Dirichlet distribution for the input vector [x] 
    with concentration parameters [alpha].

    @param x The input vector for which to evaluate the log-PDF, typically representing 
    proportions that sum to 1.
    @param alpha The concentration parameters of the distribution, where each element 
    must be greater than 0.
    @return The log-PDF value for the given input vector [x].
*)


(* ends here *)
