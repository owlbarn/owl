(* TODO REIMPLEMENT IN TERMS OF OWL UTILS HEAP *)
(* Priority queue implementation for finding heavy hitters.  From
 * http://caml.inria.fr/pub/docs/manual-ocaml/moduleexamples.html 
 * with small additions and edits *)
module PrioQueue = struct
  type priority = int

  type 'a queue =
    | Empty
    | Node of priority * 'a * 'a queue * 'a queue

  exception Queue_is_empty

  let empty = Empty
  let isempty = ( = ) empty

  let rec insert prio elt = function
    | Empty -> Node (prio, elt, Empty, Empty)
    | Node (p, e, left, right) ->
      if prio <= p
      then Node (prio, elt, insert p e right, left)
      else Node (p, e, insert prio elt right, left)


  let rec remove_top = function
    | Empty -> raise Queue_is_empty
    | Node (_, _, left, Empty) -> left
    | Node (_, _, Empty, right) -> right
    | Node
        ( _
        , _
        , (Node (lprio, lelt, _, _) as left)
        , (Node (rprio, relt, _, _) as right) ) ->
      if lprio <= rprio
      then Node (lprio, lelt, remove_top left, right)
      else Node (rprio, relt, left, remove_top right)


  (* get the min element of the queue, its priority, and the rest of the queue *)
  let extract = function
    | Empty -> raise Queue_is_empty
    | Node (prio, elt, _, _) as queue -> prio, elt, remove_top queue


  (* find and delete all instances of element v in the queue *)
  let rec find_and_remove v = function
    | Empty -> Empty
    | Node (prio, elt, left, right) as queue ->
      if v = elt
      then remove_top queue
      else Node (prio, elt, find_and_remove v left, find_and_remove v right)


  (* return a list of the elements in descending order of priority (note max first) *)
  let to_sorted_list =
    let rec aux acc queue =
      try
        let prio, elt, rest = extract queue in
        aux ((elt, prio) :: acc) rest
      with
      | Queue_is_empty -> acc
    in
    aux []


  (* get the lowest-priority element and its priority *)
  let peek = function
    | Empty -> raise Queue_is_empty
    | Node (prio, elt, _, _) -> elt, prio
end

(* functor to make an online heavy hitters sketch based on CountMin.
 * Given a threshold k, this sketch will return all elements inserted into it
 * which appear at least n/k times among the n elements inserted into it. *)
module Make (CM : Owl_countmin_sketch.Sig) = struct
  type t =
    { sketch : CM.sketch
    ; queue : int PrioQueue.queue ref
    ; size : int ref
    ; k : float
    }

  (* Initialize a heavy-hitters sketch with threshold k, approximation ratio epsilon,
   * and failure probability delta.  *)
  let init k epsilon delta =
    { sketch = CM.init epsilon delta; queue = ref PrioQueue.empty; size = ref 0; k }


  (* Add value v to sketch h in-place. *)
  let add h v =
    CM.incr h.sketch v;
    h.size := !(h.size) + 1;
    let v_count = CM.count h.sketch v in
    let threshold = float_of_int !(h.size) /. h.k in
    if v_count |> float_of_int > threshold
    then
      h.queue := !(h.queue) |> PrioQueue.find_and_remove v |> PrioQueue.insert v_count v
    else ();
    let rec clean_queue threshold queue =
      if (not (PrioQueue.isempty queue))
         && PrioQueue.peek queue |> snd |> float_of_int < threshold
      then (
        try clean_queue threshold (PrioQueue.remove_top queue) with
        | PrioQueue.Queue_is_empty -> PrioQueue.empty)
      else queue
    in
    h.queue := clean_queue threshold !(h.queue)


  (* Return all heavy-hitters among the data thus far added, sorted in decreasing order
   * of frequency. *)
  let get h = PrioQueue.to_sorted_list !(h.queue)
end

module Native = Make (Owl_countmin_sketch.Native)
module Owl = Make (Owl_countmin_sketch.Owl)