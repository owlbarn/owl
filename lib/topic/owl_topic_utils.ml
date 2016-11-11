(** [ Topic Model Utils ]  *)

let _allocate_space x =
  Log.info "allocate more space ...";
  let l = Array.length x in
  let y = Array.make l [] in
  Array.append x y

let load_data f =
  let x = ref (Array.make 1024 []) in
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
