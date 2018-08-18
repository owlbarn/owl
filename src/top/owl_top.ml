(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let printers = [
  "Owl.Dense.Ndarray.Generic.pp_dsnda";
  "Owl.Sparse.Ndarray.Generic.pp_spnda";
  "Owl.Sparse.Matrix.Generic.pp_spmat";
  "Owl.Neural.S.Graph.pp_network";
  "Owl.Neural.D.Graph.pp_network";
  "Owl.Algodiff.S.pp_num";
  "Owl.Algodiff.D.pp_num";
  "Owl.Graph.pp_node";
  "Owl.Nlp.Vocabulary.pp_vocab";
  "Owl_pretty.pp_dataframe";
  "Owl_stats_sampler.pp_t";
  "Owl_stats.pp_hist";
]


let install_printers printers =
  List.iter (fun printer ->
    Printf.sprintf "#install_printer %s;;" printer |> Owl_zoo_cmd.eval
  ) printers


let () =
  (* register zoo directive *)
  Owl_zoo_dir.add_dir_zoo ();
  install_printers printers
