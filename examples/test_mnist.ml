(* Test neural network on MNIST *)

open Bitstring

let dataset = "/Users/liang/owl_dataset/train-labels-idx1-ubyte"

let extract_files () =
  let bits = bitstring_of_file dataset in
  let x = takebits 8 bits in
  bitmatch x with
  | { m : littleendian } -> m

let _ =
  print_endline "test MNIST"
