(** Unit test for Dilated Convolution2D operations *)

open Owl_types

module N = Owl.Dense.Ndarray.S


(* Functions used in tests *)

let tolerance_f64 = 1e-8
let tolerance_f32 = 5e-4

let close a b =
  N.(sub a b |> abs |> sum') < tolerance_f32

let test_dilated_conv2d ?(stride=[|1; 1|]) input_shape kernel_shape rate pad =
  let inp = N.sequential ~a:1. input_shape  in
  let kernel = N.sequential ~a:1. kernel_shape in
  N.dilated_conv2d ~padding:pad inp kernel stride rate

let test_dilated_conv2d_bi ?(stride=[|1; 1|]) input_shape kernel_shape rate pad =
  let inp = N.sequential ~a:1. input_shape  in
  let kernel = N.sequential ~a:1. kernel_shape in
  let output = N.dilated_conv2d ~padding:pad inp kernel stride rate in
  let output_shape = N.shape output in
  let output' = N.sequential ~a:1. output_shape in
  N.dilated_conv2d_backward_input inp kernel stride rate output'

let test_dilated_conv2d_bk ?(stride=[|1; 1|]) input_shape kernel_shape rate pad =
  let inp = N.sequential ~a:1. input_shape  in
  let kernel = N.sequential ~a:1. kernel_shape in
  let output = N.dilated_conv2d~padding:pad inp kernel stride rate in
  let output_shape = N.shape output in
  let output' = N.sequential ~a:1. output_shape in
  N.dilated_conv2d_backward_kernel inp kernel stride rate output'

let verify_value fn input_shape kernel_shape stride pad expected =
  let a = fn input_shape kernel_shape stride pad in
  let output_shape = N.shape a in
  let b = N.of_array expected output_shape in
  close a b


(* Test DilatedConvolution2D forward operation *)

module To_test_dilated_conv2d = struct

  (* multiple batches and channels *)
  let fun00 () =
    let expected = [|22383.; 23274.; 54135.; 56790.|] in
    verify_value test_dilated_conv2d [|2;7;7;2|] [|3;3;2;2|] [|3;3|] VALID expected

  (* same padding *)
  let fun01 () =
    let expected = [|
      430.; 458.; 486.; 672.; 402.; 426.; 450.; 626.; 654.; 682.; 945.; 570.;
      594.; 618.; 822.; 850.; 878.; 1218.; 738.; 762.; 786.; 1032.; 1065.;
      1098.; 1521.; 918.; 945.; 972.; 386.; 402.; 418.; 558.; 318.; 330.; 342.;
      498.; 514.; 530.; 705.; 402.; 414.; 426.; 610.; 626.; 642.; 852.; 486.;
      498.; 510. |] in
    verify_value test_dilated_conv2d [|1;7;7;1|] [|3;3;1;1|] [|3;3|] SAME expected

  (* rate equals 1 *)
  let fun02 () =
    let expected = [|5.; 8.; 11.; 17.; 20.; 23.; 29.; 32.; 35.; 41.; 44.; 47.|] in
    verify_value test_dilated_conv2d [|1;4;4;1|] [|1;2;1;1|] [|1;1|] VALID expected

  (* change input shape *)
  let fun03 () =
    let expected = [|
      196.; 206.; 216.; 226.; 236.; 276.; 286.; 296.; 306.; 316.; 356.; 366.;
      376.; 386.; 396.; 436.; 446.; 456.; 466.; 476.|] in
    verify_value test_dilated_conv2d [|1;7;8;1|] [|2;2;1;1|] [|3;3|] VALID expected

  (* change kernel and rate *)
  let fun04 () =
    let expected = [|330.; 340.; 350.; 360.; 370.; 380.; 390.; 400.|] in
    verify_value test_dilated_conv2d [|1;7;8;1|] [|4;1;1;1|] [|2;3|] VALID expected

  (* small kernel and input *)
  let fun05 () =
    let expected = [|1.; 2.; 3.; 4.|] in
    verify_value test_dilated_conv2d [|1;2;2;1|] [|1;1;1;1|] [|4;4|] VALID expected

  (* change stride *)
  let fun06 () =
    let expected = [|1155.; 1245.; 1875.; 1965.|] in
    verify_value (test_dilated_conv2d ~stride:[|2;2|])
      [|1;7;8;1|] [|3;3;1;1|] [|2;2|] VALID expected

end


(* Test DilatedConvolution2D input-backward operation *)

module To_test_dilated_conv2d_bi = struct

  (* multiple batches and channels *)
  let fun00 () =
    let expected = [|
      5.; 11.; 11.; 25.; 17.; 23.; 39.; 53.; 29.; 35.; 67.; 81.; 0.; 0.; 0.; 0.;
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 41.; 47.; 95.; 109.; 53.; 59.; 123.; 137.;
      65.; 71.; 151.; 165.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 77.;
      83.; 179.; 193.; 89.; 95.; 207.; 221.; 101.; 107.; 235.; 249.; 17.; 39.;
      23.; 53.; 61.; 83.; 83.; 113.; 105.; 127.; 143.; 173.; 0.; 0.; 0.; 0.;
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 149.; 171.; 203.; 233.; 193.; 215.; 263.; 293.; 237.; 259.; 323.; 353.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.;
      0.; 281.; 303.; 383.; 413.; 325.; 347.; 443.; 473.; 369.; 391.; 503.;
      533.|] in
    verify_value test_dilated_conv2d_bi [|2;5;6;2|] [|3;3;2;2|] [|2;2|] VALID expected

  (* same padding *)
  let fun01 () =
    let expected = [|
      90.; 102.; 114.; 198.; 158.; 174.; 190.; 174.; 186.; 198.; 345.; 270.;
      286.; 302.; 258.; 270.; 282.; 492.; 382.; 398.; 414.; 378.; 405.; 432.;
      729.; 552.; 585.; 618.; 414.; 438.; 462.; 732.; 522.; 550.; 578.; 582.;
      606.; 630.; 1005.; 718.; 746.; 774.; 750.; 774.; 798.; 1278.; 914.; 942.;
      970.|] in
    verify_value test_dilated_conv2d_bi [|1;7;7;1|] [|3;3;1;1|] [|3;3|] SAME expected

  (* rate equals 1 *)
  let fun02 () =
    let expected = [|
      4.; 10.; 16.; 17.; 29.; 62.; 83.; 75.; 77.; 146.; 167.; 139.; 125.; 230.;
      251.; 203.|] in
    verify_value test_dilated_conv2d_bi [|1;4;4;1|] [|2;3;1;1|] [|1;1|] SAME expected

  (* change input shape *)
  let fun03 () =
    let expected = [|
      1.; 0.; 2.; 0.; 3.; 0.; 0.; 0.; 0.; 0.; 4.; 0.; 5.; 0.; 6.; 0.; 0.; 0.;
      0.; 0.; 7.; 0.; 8.; 0.; 9.|] in
    verify_value test_dilated_conv2d_bi [|1;5;5;1|] [|3;3;1;1|] [|2;2|] VALID expected

  (* change kernel and rate *)
  let fun04 () =
    let expected = [|
      1.; 2.; 3.; 4.; 5.; 6.; 0.; 0.; 0.; 0.; 0.; 0.; 2.; 4.; 6.; 8.; 10.; 12.;
      0.; 0.; 0.; 0.; 0.; 0.; 3.; 6.; 9.; 12.; 15.; 18.|] in
    verify_value test_dilated_conv2d_bi [|1;5;6;1|] [|3;1;1;1|] [|2;3|] VALID expected

  (* small kernel and input *)
  let fun05 () =
    let expected = [|1.; 2.; 3.; 4.|] in
    verify_value test_dilated_conv2d_bi [|1;2;2;1|] [|1;1;1;1|] [|3;3|] SAME expected

  (* change stride *)
  let fun06 () =
    let expected = [|134.; 154.; 174.; 294.; 314.; 334.; 454.; 474.; 494.|] in
    verify_value (test_dilated_conv2d_bk ~stride:[|2;2|])
      [|1;7;8;1|] [|3;3;1;1|] [|2;2|] VALID expected

end


(* Test DilatedConvolution2D kernel-backward operation *)

module To_test_dilated_conv2d_bk = struct

  (* multiple batches and channels *)
  let fun00 () =
    let expected = [|
      756.; 884.; 772.; 904.; 820.; 964.; 836.; 984.; 884.; 1044.; 900.; 1064.;
      1140.; 1364.; 1156.; 1384.; 1204.; 1444.; 1220.; 1464.; 1268.; 1524.;
      1284.; 1544.; 1524.; 1844.; 1540.; 1864.; 1588.; 1924.; 1604.; 1944.;
      1652.; 2004.; 1668.; 2024.|] in
    verify_value test_dilated_conv2d_bk [|2;5;6;2|] [|3;3;2;2|] [|2;2|] VALID expected

  (* same padding *)
  let fun01 () =
    let expected = [|
      8696.; 16240.; 9704.; 22960.; 40425.; 22960.; 9704.; 16240.; 8696.|] in
    verify_value test_dilated_conv2d_bk [|1;7;7;1|] [|3;3;1;1|] [|3;3|] SAME expected

  (* rate equals 1 *)
  let fun02 () =
    let expected = [|12655.; 13120.; 13585.; 15910.; 16375.; 16840.|] in
    verify_value test_dilated_conv2d_bk [|1;7;7;1|] [|2;3;1;1|] [|1;1|] VALID expected

  (* change input shape *)
  let fun03 () =
    let expected = [|
      1090.; 1246.; 1402.; 2338.; 2494.; 2650.; 3586.; 3742.; 3898.|] in
    verify_value test_dilated_conv2d_bk [|1;7;8;1|] [|3;3;1;1|] [|2;2|] VALID expected

  (* change kernel and rate *)
  let fun04 () =
    let expected = [|55.; 100.; 295.; 340.; 535.; 580.; 775.; 820.|] in
    verify_value test_dilated_conv2d_bk [|1;7;8;1|] [|4;2;1;1|] [|2;3|] VALID expected

  (* small kernel and input *)
  let fun05 () =
    let expected = [|30.|] in
    verify_value test_dilated_conv2d_bk [|1;2;2;1|] [|1;1;1;1|] [|3;3|] VALID expected

  (* change stride *)
  let fun06 () =
    let expected = [|
      1.; 0.; 4.; 0.; 7.; 0.; 6.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 7.; 0.;
      23.; 0.; 33.; 0.; 24.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 19.; 0.; 53.;
      0.; 63.; 0.; 42.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 21.; 0.; 52.; 0.;
      59.; 0.; 36.; 0.|] in
    verify_value (test_dilated_conv2d_bi ~stride:[|2;2|])
      [|1;7;8;1|] [|3;3;1;1|] [|2;2|] VALID expected

end


(* tests for dilated_conv2d forward operation *)

let fun_cdf00 () =
  Alcotest.(check bool) "fun_cdf00" true (To_test_dilated_conv2d.fun00 ())

let fun_cdf01 () =
  Alcotest.(check bool) "fun_cdf01" true (To_test_dilated_conv2d.fun01 ())

let fun_cdf02 () =
  Alcotest.(check bool) "fun_cdf02" true (To_test_dilated_conv2d.fun02 ())

let fun_cdf03 () =
  Alcotest.(check bool) "fun_cdf03" true (To_test_dilated_conv2d.fun03 ())

let fun_cdf04 () =
  Alcotest.(check bool) "fun_cdf04" true (To_test_dilated_conv2d.fun04 ())

let fun_cdf05 () =
  Alcotest.(check bool) "fun_cdf05" true (To_test_dilated_conv2d.fun05 ())

let fun_cdf06 () =
  Alcotest.(check bool) "fun_cdf06" true (To_test_dilated_conv2d.fun06 ())

(* tests for dilated conv2d input backward operations *)

let fun_cdbi00 () =
  Alcotest.(check bool) "fun_cdbi00" true
    (To_test_dilated_conv2d_bi.fun00 ())

let fun_cdbi01 () =
  Alcotest.(check bool) "fun_cdbi01" true
    (To_test_dilated_conv2d_bi.fun01 ())

let fun_cdbi02 () =
  Alcotest.(check bool) "fun_cdbi02" true
    (To_test_dilated_conv2d_bi.fun02 ())

let fun_cdbi03 () =
  Alcotest.(check bool) "fun_cdbi03" true
    (To_test_dilated_conv2d_bi.fun03 ())

let fun_cdbi04 () =
  Alcotest.(check bool) "fun_cdbi04" true
    (To_test_dilated_conv2d_bi.fun04 ())

let fun_cdbi05 () =
  Alcotest.(check bool) "fun_cdbi05" true
    (To_test_dilated_conv2d_bi.fun05 ())

let fun_cdbi06 () =
  Alcotest.(check bool) "fun_cdbi06" true
    (To_test_dilated_conv2d_bi.fun06 ())

(* tests for dilated_conv2d kernel backward operations *)

let fun_cdbk00 () =
  Alcotest.(check bool) "fun_cdbk00" true
    (To_test_dilated_conv2d_bk.fun00 ())

let fun_cdbk01 () =
  Alcotest.(check bool) "fun_cdbk01" true
    (To_test_dilated_conv2d_bk.fun01 ())

let fun_cdbk02 () =
  Alcotest.(check bool) "fun_cdbk02" true
    (To_test_dilated_conv2d_bk.fun02 ())

let fun_cdbk03 () =
  Alcotest.(check bool) "fun_cdbk03" true
    (To_test_dilated_conv2d_bk.fun03 ())

let fun_cdbk04 () =
  Alcotest.(check bool) "fun_cdbk04" true
    (To_test_dilated_conv2d_bk.fun04 ())

let fun_cdbk05 () =
  Alcotest.(check bool) "fun_cdbk05" true
    (To_test_dilated_conv2d_bk.fun05 ())

let fun_cdbk06 () =
  Alcotest.(check bool) "fun_cdbk06" true
    (To_test_dilated_conv2d_bk.fun06 ())

let test_set = [
  "fun_cdf00",  `Slow, fun_cdf00;
  "fun_cdf01",  `Slow, fun_cdf01;
  "fun_cdf02",  `Slow, fun_cdf02;
  "fun_cdf03",  `Slow, fun_cdf03;
  "fun_cdf04",  `Slow, fun_cdf04;
  "fun_cdf05",  `Slow, fun_cdf05;
  "fun_cdf06",  `Slow, fun_cdf06;
  "fun_cdbi00", `Slow, fun_cdbi00;
  "fun_cdbi01", `Slow, fun_cdbi01;
  "fun_cdbi02", `Slow, fun_cdbi02;
  "fun_cdbi03", `Slow, fun_cdbi03;
  "fun_cdbi04", `Slow, fun_cdbi04;
  "fun_cdbi05", `Slow, fun_cdbi05;
  "fun_cdbi06", `Slow, fun_cdbi06;
  "fun_cdbk00", `Slow, fun_cdbk00;
  "fun_cdbk01", `Slow, fun_cdbk01;
  "fun_cdbk02", `Slow, fun_cdbk02;
  "fun_cdbk03", `Slow, fun_cdbk03;
  "fun_cdbk04", `Slow, fun_cdbk04;
  "fun_cdbk05", `Slow, fun_cdbk05;
  "fun_cdbk06", `Slow, fun_cdbk06;
]
