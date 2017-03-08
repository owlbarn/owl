(* test neural networks *)

open Owl_algodiff_ad

type layer = {
  mutable w : t;
  mutable b : t;
  a : t -> t;
}

type network = { layers : layer array }

let create_network l =
{
  layers = Array.init (Array.length l - 1) (fun i ->
    {
      w = Mat.uniform l.(i) l.(i+1);
      b = Mat.uniform 1 l.(i+1);
      a = Maths.sigmoid;
    }
  )
}

let run_layer x l = Maths.((x $@ l.w) + l.b) |> l.a

let run_network x nn = Array.fold_left run_layer x nn.layers

let backprop nn eta epoch x y =
  let t = tag () in
  for i = 1 to epoch do
    Array.iter (fun l ->
      l.w <- make_reverse l.w t;
      l.b <- make_reverse l.b t;
    ) nn.layers;
    let loss = ref (F 0.) in
    Mat.iter2_rows (fun u v ->
        loss := Maths.(!loss + l2norm_sqr((run_network u nn) - v))
    ) x y;
    reverse_prop (F 1.) !loss;
    Array.iter (fun l ->
      l.w <- Maths.(primal ((primal l.w) - (eta * (adjval l.w))));
      l.b <- Maths.(primal ((primal l.b) - (eta * (adjval l.b))));
    ) nn.layers;
    match (primal !loss) with
    | F loss -> Printf.printf "#%i : loss=%g\n" i loss
    | _ -> print_endline "error"
  done


(* one example *)
let _ =
  let xor_x = Mat.of_arrays [| [|0.;0.|]; [|0.;1.|]; [|1.;0.|]; [|1.;1.|] |] in
  let xor_y = Mat.of_arrays [| [|0.|]; [|1.|]; [|1.|]; [|0.|] |] in
  let net = create_network [|2;3;1|] in
  backprop net (F 1.) 5000 xor_x xor_y;
  run_network (Mat.row xor_x 0) net |> Mat.print;
  run_network (Mat.row xor_x 1) net |> Mat.print;
  run_network (Mat.row xor_x 2) net |> Mat.print;
  run_network (Mat.row xor_x 3) net |> Mat.print
