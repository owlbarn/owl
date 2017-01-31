(** [ Topic Model Utils ]  *)

let _allocate_space x =
  Log.info "allocate more space";
  let l = Array.length x in
  let y = Array.make l [||] in
  Array.append x y

let load_data ?stopwords f =
  Log.info "load text corpus";
  let t = match stopwords with
    | Some t -> t
    | None   -> Hashtbl.create 1024
  in
  let x = ref (Array.make (64 * 1024) [||]) in
  let c = ref 0 in
  let h = open_in f in
  (
    try while true do
      if !c = (Array.length !x) - 1 then x := _allocate_space !x;
      let s = Str.split (Str.regexp " ") (input_line h)
        |> List.filter (fun w -> Hashtbl.mem t w = false)
        |> Array.of_list
      in
      !x.(!c) <- s;
      c := !c + 1;
    done with End_of_file -> ()
  );
  close_in h;
  Array.sub !x 0 !c

let load_stopwords f =
  Log.info "load stopwords";
  let x = Hashtbl.create (64 * 1024) in
  let h = open_in f in
  (
    try while true do
      let w = input_line h in
      if Hashtbl.mem x w = false then Hashtbl.add x w 0
    done with End_of_file -> ()
  );
  close_in h;
  x

let build_vocabulary x =
  Log.info "build up vocabulary";
  let h = Hashtbl.create (64 * 1024) in
  Array.iter (fun l ->
    Array.iter (fun w ->
      if Hashtbl.mem h w = false then Hashtbl.add h w 0
    ) l
  ) x;
  let y = Array.make (Hashtbl.length h) "" in
  let i = ref 0 in
  Hashtbl.iter (fun w _ -> y.(!i) <- w; i := !i + 1) h;
  Array.sort String.compare y;
  Hashtbl.reset h;
  Array.iteri (fun i w -> Hashtbl.add h w i) y;
  h

let tokenisation dict data = Array.map (Array.map (Hashtbl.find dict)) data

let save_vocabulary x f = Owl_utils.marshal_to_file x f

let load_vocabulary f = Owl_utils.marshal_from_file f

let save_lda_model m f =
  Log.info "save LDA model";
  Owl_utils.marshal_to_file m (f ^ ".model")

let load_lda_model f =
  Log.info "load LDA model";
  Owl_utils.marshal_from_file (f ^ ".model")
