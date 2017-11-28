(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(*random generators *)
type t = Gsl.Rng.t


(* Set up random environment *)

let rng =
  let r = Gsl.Rng.make Gsl.Rng.MT19937 in
  let s = Nativeint.of_float (Unix.gettimeofday () *. 1000000.) in
  Gsl.Rng.set r s; r

let seed s = Gsl.Rng.set rng (Nativeint.of_int s)

(* TODO: change the order of the arguments in _pdf functions *)


(* Randomisation function *)

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

let sem ?w ?mean x =
  let s = std ?w ?mean x in
  let n = float_of_int (Array.length x) in
  s /. (sqrt n)

let absdev ?w ?mean x = Gsl.Stats.absdev ?w ?mean x

let skew ?w ?mean ?sd x =
  match mean, sd with
  | Some m, Some sd -> Gsl.Stats.skew_m_sd ?w ~mean:m ~sd:sd x
  | None, None -> Gsl.Stats.skew x
  | _, _ -> failwith "not enough arguments"

let kurtosis ?w ?mean ?sd x =
  let k = match mean, sd with
    | Some m, Some sd -> Gsl.Stats.kurtosis_m_sd ?w ~mean:m ~sd:sd x
    | None, None -> Gsl.Stats.kurtosis x
    | _, _ -> failwith "not enough arguments"
  (* GSL returns excess kurtosis, so add back *)
  in k +. 3.

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

let argsort ?(inc=true) x =
  let n = Array.length x in
  let dir = if inc then 1 else (-1) in
  let order = Array.init n (fun i -> i) in begin
    Array.sort (fun i j -> dir * compare x.(i) x.(j)) order;
    order
  end

let _resolve_ties next d = function
  | `Average    -> float_of_int next -. float_of_int d /. 2.
  | `Min        -> float_of_int (next - d)
  | `Max        -> float_of_int next

let rank ?(ties_strategy=`Average) vs =
  let n = Array.length vs in
  let order = argsort vs in
  let ranks = Array.make n 0. in
  let d = ref 0 in begin
    for i = 0 to n - 1 do
      if i == n - 1 || compare vs.(order.(i)) vs.(order.(i + 1)) <> 0
      then
        let tie_rank = _resolve_ties (i + 1) !d ties_strategy in
        for j = i - !d to i do
          ranks.(order.(j)) <- tie_rank
        done;
        d := 0
      else
        incr d  (* Found a duplicate! *)
    done;
  end; ranks


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

let _concordant x0 x1 =
  let c = ref 0 in
  for i = 0 to (Array.length x0) - 1 do
    for j = 0 to (Array.length x0) - 1 do
      if (i <> j) && (
        ((x0.(i) < x0.(j)) && (x1.(i) < x1.(j))) ||
        ((x0.(i) > x0.(j)) && (x1.(i) > x1.(j))) ) then
        c := !c + 1
    done
  done; (!c / 2)

let _discordant x0 x1 =
  let c = ref 0 in
  for i = 0 to (Array.length x0) - 1 do
    for j = 0 to (Array.length x0) - 1 do
      if (i <> j) && (
        ((x0.(i) < x0.(j)) && (x1.(i) > x1.(j))) ||
        ((x0.(i) > x0.(j)) && (x1.(i) < x1.(j))) ) then
        c := !c + 1
    done
  done; (!c / 2)

let concordant x0 x1 =
  let c = ref 0 in
  for i = 0 to (Array.length x0) - 2 do
    for j = i + 1 to (Array.length x0) - 1 do
      if (i <> j) && (
        ((x0.(i) < x0.(j)) && (x1.(i) < x1.(j))) ||
        ((x0.(i) > x0.(j)) && (x1.(i) > x1.(j))) ) then
        c := !c + 1
    done
  done; !c

let discordant x0 x1 =
  let c = ref 0 in
  for i = 0 to (Array.length x0) - 2 do
    for j = i + 1 to (Array.length x0) - 1 do
      if (i <> j) && (
        ((x0.(i) < x0.(j)) && (x1.(i) > x1.(j))) ||
        ((x0.(i) > x0.(j)) && (x1.(i) < x1.(j))) ) then
        c := !c + 1
    done
  done; !c

let kendall_tau x0 x1 =
  let a = float_of_int (concordant x0 x1) in
  let b = float_of_int (discordant x0 x1) in
  let n = float_of_int (Array.length x0) in
  2. *. (a -. b) /. (n *. (n -. 1.))

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

let histogram x n =
  let a, b = minmax x in
  match a = b with
  | true  -> [|1|]
  | false -> (
    let c = (b -. a) /. (float_of_int n) in
    let d = Array.make n 0 in
    Array.iter (fun y ->
      let i = int_of_float ((y -. a) /. c) in
      let i = if y = b then i - 1 else i in
      d.(i) <- d.(i) + 1
    ) x; d)

let ecdf x =
  let x = sort ~inc:true x in
  let n = Array.length x in
  let m = float_of_int n in
  let y = ref [||] in
  let f = ref [||] in
  let i = ref 0 in
  let c = ref 0. in
  while !i < n do
    let j = ref !i in
    while (!j < n) && (x.(!i) = x.(!j)) do
      c := !c +. 1.;
      j := !j + 1
    done;
    y := Array.append !y [|x.(!i)|];
    f := Array.append !f [|!c /. m|];
    i := !j
  done;
  !y, !f

let _quantile_from_sorted_data x q = Gsl.Stats.quantile_from_sorted_data x q
(* x must be in ascending order. *)

let percentile x q = _quantile_from_sorted_data (sort ~inc:true x) q

let median x = percentile x 0.5

let first_quartile x = percentile x 0.25

let third_quartile x = percentile x 0.75

let z_score ~mu ~sigma x = Array.map (fun y -> (y -. mu) /. sigma) x

let t_score x =
  let mu = mean x in
  let sigma = std x in
  z_score ~mu ~sigma x

let normlise_pdf x =
  let c = Owl_utils.array_sum x in
  Array.map (fun x -> x /. c) x

let centerise x = None

let standarderise x = None

let ksdensity x = None


module Rnd = struct

  let uniform_int ?(a=0) ?(b=65535) ()=
    (Gsl.Rng.uniform_int rng (b - a + 1)) + a

  let uniform () = Gsl.Rng.uniform rng

  let gaussian ?(sigma=1.) () = Gsl.Randist.gaussian_ziggurat rng sigma

  let gaussian_tail a sigma = Gsl.Randist.gaussian_tail rng a sigma

  let bivariate_gaussian sigma_x sigma_y rho = Gsl.Randist.bivariate_gaussian rng sigma_x sigma_y rho

  let exponential mu = Gsl.Randist.exponential rng mu

  let laplace a = Gsl.Randist.laplace rng a

  let exppow a b = Gsl.Randist.exppow rng a b

  let cauchy a = Gsl.Randist.cauchy rng a

  let rayleigh sigma = Gsl.Randist.rayleigh rng sigma

  let rayleigh_tail a sigma = Gsl.Randist.rayleigh_tail rng a sigma

  let landau () = Gsl.Randist.landau rng

  let levy c alpha = Gsl.Randist.levy rng c alpha

  let levy_skew c alpha beta = Gsl.Randist.levy_skew rng c alpha beta

  let gamma a b = Gsl.Randist.gamma rng a b

  let flat a b = Gsl.Randist.flat rng a b  (* TODO: use this to replace uniform *)

  let lognormal zata sigma = Gsl.Randist.lognormal rng zata sigma

  let chisq nu = Gsl.Randist.chisq rng nu

  let dirichlet alpha theta = Gsl.Randist.dirichlet rng alpha theta

  let fdist nu1 nu2 = Gsl.Randist.fdist rng nu1 nu2

  let tdist nu = Gsl.Randist.tdist rng nu

  let beta a b = Gsl.Randist.beta rng a b

  let logistic a = Gsl.Randist.logistic rng a

  let pareto a b = Gsl.Randist.pareto rng a b

  let dir_2d () = Gsl.Randist.dir_2d rng

  let dir_2d_trig_method () = Gsl.Randist.dir_2d_trig_method rng

  let dir_3d () = Gsl.Randist.dir_3d rng

  let dir_nd n =
    let x = Array.make n 0. in
    Gsl.Randist.dir_nd rng x; x

  let weibull a b = Gsl.Randist.weibull rng a b

  let gumbel1 a b = Gsl.Randist.gumbel1 rng a b

  let gumbel2 a b = Gsl.Randist.gumbel2 rng a b

  let poisson mu = Gsl.Randist.poisson rng mu

  let bernoulli p = Gsl.Randist.bernoulli rng p

  let binomial p n = Gsl.Randist.binomial rng p n

  let multinomial n p = Gsl.Randist.multinomial rng n p

  let negative_binomial p n = Gsl.Randist.negative_binomial rng p n

  let pascal p n = Gsl.Randist.pascal rng p n

  let geometric p = Gsl.Randist.geometric rng p

  let hypergeometric n1 n2 t = Gsl.Randist.hypergeometric rng n1 n2 t

  let logarithmic p = Gsl.Randist.logarithmic rng p

end


module Pdf = struct

  let gaussian x sigma = Gsl.Randist.gaussian_pdf x sigma

  let gaussian_tail x a sigma = Gsl.Randist.gaussian_tail_pdf x a sigma

  let bivariate_gaussian x y sigma_x sigma_y rho = Gsl.Randist.bivariate_gaussian_pdf x y sigma_x sigma_y rho

  let exponential x mu = Gsl.Randist.exponential_pdf x mu

  let laplace x a = Gsl.Randist.laplace_pdf x a

  let exppow x a b = Gsl.Randist.exppow_pdf x a b

  let cauchy x a = Gsl.Randist.cauchy_pdf x a

  let rayleigh x sigma = Gsl.Randist.rayleigh_pdf x sigma

  let rayleigh_tail x a sigma = Gsl.Randist.rayleigh_tail_pdf x a sigma

  let landau x = Gsl.Randist.landau_pdf x

  let gamma x a b = Gsl.Randist.gamma_pdf x a b

  let flat x a b = Gsl.Randist.flat_pdf x a b

  let lognormal x zeta sigma = Gsl.Randist.lognormal_pdf x zeta sigma

  let chisq x nu = Gsl.Randist.chisq_pdf x nu

  let dirichlet alpha theta = Gsl.Randist.dirichlet_pdf alpha theta

  let dirichlet_lnpdf alpha theta = Gsl.Randist.dirichlet_lnpdf alpha theta

  let fdist x nu1 nu2 = Gsl.Randist.fdist_pdf x nu1 nu2

  let tdist x nu = Gsl.Randist.tdist_pdf x nu

  let beta x a b = Gsl.Randist.beta_pdf x a b

  let logistic x a = Gsl.Randist.logistic_pdf x a

  let pareto x a b = Gsl.Randist.pareto_pdf x a b

  let weibull x a b = Gsl.Randist.weibull_pdf x a b

  let gumbel1 x a b = Gsl.Randist.gumbel1_pdf x a b

  let gumbel2 x a b = Gsl.Randist.gumbel2_pdf x a b

  let poisson x mu = Gsl.Randist.poisson_pdf x mu

  let bernoulli x p = Gsl.Randist.bernoulli_pdf x p

  let binomial x p n = Gsl.Randist.binomial_pdf x p n

  let multinomial p n = Gsl.Randist.multinomial_pdf p n

  let multinomial_lnpdf p n = Gsl.Randist.multinomial_lnpdf p n

  let negative_binomial x p n = Gsl.Randist.negative_binomial_pdf x p n

  let pascal x p n = Gsl.Randist.pascal_pdf x p n

  let geometric x p = Gsl.Randist.geometric_pdf x p

  let hypergeometric x n1 n2 t = Gsl.Randist.hypergeometric_pdf x n1 n2 t

  let logarithmic x p = Gsl.Randist.logarithmic_pdf x p

end


module Cdf = struct

  let gaussian_P x sigma = Gsl.Cdf.gaussian_P x sigma

  let gaussian_Q x sigma = Gsl.Cdf.gaussian_Q x sigma

  let gaussian_Pinv x sigma = Gsl.Cdf.gaussian_Pinv x sigma

  let gaussian_Qinv x sigma = Gsl.Cdf.gaussian_Qinv x sigma

  let exponential_P x mu = Gsl.Cdf.exponential_P x mu

  let exponential_Q x mu = Gsl.Cdf.exponential_Q x mu

  let exponential_Pinv p mu = Gsl.Cdf.exponential_Pinv p mu

  let exponential_Qinv q mu = Gsl.Cdf.exponential_Qinv q mu

  let laplace_P x a = Gsl.Cdf.laplace_P x a

  let laplace_Q x a = Gsl.Cdf.laplace_Q x a

  let laplace_Pinv p a = Gsl.Cdf.laplace_Pinv p a

  let laplace_Qinv q a = Gsl.Cdf.laplace_Qinv q a

  let exppow_P x a b = Gsl.Cdf.exppow_P x a b

  let exppow_Q x a b = Gsl.Cdf.exppow_Q x a b

  let cauchy_P x a = Gsl.Cdf.cauchy_P x a

  let cauchy_Q x a = Gsl.Cdf.cauchy_Q x a

  let cauchy_Pinv p a = Gsl.Cdf.cauchy_Pinv p a

  let cauchy_Qinv q a = Gsl.Cdf.cauchy_Qinv q a

  let rayleigh_P x sigma = Gsl.Cdf.rayleigh_P x sigma

  let rayleigh_Q x sigma = Gsl.Cdf.rayleigh_Q x sigma

  let rayleigh_Pinv p sigma = Gsl.Cdf.rayleigh_Pinv p sigma

  let rayleigh_Qinv q sigma = Gsl.Cdf.rayleigh_Qinv q sigma

  let gamma_P x a b = Gsl.Cdf.gamma_P x a b

  let gamma_Q x a b = Gsl.Cdf.gamma_Q x a b

  let gamma_Pinv p a b = Gsl.Cdf.gamma_Pinv p a b

  let gamma_Qinv q a b = Gsl.Cdf.gamma_Qinv q a b

  let flat_P x a b = Gsl.Cdf.flat_P x a b

  let flat_Q x a b = Gsl.Cdf.flat_Q x a b

  let flat_Pinv p a b = Gsl.Cdf.flat_Pinv p a b

  let flat_Qinv q a b = Gsl.Cdf.flat_Qinv q a b

  let lognormal_P x zeta sigma = Gsl.Cdf.lognormal_P x zeta sigma

  let lognormal_Q x zeta sigma = Gsl.Cdf.lognormal_Q x zeta sigma

  let lognormal_Pinv p zeta sigma = Gsl.Cdf.lognormal_Pinv p zeta sigma

  let lognormal_Qinv q zeta sigma = Gsl.Cdf.lognormal_Qinv q zeta sigma

  let chisq_P x nu = Gsl.Cdf.chisq_P x nu

  let chisq_Q x nu = Gsl.Cdf.chisq_Q x nu

  let chisq_Pinv p nu = Gsl.Cdf.chisq_Pinv p nu

  let chisq_Qinv q nu = Gsl.Cdf.chisq_Qinv q nu

  let fdist_P x nu1 nu2 = Gsl.Cdf.fdist_P x nu1 nu2

  let fdist_Q x nu1 nu2 = Gsl.Cdf.fdist_Q x nu1 nu2

  let fdist_Pinv p nu1 nu2 = Gsl.Cdf.fdist_Pinv p nu1 nu2

  let fdist_Qinv q nu1 nu2 = Gsl.Cdf.fdist_Qinv q nu1 nu2

  let tdist_P x nu = Gsl.Cdf.tdist_P x nu

  let tdist_Q x nu = Gsl.Cdf.tdist_Q x nu

  let tdist_Pinv p nu = Gsl.Cdf.tdist_Pinv p nu

  let tdist_Qinv q nu = Gsl.Cdf.tdist_Qinv q nu

  let beta_P x a b = Gsl.Cdf.beta_P x a b

  let beta_Q x a b = Gsl.Cdf.beta_Q x a b

  let beta_Pinv p a b = Gsl.Cdf.beta_Pinv p a b

  let beta_Qinv q a b = Gsl.Cdf.beta_Qinv q a b

  let logistic_P x a = Gsl.Cdf.logistic_P x a

  let logistic_Q x a = Gsl.Cdf.logistic_Q x a

  let logistic_Pinv p a = Gsl.Cdf.logistic_Pinv p a

  let logistic_Qinv q a = Gsl.Cdf.logistic_Qinv q a

  let pareto_P x a b = Gsl.Cdf.pareto_P x a b

  let pareto_Q x a b = Gsl.Cdf.pareto_Q x a b

  let pareto_Pinv p a b = Gsl.Cdf.pareto_Pinv p a b

  let pareto_Qinv q a b = Gsl.Cdf.pareto_Qinv q a b

  let weibull_P x a b = Gsl.Cdf.weibull_P x a b

  let weibull_Q x a b = Gsl.Cdf.weibull_Q x a b

  let weibull_Pinv p a b = Gsl.Cdf.weibull_Pinv p a b

  let weibull_Qinv q a b = Gsl.Cdf.weibull_Qinv q a b

  let gumbel1_P x a b = Gsl.Cdf.gumbel1_P x a b

  let gumbel1_Q x a b = Gsl.Cdf.gumbel1_Q x a b

  let gumbel1_Pinv p a b = Gsl.Cdf.gumbel1_Pinv p a b

  let gumbel1_Qinv q a b = Gsl.Cdf.gumbel1_Qinv q a b

  let gumbel2_P x a b = Gsl.Cdf.gumbel2_P x a b

  let gumbel2_Q x a b = Gsl.Cdf.gumbel2_Q x a b

  let gumbel2_Pinv p a b = Gsl.Cdf.gumbel2_Pinv p a b

  let gumbel2_Qinv q a b = Gsl.Cdf.gumbel2_Qinv q a b

  let poisson_P x mu = Gsl.Cdf.poisson_P x mu

  let poisson_Q x mu = Gsl.Cdf.poisson_Q x mu

  let binomial_P x p n = Gsl.Cdf.binomial_P x p n

  let binomial_Q x p n = Gsl.Cdf.binomial_Q x p n

  let negative_binomial_P x p n = Gsl.Cdf.negative_binomial_P x p n

  let negative_binomial_Q x p n = Gsl.Cdf.negative_binomial_Q x p n

  let pascal_P x p n = Gsl.Cdf.pascal_P x p n

  let pascal_Q x p n = Gsl.Cdf.pascal_Q x p n

  let geometric_P x p = Gsl.Cdf.geometric_P x p

  let geometric_Q x p = Gsl.Cdf.geometric_Q x p

  let hypergeometric_P x n1 n2 t = Gsl.Cdf.hypergeometric_P x n1 n2 t

  let hypergeometric_Q x n1 n2 t = Gsl.Cdf.hypergeometric_Q x n1 n2 t

end


(* Hypothesis tests *)

type tail = BothSide | RightSide | LeftSide

type test_result = {
  reject : bool;
  p_value : float;
  score : float;
}

let z_test ~mu ~sigma ?(alpha=0.05) ?(side=BothSide) x =
  let n = float_of_int (Array.length x) in
  let z = (mean x -. mu) *. (sqrt n) /. sigma in
  let pl = Cdf.gaussian_P z 1. in
  let pr = Cdf.gaussian_Q z 1. in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  (h, p, z)

let f_test x = None

let t_test ~mu ?(alpha=0.05) ?(side=BothSide) x =
  let n = float_of_int (Array.length x) in
  let m = mean x in
  let s = std ~mean:m x in
  let t = (m -. mu) *. (sqrt n) /. s in
  let pl = Cdf.tdist_P t (n -. 1.) in
  let pr = Cdf.tdist_Q t (n -. 1.) in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  (h, p, t)

let t_test_paired ?(alpha=0.05) ?(side=BothSide) x y =
  let nx = float_of_int (Array.length x) in
  let ny = float_of_int (Array.length y) in
  let _ = if nx <> ny then
    failwith "the sizes of two samples does not equal."
  in
  let d = Owl_utils.array_map2i (fun _ a b -> a -. b) x y in
  let m = Owl_utils.array_sum d /. nx in
  let t = m /. (sem ~mean:m d) in
  let pl = Cdf.tdist_P t (nx -. 1.) in
  let pr = Cdf.tdist_Q t (nx -. 1.) in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  (h, p, t)

let _t_test2_equal_var ~alpha ~side x y =
  let nx = float_of_int (Array.length x) in
  let ny = float_of_int (Array.length y) in
  let xm = mean x in
  let ym = mean y in
  let xs = std x in
  let ys = std y in
  let v = nx +. ny -. 2. in
  let t = (xm -. ym) /. (sqrt (((xs ** 2.) /. nx) +. ((ys ** 2.) /. ny))) in
  let pl = Cdf.tdist_P t v in
  let pr = Cdf.tdist_Q t v in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  (h, p, t)

let _t_test2_welche ~alpha ~side x y =
  let nx = float_of_int (Array.length x) in
  let ny = float_of_int (Array.length y) in
  let xm = mean x in
  let ym = mean y in
  let xs = std x in
  let ys = std y in
  let vx = nx -. 1. in
  let vy = ny -. 1. in
  let v = ((((xs ** 2.) /. nx) +. ((ys ** 2.) /. ny)) ** 2.) /.
    ((xs ** 4.) /. ((vx *. (nx ** 2.))) +. ((ys ** 4.) /. (vy *. (ny ** 2.))))
  in
  let t = (xm -. ym) /. (sqrt (((xs ** 2.) /. nx) +. ((ys ** 2.) /. ny))) in
  let pl = Cdf.tdist_P t v in
  let pr = Cdf.tdist_Q t v in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  (h, p, t)

let t_test_unpaired ?(alpha=0.05) ?(side=BothSide) ?(equal_var=true) x y =
  match equal_var with
  | true  -> _t_test2_equal_var ~alpha ~side x y
  | false -> _t_test2_welche ~alpha ~side x y

let ks_test x = None
(* One-sample Kolmogorov-Smirnov test *)

exception EXN_EMPTY_ARRAY

let ks2_test ?(alpha=0.05) x y =
  (true, 0.0, 0.0)

let ad_test x = None
(* Anderson-Darling test *)

let dw_test x = None
(* Durbin-Watson test *)

let jb_test ?(alpha=0.05) x =
(* Jarque-Bera test *)
  let n = float_of_int (Array.length x) in
  let s = skew x in
  let k = kurtosis x in
  let j = (n /. 6.) *. ((s ** 2.) +. (((k -. 3.) ** 2.) /. 4.)) in
  let p = Cdf.chisq_Q j 2. in
  let h = alpha > p in
  (h, p, j)

let var_test ?(alpha=0.05) ?(side=BothSide) ~var x =
  let n = float_of_int (Array.length x) in
  let v = n -. 1. in
  let k = v *. (variance x) /. var in
  let pl = Cdf.chisq_P k v in
  let pr = Cdf.chisq_Q k v in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  (h, p, k)

let fisher_test ?(alpha=0.05) ?(side=BothSide) a b c d =
  let cdf ?(max_prob=1.) k n1 n2 t =
    let left = Pervasives.max 0 (t - n2) in
    let right = match max_prob with
      | 1. -> k
      | _ -> Pervasives.min n1 t
    in
    let eps = 0.000000001 in
    Owl_utils.range_fold left right
      ~f:(fun acc x ->
          let p = Pdf.hypergeometric x n1 n2 t in
          if (p < max_prob) || (abs_float (p -. max_prob)) < eps
          then acc +. p
          else acc)
      ~init:0.0
  in
  (* let n = a + b + c + d in *)
  let prob = Pdf.hypergeometric a (a + b) (c + d) (a + c) in
  let oddsratio = ((float_of_int a) *. (float_of_int d)) /. ((float_of_int b) *. (float_of_int c)) in
  let p = match side with
    | BothSide -> cdf a (a + b) (c + d) (a + c) ~max_prob:prob
    | RightSide -> cdf b (b + a) (c + d) (b + d)
    | LeftSide -> cdf a (a + b) (c + d) (a + c)
  in
  let h = alpha > p in
  (h, p, oddsratio)


let lillie_test x = None
(* Lilliefors test *)


let tiecorrect rankvals =
  let ranks_sort = sort rankvals in
  let counts = Owl_utils.count_dup (Array.to_list ranks_sort) in
  let size = (float_of_int (Array.length rankvals)) in
  let numerator  = Array.fold_left (+) 0 (Array.of_list (List.map (fun (x, y) -> y * y * y - y) counts)) in
  match size with
  | 0.0 -> 1.0
  | 1.0 -> 1.0
  | _ -> 1.0 -. (float_of_int numerator)/.(size *. size *. size -. size)


(* Mann–Whitney U test *)
let mannwhitneyu ?(alpha=0.05) ?(side=BothSide) x y =
  let rec exact_a u n m =
    if u < 0. then 0.
    else if u >= m *. (n -. m) then float_of_int (Owl_maths.combination (int_of_float n) (int_of_float m))
    else if (m = 1. || (n -. m) = 1.) then u +. 1.
    else ((exact_a u (n -. 1.) m) +. (exact_a (u -. (n -. m)) (n -. 1.) (m -. 1.)))
  in
  let n1 = float_of_int (Array.length x) in
  let n2 = float_of_int (Array.length y) in
  let ranked = rank (Array.append x y) in
  let rankx = Array.fold_left (+.) 0.0 (Array.sub ranked 0 (int_of_float n1)) in
  let u1 = n1 *. n2 +. (n1 *. (n1 +. 1.0)) /. 2.0 -. rankx in
  let u2 = n1 *. n2 -. u1 in
  let asymptotic v =
    let t = tiecorrect ranked in
    let sd = sqrt(t *. n1 *. n2 *. (n1 +. n2 +. 1.0) /. 12.0) in
    let mean = n1 *. n2 /. 2.0 in
    let bigu = match side with
      | BothSide -> Pervasives.max u1 u2
      | RightSide -> u2
      | LeftSide -> u1
    in
    let z = (bigu -. mean) /. sd in
    let p = match side with
      | BothSide -> 2.0 *. Cdf.gaussian_Q (abs_float z) 1.0
      | _ -> Cdf.gaussian_Q z 1.0
    in
    let h = alpha > p in
    (h, p, u2)
  in
  let exact v =
    let bigu = match side with
      | BothSide -> Pervasives.min u1 u2
      | RightSide -> u1
      | LeftSide -> u2
    in
    let p =
      let n = n1 +. n2 in
      let k = if n1 < n2 then n2 else n1 in
      let z = (exact_a bigu (n1 +. n2) k) /. float_of_int (Owl_maths.combination (int_of_float n) (int_of_float k)) in
      match side with
      | BothSide -> 2. *. z
      | _ -> z
    in
    let h = alpha > p in
    (h, p, u2)
  in
  if (max ranked) = (n1 +. n2) && (max [|n1;n2|]) < 10. then exact 1
  else asymptotic 1

(* wilcoxon paired*)
let wilcoxon ?(alpha=0.05) ?(side=BothSide) x y =
  let d = Array.map2 (fun a b -> a -. b) x y in
  let d = Owl_utils.array_filter (fun a -> a <> 0.) d in
  let n = float_of_int (Array.length d) in
  let rankval = rank (Array.map abs_float d) in
  let rp = Array.map2 (fun a b -> (if a > 0.0 then 1. else 0.) *. b) d rankval in
  let rm = Array.map2 (fun a b -> (if a < 0.0 then 1. else 0.) *. b) d rankval in
  let rp = Array.fold_left (+.) 0. rp in
  let rm = Array.fold_left (+.) 0. rm in
  let t = Pervasives.min rp rm in
  let asymptotic v =
    let mn = n *. (n +. 1.) *. 0.25 in
    let se = n *. (n +. 1.) *. (2. *. n +. 1.) in
    let t_correction rankvals =
      let ranks_sort = sort rankvals in
      let counts = Owl_utils.count_dup (Array.to_list ranks_sort) in
      (* let size = (float_of_int (Array.length rankvals)) in *)
      Array.fold_left (+) 0 (Array.of_list (List.map (fun (x, y) -> y * y * y - y) counts))
    in
    let corr = float_of_int (t_correction rankval) in
    let se = sqrt((se -. 0.5 *. corr)/. 24.) in
    let z = (t -. mn) /. se in
    let p = 2.0 *. Cdf.gaussian_Q (abs_float z) 1. in
    match side with
    | BothSide -> p
    | RightSide -> (1. -. p /. 2.)
    | LeftSide -> p /. 2.
  in
  let exact v =
    let rec f w n =
      if (w = n *. (n +. 1.) /. 2.)  || (w = 0. && n >= 0.) then 1.
      else if (w < 0. && n > 0.) || (w > 0. && n = 0.)  || (n < 0.) then 0.
      else f w (n -. 1.) +. f (w -. n) (n -. 1.)
    in
    let n1 = float_of_int (Array.length x) in
    let v =
      match side with
      | RightSide -> v -. 1.
      | _ -> v
    in
    let p =
      if v < 0. then 0.
      else Array.fold_left (+.) 0. (Owl_utils.array_map (fun i -> f (float_of_int i) n1) (Owl_utils.range 0 (int_of_float v)))
    in
    match side with
    | BothSide -> 2. *. p /. (2. ** n1)
    | RightSide -> 1. -. (p /. (2. ** n1))
    | LeftSide -> p /. (2. ** n1)
  in
  let p =
    if (Array.length d) = (Array.length x) && n < 10. then exact t
    else asymptotic 1
  in
  let h = alpha > p in
  match side with
  | BothSide -> (h, p, t)
  | RightSide -> (h, p, t)
  | LeftSide -> (h, p, t)



let runs_test ?(alpha=0.05) ?(side=BothSide) ?v x =
(* Run test for randomness *)
let v = match v with
  | Some v -> v
  | None -> median x
in
let n1, n2 = ref 0., ref 0. in
let z = ref [||] in
let _ = Array.iter (fun y ->
  if y > v then (n1 := !n1 +. 1.; z := Array.append !z [|1|])
  else if y < v then (n2 := !n2 +. 1.; z := Array.append !z [|-1|])
) x in
let r0 = ref 1. in
let _ = for i = 0 to Array.length !z - 2 do
  match (!z.(i) * !z.(i+1)) < 0 with
  | true  -> r0 := !r0 +. 1.
  | false -> ()
done in
let aa = 2. *. !n1 *. !n2 in
let bb = !n1 +. !n2 in
let r1 = aa /. bb +. 1. in
let sr = aa *. (aa -. bb) /. (bb *. bb *. (bb -. 1.)) in
let z = (!r0 -. r1) /. (sqrt sr) in
let pl = Cdf.gaussian_P z 1. in
let pr = Cdf.gaussian_Q z 1. in
let p = match side with
  | LeftSide  -> pl
  | RightSide -> pr
  | BothSide  -> min [|pl; pr|] *. 2.
in
let h = alpha > p in
(h, p, z)

let crosstab x = None
(* Cross-tabulation *)


(* MCMC: Metropolis and Gibbs sampling *)

let metropolis_hastings f p n =
  let stepsize = 0.1 in    (* be careful about step size, try 0.01 *)
  let a, b = 1000, 10 in
  let s = Array.make n p in
  for i = 0 to a + b * n - 1 do
    let p' = Array.map (fun x -> Rnd.gaussian ~sigma:stepsize () +. x) p in
    let y, y' = f p, f p' in
    let p' = (
      if y' >= y then p'
      else if (Rnd.flat 0. 1.) < (y' /. y) then p'
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
