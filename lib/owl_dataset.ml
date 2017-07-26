(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Dataset: easy access to various datasets *)


let remote_data_path () = "https://github.com/ryanrhymes/owl_dataset/raw/master/"

let local_data_path () =
  let d = Sys.getenv "HOME" ^ "/.owl/dataset/" in
  if Sys.file_exists d = false then (
    Log.info "create %s" d;
    Unix.mkdir d 0o755;
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
    "cifar10_test_data.gz"; "cifar10_test_labels.gz"; "cifar10_test_filenames.gz";
    "cifar10_train1_data.gz"; "cifar10_train1_labels.gz"; "cifar10_train1_filenames.gz";
    "cifar10_train2_data.gz"; "cifar10_train2_labels.gz"; "cifar10_train2_filenames.gz";
    "cifar10_train3_data.gz"; "cifar10_train3_labels.gz"; "cifar10_train3_filenames.gz";
    "cifar10_train4_data.gz"; "cifar10_train4_labels.gz"; "cifar10_train4_filenames.gz";
    "cifar10_train5_data.gz"; "cifar10_train5_labels.gz"; "cifar10_train5_filenames.gz";
    ] in
  List.iter (fun fname -> download_data fname) l

let draw_samples x y n =
  let x', y', _ = Owl_dense_matrix_generic.draw_rows2 ~replacement:false x y n in
  x', y'

(* load mnist train data, the return is a triplet. The first is a 60000 x 784
  matrix where each row represents a 28 x 28 image. The second is label and the
  third is the corresponding unravelled row vector of the label. *)
let load_mnist_train_data () =
  let p = local_data_path () in
  Owl_dense_matrix.S.load (p ^ "mnist-train-images"),
  Owl_dense_matrix.S.load (p ^ "mnist-train-labels"),
  Owl_dense_matrix.S.load (p ^ "mnist-train-lblvec")

let load_mnist_test_data () =
  let p = local_data_path () in
  Owl_dense_matrix.S.load (p ^ "mnist-test-images"),
  Owl_dense_matrix.S.load (p ^ "mnist-test-labels"),
  Owl_dense_matrix.S.load (p ^ "mnist-test-lblvec")

let print_mnist_image x =
  x |> Owl_dense_matrix_generic.reshape 28 28
  |> Owl_dense_matrix_generic.iter_rows (fun v ->
    Owl_dense_vector_generic.iter (function 0. -> Printf.printf " " | _ -> Printf.printf "■") v;
    print_endline "";
  )

(* load cifar train data, there are five batches in total. The loaded data is a
  10000 * 3072 matrix. Each row represents a 32 x 32 image of three colour
  channels, unravelled into a row vector. The labels are also returned. *)
let load_cifar_train_data batch =
  let p = local_data_path () in
  Owl_dense_matrix.S.load (p ^ "cifar10_train" ^ (string_of_int batch) ^ "_data"),
  Owl_dense_matrix.S.load (p ^ "cifar10_train" ^ (string_of_int batch) ^ "_labels")

let load_cifar_test_data () =
  let p = local_data_path () in
  Owl_dense_matrix.S.load (p ^ "cifar10_test_data"),
  Owl_dense_matrix.S.load (p ^ "cifar10_test_labels")

(* load text data and stopwords *)
let load_stopwords () =
  let p = local_data_path () in
  Owl_nlp_utils.load_stopwords (p ^ "stopwords.txt")

let load_nips_train_data stopwords =
  let p = local_data_path () in
  Owl_nlp_utils.load_from_file ~stopwords (p ^ "nips.train")
