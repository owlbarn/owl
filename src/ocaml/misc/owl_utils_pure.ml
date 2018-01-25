
(* pretty-print an array to string *)
let string_of_array ?(prefix="") ?(suffix="") ?(sep=",") string_of_x x =
  let s = Array.to_list x |> List.map string_of_x |> String.concat sep in
  Printf.sprintf "%s%s%s" prefix s suffix
