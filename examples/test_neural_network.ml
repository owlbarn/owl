(* test neural networks *)

module M = Owl_dense_real
open Owl_algodiff_ad

type layer = {
  mutable w : t;
  mutable b : t;
  a : t -> t;
}

type network = { layers : layer array }

let _print_info = function
  | Matrix x -> M.pp_dsmat x
  | _ -> ()

let create_network l =
{
  layers = Array.init (Array.length l - 1) (fun i ->
    {
      w = Matrix M.(uniform l.(i) l.(i+1) -$ 0.5);
      b = Matrix M.(uniform 1 l.(i+1) -$ 0.5);
      a = Maths.sigmoid;
    }
  )
}

let run_layer x l = Maths.((x $@ l.w) + l.b) |> l.a

let run_layer' x l =
  _print_info x;
  print_endline "+++";
  _print_info (primal l.w);
  print_endline "+++";
  _print_info (primal l.b);
  print_endline "+++";
  let y = Maths.((x $@ l.w) +. l.b) in
  print_endline "---";
  l.a y

let run_network x nn = Array.fold_left run_layer x nn.layers

let backprop nn eta epoch x y =
  let t = tag () in
  for i = 1 to epoch do
    Array.iter (fun l ->
      l.w <- make_reverse l.w t;
      l.b <- make_reverse l.b t;
    ) nn.layers;
    let loss = ref (Float 0.) in
    M.iteri_rows (fun i u ->
        let v = Matrix (M.row y i) in
        let u = Matrix u in
        loss := Maths.(!loss +. l2norm_sqr((run_network u nn) -. v))
    ) x;
    reverse_prop (Float 1.) !loss;
    Array.iter (fun l ->
      l.w <- Maths.(primal ((primal l.w) -. (eta *. !(adjoint l.w))));
      l.b <- Maths.(primal ((primal l.b) -. (eta *. !(adjoint l.b))));
    ) nn.layers;
    match (primal !loss) with
    | Float loss -> Printf.printf "#%i : loss=%g\n" i loss
    | _ -> print_endline "error"
  done


(* one example *)
let _ =
  let xor_x = (M.of_arrays [|[|0.;0.|]; [|0.;1.|]; [|1.;0.|]; [|1.;1.|];|]) in
  let xor_y = (M.of_arrays [|[|0.|]; [|1.|]; [|1.|]; [|0.|];|]) in
  let net = create_network [|2;3;1|] in
  backprop net (Float 0.9) 10000 xor_x xor_y;
  run_network (Matrix (M.row xor_x 0)) net |> _print_info;
  run_network (Matrix (M.row xor_x 1)) net |> _print_info;
  run_network (Matrix (M.row xor_x 2)) net |> _print_info;
  run_network (Matrix (M.row xor_x 3)) net |> _print_info
