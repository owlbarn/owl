(** Unit test for Owl_stats module *)

module M = Owl_stats
module Maths = Owl_maths

(* define the test error *)
let eps = 1e-10
let sfmt = Printf.sprintf

(*a To test
 scale for lomax if we can figure it out
 logistic (fails ppf)

  3% (32 buckets) for distributions
 *)
(*a Types *)
(*t t_iter is an iterator that takes a function f and an initial accumulator value acc, and
    folds over a data set to produce (N, (f (f (f acc data[0]) data[1]) ... data[N]))
 *)
type ('a,'b) t_iter  = ('a -> int -> 'b -> 'a) -> 'a -> (int * 'a)


(*a Test modules *)
(*f trace - use with
    trace __POS__;
 *)
let trace pos =
    let (a,b,c,d) = pos in
    Printf.printf "trace:%s:%d:%d:%d\n%!" a b c d

(*m Cubic
  A cubic polynomial in x:(lx,rx)
  Map to a cubic in u:(0,1) by u=(x-lx)/(rx-lx)
    (or x = lx + (rx-lr)*u)
    du/dx = 1/(rx-lx)
    (or dx = (rx-lr)*du)

  Consider then a cubic in u, f, and f' = d/du f,
    and p(x)=f(u), p'(x) = dp/dx (x) = du/dx.d/du f(u) = f'(u) / (rx-lx)

  Hence: f (0) = f0  = p(lx) = p0
         f (1) = f1  = p(rx) = p1
         f'(0) = f'0 = (rx-lx).p'(lx) = (rx-lx) * p'0
         f'(1) = f'1 = (rx-lx).p'(rx) = (rx-lx) * p'1

  Given f(u) =  au^3 + bu^2 + cu +d
       f'(u) = 3au^2 + 2bu  + c
  f(0)  = d = f0
  f'(0) = c = f'0
  f'(1) = 3a + 2b + c
        = 3a + 2b + f'0  = f'1
  f(1)  = a + b + c + d
        = a + b + f'0 + f0 = f1

  Solving:
    d = f0
    c = f'0
    a = 2(f0-f1) + (f'0+f'1)
    b = 3(f1-f0) -2f'0 -f'1

  Then:
    p(x)  = f(u)          = f((x-lx)/(rx-lx))
    p'(x) = f'(u)/(rx-lx) = f'((x-lx)/(rx-lx)) / (rx-lx)
 *)
module Cubic =
struct
  (*t Structure *)
  type t = {
    lx : float;
    rx : float;
    dx : float;
    p0: float;
    p1: float;
    p'0: float;
    p'1: float;
    poly : float array;
    }

  (*f Get value of cubic at x *)
  let f t x =
    let u = (x -. t.lx) /. t.dx in
    let u2 = u *. u in
    let u3 = u2 *. u in
    ( (t.poly.(0) *. u3) +.
      (t.poly.(1) *. u2) +.
      (t.poly.(2) *. u) +.
      (t.poly.(3)) )

  (*f Get value of deriviative at x *)
  let df t x =
    let u = (x -. t.lx) /. t.dx in
    let u2 = u *. u in
    ( (t.poly.(0) *. u2 *. 3.) +.
      (t.poly.(1) *. u  *. 2.) +.
      (t.poly.(2)) ) /. t.dx

  (*f Find x for p where cubic(x)=p
    x0 = (rx+lx)/2
    x1 = x0 - (f(x0) - p) / f'(x0)
    n times over
     *)
  let find_x_of_value t p =
    let rec iter n x =
      if (n>0) then (
        let f' = df t x in
        let f' = max f' 0.01 in
        let dx = (((f t x) -. p) /. f') in
        let x' = x -. dx in
        iter (n-1) x'
      ) else (
        x
      )
    in
    iter 40 ((t.lx +. t.rx) /. 2.)

  (*f Fit a cubic to two coords and two gradients *)
  let fit lx rx p0 p'0 p1 p'1 =
    let dx = rx -. lx in
    let f0 = p0 in
    let f1 = p1 in
    let f'0 = dx *. p'0 in
    let f'1 = dx *. p'1 in
    let d = f0 in
    let c = f'0 in
    let a = (2.*.(f0-.f1)) +. (f'1 +. f'0) in
    let b = (3.*.(f1-.f0)) -. (f'1 +. (2.*.f'0)) in
    let t = {lx; rx; dx; p0; p1; p'0; p'1; poly=[|a;b;c;d;|]} in
    (* check to see the maths is correct:
    Printf.printf "lx %f, rx %f\n" lx rx;
    Printf.printf "f(lx) = %f/%f\n" (f t lx) p0;
    Printf.printf "f(rx) = %f/%f\n" (f t rx) p1;
    Printf.printf "f'(lx) = %f/%f\n" (df t lx) p'0;
    Printf.printf "f'(rx) = %f/%f\n" (df t rx) p'1;
     *)
    t

  (*f All done *)
end
type t_cubic = Cubic.t

(*m CdfTree
 *)
module CdfTree =
struct
type binary_node =
  | Leaf of int
  | Balance of (float * binary_node * binary_node)
    let rec create_node cdf_x_of_p logn p dp i di =
    if (logn<=0) then (
    Leaf (i/2)
    ) else (
      let ndp = dp /. 2. in
      let ndi = di / 2 in
      let node_l = create_node cdf_x_of_p (logn-1) (p-.ndp) ndp (i-ndi) ndi in
      let node_r = create_node cdf_x_of_p (logn-1) (p+.ndp) ndp (i+ndi) ndi in
      let x = (cdf_x_of_p p) in
      Balance (x, node_l, node_r)
    )
    let create cdf_x_of_p logn =
      create_node cdf_x_of_p logn 0.5 0.5 (1 lsl logn) (1 lsl logn)
    let rec display ?prefix:(prefix="") ?dirn:(dirn=0) t =
      match t with
      | Leaf n -> Printf.printf "%s+-- %n\n" prefix n
      | Balance (x,l,r) -> (
        let subprefix_0 = prefix ^ (if (dirn>0) then "|" else " ")  ^ "           " in
        let subprefix_1 = prefix ^ (if (dirn<0) then "|" else " ")  ^ "           " in
        display ~prefix:subprefix_0 ~dirn:(-1) l;
        Printf.printf "%s+ %8f -+\n" prefix x;
        display ~prefix:subprefix_1 ~dirn:(1) r;
      )

    let cdf_x_of_p ?min_x:(min_x=(-1.E4)) ?max_x:(max_x=(1.E4)) cdf p =
      let rec find_x_of_p lx rx =
        let dx = (rx -. lx) in
        let mx = (lx +. rx)/. 2. in
        let mp = cdf mx in
        if (dx < 1E-8) then (
          mx
        ) else if (mp>p) then (
          find_x_of_p lx mx
        ) else (
          find_x_of_p mx rx
        ) in
      find_x_of_p min_x max_x

    let rec value t x =
      match t with
      | Leaf n -> n
      | Balance (nx,nl,nr) ->
        if (x<nx) then (value nl x) else (value nr x)

    let create_from_rv rv logn =
      create (cdf_x_of_p rv) logn
end

let _ =
    let tree = CdfTree.create_from_rv (M.gaussian_cdf ~mu:0. ~sigma:1.) 5 in
    CdfTree.display tree;
    List.iter (fun x -> Printf.printf "bucket of %f: %d\n" x (CdfTree.value tree x)) [-1.;-0.5;0.;0.5;1.;]

(*m Distribution - for continuous distributions

  Model a CDF/PDF as a set of N cubics of 'x', with one cubic
    for P(X<x)=1/n, another for P(X<x)=2/n, and so on

  Each cubic represents cdf(x), so the CDF of a distribution can be
    compared with one from the stats module

  For the normal distribution, 10 cubics has a negligible error for the body (p=0.1 to 0.9) in the CDF, and an error of less than 5E-4 in the PDF.

  For the normal distribution, 32 cubics has a negligible error for (p=0.03 to 0.97) in the CDF, and an error of less than 5E-7 in the PDF. For the tails, the CDF error is <5E-3 and the PDF error is up to 0.02

  'Correct' distribution parameters can be generated (e.g. in Scipy) - and checked elsewhere, and then these distributions can be used to validate the CDFs in Owl.

  The Distribution can also then be mapped from an 'x' value to the CDF of x, for example to bucket up values from a continous random variable, where buckets can then be selected to determine patterns for checking for independence

*)
module Distribution =
struct

  (*t Structure *)
  type t = {
      name : string;
      num_buckets : int;
      cdf_x_array : float array; (* i -> x: cdf(x) = i/num_buckets *)
      pdf_x_array : float array; (* i -> pdf(x : cdf(x)=i/num_buckets ) *)
      cubics    : t_cubic array;
      dut_cdf   : float -> float;
      dut_pdf   : float -> float;
    }

  (*f create *)
  let create name dut_cdf dut_pdf cdf_x_array pdf_x_array =
    let num_buckets = (Array.length cdf_x_array) - 1 in
    let num_buckets_f = float num_buckets in
    let cubics =
      let rec add_cubic acc i = (* build acc up in forward order *)
        if (i>=0) then (
          let lx  = cdf_x_array.(i) in
          let rx  = cdf_x_array.(i+1) in
          let p0  = (float i) /. num_buckets_f in
          let p1  = (float (i+1)) /. num_buckets_f in
          let p'0 = pdf_x_array.(i) in
          let p'1 = pdf_x_array.(i+1) in
          let c = Cubic.fit lx rx p0 p'0 p1 p'1 in
          add_cubic (c :: acc) (i-1)
        ) else (
          acc
        )
      in
      Array.of_list (add_cubic [] (num_buckets-1))
    in
    { name; num_buckets; dut_cdf; dut_pdf; pdf_x_array; cdf_x_array; cubics;}

  (*f value *)
  let value t i = t.cdf_x_array.(i)

  (*f bucket_of_p - find which bucket p is in *)
  let bucket_of_p t p =
    let i = int_of_float (p*.(float t.num_buckets)) in
    (min (t.num_buckets-1) (max i 0))

  (*f interp_x_of_p - find x given P(X<x) *)
  let interp_x_of_p t p =
    let i = bucket_of_p t p in
    Cubic.find_x_of_value t.cubics.(i) p

  (*f search_for_x - find which bucket x is in *)
  let search_for_x t x =
    let rec find_x li ri =
      if (ri<=li+1) then
        (li,ri)
      else (
        let mi = (ri+li)/2 in
        let mx = t.cdf_x_array.(mi) in
        if (x<mx) then (find_x li mi) else (find_x mi ri)
      )
    in
    let (li,ri) =
      if (x<=t.cdf_x_array.(0)) then (0,1)
      else if (x>=t.cdf_x_array.(t.num_buckets)) then (t.num_buckets-1,t.num_buckets)
      else (find_x 0 t.num_buckets)
    in
    (li,ri,t.num_buckets)

  (*f dut_cdf *)
  let dut_cdf t = t.dut_cdf

  (*f dut_pdf *)
  let dut_pdf t = t.dut_pdf

  (*f interp_cdf *)
  let interp_cdf t x =
    let (li, ri, ni) = search_for_x t x in
    Cubic.f t.cubics.(li) x

  (*f interp_pdf *)
  let interp_pdf t x =
    let (li, ri, ni) = search_for_x t x in
    Cubic.df t.cubics.(li) x

  (*f plot_comparison - plot comparison of CDF/PDF distributions
   * disable this to avoid dependency on plplot, this simplies many things
   * including building docker images.

  let plot_comparison t dut_cdf dut_pdf filename  =
    let lx = t.cdf_x_array.(1) in
    let rx = t.cdf_x_array.(t.num_buckets-1) in
    Owl.Plot.(
      let h = create ~m:2 ~n:2 "fred" in
      subplot h 0 0;
      set_xlabel h "x";
      set_ylabel h "dut p";
      set_yrange h 0. 1.;
      plot_fun ~h:h dut_cdf lx rx;
      subplot h 0 1;
      set_xlabel h "x";
      set_ylabel h "interp p";
      set_yrange h 0. 1.;
      plot_fun ~h:h (interp_cdf t) lx rx;
      subplot h 1 0;
      set_xlabel h "x";
      set_ylabel h "cdf diff";
      plot_fun ~h:h (fun x -> (dut_cdf x) -. (interp_cdf t x)) lx rx;
      subplot h 1 1;
      set_xlabel h "x";
      set_ylabel h "pdf diffx";
      plot_fun ~h:h (fun x -> (dut_pdf x) -. (interp_pdf t x)) lx rx;
      set_output h filename ;
      output h
    )
  *)

  (*f All done *)
end

(*m RandomTest *)
module RandomTest = struct
  (*t Structure *)
  type test_hypothesis = {
      test_name : string;
      score_name: string;
      hypothesis : M.hypothesis
    }

  (*t make_hypothesis *)
  let make_hypothesis reject p_value score : M.hypothesis =
    {reject; p_value; score }

  (*t make_test_hypothesis *)
  let make_test_hypothesis test_name score_name hypothesis =
    { test_name; score_name; hypothesis; }

  (*t is_fail *)
  let is_fail t = t.hypothesis.reject

  (*t assert_hypothesis *)
  let assert_hypothesis ?should_reject:(should_reject=false) rv_name test_hypothesis =
    let hypothesis = test_hypothesis.hypothesis in
    let name       = test_hypothesis.test_name in
    let data_name  = test_hypothesis.score_name in
    Printf.printf "********************************************************************************\n";
    Printf.printf "%s %s test\n" rv_name name;
    Printf.printf "%s = %f \n" data_name hypothesis.score;
    Printf.printf "p_value = %f \n" hypothesis.p_value;
    Alcotest.(check bool) (sfmt "Statistical test '%s' for random variable '%s'" name rv_name ) should_reject hypothesis.reject;
    ()

  (*t iterate *)
  let iterate (sampler: int -> int -> (int *(int -> 'b))) (start:int) (length:int) (f:'c -> int -> 'b -> 'c) (acc:'c) : (int * 'c) =
    let (actual_length, sampler_next) = sampler start length in
    let rec x acc i n =
      if (n<=0) then acc else (
        let new_acc = f acc i (sampler_next i) in
        x new_acc (i+1) (n-1)
      )
    in
    (length, x acc 0 actual_length)

  (*t match_distribution *)
  let match_distribution ?significance:(significance=0.01) (dist:Distribution.t) =
    let diff i =
      let x = (float i) /. 32. in
      (Distribution.interp_cdf dist x) -. (Distribution.dut_cdf dist x)
    in
    let diff2 i = (diff i) ** 2. in
    let rec sum_diff2 acc i =
      if (i>=0) then (sum_diff2 (acc +. (diff2 i)) (i-1)) else acc
    in
    let p = (sum_diff2 0. 32) /. 32. in (* NOT a probability, but a closeness... *)
    let hypothesis = make_hypothesis (p < significance) p p in
    hypothesis

  (*t do_fft *)
  module C = Owl.Dense.Matrix.C
  let do_fft ?significance:(significance=0.01) ?n:(n=1024) f iter =
    let x = C.zeros 1 n in
    let blah acc i b =
      if (i<n) then (C.set x 0 i {Complex.re=(f b); im=0.}); (* -1 or +1 *)
      acc
    in
    let (_,_) = iter blah 0 in
    C.print ~max_col:64 x;
    (*
     *)
    let f = Owl.Fft.S.fft x in
    C.print ~max_col:64 f;
    (*
     *)
    let p = 0.95 in
    let q = (1. -. p) in

    let t2 = (float n) *. (-. (log q)) in
    Printf.printf "t2 %f \n" t2;
    let rec count_above_threshold i acc =
      if (i<0) then acc else (
        let c = C.get f 0 i in
        let new_acc =
          if (Complex.norm2 c) < t2 then (acc+1) else acc
        in
        count_above_threshold (i-1) new_acc
      )
    in
    let n_over = count_above_threshold (n/2-1) 0 in
    let x = (float n_over) -. ((float (n/2)) *. p) in
    let x = x /. ( sqrt ( (float (2*n)) *. p *. q ) ) in
    let x = abs_float x in
    let p = Maths.erfc x in (* probability of seeing x given the distribution actually is mean 0, sd=1/sqrt(2) *)
    let hypothesis = make_hypothesis (p < significance) p ((float n_over) /. (float (n/2))) in
    hypothesis

  (*t All done *)
end

(*m BinaryTest *)
module BinaryTest = struct
  include RandomTest
  (*f frequency test

     Yi = {-1 with prob q=(1-p), 1 with prob p}
     Mean(Yi)     = 1*p -1*(1-p) = 2p-1 = p-q  (= 0 if p is 0.5)
     Variance(Yi) = (-1-(2p-1))^2 * (1-p) + (1-(2p-1))^2 * p)
                  = (4p^2.(1-p) + 4(1-p)^2*p)
                  = 4*p*(1-p)*(p + 1-p)
                  = 4*p*(1-p)
                  = 4pq  (= 1 if p is 0.5)

     For Y = N occurences of Yi:
     Mean(Y) = N*(p-q) (= 0 if p=0.5)
     Variance(Y) = N*4pq = 4Npq (= N if p=0.5)

     Consider Y' = (Y-(N(p-q)) / sqrt(8Npq) (= Y/sqrt(2N) if p=0.5)
     Mean(Y') = 0, Variance(Y') = 1/2

     If Y' is normally distributed then the probability of observing a value outside of [-|s|;|s|] for Y' is erfc(|s|)

    *)
  let frequency ?significance:(significance=0.01) ?p:(p=0.5) iter =
    let q = 1. -. p in
    let inc_if_true_else_dec acc _ b =
      if b then (acc+1) else (acc-1)
    in
    let (n,sum) = iter inc_if_true_else_dec 0 in              (* if p=0.5  then sum should have mean 0, sd=sqrt(n) *)
    let x = (float sum) -. ((2. *. p -. 1.) *. (float n)) in  (* x always should have mean 0, sd=sqrt(n*4pq) *)
    let x = x /. (sqrt (8. *. p *. q *. (float n))) in        (* x always should have mean 0, sd=1/sqrt(2) *)
    let x = abs_float x in
    let p = Maths.erfc x in (* probability of seeing x given the distribution actually is mean 0, sd=1/sqrt(2) *)
    let hypothesis = make_hypothesis (p < significance) p x in
    make_test_hypothesis (sfmt "Frequency with %d samples" n) "Partial sum" hypothesis

  (*f block_frequency test
    Consider a stream of N * M bools, which may be represented as 0 or 1s, with prob(true/1) = p

    Consider the number of occurrence of trues/1's, particularly, within each run of M bools/bits.

    We can calculate Chi^2 = M*Sum( (Obs(1s)/M-p)^2/p ), summing over the N blocks.
    The inside of this is ((sum1s/M-0.5)^2)/0.5) = (sum1s/M-0.5)^2 = 2*chi2_obs (in the code)

    Assume that the probability of a 1 is 0.5, under the null hypothesis that 0s and 1s are equally likely.

    The probability of an observed value x2 for Chi^2 can be found from the Chi^2 distribution for N degrees of freedom.
    *)
  let block_frequency ?significance:(significance=0.01) ?p:(p=0.5) m iter =
    let number_ones_in_block (i_of_m,acc,chi2,n) _ b =
      let v = if b then 1 else 0 in
      if (i_of_m+1)==m then
        let chi2_obs = ((float (acc+v))/.(float m) -. p)**2. in
        (0,0,chi2_obs +. chi2,n+1)
      else
        (i_of_m+1,acc+v,chi2,n)
    in
    let (_,(_,_,chi2,n)) = iter number_ones_in_block (0,0,0.,0) in
    let chi2 = chi2 *. (float m) /. p in
    let p = 1. -. (M.chi2_cdf chi2 (float n)) in
    let hypothesis = make_hypothesis (p < significance) p chi2 in
    make_test_hypothesis (sfmt "Block frequency of %d run lengths of size %d" n m) "Chi^2" hypothesis

  (*f occurrence_of_patterns
    Consider every pattern of M bools/bits, given P(true/1)=p and P(false/0)=1-p=q

    A particular pattern, for example TFFFTFT has probability p*q*q*q*p*q*p = p^3*q^4

    Given N bools/bits, we would expect to see to see (N-m+1)*p^3*q^4 occurrences

    So count the occurrences of every one of the 2^M patterns in N bits

    Now a Chi2 test can be performed with 2^M-1 degrees of freedom

    Chi^2 = Sum( (Obs(patm) - Em)^2 / Em ) where Em = (N-m+1)*p^Npmt*q^(M-Npmt),
    where Npmt is the number of true/1 bits in pattern m
   *)
  let occurrence_of_patterns ?significance:(significance=0.01) m iter =
    let num_pats = (1 lsl m) in
    let mask = num_pats - 1 in
    let obs_counts = Array.make num_pats 0 in
    let rec count_ones_in_n acc i v =
      if (i==0) then
        acc
      else
        (count_ones_in_n (acc+(v land 1)) (i-1) (v lsr 1))
    in
    let count_observations (sum_z,sum_o,m_seen,pat) _ b =
      let v = if b then 1 else 0 in
      let new_pat = ((pat lsl 1) land mask) + v in
      if m_seen==m then (
        obs_counts.(new_pat) <- obs_counts.(new_pat) + 1;
        (sum_z+1-v,sum_o+v,m_seen,new_pat)
      ) else (
        (sum_z+1-v,sum_o+v,m_seen+1,new_pat)
      )
    in
    let (n,(sum_z,sum_o,_,_)) = iter count_observations (0,0,0,0) in
    let prob_z = (float sum_z) /. (float (n-m+1)) in
    let prob_o = (float sum_o) /. (float (n-m+1)) in
    let set_exp_counts i =
      let num_o = count_ones_in_n 0 m i in
      let num_z = m - num_o in
      ( (prob_o ** (float num_o)) *.
          (prob_z ** (float num_z)) ) *. (float (n-m+1))
    in
    let exp_counts = Array.init num_pats set_exp_counts in
    (*
       Printf.printf "%f %f %f\n" (prob_z ** (float m)) (prob_o ** (float m)) (5.0/.(float (n-m+1)));
       Array.iteri (fun i v -> Printf.printf "Expecting %d:%f\n" i v) exp_counts;
       Array.iteri (fun i v -> Printf.printf "Occurrences %d:%d\n" i v) obs_counts;
     *)
    let rec sum_chi2 acc i =
      if i==num_pats then acc else (
        let obs_m = (float obs_counts.(i)) in
        let exp_m = exp_counts.(i) in
        sum_chi2 (acc +. (((obs_m -. exp_m) ** 2.) /. exp_m)) (i+1)
      )
    in
    let chi2 = sum_chi2 0. 0 in
    let p = 1. -. (M.chi2_cdf chi2 (float (num_pats-1))) in
    let hypothesis = make_hypothesis (p < significance) p chi2 in
    make_test_hypothesis (sfmt "Occurrences of %d-bit patterns in run length of size %d" m n) "Chi^2" hypothesis

  (*f occurrences_of_patterns
    The issue with the occurrence_of_patterns test is that it is a 99%
    passing test, for good, independent RVs.

    Which means that a good RV will fail 1% of the tests, and if we
    run 10 RVs with 20 tests, we will fail on average 2 RVs...

    Furthermore, one should probably run the test numerous times on a
    single bitstream.

    So, this test runs occurrence_of_patterns a number of times and
    uses a chi2 test to determine if the number of failures is outside
    the significance level

   *)
  let occurrences_of_patterns ?significance:(significance=0.01) n m iter =
    let rec accum_n acc f n = if (n<=0) then acc else (accum_n (f acc) f (n-1)) in
    let accum acc = (occurrence_of_patterns ~significance:0.01 m iter) :: acc in
    let run_results = accum_n [] accum n in
    let num_passing = List.fold_left (fun a i -> if (is_fail i) then a else (a +. 1.)) 0. run_results in
    let chi2 = (num_passing -. 0.99 *. (float n))**2. /. (0.99 *. (float n)) in
    let p = 1. -. (M.chi2_cdf chi2 1.) in
    let hypothesis = make_hypothesis (p < significance) p num_passing in
    make_test_hypothesis (sfmt "%d iterations of '%s'" n ((List.hd run_results).test_name)) "Num passing" hypothesis

  (*f fft *)
  let fft ?significance:(significance=0.01) ~n iter =
    let hypothesis = do_fft ~significance:significance ~n:n (fun b -> if b then 1. else (-1.)) iter in
    make_test_hypothesis (sfmt "FFT of size %d" n) "#peaks above 95% power" hypothesis

  (*f All done *)
end

(*a CDF approximations as piece-wise cubic - checks we are okay to bucket away, really *)
(*v distributions
 *)
open Unit_stats_rvs_distributions
let cdf_approximations = Unit_stats_rvs_distributions.cdf_approximations

(*f test_rough_cdf - test that a stats CDF/PDF matches that from scipy given in cdf_approximations
 *)

let test_rough_cdf pydist =
  let (name, imprecision, dut_cdf, dut_pdf, dut_logcdf, dut_logpdf, dut_opt_ppf, dut_sf, dut_logsf, dut_opt_isf, cdf_x_array, pdf_x_array) = pydist in
  let dist = Distribution.create name dut_cdf dut_pdf cdf_x_array pdf_x_array in
  let sum_diff_cdf_2 = ref 0. in
  let sum_diff_pdf_2 = ref 0. in
  let max_diff_cdf_2 = ref 0. in
  let max_diff_pdf_2 = ref 0. in
  let sum_err_log_cdf_2 = ref 0. in
  let sum_err_log_pdf_2 = ref 0. in
  let sum_err_ppf_2     = ref 0. in
  let sum_err_isf_2     = ref 0. in
  let sum_err_sf_2      = ref 0. in
  let sum_err_log_sf_2  = ref 0. in
  let n = 1000 in
  let total = (float (n) *. 0.96) in
  for i=(n*2/100) to (n*98/100) do (* ignore the 2% tails *)
    let p = ((float i)/.(float n))in
    let x     = Distribution.interp_x_of_p dist p in
    let cdf_x = Distribution.interp_cdf dist x in
    let pdf_x = Distribution.interp_pdf dist x in
    let dut_cdf_x = Distribution.dut_cdf dist x in
    let dut_pdf_x = Distribution.dut_pdf dist x in
    let diff_cdf_2 = (cdf_x -. dut_cdf_x) ** 2. in
    let diff_pdf_2 = (pdf_x /. dut_pdf_x -. 1.) ** 2. in
    let err_log_cdf_2 = ((log dut_cdf_x) -. (dut_logcdf x)) ** 2. in
    let err_log_pdf_2 = ((log dut_pdf_x) -. (dut_logpdf x)) ** 2. in
    let option_get o =
      match o with
      | Some x -> x
      | None   -> raise Owl_exception.TEST_FAIL
    in
    let dut_cdf_ppf_p, dut_ppf_p, dut_isf_o_m_p =
      match dut_opt_ppf with
      | None -> (p,0.,0.)
      | Some dut_ppf -> (
          let dut_isf = option_get dut_opt_isf in
          (dut_cdf (dut_ppf p)), (dut_ppf p), (dut_isf (1.-.p))
        )
    in
    let (err_ppf_2, err_isf_2) =
              (dut_cdf_ppf_p -. p) ** 2.,
              (dut_ppf_p     -. dut_isf_o_m_p) ** 2.
    in
    let err_sf_2      = ((dut_cdf x) +. (dut_sf x) -. 1.) ** 2. in
    let err_log_sf_2  = ((dut_logsf x) -. (log (dut_sf x))) ** 2. in
    (*
    Printf.printf "%d: p %f : x %f : ppf(p) %f : cdf(ppf(p)) %f : isf(1-p) %f : err^2 ppf %g isf %g\n" i p x (dut_ppf_p) (dut_cdf_ppf_p) dut_isf_o_m_p err_ppf_2 err_isf_2;
    Printf.printf "%d: p %f : x %f : cdf %f : sf %f : err^2 %g, %g\n" i p x (dut_cdf x) (dut_sf x) err_sf_2 err_log_sf_2;
    Printf.printf "%d: p %f : x %f : cdf %f/%f : pdf %f/%f\n" i p x cdf_x dut_cdf_x pdf_x dut_pdf_x;
    *)
    if (!max_diff_cdf_2<diff_cdf_2) then (max_diff_cdf_2 := diff_cdf_2);
    if (!max_diff_pdf_2<diff_pdf_2) then (max_diff_pdf_2 := diff_pdf_2);
    sum_diff_cdf_2 := !sum_diff_cdf_2 +. diff_cdf_2;
    sum_diff_pdf_2 := !sum_diff_pdf_2 +. diff_pdf_2;
    sum_err_log_cdf_2 := !sum_err_log_cdf_2 +. err_log_cdf_2;
    sum_err_log_pdf_2 := !sum_err_log_pdf_2 +. err_log_pdf_2;
    sum_err_ppf_2     := !sum_err_ppf_2     +. err_ppf_2;
    sum_err_isf_2     := !sum_err_isf_2     +. err_isf_2;
    sum_err_sf_2      := !sum_err_sf_2      +. err_sf_2;
    sum_err_log_sf_2  := !sum_err_log_sf_2  +. err_log_sf_2;
  done;
  let avg_diff_cdf_2 = !sum_diff_cdf_2 /. total in
  let avg_diff_pdf_2 = !sum_diff_pdf_2 /. total in
  let avg_err_log_cdf_2 = !sum_err_log_cdf_2 /. total in
  let avg_err_log_pdf_2 = !sum_err_log_pdf_2 /. total in
  let avg_err_ppf_2     = !sum_err_ppf_2 /. total in
  let avg_err_isf_2     = !sum_err_isf_2 /. total in
  let avg_err_sf_2      = !sum_err_sf_2 /. total in
  let avg_err_log_sf_2  = !sum_err_log_sf_2 /. total in
  Printf.printf "%s: Avg sq diff in cdf %g pdf %g max cdf %g pdf %g\n" name avg_diff_cdf_2 avg_diff_pdf_2 !max_diff_cdf_2 !max_diff_pdf_2;
  Printf.printf "         Avg err logcdf %g logpdf %g ppf %g isf %g\n" avg_err_log_cdf_2 avg_err_log_pdf_2 avg_err_ppf_2 avg_err_isf_2;
  Printf.printf "         Avg err sf %g logsf %g\n" avg_err_sf_2 avg_err_log_sf_2;
  (*Distribution.plot_comparison dist dut_cdf dut_pdf (sfmt "plot_diffs_%s.png" name);*)
  Alcotest.(check bool) (sfmt "Avg sq diff in '%s' cdf<1E-8" name) true (avg_diff_cdf_2<1E-8*.imprecision);
  Alcotest.(check bool) (sfmt "Max sq diff in '%s' cdf<1E-5"  name) true (!max_diff_cdf_2<1E-5*.imprecision);
  Alcotest.(check bool) (sfmt "Avg sq diff in '%s' pdf<1E-3" name)  true (avg_diff_pdf_2<1E-3*.imprecision);
  Alcotest.(check bool) (sfmt "Max sq diff in '%s' pdf<1E-1"  name) true (!max_diff_pdf_2<1E-1*.imprecision);
  Alcotest.(check bool) (sfmt "Avg logcdf error in '%s' <1E-28"  name) true (avg_err_log_cdf_2<1E-28);
  Alcotest.(check bool) (sfmt "Avg logpdf error in '%s' <1E-28"  name) true (avg_err_log_pdf_2<1E-28);
  Alcotest.(check bool) (sfmt "Avg ppf error in '%s' <1E-28"  name)    true (avg_err_ppf_2<1E-28);
  Alcotest.(check bool) (sfmt "Avg isf error in '%s' <1E-28"  name)    true (avg_err_isf_2<1E-28);
  Alcotest.(check bool) (sfmt "Avg sf error in '%s' <1E-28"  name)    true (avg_err_sf_2<1E-28);
  Alcotest.(check bool) (sfmt "Avg log sf error in '%s' <1E-28"  name)    true (avg_err_log_sf_2<1E-28);
  ()

(*f test_rough_cdf_matches - test all the CDFs match, so we have confidence using the RV cdf functions in bucket tests
 *)
let test_rough_cdf_matches _ =
  List.iter test_rough_cdf cdf_approximations;
  ()

(*a Initialization *)
let _ =
  Owl_common.PRNG.init ();
  Owl_common.PRNG.sfmt_seed 1

(*a Tests *)

(*f test descriptors *)
let one_third = 1. /. 3.
type t_bin_iter = IOfBool of  ((int,bool) t_iter -> RandomTest.test_hypothesis)
                | IIIIOfBool of ((int * int * int * int, bool) t_iter -> RandomTest.test_hypothesis)
                | IIFIOfBool of ((int * int * float * int, bool) t_iter -> RandomTest.test_hypothesis)

let bin_frequency             = IOfBool    (BinaryTest.frequency)           (* Distribution of (# of 1s in runs of length 7) is uniform *)
let bin_frequency_1_of_3      = IOfBool    (BinaryTest.frequency ~p:one_third)           (* Distribution of (# of 1s in runs of length 7) is uniform *)

let bin_block_frequency_7     = IIFIOfBool (BinaryTest.block_frequency 7)     (* Distribution of (# of 1s in runs of length 7) is uniform *)
let bin_block_frequency_70    = IIFIOfBool (BinaryTest.block_frequency 70)    (* Distribution of (# of 1s in runs of length 70) is uniform *)
let bin_block_frequency_700   = IIFIOfBool (BinaryTest.block_frequency 700)   (* Distribution of (# of 1s in runs of length 700) is uniform *)
let bin_block_frequency_1_of_3_7   = IIFIOfBool (BinaryTest.block_frequency ~p:one_third 7)     (* Distribution of (# of 1s in runs of length 7) is uniform *)
let bin_block_frequency_1_of_3_70  = IIFIOfBool (BinaryTest.block_frequency ~p:one_third 70)    (* Distribution of (# of 1s in runs of length 70) is uniform *)
let bin_block_frequency_1_of_3_700 = IIFIOfBool (BinaryTest.block_frequency ~p:one_third 700)   (* Distribution of (# of 1s in runs of length 700) is uniform *)

let bin_patterns_2 = IIIIOfBool (BinaryTest.occurrences_of_patterns 8 2) (* Distribution of overlapping 2-bit patterns is uniform *)
let bin_patterns_3 = IIIIOfBool (BinaryTest.occurrences_of_patterns 8 3) (* Distribution of overlapping 3-bit patterns is uniform *)
let bin_patterns_4 = IIIIOfBool (BinaryTest.occurrences_of_patterns 8 4) (* Distribution of overlapping 4-bit patterns is uniform *)
let bin_patterns_5 = IIIIOfBool (BinaryTest.occurrences_of_patterns 8 5) (* Distribution of overlapping 5-bit patterns is uniform *)
let bin_patterns_6 = IIIIOfBool (BinaryTest.occurrences_of_patterns 8 6) (* Distribution of overlapping 6-bit patterns is uniform *)
let bin_patterns_7 = IIIIOfBool (BinaryTest.occurrences_of_patterns 8 7) (* Distribution of overlapping 7-bit patterns is uniform *)
let bin_patterns_8 = IIIIOfBool (BinaryTest.occurrences_of_patterns 8 8) (* Distribution of overlapping 8-bit patterns is uniform *)
let bin_patterns_9 = IIIIOfBool (BinaryTest.occurrences_of_patterns 8 9) (* Distribution of overlapping 9-bit patterns is uniform *)
let bin_patterns_10 = IIIIOfBool (BinaryTest.occurrences_of_patterns 8 10) (* Distribution of overlapping 10-bit patterns is uniform *)

let bin_fft_64   = IOfBool (BinaryTest.fft ~n:64)
let bin_fft_1024 = IOfBool (BinaryTest.fft ~n:1024)

(*f run_random_tests *)
let run_random_tests test_name pretest sampler tests =
  let run_test (test, should_reject, start, length) =
    pretest ();
    let test_result =
      match test with
      | IOfBool t ->
         t (RandomTest.iterate sampler start length) (* Note type of iterator depends on type of t*)
      | IIFIOfBool t ->
         t (RandomTest.iterate sampler start length) (* Note type of iterator depends on type of t*)
      | IIIIOfBool t ->
         t (RandomTest.iterate sampler start length) (* Note type of iterator depends on type of t*)
    in
    RandomTest.assert_hypothesis test_name ~should_reject:should_reject test_result
  in
  List.iter run_test tests;
  ()

(*f tests to run if p=1/2 *)
let tests_for_p_0_5 = [ bin_frequency           ,  false, 0, 2000;
                        bin_frequency           ,  false, 0, 10000;
                        bin_frequency_1_of_3    ,  true, 0, 1000;
                        bin_frequency_1_of_3    ,  true, 0, 10000;
                        bin_block_frequency_7   ,  false, 0, 100;
                        bin_block_frequency_7   ,  false, 0, 1000;
                        bin_block_frequency_70  ,  false, 0, 1000;
                        bin_block_frequency_70  ,  false, 0, 10000;
                        bin_block_frequency_700 ,  false, 0, 10000;
                        bin_block_frequency_700 ,  false, 0, 100000;
                        bin_block_frequency_1_of_3_70  ,  true, 0, 1000;
                        bin_block_frequency_1_of_3_70  ,  true, 0, 10000;
                        bin_block_frequency_1_of_3_700 ,  true, 0, 10000;
                        bin_block_frequency_1_of_3_700 ,  true, 0, 100000;
                        bin_patterns_2          ,  false, 0, 1000;
                        bin_patterns_3          ,  false, 0, 1000;
                        bin_patterns_4          ,  false, 0, 1000;
                        bin_patterns_5          ,  false, 0, 1000;
                        bin_patterns_6          ,  false, 0, 1000;
                        bin_patterns_7          ,  false, 0, 1000;
                        bin_patterns_7          ,  false, 0, 10000;
                        bin_patterns_8          ,  false, 0, 10000;
                        bin_patterns_9          ,  false, 0, 10000;
                        bin_patterns_10         ,  false, 0, 10000;
                        bin_fft_64            ,  false, 0, 1024;
                        bin_fft_1024          ,  false, 0, 1024;
                      ]

(*f tests to run if p=1/3 *)
let tests_for_p_0_3 = [ bin_frequency           ,  true, 0, 1000;
                        bin_frequency           ,  true, 0, 10000;
                        bin_frequency_1_of_3    ,  false, 0, 100;
                        bin_frequency_1_of_3    ,  false, 0, 1000;
                        bin_frequency_1_of_3    ,  false, 0, 10000;
                        bin_block_frequency_7   ,  false, 0, 100;  (* one might expect this one to reject, but 0.33~0.5 for length 7 *)
                        bin_block_frequency_7   ,  false, 0, 1000; (* one might expect this one to reject, but 0.33~0.5 for length 7 *)
                        bin_block_frequency_70  ,  true, 0, 1000;
                        bin_block_frequency_70  ,  true, 0, 10000;
                        bin_block_frequency_700 ,  true, 0, 10000;
                        bin_block_frequency_700 ,  true, 0, 100000;
                        bin_block_frequency_1_of_3_7   ,  false, 0, 100;
                        bin_block_frequency_1_of_3_7   ,  false, 0, 1000;
                        bin_block_frequency_1_of_3_70  ,  false, 0, 1000;
                        bin_block_frequency_1_of_3_70  ,  false, 0, 10000;
                        bin_block_frequency_1_of_3_700 ,  false, 0, 10000;
                        bin_block_frequency_1_of_3_700 ,  false, 0, 100000;
                        bin_patterns_2          ,  false, 0, 1000;
                        bin_patterns_3          ,  false, 0, 1000;
                        bin_patterns_4          ,  false, 0, 1000;
                        bin_patterns_5          ,  false, 0, 1000;
                        bin_patterns_6          ,  false, 0, 1000;
                        bin_patterns_7          ,  false, 0, 1000;
                        bin_patterns_7          ,  false, 0, 10000;
                        bin_patterns_8          ,  false, 0, 10000;
                        bin_patterns_9          ,  false, 0, 10000;
                        bin_patterns_10         ,  false, 0, 10000;
                        bin_fft_64            ,  false, 0, 1024;
                        bin_fft_1024          ,  false, 0, 1024;
                      ]

(*f test_true_is_not_random - Test that a constant 'true' is not random

  This tests the frequency and binning tests reject the null hypothesis that an 'always true' distribution is independent with probability 0.5

  Note that the patterns tests cannot be run as they expect the frequency test to pass first

 *)
let test_true_is_not_random _ =
  Owl_common.PRNG.sfmt_seed 1;
  let test_name = "always true" in
  let pretest _ = () in
  let sampler _ length = (length, (fun _ -> true)) in
  let tests = [ bin_frequency         ,  true, 0, 100;
                bin_block_frequency_7 ,  true, 0, 100;
                bin_fft_64            ,  false, 0, 1024;
                bin_fft_1024          ,  true, 0, 1024; (* there is one frequency here - expect others randomly to exceed 95% too *)
              ] in
  run_random_tests test_name pretest sampler tests

(*f test_alternate_is_not_random - Test that a sequence 1 0 1 0 1 0 is not random

  This ensures the pattern and block frequency tests reject the null hypothesis that an 'alternating true false' distribution is independent with probability 0.5

  Note that the frequency and block frequency tests will accept it as random

  The patterns tests should fail as the patterns '00' and '11' (for example) never occur

 *)
let test_alternate_is_not_random _ =
    Owl_common.PRNG.sfmt_seed 1;
    let test_name = "every other" in
    let pretest _ = () in
    let sampler _ length = (length, (fun x -> ((x land 1)==0))) in
    let tests = [ bin_frequency         ,  false, 0, 100;
                  bin_block_frequency_7 ,  false, 0, 100;
                  bin_patterns_2        ,  true,  0, 1000;
                  bin_patterns_3        ,  true,  0, 1000;
                 ] in
    run_random_tests test_name pretest sampler tests

(*f test_three_of_four_is_not_random - Test that a sequence 1 0 0 0 1 0 0 0 is not random

  This ensures the pattern and block frequency tests reject the null hypothesis that a 'three zeros of four' distribution is independent with probability 0.5

  Note that the block frequency tests for small block sizes will accept it as random

 *)
let test_three_of_four_is_not_random _ =
  Owl_common.PRNG.sfmt_seed 1;
  let test_name = "three of four" in
  let pretest _ = () in
  let sampler _ length = (length, (fun x -> ((x land 3)==0))) in
  let tests = [ bin_frequency            , true, 0, 100;
                bin_block_frequency_7     ,  false, 0, 100;
                bin_block_frequency_7     ,  false, 0, 1000;
                bin_block_frequency_70    ,  true, 0, 1000;
                bin_patterns_2            ,  true, 0, 1000;
                bin_patterns_3            ,  true, 0, 1000;
              ] in
  run_random_tests test_name pretest sampler tests

(*f test_two_of_four_is_not_random - Test that a sequence 1 1 0 0 1 1 0 0 is not random

  This ensures the pattern and block frequency tests reject the null hypothesis that a 'two zeros of four' distribution is independent with probability 0.5

  Since the frequency is 50% true, all the frequency and block frequency tests should fail to reject the null hypothesis

  Patterns of length 2 will be uniform, which is (unlikely!) but quite possible, so that should also fail to reject the null hypothesis

  Patterns of length 3 and above will have no matches for runs of three 0s or 1s, so should reject the null hypothesis

 *)
let test_two_of_four_is_not_random _ =
  Owl_common.PRNG.sfmt_seed 1;
  let test_name = "two of four" in
  let pretest _ = () in
  let sampler _ length = (length, (fun x -> ((x land 3)<2))) in
  let tests = [ bin_frequency               , false, 0, 100;
                bin_block_frequency_7       , false, 0, 100;
                bin_block_frequency_7       , false, 0, 1000;
                bin_block_frequency_70      , false, 0, 1000;
                bin_patterns_2              , false, 0, 1000;
                bin_patterns_3              , true, 0, 1000;
                bin_patterns_4              , true, 0, 1000;
              ] in
  run_random_tests test_name pretest sampler tests

(*f test_uniform_ints_0_1 - Test the Uniform random variable in Owl with 0/1

  Since the uniform should be random, and P(1-100<50) = 0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_uniform_ints_0_1 _ =
  let test_name = "uniform_int ~a:0 ~b:1" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.uniform_int_rvs ~a:0 ~b:1)==0)) in
  let tests = [ bin_frequency           ,  false, 0, 100;
                bin_frequency           ,  false, 0, 1000;
                bin_frequency           ,  false, 0, 10000;
                bin_block_frequency_7   ,  false, 0, 100;
                bin_block_frequency_7   ,  false, 0, 1000;
                bin_block_frequency_70  ,  false, 0, 1000;
                bin_patterns_3          ,  false, 0, 1000;
              ] in
  run_random_tests test_name pretest sampler tests

(*f test_uniform_ints_1_100 - Test the Uniform random variable in Owl with 1-100<=50

  Since the uniform should be random, and P(1-100<50) = 0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_uniform_ints_1_100 _ =
  let test_name = "uniform_int ~a:1 ~b:100 <= 50" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.uniform_int_rvs ~a:1 ~b:100)<51)) in
  let tests = [ bin_frequency           ,  false, 0, 100;
                bin_frequency           ,  false, 0, 1000;
                bin_frequency           ,  false, 0, 10000;
                bin_block_frequency_7   ,  false, 0, 100;
                bin_block_frequency_7   ,  false, 0, 1000;
                bin_block_frequency_70  ,  false, 0, 1000;
                bin_block_frequency_70  ,  false, 0, 10000;
                bin_block_frequency_700 ,  false, 0, 10000;
                bin_block_frequency_700 ,  false, 0, 100000;
                bin_patterns_2          ,  false, 0, 1000;
                bin_patterns_3          ,  false, 0, 1000;
                bin_patterns_4          ,  false, 0, 1000;
                bin_patterns_5          ,  false, 0, 1000;
                bin_patterns_6          ,  false, 0, 1000;
                bin_patterns_7          ,  false, 0, 1000;
                bin_patterns_7          ,  false, 0, 10000;
                bin_patterns_8          ,  false, 0, 10000;
                bin_patterns_9          ,  false, 0, 10000;
                bin_patterns_10         ,  false, 0, 10000;
              ] in
  run_random_tests test_name pretest sampler tests

(*f test_uniform_ints_1_100_even - Test the Uniform random variable in Owl with 1-100<=50

  Since the uniform should be random, and P(1-100<50) = 0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_uniform_ints_1_100_even _ =
  let test_name = "uniform_int ~a:1 ~b:100 even" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 0 in
  let sampler _ length = (length, (fun _ -> ((M.uniform_int_rvs ~a:1 ~b:100) land 1)==0)) in
  let tests = tests_for_p_0_5 in
  run_random_tests test_name pretest sampler tests

(*f test_uniform_ints_0_to_65535 <bit> - Test the Uniform random variable in Owl with 0 to 65535 for a particular bit

  Since the uniform should be random, and any single bit P(0-65535) = 0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_uniform_ints_0_to_65535 (bit:int) _ =
  let test_name = sfmt "uniform_int ~a:0 ~b:65535 bit %d" bit in
  let pretest _ = Owl_common.PRNG.sfmt_seed 0 in
  let sampler _ length = (length, (fun _ -> (((M.uniform_int_rvs ~a:0 ~b:65535) lsr bit) land 1)==0)) in
  let tests = tests_for_p_0_5 in
  run_random_tests test_name pretest sampler tests
let test_uniform_ints_0_to_65535_bit_0 _ = test_uniform_ints_0_to_65535 0 ()
let test_uniform_ints_0_to_65535_bit_1 _ = test_uniform_ints_0_to_65535 1 ()
let test_uniform_ints_0_to_65535_bit_2 _ = test_uniform_ints_0_to_65535 2 ()
let test_uniform_ints_0_to_65535_bit_3 _ = test_uniform_ints_0_to_65535 3 ()
let test_uniform_ints_0_to_65535_bit_4 _ = test_uniform_ints_0_to_65535 4 ()
let test_uniform_ints_0_to_65535_bit_5 _ = test_uniform_ints_0_to_65535 5 ()
let test_uniform_ints_0_to_65535_bit_6 _ = test_uniform_ints_0_to_65535 6 ()
let test_uniform_ints_0_to_65535_bit_7 _ = test_uniform_ints_0_to_65535 7 ()
let test_uniform_ints_0_to_65535_bit_8 _ = test_uniform_ints_0_to_65535 8 ()
let test_uniform_ints_0_to_65535_bit_9 _ = test_uniform_ints_0_to_65535 9 ()
let test_uniform_ints_0_to_65535_bit_10 _ = test_uniform_ints_0_to_65535 10 ()
let test_uniform_ints_0_to_65535_bit_11 _ = test_uniform_ints_0_to_65535 11 ()
let test_uniform_ints_0_to_65535_bit_12 _ = test_uniform_ints_0_to_65535 12 ()
let test_uniform_ints_0_to_65535_bit_13 _ = test_uniform_ints_0_to_65535 13 ()
let test_uniform_ints_0_to_65535_bit_14 _ = test_uniform_ints_0_to_65535 14 ()
let test_uniform_ints_0_to_65535_bit_15 _ = test_uniform_ints_0_to_65535 15 ()

(*f test_uniform_ints_1_100_48 - Test the Uniform random variable in Owl with 1-100<=48

  Since the uniform should be random, and P(1-100<48) = 0.48, most tests should accept
    the null hypothesis that the distribution is random

  The longer frequency tests should reject the null hypothesis though

 *)
let test_uniform_ints_1_100_48 _ =
  let test_name = "uniform_int ~a:1 ~b:100 <= 48" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 0 in
  let sampler _ length = (length, (fun _ -> (M.uniform_int_rvs ~a:1 ~b:100)<=48)) in
  let tests = [ bin_frequency           ,  false, 0, 100;
                bin_frequency           ,  false, 0, 1000;
                bin_frequency           ,  true, 0, 10000;
                bin_block_frequency_7   ,  false, 0, 100;
                bin_block_frequency_7   ,  false, 0, 1000;
                bin_block_frequency_70  ,  false, 0, 1000;
                bin_block_frequency_70  ,  false, 0, 10000;
                bin_block_frequency_700 ,  false, 0, 10000;
                bin_block_frequency_700 ,  true, 0, 100000;
                bin_patterns_2          ,  false, 0, 1000;
                bin_patterns_3          ,  false, 0, 1000;
                bin_patterns_4          ,  false, 0, 1000;
                bin_patterns_5          ,  false, 0, 1000;
                bin_patterns_6          ,  false, 0, 1000;
                bin_patterns_7          ,  false, 0, 1000;
                bin_patterns_7          ,  false, 0, 10000;
                bin_patterns_8          ,  false, 0, 10000;
                bin_patterns_9          ,  false, 0, 10000;
                bin_patterns_10         ,  false, 0, 10000;
                bin_patterns_7          ,  false, 0, 100000;
                bin_patterns_8          ,  false, 0, 100000;
                bin_patterns_9          ,  false, 0, 100000;
                bin_patterns_10         ,  false, 0, 100000;
              ] in
  run_random_tests test_name pretest sampler tests

(*f test_uniform_ints_1_100_biased_2 - Test the Uniform random variable in Owl with 1-100<=45

  Since the uniform should be random, and P(1-100<45) = 0.45, most tests should accept
    the null hypothesis that the distribution is random

  The frequency tests should reject the null hypothesis though

 *)
let test_uniform_ints_1_100_45 _ =
  let test_name = "uniform_int ~a:1 ~b:100 <= 45" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 0 in
  let sampler _ length = (length, (fun _ -> (M.uniform_int_rvs ~a:1 ~b:100)<=45)) in
  let tests = [ bin_frequency           ,  false, 0, 100;
                bin_frequency           ,  true, 0, 1000;
                bin_frequency           ,  true, 0, 10000;
                bin_block_frequency_7   ,  false, 0, 100;
                bin_block_frequency_7   ,  false, 0, 1000;
                bin_block_frequency_70  ,  false, 0, 1000;
                bin_block_frequency_70  ,  false, 0, 10000;
                bin_block_frequency_700 ,  true, 0, 10000;
                bin_block_frequency_700 ,  true, 0, 100000;
                bin_patterns_2          ,  false, 0, 1000;
                bin_patterns_3          ,  false, 0, 1000;
                bin_patterns_4          ,  false, 0, 1000;
                bin_patterns_5          ,  false, 0, 1000;
                bin_patterns_6          ,  false, 0, 1000;
                bin_patterns_7          ,  false, 0, 1000;
                bin_patterns_7          ,  false, 0, 10000;
                bin_patterns_8          ,  false, 0, 10000;
                bin_patterns_9          ,  false, 0, 10000;
                bin_patterns_10         ,  false, 0, 10000;
              ] in
  run_random_tests test_name pretest sampler tests

(*f test_uniform_ints_1_300_100 - Test the Uniform random variable in Owl with 1-300<=100

    The frequency tests need to use the probability of 1/3 to pass

    The block frequency tests with short blocks will pass even if they expect p=0.5, given
    the block length is short

    The pattern tests are inherently based on the actual distribution probability, so they are
    not effected (except that large pattern lengths are less reliable as the expected number of a pattern
    of ten 1's in 10000 is (1/3)^10*10000 = 0.17; probaby one should not go below about 10 for this...
    so max length of patterns should probably be 6

 *)
let test_uniform_ints_1_300_100 _ =
  let test_name = "uniform_int ~a:1 ~b:300 mod 3 is 0" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> ((M.uniform_int_rvs ~a:1 ~b:300) mod 3)=0)) in
  let tests = [ bin_frequency           ,  true, 0, 100;
                bin_frequency           ,  true, 0, 1000;
                bin_frequency           ,  true, 0, 10000;
                bin_frequency_1_of_3    ,  false, 0, 100;
                bin_frequency_1_of_3    ,  false, 0, 1000;
                bin_frequency_1_of_3    ,  false, 0, 10000;
                bin_block_frequency_7   ,  false, 0, 100;  (* one might expect this one to reject, but 0.33~0.5 for length 7 *)
                bin_block_frequency_7   ,  false, 0, 1000; (* one might expect this one to reject, but 0.33~0.5 for length 7 *)
                bin_block_frequency_70  ,  true, 0, 1000;
                bin_block_frequency_70  ,  true, 0, 10000;
                bin_block_frequency_700 ,  true, 0, 10000;
                bin_block_frequency_700 ,  true, 0, 100000;
                bin_block_frequency_1_of_3_7   ,  false, 0, 100;
                bin_block_frequency_1_of_3_7   ,  false, 0, 1000;
                bin_block_frequency_1_of_3_70  ,  false, 0, 1000;
                bin_block_frequency_1_of_3_70  ,  false, 0, 10000;
                bin_block_frequency_1_of_3_700 ,  false, 0, 10000;
                bin_block_frequency_1_of_3_700 ,  false, 0, 100000;
                bin_patterns_2          ,  false, 0, 1000;
                bin_patterns_3          ,  false, 0, 1000;
                bin_patterns_4          ,  false, 0, 1000;
                bin_patterns_5          ,  false, 0, 1000;
                bin_patterns_6          ,  false, 0, 1000;
                bin_patterns_7          ,  false, 0, 1000;
                bin_patterns_7          ,  false, 0, 10000;
                bin_patterns_8          ,  false, 0, 10000;
                bin_patterns_9          ,  false, 0, 10000;
                bin_patterns_10         ,  false, 0, 10000;
              ] in
  run_random_tests test_name pretest sampler tests

(*f test_gaussian_mean_0 - Test the Gaussian random variable in Owl with 0/1

  Use Gaussian mean 0 SD 1, and > 0, for a binary test.

  Clearly should be independent occurrences with p=0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_gaussian_mean_0 _ =
  let test_name = "gaussian mean 0 sd 1 > 0" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.gaussian_rvs ~mu:0. ~sigma:1.)>0.)) in
  let tests = tests_for_p_0_5 in
  run_random_tests test_name pretest sampler tests

(*f test_gaussian_mean_0_p0_3_left - Test the Gaussian random variable in Owl with 0/1 < -0.43

    The frequency tests need to use the probability of 1/3 to pass

    The block frequency tests with short blocks will pass even if they expect p=0.5, given
    the block length is short

    The pattern tests are inherently based on the actual distribution probability, so they are
    not effected (except that large pattern lengths are less reliable as the expected number of a pattern
    of ten 1's in 10000 is (1/3)^10*10000 = 0.17; probaby one should not go below about 10 for this...
    so max length of patterns should probably be 6

 *)
let test_gaussian_mean_0_p0_3_left _ =
  let test_name = "gaussian mean 0 sd 1 < -.43 0" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.gaussian_rvs ~mu:0. ~sigma:1.)<(-0.43))) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_gaussian_mean_0_p0_3_right - Test the Gaussian random variable in Owl with 0/1 > 0.43

    The frequency tests need to use the probability of 1/3 to pass

    The block frequency tests with short blocks will pass even if they expect p=0.5, given
    the block length is short

    The pattern tests are inherently based on the actual distribution probability, so they are
    not effected (except that large pattern lengths are less reliable as the expected number of a pattern
    of ten 1's in 10000 is (1/3)^10*10000 = 0.17; probaby one should not go below about 10 for this...
    so max length of patterns should probably be 6

 *)
let test_gaussian_mean_0_p0_3_right _ =
  let test_name = "gaussian mean 0 sd 1 > 0.43" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.gaussian_rvs ~mu:0. ~sigma:1.)>(0.43))) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_exponential_lambda_1 - Test the Exponential random variable in Owl with lambda 1 p(0.5)

  Use Exponential (lambda.e**(-lambda)) with lambda of 1, for a binary test, probability (0.5)

  Clearly should be independent occurrences with p=0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_exponential_lambda_1 _ =
  let test_name = "exponential lambda 1 > 0.69" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.exponential_rvs ~lambda:1.)>0.69)) in
  let tests = tests_for_p_0_5 in
  run_random_tests test_name pretest sampler tests

(*f test_exponential_lambda_1_p0_3_left - Test the Exponential random variable in Owl with lambda 1 p(0.33)

  Use Exponential (lambda.e**(-lambda)) with lambda of 1, for a binary test, probability (0.33)

  Clearly should be independent occurrences with p=0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_exponential_lambda_1_p0_3_left _ =
  let test_name = "exponential lambda 1 < 0.41" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.exponential_rvs ~lambda:1.)< 0.41)) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_exponential_lambda_1_p0_3_right - Test the Exponential random variable in Owl with lambda 1 p(0.33)

  Use Exponential (lambda.e**(-lambda)) with lambda of 1, for a binary test, probability (0.33)

  Clearly should be independent occurrences with p=0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_exponential_lambda_1_p0_3_right _ =
  let test_name = "exponential lambda 1 > 1.10" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.exponential_rvs ~lambda:1.)>1.10)) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_hypergeometric_50_500_100 - Test hypergeometric with 1000 total items, 100 'good', sampling 195 times, p(0.5) (>=20 good)

  Use hypergeometric_rvs 50 (500-50) 100, for a binary test, probability (0.5)

  Clearly should be independent occurrences with p=0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_hypergeometric_50_500_100 _ =
  let test_name = "hypergeometric 50 of 500 good pick 100 > 9 good" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 2 in (* fails in one of the patterns with seed 1 *)
  let sampler _ length = (length, (fun _ -> (M.hypergeometric_rvs ~good:100 ~bad:(1000-100) ~sample:195)>=20)) in
  let tests = tests_for_p_0_5 in
  run_random_tests test_name pretest sampler tests

(*f test_hypergeometric_50_500_100_p0_3_left - Test hypergeometric with 1000 total items, 100 'good', sampling 180 times, p(0.333) (>=20 good)

  Use hypergeometric_rvs 100 (1000-100) 180, for a binary test, probability (0.333)

  Clearly should be independent occurrences with p=0.3333, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_hypergeometric_50_500_100_p0_3_left _ =
  let test_name = "hypergeometric 50 of 500 good pick 100 > 9 good" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 2 in (* fails in one of the patterns with seed 1 *)
  let sampler _ length = (length, (fun _ -> (M.hypergeometric_rvs ~good:100 ~bad:(1000-100) ~sample:180)>=20)) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_hypergeometric_50_500_100_p0_3_right - Test hypergeometric with 1000 total items, 100 'good', sampling 212 times, p(0.333) (<20 good)

  Use hypergeometric_rvs 100 (1000-100) 212, for a binary test, probability (0.333)

  Clearly should be independent occurrences with p=0.333, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_hypergeometric_50_500_100_p0_3_right _ =
  let test_name = "hypergeometric 50 of 500 good pick 100 > 9 good" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 2 in (* fails in one of the patterns with seed 1 *)
  let sampler _ length = (length, (fun _ -> (M.hypergeometric_rvs ~good:100 ~bad:(1000-100) ~sample:212)<20)) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_gamma_shape_7_5_scale_1 - Test the Gamma distribution

  gamma(shape 7.5, scale 1.) > 7.17 is p(0.5)
  Clearly should be independent occurrences with p=0.5, all tests should accept
    the null hypothesis that the distribution is random

<6.08 0.3333
>8.38 0.3333
 *)
let test_gamma_shape_7_5_scale_1 _ =
  let test_name = "gamma scale 7.5 scale 1.0 > 7.17" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.gamma_rvs ~shape:7.5 ~scale:1.)>7.17)) in
  let tests = tests_for_p_0_5 in
  run_random_tests test_name pretest sampler tests

(*f test_gamma_shape_7_5_scale_1_p0_3_left - Test the Gamma distribution

  gamma(shape 7.5, scale 1.) < 6.08 is p(0.333)
  Clearly should be independent occurrences with p=0.333, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_gamma_shape_7_5_scale_1_p0_3_left _ =
  let test_name = "gamma scale 7.5 scale 1.0 < 6.08" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.gamma_rvs ~shape:7.5 ~scale:1.)<6.08)) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_gamma_shape_7_5_scale_1_p0_3_right - Test the Gamma distribution

  gamma(shape 7.5, scale 1.) > 8.38 is p(0.333)
  Clearly should be independent occurrences with p=0.333, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_gamma_shape_7_5_scale_1_p0_3_right _ =
  let test_name = "gamma scale 7.5 scale 1.0 > 8.38" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.gamma_rvs ~shape:7.5 ~scale:1.)>8.38)) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_beta_alpha_2_beta_5 - Test the Gamma distribution

  beta(alpha 2 beta 5) > 0.265 is p(0.5)

  Clearly should be independent occurrences with p=0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_beta_alpha_2_beta_5 _ =
  let test_name = "beta (alpha 2 beta 5)  0.265" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.beta_rvs ~a:2.0 ~b:5.0)>0.265)) in
  let tests = tests_for_p_0_5 in
  run_random_tests test_name pretest sampler tests

(*f test_beta_alpha_2_beta_5_p0_3_left - Test the Gamma distribution

  beta(alpha 2 beta 5) > 0.265 is p(0.5)

  Clearly should be independent occurrences with p=0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_beta_alpha_2_beta_5_p0_3_left _ =
  let test_name = "beta (alpha 2 beta 5) < 0.195" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.beta_rvs ~a:2.0 ~b:5.0)<0.195)) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_beta_alpha_2_beta_5_p0_3_right - Test the Gamma distribution

  beta(alpha 2 beta 5) > 0.341 is p(0.333)

  Clearly should be independent occurrences with p=0.333, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_beta_alpha_2_beta_5_p0_3_right _ =
  let test_name = "beta (alpha 2 beta 5) > 0.341" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.beta_rvs ~a:2.0 ~b:5.0)>0.341)) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_chi2_df_4 - Test the Chi2 distribution

  chi2(df 4) > 3.36 is p(0.5)

  Clearly should be independent occurrences with p=0.5, all tests should accept
    the null hypothesis that the distribution is random

 *)
let test_chi2_df_4 _ =
  let test_name = "chi2 (4 df) > 3.36" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.chi2_rvs ~df:4.00)>3.36)) in
  let tests = tests_for_p_0_5 in
  run_random_tests test_name pretest sampler tests

(*f test_chi2_df_4_p0_3_left - Test the Chi2 distribution

  chi2(df 4) < 2.38 is p(0.333)

  Clearly should be independent occurrences with p=0.333, all tests should accept
    the null hypothesis that the distribution is random
 *)
let test_chi2_df_4_p0_3_left _ =
  let test_name = "chi2 (4 df) < 2.38" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 2 in (* seed 1 fails *)
  let sampler _ length = (length, (fun _ -> (M.chi2_rvs ~df:4.00)<2.38)) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*f test_chi2_df_4_p0_3_right - Test the Chi2 distribution

  chi2(df 4) > 4.58 is p(0.333)

  Clearly should be independent occurrences with p=0.333, all tests should accept
    the null hypothesis that the distribution is random
 *)
let test_chi2_df_4_p0_3_right _ =
  let test_name = "chi2 (4 df) > 4.58" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.chi2_rvs ~df:4.00)>4.58)) in
  let tests = tests_for_p_0_3 in
  run_random_tests test_name pretest sampler tests

(*a Test suite *)
(* The tests *)
let test_set = [
  "true_is_not_random", `Slow, test_true_is_not_random; (* tests the test infrastructure *)
  "alternate_is_not_random", `Slow, test_alternate_is_not_random; (* tests the test infrastructure *)
  "three_of_four_is_not_random", `Slow, test_three_of_four_is_not_random; (* tests the test infrastructure *)
  "two_of_four_is_not_random", `Slow, test_two_of_four_is_not_random; (* tests the test infrastructure *)
  "uniform_int_0_or_1", `Slow, test_uniform_ints_0_1;
  "uniform_ints_1_to_100", `Slow, test_uniform_ints_1_100;
  "uniform_ints_1_to_100_even", `Slow, test_uniform_ints_1_100_even;
  "uniform_ints_1_to_100_48", `Slow, test_uniform_ints_1_100_48;
  "uniform_ints_1_to_100_45", `Slow, test_uniform_ints_1_100_45;
  "uniform_ints_1_to_300_100", `Slow, test_uniform_ints_1_300_100;
  "gaussian_mean_0", `Slow, test_gaussian_mean_0;
  "gaussian_mean_0_p0_3_left", `Slow, test_gaussian_mean_0_p0_3_left;
  "gaussian_mean_0_p0_3_right", `Slow, test_gaussian_mean_0_p0_3_right;
  "exponential_lambda_1", `Slow, test_exponential_lambda_1;
  "exponential_lambda_1_p0_3_left", `Slow, test_exponential_lambda_1_p0_3_left;
  "exponential_lambda_1_p0_3_right", `Slow, test_exponential_lambda_1_p0_3_right;
  "hypergeometric_50_500_100", `Slow, test_hypergeometric_50_500_100;
  "hypergeometric_50_500_100_p0_3_left", `Slow, test_hypergeometric_50_500_100_p0_3_left;
  "hypergeometric_50_500_100_p0_3_right", `Slow, test_hypergeometric_50_500_100_p0_3_right;
  "gamma_shape_7_5_scale_1", `Slow, test_gamma_shape_7_5_scale_1;
  "gamma_shape_7_5_scale_1_p0_3_left", `Slow, test_gamma_shape_7_5_scale_1_p0_3_left;
  "gamma_shape_7_5_scale_1_p0_3_right", `Slow, test_gamma_shape_7_5_scale_1_p0_3_right;
  "beta_alpha_2_beta_5", `Slow, test_beta_alpha_2_beta_5;
  "beta_alpha_2_beta_5_p0_3_left", `Slow, test_beta_alpha_2_beta_5_p0_3_left;
  "beta_alpha_2_beta_5_p0_3_right", `Slow, test_beta_alpha_2_beta_5_p0_3_right;
  "chi2_df_4", `Slow, test_chi2_df_4;
  "chi2_df_4_p0_3_left", `Slow, test_chi2_df_4_p0_3_left;
  "chi2_df_4_p0_3_right", `Slow, test_chi2_df_4_p0_3_right;
  "uniform_ints_0_to_65536_bit_0", `Slow, test_uniform_ints_0_to_65535_bit_0;
  "uniform_ints_0_to_65536_bit_1", `Slow, test_uniform_ints_0_to_65535_bit_1;
  "uniform_ints_0_to_65536_bit_2", `Slow, test_uniform_ints_0_to_65535_bit_2;
  "uniform_ints_0_to_65536_bit_3", `Slow, test_uniform_ints_0_to_65535_bit_3;
  "uniform_ints_0_to_65536_bit_4", `Slow, test_uniform_ints_0_to_65535_bit_4;
  "uniform_ints_0_to_65536_bit_5", `Slow, test_uniform_ints_0_to_65535_bit_5;
  "uniform_ints_0_to_65536_bit_6", `Slow, test_uniform_ints_0_to_65535_bit_6;
  "uniform_ints_0_to_65536_bit_7", `Slow, test_uniform_ints_0_to_65535_bit_7;
  "uniform_ints_0_to_65536_bit_8", `Slow, test_uniform_ints_0_to_65535_bit_8;
  "uniform_ints_0_to_65536_bit_9", `Slow, test_uniform_ints_0_to_65535_bit_9;
  "uniform_ints_0_to_65536_bit_10", `Slow, test_uniform_ints_0_to_65535_bit_10;
  "uniform_ints_0_to_65536_bit_11", `Slow, test_uniform_ints_0_to_65535_bit_11;
  "uniform_ints_0_to_65536_bit_12", `Slow, test_uniform_ints_0_to_65535_bit_12;
  "uniform_ints_0_to_65536_bit_13", `Slow, test_uniform_ints_0_to_65535_bit_13;
  "uniform_ints_0_to_65536_bit_14", `Slow, test_uniform_ints_0_to_65535_bit_14;
  "uniform_ints_0_to_65536_bit_15", `Slow, test_uniform_ints_0_to_65535_bit_15;
  "rough_cdf_matches", `Slow, test_rough_cdf_matches;
]
