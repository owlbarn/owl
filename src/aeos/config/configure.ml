(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module C = Configurator.V1


let igetenv v =
  let v' = try Sys.getenv v |> int_of_string with Not_found -> 0 in
  if v' < 0 || v' > 1 then raise @@
    Invalid_argument (Printf.sprintf "Invalid value for env variable %s: got %d" v v');
  v'


let get_os_type c =
  let sys = C.ocaml_config_var c "system" in
  match sys with Some s -> s | None -> ""


let default_cflags = [
  "-g"; "-O3"; "-Ofast";
  "-march=native"; "-funroll-loops"; "-ffast-math";
  "-DSFMT_MEXP=19937"; "-fno-strict-aliasing";
]


let get_openmp_cflags c =
  let enable_openmp = igetenv "ENABLE_OPENMP" in
  if enable_openmp = 0 then []
  else if enable_openmp = 1 then (
    match get_os_type c with
    | "linux"        -> [ "-fopenmp" ]
    | "linux_elf"    -> [ "-fopenmp" ]
    | "linux_eabihf" -> [ "-fopenmp" ]
    | "macosx"       -> [ "-Xpreprocessor"; "-fopenmp" ]
    | "mingw64"      -> [ "-fopenmp" ]
    | _              -> []
  )
  else failwith "Error: ENABLE_OPENMP only accepts 0/1."


let default_libs = ["-lm";]


let get_openmp_libs c =
  let enable_openmp = igetenv "ENABLE_OPENMP" in
  if enable_openmp = 0 then []
  else if enable_openmp = 1 then (
    match get_os_type c with
    | "linux"        -> [ "-lgomp" ]
    | "linux_elf"    -> [ "-lgomp" ]
    | "linux_eabihf" -> [ "-lgomp" ]
    | "macosx"       -> [ "-lomp"  ]
    | "mingw64"      -> [ "-lgomp" ]
    | _              -> []
  )
  else failwith "Error: ENABLE_OPENMP only accepts 0/1."


let () =
  C.main ~name:"aeos" (fun c ->

    (* configure link options *)
    let libs = []
      @ default_libs
      @ get_openmp_libs c
    in

    (* configure compile options *)
    let cflags = []
      @ default_cflags
      @ get_openmp_cflags c
    in

    (* assemble default config *)
    let conf : C.Pkg_config.package_conf = { cflags; libs } in

    C.Flags.write_sexp "aeos_c_flags.sexp" conf.cflags;
    C.Flags.write_sexp "aeos_c_library_flags.sexp" conf.libs
  )
