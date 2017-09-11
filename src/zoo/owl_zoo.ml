(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let () =
  Owl_zoo_cmd.eval "
    #install_printer Owl.Neural.S.Graph.print;;
    #install_printer Owl.Neural.D.Graph.print;;
    #install_printer Owl.Mat.pp_dsmat;;
    #install_printer Owl.Arr.pp_dsdna;;
    #install_printer Owl.Dense.Matrix.S.pp_dsmat;;
    #install_printer Owl.Dense.Matrix.D.pp_dsmat;;
    #install_printer Owl.Dense.Matrix.C.pp_dsmat;;
    #install_printer Owl.Dense.Matrix.Z.pp_dsmat;;
    #install_printer Owl.Dense.Ndarray.Generic.pp_dsnda;;
    #install_printer Owl.Dense.Matrix.Generic.pp_dsmat;;
    #install_printer Owl.Sparse.Ndarray.Generic.pp_spnda;;
    #install_printer Owl.Sparse.Matrix.Generic.pp_spmat;;
  "
