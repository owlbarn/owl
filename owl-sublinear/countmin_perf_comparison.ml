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
  let l1_norm = ref 0 in
  let rec addloop () =
    match get_data () with
    | Some lst ->
      List.iter (fun s -> HF.incr t s; incr l1_norm) lst;
      let cur_lws = Gc.(stat ()).live_words - init_lws in
      max_lws := max cur_lws !max_lws; addloop ()
    | None -> ()
  in
  addloop ();
  !max_lws, HF.get_table t, !l1_norm

let ctr = ref 0
let get_unique_filename prefix suffix =
  let n = !ctr in
  incr ctr; prefix ^ "_" ^ (string_of_int n) ^ suffix

let plot_comparison epsilon delta true_freqs sketch =
  let open Owl_plplot in
  let freqs = 
    let mapfn (v, ct) = (float_of_int ct, float_of_int (CM.count sketch v)) in
    true_freqs |> List.rev_map mapfn |> Array.of_list
  in
  let h = Plot.create ~m:1 ~n:3 ("plots/comp_plot_logeps" 
                                 ^ string_of_int (int_of_float (log10 epsilon))
                                 ^ "_logdel"
                                 ^ string_of_int (int_of_float (log10 delta))
                                 ^ ".png") in
  Plot.subplot h 0 0;
  let xdata = Owl.Mat.init (Array.length freqs) 1 (fun i -> fst freqs.(i)) in
  let ydata = Owl.Mat.init (Array.length freqs) 1 (fun i -> snd freqs.(i)) in
  Plot.set_title h (Printf.sprintf "epsilon = %f, delta = %f" epsilon delta);
  Plot.set_xlabel h "actual freq";
  Plot.set_ylabel h "estimated freq";
  Plot.scatter ~h xdata ydata;
  Plot.subplot h 0 1;
  Plot.set_title h "log-log scale";
  Plot.set_xlabel h "actual freq";
  Plot.set_ylabel h "estimated freq";
  Plot.loglog ~h ~spec:[LineWidth 0.00000001; Marker "x"; MarkerSize 3.] ~x:xdata ydata;
  Plot.subplot h 0 2;
  let diffs =
    Array.map (fun (tct, sct) -> (sct -. tct) /. tct) freqs
  in
  let diffs_mat = Owl.Mat.init (Array.length diffs) 1 (fun i -> diffs.(i)) in
  Plot.set_title h "histogram";
  Plot.set_xlabel h "relative freq diff";
  Plot.set_ylabel h "bin frequency";
  Plot.histogram ~h ~bin:200 diffs_mat;
  Plot.output h

(* profile a sketch with parameters epsilon and delta on
 * input data against the true frequency profile true_freqs,
 * returning the maximum memory usage and mean estimate error *)
let full_profile epsilon delta get_data true_freqs l1_norm =
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
  plot_comparison epsilon delta true_freqs s;
  let avg_diff = (List.fold_left (+.) 0. freq_diffs) /. 
                  (List.length freq_diffs |> float_of_int) in
  let sorted_arr = freq_diffs 
                   |> List.sort compare 
                   |> Array.of_list in
  let len = Array.length sorted_arr in
  let median_diff = (sorted_arr.((len-1)/2) +. sorted_arr.(len/2)) /. 2. in 
  let l1_diffs =  
    let mapfn (v, ct) = 
      let ct = float_of_int ct in
      let ect = CM.count s v |> float_of_int in
      (ect -. ct) /. l1_norm
    in
    List.rev_map mapfn true_freqs 
  in
  let avg_l1_diff = (List.fold_left (+.) 0. l1_diffs) /. 
                    (List.length freq_diffs |> float_of_int) in
  !max_lws, avg_diff, median_diff, avg_l1_diff


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
  let epsvals = [0.01; 0.001; 0.0001; 0.00001] in
  let del = Sys.argv.(1) |> float_of_string in
  let outf = open_out ("logs/perfcomp_logdel" ^ string_of_int (int_of_float (log10 del)) ^ ".log") in
  let lws_ht, true_freqs, l1_norm = 
    let inch = get_inch_news_txt () in
    get_true_freqs (fun () -> get_data_news_txt inch)
  in
  Printf.fprintf outf "lws_ht = %d, l1_norm = %d\n" lws_ht l1_norm; flush outf;
  let iterfn eps =
    let lws_cm, avg_diff, median_diff, avg_l1_diff = 
      let inch = get_inch_news_txt () in
      full_profile eps del (fun () -> get_data_news_txt inch) true_freqs (float_of_int l1_norm)
    in
    Printf.fprintf outf 
      "eps = %f, del = %f, lws_cm = %d, avg_diff = %f, median_diff = %f, avg_l1_diff = %f\n" 
      eps del lws_cm avg_diff median_diff avg_l1_diff; flush outf
  in
  List.iter iterfn epsvals









