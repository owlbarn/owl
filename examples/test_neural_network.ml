(* test neural networks *)

module M = Owl_dense_real
module A = Owl_algodiff_ad

type layer = {
  mutable w : A.t;
  mutable b : A.t;
  a : A.t -> A.t;
}

type network = { layers : layer array }

let _print_info = function
  | A.Matrix x -> M.pp_dsmat x
  | _ -> ()

let mini_batch = 4

let create_network l =
{
  layers = Array.init (Array.length l - 1) (fun i ->
    {
      w = Matrix M.(uniform l.(i) l.(i+1) -$ 0.5);
      b = Matrix M.(uniform 1 l.(i+1) -$ 0.5);
      a = A.Maths.sigmoid;
    }
  )
}

let run_layer x l = A.Maths.((x $@ l.w) +. l.b) |> l.a

let run_layer' x l =
  _print_info x;
  print_endline "+++";
  _print_info (A.primal l.w);
  print_endline "+++";
  _print_info (A.primal l.b);
  print_endline "+++";
  let y = A.Maths.((x $@ l.w) +. l.b) in
  print_endline "---";
  l.a y

let run_network x nn = Array.fold_left run_layer x nn.layers

let backprop nn eta epoch x y =
  let t = A.tag () in
  for i = 1 to epoch do
    Array.iter (fun l ->
      l.w <- A.make_reverse l.w t;
      l.b <- A.make_reverse l.b t;
    ) nn.layers;
    (* let loss = A.Maths.(l2norm_sqr((run_network x nn) -. y)) in *)
    let a0 = A.Matrix (M.row x 0) in
    let a1 = A.Matrix (M.row x 1) in
    let a2 = A.Matrix (M.row x 2) in
    let a3 = A.Matrix (M.row x 3) in
    let b0 = A.Matrix (M.row y 0) in
    let b1 = A.Matrix (M.row y 1) in
    let b2 = A.Matrix (M.row y 2) in
    let b3 = A.Matrix (M.row y 3) in
    let l0 = A.Maths.(l2norm_sqr((run_network a0 nn) -. b0)) in
    let l1 = A.Maths.(l2norm_sqr((run_network a1 nn) -. b1)) in
    let l2 = A.Maths.(l2norm_sqr((run_network a2 nn) -. b2)) in
    let l3 = A.Maths.(l2norm_sqr((run_network a3 nn) -. b3)) in
    let loss = A.Maths.(l0 +. l1 +. l2 +. l3) in
    A.reverse_prop (Float 1.) loss;
    Array.iter (fun l ->
      l.w <- A.Maths.(A.primal ((A.primal l.w) -. (eta *. !(A.adjoint l.w))));
      l.b <- A.Maths.(A.primal ((A.primal l.b) -. (eta *. !(A.adjoint l.b))));
    ) nn.layers;
    match (A.primal loss) with
    | Float loss -> Printf.printf "#%i : loss=%g\n" i loss
    | _ -> print_endline "error"
  done


(* one example *)
let _ =
  let xor_x = (M.of_arrays [|[|0.;0.|]; [|0.;1.|]; [|1.;0.|]; [|1.;1.|];|]) in
  let xor_y = (M.of_arrays [|[|0.|]; [|1.|]; [|1.|]; [|0.|];|]) in
  let net = create_network [|2;3;1|] in
  backprop net (Float 0.1) 1000 xor_x xor_y;
  run_network (Matrix (M.row xor_x 0)) net |> _print_info;
  run_network (Matrix (M.row xor_x 1)) net |> _print_info;
  run_network (Matrix (M.row xor_x 2)) net |> _print_info;
  run_network (Matrix (M.row xor_x 3)) net |> _print_info
