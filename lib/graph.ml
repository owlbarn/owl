(** [ Graphical Module ]  *)

open Plplot

module MX = Matrix.Dense

let plot x y =
  let x = MX.to_array x in
  let y = MX.to_array y in
  let _ = plinit () in
  let xmin, xmax = Stats.minmax x in
  let ymin, ymax = Stats.minmax y in
  let _ = plenv xmin xmax ymin ymax 0 0 in
  let _ = plline x y in
  plend ()

let plot_fun f a b =
  let x = MX.linspace a b 100 in
  let y = MX.map f x in
  plot x y

let scatter ?(marker='+') x y =
  let x = MX.to_array x in
  let y = MX.to_array y in
  let _ = plinit () in
  let xmin, xmax = Stats.minmax x in
  let ymin, ymax = Stats.minmax y in
  let _ = plenv xmin xmax ymin ymax 0 0 in
  let _ = pllab "x" "y" "scatter ploat" in
  let _ = plpoin x y 2 in (* TODO: + is 2; x is 5 *)
  plend ()

let histogram ?(bin=10) x =
  let open Plplot in
  let x = MX.to_array x in
  let _ = plinit () in
  let xmin, xmax = Stats.minmax x in
  let _ = plhist x xmin xmax bin [ PL_HIST_DEFAULT ] in
  plend ()

let mesh x y z =
  let open Plplot in
  None
