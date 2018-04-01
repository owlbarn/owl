(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module C = Configurator


let write_sexp fn sexp =
  Stdio.Out_channel.write_all fn ~data:(Base.Sexp.to_string sexp)


let get_os_type c =
  let sys = C.ocaml_config_var c "system" in
  match sys with Some s -> s | None -> ""


let get_gcc_path c =
  let p0 = "/usr/local/lib/gcc/7" in
  if Sys.file_exists p0 then ["-L" ^ p0]
  else []


let get_openblas_path c =
  let p0 = "/usr/local/opt/openblas/lib" in
  if Sys.file_exists p0 then ["-L" ^ p0]
  else []


let get_accelerate_libs c =
  match get_os_type c with
  | "macosx"    -> [ "-framework"; "Accelerate" ]
  | "mingw64"   -> [ "-DWIN32" ]
  | _           -> []


let get_openmp_cflags c =
  let enable_openmp = Sys.getenv "ENABLE_OPENMP" |> int_of_string in
  if enable_openmp = 0 then []
  else if enable_openmp = 1 then (
    match get_os_type c with
    | "linux"     -> []
    | "linux_elf" -> []
    | "macosx"    -> [ "-Xpreprocessor"; "-fopenmp" ]
    | "mingw64"   -> []
    | _           -> []
  )
  else failwith "Error: ENABLE_OPENMP only accepts 0/1."


let get_openmp_libs c =
  let enable_openmp = Sys.getenv "ENABLE_OPENMP" |> int_of_string in
  if enable_openmp = 0 then []
  else if enable_openmp = 1 then (
    match get_os_type c with
    | "linux"     -> []
    | "linux_elf" -> []
    | "macosx"    -> [ "-lomp" ]
    | "mingw64"   -> []
    | _           -> []
  )
  else failwith "Error: ENABLE_OPENMP only accepts 0/1."


let () =
  C.main ~name:"owl" (fun c ->
    (* configure link options *)
    let libs = []
      @ get_gcc_path c
      @ get_openblas_path c
      @ get_accelerate_libs c
      @ get_openmp_libs c
    in

    (* configure compile options *)
    let cflags = []
      @ get_openmp_cflags c
    in

    (* assemble default config *)
    let conf : C.Pkg_config.package_conf = { cflags; libs } in

    write_sexp "c_flags.sexp" Base.(sexp_of_list sexp_of_string conf.cflags);
    write_sexp "c_library_flags.sexp" Base.(sexp_of_list sexp_of_string conf.libs)
  )
