(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* A naive implementation of a min-heap for Owl's internal use. *)


type 'a t = {
  mutable used : int;
  mutable data : 'a array;
  cmp          : 'a -> 'a -> int;
}

let left_son pos = (pos lsl 1) + 1

let right_son pos = (pos lsl 1) + 2

let parent pos = (pos - 1) lsr 1

(* can't set an initial size without knowing the type *)
let make cmp = {
  used = 0;
  data = [||];
  cmp;
}

let make_int ?(initial_size=0) cmp = {
  used = 0;
  data = Array.make initial_size 0;
  cmp;
}

let make_float ?(initial_size=0) cmp = {
  used = 0;
  data = Array.make initial_size 0.;
  cmp;
}

let size_arr heap = Array.length heap.data

let extend_size heap =
  heap.data <- Array.(append heap.data (copy heap.data))

let size heap = heap.used

let push ({used; cmp; _} as heap) x =
  if size_arr heap = 0 then (
    heap.data <- [|x|];
    heap.used <- 1
  )
  else (
    if size_arr heap <= used then (
      extend_size heap
    );
    (* insert x at the end and swap it with its parent if x is smaller *)
    let pos = ref used in
    let par = ref (parent !pos) in
    while !pos > 0 && cmp x heap.data.(!par) < 0 do
      heap.data.(!pos) <- heap.data.(!par);
      pos := !par;
      par := parent (!pos);
    done;
    heap.used <- used + 1;
    heap.data.(!pos) <- x
  )

let pop ({data; cmp; _} as heap) = match heap.used with
  | 0 -> invalid_arg "owl_utils_heap: can't pop an element from an empty heap"
  | _ ->
     let x = data.(0) in
     (* replace the first element with the last one and swap it with its
      * smallest son *)
     heap.used <- heap.used - 1;
     data.(0) <- data.(heap.used);
     let pos = ref 0 in
     let again = ref true in
     while !again do
       let small = ref !pos in
       let left = left_son !pos
       and right = right_son !pos in
       if left < heap.used && cmp data.(left) data.(!small) < 0 then (
         small := left
       );
       if right < heap.used && cmp data.(right) data.(!small) < 0 then (
         small := right
       );
       if !pos = !small then
         again := false
       else (
         let tmp = data.(!pos) in
         data.(!pos) <- data.(!small);
         data.(!small) <- tmp;
         pos := !small
       );
     done;
     x

let peek heap = match heap.used with
  | 0 -> invalid_arg "owl_utils_heap: can't peek at an empty heap"
  | _ -> heap.data.(0)

let is_empty heap = heap.used = 0

let to_array heap = Array.sub heap.data 0 heap.used
