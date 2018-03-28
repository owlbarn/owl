open Base
open Stdio
module C = Configurator

let write_sexp fn sexp =
  Out_channel.write_all fn ~data:(Sexp.to_string sexp)

let () =
  C.main ~name:"owl" (fun c ->
    let libs   = [] in
    let cflags = [] in
    let default : C.Pkg_config.package_conf = { cflags; libs } in

    let conf =
      match C.Pkg_config.get c with
      | None    -> default
      | Some pc -> (
        Option.value_map (C.ocaml_config_var c "system") ~default ~f:(function
          | "linux" | "linux_elf" -> default
          | "macosx" ->
              { default with libs = "-framework" :: "Accelerate" :: libs }
          | "mingw64" -> default
          | _ -> default)
        )
    in

    write_sexp "c_flags.sexp"         (sexp_of_list sexp_of_string conf.cflags);
    write_sexp "c_library_flags.sexp" (sexp_of_list sexp_of_string conf.libs)
  )
