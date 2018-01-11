(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

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
