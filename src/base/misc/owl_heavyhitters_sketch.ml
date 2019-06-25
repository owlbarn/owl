(* functor to make an online heavy hitters sketch based on CountMin.
 * Given a threshold k, this sketch will return all elements inserted into it
 * which appear at least n/k times among the n elements inserted into it. *)
module Make (CM : Owl_countmin_sketch.Sig) = struct
  type ('a, 'b) inner =
    { s : (module Set.S with type elt = 'a * int and type t = 'b)
    ; sketch : 'a CM.sketch
    ; mutable queue : 'b
    ; mutable size : int
    ; k : float
    }
  
  type 'a t = E : ('a, 'b) inner -> 'a t

  (* Initialize a heavy-hitters sketch with threshold k, approximation ratio epsilon,
   * and failure probability delta.  *)
  let init ~k ~epsilon ~delta (type a) =
    let module PQPair = struct 
      type t = a * int 
      let compare (_,p0) (_,p1) = Pervasives.compare p0 p1
    end
    in 
    let module S = Set.Make(PQPair) in
    E {s = (module S); sketch = CM.init ~epsilon ~delta; queue = S.empty; size = 0; k }

  (* Add value v to sketch h in-place. *)
  let add (type a) (E h : a t) v =
    let module PQSet = (val h.s) in
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
  let get (type a) (E h : a t) = 
    let module PQSet = (val h.s) in 
    PQSet.elements h.queue |> List.rev
end

module Native = Make (Owl_countmin_sketch.Native)
module Owl = Make (Owl_countmin_sketch.Owl)