(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017
 *   Ben Catterall <bpwc2@cam.ac.uk>
 *   Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let _allocate_space x =
  Log.info "allocate more space";
  let l = Array.length x in
  let y = Array.make l [||] in
  Array.append x y

let load_from_file ?stopwords f =
  Log.info "load text corpus";
  let t = match stopwords with
    | Some t -> t
    | None   -> Hashtbl.create 2
  in
  let x = ref (Array.make (64 * 1024) [||]) in
  let c = ref 0 in
  let w = ref 0 in
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
      w := !w + Array.length s;
    done with End_of_file -> ()
  );
  close_in h;
  Log.info "load %i docs, %i words" !c !w;
  Array.sub !x 0 !c

let load_from_string ?stopwords s =
  let t = match stopwords with
    | Some t -> t
    | None   -> Hashtbl.create 2
  in
  Str.split (Str.regexp " ") s
  |> List.filter (fun w -> Hashtbl.mem t w = false)
  |> Array.of_list

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

(* return both word->index and index->word hashtbl *)
let build_vocabulary x =
  Log.info "build up vocabulary";
  let w2i = Hashtbl.create (64 * 1024) in
  Array.iter (fun l ->
    Array.iter (fun w ->
      if Hashtbl.mem w2i w = false then Hashtbl.add w2i w 0
    ) l
  ) x;
  let y = Array.make (Hashtbl.length w2i) "" in
  let i = ref 0 in
  Hashtbl.iter (fun w _ -> y.(!i) <- w; i := !i + 1) w2i;
  Array.sort String.compare y;
  let i2w = Hashtbl.(create (length w2i)) in
  Hashtbl.reset w2i;
  Array.iteri (fun i w ->
    Hashtbl.add w2i w i;
    Hashtbl.add i2w i w;
  ) y;
  w2i, i2w

let tokenise dict data = Array.map (Hashtbl.find dict) data

let tokenise_all dict data = Array.map (Array.map (Hashtbl.find dict)) data

let save_vocabulary x f = Owl_utils.marshal_to_file x f

let load_vocabulary f = Owl_utils.marshal_from_file f

let save_lda_model m f =
  Log.info "save LDA model";
  Owl_utils.marshal_to_file m (f ^ ".model")

let load_lda_model f =
  Log.info "load LDA model";
  Owl_utils.marshal_from_file (f ^ ".model")
