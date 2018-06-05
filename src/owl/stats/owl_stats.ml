(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Random numbers and distributions *)

include Owl_stats_dist


(* Randomisation function *)

let shuffle x =
  let y = Array.copy x in
  Owl_stats_extend.shuffle y;
  y


let choose x k =
  assert (Array.length x >= k);
  let y = Array.make k x.(0) in
  Owl_stats_extend.choose ~src:x ~dst:y;
  y


let sample x k =
  let y = Array.make k x.(0) in
  Owl_stats_extend.sample ~src:x ~dst:y;
  y


(* Basic statistical functions *)

let sum x = Owl_stats_extend.sum x


let mean x = Owl_stats_extend.mean x


let _get_mean m x =
  match m with
  | Some a -> a
  | None   -> mean x


let var ?mean x = Owl_stats_extend.var x (_get_mean mean x)


let std ?mean x = Owl_stats_extend.std x (_get_mean mean x)


let sem ?mean x =
  let s = std ?mean x in
  let n = float_of_int (Array.length x) in
  s /. (sqrt n)


let absdev ?mean x = Owl_stats_extend.absdev x (_get_mean mean x)


let skew ?mean ?sd x =
  let m = _get_mean mean x in
  let s = match sd with
    | Some a -> a
    | None   -> std ~mean:m x
  in
  Owl_stats_extend.skew x m s


let kurtosis ?mean ?sd x =
  let m = _get_mean mean x in
  let s = match sd with
    | Some a -> a
    | None   -> std ~mean:m x
  in
  Owl_stats_extend.kurtosis x m s


(* TODO: move to C code *)
let central_moment = Owl_base_stats.central_moment


let corrcoef x0 x1 =
  assert Array.(length x0 = length x1);
  Owl_stats_extend.corrcoef x0 x1


(* TODO: optimise *)
let sort = Owl_base_stats.sort


let argsort = Owl_base_stats.argsort


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
  end;
  ranks


let autocorrelation ?(lag=1) x =
  let n = Array.length x in
  let y = mean x in
  let a = ref 0. in
  for i = 0 to (n - lag - 1) do
    a := !a +. ((x.(i) -. y) *. (x.(i+lag) -. y))
  done;
  let b = ref 0. in
  for i = 0 to (n - 1) do
    b := !b +. (x.(i) -. y) ** 2.
  done;
  (!a /. !b)


let cov ?m0 ?m1 x0 x1 =
  assert Array.(length x0 = length x1);
  let m0 = _get_mean m0 x0 in
  let m1 = _get_mean m1 x1 in
  Owl_stats_extend.cov x0 x1 m0 m1


let concordant = Owl_base_stats.concordant


let discordant = Owl_base_stats.discordant


let kendall_tau = Owl_base_stats.kendall_tau


let spearman_rho x0 x1 =
  let r0 = rank x0 in
  let r1 = rank x1 in
  let a = cov r0 r1 in
  let b = (std r0) *. (std r1) in
  a /. b


let minmax_i = Owl_base_stats.minmax_i


let min_i = Owl_base_stats.min_i


let max_i = Owl_base_stats.max_i


let min = Owl_base_stats.min


let max = Owl_base_stats.max


let minmax = Owl_base_stats.minmax


type histogram = Owl_base_stats.histogram = {
  bins              : float array;
  counts            : int array;
  weighted_counts   : float array option;
  normalised_counts : float array option;
  density           : float array option}


let histogram = Owl_base_stats.histogram


let histogram_weighted = Owl_base_stats.histogram_weighted


let histogram_sorted = Owl_base_stats.histogram_sorted


let histogram_sorted_weighted = Owl_base_stats.histogram_sorted_weighted


let normalise = Owl_base_stats.normalise


let normalise_density = Owl_base_stats.normalise_density


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


let quantile x p =
  assert (p >= 0. && p <= 1.);
  Owl_stats_extend.quantile (sort ~inc:true x) p


let percentile x p = quantile x (p /. 100.)


let median x = percentile x 0.5


let first_quartile x = percentile x 0.25


let third_quartile x = percentile x 0.75


let z_score ~mu ~sigma x = Array.map (fun y -> (y -. mu) /. sigma) x


let t_score x =
  let mu = mean x in
  let sigma = std x in
  z_score ~mu ~sigma x


let normlise_pdf x =
  let c = Owl_stats_extend.sum x in
  Array.map (fun x -> x /. c) x


(* TODO *)

let centerise x = None

let standarderise x = None

let ksdensity x = None


(* Hypothesis tests *)

type tail = BothSide | RightSide | LeftSide

type hypothesis = {
  reject : bool;
  p_value : float;
  score : float;
}

let make_hypothesis reject p_value score = {
  reject;
  p_value;
  score
}


let z_test ~mu ~sigma ?(alpha=0.05) ?(side=BothSide) x =
  let n = float_of_int (Array.length x) in
  let z = (mean x -. mu) *. (sqrt n) /. sigma in

  let pl = gaussian_cdf ~mu:0. ~sigma:1. z in
  let pr = gaussian_sf  ~mu:0. ~sigma:1. z in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  make_hypothesis h p z


let t_test ~mu ?(alpha=0.05) ?(side=BothSide) x =
  let n = float_of_int (Array.length x) in
  let m = mean x in
  let s = std ~mean:m x in
  let t = (m -. mu) *. (sqrt n) /. s in
  let pl = t_cdf ~df:(n -. 1.) ~loc:0. ~scale:1. t in
  let pr = t_sf  ~df:(n -. 1.) ~loc:0. ~scale:1. t in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  make_hypothesis h p t


let t_test_paired ?(alpha=0.05) ?(side=BothSide) x y =
  let nx = float_of_int (Array.length x) in
  let ny = float_of_int (Array.length y) in
  let _ = if nx <> ny then
    failwith "the sizes of two samples does not equal."
  in
  let d = Owl_utils.Array.map2i (fun _ a b -> a -. b) x y in
  let m = Owl_stats_extend.sum d /. nx in
  let t = m /. (sem ~mean:m d) in
  let pl = t_cdf ~df:(nx -. 1.) ~loc:0. ~scale:1. t in
  let pr = t_sf  ~df:(nx -. 1.) ~loc:0. ~scale:1. t in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  make_hypothesis h p t


let _t_test2_equal_var ~alpha ~side x y =
  let nx = float_of_int (Array.length x) in
  let ny = float_of_int (Array.length y) in
  let xm = mean x in
  let ym = mean y in
  let xs = std x in
  let ys = std y in
  let v = nx +. ny -. 2. in
  let t = (xm -. ym) /. (sqrt (((xs ** 2.) /. nx) +. ((ys ** 2.) /. ny))) in
  let pl = t_cdf ~df:v ~loc:0. ~scale:1. t in
  let pr = t_sf  ~df:v ~loc:0. ~scale:1. t in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  make_hypothesis h p t


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
  let pl = t_cdf ~df:v ~loc:0. ~scale:1. t in
  let pr = t_sf  ~df:v ~loc:0. ~scale:1. t in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  make_hypothesis h p t


let t_test_unpaired ?(alpha=0.05) ?(side=BothSide) ?(equal_var=true) x y =
  match equal_var with
  | true  -> _t_test2_equal_var ~alpha ~side x y
  | false -> _t_test2_welche ~alpha ~side x y


let smirnov n e =
  let nn = int_of_float (floor ((float_of_int n) *. (1. -. e))) in
  let rec helper sum v c =
    let evn = e +. (float_of_int v) /. (float_of_int n) in
    let sum' = sum +. c *. (evn ** (float_of_int (v - 1)))
                         *. ((1. -. evn) ** (float_of_int (n - v))) in
    let c' = c *. (float_of_int (n - v)) /. (float_of_int (v + 1)) in
    if v <= nn then
      helper sum' (v + 1) c'
    else
      sum
  in
  let helper2 () =
    let maxlog = log max_float in
    let lngamma = Owl_maths_special.loggamma in
    let lgamnp1 = lngamma (1. +. float_of_int n) in
    let rec helper3 sum v =
      let evn = e +. (float_of_int v) /. (float_of_int n) in
      let omevn = 1. -. evn in
      let t = lgamnp1
              -. lngamma (1. +. float_of_int v)
              -. lngamma (1. +. float_of_int (n + v)) in
      let sum' = sum +. exp t in
      if v <= nn then
        if abs_float omevn > 0. && t > ~-. maxlog then
          helper3 sum' (v + 1)
        else
          helper3 sum (v + 1)
      else
        sum
    in
    helper3 0. 0
  in
  if not (n > 0 && e >= 0. && e <= 1.) then nan
  else if e = 0.0 then 1.0
  else if n < 1013 then
    e *. (helper 0. 0 1.)
  else
    e *. (helper2 ())

let kolmogorov y =
  let x = (-2.) *. y *. y in
  let rec helper sign sum r =
    let t = exp (x *. r *. r) in
    let sum' = sum +. sign *. t in
    let r' = r +. 1. in
    let sign' = ~-. sign in
    if t = 0.0 || (t /. sum' <= 1.1e-16) then sum'
    else helper sign' sum' r'
  in
  if y < 1.1e-16 then 1.0
  else
    2. *. helper 1. 0. 1.

let ks_test ?(alpha=0.05) x f =
  let x' = sort x in
  let max p q = if p > q then p else q in
  let n = Array.length x' in
  let nn = float_of_int n in
  let fvals = Array.map f x' in
  let g1 i v = v -. (float_of_int i) /. nn in
  let g2 i v = (float_of_int (i+1)) /. nn -. v in
  let d1 = Array.fold_left max 0. (Array.mapi g1 fvals) in
  let d2 = Array.fold_left max 0. (Array.mapi g2 fvals) in
  let d = max d1 d2 in
  let pval =  2. *. (smirnov n d) in
  let pval2 = kolmogorov (d *. sqrt nn) in
  if n = 0 then raise Owl_exception.EMPTY_ARRAY
  else if n > 2666 || pval2 > 0.8 -. nn *. 0.003
  then make_hypothesis (pval2 < alpha) pval2 d
  else make_hypothesis (pval < alpha) pval d


let rec uniques l = match l with
  | []             -> []
  | x :: []        -> x :: []
  | x1 :: x2 :: xs ->
     if x1 = x2 then uniques (x2 :: xs)
     else x1 :: (uniques (x2 :: xs))

(* Compute the empirical CDF of a list of samples from the input
   domain (sorted list of floats). The output is a list of length
   equal to domain. Both inputs are assumed to be sorted. *)
let empCdf domain samples =
  let rec count x samples = match samples with
    | []      -> (0, samples)
    | y :: ys ->
       if x = y then
         let (n, rest) = count x ys in
         (n + 1, rest)
       else
         (0, samples)
  in
  let rec aggregate accum domain samples = match domain with
    | []      -> []
    | x :: xs ->
       let (p, rest) = count x samples in
       let accum' = accum + p in
       accum' :: (aggregate accum' xs rest)
  in
  let n = float_of_int (List.length samples) in
  let a = aggregate 0 domain samples in
  List.map (fun x -> (float_of_int x) /. n) a

let ks2_test ?(alpha=0.05) x y =
  let n1 = Array.length x in
  let n2 = Array.length y in
  if n1 = 0 || n2 = 0 then
    raise Owl_exception.EMPTY_ARRAY
  else
    let nn1 = float_of_int n1 in
    let nn2 = float_of_int n2 in
    let x' = Array.to_list (sort x) in
    let y' = Array.to_list (sort y) in
    let domain = uniques (Array.to_list (sort (Array.concat [x; y]))) in
    let xCdf = empCdf domain x' in
    let yCdf = empCdf domain y' in
    let diffs = List.map2 (fun p q -> abs_float (p -. q)) xCdf yCdf in
    let max p q = if p > q then p else q in
    let d = List.fold_left max 0. diffs in
    let en = sqrt (nn1 *. nn2 /. (nn1 +. nn2)) in
    let pval = kolmogorov ((en +. 0.12 +. 0.11 /. en) *. d) in
    make_hypothesis (pval < alpha) pval d


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
  let p = chi2_sf ~df:2. j in
  let h = alpha > p in
  make_hypothesis h p j


let var_test ?(alpha=0.05) ?(side=BothSide) ~variance x =
  let n = float_of_int (Array.length x) in
  let v = n -. 1. in
  let k = v *. (var x) /. variance in
  let pl = chi2_cdf ~df:v k in
  let pr = chi2_sf  ~df:v k in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  make_hypothesis h p k


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
          let p = hypergeometric_pdf ~good:n1 ~bad:n2 ~sample:t x in
          if (p < max_prob) || (abs_float (p -. max_prob)) < eps
          then acc +. p
          else acc)
      ~init:0.0
  in
  (* let n = a + b + c + d in *)
  let prob = hypergeometric_pdf ~good:(a + b) ~bad:(c + d) ~sample:(a + c) a in
  let oddsratio = ((float_of_int a) *. (float_of_int d)) /. ((float_of_int b) *. (float_of_int c)) in
  let p = match side with
    | BothSide  -> cdf a (a + b) (c + d) (a + c) ~max_prob:prob
    | RightSide -> cdf b (b + a) (c + d) (b + d)
    | LeftSide  -> cdf a (a + b) (c + d) (a + c)
  in
  let h = alpha > p in
  make_hypothesis h p oddsratio


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
  | _   -> 1.0 -. (float_of_int numerator)/.(size *. size *. size -. size)


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
      | BothSide -> 2.0 *. gaussian_sf ~mu:0. ~sigma:1. (abs_float z)
      | _ -> gaussian_sf ~mu:0. ~sigma:1. z
    in
    let h = alpha > p in
    make_hypothesis h p u2
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
    make_hypothesis h p u2
  in
  if (max ranked) = (n1 +. n2) && (max [|n1;n2|]) < 10. then exact 1
  else asymptotic 1


(* wilcoxon paired *)
let wilcoxon ?(alpha=0.05) ?(side=BothSide) x y =
  let d = Array.map2 (fun a b -> a -. b) x y in
  let d = Owl_utils.Array.filter (fun a -> a <> 0.) d in
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
    let p = 2.0 *. gaussian_sf ~mu:0. ~sigma:1. (abs_float z) in
    match side with
    | BothSide  -> p
    | RightSide -> (1. -. p /. 2.)
    | LeftSide  -> p /. 2.
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
      else Array.fold_left (+.) 0. (Owl_utils.Array.map (fun i -> f (float_of_int i) n1) (Owl_utils.Array.range 0 (int_of_float v)))
    in
    match side with
    | BothSide  -> 2. *. p /. (2. ** n1)
    | RightSide -> 1. -. (p /. (2. ** n1))
    | LeftSide  -> p /. (2. ** n1)
  in
  let p =
    if (Array.length d) = (Array.length x) && n < 10. then exact t
    else asymptotic 1
  in
  let h = alpha > p in
  make_hypothesis h p t


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
  let pl = gaussian_cdf ~mu:0. ~sigma:1. z in
  let pr = gaussian_sf  ~mu:0. ~sigma:1. z in
  let p = match side with
    | LeftSide  -> pl
    | RightSide -> pr
    | BothSide  -> min [|pl; pr|] *. 2.
  in
  let h = alpha > p in
  make_hypothesis h p z


let crosstab x = None
(* Cross-tabulation *)


(* MCMC: Metropolis and Gibbs sampling *)

let metropolis_hastings f p n =
  let stepsize = 0.1 in    (* be careful about step size, try 0.01 *)
  let a, b = 1000, 10 in
  let s = Array.make n p in
  for i = 0 to a + b * n - 1 do
    let p' = Array.map (fun x -> gaussian_rvs ~mu:0. ~sigma:stepsize +. x) p in
    let y, y' = f p, f p' in
    let p' = (
      if y' >= y then p'
      else if std_uniform_rvs () < (y' /. y) then p'
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
