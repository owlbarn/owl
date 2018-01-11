(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

external j0 : float -> float = "owl_stub_sf_j0"


(* Gamma functions *)

external gamma : float -> float = "owl_stub_sf_gamma"

external loggamma : float -> float = "owl_stub_sf_loggamma"

external gammainc : float -> float -> float = "owl_stub_sf_gammainc"

external gammaincinv : float -> float -> float = "owl_stub_sf_gammaincinv"

external gammaincc : float -> float -> float = "owl_stub_sf_gammaincc"

external gammainccinv : float -> float -> float = "owl_stub_sf_gammainccinv"

(* Beta functions *)

external beta : float -> float -> float = "owl_stub_sf_beta"

external betainc : float -> float -> float -> float = "owl_stub_sf_betainc"

external betaincinv : float -> float -> float -> float = "owl_stub_sf_betaincinv"


external psi : float -> float = "owl_stub_sf_psi"
