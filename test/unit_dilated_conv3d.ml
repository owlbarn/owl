(** Unit test for Dilated Convolution3D operations *)

open Owl_types

module N = Owl.Dense.Ndarray.S


(* Functions used in tests *)

let tolerance_f64 = 1e-8
let tolerance_f32 = 5e-4

let close a b =
  N.(sub a b |> abs |> sum') < tolerance_f32

let test_dilated_conv3d ?(stride=[|1; 1; 1|]) input_shape kernel_shape rate pad =
  let inp = N.sequential ~a:1. input_shape  in
  let kernel = N.sequential ~a:1. kernel_shape in
  N.dilated_conv3d ~padding:pad inp kernel stride rate

let test_dilated_conv3d_bi ?(stride=[|1; 1; 1|]) input_shape kernel_shape rate pad =
  let inp    = N.sequential ~a:1. input_shape in
  let kernel = N.sequential ~a:1. kernel_shape in
  let output = N.dilated_conv3d ~padding:pad inp kernel stride rate in
  let output_shape = N.shape output in
  let output' = N.sequential ~a:0. output_shape in
  N.dilated_conv3d_backward_input inp kernel stride rate output'

let test_dilated_conv3d_bk ?(stride=[|1; 1; 1|]) input_shape kernel_shape rate pad =
  let inp = N.sequential ~a:1. input_shape  in
  let kernel = N.sequential ~a:1. kernel_shape in
  let output = N.dilated_conv3d ~padding:pad inp kernel stride rate in
  let output_shape = N.shape output in
  let output' = N.sequential ~a:1. output_shape in
  N.dilated_conv3d_backward_kernel inp kernel stride rate output'

let verify_value fn input_shape kernel_shape stride pad expected =
  let a = fn input_shape kernel_shape stride pad in
  let output_shape = N.shape a in
  let b = N.of_array expected output_shape in
  close a b


(* Test DilatedConvolution3D forward operation *)

module To_test_dilated_conv3d = struct

  (* multiple batches and channels *)
  let fun00 () =
    let expected = [|255789.; 627039.|] in
    verify_value test_dilated_conv3d [|2;5;5;5;2|] [|3;3;3;2;1|] [|2;2;2|] VALID expected

  (* same padding *)
  let fun01 () =
    let expected = [|
      832.; 860.; 888.; 916.; 944.; 972.; 1305.; 1344.; 780.; 804.; 828.; 852.;
      876.; 900.; 1224.; 1252.; 1280.; 1308.; 1336.; 1364.; 1851.; 1890.; 1116.;
      1140.; 1164.; 1188.; 1212.; 1236.; 1616.; 1644.; 1672.; 1700.; 1728.;
      1756.; 2397.; 2436.; 1452.; 1476.; 1500.; 1524.; 1548.; 1572.; 2031.;
      2064.; 2097.; 2130.; 2163.; 2196.; 2997.; 3042.; 1809.; 1836.; 1863.;
      1890.; 1917.; 1944.; 756.; 772.; 788.; 804.; 820.; 836.; 1095.; 1116.;
      624.; 636.; 648.; 660.; 672.; 684.; 980.; 996.; 1012.; 1028.; 1044.;
      1060.; 1389.; 1410.; 792.; 804.; 816.; 828.; 840.; 852.; 1204.; 1220.;
      1236.; 1252.; 1268.; 1284.; 1683.; 1704.; 960.; 972.; 984.; 996.; 1008.;
      1020.|] in
    verify_value test_dilated_conv3d [|1;7;7;2;1|] [|3;3;1;1;1|] [|3;3;1|] SAME expected

  (* rate equals 1 *)
  let fun02 () =
    let expected = [|
      560.; 596.; 632.; 704.; 740.; 776.; 848.; 884.; 920.; 1136.; 1172.; 1208.;
      1280.; 1316.; 1352.; 1424.; 1460.; 1496.; 1712.; 1748.; 1784.; 1856.;
      1892.; 1928.; 2000.; 2036.; 2072.|] in
    verify_value test_dilated_conv3d [|1;4;4;4;1|] [|2;2;2;1;1|] [|1;1;1|] VALID expected

  (* change input shape *)
  let fun03 () =
    let expected = [|
      2092.; 2128.; 2164.; 2200.; 2236.; 2272.; 2380.; 2416.; 2452.; 2488.;
      2524.; 2560.; 3244.; 3280.; 3316.; 3352.; 3388.; 3424.; 3532.; 3568.;
      3604.; 3640.; 3676.; 3712.; 4396.; 4432.; 4468.; 4504.; 4540.; 4576.;
      4684.; 4720.; 4756.; 4792.; 4828.; 4864.; 5548.; 5584.; 5620.; 5656.;
      5692.; 5728.; 5836.; 5872.; 5908.; 5944.; 5980.; 6016.; 6700.; 6736.;
      6772.; 6808.; 6844.; 6880.; 6988.; 7024.; 7060.; 7096.; 7132.; 7168.|] in
    verify_value test_dilated_conv3d [|1;7;4;8;1|] [|2;2;2;1;1|] [|2;2;2|] VALID expected

  (* change kernel and rate *)
  let fun04 () =
    let expected = [|
      2756.; 2834.; 2912.; 2990.; 3068.; 3146.; 7124.; 7202.; 7280.; 7358.;
      7436.; 7514.; 11492.; 11570.; 11648.; 11726.; 11804.; 11882.; 15860.;
      15938.; 16016.; 16094.; 16172.; 16250.|] in
    verify_value test_dilated_conv3d [|1;4;7;8;1|] [|1;4;3;1;1|] [|4;2;1|] VALID expected

  (* small kernel and input *)
  let fun05 () =
    let expected = [|1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.|] in
    verify_value test_dilated_conv3d [|1;2;2;2;1|] [|1;1;1;1;1|] [|3;3;3|] VALID expected

  (* change stride *)
  let fun06 () =
    let expected = [|
      16881.; 17223.; 19617.; 19959.; 27825.; 28167.; 30561.; 30903.|] in
    verify_value (test_dilated_conv3d ~stride:[|2;2;2|])
      [|1;7;4;8;1|] [|3;2;3;1;1|] [|2;1;2|] VALID expected

end


(* Test DilatedConvolution3D input-backward operation *)

module To_test_dilated_conv3d_bi = struct

  (* multiple batches and channels *)
  let fun00 () =
    let expected =  [|
      2.; 4.; 8.; 18.; 6.; 8.; 28.; 38.; 14.; 32.; 20.; 46.; 50.; 68.; 72.; 98.;
      10.; 12.; 48.; 58.; 14.; 16.; 68.; 78.; 86.; 104.; 124.; 150.; 122.; 140.;
      176.; 202.; 26.; 60.; 32.; 74.; 94.; 128.; 116.; 158.; 38.; 88.; 44.;
      102.; 138.; 188.; 160.; 218.; 162.; 196.; 200.; 242.; 230.; 264.; 284.;
      326.; 238.; 288.; 276.; 334.; 338.; 388.; 392.; 450.; 18.; 20.; 88.; 98.;
      22.; 24.; 108.; 118.; 158.; 176.; 228.; 254.; 194.; 212.; 280.; 306.;
      26.; 28.; 128.; 138.; 30.; 32.; 148.; 158.; 230.; 248.; 332.; 358.; 266.;
      284.; 384.; 410.; 298.; 332.; 368.; 410.; 366.; 400.; 452.; 494.; 438.;
      488.; 508.; 566.; 538.; 588.; 624.; 682.; 434.; 468.; 536.; 578.; 502.;
      536.; 620.; 662.; 638.; 688.; 740.; 798.; 738.; 788.; 856.; 914.; 50.;
      116.; 56.; 130.; 182.; 248.; 204.; 278.; 62.; 144.; 68.; 158.; 226.;
      308.; 248.; 338.; 314.; 380.; 352.; 426.; 446.; 512.; 500.; 574.; 390.;
      472.; 428.; 518.; 554.; 636.; 608.; 698.; 74.; 172.; 80.; 186.; 270.;
      368.; 292.; 398.; 86.; 200.; 92.; 214.; 314.; 428.; 336.; 458.; 466.;
      564.; 504.; 610.; 662.; 760.; 716.; 822.; 542.; 656.; 580.; 702.; 770.;
      884.; 824.; 946.; 578.; 644.; 648.; 722.; 710.; 776.; 796.; 870.; 718.;
      800.; 788.; 878.; 882.; 964.; 968.; 1058.; 842.; 908.; 944.; 1018.; 974.;
      1040.; 1092.; 1166.; 1046.; 1128.; 1148.; 1238.; 1210.; 1292.; 1328.;
      1418.; 858.; 956.; 928.; 1034.; 1054.; 1152.; 1140.; 1246.; 998.; 1112.;
      1068.; 1190.; 1226.; 1340.; 1312.; 1434.; 1250.; 1348.; 1352.; 1458.;
      1446.; 1544.; 1564.; 1670.; 1454.; 1568.; 1556.; 1678.; 1682.; 1796.;
      1800.; 1922.|] in
    verify_value test_dilated_conv3d_bi [|2;4;4;4;2|]
      [|2;2;2;2;2|] [|2;2;2|] VALID expected

  (* same padding *)
  let fun01 () =
    let expected = [|
      348.; 366.; 384.; 522.; 544.; 566.; 1146.; 1194.; 1242.; 1494.; 1550.;
      1606.; 1434.; 1482.; 1530.; 1830.; 1886.; 1942.; 1050.; 1080.; 1110.;
      1248.; 1282.; 1316.; 780.; 798.; 816.; 1050.; 1072.; 1094.; 2298.; 2346.;
      2394.; 2838.; 2894.; 2950.; 2586.; 2634.; 2682.; 3174.; 3230.; 3286.;
      1770.; 1800.; 1830.; 2064.; 2098.; 2132.; 831.; 846.; 861.; 942.; 959.;
      976.; 1959.; 1995.; 2031.; 2181.; 2221.; 2261.; 2175.; 2211.; 2247.;
      2421.; 2461.; 2501.; 1290.; 1311.; 1332.; 1413.; 1436.; 1459.; 1392.;
      1434.; 1476.; 1566.; 1612.; 1658.; 3234.; 3330.; 3426.; 3582.; 3686.;
      3790.; 3810.; 3906.; 4002.; 4206.; 4310.; 4414.; 2238.; 2292.; 2346.;
      2436.; 2494.; 2552.; 2400.; 2442.; 2484.; 2670.; 2716.; 2762.; 5538.;
      5634.; 5730.; 6078.; 6182.; 6286.; 6114.; 6210.; 6306.; 6702.; 6806.;
      6910.; 3534.; 3588.; 3642.; 3828.; 3886.; 3944.|] in
    verify_value test_dilated_conv3d_bi [|1;5;4;6;1|]
      [|3;2;3;1;1|] [|3;2;3|] SAME expected

  (* rate equals 1 *)
  let fun02 () =
    let expected = [|
      0.; 1.; 2.; 3.; 2.; 11.; 17.; 15.; 12.; 35.; 49.; 33.; 16.; 40.; 49.; 30.;
      6.; 26.; 40.; 30.; 46.; 130.; 166.; 108.; 90.; 226.; 278.; 168.; 80.;
      188.; 218.; 126.; 54.; 134.; 172.; 102.; 178.; 418.; 502.; 288.; 222.;
      514.; 614.; 348.; 164.; 368.; 422.; 234.; 84.; 187.; 212.; 117.; 218.;
      479.; 533.; 291.; 252.; 551.; 613.; 333.; 160.; 346.; 379.; 204.|] in
    verify_value test_dilated_conv3d_bi [|1;4;4;4;1|]
      [|2;2;3;1;1|] [|1;1;1|] VALID expected

  (* change input shape *)
  let fun03 () =
    let expected = [|
      0.; 1.; 0.; 0.; 0.; 2.; 2.; 3.; 0.; 0.; 4.; 6.; 4.; 8.; 0.; 0.; 8.; 14.;
      6.; 9.; 0.; 0.; 8.; 12.; 12.; 20.; 0.; 0.; 16.; 26.; 10.; 15.; 0.; 0.;
      12.; 18.; 20.; 25.; 0.; 0.; 24.; 30.|] in
    verify_value test_dilated_conv3d_bi [|1;7;3;2;1|]
      [|3;2;1;1;1|] [|2;2;1|] VALID expected

  (* change kernel and rate *)
  let fun04 () =
    let expected = [|
      112.; 116.; 180.; 124.; 128.; 198.; 136.; 140.; 216.; 148.; 152.; 234.;
      160.; 164.; 252.; 172.; 176.; 270.; 189.; 198.; 288.; 216.; 225.; 324.;
      243.; 252.; 360.; 270.; 279.; 396.; 297.; 306.; 432.; 324.; 333.; 468.;
      260.; 268.; 324.; 284.; 292.; 354.; 308.; 316.; 384.; 332.; 340.; 414.;
      356.; 364.; 444.; 380.; 388.; 474.; 411.; 426.; 504.; 456.; 471.; 558.;
      501.; 516.; 612.; 546.; 561.; 666.; 591.; 606.; 720.; 636.; 651.; 774.;
      408.; 420.; 468.; 444.; 456.; 510.; 480.; 492.; 552.; 516.; 528.; 594.;
      552.; 564.; 636.; 588.; 600.; 678.|] in
    verify_value test_dilated_conv3d_bi [|1;5;6;3;1|]
      [|4;1;2;1;1|] [|2;1;3|] SAME expected

  (* small kernel and input *)
  let fun05 () =
    let expected = [|
      0.; 1.; 2.; 3.; 4.; 5.; 6.; 7.; 8.; 9.; 10.; 11.; 12.; 13.; 14.; 15.; 16.;
      17.; 18.; 19.; 20.; 21.; 22.; 23.; 24.; 25.; 26.|] in
    verify_value test_dilated_conv3d_bi [|1;3;3;3;1|]
      [|1;1;1;1;1|] [|2;2;2|] VALID expected

  (* change stride *)
  let fun06 () =
    let expected = [|
      0.; 1.; 0.; 0.; 2.; 5.; 0.; 0.; 4.; 9.; 0.; 0.; 6.; 9.; 0.; 0.; 0.; 0.;
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 4.; 9.; 0.; 0.;
      22.; 34.; 0.; 0.; 34.; 50.; 0.; 0.; 30.; 39.; 0.; 0.; 0.; 0.; 0.; 0.; 0.;
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 16.; 27.; 0.; 0.; 58.; 82.;
      0.; 0.; 70.; 98.; 0.; 0.; 54.; 69.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.;
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 28.; 35.; 0.; 0.; 74.; 89.; 0.; 0.;
      84.; 101.; 0.; 0.; 54.; 63.; 0.; 0.|] in
    verify_value (test_dilated_conv3d_bi ~stride:[|2;2;1|])
      [|1;7;8;2;1|] [|3;3;1;1;1|] [|2;2;1|] VALID expected

end


(* Test DilatedConvolution3D kernel-backward operation *)

module To_test_dilated_conv3d_bk = struct

  (* multiple batches and channels *)
  let fun00 () =
    let expected = [|
      52176.; 54416.; 52432.; 54688.; 53200.; 55504.; 53456.; 55776.; 54224.;
      56592.; 54480.; 56864.; 76752.; 80528.; 77008.; 80800.; 77776.; 81616.;
      78032.; 81888.; 78800.; 82704.; 79056.; 82976.; 101328.; 106640.; 101584.;
      106912.; 102352.; 107728.; 102608.; 108000.; 103376.; 108816.; 103632.;
      109088.|] in
    verify_value test_dilated_conv3d_bk [|2;5;4;6;2|]
      [|3;1;3;2;2|] [|2;2;2|] VALID expected

  (* same padding *)
  let fun01 () =
    let expected = [|
      39396.; 83166.; 43608.; 47496.; 98718.; 51060.; 216750.; 434715.; 217560.;
      217560.; 434715.; 216750.; 51060.; 98718.; 47496.; 43608.; 83166.; 39396.
    |] in
    verify_value test_dilated_conv3d_bk [|1;5;4;6;1|]
      [|3;2;3;1;1|] [|3;2;3|] SAME expected

  (* rate equals 1 *)
  let fun02 () =
    let expected = [|
      4929.; 5100.; 5271.; 5613.; 5784.; 5955.; 7665.; 7836.; 8007.; 8349.;
      8520.; 8691.|] in
    verify_value test_dilated_conv3d_bk [|1;4;4;4;1|]
      [|2;2;3;1;1|] [|1;1;1|] VALID expected

  (* change input shape *)
  let fun03 () =
    let expected = [|207.; 291.; 459.; 543.; 711.; 795.|] in
    verify_value test_dilated_conv3d_bk [|1;7;3;2;1|]
      [|3;2;1;1;1|] [|2;2;1|] VALID expected

  (* change kernel and rate *)
  let fun04 () =
    let expected = [|
      34116.; 18018.; 115752.; 58500.; 116616.; 57636.; 35412.; 16722.|] in
    verify_value test_dilated_conv3d_bk [|1;5;6;3;1|]
      [|4;1;2;1;1|] [|2;1;3|] SAME expected

  (* small kernel and input *)
  let fun05 () =
    let expected = [|6930.|] in
    verify_value test_dilated_conv3d_bk [|1;3;3;3;1|]
      [|1;1;1;1;1|] [|2;2;2|] VALID expected

  (* change stride *)
  let fun06 () =
    let expected = [|
      976.; 1120.; 1264.; 2128.; 2272.; 2416.; 3280.; 3424.; 3568.|] in
    verify_value (test_dilated_conv3d_bk ~stride:[|2;2;1|])
      [|1;7;8;2;1|] [|3;3;1;1;1|] [|2;2;1|] VALID expected

end


(* tests for dilated_conv3d forward operation *)

let fun_cdf00 () =
  Alcotest.(check bool) "fun_cdf00" true (To_test_dilated_conv3d.fun00 ())

let fun_cdf01 () =
  Alcotest.(check bool) "fun_cdf01" true (To_test_dilated_conv3d.fun01 ())

let fun_cdf02 () =
  Alcotest.(check bool) "fun_cdf02" true (To_test_dilated_conv3d.fun02 ())

let fun_cdf03 () =
  Alcotest.(check bool) "fun_cdf03" true (To_test_dilated_conv3d.fun03 ())

let fun_cdf04 () =
  Alcotest.(check bool) "fun_cdf04" true (To_test_dilated_conv3d.fun04 ())

let fun_cdf05 () =
  Alcotest.(check bool) "fun_cdf05" true (To_test_dilated_conv3d.fun05 ())

let fun_cdf06 () =
  Alcotest.(check bool) "fun_cdf06" true (To_test_dilated_conv3d.fun06 ())

(* tests for dilated conv3d input backward operations *)

let fun_cdbi00 () =
  Alcotest.(check bool) "fun_cdbi00" true
    (To_test_dilated_conv3d_bi.fun00 ())

let fun_cdbi01 () =
  Alcotest.(check bool) "fun_cdbi01" true
    (To_test_dilated_conv3d_bi.fun01 ())

let fun_cdbi02 () =
  Alcotest.(check bool) "fun_cdbi02" true
    (To_test_dilated_conv3d_bi.fun02 ())

let fun_cdbi03 () =
  Alcotest.(check bool) "fun_cdbi03" true
    (To_test_dilated_conv3d_bi.fun03 ())

let fun_cdbi04 () =
  Alcotest.(check bool) "fun_cdbi04" true
    (To_test_dilated_conv3d_bi.fun04 ())

let fun_cdbi05 () =
  Alcotest.(check bool) "fun_cdbi05" true
    (To_test_dilated_conv3d_bi.fun05 ())

let fun_cdbi06 () =
  Alcotest.(check bool) "fun_cdbi06" true
    (To_test_dilated_conv3d_bi.fun06 ())

(* tests for dilated_conv3d kernel backward operations *)

let fun_cdbk00 () =
  Alcotest.(check bool) "fun_cdbk00" true
    (To_test_dilated_conv3d_bk.fun00 ())

let fun_cdbk01 () =
  Alcotest.(check bool) "fun_cdbk01" true
    (To_test_dilated_conv3d_bk.fun01 ())

let fun_cdbk02 () =
  Alcotest.(check bool) "fun_cdbk02" true
    (To_test_dilated_conv3d_bk.fun02 ())

let fun_cdbk03 () =
  Alcotest.(check bool) "fun_cdbk03" true
    (To_test_dilated_conv3d_bk.fun03 ())

let fun_cdbk04 () =
  Alcotest.(check bool) "fun_cdbk04" true
    (To_test_dilated_conv3d_bk.fun04 ())

let fun_cdbk05 () =
  Alcotest.(check bool) "fun_cdbk05" true
    (To_test_dilated_conv3d_bk.fun05 ())

let fun_cdbk06 () =
  Alcotest.(check bool) "fun_cdbk06" true
    (To_test_dilated_conv3d_bk.fun06 ())

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
