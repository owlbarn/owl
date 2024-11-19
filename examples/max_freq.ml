(** This example shows how to compute the maximum peak frequency in time series data using the FFT module. *)

module G = Owl.Dense.Ndarray.Generic
module FFT = Owl.Fft.Generic

let max_freq signal sampling_rate =
  (* Apply FFT *)
  let fft_result = FFT.rfft ~otyp:Bigarray.Complex32 signal in
  (* Get magnitude spectrum *)
  let magnitudes = G.abs fft_result in
  (* Find peak frequency *)
  let max_idx = ref 0 in
  let max_val = ref (G.get magnitudes [|0|]) in
  for i = 0 to G.numel magnitudes - 1 do
    let curr_val = G.get magnitudes [|i|] in
    if curr_val > !max_val then (
      max_val := curr_val ;
      max_idx := i )
  done ;
  (* Convert index to frequency *)
  float_of_int !max_idx *. sampling_rate /. float_of_int (G.numel signal)