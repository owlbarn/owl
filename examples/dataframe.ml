#!/usr/bin/env owl
(* This example demonstrates the dataframe module in Owl. *)

open Owl

#zoo "3de010940ab340e3d2bfb564ecd7d6ba"


let example_01 gist_path =
  let fname = gist_path ^ "funding.csv" in
  let types =  [|"%s";"%s";"%f";"%s";"%s";"%s";"%s";"%f";"%s";"%s"|] in
  let df = Dataframe.of_csv ~sep:',' types fname in
  Owl_pretty.pp_dataframe Format.std_formatter df


let example_02 gist_path =
  let fname = gist_path ^ "sales.csv" in
  let types =  [|"%s";"%s";"%f";"%s";"%s";"%s";"%s";"%s";"%s";"%s";"%f";"%f"|] in
  let df = Dataframe.of_csv ~sep:',' types fname in
  Owl_pretty.pp_dataframe Format.std_formatter df


let _ =
  let gist_path = Owl_zoo_cmd.query_path "3de010940ab340e3d2bfb564ecd7d6ba" in
  example_01 gist_path;
  example_02 gist_path
