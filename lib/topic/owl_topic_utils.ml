(** [ Topic Model Utils ]  *)

let load_data f =
  let l = ref [||] in
  let h = open_in f in
  try while true do
    let s = Str.split (Str.regexp " ") (input_line h) in
    let _ = l := Array.append !l [|s|] in
    Log.info "%i" (List.length s)
  done with End_of_file -> ();
  close_in h
