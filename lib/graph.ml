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
  let x = MX.to_array x in
  let y = MX.to_array y in
  let xmin, xmax = Stats.minmax x in
  let ymin, ymax = Stats.minmax y in
  let zmin, zmax, _, _, _, _ = MX.minmax z in
  let _ = plinit () in
  let _ = pladv 0 in
  let _ = plcol0 1 in
  let _ = plvpor 0.0 1.0 0.0 1.0 in
  let _ = plwind (-1.0) 1.0 (-1.0) 1.5 in
  let _ = plw3d 1.0 1.0 1.0 xmin xmax ymin ymax zmin zmax 33. 115. in
  let _ = plbox3  "bnstu", "x axis", 0.0, 0,
                  "bnstu", "y axis", 0.0, 0,
                  "bcdmnstuv", "z axis", 0.0, 4 in
  let _ = plcol0 2 in
  let z = MX.to_arrays z in
  let _ = plmesh x y z [ PL_DRAW_LINEXY; PL_MAG_COLOR; PL_MESH ] in
  let _ = plcol0 3 in
  plend ()
