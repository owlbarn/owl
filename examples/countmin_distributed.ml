#!/usr/bin/env owl
(* This example demonstrates the use of distributed count-min sketches. It
 * fills a single count-min sketch using the news.txt corpus at 
 * https://github.com/ryanrhymes/owl_dataset, then initializes two new empty
 * sketches with the same parameters as the first. It then adds alternate lines from
 * the corpus into each of the two sketches, then merges them into a single sketch.
 * This illustrates how different parts of a data set or stream can be processed into
 * separate sketches in parallel, while still obtaining correct results.
 * WARNING: This example will download the file news.txt.gz (96.5MB) onto
 * your machine and expand it into news.txt (340.3MB).
 *)

module CM = Owl_base.Countmin_sketch.Native

let get_inch_news_txt () = 
  let fn = "news.txt" in
  if not (Sys.file_exists (Owl_dataset.local_data_path () ^ fn)) then
    Owl_dataset.download_data (fn ^ ".gz");
  open_in (Owl_dataset.local_data_path () ^ fn)

let get_line_words inch =
  let regexp = Str.regexp "[^A-Za-z]+" in
  try
    Some ((input_line inch) |> Str.split regexp)
  with
    End_of_file -> None

let fill_one_sketch inch s =
  let rec aux () =
    match get_line_words inch with
    | Some lst -> List.iter (CM.incr s) lst; aux ()
    | None -> s in
  aux ()

let fill_two_sketches inch (s0, s1) =
  let rec aux par =
    match get_line_words inch with
    | Some lst -> 
      let sc = if par then s0 else s1 in
      List.iter (CM.incr sc) lst; aux (not par)
    | None -> s0, s1 in
  aux true

let _ = 
  let single_sketch = 
    let inch = get_inch_news_txt () in
    CM.init ~epsilon:0.001 ~delta:1e-06 |> fill_one_sketch inch 
  in
  let split_merge_sketch = 
    let inch = get_inch_news_txt () in
    (* initialize from single_sketch to ensure both sketches have same 
     * hash function parameters and are thus comparable *)
    let s0 = CM.init_from single_sketch in 
    let s1 = CM.init_from s0 in
    let s0', s1' = fill_two_sketches inch (s0,s1) in
    CM.merge s0' s1'
  in
  Printf.printf "%b\n" (single_sketch = split_merge_sketch)
