(** [
  Helper functions used in the library
  ]  *)

let shuffle l =
  let nd = List.map (fun c -> (Random.bits (), c)) l in
  let sond = List.sort compare nd in
  List.map snd sond

let range a b =
  let rec aux a b =
    if a > b then [] else a :: aux (a+1) b  in
  if a > b then List.rev (aux b a) else aux a b;;

let rec sublist b e l =
  match l with
  | [] -> failwith "sublist"
  | h :: t -> let tail = if e = 0 then [] else sublist (b - 1) (e - 1) t in
    if b > 0 then tail else h :: tail
