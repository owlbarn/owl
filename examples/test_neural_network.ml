(* test neural networks *)

module M = Owl_dense_real
module A = Owl_algodiff_ad

type layer = {
  mutable w : A.t;
  mutable b : A.t;
  a : A.t -> A.t;
}

type network = { layers : layer array }

let creat_network l =
{
  layers = Array.init (Array.length l - 1) (fun i ->
    {
      w = Matrix M.(uniform l.(i+1) l.(i) -$ 0.5);
      b = Matrix M.(uniform 1 l.(i) -$ 0.5);
      a = A.Maths.sigmoid;
    }
  )
}

let run_layer x l = A.Maths.(x $@ l.w +. l.b) |> l.a

let run_network x nn = Array.fold_left run_layer x nn.layers

let backprop nn eta epoch x y =
  let t = A.tag () in
  for i = 1 to epoch do
    Array.iter (fun l ->
      l.w <- A.make_reverse l.w t;
      l.b <- A.make_reverse l.w t;
    ) nn.layers;
    (* TODO: run network *)
    let loss = 0.1 in
    Array.iter (fun l ->
      l.w <- A.Maths.(A.primal ((A.primal l.w) -. (eta *. !(A.adjoint l.w))));
      l.b <- A.Maths.(A.primal ((A.primal l.b) -. (eta *. !(A.adjoint l.b))));
    ) nn.layers;
    Printf.printf "#%i : loss=%g\n" i loss;
  done
