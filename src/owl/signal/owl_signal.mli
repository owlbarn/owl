(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2021 Chandra Shekhar <shekharchandra134@gmail.com>, Kumar Appaiah <akumar@ee.iitb.ac.in>
 *)

(** Signal: Fundamental Signal Processing functions. *)

open Owl_dense

(** {Basic window functions} *)

val blackman : int -> Ndarray.D.arr
(** Blackman window is a taper formed by using the first three terms of a summation of cosines. It was designed to have close to the minimal leakage possible. 
``blackman m`` returns a blackman window.
*)

val hamming : int -> Ndarray.D.arr
(** Hamming window is a taper formed by using a raised cosine with non-zero endpoints, optimized to minimize the nearest side lobe. ``hamming m``
returns a hamming window.
*)

val hann : int -> Ndarray.D.arr
(** Hann window is a taper formed by using a raised cosine or sine-squared with ends that touch zero. ``hann m``
returns a hann window.
*)

(** {Filter response function} *)

val freqz
  :  ?n:int
  -> ?whole:bool
  -> float array
  -> float array
  -> Ndarray.D.arr * Ndarray.Z.arr
(** freqz computes the frequency response of a digital filter. 

``freqz b a`` computes the frequency response of digital filter with numerator filter coeffecient given by ``b`` (float array) while the denominator filter coeffecient given by ``a`` (float array), and returns the frequencies and the frequency response respectively in real and complex ndarrays. Two optional parameters may be specified: ``n`` is an integer that determines the number of frequencies where the frequency response is to be evaluated, and ``whole`` is a boolean that decides whether the frequency response is two-sided or one-sided. Default values of ``n`` and ``whole`` are 512 and false.
*)

(*ends here*)
