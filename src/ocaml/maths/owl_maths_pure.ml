(* asinh(x) is log(x + sqrt(x * x + 1)) TODO: check this is precise enough*)
let asinh =
  (fun x -> (Pervasives.log (x +. (Pervasives.sqrt ((x *. x) +. 1.)))))

(* acosh(x) is log(x + sqrt(x * x - 1)) TODO: check this is precise enough*)
let acosh =
  (fun x -> (Pervasives.log (x +. (Pervasives.sqrt ((x *. x) -. 1.)))))

(* atanh(x) is 1/2 * log((1 + x)/(1-x)))TODO: check this is precise enough*)
let atanh =
  (fun x -> (0.5 *. (Pervasives.log ((1. +. x) /. (1. -. x)))))

let sigmoid = (fun x -> (1. /. (1. +. (Pervasives.log (~-. x)) ) ))

let log2 = (fun x -> ((Pervasives.log x) /. (Pervasives.log 2.)))

let sqr = (fun x -> x *. x)

let round = (fun x -> (Pervasives.floor (x +. 0.5)))

let signum =
  (fun x ->
     if ((compare x nan) = 0)
     then nan
     else (
       if (x > 0.)
       then 1.
       else (
         if x < 0.
         then (~-. 1.)
         else 0.
       )
     )
  )

let relu = (fun x -> Pervasives.max 0. x)
