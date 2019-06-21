type 'a t = {
  mutable used : int;
  mutable data : ('a * int) array;
  mutable idxs : ('a, int) Hashtbl.t;
}

(* compare two elements by priority *)
let cmp (_,p1) (_,p2) = Pervasives.compare p1 p2

let left_son pos = (pos lsl 1) + 1

let right_son pos = (pos lsl 1) + 2

let parent pos = (pos - 1) lsr 1

(* can't set an initial size without knowing the type *)
let make () = {
  used = 0;
  data = [||];
  idxs = Hashtbl.create 100;
}

let size_arr heap = Array.length heap.data

let extend_size heap =
  heap.data <- Array.(append heap.data (copy heap.data))

let size heap = heap.used

let swap heap i1 i2 =
  let tmp = heap.data.(i1) in
  heap.data.(i1) <- heap.data.(i2);
  Hashtbl.replace heap.idxs (fst heap.data.(i1)) i1;
  heap.data.(i2) <- tmp;
  Hashtbl.replace heap.idxs (fst heap.data.(i2)) i2

let bubble_up heap i =
  if not (i <= 0 || i > heap.used) then (
    let pos = ref i in
    let par = ref (parent !pos) in
    while !pos > 0 && cmp heap.data.(!pos) heap.data.(!par) < 0 do
      swap heap !pos !par;
      pos := !par;
      par := parent (!pos);
    done;
  )

let bubble_down heap i = 
  if not (i < 0 || i >= heap.used) then (
    let pos = ref i in
    let again = ref true in
    while !again do
      let small = ref !pos in
      let left = left_son !pos
      and right = right_son !pos in
      if left < heap.used && cmp heap.data.(left) heap.data.(!small) < 0 then (
        small := left
      );
      if right < heap.used && cmp heap.data.(right) heap.data.(!small) < 0 then (
        small := right
      );
      if !pos = !small then
        again := false
      else (
        swap heap !pos !small;
        pos := !small
      );
    done
  )

let push heap x =
  if size_arr heap = 0 then (
    heap.data <- [|x|];
    heap.used <- 1 ;
    Hashtbl.replace heap.idxs (fst x) 0
  )
  else (
    if size_arr heap <= heap.used then (
      extend_size heap
    );
    (* insert x at the end and swap it with its parent if x is smaller *)
    heap.data.(heap.used) <- x;
    heap.used <- heap.used + 1;
    bubble_up heap (heap.used - 1)
  )

let pop heap = match heap.used with
  | 0 -> invalid_arg "owl_utils_heap: can't pop an element from an empty heap"
  | _ ->
    let x = heap.data.(0) in
    (* replace the first element with the last one and swap it with its
      * smallest son *)
    heap.used <- heap.used - 1;
    heap.data.(0) <- heap.data.(heap.used);
    bubble_down heap 0;
    Hashtbl.remove heap.idxs (fst x);
    x

let peek heap = match heap.used with
  | 0 -> invalid_arg "owl_utils_heap: can't peek at an empty heap"
  | _ -> heap.data.(0)

let change_priority heap v p =
  match Hashtbl.find_opt heap.idxs v with
  | None -> push heap (v, p)
  | Some pos ->
    Owl_exception.check (fst heap.data.(pos) = v) (Failure "Owl_prioqueue: hashtbl failure") ;
    heap.data.(pos) <- (v, p);
    if pos > 0 && cmp heap.data.(pos) heap.data.(parent pos) < 0 then
      bubble_up heap pos
    else bubble_down heap pos

let is_empty heap = heap.used = 0

let to_array heap = Array.sub heap.data 0 heap.used
