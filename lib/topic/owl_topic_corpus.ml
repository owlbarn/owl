(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let default_punctuation = [|"."; ","; ":"; ";"; "("; ")"; "!"; "?"|]

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


let iteri_lines_of_file ?(verbose=true) f file_name =
  let i = ref 0 in
  let h = open_in file_name in
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
          Log.info "processed %i, avg. %i lines/s" !i speed
        )
      )
    done with End_of_file -> ()
  );
  close_in h


let mapi_lines_of_file f file_name =
  let stack = Owl_utils.Stack.make 1024 "" in
  iteri_lines_of_file (fun i s ->
    Owl_utils.Stack.push stack (f i s)
  ) file_name;
  Owl_utils.Stack.to_array stack


(* remove extremely low and high frequency words
  lo: the percentage of lower bound
  hi: the percentage of higher bound
  h: the hashtbl of the vocabulary
 *)
let trim_vocabulary lo hi h =
  let n = Hashtbl.length h in
  let all_freq = Array.make n 0 in
  let i = ref 0 in
  Hashtbl.iter (fun _ (_, freq) ->
    all_freq.(!i) <- freq;
    i := !i + 1;
  ) h;
  Array.sort Pervasives.compare all_freq;
  let l0 = float_of_int n *. lo |> int_of_float in
  let h0 = float_of_int n *. hi |> int_of_float in
  let lo = all_freq.(l0) in
  let hi = all_freq.(n - h0) in
  Hashtbl.filter_map_inplace (fun w (index, freq) ->
    match freq > lo, freq < hi with
    | true, true -> Some (index, freq)
    | _          -> None
  ) h

(* return both word->index and index->word hashtbl *)
let build_vocabulary_of_file file_name =
  let w2i = Hashtbl.create (64 * 1024) in
  let f s =
    Str.split (Str.regexp " ") s
    |> List.iter (fun w ->
      match Hashtbl.mem w2i w with
      | true  -> (
          let index, freq = Hashtbl.find w2i w in
          Hashtbl.replace w2i w (index, freq + 1)
        )
      | false -> Hashtbl.add w2i w (0,0)
    )
  in
  iteri_lines_of_file (fun _ s -> f s) file_name;
  w2i


(* ends here *)
