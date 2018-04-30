(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type elt =
  | Int'    of int
  | Float'  of float
  | String' of string
  | Any'


type series =
  | Int_Series    of int array
  | Float_Series  of float array
  | String_Series of string array
  | Any_Series


type t = {
  mutable data : series array;
  mutable head : (string, int) Hashtbl.t;
  mutable used : int;
  mutable size : int;
}


let unpack_int = function Int' x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_float = function Float' x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_string = function String' x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_int_series = function Int_Series x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_float_series = function Float_Series x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_string_series = function String_Series x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let pack_int x = Int' x

let pack_float x = Float' x

let pack_string x = String' x

let pack_int_series x = Int_Series x

let pack_float_series x = Float_Series x

let pack_string_series x = String_Series x


let make head_names =
  let col_num = Array.length head_names in
  let data = Array.make col_num Any_Series in
  let head = Hashtbl.create 64 in
  Array.iteri (fun i s ->
    assert (Hashtbl.mem head s = false);
    Hashtbl.add head s i
  ) head_names;
  let used = 0 in
  let size = 0 in
  { data; head; used; size }


let allocate_space data =
  Array.(map (function
    | Int_Series c    -> Int_Series (append c (copy c))
    | Float_Series c  -> Float_Series (append c (copy c))
    | String_Series c -> String_Series (append c (copy c))
    | Any_Series      -> Any_Series
  ) data)


let set_elt_in_series x i a =
  match a with
  | Int' a    -> (unpack_int_series x).(i) <- a
  | Float' a  -> (unpack_float_series x).(i) <- a
  | String' a -> (unpack_string_series x).(i) <- a
  | Any'      -> ()


let get_elt_in_series x i =
  match x with
  | Int_Series c    -> Int' c.(i)
  | Float_Series c  -> Float' c.(i)
  | String_Series c -> String' c.(i)
  | Any_Series      -> Any'


let init_series n a =
  match a with
  | Int' a    -> Int_Series (Array.make n a)
  | Float' a  -> Float_Series (Array.make n a)
  | String' a -> String_Series (Array.make n a)
  | Any'      -> Any_Series


let length_series = function
  | Int_Series c    -> Array.length c
  | Float_Series c  -> Array.length c
  | String_Series c -> Array.length c
  | Any_Series      -> 0


let elt_to_str = function
  | Int' a    -> string_of_int a
  | Float' a  -> string_of_float a
  | String' a -> a
  | Any'      -> ""


let append x row =
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


let get_head x i = (get_heads x).(i)


let get_row x i = Array.map (fun y -> get_elt_in_series y i) x.data


let get_col x j =
  match x.data.(j) with
  | Int_Series c    -> Int_Series (Array.sub c 0 x.used)
  | Float_Series c  -> Float_Series (Array.sub c 0 x.used)
  | String_Series c -> String_Series (Array.sub c 0 x.used)
  | Any_Series      -> Any_Series


let get_rows x idx = Array.map (get_row x) idx


let get_cols x idx = Array.map (get_col x) idx


let get_col_by_name x name =
  let j = Hashtbl.find x.head name in
  get_col x j


let get_cols_by_name x names = Array.map (get_col_by_name x) names


let get x i j =
  match x.data.(j) with
  | Int_Series c    -> Int' c.(i)
  | Float_Series c  -> Float' c.(i)
  | String_Series c -> String' c.(i)
  | Any_Series      -> Any'


let set x i j a =
  match x.data.(j) with
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


let col_num x = Array.length x.data


let row_num x = x.used


let shape x = row_num x, col_num x


let numel x = (row_num x) * (col_num x)


let to_cols x = x.data


let to_rows x = raise Owl_exception.NOT_IMPLEMENTED


let copy x =
  let head = Hashtbl.copy x.head in
  let used = x.used in
  let size = x.size in
  let data = Array.map (function
    | Int_Series c    -> Int_Series (Array.copy c)
    | Float_Series c  -> Float_Series (Array.copy c)
    | String_Series c -> String_Series (Array.copy c)
    | Any_Series      -> Any_Series
  ) x.data in
  { data; head; used; size }


let concat_horizontal x y =
  assert (row_num x = row_num y);
  let z = copy x in
  let i = ref (col_num x) in
  Hashtbl.iter (fun k v ->
    Hashtbl.add z.head k (v + !i);
    i := !i + 1;
  ) y.head;
  z.data <- Array.append z.data y.data;
  z


let concat_vertical x y = raise Owl_exception.NOT_IMPLEMENTED


let _convert_to_elt = function
  | "%i" -> fun a -> Int' (int_of_string a)
  | "%f" -> fun a -> Float' (float_of_string a)
  | "%s" -> fun a -> String' a
  | _    -> failwith "_convert_to_elt: unsupported type"


let load ?sep types fname =
  let convert_f = Array.map _convert_to_elt types in
  let n = Array.length convert_f in
  let head_names = Array.init n (Printf.sprintf "h#%i") in
  let dataframe = make head_names in
  Owl_io.read_csv_proc ?sep (fun _ line ->
    let row = Array.map2 (fun f a -> f a) convert_f line in
    append dataframe row
  ) fname;
  dataframe


let save ?sep x fname =
  let m, n = shape x in
  let csv = Array.make_matrix m n "" in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      csv.(i).(j) <- elt_to_str (get x i j)
    done;
  done;
  Owl_io.write_csv ?sep csv fname


let ( .%( ) ) x idx = get_by_name x (fst idx) (snd idx)


let ( .%( )<- ) x idx a = set_by_name x (fst idx) (snd idx) a


(* ends here *)
