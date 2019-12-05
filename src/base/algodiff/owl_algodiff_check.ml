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


  module Reverse = struct
    let finite_difference_grad =
      let two = F A.(float_to_elt 2.) in
      fun ~order ~f ?(eps = 1E-5) x d ->
        let eps = F A.(float_to_elt eps) in
        let dx = Maths.(eps * d) in
        let df1 = Maths.(f (x + dx) - f (x - dx)) in
        match order with
        | `fourth ->
          let eight = F A.(float_to_elt 8.) in
          let twelve = F A.(float_to_elt 12.) in
          let df2 =
            let twodx = Maths.(two * dx) in
            Maths.(f (x + twodx) - f (x - twodx))
          in
          Maths.(((eight * df1) - df2) / (twelve * eps))
        | `second -> Maths.(df1 / (two * eps))


    let check ~threshold ~order ?(verbose = false) ?(eps = 1E-5) ~f =
      let compare rs =
        let n_d = Array.length rs in
        let r_fds = Array.map snd rs in
        let rms =
          Array.fold_left (fun acc r_fd -> acc +. (r_fd *. r_fd)) 0. r_fds /. float n_d
          |> sqrt
        in
        let max_err =
          rs
          |> Array.map (fun (r_ad, r_fd) -> abs_float (r_ad -. r_fd) /. (rms +. 1E-9))
          |> Array.fold_left max (-1.)
        in
        max_err < threshold, max_err
      in
      let f x = Maths.(sum' (f x)) in
      let g = grad f in
      fun ~directions samples ->
        let n_samples = Array.length samples in
        let check, max_err, n_passed =
          samples
          |> Array.map (fun x ->
                 let check, max_err =
                   Array.map
                     (fun d ->
                       let r_ad = Maths.(sum' (g x * d)) |> unpack_flt in
                       let r_fd =
                         finite_difference_grad ~order ~f ~eps x d |> unpack_flt
                       in
                       r_ad, r_fd)
                     directions
                   |> compare
                 in
                 check, max_err)
          |> Array.fold_left
               (fun (check_old, max_err_old, acc) (check, max_err) ->
                 ( check_old && check
                 , max max_err_old max_err
                 , if check then succ acc else acc ))
               (true, -1., 0)
        in
        if verbose
        then
          Printf.printf
            "adjoints passed: %i/%i | max_err: %f.\n%!"
            n_passed
            n_samples
            max_err;
        check, n_passed
  end

  module Forward = struct
    let check_tangent_dimensions ~f x =
      (* tangent at x should have the same dimension as f x *)
      match primal' (f x), primal' (jacobianv f x x) with
      | F _, F _     -> ()
      | Arr a, Arr b ->
        if A.shape a <> A.shape b then failwith "tangent dimension mismatch" else ()
      | _            -> failwith "tangent dimension mismatch"


    let check ~threshold ~f ~directions samples =
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
        (fun (b, n) x ->
          let reverse_gx = reverse_g x in
          let forward_gx = forward_g x in
          let e = Maths.(l2norm_sqr' (reverse_gx - forward_gx)) |> unpack_flt in
          let b' = e < threshold in
          let n = if b' then n + 1 else n in
          b && b', n)
        (true, 0)
        samples
  end
end
