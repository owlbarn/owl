

let inv x =
  let open Gsl.Vectmat in
  let y = Gsl.Linalg.invert_LU (`M x) in
  match y with `M y -> y 
