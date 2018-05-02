#!/usr/bin/env owl
(* This example demonstrates the dataframe module in Owl. *)

open Owl

#zoo "3de010940ab340e3d2bfb564ecd7d6ba"


let example_01 gist_path =
  let fname = gist_path ^ "funding.csv" in
  let types =  [|"%s";"%s";"%f";"%s";"%s";"%s";"%s";"%f";"%s";"%s"|] in
  let df = Dataframe.of_csv ~sep:',' ~types fname in
  Owl_pretty.pp_dataframe Format.std_formatter df


let example_02 gist_path =
  let fname = gist_path ^ "sales.csv" in
  let types =  [|"%s";"%s";"%f";"%s";"%s";"%s";"%s";"%s";"%s";"%s";"%f";"%f"|] in
  let df = Dataframe.of_csv ~sep:',' ~types fname in
  Owl_pretty.pp_dataframe Format.std_formatter df


let example_03 gist_path =
  let fname = gist_path ^ "estate.csv" in
  let df = Dataframe.of_csv ~sep:',' fname in
  Owl_pretty.pp_dataframe Format.std_formatter df


let example_04 gist_path =
  let fname = gist_path ^ "insurance.csv" in
  let types =  [|"%i";"%s";"%s";"%f";"%f";"%f";"%f";"%f";"%f";"%f";"%f";"%f";"%f";"%f";"%f";"%s";"%s";"%i"|] in
  let d0 = Dataframe.of_csv ~sep:',' ~types fname in
  let d1 = Dataframe.(filter_row (fun row ->
    (unpack_string row.(15)) = "Commercial" && (unpack_float row.(3)) > 0.
    ) d0) in
  Owl_pretty.pp_dataframe Format.std_formatter d1


let example_05 gist_path =
  let fname = gist_path ^ "estate.csv" in
  let d0 = Dataframe.of_csv ~sep:',' fname in
  let d1 = Dataframe.(d0.?(fun row -> (unpack_string row.(7)) = "Condo")) in
  let d2 = Dataframe.(d0.?(fun row -> (unpack_string row.(7)) = "Condo").?(fun row -> (unpack_string row.(4)) = "2")) in
  Owl_pretty.pp_dataframe Format.std_formatter d2


let _ =
  let gist_path = Owl_zoo_cmd.query_path "3de010940ab340e3d2bfb564ecd7d6ba" in
  example_01 gist_path;
  example_02 gist_path;
  example_03 gist_path;
  example_04 gist_path;
  example_05 gist_path
