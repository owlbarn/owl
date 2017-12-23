(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


module Make (A : InpureSig) = struct

  module D = Owl_distribution.Make (A)

  module L = Owl_lazy.Make (A)


  module MetropolisHastings = struct

    let init () = ()

    let update model h =
      let ratio = 0.0 in
      let model' = L.copy model in
      let sample = Hashtbl.find h "latent" |> List.map L.to_arr in

      (* Draw sample znew ~ g(znew | zold) *)
      let sample' = Hashtbl.find h "proposal" |> List.map L.to_arr in
      let ratio = ratio -. 0.0 in

      let condition = Hashtbl.find h "condition" |> List.map L.to_arr in
      let sample' = sample in
      ()

  end


end
