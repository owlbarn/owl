#!/usr/bin/env owl
#require "owl-plplot"

(* let data = [|
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
|] *)

let read_data () = 
  let inch = Scanf.Scanning.open_in "logs/perfcomp.log" in
  let data = 
    let rec read_parse_line acc = 
      try
        read_parse_line (Scanf.bscanf inch 
          "eps = %f, del = %f, phi = %f, lws_cm = %d, avg_diff = %f, median_diff = %f, avg_l1_diff = %f\n" 
          (fun _ _ phi lws avg med l1 -> [|(float_of_int lws);avg;med;l1;phi|] :: acc))
      with
      _ -> acc
    in Array.of_list (read_parse_line [])
  in
  Owl.Mat.of_arrays data

let mat_to_vars data =
  let memusage = Owl.Mat.col data 0 in
  let avgdiffs = Owl.Mat.col data 1 in
  let meddiffs = Owl.Mat.col data 2 in
  let l1_diffs = Owl.Mat.col data 3 in
  memusage, avgdiffs, meddiffs, l1_diffs

let filter_nozero data =
  Owl.Mat.rows data 
    (Owl.Mat.filter_rows (Owl.Mat.not_exists (fun x -> x = 0.)) data)

let make_plot data h title r g b =
  let open Owl_plplot.Plot in
  let memusage, avgdiffs, meddiffs, l1_diffs = data |> mat_to_vars in
  let memusage', avgdiffs', meddiffs', l1_diffs' = 
    data |> filter_nozero |> Owl.Mat.map (Owl.Maths.log10) |> mat_to_vars in
  set_background_color h 255 255 255;
  set_title h title;
  subplot h 0 0; set_foreground_color h 0 0 0;
  set_xlabel h "heap words";
  set_ylabel h "mean relative diff";
  scatter ~h ~spec:[Marker "x"; MarkerSize 3.; RGB (r,g,b)] memusage avgdiffs;
  subplot h 1 0; set_foreground_color h 0 0 0;
  set_xlabel h "log(heap words)";
  set_ylabel h "log(mean relative diff)";
  scatter ~h ~spec:[Marker "x"; MarkerSize 3.; RGB (r,g,b)] memusage' avgdiffs';
  subplot h 0 1; set_foreground_color h 0 0 0;
  set_xlabel h "heap words";
  set_ylabel h "median relative diff";
  scatter ~h ~spec:[Marker "x"; MarkerSize 3.; RGB (r,g,b)] memusage meddiffs;
  subplot h 1 1; set_foreground_color h 0 0 0;
  set_xlabel h "log(heap words)";
  set_ylabel h "log(median relative diff)";
  scatter ~h ~spec:[Marker "x"; MarkerSize 3.; RGB (r,g,b)] memusage' meddiffs';
  subplot h 0 2; set_foreground_color h 0 0 0;
  set_xlabel h "heap words";
  set_ylabel h "mean L1 diff";
  scatter ~h~spec:[Marker "x"; MarkerSize 3.; RGB (r,g,b)] memusage l1_diffs;
  subplot h 1 2; set_foreground_color h 0 0 0;
  set_xlabel h "log(heap words)";
  set_ylabel h "log(mean L1 diff)";
  scatter ~h ~spec:[Marker "x"; MarkerSize 3.; RGB (r,g,b)] memusage' l1_diffs'


let plot_tradeoffs () =
  let open Owl_plplot.Plot in
  let data = read_data () in
  let h = Owl_plplot.Plot.create ~m:2 ~n:3 ("plots/tradeoff_moredels.pdf") in
  make_plot data h "all" 255 0 0; output h

let data_by_phis data phis =
  let mapfn phi =
    let ridxs = Owl.Mat.filter_rows (fun r -> Owl.Mat.get r 0 4 = phi) data in
    phi, Owl.Mat.rows data ridxs
  in
  List.map mapfn phis

let plot_by_phis phis rgbs =
  let open Owl_plplot.Plot in
  let data = data_by_phis (read_data ()) phis in
  let h = create ~m:2 ~n:3 ("plots/tradeoff_by_phis.pdf") in
  let iterfn i (phi, phidata) = 
    make_plot phidata h "" rgbs.(i).(0) rgbs.(i).(1) rgbs.(i).(2)
  in
  List.iteri iterfn data; 
  let legend_text = phis |> List.map (fun f -> "phi = " ^ (string_of_float f)) |> Array.of_list in
  subplot h 0 2;
  set_foreground_color h 0 0 0;
  legend_on h ~position:NorthEast legend_text;
  output h 

let rgbs = 
  [|[|255;  0;  0|];
    [|  0;255;  0|];
    [|  0;  0;255|];
    [|255;  0;255|];
    [|255;255;  0|];
    [|  0;255;255|];
    [|  0;  0;  0|]|] 

let _ = plot_tradeoffs ()

let _ = plot_by_phis [0.05; 0.01; 0.005; 0.001] rgbs