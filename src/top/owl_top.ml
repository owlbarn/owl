(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

let printers =
  [ "Owl.Dense.Ndarray.Generic.pp_dsnda"
  ; "Owl.Sparse.Ndarray.Generic.pp_spnda"
  ; "Owl.Sparse.Matrix.Generic.pp_spmat"
  ; "Owl.Neural.S.Graph.pp_network"
  ; "Owl.Neural.D.Graph.pp_network"
  ; "Owl.Algodiff.S.pp_num"
  ; "Owl.Algodiff.D.pp_num"
  ; "Owl.Graph.pp_node"
  ; "Owl.Nlp.Vocabulary.pp_vocab"
  ; "Owl_pretty.pp_dataframe"
  ; "Owl_stats_sampler.pp_t"
  ; "Owl_stats.pp_hist"
  ]

let eval cmd =
  cmd
  |> Lexing.from_string
  |> !Toploop.parse_toplevel_phrase
  |> Toploop.execute_phrase true Format.err_formatter
  |> ignore

let install_printers printers =
  List.iter
    (fun printer -> Printf.sprintf "#install_printer %s;;" printer |> eval)
    printers


let () =
  install_printers printers
