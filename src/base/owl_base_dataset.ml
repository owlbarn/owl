(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Dataset: easy access to various datasets *)

open Owl_types

module NdarrayS = Owl_base_dense_ndarray.NdarrayPureSingle

let remote_data_path () = "https://github.com/ryanrhymes/owl_dataset/raw/master/"

let local_data_path () =
  let d = Sys.getenv "HOME" ^ "/.owl/dataset/" in
  if Sys.file_exists d = false then (
    Owl_log.info "ERROR - cannot create dir";
    exit ~-1
  );
  d

let download_data fname =
  let fn0 = remote_data_path () ^ fname in
  let fn1 = local_data_path () ^ fname in
  let cmd0 = "wget " ^ fn0 ^ " -O " ^ fn1 in
  let cmd1 = "gunzip " ^ fn1 in
  ignore (Sys.command cmd0);
  ignore (Sys.command cmd1)

let download_all () =
  let l = [
    "stopwords.txt.gz"; "enron.test.gz"; "enron.train.gz"; "nips.test.gz"; "nips.train.gz";
    "mnist-test-images.gz"; "mnist-test-labels.gz"; "mnist-test-lblvec.gz";
    "mnist-train-images.gz"; "mnist-train-labels.gz"; "mnist-train-lblvec.gz";
    "cifar10_test_data.gz"; "cifar10_test_labels.gz"; "cifar10_test_filenames.gz"; "cifar10_test_lblvec.gz";
    "cifar10_train1_data.gz"; "cifar10_train1_labels.gz"; "cifar10_train1_filenames.gz"; "cifar10_train1_lblvec.gz";
    "cifar10_train2_data.gz"; "cifar10_train2_labels.gz"; "cifar10_train2_filenames.gz"; "cifar10_train2_lblvec.gz";
    "cifar10_train3_data.gz"; "cifar10_train3_labels.gz"; "cifar10_train3_filenames.gz"; "cifar10_train3_lblvec.gz";
    "cifar10_train4_data.gz"; "cifar10_train4_labels.gz"; "cifar10_train4_filenames.gz"; "cifar10_train4_lblvec.gz";
    "cifar10_train5_data.gz"; "cifar10_train5_labels.gz"; "cifar10_train5_filenames.gz"; "cifar10_train5_lblvec.gz";
    ] in
  List.iter (fun fname -> download_data fname) l

let draw_samples x y n =
  let x', y', _ = NdarrayS.draw_rows2 ~replacement:false x y n in
  x', y'

(* load mnist train data, the return is a triplet. The first is a 60000 x 784
  matrix where each row represents a 28 x 28 image. The second is label and the
  third is the corresponding unravelled row vector of the label. *)
let load_mnist_train_data () =
  let p = local_data_path () in
  (NdarrayS.load (p ^ "mnist-train-images") [|60000; 784|]), (*   [|60000; 784|] *)
  (NdarrayS.load (p ^ "mnist-train-labels") [|60000; 1|]), (*  [|60000; 1|]*)
  (NdarrayS.load (p ^ "mnist-train-lblvec") [|60000; 10|]) (* [|60000; 10|] *)

let load_mnist_test_data () =
  let p = local_data_path () in
  NdarrayS.load (p ^ "mnist-test-images") [|10000; 784|], (*  [|10000; 784|] *)
  NdarrayS.load (p ^ "mnist-test-labels") [|10000; 1|], (*  [|10000; 1|] *)
  NdarrayS.load (p ^ "mnist-test-lblvec") [|10000; 10|] (*  [|10000; 10|] *)

(*let print_mnist_image x =
  NdarrayS.reshape x [|28; 28|]
  |> NdarrayS.iter_rows (fun v ->
    NdarrayS.iter (function 0. -> Printf.printf " " | _ -> Printf.printf "■") v;
    print_endline "";
  )*)

(* similar to load_mnist_train_data but returns [x] as [*,28,28,1] ndarray *)
let load_mnist_train_data_arr () =
  let x, label, y = load_mnist_train_data () in
  let m = NdarrayS.row_num x in
  let x = NdarrayS.reshape x [|m;28;28;1|] in
  x, label, y

let load_mnist_test_data_arr () =
  let x, label, y = load_mnist_test_data () in
  let m = NdarrayS.row_num x in
  let x = NdarrayS.reshape x [|m;28;28;1|] in
  x, label, y
