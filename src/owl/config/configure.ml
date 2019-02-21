(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module C = Configurator.V1

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
  let cflags = ["-lopenblas"] in
  C.Pkg_config.{cflags; libs}


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
      (* configure link options *)
      let libs =
        []
        @ default_libs
        @ openblas_conf.libs
        @ default_gcc_path
        @ get_accelerate_libs c
        @ get_openmp_libs c
      in

      (* configure compile options *)
      let cflags =
        []
        @ default_cflags
        @ openblas_conf.cflags
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
