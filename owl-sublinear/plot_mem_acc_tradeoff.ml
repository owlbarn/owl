#!/usr/bin/env owl
#require "owl-plplot"

let data = [|
  [|707.;107809.248081;66787.5;0.004810|];
  [|7007.;5203.475383;3012.;0.000232|];
  [|70007.;99.00525;43.5;0.000004|];
  (* [|700056.;0.276585;0.;0. |]; *)
  [|1010.;101611.422874;62886.;0.004533|];
  [|10010.;4680.630373;2739.;0.000209|];
  [|100010.;75.603136;35.;0.000003|];
  (* [|1000077.;0.113316;0.;0. |]; *)
  [|1414.;97371.892224;60515.;0.004344|];
  [|14014.;4224.767875;2501.;0.000188|];
  [|140014.;59.931154;29.0;0.000003|]
  (* [|1400105.;0.0447;0.;0. |] *)
|]
let memusage = Owl.Mat.init (Array.length data) 1 (fun i -> data.(i).(0))
let avgdiffs = Owl.Mat.init (Array.length data) 1 (fun i -> data.(i).(1))
let meddiffs = Owl.Mat.init (Array.length data) 1 (fun i -> data.(i).(2))
let l1_diffs = Owl.Mat.init (Array.length data) 1 (fun i -> data.(i).(3))

let _ =
  let open Owl_plplot.Plot in
  let h = create ~m:2 ~n:3 "plots/tradeoff.png" in
  set_background_color h 255 255 255;
  subplot h 0 0; set_foreground_color h 0 0 0;
  set_xlabel h "heap words";
  set_ylabel h "mean relative diff";
  scatter ~h ~spec:[Marker "x"; MarkerSize 3.; RGB (255,0,0)] memusage avgdiffs;
  subplot h 1 0; set_foreground_color h 0 0 0;
  set_xlabel h "heap words (log scale)";
  set_ylabel h "mean relative diff (log scale)";
  loglog ~h ~spec:[LineWidth 0.00000001; Marker "x"; MarkerSize 3.; RGB (255,0,0)] ~x:memusage avgdiffs;
  subplot h 0 1; set_foreground_color h 0 0 0;
  set_xlabel h "heap words";
  set_ylabel h "median relative diff";
  scatter ~h ~spec:[Marker "x"; MarkerSize 3.; RGB (255,0,0)] memusage meddiffs;
  subplot h 1 1; set_foreground_color h 0 0 0;
  set_xlabel h "heap words (log scale)";
  set_ylabel h "median relative diff (log scale)";
  loglog ~h ~spec:[LineWidth 0.00000001; Marker "x"; MarkerSize 3.; RGB (255,0,0)] ~x:memusage meddiffs;
  subplot h 0 2; set_foreground_color h 0 0 0;
  set_xlabel h "heap words";
  set_ylabel h "mean L1 diff";
  scatter ~h~spec:[Marker "x"; MarkerSize 3.; RGB (255,0,0)] memusage l1_diffs;
  subplot h 1 2; set_foreground_color h 0 0 0;
  set_xlabel h "heap words (log scale)";
  set_ylabel h "mean L1 diff (log scale)";
  loglog ~h ~spec:[LineWidth 0.00000001; Marker "x"; MarkerSize 3.; RGB (255,0,0)] ~x:memusage l1_diffs;
  output h

