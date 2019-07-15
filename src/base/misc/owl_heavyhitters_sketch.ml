<<<<<<< HEAD
(* functor to make an online heavy hitters sketch based on CountMin.
 * Given a threshold k, this sketch will return all elements inserted into it
 * which appear at least n/k times among the n elements inserted into it. *)
module Make (CM : Owl_countmin_sketch_sig.Sig) : Owl_heavyhitters_sketch_sig.Sig = struct
  (* type system magic based on https://www.reddit.com/r/ocaml/comments/4j090g/how_to_define_a_polymorphic_set_module_based_on/ *)
=======
(* functor to make a heavy hitters sketch based on CountMin. *)
module Make (CM : Owl_countmin_sketch_sig.Sig) : Owl_heavyhitters_sketch_sig.Sig = struct
>>>>>>> c858d29f49cac42c60c8067d7ef99b5f66b5ca40
  type ('a, 'b) inner =
    { s : (module Set.S with type elt = 'a * int and type t = 'b)
    ; sketch : 'a CM.sketch
    ; mutable queue : 'b
    ; mutable size : int
    ; k : float
    }
<<<<<<< HEAD
  
  type 'a t = E : ('a, 'b) inner -> 'a t

  let init ~k ~epsilon ~delta (type a) =
    let module PQPair = struct 
      type t = a * int 
      let compare (_,p0) (_,p1) = Pervasives.compare p0 p1
    end
    in 
    let module S = Set.Make(PQPair) in
    E {s = (module S); sketch = CM.init ~epsilon ~delta; queue = S.empty; size = 0; k }
=======

  type 'a t = E : ('a, 'b) inner -> 'a t

  let init ~k ~epsilon ~delta (type a) =
    let module PQPair = struct
      type t = a * int

      let compare (_, p0) (_, p1) = Pervasives.compare p0 p1
    end
    in
    let module S = Set.Make (PQPair) in
    E { s = (module S); sketch = CM.init ~epsilon ~delta; queue = S.empty; size = 0; k }

>>>>>>> c858d29f49cac42c60c8067d7ef99b5f66b5ca40

  let add (type a) (E h : a t) v =
    let module PQSet = (val h.s) in
    CM.incr h.sketch v;
    h.size <- h.size + 1;
    let v_count = CM.count h.sketch v in
    let threshold = float_of_int h.size /. h.k in
    if v_count |> float_of_int > threshold
    then
<<<<<<< HEAD
      h.queue <- h.queue |> PQSet.partition (fun (x,_) -> x = v) |> snd |> PQSet.add (v, v_count)
    else ();
    let rec clean_queue queue =
      match PQSet.min_elt_opt queue with
      | Some (x, c) -> 
        if float_of_int c < threshold then clean_queue (PQSet.remove (x,c) queue) else queue
=======
      h.queue
      <- h.queue |> PQSet.partition (fun (x, _) -> x = v) |> snd |> PQSet.add (v, v_count)
    else ();
    let rec clean_queue queue =
      match PQSet.min_elt_opt queue with
      | Some (x, c) ->
        if float_of_int c < threshold
        then clean_queue (PQSet.remove (x, c) queue)
        else queue
>>>>>>> c858d29f49cac42c60c8067d7ef99b5f66b5ca40
      | None -> queue
    in
    h.queue <- clean_queue h.queue

<<<<<<< HEAD
  let get (type a) (E h : a t) = 
    let module PQSet = (val h.s) in 
=======

  let get (type a) (E h : a t) =
    let module PQSet = (val h.s) in
>>>>>>> c858d29f49cac42c60c8067d7ef99b5f66b5ca40
    PQSet.elements h.queue |> List.rev
end

module Native = Make (Owl_countmin_sketch.Native)
<<<<<<< HEAD
module Owl = Make (Owl_countmin_sketch.Owl)
=======
module Owl = Make (Owl_countmin_sketch.Owl)
>>>>>>> c858d29f49cac42c60c8067d7ef99b5f66b5ca40
