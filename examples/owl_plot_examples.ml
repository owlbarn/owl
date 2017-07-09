open Owl;;

let f x = Maths.sin x /. x in
let h = Plot.create "plot01.pdf" in
Plot.set_foreground_color h 0 0 0;
Plot.set_background_color h 255 255 255;
Plot.set_title h "Function: f(x) = sine x / x";
Plot.set_xlabel h "x-axis";
Plot.set_ylabel h "y-axis";
Plot.set_font_size h 8.;
Plot.set_pen_size h 3.;
Plot.plot_fun ~h f 1. 15.;
Plot.output h;;



let f p i = match i with
  | 0 -> Stats.Rnd.gaussian ~sigma:0.5 () +. p.(1)
  | _ -> Stats.Rnd.gaussian ~sigma:0.1 () *. p.(0)
in
let y = Stats.gibbs_sampling f [|0.1;0.1|] 5_000 |> Mat.of_arrays in
let h = Plot.create ~m:2 ~n:2 "plot02.pdf" in
Plot.set_background_color h 255 255 255;
(* focus on the subplot at 0,0 *)
Plot.subplot h 0 0;
Plot.set_title h "Bivariate model";
Plot.scatter ~h (Mat.col y 0) (Mat.col y 1);
(* focus on the subplot at 0,1 *)
Plot.subplot h 0 1;
Plot.set_title h "Distribution of y";
Plot.set_xlabel h "y";
Plot.set_ylabel h "Frequency";
Plot.histogram ~h ~bin:50 (Mat.col y 1);
(* focus on the subplot at 1,0 *)
Plot.subplot h 1 0;
Plot.set_title h "Distribution of x";
Plot.set_ylabel h "Frequency";
Plot.histogram ~h ~bin:50 (Mat.col y 0);
(* focus on the subplot at 1,1 *)
Plot.subplot h 1 1;
Plot.set_foreground_color h 0 50 255;
Plot.set_title h "Sine function";
Plot.(plot_fun ~h ~spec:[ LineStyle 2 ] Maths.sin 0. 28.);
Plot.autocorr ~h (Mat.sequential 1 28);
(* output your final plot *)
Plot.output h;;


let h = Plot.create "plot03.pdf" in
Plot.(plot_fun ~h ~spec:[ RGB (0,0,255); Marker "#[0x2299]"; MarkerSize 8. ] Maths.sin 0. 9.);
Plot.(plot_fun ~h ~spec:[ RGB (255,0,0); Marker "#[0x0394]"; MarkerSize 8. ] Maths.cos 0. 9.);
Plot.legend_on h [|"Sine function"; "Cosine function"|];
Plot.output h;;


(* generate data *)
let f p = Stats.Pdf.gaussian p.(0) 0.5 in
let g x = Stats.Pdf.gaussian x 0.5 *. 4000. in
let y = Stats.metropolis_hastings f [|0.1|] 100_000 |>  Mat.of_arrays in
(* plot multiple data sets *)
let h = Plot.create "plot04.pdf" in
Plot.set_background_color h 255 255 255;
Plot.(histogram ~h ~spec:[ RGB (255,0,50) ] ~bin:100 y);
Plot.(plot_fun ~h ~spec:[ RGB (0,0,255); LineWidth 2. ] g (-2.) 2.);
Plot.legend_on h [|"data"; "model"|];
Plot.output h;;


type legend_position =
  North | South | West | East | NorthWest | NorthEast | SouthWest | SouthEast;;


(* generate data *)
let x = Mat.(uniform 1 20 *$ 10.) in
let y = Mat.(uniform 1 20) in
let z = Mat.gaussian 1 20 in
(* plot multiple data sets *)
let h = Plot.create "plot05.pdf" in
Plot.(plot_fun ~h ~spec:[ RGB (0,0,255); LineStyle 1; Marker "*" ] Maths.sin 1. 8.);
Plot.(plot_fun ~h ~spec:[ RGB (0,255,0); LineStyle 2; Marker "+" ] Maths.cos 1. 8.);
Plot.scatter ~h x y;
Plot.stem ~h x z;
let u = Mat.(abs(gaussian 1 10 *$ 0.3)) in
Plot.(bar ~h ~spec:[ RGB (255,255,0); FillPattern 3 ] u);
let v = Mat.(neg u *$ 0.3) in
let u = Mat.sequential 1 10 in
Plot.(area ~h ~spec:[ RGB (0,255,0); FillPattern 4 ] u v);
(* set up legend *)
Plot.(legend_on h ~position:NorthEast [|"test 1"; "test 2"; "scatter"; "stem"; "bar"; "area"|]);
Plot.output h;;


let h = Plot.create "plot06.pdf" in
Plot.set_background_color h 255 255 255;
Plot.set_pen_size h 2.;
Plot.(draw_line ~h ~spec:[ LineStyle 1 ] 1. 1. 9. 1.);
Plot.(draw_line ~h ~spec:[ LineStyle 2 ] 1. 2. 9. 2.);
Plot.(draw_line ~h ~spec:[ LineStyle 3 ] 1. 3. 9. 3.);
Plot.(draw_line ~h ~spec:[ LineStyle 4 ] 1. 4. 9. 4.);
Plot.(draw_line ~h ~spec:[ LineStyle 5 ] 1. 5. 9. 5.);
Plot.(draw_line ~h ~spec:[ LineStyle 6 ] 1. 6. 9. 6.);
Plot.(draw_line ~h ~spec:[ LineStyle 7 ] 1. 7. 9. 7.);
Plot.(draw_line ~h ~spec:[ LineStyle 8 ] 1. 8. 9. 8.);
Plot.set_xrange h 0. 10.;
Plot.set_yrange h 0. 9.;
Plot.output h;;


let h = Plot.create "plot07.pdf" in
Array.init 9 (fun i ->
  let x0, y0 = 0.5, float_of_int i +. 1.0 in
  let x1, y1 = 4.5, float_of_int i +. 0.5 in
  Plot.(draw_rect ~h ~spec:[ FillPattern i ] x0 y0 x1 y1);
  Plot.(text ~h ~spec:[ RGB (0,255,0) ] 2.3 (y0-.0.2) ("pattern: " ^ (string_of_int i)));
);
Plot.output h;;


let x = Mat.linspace 0. 2. 100 in
let y0 = Mat.sigmoid x in
let y1 = Mat.map Maths.sin x in
let h = Plot.create "plot10.pdf" in
Plot.(plot ~h ~spec:[ RGB (255,0,0); LineStyle 1; Marker "#[0x2299]"; MarkerSize 8. ] x y0);
Plot.(plot ~h ~spec:[ RGB (0,255,0); LineStyle 2; Marker "#[0x0394]"; MarkerSize 8. ] x y1);
Plot.(legend_on h ~position:SouthEast [|"sigmoid"; "sine"|]);
Plot.output h;;


let x = Mat.uniform 1 30 in
let y = Mat.uniform 1 30 in
let h = Plot.create ~m:3 ~n:3 "plot11.pdf" in
Plot.set_background_color h 255 255 255;
Plot.subplot h 0 0;
Plot.(scatter ~h ~spec:[ Marker "#[0x2295]"; MarkerSize 5. ] x y);
Plot.subplot h 0 1;
Plot.(scatter ~h ~spec:[ Marker "#[0x229a]"; MarkerSize 5. ] x y);
Plot.subplot h 0 2;
Plot.(scatter ~h ~spec:[ Marker "#[0x2206]"; MarkerSize 5. ] x y);
Plot.subplot h 1 0;
Plot.(scatter ~h ~spec:[ Marker "#[0x229e]"; MarkerSize 5. ] x y);
Plot.subplot h 1 1;
Plot.(scatter ~h ~spec:[ Marker "#[0x2217]"; MarkerSize 5. ] x y);
Plot.subplot h 1 2;
Plot.(scatter ~h ~spec:[ Marker "#[0x2296]"; MarkerSize 5. ] x y);
Plot.subplot h 2 0;
Plot.(scatter ~h ~spec:[ Marker "#[0x2666]"; MarkerSize 5. ] x y);
Plot.subplot h 2 1;
Plot.(scatter ~h ~spec:[ Marker "#[0x22a1]"; MarkerSize 5. ] x y);
Plot.subplot h 2 2;
Plot.(scatter ~h ~spec:[ Marker "#[0x22b9]"; MarkerSize 5. ] x y);
Plot.output h;;


let x = Mat.linspace 0. 6.5 20 in
let y = Mat.map Maths.sin x in
let h = Plot.create ~m:1 ~n:2 "plot12.pdf" in
Plot.set_background_color h 255 255 255;
Plot.subplot h 0 0;
Plot.plot_fun ~h Maths.sin 0. 6.5;
Plot.(stairs ~h ~spec:[ RGB (0,128,255) ] x y);
Plot.subplot h 0 1;
Plot.(plot ~h ~spec:[ RGB (0,0,0) ] x y);
Plot.(stairs ~h ~spec:[ RGB (0,128,255) ] x y);
Plot.output h;;


let y1 = Mat.uniform 1 10 in
let y2 = Mat.uniform 10 100 in
let h = Plot.create ~m:1 ~n:2 "plot13.pdf" in
Plot.subplot h 0 0;
Plot.(bar ~h ~spec:[ RGB (0,153,51); FillPattern 3 ] y1);
Plot.subplot h 0 1;
Plot.(boxplot ~h ~spec:[ RGB (0,153,51) ] y2);
Plot.output h;;


let x = Mat.linspace 0.5 2.5 25 in
let y = Mat.map (Stats.Pdf.exponential 0.1) x in
let h = Plot.create ~m:1 ~n:2 "plot14.pdf" in
Plot.set_background_color h 255 255 255;
Plot.subplot h 0 0;
Plot.set_foreground_color h 0 0 0;
Plot.stem ~h x y;
Plot.subplot h 0 1;
Plot.(stem ~h ~spec:[ Marker "#[0x2295]"; MarkerSize 5.; LineStyle 1 ] x y);
Plot.output h;;


let x = Mat.linspace 0. 8. 30 in
let y0 = Mat.map Maths.sin x in
let y1 = Mat.uniform 1 30 in
let h = Plot.create ~m:1 ~n:2 "plot15.pdf" in
Plot.subplot h 0 0;
Plot.set_title h "Sine";
Plot.autocorr ~h y0;
Plot.subplot h 0 1;
Plot.set_title h "Gaussian";
Plot.autocorr ~h y1;
Plot.output h;;


let h = Plot.create ~m:1 ~n:2 "plot16.pdf" in
let x = Mat.linspace 0. 8. 100 in
let y = Mat.map Maths.atan x in
Plot.subplot h 0 0;
Plot.(area ~h ~spec:[ FillPattern 1 ] x y);
let x = Mat.linspace 0. (2. *. 3.1416) 100 in
let y = Mat.map Maths.sin x in
Plot.subplot h 0 1;
Plot.(area ~h ~spec:[ FillPattern 2 ] x y);
Plot.output h;;


let x = Mat.gaussian 200 1 in
let h = Plot.create ~m:1 ~n:2 "plot17.pdf" in
Plot.subplot h 0 0;
Plot.set_title h "histogram";
Plot.histogram ~h ~bin:25 x;
Plot.subplot h 0 1;
Plot.set_title h "empirical cdf";
Plot.ecdf ~h x;
Plot.output h;;


let x, y = Mat.meshgrid (-2.5) 2.5 (-2.5) 2.5 100 100 in
let z0 = Mat.(sin ((x **$ 2.) + (y **$ 2.))) in
let z1 = Mat.(cos ((x **$ 2.) + (y **$ 2.))) in
let h = Plot.create ~m:2 ~n:2 "plot18.pdf" in
Plot.subplot h 0 0;
Plot.surf ~h x y z0;
Plot.subplot h 0 1;
Plot.mesh ~h x y z0;
Plot.subplot h 1 0;
Plot.surf ~h x y z1;
Plot.subplot h 1 1;
Plot.mesh ~h x y z1;
Plot.output h;;


let x, y = Mat.meshgrid (-2.5) 2.5 (-2.5) 2.5 100 100 in
let z = Mat.(sin ((x * x) + (y * y))) in
let h = Plot.create ~m:1 ~n:3 "plot19.pdf" in
Plot.subplot h 0 0;
Plot.(mesh ~h ~spec:[ Altitude 50.; Azimuth 120. ] x y z);
Plot.subplot h 0 1;
Plot.(mesh ~h ~spec:[ Altitude 65.; Azimuth 120. ] x y z);
Plot.subplot h 0 2;
Plot.(mesh ~h ~spec:[ Altitude 80.; Azimuth 120. ] x y z);
Plot.output h;;


let x, y = Mat.meshgrid (-3.) 3. (-3.) 3. 100 100 in
let z = Mat.(
  3. $* ((1. $- x) **$ 2.) * exp (neg (x **$ 2.) - ((y +$ 1.) **$ 2.)) -
  (10. $* (x /$ 5. - (x **$ 3.) - (y **$ 5.)) * (exp (neg (x **$ 2.) - (y **$ 2.)))) -
  ((1./.3.) $* exp (neg ((x +$ 1.) **$ 2.) - (y **$ 2.)))
  ) in
let h = Plot.create ~m:2 ~n:2 "plot20.pdf" in
Plot.subplot h 0 0;
Plot.surf ~h x y z;
Plot.subplot h 0 1;
Plot.mesh ~h x y z;
Plot.subplot h 1 0;
Plot.(surf ~h ~spec:[ Contour ] x y z);
Plot.subplot h 1 1;
Plot.(mesh ~h ~spec:[ Contour ] x y z);
Plot.output h;;


let x, y = Mat.meshgrid (-3.) 3. (-3.) 3. 100 100 in
let z = Mat.(
  3. $* ((1. $- x) **$ 2.) * exp (neg (x **$ 2.) - ((y +$ 1.) **$ 2.)) -
  (10. $* (x /$ 5. - (x **$ 3.) - (y **$ 5.)) * (exp (neg (x **$ 2.) - (y **$ 2.)))) -
  ((1./.3.) $* exp (neg ((x +$ 1.) **$ 2.) - (y **$ 2.)))
  ) in
let h = Plot.create ~m:2 ~n:2 "plot21.pdf" in
Plot.subplot h 0 0;
Plot.(mesh ~h ~spec:[ Contour ] x y z);
Plot.subplot h 0 1;
Plot.heatmap ~h x y z;
Plot.subplot h 1 0;
Plot.mesh ~h x y z;
Plot.subplot h 1 1;
Plot.contour ~h x y z;
Plot.output h;;

