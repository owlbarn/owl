(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module C = Configurator.V1

(* Adapted from lapacke_DGELS_colmajor example *)
let test_lapacke_working_code = {|
#include <stdio.h>
#include <lapacke.h>

void print_matrix_colmajor( char* desc, lapack_int m, lapack_int n, double* mat, lapack_int ldm ) {
  lapack_int i, j;
  printf( "\n %s\n", desc );

  for( i = 0; i < m; i++ ) {
    for( j = 0; j < n; j++ ) printf( " %6.2f", mat[i+j*ldm] );
    printf( "\n" );
  }
}

int main (int argc, const char * argv[])
{
  /* Locals */
  double A[5][3] = {{1,2,3},{4,5,1},{3,5,2},{4,1,4},{2,5,3}};
  double b[5][2] = {{-10,12},{14,16},{18,-3},{14,12},{16,16}};
  lapack_int info,m,n,lda,ldb,nrhs;

  /* Initialization */
  m = 5;
  n = 3;
  nrhs = 2;
  lda = 5;
  ldb = 5;

  /* Solve least squares problem*/
  info = LAPACKE_dgels(LAPACK_COL_MAJOR,'N',m,n,nrhs,*A,lda,*b,ldb);

  /* Print Solution */
  print_matrix_colmajor( "Solution", n, nrhs, *b, ldb );
  printf( "\n" );
  exit( info );
}
|}

let test_linking = {|
int main() { return 0; }
|}

let get_os_type c =
  let sys = C.ocaml_config_var c "system" in
  match sys with Some s -> s | None -> ""


let get_ocaml_default_flags _c = [
]


let get_ocaml_devmode_flags _c =
  let enable_devmode = Sys.getenv "ENABLE_DEVMODE" |> int_of_string in
  if enable_devmode = 0 then []
  else if enable_devmode = 1 then [
    "-w"; "-32-27-6-37-3";
  ]
  else failwith "Error: ENABLE_DEVMODE only accepts 0/1."


let default_cflags = [
  (* Basic optimisation *)
  "-g"; "-O3"; "-Ofast";
  (* FIXME: experimental switches *)
  (* "-mavx2"; "-mfma"; "-ffp-contract=fast"; *)
  (* Experimental switches, -ffast-math may break IEEE754 semantics*)
  "-march=native"; "-mfpmath=sse"; "-funroll-loops"; "-ffast-math";
  (* Configure Mersenne Twister RNG *)
  "-DSFMT_MEXP=19937"; "-msse2"; "-fno-strict-aliasing";
  "-Wno-tautological-constant-out-of-range-compare";
]


let default_libs =
  [
    "-lm";
  ]


let get_expmode_cflags _c =
  let enable_expmode = Sys.getenv "ENABLE_EXPMODE" |> int_of_string in
  if enable_expmode = 0 then []
  else if enable_expmode = 1 then [
    "-flto";
  ]
  else failwith "Error: ENABLE_EXPMODE only accepts 0/1."


let get_devmode_cflags _c =
  let enable_devmode = Sys.getenv "ENABLE_DEVMODE" |> int_of_string in
  if enable_devmode = 0 then [
    "-Wno-logical-op-parentheses"
  ]
  else if enable_devmode = 1 then [
    "-Wall";
    "-pedantic";
    "-Wextra";
    "-Wunused";
  ]
  else failwith "Error: ENABLE_DEVMODE only accepts 0/1."


let default_gcc_path =
  let p0 = "/usr/local/lib/gcc/7" in
  if Sys.file_exists p0 then ["-L" ^ p0]
  else []


let openblas_default : C.Pkg_config.package_conf =
  let p0 = "/usr/local/opt/openblas/lib" in
  let p1 = "/opt/OpenBLAS/lib/" in
  let p2 = "/usr/local/lib/openblas/lib" in
  let libs = if Sys.file_exists p0 then ["-L" ^ p0]
    else if Sys.file_exists p1 then ["-L" ^ p1]
    else if Sys.file_exists p2 then ["-L" ^ p2]
    else []
  in
  let libs = libs @ ["-lopenblas"] in
  C.Pkg_config.{cflags=[]; libs}


let get_accelerate_libs c =
  match get_os_type c with
  | "macosx"    -> [ (* disable "-framework"; "Accelerate" ] *) ]
  | "mingw64"   -> [ "-DWIN32" ]
  | _           -> []


let get_openmp_cflags c =
  let enable_openmp = Sys.getenv "ENABLE_OPENMP" |> int_of_string in
  if enable_openmp = 0 then []
  else if enable_openmp = 1 then (
    match get_os_type c with
    | "linux"     -> [ "-fopenmp" ]
    | "linux_elf" -> [ "-fopenmp" ]
    | "macosx"    -> [ "-Xpreprocessor"; "-fopenmp" ]
    | "mingw64"   -> [ "-fopenmp" ]
    | _           -> []
  )
  else failwith "Error: ENABLE_OPENMP only accepts 0/1."


let get_openmp_libs c =
  let enable_openmp = Sys.getenv "ENABLE_OPENMP" |> int_of_string in
  if enable_openmp = 0 then []
  else if enable_openmp = 1 then (
    match get_os_type c with
    | "linux"     -> [ "-lgomp" ]
    | "linux_elf" -> [ "-lgomp" ]
    | "macosx"    -> [ "-lomp" ]
    | "mingw64"   -> [ "-lgomp" ]
    | _           -> []
  )
  else failwith "Error: ENABLE_OPENMP only accepts 0/1."


let () =
  C.main ~name:"owl" (fun c ->
      let openblas_conf =
        let open Base.Option.Monad_infix in
        Base.Option.value ~default:openblas_default
          (C.Pkg_config.get c >>= C.Pkg_config.query ~package:"openblas")
      in
      if not @@ C.c_test c test_linking
          ~c_flags:openblas_conf.cflags ~link_flags:openblas_conf.libs
      then begin
        Printf.printf {|
Unable to link against openblas: the current values for cflags and libs
are respectively %s and %s.

Usually this is due to missing paths for pkg-config. Try to re-install
or re-compile owl by prefixing the command with (or exporting)

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/path/to/openblas/lib/pkgconfig

If this does not work please raise and issue in the owl repository, adding
some details on how your openblas have been installed and where is located,
as well as the above values for cflags and libs.
        |}
          Base.(string_of_sexp @@ sexp_of_list sexp_of_string openblas_conf.cflags)
          Base.(string_of_sexp @@ sexp_of_list sexp_of_string openblas_conf.libs);
        failwith "Unable to link against openblas."
      end;
      let lapacke_lib =
        let needs_lapacke_flag =
          C.c_test c test_lapacke_working_code
            ~c_flags:openblas_conf.cflags ~link_flags:openblas_conf.libs
          |> not
        in
        if needs_lapacke_flag then ["-llapacke"] else []
      in
      (* configure link options *)
      let libs =
        []
        @ lapacke_lib
        @ openblas_conf.libs
        @ default_libs
        @ default_gcc_path
        @ get_accelerate_libs c
        @ get_openmp_libs c
      in

      (* configure compile options *)
      let cflags =
        []
        @ openblas_conf.cflags
        @ default_cflags
        @ get_devmode_cflags c
        @ get_expmode_cflags c
        @ get_openmp_cflags c
      in

      (* configure ocaml options *)
      let ocaml_flags =
        []
        @ get_ocaml_default_flags c
        @ get_ocaml_devmode_flags c
      in

      (* assemble default config *)
      let conf : C.Pkg_config.package_conf = { cflags; libs } in

      C.Flags.write_sexp "c_flags.sexp" conf.cflags;
      C.Flags.write_sexp "c_library_flags.sexp" conf.libs;
      C.Flags.write_sexp "ocaml_flags.sexp" ocaml_flags;
    )
