(** Owl - Experimental *)

let add x y = x +. y

let sub x y = x -. y

let mul x y = x *. y

let div x y = x /. y

let pow x y = x ** y

let atan2 x y = Pervasives.atan2 x y

let abs x = Pervasives.abs_float x

let neg x = ~-. x

let sqr x = x *. x

let sqrt x = Pervasives.sqrt x

let exp x = Pervasives.exp x

let log x = Pervasives.log x

let log2 x = (log x) /. (log 2.)

let log10 x = Pervasives.log10 x

let signum x =
  if ((compare x nan) = 0)
  then nan
  else (
    if (x > 0.)
    then 1.
    else (if x < 0. then (~-. 1.) else 0.)
  )

let floor x = Pervasives.floor x

let ceil x = Pervasives.ceil x

let round x = floor (x +. 0.5)

let trunc x = Pervasives.float_of_int (Pervasives.truncate x)

let sin x = Pervasives.sin x

let cos x = Pervasives.cos x

let tan x = Pervasives.tan x

let sinh x = Pervasives.sinh x

let cosh x = Pervasives.cosh x

let tanh x = Pervasives.tanh x

let asin x = Pervasives.asin x

let acos x = Pervasives.acos x

let atan x = Pervasives.atan x

(* asinh(x) is log(x + sqrt(x * x + 1)) *)
let asinh x = log (x +. (sqrt ((x *. x) +. 1.)))

(* acosh(x) is log(x + sqrt(x * x - 1)) *)
let acosh x = log (x +. (sqrt ((x *. x) -. 1.)))

(* atanh(x) is 1/2 * log((1 + x)/(1-x))) *)
let atanh x = 0.5 *. (log ((1. +. x) /. (1. -. x)))

let relu x = Pervasives.max 0. x

let sigmoid x = 1. /. (1. +. (log (~-. x)) )




let is_odd x = ((Pervasives.abs x) mod 2) = 1

let is_even x = (x mod 2) = 0

let is_pow2 x = (x <> 0) && (x land (x - 1) = 0)

let same_sign x y =
  if x >= 0. && y >= 0. then true
  else if x <= 0. && y <= 0. then true
  else false
