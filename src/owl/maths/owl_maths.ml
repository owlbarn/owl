(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module CI = Cstubs_internals


(** Basic and advanced math functions *)

let add = ( +. )

let sub = ( -. )

let mul = ( *. )

let div = ( /. )

let atan2 = Pervasives.atan2


let abs x = abs_float x

let neg x = 0. -. x

let reci x = 1. /. x

let signum x = if x = 0. then 0. else if x > 0. then 1. else -1.

let softsign x = x /. (1. +. abs x)

let softplus x = log (1. +. exp x)

let relu x = max 0. x

let floor x = floor x

let ceil x = ceil x

let round_lb = -.(2. ** 52.)
let round_ub = 2. ** 52.
let round t =
  if t >= round_lb && t <= round_ub then
    floor (t +. 0.49999999999999994)
  else t

let trunc x = modf x |> snd

let sqr x = x *. x

let sqrt x = sqrt x

let pow x y = x ** y

let exp x = exp x

let expm1 x = expm1 x

let log x = log x

let log1p x = log1p x

let log2 x = (log x) /. Owl_const.loge2

let log10 x = (log x) /. Owl_const.loge10

let logn base x = (log x) /. (log base)

let logabs x = Owl_maths_special.logabs x

let sigmoid x = 1. /. ((exp (-.x)) +. 1.)

let sin x = sin x

let cos x = cos x

let tan x = tan x

let cot x = 1. /. (tan x)

let sec x = 1. /. (cos x)

let csc x = 1. /. (sin x)

let asin x = asin x

let acos x = acos x

let atan x = atan x

let acot x = (Owl_const.pi /. 2.) -. (atan x)

let asec x = acos (1. /. x)

let acsc x = asin (1. /. x)

let sinc x = Owl_maths_special.sinc x

let sinh x = sinh x

let cosh x = cosh x

let tanh x = tanh x

let coth x = let a = exp (-2. *. x) in (1. +. a) /. (1. -. a)

let sech x = 1. /. cosh x

let csch x = 1. /. sinh x

let asinh x = Owl_maths_special.asinh x

let acosh x = Owl_maths_special.acosh x

let atanh x = Owl_maths_special.atanh x

let acoth x = atanh (1. /. x)

let asech x = acosh (1. /. x)

let acsch x = asinh (1. /. x)

let logsinh x = log (sinh x)

let logcosh x = log (cosh x)

let sindg x = Owl_maths_special.sindg x

let cosdg x = Owl_maths_special.cosdg x

let tandg x = Owl_maths_special.tandg x

let cotdg x = Owl_maths_special.cotdg x

let hypot x y = Owl_maths_special.hypot x y

let xlogy x y = Owl_maths_special.xlogy x y

let xlog1py x y = Owl_maths_special.xlog1py x y

let logit x = Owl_maths_special.logit x

let expit x = Owl_maths_special.expit x

let airy x =
  let ai = Ctypes.(allocate double 0.) in
  let aip = Ctypes.(allocate double 0.) in
  let bi = Ctypes.(allocate double 0.) in
  let bip = Ctypes.(allocate double 0.) in
  (* TODO: unify exception handling ... *)
  Owl_maths_special.airy x ai aip bi bip |> ignore;
  Ctypes.(!@ai, !@aip, !@bi, !@bip)

let ellipj u m =
  let sn = Ctypes.(allocate double 0.) in
  let cn = Ctypes.(allocate double 0.) in
  let dn = Ctypes.(allocate double 0.) in
  let ph = Ctypes.(allocate double 0.) in
  Owl_maths_special.ellipj u m sn cn dn ph |> ignore;
  Ctypes.(!@sn, !@cn, !@dn, !@ph)

let ellipk m = Owl_maths_special.ellipk m

let ellipkm1 m = Owl_maths_special.ellipkm1 m

let ellipkinc phi m = Owl_maths_special.ellipkinc phi m

let ellipe m = Owl_maths_special.ellipe m

let ellipeinc phi m = Owl_maths_special.ellipeinc phi m

let j0 x = Owl_maths_special.j0 x

let j1 x = Owl_maths_special.j1 x

let jv v x = Owl_maths_special.jv v x

let y0 x = Owl_maths_special.y0 x

let y1 x = Owl_maths_special.y1 x

let yv v x = Owl_maths_special.yv v x

let yn n x = Owl_maths_special.yn n x

let i0 x = Owl_maths_special.i0 x

let i0e x = Owl_maths_special.i0e x

let i1 x = Owl_maths_special.i1 x

let i1e x = Owl_maths_special.i1e x

let iv v x = Owl_maths_special.iv v x

let k0 x = Owl_maths_special.k0 x

let k0e x = Owl_maths_special.k0e x

let k1 x = Owl_maths_special.k1 x

let k1e x = Owl_maths_special.k1e x

let expn n x = Owl_maths_special.expn n x

let shichi x =
  let si = Ctypes.(allocate double 0.) in
  let ci = Ctypes.(allocate double 0.) in
  Owl_maths_special.shichi x si ci |> ignore;
  Ctypes.(!@si, !@ci)

let shi x = shichi x |> fst

let chi x = shichi x |> snd

let sici x =
  let si = Ctypes.(allocate double 0.) in
  let ci = Ctypes.(allocate double 0.) in
  Owl_maths_special.sici x si ci |> ignore;
  Ctypes.(!@si, !@ci)

let si x = sici x |> fst

let ci x = sici x |> snd

let gamma x = Owl_maths_special.gamma x

let rgamma x = Owl_maths_special.rgamma x

let loggamma x = Owl_maths_special.loggamma x

let gammainc a x = Owl_maths_special.gammainc a x

let gammaincinv a x = Owl_maths_special.gammaincinv a x

let gammaincc a x = Owl_maths_special.gammaincc a x

let gammainccinv a x = Owl_maths_special.gammainccinv a x

let psi x = Owl_maths_special.psi x

let fact x =
  assert (x >= 0);
  Owl_maths_special.fact x

let log_fact x =
  assert (x >= 0);
  Owl_maths_special.log_fact x

let doublefact x =
  assert (x >= 0);
  Owl_maths_special.doublefact x

let log_doublefact x =
  assert (x >= 0);
  Owl_maths_special.log_doublefact x

let beta a b = Owl_maths_special.beta a b

let betainc a b x = Owl_maths_special.betainc a b x

let betaincinv a b y = Owl_maths_special.betaincinv a b y

let zeta x q = Owl_maths_special.zeta x q

let zetac x = Owl_maths_special.zetac x

let combination_float n k = Owl_maths_special.combination n k |> trunc

let combination n k = combination_float n k |> int_of_float

let log_combination n k = Owl_maths_special.log_combination n k

let permutation_float n k =
  let r = ref 1. in
  for i = 0 to k - 1 do
    r := !r *. float_of_int (n - i)
  done;
  !r |> trunc

let permutation n k = permutation_float n k |> int_of_float

let erf x = Owl_maths_special.erf x

let erfc x = Owl_maths_special.erfc x

let erfcx x = Owl_maths_special.erfcx x

let erfinv x = Owl_maths_special.erfinv x

let erfcinv x = Owl_maths_special.erfcinv x

let dawsn x = Owl_maths_special.dawsn x

let fresnel x =
  let ssa = Ctypes.(allocate double 0.) in
  let csa = Ctypes.(allocate double 0.) in
  Owl_maths_special.fresnel x ssa csa |> ignore;
  Ctypes.(!@ssa, !@csa)

let struve v x = Owl_maths_special.struve v x

let same_sign = Owl_base_maths.same_sign

let is_simplex = Owl_base_maths.is_simplex

let is_nan = Owl_base_maths.is_nan

let is_inf = Owl_base_maths.is_inf

let is_odd = Owl_base_maths.is_odd

let is_even = Owl_base_maths.is_even

let is_pow2 = Owl_base_maths.is_pow2

let nextafter = Owl_maths_special.nextafter

let nextafterf = Owl_maths_special.nextafterf

let bdtr k n p = Owl_maths_special.bdtr k n p

let bdtrc k n p = Owl_maths_special.bdtrc k n p

let bdtri k n y = Owl_maths_special.bdtri k n y

let btdtr a b x = Owl_maths_special.btdtr a b x

let btdtri a b p = Owl_maths_special.btdtri a b p



(* ends here *)
