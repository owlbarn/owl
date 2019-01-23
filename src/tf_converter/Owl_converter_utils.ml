
let array_to_string ?(prefix="") ?(suffix="") ?(sep=",") elt_to_str x =
  let s = Array.to_list x |> List.map elt_to_str |> String.concat sep in
  Printf.sprintf "%s%s%s" prefix s suffix
