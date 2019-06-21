(* functor to make an online heavy hitters sketch based on CountMin.
 * Given a threshold k, this sketch will return all elements inserted into it
 * which appear at least n/k times among the n elements inserted into it. *)
module Make (CM : Owl_countmin_sketch.Sig) = struct
  module PQPair = struct 
    type elt = int
    type t = elt * int 
    let compare (_,p0) (_,p1) = Pervasives.compare p0 p1
  end
  module PQSet = Set.Make(PQPair)

  type t =
    { sketch : CM.sketch
    ; mutable queue : PQSet.t
    ; mutable size : int
    ; k : float
    }

  (* Initialize a heavy-hitters sketch with threshold k, approximation ratio epsilon,
   * and failure probability delta.  *)
  let init k epsilon delta =
    { sketch = CM.init epsilon delta; queue = PQSet.empty; size = 0; k }

  (* Add value v to sketch h in-place. *)
  let add h v =
    CM.incr h.sketch v;
    h.size <- h.size + 1;
    let v_count = CM.count h.sketch v in
    let threshold = float_of_int h.size /. h.k in
    if v_count |> float_of_int > threshold
    then
      h.queue <- h.queue |> PQSet.partition (fun (x,_) -> x = v) |> snd |> PQSet.add (v, v_count)
    else ();
    let rec clean_queue queue =
      match PQSet.min_elt_opt queue with
      | Some (x, c) -> 
        if float_of_int c < threshold then clean_queue (PQSet.remove (x,c) queue) else queue
      | None -> queue
    in
    h.queue <- clean_queue h.queue

  (* Return all heavy-hitters among the data thus far added, sorted in decreasing order
   * of frequency. *)
  let get h = PQSet.elements h.queue |> List.rev
end

module Native = Make (Owl_countmin_sketch.Native)
module Owl = Make (Owl_countmin_sketch.Owl)