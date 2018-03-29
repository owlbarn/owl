module C = Configurator


let write_sexp fn sexp =
  Stdio.Out_channel.write_all fn ~data:(Base.Sexp.to_string sexp)


let get_gcc_path () =
  let p0 = "/usr/local/lib/gcc/7" in
  if Sys.file_exists p0 then "-L" ^ p0
  else ""


let get_openblas_path () =
  let p0 = "/usr/local/opt/openblas/lib" in
  if Sys.file_exists p0 then "-L" ^ p0
  else ""


let () =
  C.main ~name:"owl" (fun c ->
    let libs = List.filter ((<>) "") [
      get_gcc_path ();
      get_openblas_path ();
    ]
    in
    let cflags = [] in
    let default : C.Pkg_config.package_conf = { cflags; libs } in

    let conf =
      match C.Pkg_config.get c with
      | None    -> default
      | Some pc -> (
          Base.Option.value_map (C.ocaml_config_var c "system") ~default ~f:(function
            | "linux"     -> default
            | "linux_elf" -> default
            | "macosx"    -> { default with libs = "-framework" :: "Accelerate" :: libs }
            | "mingw64"   -> default
            | _           -> default
          )
        )
    in

    write_sexp "c_flags.sexp" Base.(sexp_of_list sexp_of_string conf.cflags);
    write_sexp "c_library_flags.sexp" Base.(sexp_of_list sexp_of_string conf.libs)
  )
