(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_nlp_utils

let default_punctuation = [|"."; ","; ":"; ";"; "("; ")"; "!"; "?"|]

type t = {
  mutable uri : string;
}

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


let num_doc fname =
  let n = ref 0 in
  Owl_nlp_utils.iteri_lines_of_file (fun i _ -> n := i) fname;
  !n + 1


let tokenise_all dict fname =
  mapi_lines_of_file (fun _ s ->
    Str.split (Str.regexp " ") s
    |> List.map (Owl_nlp_vocabulary.word2index dict)
  ) fname



(* ends here *)
