
let array_to_string = Owl_utils_array.to_string

let apply_and_combine_string fn x =
  let arr = Array.map fn x in
  Owl_utils_array.to_string ~sep:" " (fun x -> x) arr
