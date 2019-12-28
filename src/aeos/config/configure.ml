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


let get_os_type c =
  let sys = C.ocaml_config_var c "system" in
  match sys with
  | Some s -> s
  | None   -> ""


let get_default_cflags =
  try
    Sys.getenv "OWL_AEOS_CFLAGS"
    |> String.trim
    |> String.split_on_char ' '
    |> List.filter (fun s -> String.trim s <> "")
  with
  | Not_found ->
    [ "-g"
    ; "-O3"
    ; "-Ofast"
    ; "-march=native"
    ; "-funroll-loops"
    ; "-ffast-math"
    ; "-DSFMT_MEXP=19937"
    ; "-fno-strict-aliasing"
    ]


let get_openmp_cflags c =
  let enable_openmp = bgetenv "OWL_ENABLE_OPENMP" in
  if not enable_openmp
  then []
  else (
    match get_os_type c with
    | "linux"     -> [ "-fopenmp" ]
    | "linux_elf" -> [ "-fopenmp" ]
    | "macosx"    -> [ "-Xpreprocessor"; "-fopenmp" ]
    | "mingw64"   -> [ "-fopenmp" ]
    | _           -> [])


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
      let cflags = [] @ get_default_cflags @ get_openmp_cflags c in
      (* assemble default config *)
      let conf : C.Pkg_config.package_conf = { cflags; libs } in
      C.Flags.write_sexp "aeos_c_flags.sexp" conf.cflags;
      C.Flags.write_sexp "aeos_c_library_flags.sexp" conf.libs)
