(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Mathematics module

  This module contains some basic and advanced mathematical operations.
  If you cannot find some function in this module, try Stats module.

  Please refer to GSL documentation using following linke for details:
  https://www.gnu.org/software/gsl/manual
*)


(** {6 Basic math functions} *)

val abs : float -> float

val sqrt : float -> float

val pow : float -> float -> float

val exp : float -> float

val expm1 : float -> float

val exp_mult : float -> float -> float

val exprel : float -> float

val ln : float -> float

val ln1p : float -> float

val ln_abs : float -> float

val log2 : float -> float

val log10 : float -> float

val log : float -> float -> float

val sigmoid : float -> float

(** {6 Trigonometric Functions} *)

val sin : float -> float

val cos : float -> float

val tan : float -> float

val cot : float -> float

val sec : float -> float

val csc : float -> float

val asin : float -> float

val acos : float -> float

val atan : float -> float

val acot : float -> float

val sinh : float -> float

val cosh : float -> float

val asinh : float -> float

val acosh : float -> float

val atanh : float -> float

val sinc : float -> float

val lnsinh : float -> float

val lncosh : float -> float

val hypot : float -> float -> float

val rect_of_polar : r:float -> theta:float -> float * float

val polar_of_rect : x:float -> y:float -> float * float

val angle_restrict_symm : float -> float

val angle_restrict_pos : float -> float


(** {6 Airy functions and derivatives} *)

val airy_Ai : float -> float

val airy_Bi : float -> float

val airy_Ai_scaled : float -> float

val airy_Bi_scaled : float -> float

val airy_Ai_deriv : float -> float

val airy_Bi_deriv : float -> float

val airy_Ai_deriv : float -> float

val airy_Bi_deriv : float -> float

val airy_zero_Ai : int -> float

val airy_zero_Bi : int -> float


(** {6 Regular Cylindrical Bessel Functions} *)

val bessel_J0 : float -> float

val bessel_J1 : float -> float

val bessel_Jn : int -> float -> float

val bessel_Jn_array : int -> int -> float -> float array


(** {6 Irregular Cylindrical Bessel Functions} *)

val bessel_Y0 : float -> float

val bessel_Y1 : float -> float

val bessel_Yn : int -> float -> float

val bessel_Yn_array : int -> int -> float -> float array


(** {6 Regular Modified Cylindrical Bessel Functions} *)

val bessel_I0 : float -> float

val bessel_I1 : float -> float

val bessel_In : int -> float -> float

val bessel_In_array : int -> int -> float -> float array

val bessel_I0_scaled : float -> float

val bessel_I1_scaled : float -> float

val bessel_In_scaled : int -> float -> float

val bessel_In_scaled_array : int -> int -> float -> float array


(** {6 Irregular Modified Cylindrical Bessel Functions} *)

val bessel_K0 : float -> float

val bessel_K1 : float -> float

val bessel_Kn : int -> float -> float

val bessel_Kn_array : int -> int -> float -> float array

val bessel_K0_scaled : float -> float

val bessel_K1_scaled : float -> float

val bessel_Kn_scaled : int -> float -> float

val bessel_Kn_scaled_array : int -> int -> float -> float array


(** {6 Regular Spherical Bessel Functions} *)

val bessel_j0 : float -> float

val bessel_j1 : float -> float

val bessel_j2 : float -> float

val bessel_jl : int -> float -> float

val bessel_jl_array : int -> float -> float array

val bessel_jl_steed_array : int -> float -> float array


(** {6 Irregular Spherical Bessel Functions} *)

val bessel_y0 : float -> float

val bessel_y1 : float -> float

val bessel_y2 : float -> float

val bessel_yl : int -> float -> float

val bessel_yl_array : int -> float -> float array


(** {6 Regular Modified Spherical Bessel Functions} *)

val bessel_i0_scaled : float -> float

val bessel_i1_scaled : float -> float

val bessel_il_scaled : int -> float -> float

val bessel_il_array_scaled : int -> float -> float array


(** {6 Irregular Modified Spherical Bessel Functions} *)

val bessel_k0_scaled : float -> float

val bessel_k1_scaled : float -> float

val bessel_kl_scaled : int -> float -> float

val bessel_kl_array_scaled : int -> float -> float array


(** {6 Regular Bessel Function - Fractional Order} *)

val bessel_Jnu : float -> float -> float


(** {6 Irregular Bessel Functions - Fractional Order} *)

val bessel_Ynu : float -> float -> float


(** {6 Regular Modified Bessel Functions - Fractional Order} *)

val bessel_Inu : float -> float -> float

val bessel_Inu_scaled : float -> float -> float


(** {6 Irregular Modified Bessel Functions - Fractional Order} *)

val bessel_Knu : float -> float -> float

val bessel_lnKnu : float -> float -> float

val bessel_Knu_scaled : float -> float -> float


(** {6 Zeros of Regular Bessel Functions} *)

val bessel_zero_J0 : int -> float

val bessel_zero_J1 : int -> float

val bessel_zero_Jnu : float -> int -> float


(** {6 Clausen Functions} *)

val clausen : float -> float


(** {6 Dawson Function} *)

val dawson : float -> float


(** {6 Debye Functions} *)

val debye_1 : float -> float

val debye_2 : float -> float

val debye_3 : float -> float

val debye_4 : float -> float

val debye_5 : float -> float

val debye_6 : float -> float


(** {6 Dilogarithm} *)

val dilog : float -> float


(** {6 Elliptic Integrals} *)

val ellint_Kcomp : float -> float

val ellint_Ecomp : float -> float

val ellint_Pcomp : float -> float -> float

val ellint_Dcomp : float -> float


(** {6 Elliptic Integrals - Legendre Form of Complete Elliptic Integrals} *)

val laguerre_1 : float -> float -> float

val laguerre_2 : float -> float -> float

val laguerre_3 : float -> float -> float

val laguerre_n : int -> float -> float -> float


(** {6 Elliptic Integrals - Legendre Form of Incomplete Elliptic Integrals} *)

val ellint_F : float -> float -> float

val ellint_E : float -> float -> float

val ellint_P : float -> float -> float -> float

val ellint_D : float -> float -> float


(** {6 Elliptic Integrals - Carlson Forms of Incomplete Elliptic Integrals} *)

val ellint_RC : float -> float -> float

val ellint_RD : float -> float -> float -> float

val ellint_RF : float -> float -> float -> float

val ellint_RJ : float -> float -> float -> float -> float


(** {6 Exponential Integrals} *)

val expint_E1 : float -> float

val expint_E2 : float -> float

val expint_Ei : float -> float

val expint_E1_scaled : float -> float

val expint_E2_scaled : float -> float

val expint_Ei_scaled : float -> float

val expint_3 : float -> float

val shi : float -> float

val chi : float -> float

val si : float -> float

val ci : float -> float

val atanint : float -> float


(** {6 Fermi-Dirac Function} *)

val fermi_dirac_m1 : float -> float

val fermi_dirac_0 : float -> float

val fermi_dirac_1 : float -> float

val fermi_dirac_2 : float -> float

val fermi_dirac_int : int -> float -> float

val fermi_dirac_mhalf : float -> float

val fermi_dirac_half : float -> float

val fermi_dirac_3half : float -> float

val fermi_dirac_inc_0 : float -> float -> float


(** {6 Gamma Functions} *)

val gamma : float -> float

val lngamma : float -> float

val gammastar : float -> float

val gammainv : float -> float


(** {6 Incomplete Gamma Functions} *)

val gamma_inc : float -> float -> float

val gamma_inc_Q : float -> float -> float

val gamma_inc_P : float -> float -> float


(** {6 Factorials} *)

val factorial : int -> float

val double_factorial : int -> float

val ln_factorial : int -> float

val ln_double_factorial : int -> float

val permutation : int -> int -> int

val combination : int -> int -> int

val ln_combination : int -> int -> float

val taylorcoeff : int -> float -> float

val combination_iterator : int -> int -> (unit -> int array)

val permutation_iterator : int -> (unit -> int array)


(** {6 Pochhammer Symbol} *)

val poch : float -> float -> float

val lnpoch : float -> float -> float

val pochrel : float -> float -> float


(** {6 Beta functions} *)

val betaf : float -> float -> float

val lnbeta : float -> float -> float

val beta_inc : float -> float -> float -> float


(** {6 Laguerre Functions} *)

val laguerre_1 : float -> float -> float

val laguerre_2 : float -> float -> float

val laguerre_3 : float -> float -> float

val laguerre_n : int -> float -> float -> float


(** {6 Lambert W Functions} *)

val lambert_w0 : float -> float

val lambert_w1 : float -> float


(** {6 Legendre Functions and Spherical Harmonics} *)

val legendre_P1 : float -> float

val legendre_P2 : float -> float

val legendre_P3 : float -> float

val legendre_Pl : int -> float -> float

val legendre_Pl_array : int -> float -> float array

val legendre_Q0 : float -> float

val legendre_Q1 : float -> float

val legendre_Ql : int -> float -> float


(** {6 Psi (Digamma) Function} *)

val psi : float -> float

val psi_int : int -> float

val psi_1 : float -> float

val psi_1piy : float -> float

val psi_1_pint : int -> float

val psi_n : int -> float -> float


(** {6 Synchrotron Functions} *)

val synchrotron_1 : float -> float

val synchrotron_2 : float -> float


(** {6 Transport Functions} *)

val transport_2 : float -> float

val transport_3 : float -> float

val transport_4 : float -> float

val transport_5 : float -> float


(** {6 Zeta Functions} *)

val zeta : float -> float

val zeta_int : int -> float

val hzeta : float -> float -> float

val eta : float -> float

val eta_int : int -> float


(** {6 Some constants} *)

val pi : float


(* TODO: Wavelet function is missing; FFT function is missing *)




(* ends here *)
