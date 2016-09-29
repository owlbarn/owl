(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type dsmat = Dense.dsmat

val inv : dsmat -> dsmat

val det : dsmat -> float

val qr : dsmat -> dsmat * dsmat

val qr : dsmat -> dsmat * dsmat

val qr_sqsolve : dsmat -> dsmat -> dsmat

val qr_lssolve : dsmat -> dsmat -> dsmat * dsmat

val svd : dsmat -> dsmat * dsmat * dsmat

val cholesky : dsmat -> dsmat

val is_posdef : dsmat -> bool

val symmtd : dsmat -> dsmat * dsmat * dsmat

val bidiag : dsmat -> dsmat * dsmat * dsmat * dsmat

val tridiag_solve : dsmat -> dsmat -> dsmat

val symm_tridiag_solve : dsmat -> dsmat -> dsmat

(* TODO: lu decomposition *)
