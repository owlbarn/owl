(* uses reverse mode gradient to check forward mode gradients *)
module Make (Algodiff : Owl_algodiff_generic_sig.Sig) = struct
  open Algodiff

  let generate_directions (dim1, dim2) =
    let n_directions = dim1 * dim2 in
    Array.init n_directions (fun j ->
        Arr
          (A.init [| dim1; dim2 |] (fun i ->
               if i = j then A.(float_to_elt 1.) else A.(float_to_elt 0.))))


  let generate_test_samples (dim1, dim2) n_samples =
    ( Array.init n_samples (fun _ -> Mat.gaussian dim1 dim2)
    , generate_directions (dim1, dim2) )


  let check_tangent_dimensions ~f x =
    (* tangent at x should have the same dimension as f x *)
    match primal' (f x), primal' (jacobianv f x x) with
    | F _, F _ -> ()
    | Arr a, Arr b ->
      if A.shape a <> A.shape b then failwith "tangent dimension mismatch" else ()
    | _ -> failwith "tangent dimension mismatch"


  let check_diff ~threshold ~f ~directions samples =
    check_tangent_dimensions ~f samples.(0);
    let f x = Maths.(sum' (f x)) in
    let reverse_g = grad f in
    let dim1, dim2 = Mat.shape directions.(0) in
    let forward_g x =
      Arr
        (A.init [| dim1; dim2 |] (fun i ->
             let v = directions.(i) in
             jacobianv f x v |> unpack_elt))
    in
    Array.fold_left
      (fun e' x ->
        let reverse_gx = reverse_g x in
        let forward_gx = forward_g x in
        let e = Maths.(l2norm_sqr' (reverse_gx - forward_gx)) |> unpack_flt in
        e +. e')
      0.
      samples
    < threshold
end
