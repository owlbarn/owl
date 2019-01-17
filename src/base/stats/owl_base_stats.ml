(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* PRNG of various distributions *)

let std_uniform_rvs = Owl_base_stats_dist_uniform.std_uniform_rvs


let uniform_int_rvs = Owl_base_stats_dist_uniform.uniform_int_rvs


let uniform_rvs = Owl_base_stats_dist_uniform.uniform_rvs


let bernoulli_rvs = Owl_base_stats_dist_bernoulli.bernoulli_rvs


let gaussian_rvs = Owl_base_stats_dist_gaussian.gaussian_rvs


let exponential_rvs = Owl_base_stats_dist_exponential.exponential_rvs


let cauchy_rvs = Owl_base_stats_dist_cauchy.cauchy_rvs


let std_gamma_rvs = Owl_base_stats_dist_gamma.std_gamma_rvs


let gamma_rvs = Owl_base_stats_dist_gamma.gamma_rvs


let gumbel1_rvs = Owl_base_stats_dist_gumbel1.gumbel1_rvs


let gumbel2_rvs = Owl_base_stats_dist_gumbel2.gumbel2_rvs


(* Randomisation function *)

let shuffle x =
  let y = Array.copy x in
  let n = Array.length x in

  for i = n - 1 downto 1 do
    let s = float_of_int (i + 1) in
    let j = int_of_float (std_uniform_rvs () *. s) in
    Owl_utils_array.swap y i j
  done;

  y


let choose x k =
  let n = Array.length x in
  assert (n >= k);
  let y = Array.make k x.(0) in
  let i = ref 0 in
  let j = ref 0 in

  while !i < n && !j < k do
    let s = float_of_int (n - !i) in
    let l = int_of_float (s *. std_uniform_rvs ()) in
    if l < (k - !j) then (
      y.(!j) <- x.(!i);
      j := !j + 1;
    );
    i := !i + 1;
  done;

  y


let sample x k =
  let y = Array.make k x.(0) in
  let n = Array.length x in

  for i = 0 to k - 1 do
    let j = uniform_int_rvs n in
    y.(i) <- x.(j)
  done;

  y


(* Basic statistical functions *)

let sum x = Array.fold_left ( +. ) 0. x


let mean x =
  let n = float_of_int (Array.length x) in
  sum x /. n


let _get_mean m x =
  match m with
  | Some a -> a
  | None   -> mean x


let var ?mean x =
  let m = _get_mean mean x in
  let t = ref 0. in

  Array.iter (fun a ->
    let d = a -. m in
    t := !t +. d *. d
  ) x;

  let l = float_of_int (Array.length x) in
  let n = if l = 1. then 1. else l -. 1. in
  !t /. n


let std ?mean x = sqrt (var ?mean x)


let sem ?mean x =
  let s = std ?mean x in
  let n = float_of_int (Array.length x) in
  s /. (sqrt n)


let absdev ?mean x =
  let m = _get_mean mean x in
  let t = ref 0. in

  Array.iter (fun a ->
    let d = abs_float (a -. m) in
    t := !t +. d
  ) x;

  let n = float_of_int (Array.length x) in
  !t /. n


let skew ?mean ?sd x =
  let m = _get_mean mean x in
  let s = match sd with
    | Some a -> a
    | None   -> std ~mean:m x
  in
  let t = ref 0. in

  Array.iter (fun a ->
    let s = (a -. m) /. s in
    t := !t +. s *. s *. s
  ) x;

  let n = float_of_int (Array.length x) in
  !t /. n


let kurtosis ?mean ?sd x =
  let m = _get_mean mean x in
  let s = match sd with
    | Some a -> a
    | None   -> std ~mean:m x
  in
  let t = ref 0. in

  Array.iter (fun a ->
    let s = (a -. m) /. s in
    let u = s *. s in
    t := !t +. u *. u
  ) x;

  let n = float_of_int (Array.length x) in
  !t /. n


let central_moment n x =
  let m = float_of_int n in
  let u = mean x in
  let x = Array.map (fun x -> (x -. u) ** m) x in
  let a = Array.fold_left (+.) 0. x in
  a /. (float_of_int (Array.length x))


let cov ?m0 ?m1 x0 x1 =
  let n0 = Array.length x0 in
  let n1 = Array.length x1 in
  assert (n0 = n1);
  let m0 = _get_mean m0 x0 in
  let m1 = _get_mean m1 x1 in
  let t = ref 0. in

  Array.iter2 (fun a0 a1 ->
    let d0 = a0 -. m0 in
    let d1 = a1 -. m1 in
    t := !t +. d0 *. d1
  ) x0 x1;

  let n = float_of_int (Array.length x0) in
  !t /. n


let concordant x0 x1 =
  let c = ref 0 in
  for i = 0 to (Array.length x0) - 2 do
    for j = i + 1 to (Array.length x0) - 1 do
      if (i <> j) && (
        ((x0.(i) < x0.(j)) && (x1.(i) < x1.(j))) ||
        ((x0.(i) > x0.(j)) && (x1.(i) > x1.(j))) ) then
        c := !c + 1
    done
  done;
  !c


let discordant x0 x1 =
  let c = ref 0 in
  for i = 0 to (Array.length x0) - 2 do
    for j = i + 1 to (Array.length x0) - 1 do
      if (i <> j) && (
        ((x0.(i) < x0.(j)) && (x1.(i) > x1.(j))) ||
        ((x0.(i) > x0.(j)) && (x1.(i) < x1.(j))) ) then
        c := !c + 1
    done
  done;
  !c


let kendall_tau x0 x1 =
  let a = float_of_int (concordant x0 x1) in
  let b = float_of_int (discordant x0 x1) in
  let n = float_of_int (Array.length x0) in
  2. *. (a -. b) /. (n *. (n -. 1.))


let sort ?(inc=true) x =
  let y = Array.copy x in
  let c = if inc then 1 else (-1) in
  Array.sort (fun a b ->
    if a < b then (-c)
    else if a > b then c
    else 0
  ) y;
  y


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
  end;
  ranks


let minmax_i x =
  assert (Array.length x > 0);
  let _min = ref x.(0) in
  let _max = ref x.(0) in
  let _min_idx = ref 0 in
  let _max_idx = ref 0 in
  Array.iteri (fun i a ->
    if a < !_min then (
      _min := a;
      _min_idx := i
    )
    else if a > !_max then (
      _max := a;
      _max_idx := i;
    )
  ) x;
  !_min_idx, !_max_idx


let min_i x = minmax_i x |> fst


let max_i x = minmax_i x |> snd


let min x = Array.fold_left min infinity x


let max x = Array.fold_left max neg_infinity x


let minmax x =
  let _min = ref infinity in
  let _max = ref neg_infinity in
  Array.iter (fun a ->
    if a < !_min then _min := a;
    if a > !_max then _max := a;
  ) x;
  !_min, !_max


type histogram = {
  bins              : float array;
  counts            : int array;
  weighted_counts   : float array option;
  normalised_counts : float array option;
  density           : float array option
}


(* fast unsafe array access! *)
let (.%()) = Array.unsafe_get and (.%()<-) = Array.unsafe_set
(*let (.%()) = Array.get and (.%()<-) = Array.set*)


let fcmp = (compare :> float -> _ -> _)


(* fast direct binning for uniform bins *)

let setup_uniform_binning n x =
  if n < 1 then failwith "Need at least one bin!";
  let bmin, bmax = minmax x in
  let db = (bmax -. bmin) /. float_of_int n in
  let bins = Array.init (n + 1) (fun i -> bmin +. float_of_int i *. db) in
  let get_bin y =
    let i = int_of_float ((y -. bmin) /. db) in
    if i = n then n - 1 else i in
  bmin, bmax, db, bins, get_bin


let hist_uniform n x =
  let _bmin, _bmax, _db, bins, get_bin = setup_uniform_binning n x in
  let c = Array.make n 0 in
  x |> Array.iter (fun y ->
      let i = get_bin y in
      c.%(i) <- c.%(i) + 1);
  bins, c


let hist_weighted_uniform n w x =
  if Array.(length x <> length w) then
    failwith  "Data and weights must have the same length.";
  let _bmin, _bmax, _db, bins, get_bin = setup_uniform_binning n x in
  let c = Array.make n 0 in
  let wc = Array.make n 0. in
  x |> Array.iteri (fun j y ->
      let i = get_bin y in
      c.%(i)  <- c.%(i) + 1;
      wc.%(i) <- wc.%(i) +. w.%(j));
  (bins, c), Some wc


(* nonuniform binning with binary search *)

let setup_nonuniform_binning bins =
  let n = Array.length bins - 1 in
  if n < 1 then failwith "Need at least two bin boundaries!";
  let get_bin y =
    let i = Owl_utils_array.bsearch ~cmp:fcmp y bins in
    if i = n && fcmp y bins.(n) = 0 then i - 1 else i in
  n, get_bin


let hist_nonuniform bins x =
  let n, get_bin = setup_nonuniform_binning bins in
  let c = Array.make n 0 in
  x |> Array.iter (fun y ->
      let i = get_bin y in
      (* drop out-of-bounds without exception.
       * compatible with -unsafe compiler option. *)
      if 0 <= i && i < n then c.(i) <- c.(i) + 1);
  bins, c


let hist_weighted_nonuniform bins w x =
  if Array.(length x <> length w) then
    failwith  "Data and weights must have the same length.";
  let n, get_bin = setup_nonuniform_binning bins in
  let c = Array.make n 0 in
  let wc = Array.make n 0. in
  x |> Array.iteri (fun j y ->
      let i = get_bin y in
      if 0 <= i && i < n then
        (c.(i) <- c.(i) + 1;
         wc.(i) <- wc.(i) +. w.(j)));
  (bins, c), Some wc


(* binning of sorted arrays by accumulating bin by bin *)

let make_uniform_bins_from_sorted n x =
  let bmin, bmax = minmax x in
  let db = (bmax -. bmin) /. float_of_int n in
  Array.init (n + 1) (fun i -> bmin +. float_of_int i *. db)


(* find start of upward iteration *)
let init_sorted bins x =
  (* Number of bins (not boundaries) *)
  let n = Array.length bins - 1 in
  if n < 1 then failwith "Need at least two bin boundaries!";
  let m = Array.length x in
  let bs = Owl_utils_array.bsearch ~cmp:fcmp in
  let i, j =
  if fcmp bins.(0) x.(0) < 1 then
    bs x.(0) bins, 0
  else
    0, 1 + bs bins.(0) x in
  assert (0 <= i && i <= n);
  assert (0 <= j && j < m);
  n, m, ref i, ref j


let hist_sorted bins x =
  let n, m, bin_i, x_j = init_sorted bins x in
  let c = Array.make n 0 in
  (* now iterate up the bins.
   * to the second-to-last bin since we look ahead by one. *)
  while !bin_i <= n - 1 do
    while !x_j < m && fcmp x.%(!x_j) bins.%(!bin_i + 1) < 0 do
      c.%(!bin_i) <- c.%(!bin_i) + 1;
      incr x_j
    done;
    incr bin_i
  done;
  (* last bin is right-inclusive... *)
  while !x_j < m && fcmp x.%(!x_j) bins.%(n) = 0 do
    c.%(n-1) <- c.%(n-1) + 1;
    incr x_j
  done;
  bins, c


let hist_weighted_sorted bins w x =
  if Array.(length x <> length w) then
    failwith  "Data and weights must have the same length.";
  let n, m, bin_i, x_j = init_sorted bins x in
  let c = Array.make n 0 in
  let wc = Array.make n 0. in
  while !bin_i <= n - 1 do
    while !x_j < m && fcmp x.%(!x_j) bins.%(!bin_i + 1) < 0 do
      c.%(!bin_i)  <- c.%(!bin_i) + 1;
      wc.%(!bin_i) <- wc.%(!bin_i) +. w.%(!x_j);
      incr x_j
    done;
    incr bin_i
  done;
  (* last bin is right-inclusive... *)
  while !x_j < m && fcmp x.%(!x_j) bins.%(n) = 0 do
    c.%(n-1)  <- c.%(n-1) + 1;
    wc.%(n-1) <- wc.%(n-1) +. w.%(!x_j);
    incr x_j
  done;
  (bins, c), Some wc


let hist_to_string { bins; counts; weighted_counts; normalised_counts; density } =
  let n_counts = Array.fold_left (+) 0 counts in
  let n = Array.length bins - 1 in
  let w = match weighted_counts with
    | None -> ""
    | Some wc ->
      let tot = Array.fold_left (+.) 0. wc in
      Printf.sprintf "; tot. weight: %g" tot in
  let norm = match normalised_counts with
    | None -> ""
    | Some _ -> "; normalised" in
  let pdf = match density with
    | None -> ""
    | Some _ -> "; density" in
  Printf.sprintf "[ N: %i; N_bins: %i%s%s%s ]"
  n_counts n w norm pdf


(* now the external api *)

let histogram
    (bins:[`N of int|`Bins of float array])
    ?weights x =
  let (bins, counts), weighted_counts = match bins, weights with
    | `N n, None      -> hist_uniform n x, None
    | `Bins b, None   -> hist_nonuniform b x, None
    | `N n, Some w    -> hist_weighted_uniform n x w
    | `Bins b, Some w -> hist_weighted_nonuniform b w x in
  {bins; counts; weighted_counts;
   normalised_counts=None; density=None}


let histogram_sorted
    (bins:[`N of int|`Bins of float array])
    ?weights x =
  let bins = match bins with
    | `N n    -> make_uniform_bins_from_sorted n x
    | `Bins b -> b in
  let (bins, counts), weighted_counts = match weights with
    | None   -> hist_sorted bins x, None
    | Some w -> hist_weighted_sorted bins w x in
  {bins; counts; weighted_counts;
   normalised_counts=None; density=None}


let normalise ({counts; weighted_counts; _} as h) =
  let nc = match weighted_counts with
    | None ->
        let total = Array.fold_left (+) 0 counts |> float_of_int in
        Array.map (fun c -> float_of_int c /. total) counts
    | Some wcounts ->
        let total = Array.fold_left (+.) 0. wcounts in
        Array.map (fun wc -> wc /. total) wcounts in
  {h with normalised_counts=Some nc}


let normalise_density ({bins; counts; weighted_counts; _} as h) =
  let ds = match weighted_counts with
    | None ->
        let total = Array.fold_left (+) 0 counts |> float_of_int in
        Array.mapi (fun i c ->
            float_of_int c /. (bins.(i+1) -. bins.(i)) /. total) counts
    | Some wcounts ->
        let total = Array.fold_left (+.) 0. wcounts in
        Array.mapi (fun i wc ->
            wc /. (bins.(i+1) -. bins.(i)) /. total) wcounts in
  {h with density=Some ds}


let pp_hist formatter hist =
  Format.open_box 0;
  Format.fprintf formatter "%s" (hist_to_string hist);
  Format.close_box ()



let quantile x =
  let y = sort ~inc:true x in
  let n = Array.length y in
  fun p ->
    if p < 0. || p > 1. then
      raise (Invalid_argument "Owl_base_stats.quantile: expected float between 0 and 1")
    else
      let index = p *. (float_of_int (n - 1)) in
      let lhs = int_of_float index in
      let delta = index -. (float_of_int lhs) in

      if n = 0 then 0.
      else (
        if lhs = n - 1 then y.(lhs)
        else (1. -. delta) *. y.(lhs) +. delta *. y.(lhs + 1)
      )


let percentile x p = quantile x (p /. 100.)


let median x = percentile x 50.


let first_quartile x = percentile x 25.


let third_quartile x = percentile x 75.


let interquartile x =
    third_quartile x -. first_quartile x


let tukey_fences ?(k=1.5) arr =
  let first_quartile = first_quartile arr in
  let third_quartile = third_quartile arr in
  let offset = k *. (third_quartile -. first_quartile) in
  first_quartile -. offset, third_quartile +. offset


let build_kernel = function
  | `Gaussian ->
    fun h p v ->
      let u = (v -. p) /. h in
      (1. /. (Owl_const.(sqrt2 *. sqrtpi))) *. exp (-. Owl_base_maths.sqr u /. 2.)

let build_points n_points h kernel vs =
  let (min, max) = minmax vs in
  let (a, b) = match kernel with
    | `Gaussian -> (min -. 3. *. h, max +. 3. *. h)
  in

  let points = Array.make n_points 0. in
  let step = (b -. a) /. float_of_int n_points in

  for i = 0 to n_points - 1 do
    Array.unsafe_set points i (a +. (float_of_int i) *. step)
  done;

  points


let gaussian_kde ?(bandwidth=`Scott) ?(n_points=512) vs =
  if Array.length vs < 2 then
    invalid_arg "estimate_pdf: sample should have multiple elements";

  let n = float_of_int (Array.length vs) in
  let s = min [|(std vs); (interquartile vs /. 0.34)|] in
  let h = match bandwidth with
    | `Silverman -> 0.90 *. s *. (n ** -0.2)
    | `Scott     -> 1.06 *. s *. (n ** -0.2)
  in

  let kernel = `Gaussian in
  let points = build_points n_points h kernel vs in
  let k      = build_kernel kernel in
  let f      = 1. /. (h *. n) in
  let pdf    = Array.make n_points 0. in

  for i = 0 to n_points - 1 do
    let p = Array.unsafe_get points i in
    Array.unsafe_set pdf i
      (f *. Array.fold_left (fun acc v -> acc +. k h p v) 0. vs)
  done;

  (points, pdf)



(* ends here *)
