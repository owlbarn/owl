open Bigarray

type arr = (float, float32_elt, c_layout) Genarray.t

let create_bigarray dims valz =
  let new_arr = Genarray.create float32 c_layout dims in
  (
    Genarray.fill new_arr valz; new_arr
  )

let next_ind ind dims =
  let num_dims = Array.length ind in
  let p = ref (num_dims - 1) in
  let ok = ref false in
  begin
    while !p >= 0 && not !ok do
      if ind.(!p) + 1 < dims.(!p) then
        begin
          Array.set ind (!p) (ind.(!p) + 1);
          ok := true;
        end
      else
        begin
          Array.set ind (!p) 0;
          p := !p - 1;
        end
    done;
    !ok
  end

let print_bigarray bigarr =
  let dims = Genarray.dims bigarr in
  let num_dims = Genarray.num_dims bigarr in
  let ind = Array.make num_dims 0 in
  let should_stop = ref false in
  begin
    while not !should_stop do
      print_float (Genarray.get bigarr ind);
      print_string " ";
      if not (next_ind ind dims) then
        should_stop := true
    done;
    print_string "\n";
  end

let rec print_array l =
  begin
    for i = 0 to (Array.length l) - 1 do
      print_int (Array.get l i); print_string " "
    done;
    print_string "\n"
  end

let sum_bigarrays = function
  | [] -> None
  | res::terms -> let dims = Genarray.dims res in
    let num_dims = Genarray.num_dims res in
    let ind = Array.make num_dims 0 in
    let should_stop = ref false in
    while not !should_stop do
      List.iter (fun bigarr ->
          (Genarray.set res ind
             ((Genarray.get res ind) +. (Genarray.get bigarr ind)))
        ) terms;
      if not (next_ind ind dims) then
        should_stop := true
    done;
    Some res

let sum_bigarray_elems bigarr = let dims = Genarray.dims bigarr in
  let num_dims = Genarray.num_dims bigarr in
  let ind = Array.make num_dims 0 in
  let result = ref 0. in
  let should_stop = ref false in (
    while not !should_stop do
      result := (!result) +. (Genarray.get bigarr ind);
      if not (next_ind ind dims) then
        should_stop := true
    done;
    !result
  )

(* Create an array of n + 1 bigarrays of that size, the first of value 0, the rest of value 1 *)
let create_bigarray_list n dims =
  let ret = ref [create_bigarray dims 0.] in (
    for i = 1 to n do
      ret := (create_bigarray dims 1.)::(!ret)
    done;
    !ret
  )

let dims = [|10; 10; 10; 10; 10; 10;|]
let num_arrays = 300
let arrays = create_bigarray_list num_arrays dims;;

print_string "Number of arrays: "; print_int num_arrays; print_newline ();;
print_string "Dimensions of each bigarray: "; print_array dims; print_newline ();;
print_string "Resulting sum of all elements in all bigarray: ";
print_float (
  sum_bigarray_elems (
    match sum_bigarrays arrays with
    | None -> (create_bigarray dims 0.)
    | Some x -> x
  )
);
print_newline ();;
