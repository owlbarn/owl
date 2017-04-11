(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let default_punctuation = [|"."; ","; ":"; ";"; "("; ")"; "!"; "?"|]

type t = {
  mutable uri = string;
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


let iteri_lines_of_file ?(verbose=true) f fname =
  let i = ref 0 in
  let h = open_in fname in
  (
    let t0 = Unix.gettimeofday () in
    let t1 = ref (Unix.gettimeofday ()) in
    try while true do
      f !i (input_line h);
      i := !i + 1;
      (* output summary if in verbose mode *)
      if verbose = true then (
        let t2 = Unix.gettimeofday () in
        if t2 -. !t1 > 5. then (
          t1 := t2;
          let speed = float_of_int !i /. (t2 -. t0) |> int_of_float in
          Log.info "processed %i, avg. %i docs/s" !i speed
        )
      )
    done with End_of_file -> ()
  );
  close_in h


let mapi_lines_of_file f fname =
  let stack = Owl_utils.Stack.make 1024 "" in
  iteri_lines_of_file (fun i s ->
    Owl_utils.Stack.push stack (f i s)
  ) fname;
  Owl_utils.Stack.to_array stack


let num_doc fname =
  let n = ref 0 in
  iteri_lines_of_file (fun i _ -> n := i);
  !n + 1


(* module to process vocabulary in text corpus *)
module Vocabulary = struct

  type t = {
    mutable w2i : (string, int) Hashtbl.t;  (* word -> index *)
    mutable i2w : (int, string) Hashtbl.t;  (* index -> word *)
    mutable i2f : (int, int) Hashtbl.t      (* index -> freq *)
  }

  (* remove extremely low and high frequency words
    lo: the percentage of lower bound
    hi: the percentage of higher bound
    h: the hashtbl of the vocabulary (word, freq)
   *)
  let trim_freq lo hi h =
    let n = Hashtbl.length h in
    let all_freq = Array.make n 0 in
    let i = ref 0 in
    Hashtbl.iter (fun _ freq ->
      all_freq.(!i) <- freq;
      i := !i + 1;
    ) h;
    Array.sort Pervasives.compare all_freq;
    let l0 = float_of_int n *. lo |> int_of_float in
    let h0 = float_of_int n *. hi |> int_of_float in
    let lo = all_freq.(l0) in
    let hi = all_freq.(n - h0) in
    Hashtbl.filter_map_inplace (fun w freq ->
      match freq > lo, freq < hi with
      | true, true -> Some freq
      | _          -> None
    ) h

  (* remove stopwords from vocabulary
    sw: hashtbl contains the vocabulary
   *)
  let remove_stopwords sw h =
  Hashtbl.filter_map_inplace (fun w v ->
    match Hashtbl.mem sw w with
    | true  -> None
    | false -> Some v
  ) h

  (* return both word->index and index->word hashtbl
    lo: percentage of lower bound of word frequency
    hi: percentage of higher bound of word frequency
    fname: file name of the corpus, each line contains a doc
   *)
  let build_from_file ?(lo=0.) ?(hi=1.) ?stopwords fname =
    let w2f = Hashtbl.create (64 * 1024) in
    let f s =
      Str.split (Str.regexp " ") s
      |> List.iter (fun w ->
        match Hashtbl.mem w2f w with
        | true  -> (
            let freq = Hashtbl.find w2f w in
            Hashtbl.replace w2f w (freq + 1)
          )
        | false -> Hashtbl.add w2f w 1
      )
    in
    iteri_lines_of_file (fun _ s -> f s) fname;
    (* trim frequency if necessary *)
    if lo <> 0. || hi <> 1. then
      trim_freq lo hi w2f;
    (* trim stopwords if necessary *)
    (
      match stopwords with
      | Some sw  -> remove_stopwords sw w2f
      | None     -> ()
    );
    (* build w2i and i2w tables from trimmed w2f *)
    Log.info "buidling ...";
    let w2i = Hashtbl.(create (length w2f)) in
    let i2w = Hashtbl.(create (length w2f)) in
    let i2f = Hashtbl.(create (length w2f)) in
    let i = ref 0 in
    Hashtbl.iter (fun w f ->
      Hashtbl.add w2i w !i;
      Hashtbl.add i2w !i w;
      Hashtbl.add i2f !i f;
      i := !i + 1;
    ) w2f;
    Log.info "done ...";
    { w2i; i2w; i2f }

  let word2index d w = Hashtbl.find d.w2i w

  let index2word d i = Hashtbl.find d.i2w i

  let size d = Hashtbl.length d.w2i

  let freq_i d i = Hashtbl.find d.i2f i

  let freq_w d w = w |> word2index d |> freq_i d

  let save d fname = Owl_utils.marshal_to_file d fname

  let load fname = Owl_utils.marshal_from_file fname

  (* return (index, freq) array in increasing or decreasing freq *)
  let sort_freq ?(inc=true) d =
    let all_freq = Array.make (size d) (0, 0) in
    let i = ref 0 in
    Hashtbl.iter (fun j freq ->
      all_freq.(!i) <- (j, freq);
      i := !i + 1;
    ) d.i2f;
    let f = match inc with
      | true  -> fun a b -> Pervasives.compare (snd a) (snd b)
      | false -> fun a b -> Pervasives.compare (snd b) (snd a)
    in
    Array.sort f all_freq;
    all_freq

  (* return k most popular words *)
  let top_k d k =
    let all_freq = sort_freq ~inc:false d in
    Array.sub all_freq 0 k |>
    Array.map (fun (i, freq) -> (index2word d i, freq))

  (* return k least popular words *)
  let bottom_k d k =
    let all_freq = sort_freq ~inc:true d in
    Array.sub all_freq 0 k |>
    Array.map (fun (i, freq) -> (index2word d i, freq))

end



(* ends here *)
