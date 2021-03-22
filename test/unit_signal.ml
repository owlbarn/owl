(*Used unit_dense_ndarray test code as reference*)
open Bigarray
open Owl
open Owl_signal

module M = Owl_dense_ndarray_generic


let ndarray = Alcotest.testable (fun _p (_x : (float, float64_elt) M.t) -> ()) M.equal

let blackman_reference = M.zeros Float64 [|4|]
let hamming_reference = M.zeros Float64 [|4|]
let hann_reference = M.zeros Float64 [|4|]       
       
let _ = 
  M.set blackman_reference [|0|] 0.;
  M.set blackman_reference [|1|] 0.63;
  M.set blackman_reference [|2|] 0.63;
  M.set blackman_reference [|3|] 0.;
  M.set hamming_reference [|0|] 0.08;
  M.set hamming_reference [|1|] 0.77;
  M.set hamming_reference [|2|] 0.77;
  M.set hamming_reference [|3|] 0.08;	
  M.set hann_reference [|0|] 0.;
  M.set hann_reference [|1|] 0.75;
  M.set hann_reference [|2|] 0.75;
  M.set hann_reference [|3|] 0.;

(*a module with functions to test*)
module To_test = struct
  let blackman () = 
    let b = blackman 4 in
    let max_err = (Arr.map2 (fun x y -> x -. y) blackman_reference b |> Arr.abs |> Arr.max |> Arr.get) [|0|] in
    max_err < 1e-5

  let hamming () = 
    let h = hamming 4 in
    let max_err = (Arr.map2 (fun x y -> x -. y) hamming_reference h |> Arr.abs |> Arr.max |> Arr.get) [|0|] in
    max_err < 1e-5

  let hann () = 
    let h = hann 4 in
    let max_err = (Arr.map2 (fun x y -> x -. y) hann_reference h |> Arr.abs |> Arr.max |> Arr.get) [|0|] in
    max_err < 1e-5
end

let blackman () = Alcotest.(check bool) "blackman" true (To_test.blackman ())

let hamming () = Alcotest.(check bool) "hamming" true (To_test.hamming ())

let hann () = Alcotest.(check bool) "hann" true (To_test.hann ())

let test_set = 
  [ "blackman", `Slow, blackman; "hamming", `Slow, hamming; "hann", `Slow, hann ]
