(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** Ndarray pretty printing  *)

let _calc_col_width table col_idx =
  let col_width = ref 0 in
  for row_idx = 0 to Array.length table - 1 do
    let w = String.length table.(row_idx).(col_idx) in
    col_width := max !col_width w
  done;
  !col_width


let _align_str s n =
  let w = max 0 (n - String.length s) in
  (String.make w ' ') ^ s


let _reshape_ndarray x =
  let shape = Bigarray.Genarray.dims x in
  let n = shape.(Bigarray.Genarray.num_dims x - 1) in
  let m = (Array.fold_left ( * ) 1 shape) / n in
  let y = Bigarray.reshape x [|m;n|] in
  y, m, n


let _chunk_table max_row max_col row_num col_num =
  let _discontinuous max_w w =
    let half = max_w / 2 in
    let fst_half = Array.init half (fun i -> i) in
    let snd_half = Array.init half (fun i -> i + w - half) in
    Array.(append (append fst_half [|-1|]) snd_half)
  in
  let row_indices =
    match row_num <= max_row with
    | true  -> Array.init row_num (fun i -> i)
    | false -> _discontinuous max_row row_num
  in
  let col_indices =
    match col_num <= max_col with
    | true  -> Array.init col_num (fun i -> i)
    | false -> _discontinuous max_col col_num
  in
  row_indices, col_indices


let _make_header ?(row_prefix="R") ?(col_prefix="C") row_indices col_indices shape x =
  let stride = Owl_utils.calc_stride shape in
  let dim_num = Array.length shape in
  let col_num = shape.(dim_num - 1) in
  let row_header = Array.map (fun i ->
    if i < 0 then ""
    else (
      let idx_1d = i * col_num in
      let idx_nd = Array.copy stride in
      Owl_utils.index_1d_nd idx_1d idx_nd stride;
      let idx_nd = Array.(sub idx_nd 0 (dim_num - 1)) in
      let idx_s = match dim_num with
        | 1 -> ""
        | 2 -> string_of_int idx_nd.(0)
        | _ -> Owl_utils_array.to_string ~prefix:"[" ~suffix:"]" string_of_int idx_nd
      in
      Printf.sprintf "%s%s" row_prefix idx_s
    )
  ) row_indices
  in
  let col_header = Array.map (fun i ->
    if i < 0 then "" else Printf.sprintf "%s%i" col_prefix i
  ) col_indices
  in
  row_header, col_header


let _fill_table elt_to_str_fun get_elt_fun row_indices col_indices x =
  let m = Array.length row_indices in
  let n = Array.length col_indices in
  let table = Array.make_matrix m n "" in

  Array.iteri (fun i i' ->
    Array.iteri (fun j j' ->
      if i' < 0 || j' < 0 then
        table.(i).(j) <- "..."
      else (
        let e = get_elt_fun x i' j' in
        let s = elt_to_str_fun e in
        table.(i).(j) <- s
      )
    ) col_indices
  ) row_indices;

  table


let _glue_headers row_header col_header table =
  let table = Array.append [|col_header|] table in
  let row_header = Array.append [|""|] row_header in
  Array.mapi (fun i row ->
    Array.append [|row_header.(i)|] row
  ) table


let _format_table hline table =
  let row_num = Array.length table in
  let col_num = Array.length table.(0) in
  let col_width = Array.init col_num (fun i -> _calc_col_width table i) in
  let out_s = ref "\n" in

  for i = 0 to row_num - 1 do
    (* print hline if necessary *)
    if hline = true && i < 2 then (
      let hline = Array.init col_num (fun j ->
        if j = 0 then String.make col_width.(j) ' '
        else "+" ^ String.make col_width.(j) '-'
      )
      in
      let s = Array.fold_left (fun acc a -> acc ^ a) "" hline in
      out_s := !out_s ^ s ^ "\n";
    );
    (* print rest of content *)
    for j = 0 to col_num - 1 do
      let new_s = _align_str table.(i).(j) col_width.(j) in
      out_s := !out_s ^ new_s ^ " "
    done;
    out_s := !out_s ^ "\n"
  done;

  !out_s


let dsnda_to_string ?(header=true) ?(max_row=10) ?(max_col=10) ?elt_to_str_fun x =
  let elt_to_str_fun =
    match elt_to_str_fun with
    | Some f -> f
    | None   -> Owl_utils.elt_to_str (Bigarray.Genarray.kind x)
  in
  let get_elt_fun x i j = Bigarray.Genarray.get x [|i; j|] in

  if Bigarray.Genarray.num_dims x = 0 then (
    (* special case: rank = 0 *)
    elt_to_str_fun (Bigarray.Genarray.get x [||])
  )
  else (
    (* common case: rank > 0 *)
    let x_shape = Bigarray.Genarray.dims x in
    let y, row_num, col_num = _reshape_ndarray x in
    let row_indices, col_indices = _chunk_table max_row max_col row_num col_num in
    let tbody = _fill_table elt_to_str_fun get_elt_fun row_indices col_indices y in
    let row_header, col_header = _make_header row_indices col_indices x_shape x in
    let table = match header with
      | true  -> _glue_headers row_header col_header tbody
      | false -> tbody
    in
    _format_table false table
  )


let print_table ?header ?max_row ?max_col ?elt_to_str_fun formatter x =
  let s = dsnda_to_string ?header ?max_row ?max_col ?elt_to_str_fun x in
  Format.open_box 0;
  Format.fprintf formatter "%s" s;
  Format.close_box ()


let pp_dsnda formatter x = print_table formatter x


let print_dsnda ?header ?max_row ?max_col ?elt_to_str_fun ?(formatter=Format.std_formatter) x =
  print_table ?header ?max_row ?max_col ?elt_to_str_fun formatter x


(** Dataframe pretty printing *)

let dataframe_to_string ?(header=true) ?names ?(max_row=40) ?(max_col=10) ?elt_to_str_fun x =
  let elt_to_str_fun =
    match elt_to_str_fun with
    | Some f -> f
    | None   -> Owl_dataframe.elt_to_str
  in
  let get_elt_fun x i j = Owl_dataframe.get x i j in

  let x_shape = Owl_dataframe.([|row_num x; col_num x|]) in
  let row_num, col_num = Owl_dataframe.shape x in
  let row_indices, col_indices = _chunk_table max_row max_col row_num col_num in
  let tbody = _fill_table elt_to_str_fun get_elt_fun row_indices col_indices x in
  let row_header, col_header = _make_header row_indices col_indices x_shape x in

  (* rewrite column header if names is not None ... *)
  let col_header =
    if header = true then
      match names with
      | Some c -> Array.map (fun j -> if j < 0 then "" else c.(j)) col_indices
      | None   -> col_header
    else col_header
  in

  let table = match header with
    | true  -> _glue_headers row_header col_header tbody
    | false -> tbody
  in
  _format_table header table


let print_dataframe ?header ?names ?max_row ?max_col ?elt_to_str_fun formatter x =
  let s = dataframe_to_string ?header ?names ?max_row ?max_col ?elt_to_str_fun x in
  Format.open_box 0;
  Format.fprintf formatter "%s" s;
  Format.close_box ()


let pp_dataframe formatter x =
  let names = Owl_dataframe.get_heads x in
  print_dataframe ~names formatter x
