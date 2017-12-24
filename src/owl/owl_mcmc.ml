(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module Make (A : InpureSig) = struct

  module D = Owl_distribution.Make (A)

  module L = Owl_lazy.Make (A)


  module MetropolisHastings = struct

    let init h = ()

    let update h =
      let ratio = ref 0.0 in

      let g_x'_x = Hashtbl.find h "g(x'|x)" in
      let g_x_x' = Hashtbl.find h "g(x|x')" in
      List.iter2 (fun g' g ->
        ratio := !ratio +. (L.to_elt g') -. (L.to_elt g)
      ) g_x'_x g_x_x';

      let p_x' = Hashtbl.find h "p(x')" in
      let p_x = Hashtbl.find h "p(x)" in
      List.iter2 (fun p' p ->
        ratio := !ratio +. (L.to_elt p') -. (L.to_elt p)
      ) p_x' p_x;

      let p_y_x' = Hashtbl.find h "p(y|x')" in
      let p_y_x = Hashtbl.find h "p(y|x)" in
      List.iter2 (fun p' p ->
        ratio := !ratio +. (L.to_elt p') -. (L.to_elt p)
      ) p_y_x' p_y_x;

      let accept = log (Owl_stats.Rnd.uniform ()) < !ratio in
      if accept = true then (
        let sample = Hashtbl.find h "latent" in
        let sample' = Hashtbl.find h "proposal" in
        List.iter2 (fun x' x ->
          L.assign_arr x (L.to_arr x')
        ) sample' sample
        (* copy to samples *)
      )
      else (
        (* copy to samples *)
      )

  end


end
