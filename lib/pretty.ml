(* File: io.ml

   Copyright (C) 2005-

     Markus Mottl
     email: markus.mottl@gmail.com
     WWW: http://www.ocaml.info

     Jane Street Holding, LLC
     Author: Markus Mottl
     email: markus.mottl@gmail.com
     WWW: http://www.ocaml.info

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*)

open Format
open Bigarray
open Complex

let from_col_vec v = reshape_2 (genarray_of_array1 v) (Array1.dim v) 1
let from_row_vec v = reshape_2 (genarray_of_array1 v) 1 (Array1.dim v)

let pp_open ppf = pp_open_box ppf 0
let pp_close ppf = pp_close_box ppf ()
let pp_newline ppf = pp_force_newline ppf ()
let pp_space ppf = pp_print_string ppf " "

let pp_end_row_newline ppf _ = pp_newline ppf
let pp_end_row_space ppf _ = pp_space ppf
let pp_end_col_space ppf ~row:_ ~col:_ = pp_space ppf

let pad_str pad_c max_len str =
  let str_len = String.length str in
  let diff = max_len - str_len in
  if diff = 0 then str
  else
    let res = Bytes.make max_len pad_c in
    Bytes.blit_string str 0 res diff str_len;
    Bytes.unsafe_to_string res

let pp_padded_str ppf pad_c max_len str =
  pp_print_string ppf (pad_str pad_c max_len str)

let some_space = Some ' '

let extract_buf buf buf_ppf =
  pp_print_flush buf_ppf ();
  let str = Buffer.contents buf in
  Buffer.clear buf;
  str, String.length str

let pp_el_buf pp_el buf buf_ppf el =
  pp_el buf_ppf el;
  extract_buf buf buf_ppf

let pp_buf pp buf buf_ppf =
  pp buf_ppf;
  extract_buf buf buf_ppf

let ignore2 _ _ = ()

module Context = struct
  type t = int

  let create n =
    if n < 1 then failwith "Context.create: n < 1"
    else n

  let ellipsis_default = ref "..."

  let vertical_default, horizontal_default =
    (** TODO: check terminal type and auto configure the size *)
    let context = if !Sys.interactive then Some 5 else None in
    ref context, ref context

  let set_dim_defaults opt_n =
    vertical_default := opt_n;
    horizontal_default := opt_n

  let get_disp real = function
    | None -> real, real
    | Some virt -> min real (2 * virt), virt
end

let pp_mat_gen
    ?(pp_open = pp_open)
    ?(pp_close = pp_close)
    ?pp_head
    ?pp_foot
    ?(pp_end_row = pp_end_row_newline)
    ?(pp_end_col = pp_end_col_space)
    ?pp_left
    ?pp_right
    ?(pad = some_space)
    ?(ellipsis = !Context.ellipsis_default)
    ?(vertical_context = !Context.vertical_default)
    ?(horizontal_context = !Context.horizontal_default)
    pp_el ppf mat =
  let m = Array2.dim1 mat in
  if m > 0 then (
    let n = Array2.dim2 mat in
    if n > 0 then (
      let disp_m, vertical_context = Context.get_disp m vertical_context in
      let disp_n, horizontal_context = Context.get_disp n horizontal_context in
      pp_open ppf;
      let do_pp_right =
        match pp_right with
        | None -> ignore2
        | Some pp_right ->
            let buf = Buffer.create 32 in
            let buf_ppf = formatter_of_buffer buf in
            (fun ppf row ->
              let str, n_str =
                pp_buf (fun ppf -> pp_right ppf row) buf buf_ppf in
              if n_str <> 0 then (
                pp_end_col ppf ~row ~col:n;
                pp_print_string ppf str))
      in
      let has_ver = disp_m < m in
      let ver_stop = if has_ver then vertical_context - 1 else m - 1 in
      let has_hor = disp_n < n in
      let hor_stop = if has_hor then horizontal_context - 1 else n - 1 in
      let src_col_ofs = n - horizontal_context + 1 in
      let dst_col_ofs = horizontal_context in
      let src_row_ofs = m - vertical_context + 1 in
      let dst_row_ofs = vertical_context in
      let gen_fmt_row_body ~pp_nth ?(ellipsis = ellipsis)
            ?(dst_col_ofs = dst_col_ofs) src_r =
        pp_nth 0;
        for c = 1 to hor_stop do
          pp_end_col ppf ~row:src_r ~col:c;
          pp_nth c;
        done;
        if has_hor then begin
          pp_end_col ppf ~row:src_r ~col:horizontal_context;
          pp_print_string ppf ellipsis;
          for c = 0 to horizontal_context - 1 do
            pp_end_col ppf ~row:src_r ~col:(src_col_ofs + c);
            pp_nth (dst_col_ofs + c)
          done
        end
      in
      let fmt_label ~src_r label =
        pp_print_string ppf label;
        pp_end_col ppf ~row:src_r ~col:0
      in
      (match pad with
      | Some pad_c ->
          let buf = Buffer.create 32 in
          let buf_ppf = formatter_of_buffer buf in
          let ellipsis_len = String.length ellipsis in
          let max_lens =
            Array.make disp_n (if has_ver then ellipsis_len else 0)
          in
          let fmt_head_foot pp =
            let heads_foots = Array.make disp_n "" in
            let fmt_col ~src_ofs ~dst_ofs c =
              let head_foot, head_foot_len =
                pp_buf (fun ppf -> pp ppf (src_ofs + c)) buf buf_ppf
              in
              let dst_ofs_c = dst_ofs + c in
              heads_foots.(dst_ofs_c) <- head_foot;
              max_lens.(dst_ofs_c) <- max max_lens.(dst_ofs_c) head_foot_len;
            in
            for c = 0 to hor_stop do fmt_col ~src_ofs:1 ~dst_ofs:0 c done;
            if has_hor then begin
              let src_ofs = n - horizontal_context + 1 in
              let dst_ofs = horizontal_context in
              for c = 0 to horizontal_context - 1 do
                fmt_col ~src_ofs ~dst_ofs c
              done;
            end;
            heads_foots
          in
          let heads, foots =
            match pp_head, pp_foot with
            | None, None -> [||], [||]
            | Some pp_head, None -> fmt_head_foot pp_head, [||]
            | None, Some pp_foot -> [||], fmt_head_foot pp_foot
            | Some pp_head, Some pp_foot ->
                fmt_head_foot pp_head, fmt_head_foot pp_foot
          in
          let many_strs = Array.make_matrix disp_m disp_n "" in
          let fmt_strs ~src_row_ofs ~dst_row_ofs r =
            let row = many_strs.(dst_row_ofs + r) in
            let src_r = src_row_ofs + r in
            let fmt_col ~src_col_ofs ~dst_col_ofs c =
              let str, str_len =
                pp_el_buf pp_el buf buf_ppf mat.{src_r - 1, src_col_ofs + c - 1}
              in
              let dst_c = dst_col_ofs + c in
              row.(dst_c) <- str;
              if str_len > max_lens.(dst_c) then max_lens.(dst_c) <- str_len
            in
            for c = 0 to hor_stop do
              fmt_col ~src_col_ofs:1 ~dst_col_ofs:0 c
            done;
            if has_hor then begin
              for c = 0 to horizontal_context - 1 do
                fmt_col ~src_col_ofs ~dst_col_ofs c
              done
            end
          in
          for r = 0 to ver_stop do
            fmt_strs ~src_row_ofs:1 ~dst_row_ofs:0 r
          done;
          if has_ver then begin
            for r = 0 to vertical_context - 1 do
              fmt_strs ~src_row_ofs ~dst_row_ofs r
            done
          end;
          let head_label, row_labels, foot_label =
            match pp_left with
            | None -> "", [||], ""
            | Some pp_left ->
                let max_len_row_labels_ref = ref 0 in
                let row_labels = Array.make disp_m "" in
                let get_label i =
                  let label, len =
                    pp_buf (fun ppf -> pp_left ppf i) buf buf_ppf
                  in
                  max_len_row_labels_ref := max !max_len_row_labels_ref len;
                  label
                in
                let set_labels ~src_r ~dst_r =
                  for i = 0 to ver_stop do
                    row_labels.(dst_r + i) <- get_label (src_r + i)
                  done
                in
                set_labels ~src_r:1 ~dst_r:0;
                if has_ver then
                  set_labels ~src_r:src_row_ofs ~dst_r:vertical_context;
                let head0 = if pp_head <> None then get_label 0 else "" in
                let foot0 = if pp_foot <> None then get_label (m + 1) else "" in
                let max_len_row_labels = !max_len_row_labels_ref in
                let padded_row_labels =
                  Array.map (pad_str pad_c max_len_row_labels) row_labels
                in
                let padded_head0 = pad_str pad_c max_len_row_labels head0 in
                let padded_foot0 = pad_str pad_c max_len_row_labels foot0 in
                padded_head0, padded_row_labels, padded_foot0
          in
          let fmt_row_body ?ellipsis ~src_r row =
            let pp_nth c = pp_padded_str ppf pad_c max_lens.(c) row.(c) in
            gen_fmt_row_body ~pp_nth ?ellipsis src_r
          in
          let fmt_row_label ?ellipsis ~src_r row label =
            if pp_left <> None then fmt_label ~src_r label;
            fmt_row_body ?ellipsis ~src_r row
          in
          let fmt_row_labels ?ellipsis ~src_r rows labels i =
            if pp_left <> None then fmt_label ~src_r labels.(i);
            fmt_row_body ?ellipsis ~src_r rows.(i)
          in
          let head_foot_ellipsis = String.make (String.length ellipsis) pad_c in
          if pp_head <> None then (
            fmt_row_label
              ~ellipsis:head_foot_ellipsis ~src_r:0 heads head_label;
              do_pp_right ppf 0;
            pp_end_row ppf 0);
          fmt_row_labels ~src_r:1 many_strs row_labels 0;
          for r = 1 to ver_stop do
            pp_end_row ppf r;
            let src_r = r + 1 in
            fmt_row_labels ~src_r many_strs row_labels r;
            do_pp_right ppf src_r;
          done;
          if has_ver then begin
            pp_end_row ppf vertical_context;
            let v1 = vertical_context + 1 in
            fmt_row_label ~src_r:v1 (Array.make disp_n ellipsis)
              (String.make (String.length head_label) pad_c);
            for r = 0 to vertical_context - 1 do
              let src_r = src_row_ofs + r in
              pp_end_row ppf (src_r - 1);
              let dst_r = dst_row_ofs + r in
              fmt_row_labels ~src_r many_strs row_labels dst_r;
              do_pp_right ppf src_r;
            done;
          end;
          if pp_foot <> None then (
            pp_end_row ppf m;
            let m1 = m + 1 in
            fmt_row_label
              ~ellipsis:head_foot_ellipsis ~src_r:m1 foots foot_label;
            do_pp_right ppf m1)
      | None ->
          let maybe_pp_label row =
            match pp_left with
            | None -> ()
            | Some pp_left ->
                pp_left ppf row;
                pp_end_col ppf ~row ~col:0
          in
          let fmt_head_foot ~src_r pp_head_foot =
            maybe_pp_label src_r;
            let pp_nth c = pp_head_foot ppf c in
            gen_fmt_row_body ~pp_nth ~ellipsis:"" src_r;
            do_pp_right ppf src_r
          in
          (match pp_head with
          | None -> ()
          | Some pp_head ->
              fmt_head_foot ~src_r:0 pp_head;
              pp_end_row ppf 0);
          let fmt_row_body src_r =
            maybe_pp_label src_r;
            let pp_nth c = pp_el ppf mat.{src_r - 1, c} in
            gen_fmt_row_body ~dst_col_ofs:(src_col_ofs - 1) ~pp_nth src_r
          in
          for r = 0 to ver_stop do
            let src_r = r + 1 in
            fmt_row_body src_r;
            do_pp_right ppf src_r;
          done;
          if has_ver then begin
            pp_end_row ppf vertical_context;
            let v1 = vertical_context + 1 in
            for c = 0 to horizontal_context - 1 do
              pp_print_string ppf ellipsis;
              pp_end_col ppf ~row:v1 ~col:(src_col_ofs + c);
            done;
            for r = 0 to vertical_context - 1 do
              let src_r = src_row_ofs + r in
              pp_end_row ppf (src_r - 1);
              fmt_row_body src_r;
              do_pp_right ppf src_r;
            done;
          end;
          match pp_foot with
          | None -> ()
          | Some pp_foot ->
              pp_end_row ppf m;
              fmt_head_foot ~src_r:(m + 1) pp_foot);
      pp_close ppf))


(* Pretty-printing elements *)

type 'el pp_el_default = (formatter -> 'el -> unit) ref

let pp_float_el_default_fun ppf el = fprintf ppf "%G" el
let pp_float_el_default = ref pp_float_el_default_fun

let pp_complex_el_default_fun ppf el = fprintf ppf "(%G, %Gi)" el.re el.im
let pp_complex_el_default = ref pp_complex_el_default_fun

let pp_float_el ppf el = !pp_float_el_default ppf el
let pp_complex_el ppf el = !pp_complex_el_default ppf el

let pp_int32_el ppf n = fprintf ppf "%ld" n


(* Pretty-printing in standard style *)

(* Vectors *)

type ('el, 'elt) pp_vec =
  formatter ->
  ('el, 'elt, c_layout) Array1.t
  -> unit

let pp_fvec ppf vec = pp_mat_gen pp_float_el ppf (from_col_vec vec)
let pp_cvec ppf vec = pp_mat_gen pp_complex_el ppf (from_col_vec vec)
let pp_ivec ppf vec = pp_mat_gen pp_int32_el ppf (from_col_vec vec)

let pp_rfvec ppf vec =
  let mat = from_row_vec vec in
  pp_mat_gen ~pp_end_row:pp_end_row_space ~pad:None pp_float_el ppf mat

let pp_rcvec ppf vec =
  let mat = from_row_vec vec in
  pp_mat_gen ~pp_end_row:pp_end_row_space ~pad:None pp_complex_el ppf mat

let pp_rivec ppf vec =
  let mat = from_row_vec vec in
  pp_mat_gen ~pp_end_row:pp_end_row_space ~pad:None pp_int32_el ppf mat

(* Matrices *)

type ('el, 'elt) pp_mat =
  formatter ->
  ('el, 'elt, c_layout) Array2.t
  -> unit

let pp_fmat ppf mat = pp_mat_gen pp_float_el ppf mat
let pp_cmat ppf mat = pp_mat_gen pp_complex_el ppf mat
let pp_imat ppf mat = pp_mat_gen pp_int32_el ppf mat


(* Labeled pretty-printing *)

(* Labeled matrices *)

type ('el, 'elt) pp_labeled_mat =
  ?pp_head : (formatter -> int -> unit) option ->
  ?pp_foot : (formatter -> int -> unit) option ->
  ?pp_left : (formatter -> int -> unit) option ->
  ?pp_right : (formatter -> int -> unit) option ->
  ?pad : char option ->
  ?ellipsis : string ->
  ?vertical_context : Context.t option ->
  ?horizontal_context : Context.t option ->
  unit ->
  formatter ->
  ('el, 'elt, c_layout) Array2.t
  -> unit

let get_pp_head_foot_mat = function
  | None -> Some pp_print_int
  | Some pp_head -> pp_head

let get_some_pp_left_right m =
  Some (fun ppf row_col ->
    if row_col > 0 && row_col <= m then pp_print_int ppf row_col)

let get_pp_left_right m = function
  | None -> get_some_pp_left_right m
  | Some pp_left -> pp_left

let pp_labeled_mat_gen
    pp_el ?pp_head ?pp_foot ?pp_left ?pp_right ?pad
    ?ellipsis ?vertical_context ?horizontal_context () ppf mat =
  let pp_head = get_pp_head_foot_mat pp_head in
  let pp_foot = get_pp_head_foot_mat pp_foot in
  let m = Array2.dim1 mat in
  let pp_left = get_pp_left_right m pp_left in
  let pp_right = get_pp_left_right m pp_right in
  pp_mat_gen ?pp_head ?pp_foot ?pp_left ?pp_right ?pad
    ?ellipsis ?vertical_context ?horizontal_context pp_el ppf mat

let pp_labeled_fmat ?pp_head = pp_labeled_mat_gen pp_float_el ?pp_head
let pp_labeled_cmat ?pp_head = pp_labeled_mat_gen pp_complex_el ?pp_head
let pp_labeled_imat ?pp_head = pp_labeled_mat_gen pp_int32_el ?pp_head

(* String-labeled matrices *)

type ('el, 'elt) pp_lmat =
  ?print_head : bool ->
  ?print_foot : bool ->
  ?print_left : bool ->
  ?print_right : bool ->
  ?row_labels : string array ->
  ?col_labels : string array ->
  ?pad : char option ->
  ?ellipsis : string ->
  ?vertical_context : Context.t option ->
  ?horizontal_context : Context.t option ->
  unit ->
  formatter ->
  ('el, 'elt, c_layout) Array2.t
  -> unit

let get_some_pp_head_foot_mat col_labels =
  Some (fun ppf col -> pp_print_string ppf col_labels.(col - 1))

let get_pp_left_right_mat print m row_labels =
  if print then
    Some (fun ppf row ->
      if row > 0 && row <= m then pp_print_string ppf row_labels.(row - 1))
  else None

let pp_lmat_gen
      (pp_labeled_mat : ('el, 'elt) pp_labeled_mat)
      ?(print_head = true)
      ?(print_foot = true)
      ?(print_left = true)
      ?(print_right = true)
      ?row_labels
      ?col_labels
      ?pad
      ?ellipsis ?vertical_context ?horizontal_context
      () ppf mat =
  let pp_head, pp_foot =
    match col_labels with
    | Some col_labels when print_head ->
        if Array.length col_labels <> Array2.dim2 mat then
          invalid_arg
            "Io.pp_lmat_gen: dim(col_labels) <> dim2(mat)";
        let pp_head = get_some_pp_head_foot_mat col_labels in
        let pp_foot = if print_foot then pp_head else None in
        pp_head, pp_foot
    | Some col_labels when print_foot ->
        None, get_some_pp_head_foot_mat col_labels
    | _ -> None, None in
  let pp_left, pp_right =
    match row_labels with
    | Some row_labels ->
        let m = Array2.dim1 mat in
        if Array.length row_labels <> m then
          invalid_arg
            "Io.pp_lmat_gen: dim(row_labels) <> dim1(mat)";
        let pp_left = get_pp_left_right_mat print_left m row_labels in
        let pp_right = get_pp_left_right_mat print_right m row_labels in
        pp_left, pp_right
    | None -> None, None in
  pp_labeled_mat
    ~pp_head ~pp_foot ~pp_left ~pp_right ?pad
    ?ellipsis ?vertical_context ?horizontal_context () ppf mat

let pp_lfmat ?print_head = pp_lmat_gen pp_labeled_fmat ?print_head
let pp_lcmat ?print_head = pp_lmat_gen pp_labeled_cmat ?print_head
let pp_limat ?print_head = pp_lmat_gen pp_labeled_imat ?print_head

(* Labeled vectors *)

type ('el, 'elt) pp_labeled_vec =
  ?pp_head : (formatter -> int -> unit) ->
  ?pp_foot : (formatter -> int -> unit) ->
  ?pp_left : (formatter -> int -> unit) option ->
  ?pp_right : (formatter -> int -> unit) ->
  ?pad : char option ->
  ?ellipsis : string ->
  ?vertical_context : Context.t option ->
  ?horizontal_context : Context.t option ->
  unit ->
  formatter ->
  ('el, 'elt, c_layout) Array1.t
  -> unit

let pp_labeled_vec_gen
      pp_el ?pp_head ?pp_foot ?pp_left ?pp_right ?pad
      ?ellipsis ?vertical_context ?horizontal_context
      () ppf vec =
  let m = Array1.dim vec in
  let pp_left =
    match pp_left with
    | None -> get_some_pp_left_right m
    | Some None -> None
    | Some (Some pp_left) -> Some pp_left in
  let mat = from_col_vec vec in
  pp_mat_gen ?pp_head ?pp_foot ?pp_left ?pp_right ?pad
    ?ellipsis ?vertical_context ?horizontal_context
    pp_el ppf mat

let pp_labeled_fvec ?pp_head = pp_labeled_vec_gen pp_float_el ?pp_head
let pp_labeled_cvec ?pp_head = pp_labeled_vec_gen pp_complex_el ?pp_head
let pp_labeled_ivec ?pp_head = pp_labeled_vec_gen pp_int32_el ?pp_head

let some_pp_print_int = Some pp_print_int

let pp_labeled_rvec_gen
      pp_el
      ?pp_head:this_pp_head
      ?pp_foot:this_pp_foot
      ?pp_left:this_pp_left
      ?pp_right:this_pp_right
      ?pad
      ?ellipsis ?vertical_context ?horizontal_context
      () ppf vec =
  let pp_head =
    match this_pp_left with
    | None -> some_pp_print_int
    | Some None -> None
    | Some (Some this_pp_left) -> Some this_pp_left in
  let pp_foot = this_pp_right in
  let pp_left = this_pp_head in
  let pp_right = this_pp_foot in
  let mat = from_row_vec vec in
  pp_mat_gen ?pp_head ?pp_foot ?pp_left ?pp_right ?pad
    ?ellipsis ?vertical_context ?horizontal_context
    pp_el ppf mat

let pp_labeled_rfvec ?pp_head = pp_labeled_rvec_gen pp_float_el ?pp_head
let pp_labeled_rcvec ?pp_head = pp_labeled_rvec_gen pp_complex_el ?pp_head
let pp_labeled_rivec ?pp_head = pp_labeled_rvec_gen pp_int32_el ?pp_head

(* String-labeled vectors *)

type ('el, 'elt) pp_lvec =
  ?print_head : bool ->
  ?print_foot : bool ->
  ?print_left : bool ->
  ?print_right : bool ->
  ?labels : string array ->
  ?name : string ->
  ?pad : char option ->
  ?ellipsis : string ->
  ?vertical_context : Context.t option ->
  ?horizontal_context : Context.t option ->
  unit ->
  formatter ->
  ('el, 'elt, c_layout) Array1.t
  -> unit

let get_lvec_name = function
  | None -> None
  | Some name -> Some [| name |]

let pp_lvec_gen
      (pp_lmat : ('el, 'elt) pp_lmat)
      ?print_head ?print_foot ?print_left ?(print_right = false)
      ?labels:row_labels ?name ?pad
      ?ellipsis ?vertical_context ?horizontal_context
      () ppf vec =
  let mat = from_col_vec vec in
  let col_labels = get_lvec_name name in
  pp_lmat
    ?print_head ?print_foot ?print_left ~print_right
    ?row_labels ?col_labels ?pad ?ellipsis ?vertical_context
    ?horizontal_context () ppf mat

let pp_lfvec ?print_head = pp_lvec_gen pp_lfmat ?print_head
let pp_lcvec ?print_head = pp_lvec_gen pp_lcmat ?print_head
let pp_livec ?print_head = pp_lvec_gen pp_limat ?print_head

let pp_rlvec_gen
      (pp_lmat : ('el, 'elt) pp_lmat)
      ?print_head:print_left
      ?print_foot:print_right
      ?print_left:print_head
      ?print_right:this_print_right
      ?labels:col_labels ?name ?pad
      ?ellipsis ?vertical_context ?horizontal_context
      () ppf vec =
  let mat = from_row_vec vec in
  let row_labels = get_lvec_name name in
  let print_foot =
    match this_print_right with
    | None -> false
    | Some this_print_right -> this_print_right in
  pp_lmat
    ?print_head ~print_foot ?print_left ?print_right
    ?row_labels ?col_labels ?pad
    ?ellipsis ?vertical_context ?horizontal_context () ppf mat

let pp_rlfvec ?print_head = pp_rlvec_gen pp_lfmat ?print_head
let pp_rlcvec ?print_head = pp_rlvec_gen pp_lcmat ?print_head
let pp_rlivec ?print_head = pp_rlvec_gen pp_limat ?print_head


(* Pretty-printing in OCaml-style *)

(* Vectors *)

type ('el, 'elt) pp_el_ovec =
  formatter ->
  (formatter -> 'el -> unit) ->
  ('el, 'elt, c_layout) Array1.t
  -> unit

type ('el, 'elt) pp_ovec =
  formatter ->
  ('el, 'elt, c_layout) Array1.t
  -> unit

let pp_ocaml_open_vec ppf =
  pp_open_box ppf 2;
  pp_print_string ppf "[|";
  pp_force_newline ppf ()

let pp_ocaml_close_vec ppf =
  pp_print_string ppf ";";
  pp_close_box ppf ();
  pp_force_newline ppf ();
  pp_print_string ppf "|]"

let pp_end_row_semi ppf _ =
  pp_print_string ppf ";";
  pp_force_newline ppf ()

let pp_ovec ppf pp_el vec =
  if Array1.dim vec = 0 then pp_print_string ppf "[||]"
  else
    pp_mat_gen
      ~pp_open:pp_ocaml_open_vec
      ~pp_close:pp_ocaml_close_vec
      ~pp_end_row:pp_end_row_semi
      pp_el
      ppf
      (from_col_vec vec)

let pp_ocaml_open_rvec ppf =
  pp_open_box ppf 2;
  pp_print_string ppf "[| "

let pp_ocaml_close_rvec ppf =
  pp_print_string ppf " |]";
  pp_close_box ppf ()

let pp_end_row_semi_space ppf _ = pp_print_string ppf "; "

let pp_rovec ppf pp_el vec =
  if Array1.dim vec = 0 then pp_print_string ppf "[||]"
  else
    pp_mat_gen
      ~pp_open:pp_ocaml_open_rvec
      ~pp_close:pp_ocaml_close_rvec
      ~pp_end_row:pp_end_row_semi_space
      ~pad:None
      pp_el
      ppf
      (from_col_vec vec)

let pp_ofvec ppf vec = pp_ovec ppf pp_float_el vec
let pp_ocvec ppf vec = pp_ovec ppf pp_complex_el vec
let pp_oivec ppf vec = pp_ovec ppf pp_int32_el vec

let pp_rofvec ppf vec = pp_rovec ppf pp_float_el vec
let pp_rocvec ppf vec = pp_rovec ppf pp_complex_el vec
let pp_roivec ppf vec = pp_rovec ppf pp_int32_el vec

(* Matrices *)

type ('el, 'elt) pp_omat =
  formatter ->
  ('el, 'elt, c_layout) Array2.t
  -> unit

let pp_ocaml_open_mat ppf =
  pp_open_box ppf 2;
  pp_print_string ppf "[|";
  pp_force_newline ppf ();
  pp_print_string ppf "[| "

let pp_ocaml_close_mat ppf =
  pp_print_string ppf " |];";
  pp_close_box ppf ();
  pp_force_newline ppf ();
  pp_print_string ppf "|]"

let pp_ocaml_end_row_mat ppf _ =
  pp_print_string ppf " |];";
  pp_force_newline ppf ();
  pp_print_string ppf "[| "

let pp_end_col_semi_space ppf ~row:_ ~col:_ = pp_print_string ppf "; "

let pp_omat ppf pp_el mat =
  if Array2.dim1 mat = 0 || Array2.dim2 mat = 0 then pp_print_string ppf "[||]"
  else
    pp_mat_gen
      ~pp_open:pp_ocaml_open_mat
      ~pp_close:pp_ocaml_close_mat
      ~pp_end_row:pp_ocaml_end_row_mat
      ~pp_end_col:pp_end_col_semi_space
      pp_el
      ppf
      mat

let pp_ofmat ppf mat = pp_omat ppf pp_float_el mat
let pp_ocmat ppf mat = pp_omat ppf pp_complex_el mat
let pp_oimat ppf mat = pp_omat ppf pp_int32_el mat


(* Good pretty-printers for toplevels *)

module Toplevel = struct
  (* Vectors *)

  let pp_labeled_col ppf c = if c > 0 then fprintf ppf "C%d" (c - 1)
  let pp_labeled_row ppf r = if r > 0 then fprintf ppf "R%d" (r - 1)

  let gen_pp_vec pp_el ppf vec =
    pp_mat_gen ~pp_left:pp_labeled_row pp_el ppf (from_col_vec vec)

  let pp_fvec ppf vec = gen_pp_vec pp_float_el ppf vec
  let pp_cvec ppf vec = gen_pp_vec pp_complex_el ppf vec
  let pp_ivec ppf vec = gen_pp_vec pp_int32_el ppf vec

  let gen_pp_rvec pp_el ppf vec =
    pp_mat_gen ~pp_head:pp_labeled_row pp_el ppf (from_row_vec vec)

  let pp_rfvec ppf vec = gen_pp_rvec pp_float_el ppf vec
  let pp_rcvec ppf vec = gen_pp_rvec pp_complex_el ppf vec
  let pp_rivec ppf vec = gen_pp_rvec pp_int32_el ppf vec

  (* Matrices *)

  let gen_pp_mat pp_el ppf mat =
    pp_mat_gen ~pp_head:pp_labeled_col ~pp_left:pp_labeled_row pp_el ppf mat

  let pp_fmat ppf mat = gen_pp_mat pp_float_el ppf mat
  let pp_cmat ppf mat = gen_pp_mat pp_complex_el ppf mat
  let pp_imat ppf mat = gen_pp_mat pp_int32_el ppf mat

  let lsc n = Context.set_dim_defaults (Some (Context.create n))
end
