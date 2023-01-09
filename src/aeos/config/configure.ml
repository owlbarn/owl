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


let get_os_type c =
  let sys = C.ocaml_config_var c "system" in
  match sys with
  | Some s -> s
  | None   -> ""


let get_default_cflags c =
  try
    Sys.getenv "OWL_AEOS_CFLAGS"
    |> String.trim
    |> String.split_on_char ' '
    |> List.filter (fun s -> String.trim s <> "")
  with
  | Not_found ->
    let os =
      let platform =
        C.C_define.import c ~includes:[ ] ~prelude:detect_system_os [ "PLATFORM_NAME", String ]
      in
      match List.map snd platform with
      | [ String "android" ] -> `android
      | [ String "ios" ]     -> `ios
      | [ String "linux" ]   -> `linux
      | [ String "mac" ]     -> `mac
      | [ String "windows" ] -> `windows
      | _                    -> `unknown
    in
    let arch =
      let arch =
        C.C_define.import c ~includes:[ ] ~prelude:detect_system_arch [ "PLATFORM_ARCH", String ]
      in
      match List.map snd arch with
      | [ String "x86_64" ] -> `x86_64
      | [ String "x86" ]    -> `x86
      | [ String "arm64" ]  -> `arm64
      | [ String "arm" ]    -> `arm
      | _                   -> `unknown
    in
    [ "-g"; "-O3"; "-Ofast" ]
    @ (match arch, os with
      | `arm64, `mac -> [ "-mcpu=apple-m1" ]
      | `x86_64, _   -> [ "-march=native"; "-msse2" ]
      | _            -> [])
    @ [ "-funroll-loops"; "-ffast-math"; "-DSFMT_MEXP=19937"; "-fno-strict-aliasing" ]


let get_openmp_cflags c =
  let enable_openmp = bgetenv "OWL_ENABLE_OPENMP" in
  if not enable_openmp
  then []
  else (
    match get_os_type c with
    | "mingw64" | "linux" | "linux_elf" -> [ "-fopenmp" ]
    | "macosx" -> [ "-Xpreprocessor"; "-fopenmp" ]
    | _ -> [])


let get_default_libs () = [ "-lm" ]

let get_openmp_libs c =
  let enable_openmp = bgetenv "OWL_ENABLE_OPENMP" in
  if not enable_openmp
  then []
  else (
    match get_os_type c with
    | "linux"     -> [ "-lgomp" ]
    | "linux_elf" -> [ "-lgomp" ]
    | "macosx"    -> [ "-lomp" ]
    | "mingw64"   -> [ "-lgomp" ]
    | _           -> [])


let () =
  C.main ~name:"aeos" (fun c ->
      (* configure link options *)
      let libs = [] @ get_default_libs () @ get_openmp_libs c in
      (* configure compile options *)
      let cflags = [] @ get_default_cflags c @ get_openmp_cflags c in
      (* assemble default config *)
      let conf : C.Pkg_config.package_conf = { cflags; libs } in
      C.Flags.write_sexp "aeos_c_flags.sexp" conf.cflags;
      C.Flags.write_sexp "aeos_c_library_flags.sexp" conf.libs)
