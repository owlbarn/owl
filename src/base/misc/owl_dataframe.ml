(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


type elt =
  | Bool   of bool
  | Int    of int
  | Float  of float
  | String of string
  | Any


type series =
  | Bool_Series   of bool array
  | Int_Series    of int array
  | Float_Series  of float array
  | String_Series of string array
  | Any_Series


type t = {
  mutable data : series array;             (* column-based table, each column is a time series *)
  mutable head : (string, int) Hashtbl.t;  (* head and index of each column, stored in a hash table *)
  mutable used : int;                      (* sise of the used buffer space *)
  mutable size : int;                      (* size of the allocated buffer *)
}


let unpack_bool = function Bool x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_int = function Int x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_float = function Float x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_string = function String x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_bool_series = function Bool_Series x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_int_series = function Int_Series x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_float_series = function Float_Series x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_string_series = function String_Series x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let pack_bool x = Bool x

let pack_int x = Int x

let pack_float x = Float x

let pack_string x = String x

let pack_bool_series x = Bool_Series x

let pack_int_series x = Int_Series x

let pack_float_series x = Float_Series x

let pack_string_series x = String_Series x


let allocate_space data =
  Array.(map (function
    | Bool_Series c   -> Bool_Series (append c (copy c))
    | Int_Series c    -> Int_Series (append c (copy c))
    | Float_Series c  -> Float_Series (append c (copy c))
    | String_Series c -> String_Series (append c (copy c))
    | Any_Series      -> Any_Series
  ) data)


let set_elt_in_series x i = function
  | Bool a   -> (unpack_bool_series x).(i) <- a
  | Int a    -> (unpack_int_series x).(i) <- a
  | Float a  -> (unpack_float_series x).(i) <- a
  | String a -> (unpack_string_series x).(i) <- a
  | Any      -> ()


let get_elt_in_series x i =
  match x with
  | Bool_Series c   -> Bool c.(i)
  | Int_Series c    -> Int c.(i)
  | Float_Series c  -> Float c.(i)
  | String_Series c -> String c.(i)
  | Any_Series      -> Any


let init_series n = function
  | Bool a   -> Bool_Series (Array.make n a)
  | Int a    -> Int_Series (Array.make n a)
  | Float a  -> Float_Series (Array.make n a)
  | String a -> String_Series (Array.make n a)
  | Any      -> Any_Series


let resize_series n = function
  | Bool_Series c   -> Bool_Series (Owl_utils_array.resize ~head:true true n c)
  | Int_Series c    -> Int_Series (Owl_utils_array.resize ~head:true 0 n c)
  | Float_Series c  -> Float_Series (Owl_utils_array.resize ~head:true 0. n c)
  | String_Series c -> String_Series (Owl_utils_array.resize ~head:true "" n c)
  | Any_Series      -> Any_Series


let append_series x y =
  match x, y with
  | Bool_Series x, Bool_Series y     -> Bool_Series (Array.append x y)
  | Int_Series x, Int_Series y       -> Int_Series (Array.append x y)
  | Float_Series x, Float_Series y   -> Float_Series (Array.append x y)
  | String_Series x, String_Series y -> String_Series (Array.append x y)
  | Any_Series, Any_Series           -> Any_Series
  | _                                -> failwith "append_series: unsupported type"


let length_series = function
  | Bool_Series c   -> Array.length c
  | Int_Series c    -> Array.length c
  | Float_Series c  -> Array.length c
  | String_Series c -> Array.length c
  | Any_Series      -> 0


let slice_series slice = function
  | Bool_Series c   -> Bool_Series (Owl_utils_array.get_slice slice c)
  | Int_Series c    -> Int_Series (Owl_utils_array.get_slice slice c)
  | Float_Series c  -> Float_Series (Owl_utils_array.get_slice slice c)
  | String_Series c -> String_Series (Owl_utils_array.get_slice slice c)
  | Any_Series      -> Any_Series


let argsort_series = function
  | Bool_Series c   -> Owl_utils_array.argsort ~cmp:Pervasives.compare c
  | Int_Series c    -> Owl_utils_array.argsort ~cmp:Pervasives.compare c
  | Float_Series c  -> Owl_utils_array.argsort ~cmp:Pervasives.compare c
  | String_Series c -> Owl_utils_array.argsort ~cmp:Pervasives.compare c
  | Any_Series      -> [||]


let min_series = function
  | Bool_Series c   -> Owl_utils_array.min_i ~cmp:Pervasives.compare c
  | Int_Series c    -> Owl_utils_array.min_i ~cmp:Pervasives.compare c
  | Float_Series c  -> Owl_utils_array.min_i ~cmp:Pervasives.compare c
  | String_Series c -> Owl_utils_array.min_i ~cmp:Pervasives.compare c
  | Any_Series      -> -1


let max_series = function
  | Bool_Series c   -> Owl_utils_array.max_i ~cmp:Pervasives.compare c
  | Int_Series c    -> Owl_utils_array.max_i ~cmp:Pervasives.compare c
  | Float_Series c  -> Owl_utils_array.max_i ~cmp:Pervasives.compare c
  | String_Series c -> Owl_utils_array.max_i ~cmp:Pervasives.compare c
  | Any_Series      -> -1


let remove_ith_elt i = function
  | Bool_Series c   -> Bool_Series (Owl_utils_array.remove c i)
  | Int_Series c    -> Int_Series (Owl_utils_array.remove c i)
  | Float_Series c  -> Float_Series (Owl_utils_array.remove c i)
  | String_Series c -> String_Series (Owl_utils_array.remove c i)
  | Any_Series      -> Any_Series


let insert_ith_elt i e = function
  | Bool_Series c   -> Bool_Series (Owl_utils_array.insert c [|unpack_bool e|] i)
  | Int_Series c    -> Int_Series (Owl_utils_array.insert c [|unpack_int e|] i)
  | Float_Series c  -> Float_Series (Owl_utils_array.insert c [|unpack_float e|] i)
  | String_Series c -> String_Series (Owl_utils_array.insert c [|unpack_string e|] i)
  | Any_Series      -> Any_Series


let elt_to_str = function
  | Bool a   -> string_of_bool a
  | Int a    -> string_of_int a
  | Float a  -> string_of_float a
  | String a -> a
  | Any      -> ""


let series_type_to_str = function
  | Bool_Series c   -> "b"
  | Int_Series c    -> "i"
  | Float_Series c  -> "f"
  | String_Series c -> "s"
  | Any_Series      -> "a"


let str_to_elt_fun = function
  | "b" -> fun a -> Bool (bool_of_string a)
  | "i" -> fun a -> Int (int_of_string a)
  | "f" -> fun a -> if a = "" then Float nan else Float (float_of_string a)
  | "s" -> fun a -> String a
  | _   -> failwith "str_to_elt_fun: unsupported type"


let make ?data head_names =
  let col_num = Array.length head_names in
  let head = Hashtbl.create 64 in
  (* check the head names are unique *)
  Array.iteri (fun i s ->
    assert (Hashtbl.mem head s = false);
    Hashtbl.add head s i
  ) head_names;
  let data = match data with
    | Some a -> a
    | None   -> Array.make col_num Any_Series
  in
  assert (Array.length data = col_num);
  (* calculate the actual number of rows *)
  let size =
    if col_num = 0 then 0
    else length_series data.(0)
  in
  let used = size in
  (* check all the series have the same length *)
  Array.iter (fun c -> assert (length_series c = size)) data;
  (* return the generated frame *)
  { data; head; used; size }


let col_num x = Array.length x.data


let row_num x = x.used


let shape x = row_num x, col_num x


let numel x = (row_num x) * (col_num x)


let types x = Array.map series_type_to_str x.data


let append_row x row =
  assert (col_num x = Array.length row);
  if x.size = 0 then (
    let n = 16 in
    x.data <- Array.map (init_series n) row;
    x.size <- n;
    x.used <- 1
  )
  else (
    if x.used = x.size then (
      x.data <- allocate_space x.data;
      x.size <- length_series x.data.(0)
    );
    Array.iteri (fun i a -> set_elt_in_series x.data.(i) x.used a) row;
    x.used <- x.used + 1
  )


let append_col x col head =
  let m, n = shape x in
  assert (m = length_series col);
  let col = resize_series x.size col in
  Hashtbl.add x.head head n;
  x.data <- Array.append x.data [| col |]


let get_heads x =
  let kv = Hashtbl.fold (fun k v acc -> Array.append acc [|(k,v)|]) x.head [||] in
  Array.sort (fun a b -> (snd a) - (snd b)) kv;
  Array.map fst kv


let set_heads x head_names =
  assert (Array.length head_names = Array.length x.data);
  let head = Hashtbl.create 64 in
  Array.iteri (fun i s ->
    assert (Hashtbl.mem head s = false);
    Hashtbl.add head s i
  ) head_names;
  x.head <- head


let remove_row x i =
  let i = Owl_utils_ndarray.adjust_index i (row_num x) in
  let new_data = Array.map (fun s -> remove_ith_elt i s) x.data in
  x.data <- new_data;
  x.used <- x.used - 1;
  x.size <- x.size - 1


let remove_col x j =
  let j = Owl_utils_ndarray.adjust_index j (col_num x) in
  x.data <- Owl_utils_array.filteri (fun i _ -> i <> j) x.data;
  let new_head = Owl_utils_array.filteri (fun i _ -> i <> j) (get_heads x) in
  set_heads x new_head


let insert_row x i row =
  let i = Owl_utils_ndarray.adjust_index i (row_num x) in
  if x.size = 0 then (
    let n = 16 in
    x.data <- Array.map (init_series n) row;
    x.size <- n;
    x.used <- 1
  )
  else (
    if x.used = x.size then (
      x.data <- allocate_space x.data;
      x.size <- length_series x.data.(0)
    );
    let new_data = Array.mapi (fun j s -> insert_ith_elt i row.(j) s) x.data in
    x.data <- new_data;
    x.used <- x.used + 1;
    x.size <- x.size + 1
  )


let insert_col x j col_head col =
  let j = Owl_utils_ndarray.adjust_index j (col_num x) in
  let new_data = Owl_utils_array.insert x.data [|col|] j in
  x.data <- new_data;
  let new_head = Owl_utils_array.insert (get_heads x) [|col_head|] j in
  set_heads x new_head


let id_to_head x i = (get_heads x).(i)


let head_to_id x name = Hashtbl.find x.head name


let get_row x i = Array.map (fun y -> get_elt_in_series y i) x.data


let get_col x j =
  match x.data.(j) with
  | Bool_Series c   -> Bool_Series (Array.sub c 0 x.used)
  | Int_Series c    -> Int_Series (Array.sub c 0 x.used)
  | Float_Series c  -> Float_Series (Array.sub c 0 x.used)
  | String_Series c -> String_Series (Array.sub c 0 x.used)
  | Any_Series      -> Any_Series


let get_rows x idx = Array.map (get_row x) idx


let get_cols x idx = Array.map (get_col x) idx


(* TODO *)
let get_row_assoc x idx = raise Owl_exception.NOT_IMPLEMENTED


let get_col_by_name x name =
  let j = Hashtbl.find x.head name in
  get_col x j


let get_cols_by_name x names = Array.map (get_col_by_name x) names


let get x i j =
  match x.data.(j) with
  | Bool_Series c   -> Bool c.(i)
  | Int_Series c    -> Int c.(i)
  | Float_Series c  -> Float c.(i)
  | String_Series c -> String c.(i)
  | Any_Series      -> Any


let set x i j a =
  match x.data.(j) with
  | Bool_Series c   -> c.(i) <- (unpack_bool a)
  | Int_Series c    -> c.(i) <- (unpack_int a)
  | Float_Series c  -> c.(i) <- (unpack_float a)
  | String_Series c -> c.(i) <- (unpack_string a)
  | Any_Series      -> ()


let get_by_name x i name =
  let j = Hashtbl.find x.head name in
  get x i j

let set_by_name x i name a =
  let j = Hashtbl.find x.head name in
  set x i j a


let to_cols x = x.data


let to_rows x =
  let stack = Owl_utils.Stack.make () in
  let m = row_num x in
  for i = 0 to m - 1 do
    Owl_utils.Stack.push stack (get_row x i)
  done;
  Owl_utils.Stack.to_array stack


let copy x =
  let head = Hashtbl.copy x.head in
  let used = x.used in
  let size = x.size in
  let data = Array.map (function
    | Bool_Series c   -> Bool_Series (Array.copy c)
    | Int_Series c    -> Int_Series (Array.copy c)
    | Float_Series c  -> Float_Series (Array.copy c)
    | String_Series c -> String_Series (Array.copy c)
    | Any_Series      -> Any_Series
  ) x.data in
  { data; head; used; size }


let copy_struct x =
  let head = Hashtbl.copy x.head in
  let used = 0 in
  let size = 0 in
  let data = Array.map (function
    | Bool_Series c   -> Bool_Series [||]
    | Int_Series c    -> Int_Series [||]
    | Float_Series c  -> Float_Series [||]
    | String_Series c -> String_Series [||]
    | Any_Series      -> Any_Series
  ) x.data in
  { data; head; used; size }


let reset x =
  x.used <- 0;
  x.size <- 0;
  x.data <- Array.map (function
    | Bool_Series c   -> Bool_Series [||]
    | Int_Series c    -> Int_Series [||]
    | Float_Series c  -> Float_Series [||]
    | String_Series c -> String_Series [||]
    | Any_Series      -> Any_Series
  ) x.data


let concat_horizontal x y =
  assert (row_num x = row_num y);
  let head = Hashtbl.copy x.head in
  let col_num_x = col_num x in
  Hashtbl.iter (fun k v ->
    Hashtbl.add head k (v + col_num_x);
  ) y.head;
  let col_num_y = col_num y in
  let data = Array.make (col_num_x + col_num_y) Any_Series in
  let size = max x.size y.size in
  for i = 0 to col_num_x - 1 do
    data.(i) <- resize_series size x.data.(i)
  done;
  for i = 0 to col_num_y - 1 do
    data.(col_num_x + i) <- resize_series size y.data.(i)
  done;
  { data; head; used = x.used; size }


let concat_vertical x y =
  assert (col_num x = col_num y);
  let head = Hashtbl.copy x.head in
  let used = x.used + y.used in
  let data = Array.make (col_num x) Any_Series in
  for i = 0 to (col_num x) - 1 do
    let sx = get_col x i in
    let j = id_to_head x i |> head_to_id y in
    let sy = get_col y j in
    data.(i) <- append_series sx sy
  done;
  { data; head; used; size = used }


let iteri_row f x =
  let m = row_num x in
  for i = 0 to m - 1 do
    f i (get_row x i)
  done


let iter_row f x = iteri_row (fun _ row -> f row) x


let mapi_row f x =
  let head = Hashtbl.copy x.head in
  let used = 0 in
  let size = 0 in
  let data = Array.map (fun _ -> Any_Series) x.data in
  let y = { data; head; used; size } in
  iteri_row (fun i row -> append_row y (f i row)) x;
  y


let map_row f x = mapi_row (fun _ row -> f row) x


let filteri_row f x =
  let head = Hashtbl.copy x.head in
  let used = 0 in
  let size = 0 in
  let data = Array.map (fun _ -> Any_Series) x.data in
  let y = { data; head; used; size } in
  iteri_row (fun i row ->
    if f i row = true then append_row y row
  ) x;
  y


let filter_row f x = filteri_row (fun _ row -> f row) x


let filter_mapi_row f x =
  let head = Hashtbl.copy x.head in
  let used = 0 in
  let size = 0 in
  let data = Array.map (fun _ -> Any_Series) x.data in
  let y = { data; head; used; size } in
  iteri_row (fun i row ->
    match f i row with
    | Some r -> append_row y r
    | None   -> ()
  ) x;
  y


let filter_map_row f x = filter_mapi_row (fun _ row -> f row) x


let get_slice slice x =
  let slice = Array.(map of_list (of_list slice)) |> Array.map (fun s -> R_ s) in
  let shp_x = [|row_num x; col_num x|] in
  let _tmp0 = Owl_base_slicing.check_slice_definition slice shp_x in
  let slice = Array.map (function R_ s -> s | _ -> failwith "get_slice: unsupported") _tmp0 in
  let name = Owl_utils_array.get_slice slice.(1) (get_heads x) in
  let data = Array.map (head_to_id x) name |> get_cols x |> Array.map (slice_series slice.(0)) in
  let used = length_series data.(0) in
  let head = Hashtbl.create (Array.length name) in
  Array.iteri (fun i s -> Hashtbl.add head s i) name;
  { data; head; used; size = used }


(* TODO *)
let set_slice x = raise Owl_exception.NOT_IMPLEMENTED


let get_slice_by_name slice x =
  let row_slice = Array.of_list (fst slice) in
  let col_slice = Array.of_list (snd slice) in
  let shp_x = [|row_num x; col_num x|] in
  let refmt = Owl_base_slicing.check_slice_definition [| R_ row_slice |] shp_x in
  let row_slice = (function R_ s -> s | _ -> failwith "get_slice: unsupported") refmt.(0) in

  let col_slice =
    if Array.length col_slice = 0 then get_heads x
    else col_slice
  in
  let data = Array.map (slice_series row_slice) (get_cols_by_name x col_slice) in
  let used = length_series data.(0) in
  let head = Hashtbl.create (Array.length col_slice) in

  Array.iteri (fun i s -> Hashtbl.add head s i) col_slice;
  { data; head; used; size = used }


(* TODO *)
let set_slice_by_name x = raise Owl_exception.NOT_IMPLEMENTED


let head n x =
  let m = row_num x in
  assert (n > 0 && n <= m);
  get_slice [[0;n-1];[]] x


let tail n x =
  let m = row_num x in
  assert (n > 0 && n <= m);
  get_slice [[-n;-1];[]] x


let min_i x head =
  let series = get_col_by_name x head in
  min_series series


let max_i x head =
  let series = get_col_by_name x head in
  max_series series


let sort ?(inc=true) x head =
  let series = get_col_by_name x head in
  let indices = argsort_series series in
  if inc = false then Owl_utils_array.reverse indices;
  let y = copy_struct x in
  Array.iter (fun i ->
    get_row x i |> append_row y
  ) indices;
  y


let guess_separator lines =
  let sep = [|','; ' '; '\t'; ';'; ':'; '|'|] in
  (* rank by dividing as many parts as possible *)
  let tmp = Array.map (fun c ->
    let l = String.split_on_char c lines.(0) in
    c, List.length l
  ) sep
  in
  (* sort by decreasing order *)
  Array.sort (fun a b -> (snd b) - (snd a)) tmp;
  let sep = Array.map fst tmp in

  let not_sep = ref true in
  let sep_idx = ref 0 in

  while !not_sep = true do
    let c = sep.(!sep_idx) in
    let n = String.split_on_char c lines.(0) |> List.length in
    (
      try (
        Array.iter (fun line ->
          let m = String.split_on_char c line |> List.length in
          if m <> n then raise Owl_exception.FOUND
        ) lines;
        not_sep := false
      )
      with exn -> ()
    );
    if !not_sep = true then sep_idx := !sep_idx + 1
  done;

  (* if cannot detect, return comma as default sep *)
  if !not_sep = false then sep.(!sep_idx)
  else ','


let guess_types sep lines =
  (* Note: no need to add "s" since it is default type *)
  let typ = [|"b"; "i"; "f"|] in
  let num_lines = Array.length lines in
  (* at least two lines because the first one will be dropped *)
  assert (num_lines > 1);

  let num_cols = lines.(0)
    |> String.trim
    |> String.split_on_char sep
    |> List.length
  in

  (* split into separate columns *)
  let stacks = Array.init num_cols (fun _ -> Owl_utils_stack.make ()) in
  Array.iteri (fun i line ->
    if i > 0 then
      String.trim line
      |> String.split_on_char sep
      |> List.iteri (fun i c -> Owl_utils_stack.push stacks.(i) c)
  ) lines;
  let cols = Array.map Owl_utils_stack.to_array stacks in

  (* guess the types of columns *)
  Array.mapi (fun i col ->
    let guess_typ = ref "s" in
    (
      try
        Array.iter (fun col_typ ->
          let typ_fun = str_to_elt_fun col_typ in
          let wrong_guess = ref false in
          (
            try
              Array.iter (fun x ->
                let y = String.trim x in
                typ_fun y |> ignore
              ) col
            with exn -> wrong_guess := true
          );
          if !wrong_guess = false then (
            guess_typ := col_typ;
            raise Owl_exception.FOUND
          )
        ) typ
      with exn -> ()
    );
    !guess_typ
  ) cols


let of_csv ?sep ?head ?types fname =
  let lines = Owl_io.head 100 fname in
  let sep = match sep with
    | Some a -> a
    | None   -> guess_separator lines
  in
  let head_i = 0 in
  let head_names = match head with
    | Some a -> a
    | None   -> Owl_io.csv_head ~sep head_i fname
  in
  let types = match types with
    | Some a -> a
    | None   -> guess_types sep lines
  in
  assert (Array.length head_names = Array.length types);
  let convert_f = Array.map str_to_elt_fun types in
  let dataframe = make head_names in
  let dropped_line = ref 0 in

  Owl_io.read_csv_proc ~sep (fun i line ->
    try
      if i <> head_i then (
        let row = Array.map2 (fun f a -> f a) convert_f line in
        append_row dataframe row
      )
    with exn -> (
      dropped_line := !dropped_line + 1;
      Owl_log.warn "of_csv: fail to parse line#%i @ %s" i fname
    )
  ) fname;

  if !dropped_line > 0 then
    Owl_log.warn "%i lines have been dropped." !dropped_line;

  dataframe


let to_csv ?sep x fname =
  let m, n = shape x in
  (* include heads as the first line *)
  let csv = Array.make_matrix (m + 1) n "" in
  csv.(0) <- get_heads x;

  (* dump the data into the table *)
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      csv.(i + 1).(j) <- elt_to_str (get x i j)
    done;
  done;

  Owl_io.write_csv ?sep csv fname


(* let print x = Owl_pretty.pp_dataframe Format.std_formatter x *)


let ( .%( ) ) x idx = get_by_name x (fst idx) (snd idx)


let ( .%( )<- ) x idx a = set_by_name x (fst idx) (snd idx) a


let ( .?( ) ) x f = filter_row f x


let ( .?( )<- ) x f g =
  filter_map_row (fun r -> if f r = true then Some (g r) else None) x


let ( .$( ) ) x slice = get_slice_by_name slice x


(* TODO *)
let ( .$( )<- ) x idx a = raise Owl_exception.NOT_IMPLEMENTED



(* ends here *)
