(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module C = Configurator.V1

let bgetenv v =
  let v' =
    try Sys.getenv v |> int_of_string with
    | Not_found -> 0
  in
  if v' < 0 || v' > 1
  then
    raise
    @@ Invalid_argument (Printf.sprintf "Invalid value for env variable %s: got %d" v v');
  v' = 1


(* Adapted from lapacke_DGELS_colmajor example *)
let test_lapacke_working_code =
  {|
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
  match sys with
  | Some s -> s
  | None   -> ""


let get_ocaml_default_flags _c = []

let get_ocaml_devmode_flags _c =
  let enable_devmode = bgetenv "OWL_ENABLE_DEVMODE" in
  if not enable_devmode then [] else [ "-w"; "-32-27-6-37-3" ]


let default_cflags =
  try
    Sys.getenv "OWL_CFLAGS"
    |> String.trim
    |> String.split_on_char ' '
    |> List.filter (fun s -> String.trim s <> "")
  with
  | Not_found ->
    [ (* Basic optimisation *)
      "-g"
    ; "-O3"
    ; "-Ofast"
    ; (* FIXME: experimental switches *)
      (* "-mavx2"; "-mfma"; "-ffp-contract=fast"; *)
      (* Experimental switches, -ffast-math may break IEEE754 semantics *)
      "-march=native"
    (* Not supported on ARM64 *)
    (* ; "-mfpmath=sse" *)
    ; "-funroll-loops"
    ; "-ffast-math"
    ; (* Configure Mersenne Twister RNG *)
      "-DSFMT_MEXP=19937"
    (* Not supported on ARM64 *)
    (* ; "-msse2" *)
    ; "-fno-strict-aliasing"
    ; "-Wno-tautological-constant-out-of-range-compare"
    ]


let default_libs = [ "-lm" ]

let get_expmode_cflags _c =
  let enable_expmode = bgetenv "OWL_ENABLE_EXPMODE" in
  if not enable_expmode then [] else [ "-flto" ]


let get_devmode_cflags _c =
  let enable_devmode = bgetenv "OWL_ENABLE_DEVMODE" in
  if not enable_devmode
  then [ "-Wno-logical-op-parentheses" ]
  else [ "-Wall"; "-pedantic"; "-Wextra"; "-Wunused" ]


let default_gcc_path =
  let p0 = "/usr/local/lib/gcc/7" in
  if Sys.file_exists p0 then [ "-L" ^ p0 ] else []


let openblas_default : C.Pkg_config.package_conf =
  let p0 = "/usr/local/opt/openblas/lib" in
  let p1 = "/opt/OpenBLAS/lib/" in
  let p2 = "/usr/local/lib/openblas/lib" in
  let libs =
    if Sys.file_exists p0
    then [ "-L" ^ p0 ]
    else if Sys.file_exists p1
    then [ "-L" ^ p1 ]
    else if Sys.file_exists p2
    then [ "-L" ^ p2 ]
    else []
  in
  let p0 = "/usr/include/openblas" in
  let cflags = if Sys.file_exists p0 then [ "-I" ^ p0 ] else [] in
  let libs = libs @ [ "-lopenblas" ] in
  C.Pkg_config.{ cflags; libs }


let get_accelerate_libs c =
  match get_os_type c with
  | "macosx"  -> [ (* disable "-framework"; "Accelerate" ] *) ]
  | "mingw64" -> [ "-DWIN32" ]
  | _         -> []


let get_openmp_config c =
  let enable_openmp = bgetenv "OWL_ENABLE_OPENMP" in
  if not enable_openmp
  then C.Pkg_config.{ cflags = []; libs = [] }
  else (
    let cflags, libs =
      match get_os_type c with
      | "linux"     -> [ "-fopenmp" ], [ "-lgomp" ]
      | "linux_elf" -> [ "-fopenmp" ], [ "-lgomp" ]
      | "macosx"    -> [ "-Xpreprocessor"; "-fopenmp" ], [ "-lomp" ]
      | "mingw64"   -> [ "-fopenmp" ], [ "-lgomp" ]
      | _           -> [], []
    in
    if not @@ C.c_test c test_linking ~c_flags:cflags ~link_flags:libs
    then (
      Printf.printf
        {|
You have set OWL_ENABLE_OPENMP = 1 however I am unable to link
against openmp: the current values for cflags and libs are respectively
%s and %s.

You can disable openmp/aeos by unsetting OWL_ENABLE_OPEN or by setting
it to 0.
If you are compiling owl manually, make sure you first run `make clean`
or `dune clean` before rebuilding the project with a modified flag.

If you think this is our mistake please open an issue reporting
the output of `src/owl/config/configure.exe --verbose`.
|}
        Base.(string_of_sexp @@ sexp_of_list sexp_of_string cflags)
        Base.(string_of_sexp @@ sexp_of_list sexp_of_string libs);
      failwith "Unable to link against openmp");
    C.Pkg_config.{ cflags; libs })


let () =
  C.main ~name:"owl" (fun c ->
      let cblas_conf =
        let default = { C.Pkg_config.cflags = []; libs = [] } in
        let open Base.Option.Monad_infix in
        Base.Option.value
          ~default
          (C.Pkg_config.get c >>= C.Pkg_config.query ~package:"cblas")
      in
      let openblas_conf =
        let open Base.Option.Monad_infix in
        Base.Option.value
          ~default:openblas_default
          (C.Pkg_config.get c >>= C.Pkg_config.query ~package:"openblas")
      in
      if not
         @@ C.c_test
              c
              test_linking
              ~c_flags:openblas_conf.cflags
              ~link_flags:openblas_conf.libs
      then (
        Printf.printf
          {|
Unable to link against openblas: the current values for cflags and libs
are respectively %s and %s.

Usually this is due to missing paths for pkg-config. Try to re-install
or re-compile owl by prefixing the command with (or exporting)

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/path/to/openblas/lib/pkgconfig

If this does not work please open an issue in the owl repository, adding
some details on how your openblas has been installed and the output of
`src/owl/config/configure.exe --verbose`.
|}
          Base.(Sexp.to_string @@ sexp_of_list sexp_of_string openblas_conf.cflags)
          Base.(Sexp.to_string @@ sexp_of_list sexp_of_string openblas_conf.libs);
        failwith "Unable to link against openblas.");
      let lapacke_lib =
        let disable_linking_flag = bgetenv "OWL_DISABLE_LAPACKE_LINKING_FLAG" in
        let needs_lapacke_flag =
          if disable_linking_flag
          then false
          else
            C.c_test
              c
              test_lapacke_working_code
              ~c_flags:openblas_conf.cflags
              ~link_flags:(openblas_conf.libs @ [ "-lm" ])
            |> not
        in
        if needs_lapacke_flag then [ "-llapacke" ] else []
      in
      let openmp_config = get_openmp_config c in
      (* configure link options *)
      let libs =
        []
        @ lapacke_lib
        @ openblas_conf.libs
        @ cblas_conf.libs
        @ default_libs
        @ default_gcc_path
        @ get_accelerate_libs c
        @ openmp_config.libs
      in
      (* configure compile options *)
      let cflags =
        []
        @ openblas_conf.cflags
        @ cblas_conf.cflags
        @ default_cflags
        @ get_devmode_cflags c
        @ get_expmode_cflags c
        @ openmp_config.cflags
      in
      (* configure ocaml options *)
      let ocaml_flags = [] @ get_ocaml_default_flags c @ get_ocaml_devmode_flags c in
      (* assemble default config *)
      let conf : C.Pkg_config.package_conf = { cflags; libs } in
      C.Flags.write_sexp "c_flags.sexp" conf.cflags;
      C.Flags.write_sexp "c_library_flags.sexp" conf.libs;
      C.Flags.write_sexp "ocaml_flags.sexp" ocaml_flags)
