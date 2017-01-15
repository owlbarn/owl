(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let _ =
  let prefix = "owl_stub" in
  let generate_ml, generate_c = ref false, ref false in
  Arg.(parse [ ("-ml", Set generate_ml, "Generate ML");
               ("-c", Set generate_c, "Generate C") ])
    (fun _ -> failwith "unexpected anonymous argument")
    "stubgen [-ml|-c]";
  match !generate_ml, !generate_c with
  | false, false
  | true, true ->
    failwith "Exactly one of -ml and -c must be specified"
  | true, false ->
    Cstubs.write_ml Format.std_formatter ~prefix (module Ffi_gsl_bindings.Bindings)
  | false, true ->
    print_endline "#include <gsl/gsl_block_double.h>";
    print_endline "#include <gsl/gsl_block_complex_double.h>";
    print_endline "#include <gsl/gsl_vector_double.h>";
    print_endline "#include <gsl/gsl_vector_complex_double.h>";
    print_endline "#include <gsl/gsl_matrix_double.h>";
    print_endline "#include <gsl/gsl_matrix_complex_double.h>";

    print_endline "#include <gsl/gsl_block_float.h>";
    print_endline "#include <gsl/gsl_block_complex_float.h>";
    print_endline "#include <gsl/gsl_vector_float.h>";
    print_endline "#include <gsl/gsl_vector_complex_float.h>";
    print_endline "#include <gsl/gsl_matrix_float.h>";
    print_endline "#include <gsl/gsl_matrix_complex_float.h>";

    print_endline "#include <gsl/gsl_spmatrix.h>";
    print_endline "#include <gsl/gsl_spblas.h>";
    Cstubs.write_c Format.std_formatter ~prefix (module Ffi_gsl_bindings.Bindings)
