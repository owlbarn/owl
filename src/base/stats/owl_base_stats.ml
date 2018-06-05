(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
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

let make_uniform_bins n bmin bmax =
  let db = (bmax -. bmin) /. float_of_int n in
  let bins = Array.init (n + 1) (fun i -> bmin +. float_of_int i *. db) in
  db, bins

let get_uniform_bin bmin bmax db n y =
  let i = int_of_float ((y -. bmin) /. db) in
  if i = n && y = bmax then n - 1 else i

(* fast direct binning for uniform bins *)
let hist_uniform n x =
  let bmin, bmax = minmax x in
  let db, bins = make_uniform_bins n bmin bmax in
  let get_i y = get_uniform_bin bmin bmax db n y in
  let c = Array.make n 0 in
  Array.iter (fun y ->
      let i = get_i y in
      c.(i) <- c.(i) + 1) x;
  bins, c

let hist_weighted_uniform n w x =
  let bmin, bmax = minmax x in
  let db, bins = make_uniform_bins n bmin bmax in
  let get_i y = get_uniform_bin bmin bmax db n y in
  let c = Array.make n 0 in
  let wc = Array.make n 0. in
  Array.iteri (fun j y ->
      let i = get_i y in
      c.(i) <- c.(i) + 1;
      wc.(i) <- wc.(i) +. w.(j)
    ) x;
  bins, c, wc

let get_nonuniform_bin n bins y =
  let i = Owl_utils_array.bsearch
      ~cmp:(compare :> float -> _ -> _)
      y bins in
  if i = n && y = bins.(n-1) then n - 1 else i

let hist_nonuniform bins x =
  let n = Array.length bins in
  let get_i y = get_nonuniform_bin n bins y in
  let c = Array.make (n-1) 0 in
    Array.iter (fun y ->
        let i = get_i y in
        try c.(i) <- c.(i) + 1
        (* drop out-of bounds data! *)
        with Invalid_argument _ -> ()) x;
    bins, c

let hist_weighted_nonuniform bins w x =
  let n = Array.length bins in
  let get_i y = get_nonuniform_bin n bins y in
  let c = Array.make (n-1) 0
  and wc = Array.make n 0. in
  Array.iteri (fun j y ->
      let i = get_i y in
      try c.(i) <- c.(i) + 1; wc.(i) <- wc.(i) +. w.(j)
      with Invalid_argument _ -> ()) x;
  bins, c, wc

let make_uniform_bins_from_sorted n x =
  let bmin, bmax = minmax x in
  let db = (bmax -. bmin) /. float_of_int n in
  Array.init (n + 1) (fun i -> bmin +. float_of_int i *. db)

(* utility. find start of upward iteration *)
let init_bin_i_x_j bins x =
  let cmp = (compare :> float -> _ -> _) in
  if cmp bins.(0) x.(0) < 1 then
    ref (Owl_utils_array.bsearch ~cmp x.(0) bins), ref 0
  else
    ref 0, ref (1 + Owl_utils_array.bsearch ~cmp bins.(0) x)

(* this assumes without check that x is sorted *)
let hist_sorted bins x =
  let cmp = (compare :> float -> _ -> _) in
  (* FIXME: since this is a performance tweak it would make sense to unsafe
   * get and set the counts. write tests and then do it!! *)
  (*let module Array = struct*)
    (*include Array*)
    (*let get = unsafe_get*)
    (*let set = unsafe_set end in*)
  let bin_n = Array.length bins in
  let x_n = Array.length x in
  let c = Array.make (bin_n-1) 0 in
  let bin_i, x_j = init_bin_i_x_j bins x in
  (* now iterate up the bins *)
  while !bin_i <= bin_n - 2 do
    while !x_j < x_n && cmp x.(!x_j) bins.(!bin_i + 1) < 0 do
      c.(!bin_i) <- c.(!bin_i) + 1;
      incr x_j
    done;
    incr bin_i;
  done;
  (* last bin is right-inclusive... *)
  while !x_j < x_n && cmp x.(!x_j) bins.(bin_n-1) = 0 do
      c.(bin_n-2) <- c.(bin_n-2) + 1; incr x_j done;
  bins, c

let hist_weighted_sorted bins wts x =
  let cmp = (compare :> float -> _ -> _) in
  let bin_n = Array.length bins in
  let x_n = Array.length x in
  let c = Array.make (bin_n-1) 0 in
  let wc = Array.make (bin_n-1) 0. in
  let bin_i, x_j = init_bin_i_x_j bins x in
  (* now iterate up the bins *)
  while !bin_i <= bin_n - 2 do
    while !x_j < x_n && cmp x.(!x_j) bins.(!bin_i + 1) < 0 do
      c.(!bin_i) <- c.(!bin_i) + 1;
      wc.(!bin_i) <- wc.(!bin_i) +. wts.(!x_j);
      incr x_j
    done;
    incr bin_i;
  done;
  (* last bin is right-inclusive... *)
  while !x_j < x_n && cmp x.(!x_j) bins.(bin_n-1) = 0 do
      c.(bin_n-2) <- c.(bin_n-2) + 1;
      wc.(bin_n-2) <- wc.(bin_n-2) +. wts.(!x_j);
      incr x_j done;
  bins, c, wc

(* now the external api *)

let histogram
    (bins:[`N of int|`Bins of float array]) x =
  let bins, counts = match bins with
    | `N n -> hist_uniform n x
    | `Bins b -> hist_nonuniform b x in
  {bins; counts;
   weighted_counts=None; normalised_counts=None; density=None}

let histogram_weighted
    (bins:[`N of int|`Bins of float array]) wts x =
  let bins, counts, wcounts = match bins with
    | `N n -> hist_weighted_uniform n wts x
    | `Bins b -> hist_weighted_nonuniform b wts x in
  {bins; counts; weighted_counts=Some wcounts;
   normalised_counts=None; density=None}

let histogram_sorted
    (bins:[`N of int|`Bins of float array]) x =
  let bins = match bins with
    | `N n -> make_uniform_bins_from_sorted n x
    | `Bins b -> b in
  let bins, counts = hist_sorted bins x in
  {bins; counts;
   weighted_counts=None; normalised_counts=None; density=None}

let histogram_sorted_weighted
    (bins:[`N of int|`Bins of float array]) wts x =
  let bins = match bins with
    | `N n -> make_uniform_bins_from_sorted n x
    | `Bins b -> b in
  let bins, counts, wcounts = hist_weighted_sorted bins wts x in
  {bins; counts; weighted_counts=Some wcounts;
   normalised_counts=None; density=None}

let normalise ({counts; weighted_counts} as h) =
  let normalised_counts = match weighted_counts with
    | None ->
      let total = Array.fold_left (+) 0 counts |> float_of_int in
      Some (Array.map (fun c -> float_of_int c /. total) counts)
    | Some wcounts ->
      let total = Array.fold_left (+.) 0. wcounts in
      Some (Array.map (fun wc -> wc /. total) wcounts) in
  {h with normalised_counts}

let normalise_density ({bins; counts; weighted_counts} as h) =
  let density = match weighted_counts with
    | None ->
      let total = Array.fold_left (+) 0 counts |> float_of_int in
      Some (Array.mapi (fun i c ->
          float_of_int c /. (bins.(i+1) -. bins.(i)) /. total) counts)
    | Some wcounts ->
      let total = Array.fold_left (+.) 0. wcounts in
      Some (Array.mapi (fun i wc ->
          wc /. (bins.(i+1) -. bins.(i)) /. total) wcounts) in
  {h with density}


(* ends here *)
