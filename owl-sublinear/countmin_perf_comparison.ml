(* Test the resource usage and accuracy of various 
 * count-min sketches versus a hashtable *)

(* Hashtable-based frequency table *)
module HF = struct
  type 'a t = ('a, int) Hashtbl.t

  let init ?(n=1000) () = Hashtbl.create n

  let count t x =
    match Hashtbl.find_opt t x with
    | Some c -> c
    | None -> 0

  let incr t x = Hashtbl.replace t x (count t x + 1)

  let get_table t = Hashtbl.fold (fun v c acc -> (v, c) :: acc) t []
end

module CM = Owl_base.Countmin_sketch.Native

(* get the true frequency table of input data using a hashtable,
 * also returning the memory usage during this processing *)
let get_true_freqs get_data =
  Gc.compact () ;
  let init_lws = Gc.(stat ()).live_words in
  let t = HF.init () in
  let max_lws = ref (Gc.(stat ()).live_words - init_lws) in
  let rec addloop () =
    match get_data () with
    | Some lst ->
      List.iter (HF.incr t) lst;
      let cur_lws = Gc.(stat ()).live_words - init_lws in
      max_lws := max cur_lws !max_lws; addloop ()
    | None -> ()
  in
  addloop ();
  !max_lws, HF.get_table t


(* profile a sketch with parameters epsilon and delta on
 * input data against the true frequency profile true_freqs,
 * returning the maximum memory usage and mean estimate error *)
let full_profile epsilon delta get_data true_freqs =
  Gc.compact () ;
  let init_lws = Gc.(stat ()).live_words in
  let s = CM.init ~epsilon ~delta in
  let max_lws = ref (Gc.(stat ()).live_words - init_lws) in
  let rec addloop () =
    match get_data () with
    | Some lst ->
      List.iter (CM.incr s) lst; addloop ()
      (* let cur_lws = Gc.(stat ()).live_words - init_lws in
      max_lws := max cur_lws !max_lws; *)
    | None -> ()
  in
  addloop ();
  let freq_diffs =
    let mapfn (v, ct) = 
      let ct = float_of_int ct in
      let ect = CM.count s v |> float_of_int in
      (ect -. ct) /. ct
    in
    List.rev_map mapfn true_freqs 
  in
  let avg_diff = (List.fold_left (+.) 0. freq_diffs) /. 
                  (List.length freq_diffs |> float_of_int) in
  let sorted_arr = freq_diffs 
                   |> List.sort compare 
                   |> Array.of_list in
  let len = Array.length sorted_arr in
  let median_diff = (sorted_arr.((len-1)/2) +. sorted_arr.(len/2)) /. 2. in 
  !max_lws, avg_diff, median_diff


let get_inch_news_txt () = 
  let fn = "news.txt" in
  if not (Sys.file_exists (Owl_dataset.local_data_path () ^ fn)) then
    Owl_dataset.download_data (fn ^ ".gz");
  open_in (Owl_dataset.local_data_path () ^ fn)
  
(* get data from news.txt input source into a list. Closes the
 * file when the end is reached *)
let get_data_news_txt inch =
  let regexp = Str.regexp "[^A-Za-z]+" in
  try
    Some ((input_line inch) |> Str.split regexp)
  with
    End_of_file -> close_in inch; None

let _ = 
  Owl.Log.set_level WARN;
  let epsvals = [0.00001] in
  let del = 0.001 in
  let lws_ht, true_freqs = 
    let inch = get_inch_news_txt () in
    get_true_freqs (fun () -> get_data_news_txt inch)
  in
  Printf.printf "lws_ht = %d\n" lws_ht;
  let iterfn eps =
    let lws_cm, avg_diff, median_diff = 
      let inch = get_inch_news_txt () in
      full_profile eps del (fun () -> get_data_news_txt inch) true_freqs
    in
    Printf.printf "eps = %f, del = %f, lws_cm = %d, avg_diff = %f, median_diff = %f\n" 
                  eps del lws_cm avg_diff median_diff
  in
  List.iter iterfn epsvals









