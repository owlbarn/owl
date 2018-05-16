(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

(*
module Make (A : Stats_Dist) = struct

  module D = Owl_distribution.Make (A)

  module L = Owl_lazy.Make (A)

  module P = Owl_ppl.Make (A)


  module MetropolisHastings = struct

    let init h =
      let latent = Hashtbl.find h "latent" in
      let proposal =
        let proposal_dist = Hashtbl.find h "proposal_dist" in
        if Array.length proposal_dist = 0 then
          Array.map (fun x -> P.gaussian ~mu:x ~sigma:(L.of_elt 0.5)) latent
        else proposal_dist
      in
      assert Array.(length latent = length proposal);
      Hashtbl.add h "proposal" proposal;
      Array.map (fun x -> L.sum' x) proposal |> Hashtbl.add h "g(x'|x)";
      Array.map (fun x -> L.sum' x) proposal |> Hashtbl.add h "g(x|x')";
      ()


    let update h =
      let ratio = ref 0.0 in

      let g_x'_x = Hashtbl.find h "g(x'|x)" in
      let g_x_x' = Hashtbl.find h "g(x|x')" in
      Array.iter2 (fun g' g ->
        ratio := !ratio +. (L.to_elt g') -. (L.to_elt g)
      ) g_x'_x g_x_x';

      let p_x' = Hashtbl.find h "p(x')" in
      let p_x = Hashtbl.find h "p(x)" in
      Array.iter2 (fun p' p ->
        ratio := !ratio +. (L.to_elt p') -. (L.to_elt p)
      ) p_x' p_x;

      let p_y_x' = Hashtbl.find h "p(y|x')" in
      let p_y_x = Hashtbl.find h "p(y|x)" in
      Array.iter2 (fun p' p ->
        ratio := !ratio +. (L.to_elt p') -. (L.to_elt p)
      ) p_y_x' p_y_x;

      let accept = log (Owl_stats.std_uniform_rvs ()) < !ratio in
      if accept = true then (
        let sample = Hashtbl.find h "latent" in
        let sample' = Hashtbl.find h "proposal" in
        Array.iter2 (fun x' x ->
          L.assign_arr x (L.to_arr x')
        ) sample' sample
        (* copy to samples *)
      )
      else (
        (* copy to samples *)
      )

  end


end
*)
