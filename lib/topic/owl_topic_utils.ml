(** [ Topic Model Utils ]  *)

let _allocate_space x =
  Log.info "allocate more space ...";
  let l = Array.length x in
  let y = Array.make l [] in
  Array.append x y

let load_data f =
  let x = ref (Array.make (64 * 1024) []) in
  let c = ref 0 in
  let h = open_in f in
  (
    try while true do
      if !c = (Array.length !x) - 1 then x := _allocate_space !x;
      let s = Str.split (Str.regexp " ") (input_line h) in
      !x.(!c) <- s;
      c := !c + 1;
    done with End_of_file -> ()
  );
  close_in h;
  Array.sub !x 0 !c

module SS = Set.Make (String)

let build_vocabuary x =
  let h = Hashtbl.create 1024 in
  Array.iter (fun l ->
    List.iter (fun w ->
      if Hashtbl.mem h w = false then Hashtbl.add h w 0
    ) l
  ) x;
  let y = Array.make (Hashtbl.length h) "" in
  let i = ref 0 in
  Hashtbl.iter (fun w _ -> y.(!i) <- w; i := !i + 1) h;
  Array.sort String.compare y;
  Hashtbl.reset h;
  Array.iteri (fun i w -> Hashtbl.add h w i) y;
  h
