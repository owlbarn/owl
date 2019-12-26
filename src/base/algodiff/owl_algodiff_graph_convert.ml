(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module Make (Core : Owl_algodiff_core_sig.Sig) = struct
  open Core

  (* _traverse_trace and its related functions are used to convert the computation graph
     generated in backward mode into human-readable format. You can make your own convert
     function to generate needed format. *)
  let _traverse_trace x =
    (* init variables for tracking nodes and indices *)
    let nodes = Hashtbl.create 512 in
    let index = ref 0 in
    (* local function to traverse the nodes *)
    let rec push tlist =
      match tlist with
      | []       -> ()
      | hd :: tl ->
        if Hashtbl.mem nodes hd = false
        then (
          let op, prev =
            match hd with
            | DR (_ap, _aa, (_, _, label), _af, _ai, _) -> label
            | F _a -> Printf.sprintf "Const", []
            | Arr _a -> Printf.sprintf "Const", []
            | DF (_, _, _) -> Printf.sprintf "DF", []
          in
          (* check if the node has been visited before *)
          Hashtbl.add nodes hd (!index, op, prev);
          index := !index + 1;
          push (prev @ tl))
        else push tl
    in
    (* iterate the graph then return the hash table *)
    push x;
    nodes


  (* convert graph to terminal output *)
  let _convert_terminal_output nodes =
    Hashtbl.fold
      (fun v (v_id, v_op, v_prev) s0 ->
        let v_ts = type_info v in
        s0
        ^ List.fold_left
            (fun s1 u ->
              let u_id, u_op, _ = Hashtbl.find nodes u in
              let u_ts = type_info u in
              s1
              ^ Printf.sprintf
                  "{ i:%i o:%s t:%s } -> { i:%i o:%s t:%s }\n"
                  u_id
                  u_op
                  u_ts
                  v_id
                  v_op
                  v_ts)
            ""
            v_prev)
      nodes
      ""


  (* convert graph to dot file output *)
  let _convert_dot_output nodes =
    let network =
      Hashtbl.fold
        (fun _v (v_id, _v_op, v_prev) s0 ->
          s0
          ^ List.fold_left
              (fun s1 u ->
                let u_id, _u_op, _ = Hashtbl.find nodes u in
                s1 ^ Printf.sprintf "\t%i -> %i;\n" u_id v_id)
              ""
              v_prev)
        nodes
        ""
    in
    let attrs =
      Hashtbl.fold
        (fun v (v_id, v_op, _v_prev) s0 ->
          if v_op = "Const"
          then
            s0
            ^ Printf.sprintf
                "%i [ label=\"#%i | { %s | %s }\" fillcolor=gray, style=filled ];\n"
                v_id
                v_id
                v_op
                (deep_info v)
          else
            s0
            ^ Printf.sprintf
                "%i [ label=\"#%i | { %s | %s }\" ];\n"
                v_id
                v_id
                v_op
                (deep_info v))
        nodes
        ""
    in
    network ^ attrs


  let to_trace nodes = _traverse_trace nodes |> _convert_terminal_output

  let to_dot nodes =
    _traverse_trace nodes
    |> _convert_dot_output
    |> Printf.sprintf "digraph CG {\nnode [shape=record];\n%s}"


  let pp_num formatter x = Format.fprintf formatter "%s" (type_info x)
end
