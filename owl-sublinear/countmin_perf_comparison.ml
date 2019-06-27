(* Test the resource usage and accuracy of various 
 * count-min sketches versus a hashtable *)

(* Hashtable-based frequency table *)
module HF = struct
  type 'a t = ('a, int) Hashtbl.t

  let init ?(n=1000) () = Hashtbl.create n

  let count t x =
    match Hashtbl.find_opt t x with
    | Some c -> c
    | None -> 0

  let incr t x = Hashtbl.replace t x (count t x + 1)
end

module CM = Owl_base.Countmin_sketch.Native







let full_profile k epsvals delvals true_freqs =
  

















