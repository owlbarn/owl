(* Test neural network on MNIST *)

open Owl

let print_image x =
  let x = Mat.reshape 28 28 x in
  Mat.iter_rows (fun v ->
    Vec.iter (function 0. -> Printf.printf " " | _ -> Printf.printf "■") v;
    print_endline "";
  ) x

let print_random x m = Mat.draw_rows x m |> fst |> Mat.iter_rows print_image

let load_train_data () =
  let p = Owl_utils.local_data_path () in
  Mat.load (p ^ "mnist-train-images"),
  Mat.load (p ^ "mnist-train-labels")


let _ =
  print_endline "test MNIST";
  let x, y = load_train_data () in
  print_random x 10;
  ()
