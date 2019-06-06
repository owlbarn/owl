module Make (Algodiff : Owl_algodiff_generic_sig.Sig) = struct
  open Algodiff

  let generate_directions (dim1, dim2) =
    let n_directions = dim1 * dim2 in
    Array.init n_directions (fun j ->
        Arr
          (A.init [|dim1; dim2|] (fun i ->
               if i = j then A.(float_to_elt 1.) else A.(float_to_elt 0.) )) )

  let generate_test_samples (dim1, dim2) n_samples =
    List.init n_samples (fun _ -> Mat.gaussian dim1 dim2), generate_directions (dim1, dim2)

  let finite_difference_grad ~f ?(eps = 1E-5) x d =
    let dx = Maths.(F A.(float_to_elt eps) * d) in
    Maths.((f (x + dx) - f (x - dx)) / F A.(float_to_elt (2. *. eps)))

  let check_grad ~threshold ?(verbose = false) ?(eps = 1E-5) ~f =
    let compare rs =
      let n_d = Array.length rs in
      let r_fds = Array.map snd rs in
      let rms =
        Array.fold_left (fun acc r_fd -> acc +. (r_fd *. r_fd)) 0. r_fds /. float n_d |> sqrt
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
      let rec __check acc = function
        | [] -> acc
        | hd :: tl ->
          let check, max_err =
            Array.map
              (fun d ->
                let r_ad = Maths.(sum' (g hd * d)) |> unpack_flt in
                let r_fd = finite_difference_grad ~f ~eps hd d |> unpack_flt in
                r_ad, r_fd )
              directions
            |> compare
          in
          __check ((check, max_err) :: acc) tl
      in
      let n_samples = List.length samples in
      let check, max_err, n_passed =
        __check [] samples
        |> List.fold_left
             (fun (check_old, max_err_old, acc) (check, max_err) ->
               check_old && check, max max_err_old max_err, if check then succ acc else acc )
             (true, -1., 0)
      in
      if verbose
      then Printf.printf "adjoints passed: %i/%i | max_err: %f.\n%!" n_passed n_samples max_err;
      check, n_passed
end
