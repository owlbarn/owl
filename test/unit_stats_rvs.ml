(** Unit test for Owl_stats module *)

module M = Owl_stats
module Maths = Owl_maths

(* define the test error *)
let eps = 1e-10
let sfmt = Printf.sprintf

(*a Types *)
(*t t_iter is an iterator that takes a function f and an initial accumulator value acc, and
    folds over a data set to produce (N, (f (f (f acc data[0]) data[1]) ... data[N]))
 *)
type ('a,'b) t_iter  = ('a -> 'b -> 'a) -> 'a -> (int * 'a)


(*a Test modules *)
(*m RandomTest *)
module RandomTest = struct
type test_hypothesis = {
    test_name : string;
    score_name: string;
    hypothesis : M.hypothesis
  }

let make_hypothesis reject p_value score : M.hypothesis =
     {reject; p_value; score }

let make_test_hypothesis test_name score_name hypothesis =
     { test_name; score_name; hypothesis; }

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

    let iterate (sampler: int -> int -> (int *(int -> 'b))) (start:int) (length:int) (f:'c -> 'b -> 'c) (acc:'c) : (int * 'c) =
      let (actual_length, sampler_next) = sampler start length in
      let rec x acc i n =
        if (n<=0) then acc else (
          let new_acc = f acc (sampler_next i) in
          x new_acc (i+1) (n-1)
        )
    in
     (length, x acc 0 actual_length)
end

(*m BinaryTest *)
module BinaryTest = struct
  include RandomTest
  (*f frequency test

     Yi = {-1 with p(0.5), 1 with p(0.5)}
     Mean(Yi)     = 0
     Variance(Yi) = 1/2 ( (-1-0)^2 + (1-0)^2 ) = 1

     For Y = N occurences of Yi:
     Mean(Y) = N*0 = 0, Variance(Y) = N*1 = N

     Consider Y' = Y/sqrt(2N):
     Mean(Y') = 0, Variance(Y') = 1/2

     If Y' is normally distributed then the probability of observing a value outside of [-|s|;|s|] for Y' is erfc(|s|)

    *)
  let frequency ?significance:(significance=0.01) iter =
    let inc_if_true_else_dec acc b = 
      if b then (acc+1) else (acc-1)
    in
    let (n,sum) = iter inc_if_true_else_dec 0 in (* sum should have mean 0, sd=sqrt(n) *)
    let s_obs = (abs_float (float sum)) /. (sqrt (float n)) in (* mean 0, sd=1 *)
	let x = s_obs /. (sqrt 2.) in (* mean 0, sd=1/sqrt(2) *)
    let p = Maths.erfc x in (* probablity of seeing x given the distribution actually is mean 0, sd=1/sqrt(2) *)
    let hypothesis = make_hypothesis (p < significance) p x in
    make_test_hypothesis (sfmt "Frequency with %d samples" n) "Partial sum" hypothesis
    
  (*f block_frequency test
    Consider a stream of N * M bools, which may be represented as 0 or 1s.

    Consider the number of occurrence of trues/1's, particularly, within each run of M bools/bits.

    We can calculate Chi^2 = M*Sum( (Obs(1s)/M-prob(getting 1))^2/prob(getting 1) ), summing over the N blocks.
    The inside of this is ((sum1s/M-0.5)^2)/0.5) = (sum1s/M-0.5)^2 = 2*chi2_obs (in the code)

    Assume that the probability of a 1 is 0.5, under the null hypothesis that 0s and 1s are equally likely.

    The probability of an observed value x2 for Chi^2 can be found from the Chi^2 distribution for N degrees of freedom.
    *)
  let block_frequency ?significance:(significance=0.01) m iter =
    let number_ones_in_block (i_of_m,acc,chi2,n) b =
      let v = if b then 1 else 0 in
      if (i_of_m+1)==m then
        let chi2_obs = ((float (acc+v))/.(float m) -. 0.5)**2. in
        (0,0,chi2_obs +. chi2,n+1)
      else
        (i_of_m+1,acc+v,chi2,n)
    in
    let (_,(_,_,chi2,n)) = iter number_ones_in_block (0,0,0.,0) in
    let chi2 = chi2 *. 2. *. (float m) in
    let p = 1. -. (M.chi2_cdf chi2 (float n)) in
    let hypothesis = make_hypothesis (p < significance) p chi2 in
    make_test_hypothesis (sfmt "Block frequency of %d run lengths of size %d" n m) "Chi^2" hypothesis

  (*f occurrence_of_patterns
    Conisder every pattern of M bools/bits, given P(true/1)=p and P(false/0)=1-p=q

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
    let count_observations (sum_z,sum_o,m_seen,pat) b =
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
       Printf.printf "%f %f %f\n" (prob_z ** (float m)) (prob_o ** (float m)) (5.0/.(float (n-m+1)));
       Array.iteri (fun i v -> Printf.printf "Expecting %d:%f\n" i v) exp_counts;
       Array.iteri (fun i v -> Printf.printf "Occurrences %d:%d\n" i v) obs_counts;
    (*
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
    
  (*f All done *)
end

(*a Initialization *)
let _ =
  Owl_common.PRNG.init ();
  Owl_common.PRNG.sfmt_seed 1

(*a Tests *)

type t_bin_iter = IOfBool of  ((int,bool) t_iter -> RandomTest.test_hypothesis)
                | IIIIOfBool of ((int * int * int * int, bool) t_iter -> RandomTest.test_hypothesis)
                | IIFIOfBool of ((int * int * float * int, bool) t_iter -> RandomTest.test_hypothesis)

let bin_frequency         = IOfBool    (BinaryTest.frequency)           (* Distribution of (# of 1s in runs of length 7) is uniform *)

let bin_block_frequency_7   = IIFIOfBool (BinaryTest.block_frequency 7)     (* Distribution of (# of 1s in runs of length 7) is uniform *)
let bin_block_frequency_70  = IIFIOfBool (BinaryTest.block_frequency 70)    (* Distribution of (# of 1s in runs of length 70) is uniform *)
let bin_block_frequency_700 = IIFIOfBool (BinaryTest.block_frequency 700)   (* Distribution of (# of 1s in runs of length 700) is uniform *)

let bin_patterns_2 = IIIIOfBool (BinaryTest.occurrence_of_patterns 2) (* Distribution of overlapping 2-bit patterns is uniform *)
let bin_patterns_3 = IIIIOfBool (BinaryTest.occurrence_of_patterns 3) (* Distribution of overlapping 3-bit patterns is uniform *)
let bin_patterns_4 = IIIIOfBool (BinaryTest.occurrence_of_patterns 4) (* Distribution of overlapping 4-bit patterns is uniform *)
let bin_patterns_5 = IIIIOfBool (BinaryTest.occurrence_of_patterns 5) (* Distribution of overlapping 5-bit patterns is uniform *)
let bin_patterns_6 = IIIIOfBool (BinaryTest.occurrence_of_patterns 6) (* Distribution of overlapping 6-bit patterns is uniform *)
let bin_patterns_7 = IIIIOfBool (BinaryTest.occurrence_of_patterns 7) (* Distribution of overlapping 7-bit patterns is uniform *)
let bin_patterns_8 = IIIIOfBool (BinaryTest.occurrence_of_patterns 8) (* Distribution of overlapping 8-bit patterns is uniform *)
let bin_patterns_9 = IIIIOfBool (BinaryTest.occurrence_of_patterns 9) (* Distribution of overlapping 9-bit patterns is uniform *)
let bin_patterns_10 = IIIIOfBool (BinaryTest.occurrence_of_patterns 10) (* Distribution of overlapping 10-bit patterns is uniform *)

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
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> ((M.uniform_int_rvs ~a:1 ~b:100) land 1)==0)) in
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
                bin_patterns_5          ,  true , 0, 1000; (* !!! *)
                bin_patterns_6          ,  true, 0, 1000; (* !!! *)
                bin_patterns_7          ,  true, 0, 1000; (* !!! *)
                bin_patterns_7          ,  false, 0, 10000;
                bin_patterns_8          ,  false, 0, 10000;
                bin_patterns_9          ,  false, 0, 10000;
                bin_patterns_10         ,  false, 0, 10000;
              ] in
  run_random_tests test_name pretest sampler tests

(*f test_uniform_ints_1_100_biased - Test the Uniform random variable in Owl with 1-100<=48

  Since the uniform should be random, and P(1-100<48) = 0.48, most tests should accept
    the null hypothesis that the distribution is random

  However, depending on the seed some should fail - particularly longer pattern lengths
  For example, for seed=1, bin_patterns_8 fails

  The longer frequency tests should reject the null hypothesis though

 *)
let test_uniform_ints_1_100_48 _ =
  let test_name = "uniform_int ~a:1 ~b:100 <= 48" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
  let sampler _ length = (length, (fun _ -> (M.uniform_int_rvs ~a:1 ~b:100)<=48)) in
  let tests = [ bin_frequency           ,  false, 0, 100;
                bin_frequency           ,  false, 0, 1000;
                bin_frequency           ,  true, 0, 10000;
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
                bin_patterns_8          ,  true, 0, 10000;
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

  Indeed, for seed=1, bin_patterns_8 passes, even though it fails for P=0.48

  The frequency tests should reject the null hypothesis though

 *)
let test_uniform_ints_1_100_45 _ =
  let test_name = "uniform_int ~a:1 ~b:100 <= 45" in
  let pretest _ = Owl_common.PRNG.sfmt_seed 1 in
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
]
