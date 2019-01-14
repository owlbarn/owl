(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module C = Configurator.V1


let write_sexp fn sexp =
  Stdio.Out_channel.write_all fn ~data:(Sexplib.Sexp.to_string sexp)


let get_os_type c =
  let sys = C.ocaml_config_var c "system" in
  match sys with Some s -> s | None -> ""


let get_default_cflags _c = [
  "-g"; "-O3"; "-Ofast";
  "-march=native"; "-funroll-loops"; "-ffast-math";
  "-DSFMT_MEXP=19937"; "-fno-strict-aliasing";
]


let get_openmp_cflags c =
  match get_os_type c with
  | "linux"     -> [ "-fopenmp" ]
  | "linux_elf" -> [ "-fopenmp" ]
  | "macosx"    -> [ "-Xpreprocessor"; "-fopenmp" ]
  | "mingw64"   -> [ "-fopenmp" ]
  | _           -> []


let get_default_libs () = ["-lm";]


let get_openmp_libs c =
  match get_os_type c with
  | "linux"     -> [ "-lgomp" ]
  | "linux_elf" -> [ "-lgomp" ]
  | "macosx"    -> [ "-lomp" ]
  | "mingw64"   -> [ "-lgomp" ]
  | _           -> []


let () =
  C.main ~name:"aeos" (fun c ->

    (* configure link options *)
    let libs = []
      @ get_default_libs ()
      @ get_openmp_libs c
    in

    (* configure compile options *)
    let cflags = []
      @ get_default_cflags c
      @ get_openmp_cflags c
    in

    (* assemble default config *)
    let conf : C.Pkg_config.package_conf = { cflags; libs } in

    write_sexp "aeos_c_flags.sexp" Sexplib.Std.(sexp_of_list sexp_of_string conf.cflags);
    write_sexp "aeos_c_library_flags.sexp" Sexplib.Std.(sexp_of_list sexp_of_string conf.libs);
  )
