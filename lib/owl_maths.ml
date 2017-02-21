(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Mathematics Module ]  *)

let e = Gsl.Math.e

let euler = Gsl.Math.euler

let log2e = Gsl.Math.log2e

let log10e = Gsl.Math.log10e

let sqrt1_2 = Gsl.Math.sqrt1_2

let sqrt2 = Gsl.Math.sqrt2

let sqrt3 = Gsl.Math.sqrt3

let sqrtpi = Gsl.Math.sqrtpi

let pi = Gsl.Math.pi

let pi_2 = Gsl.Math.pi_2

let pi_4 = Gsl.Math.pi_4

let i_1_pi = Gsl.Math.i_1_pi

let i_1_pi = Gsl.Math.i_2_pi

let ln10 = Gsl.Math.ln10

let ln2 = Gsl.Math.ln2

let lnpi = Gsl.Math.lnpi

(** [ Basic and advanced math functions ] *)

let signum x = if x = 0. then 0. else if x > 0. then 1. else -1.

let abs x = if x < 0. then (0.-.x) else x

let neg x = 0. -. x

let floor x = floor x

let ceil x = ceil x

let round_lb = -.(2. ** 52.)
let round_ub = 2. ** 52.
let round t =
  if t >= round_lb && t <= round_ub then
    floor (t +. 0.49999999999999994)
  else t

let sqrt x = sqrt x

let pow x y = x ** y

let exp x = Gsl.Sf.exp x

let expm1 x = Gsl.Sf.expm1 x

let exp_mult x y = Gsl.Sf.exp_mult x y

let exprel x = Gsl.Sf.exprel x

let log x = Gsl.Sf.log x

let log1p x = Gsl.Sf.log_1plusx x

let log_abs x = Gsl.Sf.log_abs x

let log2 x = (log x) /. Gsl.Math.ln2

let log10 x = (log x) /. Gsl.Math.ln10

let logN base x = (log x) /. (log base)

let sigmoid x = 1. /. (exp (-.x) +. 1.)

let sin x = sin x

let cos x = cos x

let tan x = tan x

let cot x = 1. /. (tan x)

let sec x = 1. /. (cos x)

let csc x = 1. /. (sin x)

let asin x = asin x

let acos x = acos x

let atan x = atan x

let acot x = (Gsl.Math.pi /. 2.) -. (atan x)

let asec = None

let acsc = None

let sinc x = Gsl.Sf.sinc x

let sinh x = sinh x

let cosh x = cosh x

let tanh x = tanh x

let asinh x = Gsl.Math.asinh x

let acosh x = Gsl.Math.acosh x

let atanh x = Gsl.Math.atanh x

let lnsinh x = Gsl.Sf.lnsinh x

let lncosh x = Gsl.Sf.lncosh x

let hypot x y = Gsl.Sf.hypot x y

let rect_of_polar ~r ~theta =
  let open Gsl.Fun in
  let x, y = Gsl.Sf.rect_of_polar ~r ~theta in
  x.res, y.res

let polar_of_rect ~x ~y =
  let open Gsl.Fun in
  let a, b = Gsl.Sf.polar_of_rect ~x ~y in
  a.res, b.res

let angle_restrict_symm x = Gsl.Sf.angle_restrict_symm x

let angle_restrict_pos x = Gsl.Sf.angle_restrict_pos x

let airy_Ai x = Gsl.Sf.airy_Ai x Gsl.Fun.DOUBLE

let airy_Bi x = Gsl.Sf.airy_Ai x Gsl.Fun.DOUBLE

let airy_Ai_scaled x = Gsl.Sf.airy_Ai_scaled x Gsl.Fun.DOUBLE

let airy_Bi_scaled x = Gsl.Sf.airy_Bi_scaled x Gsl.Fun.DOUBLE

let airy_Ai_deriv x = Gsl.Sf.airy_Ai_deriv x Gsl.Fun.DOUBLE

let airy_Bi_deriv x = Gsl.Sf.airy_Ai_deriv x Gsl.Fun.DOUBLE

let airy_Ai_deriv x = Gsl.Sf.airy_Ai_deriv_scaled x Gsl.Fun.DOUBLE

let airy_Bi_deriv x = Gsl.Sf.airy_Bi_deriv_scaled x Gsl.Fun.DOUBLE

let airy_zero_Ai x = Gsl.Sf.airy_zero_Ai x

let airy_zero_Bi x = Gsl.Sf.airy_zero_Ai x

let bessel_J0 x = Gsl.Sf.bessel_J0 x

let bessel_J1 x = Gsl.Sf.bessel_J1 x

let bessel_Jn n x = Gsl.Sf.bessel_Jn n x

let bessel_Jn_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_Jn_array nmin x y; y

let bessel_Y0 x = Gsl.Sf.bessel_Y0 x

let bessel_Y1 x = Gsl.Sf.bessel_Y1 x

let bessel_Yn n x = Gsl.Sf.bessel_Yn n x

let bessel_Yn_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_Yn_array nmin x y; y

let bessel_I0 x = Gsl.Sf.bessel_I0 x

let bessel_I1 x = Gsl.Sf.bessel_I1 x

let bessel_In n x = Gsl.Sf.bessel_In n x

let bessel_In_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_In_array nmin x y; y

let bessel_K0 x = Gsl.Sf.bessel_K0 x

let bessel_K1 x = Gsl.Sf.bessel_K1 x

let bessel_Kn n x = Gsl.Sf.bessel_Kn n x

let bessel_Kn_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_Kn_array nmin x y; y

let bessel_I0_scaled x = Gsl.Sf.bessel_I0_scaled x

let bessel_I1_scaled x = Gsl.Sf.bessel_I1_scaled x

let bessel_In_scaled n x = Gsl.Sf.bessel_In_scaled n x

let bessel_In_scaled_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_In_scaled_array nmin x y; y

let bessel_K0_scaled x = Gsl.Sf.bessel_K0_scaled x

let bessel_K1_scaled x = Gsl.Sf.bessel_K1_scaled x

let bessel_Kn_scaled n x = Gsl.Sf.bessel_Kn_scaled n x

let bessel_Kn_scaled_array nmin nmax x =
  let y = Array.make (nmax - nmin + 1) 0. in
  Gsl.Sf.bessel_Kn_scaled_array nmin x y; y

let bessel_j0 x = Gsl.Sf.bessel_j0 x

let bessel_j1 x = Gsl.Sf.bessel_j1 x

let bessel_j2 x = Gsl.Sf.bessel_j2 x

let bessel_jl l x = Gsl.Sf.bessel_jl l x

let bessel_jl_array l x =
  let y = Array.make (l + 1) 0. in
  Gsl.Sf.bessel_jl_array l x y; y

let bessel_jl_steed_array l x =
  let y = Array.make (l + 1) 0. in
  Gsl.Sf.bessel_jl_steed_array x y; y

let bessel_y0 x = Gsl.Sf.bessel_y0 x

let bessel_y1 x = Gsl.Sf.bessel_y1 x

let bessel_y2 x = Gsl.Sf.bessel_y2 x

let bessel_yl l x = Gsl.Sf.bessel_yl l x

let bessel_yl_array l x =
  let y = Array.make (l + 1) 0. in
  Gsl.Sf.bessel_yl_array l x y; y

let bessel_i0_scaled x = Gsl.Sf.bessel_i0_scaled x

let bessel_i1_scaled x = Gsl.Sf.bessel_i1_scaled x

let bessel_il_scaled l x = Gsl.Sf.bessel_il_scaled l x

let bessel_il_array_scaled l x =
  let y = Array.make (l + 1) 0. in
  Gsl.Sf.bessel_il_scaled_array l x y; y

let bessel_k0_scaled x = Gsl.Sf.bessel_k0_scaled x

let bessel_k1_scaled x = Gsl.Sf.bessel_k1_scaled x

let bessel_kl_scaled l x = Gsl.Sf.bessel_kl_scaled l x

let bessel_kl_array_scaled l x =
  let y = Array.make (l + 1) 0. in
  Gsl.Sf.bessel_kl_scaled_array l x y; y

let bessel_Jnu nu x = Gsl.Sf.bessel_Jnu nu x

let bessel_Ynu nu x = Gsl.Sf.bessel_Ynu nu x

let bessel_Inu nu x = Gsl.Sf.bessel_Inu nu x

let bessel_Inu_scaled nu x = Gsl.Sf.bessel_Inu_scaled nu x

let bessel_Knu nu x = Gsl.Sf.bessel_Knu nu x

let bessel_lnKnu nu x = Gsl.Sf.bessel_lnKnu nu x

let bessel_Knu_scaled nu x = Gsl.Sf.bessel_Knu_scaled nu x

let bessel_zero_J0 x = Gsl.Sf.bessel_zero_J0 x

let bessel_zero_J1 x = Gsl.Sf.bessel_zero_J1 x

let bessel_zero_Jnu nu x = Gsl.Sf.bessel_zero_Jnu nu x

let clausen x = Gsl.Sf.clausen x

let dawson x = Gsl.Sf.dawson x

let debye_1 x = Gsl.Sf.debye_1 x

let debye_2 x = Gsl.Sf.debye_2 x

let debye_3 x = Gsl.Sf.debye_3 x

let debye_4 x = Gsl.Sf.debye_4 x

let debye_5 x = Gsl.Sf.debye_5 x

let debye_6 x = Gsl.Sf.debye_6 x

let dilog x = Gsl.Sf.dilog x

let ellint_Kcomp x = Gsl.Sf.ellint_Kcomp x Gsl.Fun.DOUBLE

let ellint_Ecomp x = Gsl.Sf.ellint_Ecomp x Gsl.Fun.DOUBLE

let ellint_Pcomp x n = Gsl.Sf.ellint_Pcomp x n Gsl.Fun.DOUBLE

let ellint_Dcomp x = Gsl.Sf.ellint_Dcomp x Gsl.Fun.DOUBLE

let ellint_F phi x =  Gsl.Sf.ellint_F phi x Gsl.Fun.DOUBLE

let ellint_E phi x =  Gsl.Sf.ellint_E phi x Gsl.Fun.DOUBLE

let ellint_P phi x n =  Gsl.Sf.ellint_P phi x n Gsl.Fun.DOUBLE

let ellint_D phi x =  Gsl.Sf.ellint_D phi x Gsl.Fun.DOUBLE

let ellint_RC x y = Gsl.Sf.ellint_RC x y Gsl.Fun.DOUBLE

let ellint_RD x y z = Gsl.Sf.ellint_RD x y z Gsl.Fun.DOUBLE

let ellint_RF x y z = Gsl.Sf.ellint_RF x y z Gsl.Fun.DOUBLE

let ellint_RJ x y z p = Gsl.Sf.ellint_RJ x y z p Gsl.Fun.DOUBLE

let expint_E1 x = Gsl.Sf.expint_E1 x

let expint_E2 x = Gsl.Sf.expint_E2 x

let expint_Ei x = Gsl.Sf.expint_Ei x

let expint_E1_scaled x = Gsl.Sf.expint_E1_scaled x

let expint_E2_scaled x = Gsl.Sf.expint_E2_scaled x

let expint_Ei_scaled x = Gsl.Sf.expint_Ei_scaled x

let expint_3 x = Gsl.Sf.expint_3 x

let shi x = Gsl.Sf.shi x

let chi x = Gsl.Sf.chi x

let si x = Gsl.Sf.si x

let ci x = Gsl.Sf.ci x

let atanint x = Gsl.Sf.atanint x

let fermi_dirac_m1 x = Gsl.Sf.fermi_dirac_m1 x

let fermi_dirac_0 x = Gsl.Sf.fermi_dirac_0 x

let fermi_dirac_1 x = Gsl.Sf.fermi_dirac_1 x

let fermi_dirac_2 x = Gsl.Sf.fermi_dirac_2 x

let fermi_dirac_int j x = Gsl.Sf.fermi_dirac_int j x

let fermi_dirac_mhalf x = Gsl.Sf.fermi_dirac_mhalf x

let fermi_dirac_half x = Gsl.Sf.fermi_dirac_half x

let fermi_dirac_3half x = Gsl.Sf.fermi_dirac_3half x

let fermi_dirac_inc_0 x b = Gsl.Sf.fermi_dirac_inc_0 x b

let gamma x = Gsl.Sf.gamma x

let lngamma x = Gsl.Sf.lngamma x

let gammastar x = Gsl.Sf.gammastar x

let gammainv x = Gsl.Sf.gammainv x

let gamma_inc a x = Gsl.Sf.gamma_inc a x

let gamma_inc_Q a x  = Gsl.Sf.gamma_inc_Q a x

let gamma_inc_P a x  = Gsl.Sf.gamma_inc_P a x

let factorial x = Gsl.Sf.fact x

let double_factorial x = Gsl.Sf.doublefact x

let ln_factorial x = Gsl.Sf.lnfact x

let ln_double_factorial x = Gsl.Sf.lndoublefact x

let combination n x = int_of_float (Gsl.Sf.choose n x)

let ln_combination n x = Gsl.Sf.lnchoose n x

let taylorcoeff n x = Gsl.Sf.taylorcoeff n x

let poch a x = Gsl.Sf.poch a x

let lnpoch a x = Gsl.Sf.lnpoch a x

let pochrel a x = Gsl.Sf.pochrel a x

let betaf x y = Gsl.Sf.beta x y

let lnbeta x y = Gsl.Sf.lnbeta x y

let beta_inc a b x = Gsl.Sf.beta_inc a b x

let laguerre_1 a x = Gsl.Sf.laguerre_1 a x

let laguerre_2 a x = Gsl.Sf.laguerre_2 a x

let laguerre_3 a x = Gsl.Sf.laguerre_3 a x

let laguerre_n n a x = Gsl.Sf.laguerre_n n a x

let lambert_w0 x = Gsl.Sf.lambert_W0 x

let lambert_w1 x = Gsl.Sf.lambert_Wm1 x

let legendre_P1 x = Gsl.Sf.legendre_P1 x

let legendre_P2 x = Gsl.Sf.legendre_P2 x

let legendre_P3 x = Gsl.Sf.legendre_P3 x

let legendre_Pl l x = Gsl.Sf.legendre_Pl l x

let legendre_Pl_array l x =
  let y = Array.make l 0. in
  Gsl.Sf.legendre_Pl_array x y; y

let legendre_Q0 x = Gsl.Sf.legendre_Q0 x

let legendre_Q1 x = Gsl.Sf.legendre_Q1 x

let legendre_Ql l x = Gsl.Sf.legendre_Ql l x

let psi x = Gsl.Sf.psi x

let psi_int n = Gsl.Sf.psi_int n

let psi_1 x = Gsl.Sf.psi_1 x

let psi_1piy n = Gsl.Sf.psi_1piy n

let psi_1_pint n = Gsl.Sf.psi_int n

let psi_n n x = Gsl.Sf.psi_n n x

let synchrotron_1 x = Gsl.Sf.synchrotron_1 x

let synchrotron_2 x = Gsl.Sf.synchrotron_2 x

let transport_2 x = Gsl.Sf.transport_2 x

let transport_3 x = Gsl.Sf.transport_3 x

let transport_4 x = Gsl.Sf.transport_4 x

let transport_5 x = Gsl.Sf.transport_5 x

let zeta x = Gsl.Sf.zeta x

let zeta_int x = Gsl.Sf.zeta_int x

let hzeta x y = Gsl.Sf.hzeta x y

let eta x = Gsl.Sf.eta x

let eta_int x = Gsl.Sf.eta_int x

let permutation n k =
  let r = ref 1 in
  for i = 0 to k - 1 do
    r := !r * (n - i)
  done;
  !r

let combination_iterator n k =
  let c = combination n k in
  let x = Gsl.Combi.make n k in
  let i = ref 0 in
  let f = fun () -> (
    let y = match !i < c with
      | true  -> Gsl.Combi.to_array x
      | false -> [||]
    in
    let _ = Gsl.Combi.next x in
    let _ = i := !i + 1 in
    y )
  in f

let permutation_iterator n =
  let c = permutation n n in
  let x = Gsl.Permut.make n in
  let i = ref 0 in
  let f = fun () -> (
    let y = match !i < c with
      | true  -> Gsl.Permut.to_array x
      | false -> [||]
    in
    let _ = Gsl.Permut.next x in
    let _ = i := !i + 1 in
    y )
  in f


(* ends here *)
