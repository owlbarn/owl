(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module C = Configurator.V1

let detect_system_os =
  {|
  #if __APPLE__
    #include <TargetConditionals.h>
    #if TARGET_OS_IPHONE
      #define PLATFORM_NAME "ios"
    #else
      #define PLATFORM_NAME "mac"
    #endif
  #elif __linux__
    #if __ANDROID__
      #define PLATFORM_NAME "android"
    #else
      #define PLATFORM_NAME "linux"
    #endif
  #elif WIN32
    #define PLATFORM_NAME "windows"
  #else
    #define PLATFORM_NAME "unknown"
  #endif
|}


let detect_system_arch =
  {|
  #if __x86_64__
    #define PLATFORM_ARCH "x86_64"
  #elif __i386__
    #define PLATFORM_ARCH "x86"
  #elif __aarch64__
    #define PLATFORM_ARCH "arm64"
  #elif __arm__
    #define PLATFORM_ARCH "arm"
  #else
    #define PLATFORM_ARCH "unknown"
  #endif
|}


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


let clean_env_var env_var =
  Sys.getenv env_var
    |> String.trim
    |> String.split_on_char ' '
    |> List.filter (fun s -> String.trim s <> "")


let get_default_config c =
  let os =
    let platform = C.C_define.import c ~includes:[ ] ~prelude:detect_system_os [ "PLATFORM_NAME", String ] in
    match List.map snd platform with
    | [ String "android" ] -> `android
    | [ String "ios" ]     -> `ios
    | [ String "linux" ]   -> `linux
    | [ String "mac" ]     -> `mac
    | [ String "windows" ] -> `windows
    | _                    -> `unknown
  in
  let arch =
    let arch = C.C_define.import c ~includes:[ ] ~prelude:detect_system_arch [ "PLATFORM_ARCH", String ] in
    match List.map snd arch with
    | [ String "x86_64" ] -> `x86_64
    | [ String "x86" ]    -> `x86
    | [ String "arm64" ]  -> `arm64
    | [ String "arm" ]    -> `arm
    | _                   -> `unknown
  in
  let cflags =
    try clean_env_var "OWL_CFLAGS" with
    | Not_found ->
       [ (* Basic optimisation *) "-g"; "-O3" ]
      @ (match arch, os with
        | `arm64, `mac -> [ "-march=native" ]
        | `x86_64, _   -> [ "-march=native"; "-mfpmath=sse"; "-msse2" ]
        | _            -> [])
      @ [ (* Experimental switches, -ffast-math may break IEEE754 semantics*)
          "-funroll-loops"
        ; "-fno-math-errno"
        ; "-fno-rounding-math"
        ; "-fno-signaling-nans"
        ; "-fexcess-precision=fast"
        ; (* Configure Mersenne Twister RNG *)
          "-DSFMT_MEXP=19937"
        ; "-fno-strict-aliasing"
        ]
  in
  (* homebrew M1 issue workaround, works only if users use the default homebrew path *)
  let libs =
    let p0 = "/opt/homebrew/opt/gcc/lib/gcc/current/" in
    if os = `mac && arch = `arm64 && Sys.file_exists p0 then [ "-L" ^ p0 ] else []
  in
  C.Pkg_config.{ cflags; libs }


let default_cppflags =
  try clean_env_var "OWL_CPPFLAGS" with
    | Not_found -> []


let default_ldflags =
  try clean_env_var "OWL_LDFLAGS" with
    | Not_found -> []


let default_ldlibs =
  try clean_env_var "OWL_LDLIBS" with
    | Not_found -> [ "-lm" ]


let get_expmode_cflags _c =
  let enable_expmode = bgetenv "OWL_ENABLE_EXPMODE" in
  if not enable_expmode then [] else [ "-flto" ]


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
      | "linux_elf"
      | "linux"     -> [ "-fopenmp" ], [ "-lgomp" ]
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
(%s) and (%s).

You can disable openmp/aeos by unsetting OWL_ENABLE_OPEN or by setting
it to 0.
If you are compiling owl manually, make sure you first run `make clean`
or `dune clean` before rebuilding the project with a modified flag.

If you think this is our mistake please open an issue reporting
the output of `src/owl/config/configure.exe --verbose`.
|}
        (String.concat " " cflags)
        (String.concat " " libs);
      failwith "Unable to link against openmp");
    C.Pkg_config.{ cflags; libs })


let () =
  C.main ~name:"owl" (fun c ->
      let (>>=) = Option.bind in
      let default_config = get_default_config c in
      let default_pkg_config = { C.Pkg_config.cflags = []; libs = [] } in
      let cblas_conf =
        Option.value ~default:default_pkg_config
          (C.Pkg_config.get c >>= C.Pkg_config.query ~package:"cblas")
      in
      let openblas_conf =
        Option.value
          ~default:openblas_default
          (C.Pkg_config.get c >>= C.Pkg_config.query ~package:"openblas")
      in
      let openmp_config = get_openmp_config c in
      (* configure link options *)
      let libs =
        []
        @ default_ldflags
        @ default_ldlibs
        @ default_config.libs
        @ openblas_conf.libs
        @ cblas_conf.libs
        @ default_gcc_path
        @ get_accelerate_libs c
        @ openmp_config.libs
      in
      (* configure compile options *)
      let cflags =
        []
        @ default_config.cflags
        @ default_cppflags
        @ openblas_conf.cflags
        @ cblas_conf.cflags
        @ get_expmode_cflags c
        @ openmp_config.cflags
      in
      if not @@ C.c_test c test_linking ~c_flags:cflags ~link_flags:libs
      then (
        Printf.printf
          {|
Unable to link against openblas: the current values for cflags and libs
are respectively (%s) and (%s).

Usually this is due to missing paths for pkg-config. Try to re-install
or re-compile owl by prefixing the command with (or exporting)

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/path/to/openblas/lib/pkgconfig

If this does not work please open an issue in the owl repository, adding
some details on how your openblas has been installed and the output of
`src/owl/config/configure.exe --verbose`.
|}
        (String.concat " " openblas_conf.cflags)
        (String.concat " " openblas_conf.libs);
        failwith "Unable to link against openblas.");
      let lapacke_conf =
        let disable_linking_flag = bgetenv "OWL_DISABLE_LAPACKE_LINKING_FLAG" in
        let needs_lapacke_flag =
          if disable_linking_flag
          then false
          else
            C.c_test
              c
              test_lapacke_working_code
              ~c_flags:openblas_conf.cflags
              ~link_flags:(default_config.libs @ openblas_conf.libs @ [ "-lm" ])
            |> not
        in
        if needs_lapacke_flag
        then
          Option.value
            ~default:C.Pkg_config.{ cflags = []; libs = [ "-llapacke" ] }
            (C.Pkg_config.get c >>= C.Pkg_config.query ~package:"llapacke")
        else default_pkg_config
      in
      (* configure link options *)
      let libs = lapacke_conf.libs @ libs in
      let cflags = lapacke_conf.cflags @ cflags in 
      (* configure ocaml options *)
      let ocaml_flags = [] @ get_ocaml_default_flags c @ get_ocaml_devmode_flags c in
      (* assemble default config *)
      let conf : C.Pkg_config.package_conf = { cflags; libs } in
      C.Flags.write_sexp "c_flags.sexp" conf.cflags;
      C.Flags.write_sexp "c_library_flags.sexp" conf.libs;
      C.Flags.write_sexp "ocaml_flags.sexp" ocaml_flags)
