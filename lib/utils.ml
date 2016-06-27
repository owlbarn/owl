(** [
  Helper functions used in the library
  ]  *)

let shuffle l =
  let nd = List.map (fun c -> (Random.bits (), c)) l in
  let sond = List.sort compare nd in
  List.map snd sond

let range a b =
  let r = Array.make (b - a + 1) 0 in
  for i = a to b do r.(i - a) <- i done;
  Array.to_list r

let sublist a b l =
  let r = Array.make (b - a + 1) 0 in
  for i = a to b do r.(i - a) <- (List.nth l (i - a)) done;
  Array.to_list r

let filter_array f x =
  let r = Array.make (Array.length x) 0 and c = ref 0 in
  for i = 0 to Array.length x - 1 do
    let y, z = f i x.(i) in
    if y = true then (r.(!c) <- z; c := !c + 1)
  done;
  Array.sub r 0 !c

let log s = None
