(** This example, extracted from the SoundML library, shows how to compute a specgram using the FFT module *)

module G = Owl.Dense.Ndarray.Generic

(* helper to compute the fft frequencies *)
let fftfreq (n : int) (d : float) =
  let nslice = ((n - 1) / 2) + 1 in
  let fhalf =
    G.linspace Bigarray.Float32 0. (float_of_int nslice) nslice
  in
  let shalf =
    G.linspace Bigarray.Float32 (-.float_of_int nslice) (-1.) nslice
  in
  let v = G.concatenate ~axis:0 [|fhalf; shalf|] in
  Owl.Arr.(1. /. (d *. float_of_int n) $* v)

(* Computes a one-sided PSD spectrogram with no padding and no detrend *)
let specgram (nfft : int) (fs : int) ?(noverlap : int = 0) (x : (float, Bigarray.float32_elt) G.t) =
  let window = Owl.Signal.hann in (* we're using hann window *)
  assert (noverlap < nfft) ;
  (* we're making copies of the data from x and y to then use in place padding
     and operations *)
  let x = G.copy x in
  (* We're making sure the arrays are at least of size nfft *)
  let xshp = G.shape x in
  ( if Array.get xshp 0 < nfft then
      let delta = nfft - Array.get xshp 0 in
      (* we're doing this in place in hope to gain a little bit of speed *)
      G.pad_ ~out:x ~v:0. [[0; delta - 1]; [0; 0]] x ) ;
  let scale_by_freq = true  in
  let pad_to = nfft in
  let scaling_factor = 2. in
  let window = window nfft |> G.cast_d2s in
  let window =
    G.reshape G.(window * ones Bigarray.float32 [|nfft|]) [|-1; 1|]
  in
  let res =
    G.slide ~window:nfft ~step:(nfft - noverlap) x |> G.transpose
  in
  (* if we'd add a detrend, we'd need to do it before applying the window *)
  let res = G.(res * window) in
  (* here comes the rfft compute, if you're processing large audio data, you might want to set ~nthreads to
     something that suits both your hardware and your needs. *)
  let res = Owl.Fft.S.rfft res ~axis:0 in
  let freqs = fftfreq pad_to (1. /. float_of_int fs) in
  let conj = G.conj res in
  (* using in-place operations to avoid array copy *)
  G.mul_ ~out:res conj res;
  let slice = if nfft mod 2 = 0 then [[1; -1]; []] else [[1]; []] in
  let gslice = G.get_slice slice res in
  G.mul_scalar_ ~out:gslice gslice Complex.{re= scaling_factor; im= 0.} ;
  G.set_slice slice res gslice ;
  if scale_by_freq then (
    let window = G.abs window in
    G.div_scalar_ ~out:res res Complex.{re= float_of_int fs; im= 0.} ;
    let n = G.sum' (G.pow_scalar window (float_of_int 2)) in
    G.div_scalar_ ~out:res res Complex.{re= n; im= 0.} )
  else (
    let window = G.abs window in
    let n = Float.pow (G.sum' window) 2. in
    G.div_scalar_ ~out:res res Complex.{re= n; im= 0.} ) ;
  (res, freqs)