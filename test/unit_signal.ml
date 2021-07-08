(*Used unit_dense_ndarray test code as reference*)
open Bigarray
open Owl
open Owl_signal
module M = Owl_dense_ndarray_generic

let ndarray = Alcotest.testable (fun _p (_x : (float, float64_elt) M.t) -> ()) M.equal

let blackman_reference = M.zeros Float64 [| 4 |]

let hamming_reference = M.zeros Float64 [| 4 |]

let hann_reference = M.zeros Float64 [| 4 |]

let _ =
  M.set blackman_reference [| 0 |] 0.;
  M.set blackman_reference [| 1 |] 0.63;
  M.set blackman_reference [| 2 |] 0.63;
  M.set blackman_reference [| 3 |] 0.;
  M.set hamming_reference [| 0 |] 0.08;
  M.set hamming_reference [| 1 |] 0.77;
  M.set hamming_reference [| 2 |] 0.77;
  M.set hamming_reference [| 3 |] 0.08;
  M.set hann_reference [| 0 |] 0.;
  M.set hann_reference [| 1 |] 0.75;
  M.set hann_reference [| 2 |] 0.75;
  M.set hann_reference [| 3 |] 0.


(*a module with functions to test*)
module To_test = struct
  let blackman () =
    let b = blackman 4 in
    let max_err =
      (Arr.map2 (fun x y -> x -. y) blackman_reference b |> Arr.abs |> Arr.max |> Arr.get)
        [| 0 |]
    in
    max_err < 1e-5


  let hamming () =
    let h = hamming 4 in
    let max_err =
      (Arr.map2 (fun x y -> x -. y) hamming_reference h |> Arr.abs |> Arr.max |> Arr.get)
        [| 0 |]
    in
    max_err < 1e-5


  let hann () =
    let h = hann 4 in
    let max_err =
      (Arr.map2 (fun x y -> x -. y) hann_reference h |> Arr.abs |> Arr.max |> Arr.get)
        [| 0 |]
    in
    max_err < 1e-5


  let freqz () =
    let freqz_ref = M.zeros Complex64 [| 4 |] in
    let freqz_num = M.zeros Float64 [| 4 |] in
    let freqz_den = M.zeros Float64 [| 4 |] in
    M.set freqz_num [| 0 |] (1. /. 6.);
    M.set freqz_num [| 1 |] 0.5;
    M.set freqz_num [| 2 |] 0.5;
    M.set freqz_num [| 3 |] (1. /. 6.);
    M.set freqz_den [| 0 |] 1.;
    M.set freqz_den [| 1 |] 0.;
    M.set freqz_den [| 2 |] (1. /. 3.);
    M.set freqz_den [| 3 |] 0.;
    M.set freqz_ref [| 0 |] { Complex.re = 1.0; im = 0.0 };
    (*ref values are taken from gnu Octave*)
    M.set freqz_ref [| 1 |] { Complex.re = 0.6536; im = -0.7536 };
    M.set freqz_ref [| 2 |] { Complex.re = -0.5; im = -0.5 };
    M.set freqz_ref [| 3 |] { Complex.re = -0.0536; im = 0.0464 };
    let f =
      freqz ~n:4 ~whole:false (freqz_num |> M.to_array) (freqz_den |> M.to_array)
      |> fun (a, b) -> b
    in
    let max_err =
      (Owl_dense_ndarray.Z.map2 (fun x a -> Complex.sub x a) f freqz_ref
      |> Owl_dense_ndarray.Z.abs
      |> Owl_dense_ndarray.Z.max
      |> Owl_dense_ndarray.Z.re
      |> Arr.get)
        [| 0 |]
    in
    max_err < 1e-3
end

let blackman () = Alcotest.(check bool) "blackman" true (To_test.blackman ())

let hamming () = Alcotest.(check bool) "hamming" true (To_test.hamming ())

let hann () = Alcotest.(check bool) "hann" true (To_test.hann ())

let freqz () = Alcotest.(check bool) "freqz" true (To_test.freqz ())

let test_set =
  [ "blackman", `Slow, blackman; "hamming", `Slow, hamming; "hann", `Slow, hann
  ; "freqz", `Slow, freqz ]
