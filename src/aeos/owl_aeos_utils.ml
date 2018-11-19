(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl

module M = Dense.Matrix.S

(* require math/stats methods *)

let fzero_bisec ?(max_iter=1000) ?(xtol=1e-6) f a b =
  let fa = f a in
  let fb = f b in
  assert (fa *. fb < 0.);

  if fa = 0. then a
  else if fb = 0. then b
  else (
    let x, d = match fa < 0. with
      | true  -> ref a, ref (b -. a)
      | false -> ref b, ref (a -. b)
    in
    try
      for _i = 1 to max_iter do
        d := !d *. 0.5;
        let c = !x +. !d in
        let fc = f c in
        if fc <= 0. then x := c;
        assert ((abs_float !d >= xtol) && fc != 0.)
      done;
      !x
    with _ -> !x;
  )

let sort ?(inc=true) x =
  let y = Array.copy x in
  let c = if inc then 1 else (-1) in
  Array.sort (fun a b ->
    if a < b then (-c)
    else if a > b then c
    else 0
  ) y;
  y


let quantile x p =
  let y = sort ~inc:true x in
  let n = Array.length y in
  let index = p *. (float_of_int (n - 1)) in
  let lhs = int_of_float index in
  let delta = index -. (float_of_int lhs) in
  if n = 0 then 0.
  else (
    if lhs = n - 1 then y.(lhs)
    else (1. -. delta) *. y.(lhs) +. delta *. y.(lhs + 1)
  )

let percentile x p = quantile x (p /. 100.)

let sum x = Array.fold_left ( +. ) 0. x

let mean x =
  let n = float_of_int (Array.length x) in
  sum x /. n

let _get_mean m x =
  match m with
  | Some a -> a
  | None   -> mean x

let var ?mean x =
  let m = _get_mean mean x in
  let t = ref 0. in
  Array.iter (fun a ->
    let d = a -. m in
    t := !t +. d *. d
  ) x;
  let l = float_of_int (Array.length x) in
  let n = if l = 1. then 1. else l -. 1. in
  !t /. n

let std ?mean x = sqrt (var ?mean x)

(* END *)

let write_file f s =
  let h = open_out f in
  Printf.fprintf h "%s" s;
  close_out h

let write_csv ?(sep='\t') x fname =
  let h = open_out fname in
  Array.iter (fun row ->
    let s = Array.fold_left (fun acc elt ->
      Printf.sprintf "%s%s%c" acc elt sep
    ) "" row
    in
    Printf.fprintf h "%s\n" s
  ) x;
  close_out h

let read_file ?(trim=true) f =
  let h = open_in f in
  let s = ref [""] in
  (
    try while true do
      let l = match trim with
        | true  -> input_line h |> String.trim
        | false -> input_line h
      in
      s := List.append !s [l]
    done with End_of_file -> ()
  );
  close_in h;
  Array.of_list !s

let default_threshold = 0

let c = 30 (* repeat times *)

let remove_outlier arr =
  let first_perc = percentile arr 25. in
  let third_perc = percentile arr 75. in
  let lst = Array.to_list arr in
  List.filter (fun x -> (x >= first_perc) && (x <= third_perc)) lst
    |> Array.of_list


let timing fn msg =
  Gc.compact ();
  let times = Array.make c 0. in
  for i = 1 to c do
    let t = fn () in
    Array.set times i t
  done;
  let times = remove_outlier(times) in
  let m_time = mean times in
  let s_time = std times in
  Printf.fprintf stderr "| %s :\t mean = %.3f \t std = %.3f \n" msg m_time s_time;
  flush stdout;
  m_time, s_time


let step_measure xs ef eg msg =
  let n = Array.length xs in
  let y1 = Array.make n 0. in
  let y2 = Array.make n 0. in

  for i = 0 to n - 1 do
    let x = xs.(i) in
    let v1, _ = timing (ef x) msg in
    let v2, _ = timing (eg x) (msg ^ "-baseline") in
    y1.(i) <- v1;
    y2.(i) <- v2;
  done;
  Array.map2 (fun a b ->  a -. b) y2 y1


let linreg x y =
  let n = Array.length x in
  let ny = Array.length y in
  assert (n = ny);

  let mu_x = mean x in
  let mu_y = mean y in
  let x' = Array.map (fun a -> a -. mu_x) x in
  let y' = Array.map (fun a -> a -. mu_y) y in
  let xy = Array.mapi (fun i a -> a *. y'.(i)) x' in

  let p = (sum xy) /. (float_of_int (n - 1)) in
  let q = var x in
  let b = p /. q in
  let c = b *. (mean x) in
  let a = (mean y) -. c in
  a, b


let linear_reg x y =
  let b, k = linreg x y in
  Printf.fprintf stderr "Linear Regression: k: %.2f, b: %.2f\n" k b;
  let g x = x *. k +. b in
  g, (if k > 0. then true else false)

  (* let p = M.get (M.cov ~a:x ~b:y) 0 1 in
  let q = M.get (M.var ~axis:0 x) 0 0 in

  let b = ( /. ) p q in
  let c = ( *. ) b (M.mean' x) in
  let a = ( -. ) (M.mean' y) c in
  a, b *)


let find_root ?(l=(-10000.)) ?(u=1000000.) f pos_slope =
  try
    if pos_slope = false then max_int
    else (
      let r = fzero_bisec f l u in
      let r = if (r > 0.) then r else 0. in
      Printf.fprintf stderr "Crosspoint: %f.\n" r;
      int_of_float r
    )
  with
  | Assert_failure (err_msg, _, _) ->
    Printf.fprintf stderr "%s" (err_msg ^ " ; using default value");
    default_threshold

(*
let plot x y y' m =
  let h = Plot.create (Printf.sprintf "line_plot_%s.png" m) in
  let x = Dense.Matrix.Generic.cast_s2d x in
  let y = Dense.Matrix.Generic.cast_s2d y in
  let y' = Dense.Matrix.Generic.cast_s2d y' in
  Plot.scatter ~h x y;
  Plot.plot ~h ~spec:[ RGB (0,255,0) ] x y';
  Plot.output h
*)

let to_csv x y y' m =
  let f = Printf.sprintf "line_data_%s.csv" m in
  let to_str = Array.map string_of_float in
  let x = to_str x in
  let y = to_str y in
  let y' = to_str y' in
  write_csv [|x; y; y'|] f


let replace_lines_in_file fname keyword replace =
  let lines = Owl_io.read_file fname in
  Array.iteri (fun i l ->
    let r = Str.regexp keyword in
    try
      let _ = Str.search_forward r l 0 in
      Array.set lines i replace
    with Not_found -> ()
  ) lines;
  let line_str = lines |> Array.to_list |> String.concat "\n" in
  Owl_io.write_file fname line_str
