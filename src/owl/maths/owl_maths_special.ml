(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module CI = Cstubs_internals


(* Airy functions *)

external airy : float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int = "stub_sf_airy"

let airy x ai aip bi bip = airy x (CI.cptr ai) (CI.cptr aip) (CI.cptr bi) (CI.cptr bip)


(* Elliptic Functions *)

external ellipj : float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int = "stub_sf_ellipj_byte6" "stub_sf_ellipj"

let ellipj u m sn cn dn phi = ellipj u m (CI.cptr sn) (CI.cptr cn) (CI.cptr dn) (CI.cptr phi)

external ellipk : float -> float = "owl_stub_sf_ellipk"

external ellipkm1 : float -> float = "owl_stub_sf_ellipkm1"

external ellipkinc : float -> float -> float = "owl_stub_sf_ellipkinc"

external ellipe : float -> float = "owl_stub_sf_ellipe"

external ellipeinc : float -> float -> float = "owl_stub_sf_ellipeinc"


(* Bessel functions *)

external j0 : float -> float = "owl_stub_sf_j0"

external j1 : float -> float = "owl_stub_sf_j1"

external jv : float -> float -> float = "owl_stub_sf_jv"

external y0 : float -> float = "owl_stub_sf_y0"

external y1 : float -> float = "owl_stub_sf_y1"

external yv : float -> float -> float = "owl_stub_sf_yv"

external yn : int -> float -> float = "owl_stub_sf_yn"

external i0 : float -> float = "owl_stub_sf_i0"

external i0e : float -> float = "owl_stub_sf_i0e"

external i1 : float -> float = "owl_stub_sf_i1"

external i1e : float -> float = "owl_stub_sf_i1e"

external iv : float -> float -> float = "owl_stub_sf_iv"

external k0 : float -> float = "owl_stub_sf_k0"

external k0e : float -> float = "owl_stub_sf_k0e"

external k1 : float -> float = "owl_stub_sf_k1"

external k1e : float -> float = "owl_stub_sf_k1e"


(* Gamma functions *)

external gamma : float -> float = "owl_stub_sf_gamma"

external rgamma : float -> float = "owl_stub_sf_rgamma"

external loggamma : float -> float = "owl_stub_sf_loggamma"

external gammainc : float -> float -> float = "owl_stub_sf_gammainc"

external gammaincinv : float -> float -> float = "owl_stub_sf_gammaincinv"

external gammaincc : float -> float -> float = "owl_stub_sf_gammaincc"

external gammainccinv : float -> float -> float = "owl_stub_sf_gammainccinv"

external psi : float -> float = "owl_stub_sf_psi"


(* Beta functions *)

external beta : float -> float -> float = "owl_stub_sf_beta"

external betainc : float -> float -> float -> float = "owl_stub_sf_betainc"

external betaincinv : float -> float -> float -> float = "owl_stub_sf_betaincinv"


(* Error Function and Fresnel Integrals *)

external erf : float -> float = "owl_stub_sf_erf"

external erfc : float -> float = "owl_stub_sf_erfc"

external erfcx : float -> float = "owl_stub_sf_erfcx"

external erfinv : float -> float = "owl_stub_sf_erfinv"

external erfcinv : float -> float = "owl_stub_sf_erfcinv"

external dawsn : float -> float = "owl_stub_sf_dawsn"

external fresnel : float -> _ CI.fatptr -> _ CI.fatptr -> int = "owl_stub_sf_fresnel"

let fresnel x ssa csa = fresnel x (CI.cptr ssa) (CI.cptr csa)


(* Other functions *)

external expn : int -> float -> float = "owl_stub_sf_expn"

external shichi : float -> _ CI.fatptr -> _ CI.fatptr -> int = "owl_stub_sf_shichi"

let shichi x si ci = shichi x (CI.cptr si) (CI.cptr ci)

external sici : float -> _ CI.fatptr -> _ CI.fatptr -> int = "owl_stub_sf_sici"

let sici x si ci = sici x (CI.cptr si) (CI.cptr ci)

external zeta : float -> float -> float = "owl_stub_sf_zeta"

external zetac : float -> float = "owl_stub_sf_zetac"

external struve : float -> float -> float = "owl_stub_sf_struve"


(* From owl_maths_special_impl.c file *)

external asinh : float -> float = "owl_stub_sf_asinh"

external acosh : float -> float = "owl_stub_sf_acosh"

external atanh : float -> float = "owl_stub_sf_atanh"

external hypot : float -> float -> float = "owl_stub_sf_hypot"

external xlogy : float -> float -> float = "owl_stub_sf_xlogy"

external xlog1py : float -> float -> float = "owl_stub_sf_xlog1py"

external logit : float -> float = "owl_stub_sf_logit"

external expit : float -> float = "owl_stub_sf_expit"

external logabs : float -> float = "owl_stub_sf_logabs"

external sinc : float -> float = "owl_stub_sf_sinc"

external sindg : float -> float = "owl_stub_sf_sindg"

external cosdg : float -> float = "owl_stub_sf_cosdg"

external tandg : float -> float = "owl_stub_sf_tandg"

external cotdg : float -> float = "owl_stub_sf_cotdg"


(* Raw statistical functions *)

external bdtr : int -> int -> float -> float = "owl_stub_sf_bdtr"

external bdtrc : int -> int -> float -> float = "owl_stub_sf_bdtrc"

external bdtri : int -> int -> float -> float = "owl_stub_sf_bdtri"

external btdtr : float -> float -> float -> float = "owl_stub_sf_btdtr"

external btdtri : float -> float -> float -> float = "owl_stub_sf_btdtri"


(* Factorial functions *)

external fact : int -> float = "owl_stub_sf_fact"

external log_fact : int -> float = "owl_stub_sf_log_fact"

external doublefact : int -> float = "owl_stub_sf_doublefact"

external log_doublefact : int -> float = "owl_stub_sf_log_doublefact"

external combination : int -> int -> float = "owl_stub_sf_combination"

external log_combination : int -> int -> float = "owl_stub_sf_log_combination"


(* Other functions *)

external nextafter : float -> float -> float = "stub_sf_nextafter"

external nextafterf : float -> float -> float = "stub_sf_nextafterf"
