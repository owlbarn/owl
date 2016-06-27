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

let rec _sublist b e l =
  match l with
  | [] -> failwith "sublist"
  | h :: t -> let tail = if e = 0 then [] else _sublist (b - 1) (e - 1) t in
    if b > 0 then tail else h :: tail

let sublist a b l =
  let r = Array.make (b - a + 1) 0 in
  for i = a to b do r.(i - a) <- (List.nth l (i - a)) done;
  Array.to_list r
