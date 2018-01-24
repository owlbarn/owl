(** Unit test for Convolution3D operations *)

open Owl

module N = Dense.Ndarray.S

(* Functions used in tests *)

let tolerance_f64 = 1e-8
let tolerance_f32 = 5e-4
let close a b =
  N.(a - b |> abs |> sum') < tolerance_f32

let test_conv3d input_shape kernel_shape stride pad =
  let ts1 = Array.fold_left ( * ) 1 input_shape in
  let ts2 = Array.fold_left ( * ) 1 kernel_shape in
  let inp = N.sequential ~a:1. input_shape in
  let inp = N.div_scalar inp (float_of_int ts1) in
  let kernel = N.sequential ~a:1. kernel_shape in
  let kernel = N.div_scalar kernel (float_of_int ts2) in
  N.conv3d ~padding:pad inp kernel stride

let test_conv3d_back_input input_shape kernel_shape stride pad =
  let inp = N.sequential ~a:1. input_shape in
  let kernel = N.sequential ~a:1. kernel_shape in
  let output = N.conv3d ~padding:pad inp kernel stride in
  let output_shape = N.shape output in
  let output' = N.sequential ~a:0. output_shape in
  N.conv3d_backward_input inp kernel stride output'

let test_conv3d_back_kernel input_shape kernel_shape stride pad =
  let inp = N.sequential ~a:1. input_shape in
  let kernel = N.sequential ~a:1. kernel_shape in
  let output = N.conv3d ~padding:pad inp kernel stride in
  let output_shape = N.shape output in
  let output' = N.sequential ~a:0. output_shape in
  N.conv3d_backward_kernel inp kernel stride output'

let verify_value fn input_shape kernel_shape stride pad expected =
  let a = fn input_shape kernel_shape stride pad in
  let output_shape = N.shape a in
  let b = N.of_array expected output_shape in
  close a b

(* Test Convolution3D forward operations *)

module To_test_conv3d = struct

  (* testConv3D1x1x1Kernel *)
  let fun00 () =
    let expected = [|
      0.18518519; 0.22222222; 0.25925926; 0.40740741; 0.5; 0.59259259;
      0.62962963; 0.77777778; 0.92592593; 0.85185185; 1.05555556; 1.25925926;
      1.07407407; 1.33333333; 1.59259259; 1.2962963; 1.61111111; 1.92592593|] in
    verify_value test_conv3d [|1;2;3;1;3|] [|1;1;1;3;3|] [|1;1;1|] VALID expected

  let fun01 () =
    let expected = [|
      0.18518519; 0.22222222; 0.25925926; 0.40740741; 0.5; 0.59259259;
      0.62962963; 0.77777778; 0.92592593; 0.85185185; 1.05555556; 1.25925926;
      1.07407407; 1.33333333; 1.59259259; 1.2962963; 1.61111111; 1.92592593|] in
    verify_value test_conv3d [|1;2;1;3;3|] [|1;1;1;3;3|] [|1;1;1|] VALID expected

  let fun02 () =
    let expected = [|
      0.18518519; 0.22222222; 0.25925926; 0.40740741; 0.5; 0.59259259;
      0.62962963; 0.77777778; 0.92592593; 0.85185185; 1.05555556; 1.25925926;
      1.07407407; 1.33333333; 1.59259259; 1.2962963; 1.61111111; 1.92592593|] in
    verify_value test_conv3d [|1;1;2;3;3|] [|1;1;1;3;3|] [|1;1;1|] VALID expected

  (* testConv3D2x2x2Kernel *)
  let fun03 () =
    let expected = [|
      3.77199074; 3.85069444; 3.92939815; 4.2650463; 4.35763889; 4.45023148;
      6.73032407; 6.89236111; 7.05439815; 7.22337963; 7.39930556; 7.57523148;
      9.68865741; 9.93402778; 10.17939815; 10.18171296; 10.44097222; 10.70023148|]
    in
    verify_value test_conv3d [|1;4;2;3;3|] [|2;2;2;3;3|] [|1;1;1|] VALID expected

  (* testConv3DStrides *)
  let fun04 () =
    let expected = [|
      0.06071429; 0.08988095; 0.10238095; 0.11488095; 0.12738095; 0.13988095;
      0.08452381; 0.26071429; 0.35238095; 0.36488095; 0.37738095; 0.38988095;
      0.40238095; 0.23452381; 0.46071429; 0.61488095; 0.62738095; 0.63988095;
      0.65238095; 0.66488095; 0.38452381; 1.12738095; 1.48988095; 1.50238095;
      1.51488095; 1.52738095; 1.53988095; 0.88452381; 1.32738095; 1.75238095;
      1.76488095; 1.77738095; 1.78988095; 1.80238095; 1.03452381; 1.52738095;
      2.01488095; 2.02738095; 2.03988095; 2.05238095; 2.06488095; 1.18452381;
      2.19404762; 2.88988095; 2.90238095; 2.91488095; 2.92738095; 2.93988095;
      1.68452381; 2.39404762; 3.15238095; 3.16488095; 3.17738095; 3.18988095;
      3.20238095; 1.83452381; 2.59404762; 3.41488095; 3.42738095; 3.43988095;
      3.45238095; 3.46488095; 1.98452381|] in
    verify_value test_conv3d [|1;5;8;7;1|] [|1;2;3;1;1|] [|2;3;1|] SAME expected

  (* testConv3D2x2x2KernelStride2 *)
  let fun05 () =
    let expected = [|
      3.77199074; 3.85069444; 3.92939815;
      9.68865741; 9.93402778; 10.17939815|] in
    verify_value test_conv3d [|1;4;2;3;3|] [|2;2;2;3;3|] [|2;2;2|] VALID expected

  (* testConv3DStride3 *)
  let fun06 () =
    let expected = [|
      1.51140873; 1.57167659; 1.63194444; 1.56349206; 1.62673611; 1.68998016;
      1.6155754 ; 1.68179563; 1.74801587; 1.9280754 ; 2.01215278; 2.09623016;
      1.98015873; 2.0672123 ; 2.15426587; 2.03224206; 2.12227183; 2.21230159;
      4.4280754 ; 4.65500992; 4.88194444; 4.48015873; 4.71006944; 4.93998016;
      4.53224206; 4.76512897; 4.99801587; 4.84474206; 5.09548611; 5.34623016;
      4.8968254 ; 5.15054563; 5.40426587; 4.94890873; 5.20560516; 5.46230159|] in
    verify_value test_conv3d [|1;6;7;8;2|] [|3;2;1;2;3|] [|3;3;3|] VALID expected

  (* testConv3D2x2x2KernelStride2Same *)
  let fun07 () =
    let expected = [|
      3.77199074; 3.85069444; 3.92939815 ; 2.0162037 ; 2.06597222; 2.11574074;
      9.68865741; 9.93402778; 10.17939815; 4.59953704; 4.73263889; 4.86574074|] in
    verify_value test_conv3d [|1;4;2;3;3|] [|2;2;2;3;3|] [|2;2;2|] SAME expected

  (* testKernelSmallerThanStride1 *)
  let fun08 () =
    let expected = [|
      0.03703704; 0.11111111; 0.25925926; 0.33333333;
      0.7037037 ; 0.77777778; 0.92592593; 1.|] in
    verify_value test_conv3d [|1;3;3;3;1|] [|1;1;1;1;1|] [|2;2;2|] SAME expected

  (* testKernelSmallerThanStride2 *)
  let fun09 () =
    let expected = [|
      0.03703704; 0.11111111; 0.25925926; 0.33333333;
      0.7037037 ; 0.77777778; 0.92592593; 1.|] in
    verify_value test_conv3d [|1;3;3;3;1|] [|1;1;1;1;1|] [|2;2;2|] VALID expected

  (* testKernelSmallerThanStride3 *)
  let fun10 () =
    let expected = [|
      0.54081633; 0.58017493; 0.28061224; 0.81632653; 0.85568513; 0.40306122;
      0.41873178; 0.4340379 ; 0.19642857; 2.46938776; 2.50874636; 1.1377551 ;
      2.74489796; 2.78425656; 1.26020408; 1.16873178; 1.1840379 ; 0.51785714;
      1.09511662; 1.10604956; 0.44642857; 1.17164723; 1.18258017; 0.47704082;
      0.3691691 ; 0.37244898; 0.125|] in
    verify_value test_conv3d [|1;7;7;7;1|] [|2;2;2;1;1|] [|3;3;3|] SAME expected

  (* testKernelSmallerThanStride4 *)
  let fun10 () =
    let expected = [|
      0.540816; 0.580175; 0.816327; 0.855685;
      2.469388; 2.508746; 2.744898; 2.784257|] in
    verify_value test_conv3d [|1;7;7;7;1|] [|2;2;2;1;1|] [|3;3;3|] VALID expected

  (* testKernelSizeMatchesInputSize *)
  let fun11 () =
    let expected = [|1.5625; 1.875|] in
    verify_value test_conv3d [|1;2;1;2;1|] [|2;1;2;1;2|] [|1;1;1|] VALID expected

end

(* Test Convolution3D input-backward operations *)

module To_test_conv3d_back_input = struct

  (* testInputGradientValidPaddingStrideOne  *)
  let fun00 () =
    let expected = [|
      8.; 17.; 52.; 97.; 98.; 134.; 88.; 160.; 464.; 662.; 484.; 610.; 376.;
      556.; 1256.; 1670.; 988.; 1222.; 548.; 665.; 1456.; 1717.; 962.; 1106.;
      80.; 89.; 412.; 457.; 386.; 422.; 664.; 736.; 2048.; 2246.; 1492.; 1618.;
      1816.; 1996.; 4568.; 4982.; 2860.; 3094.; 1484.; 1601.; 3544.; 3805.;
      2114.; 2258.|] in
    verify_value test_conv3d_back_input [|1;2;4;3;2|]
      [|2;2;2;2;3|] [|1;1;1|] VALID expected


  (* testInputGradientValidPaddingStrideTwo  *)
  let fun01 () =
    let expected = [|
      2.; 4.; 8.; 18.; 6.; 8.; 28.; 38.; 10.; 12.; 48.; 58.; 14.; 16.; 68.; 78.;
      14.; 32.; 20.; 46.; 50.; 68.; 72.; 98.; 86.; 104.; 124.; 150.; 122.; 140.;
      176.; 202.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.|] in
    verify_value test_conv3d_back_input [|1;5;2;4;1|]
      [|2;2;2;1;2|] [|2;2;2|] VALID expected


  (* testInputGradientValidPaddingStrideThree *)
  let fun02 () =
    let expected = [|
      2.; 4.; 6.; 0.; 0.; 8.; 10.; 12.; 0.; 0.; 14.; 16.; 18.; 0.; 0.; 8.; 18.;
      28.; 0.; 0.; 38.; 48.; 58.; 0.; 0.; 68.; 78.; 88.; 0.; 0.; 20.; 22.; 24.;
      0.; 0.; 26.; 28.; 30.; 0.; 0.; 32.; 34.; 36.; 0.; 0.; 98.; 108.; 118.; 0.;
      0.; 128.; 138.; 148.; 0.; 0.; 158.; 168.; 178.; 0.; 0.; 38.; 40.; 42.; 0.;
      0.; 44.; 46.; 48.; 0.; 0.; 50.; 52.; 54.; 0.; 0.; 188.; 198.; 208.; 0.;
      0.; 218.; 228.; 238.; 0.; 0.; 248.; 258.; 268.; 0.; 0.|] in
    verify_value test_conv3d_back_input [|1;3;6;5;1|]
      [|3;3;3;1;2|] [|3;3;3|] VALID expected

  (* testInputGradientSamePaddingStrideOne *)
  let fun03 () =
    let expected = [|
      4.; 8.; 10.; 16.; 28.; 40.; 44.; 60.; 28.; 40.; 43.; 58.; 110.; 140.;
      146.; 182.; 76.; 88.; 90.; 104.; 204.; 232.; 236.; 268.|] in
    verify_value test_conv3d_back_input [|1;3;2;2;2|]
      [|3;2;1;2;1|] [|1;1;1|] SAME expected

  (* testInputGradientSamePaddingStrideTwo *)
  let fun04 () =
    let expected = [|
      2.; 4.; 8.; 6.; 8.; 28.; 10.; 12.; 48.; 14.; 16.; 68.; 14.; 32.; 20.; 50.;
      68.; 72.; 86.; 104.; 124.; 122.; 140.; 176.|] in
    verify_value test_conv3d_back_input [|1;4;2;3;1|]
      [|2;2;2;1;2|] [|2;2;2|] SAME expected

  (* testInputGradientSamePaddingStrideThree *)
  let fun05 () =
    let expected = [|
      4.; 6.; 8.; 18.; 10.; 12.; 38.; 48.; 16.; 18.; 68.; 78.; 22.; 24.; 98.;
      108.; 28.; 30.; 128.; 138.; 34.; 36.; 158.; 168.; 40.; 42.; 188.; 198.;
      46.; 48.; 218.; 228.; 52.; 54.; 248.; 258.; 32.; 50.; 20.; 46.; 86.; 104.;
      98.; 124.; 140.; 158.; 176.; 202.; 194.; 212.; 254.; 280.; 248.; 266.;
      332.; 358.; 302.; 320.; 410.; 436.|] in
    verify_value test_conv3d_back_input [|1;5;3;4;1|]
      [|3;3;3;1;2|] [|3;3;3|] SAME expected

  (* testInputGradientSamePaddingDifferentStrides *)
  let fun06 () =
    let expected = [|
      12.; 38.; 80.; 96.; 48.; 128.; 242.; 228.; 0.; 0.; 0.; 0.; 92.; 206.;
      248.; 240.; 320.; 584.; 698.; 564.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.;
      0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 172.; 374.; 416.; 384.; 592.;
      1040.; 1154.; 900.; 0.; 0.; 0.; 0.; 252.; 542.; 584.; 528.; 864.; 1496.;
      1610.; 1236.|] in
    verify_value test_conv3d_back_input [|1;3;5;4;1|]
      [|1;2;3;1;2|] [|2;3;1|] SAME expected

  (* testInputGradientKernelSizeMatchesInputSize *)
  let fun07 () =
    let expected = [|
      2.; 4.; 6.; 8.; 10.; 12.; 14.; 16.; 18.; 20.; 22.; 24.; 26.; 28.; 30.;
      32.; 34.; 36.; 38.; 40.; 42.; 44.; 46.; 48.; 50.; 52.; 54.; 56.; 58.; 60.;
      62.; 64.; 66.; 68.; 70.; 72.; 74.; 76.; 78.; 80.; 82.; 84.; 86.; 88.; 90.;
      92.; 94.; 96.; 98.; 100.; 102.; 104.; 106.; 108.; 110.; 112.; 114.; 116.;
      118.; 120.|] in
    verify_value test_conv3d_back_input [|1;5;4;3;1|]
      [|5;4;3;1;2|] [|1;1;1|] VALID expected

end

(* Test Convolution3D kernel-backward operations *)

module To_test_conv3d_back_kernel = struct
  (* testKernelGradientValidPaddingStrideOne *)
  let fun00 () =
    let expected = [|
      513.; 561.; 609.; 558.; 612.; 666.; 603.; 663.; 723.; 648.; 714.; 780.;
      783.; 867.; 951.; 828.; 918.; 1008.; 873.; 969.; 1065.; 918.; 1020.;
      1122.; 1593.; 1785.; 1977.; 1638.; 1836.; 2034.; 1683.; 1887.; 2091.;
      1728.; 1938.; 2148.; 1863.; 2091.; 2319.; 1908.; 2142.; 2376.; 1953.;
      2193.; 2433.; 1998.; 2244.; 2490.|] in
    verify_value test_conv3d_back_kernel [|1;2;4;3;2|]
      [|2;2;2;2;3|] [|1;1;1|] VALID expected

  (* testKernelGradientValidPaddingStrideTwo *)
  let fun01 () =
    let expected = [|
      188.; 228.; 200.; 244.; 236.; 292.; 248.; 308.; 284.; 356.;
      296.; 372.; 332.; 420.; 344.; 436.|] in
    verify_value test_conv3d_back_kernel [|1;5;2;4;1|]
      [|2;2;2;1;2|] [|2;2;2|] VALID expected

  (* testKernelGradientValidPaddingStrideThree *)
  let fun02 () =
    let expected = [|
      32.; 49.; 34.; 53.; 36.; 57.; 42.; 69.; 44.; 73.; 46.; 77.; 52.; 89.; 54.;
      93.; 56.; 97.; 92.; 169.; 94.; 173.; 96.; 177.; 102.; 189.; 104.; 193.;
      106.; 197.; 112.; 209.; 114.; 213.; 116.; 217.; 152.; 289.; 154.; 293.;
      156.; 297.; 162.; 309.; 164.; 313.; 166.; 317.; 172.; 329.; 174.; 333.;
      176.; 337.|] in
    verify_value test_conv3d_back_kernel [|1;3;6;5;1|]
      [|3;3;3;1;2|] [|3;3;3|] VALID expected

  (* testKernelGradientSamePaddingStrideOne *)
  let fun03 () =
    let expected = [|
      564.; 624.; 294.; 320.; 1078.; 1144.;
      509.; 536.; 532.; 560.; 214.; 224.|] in
    verify_value test_conv3d_back_kernel [|1;3;2;2;2|]
      [|3;2;1;2;1|] [|1;1;1|] SAME expected

  (* testKernelGradientSamePaddingStrideTwo *)
  let fun04 () =
    let expected = [|
      148.; 180.; 56.; 72.; 184.; 228.; 68.; 90.; 220.; 276.; 80.; 108.; 256.;
      324.; 92.; 126.|] in
    verify_value test_conv3d_back_kernel [|1;4;2;3;1|]
      [|2;2;2;1;2|] [|2;2;2|] SAME expected

  (* testKernelGradientSamePaddingStrideThree *)
  let fun05 () =
    let expected = [|
      240.; 282.; 396.; 478.; 152.; 192.; 272.; 322.; 444.; 542.; 168.; 216.;
      304.; 362.; 492.; 606.; 184.; 240.; 336.; 402.; 540.; 670.; 200.; 264.;
      368.; 442.; 588.; 734.; 216.; 288.; 400.; 482.; 636.; 798.; 232.; 312.;
      54. ; 81.; 56.; 109.; 0.; 26.; 62.; 93.; 64.; 125.; 0.; 30.; 70.; 105.;
      72.; 141.; 0.; 34.|] in
    verify_value test_conv3d_back_kernel [|1;5;3;4;1|]
      [|3;3;3;1;2|] [|3;3;3|] SAME expected

  (* testKernelGradientSamePaddingDifferentStrides *)
  let fun06 () =
    let expected = [|
      7600.; 7936.; 9824.; 10280.; 7096.; 7444.; 8368.; 8752.; 10784.; 11304.;
      7768.; 8164.|] in
    verify_value test_conv3d_back_kernel [|1;3;5;4;1|]
      [|1;2;3;1;2|] [|2;3;1|] SAME expected

  (* testKernelGradientKernelSizeMatchesInputSize *)
  let fun07 () =
    let expected = [|
      0.; 1.; 0.; 2.; 0.; 3.; 0.; 4.; 0.; 5.; 0.; 6.; 0.; 7.; 0.; 8.; 0.; 9.;
      0.; 10.; 0.; 11.; 0.; 12.; 0.; 13.; 0.; 14.; 0.; 15.; 0.; 16.; 0.; 17.;
      0.; 18.; 0.; 19.; 0.; 20.; 0.; 21.; 0.; 22.; 0.; 23.; 0.; 24.; 0.; 25.;
      0.; 26.; 0.; 27.; 0.; 28.; 0.; 29.; 0.; 30.; 0.; 31.; 0.; 32.; 0.; 33.;
      0.; 34.; 0.; 35.; 0.; 36.; 0.; 37.; 0.; 38.; 0.; 39.; 0.; 40.; 0.; 41.;
      0.; 42.; 0.; 43.; 0.; 44.; 0.; 45.; 0.; 46.; 0.; 47.; 0.; 48.; 0.; 49.;
      0.; 50.; 0.; 51.; 0.; 52.; 0.; 53.; 0.; 54.; 0.; 55.; 0.; 56.; 0.; 57.;
      0.; 58.; 0.; 59.; 0.; 60.|] in
    verify_value test_conv3d_back_kernel [|1;5;4;3;1|]
      [|5;4;3;1;2|] [|1;1;1|] VALID expected
end

(* tests for conv3d forward operation *)

let fun_conv00 () =
  Alcotest.(check bool) "fun_conv00" true (To_test_conv3d.fun00 ())

let fun_conv01 () =
  Alcotest.(check bool) "fun_conv01" true (To_test_conv3d.fun01 ())

let fun_conv02 () =
  Alcotest.(check bool) "fun_conv02" true (To_test_conv3d.fun02 ())

let fun_conv03 () =
  Alcotest.(check bool) "fun_conv03" true (To_test_conv3d.fun03 ())

let fun_conv04 () =
  Alcotest.(check bool) "fun_conv04" true (To_test_conv3d.fun04 ())

let fun_conv05 () =
  Alcotest.(check bool) "fun_conv05" true (To_test_conv3d.fun05 ())

let fun_conv06 () =
  Alcotest.(check bool) "fun_conv06" true (To_test_conv3d.fun06 ())

let fun_conv07 () =
  Alcotest.(check bool) "fun_conv07" true (To_test_conv3d.fun07 ())

let fun_conv08 () =
  Alcotest.(check bool) "fun_conv08" true (To_test_conv3d.fun08 ())

let fun_conv09 () =
  Alcotest.(check bool) "fun_conv09" true (To_test_conv3d.fun09 ())

let fun_conv10 () =
  Alcotest.(check bool) "fun_conv10" true (To_test_conv3d.fun10 ())

let fun_conv11 () =
  Alcotest.(check bool) "fun_conv11" true (To_test_conv3d.fun11 ())

(* tests for conv3d input backward operation *)

let fun_cbi00 () =
  Alcotest.(check bool) "fun_cbi00" true (To_test_conv3d_back_input.fun00 ())

let fun_cbi01 () =
  Alcotest.(check bool) "fun_cbi01" true (To_test_conv3d_back_input.fun01 ())

let fun_cbi02 () =
  Alcotest.(check bool) "fun_cbi02" true (To_test_conv3d_back_input.fun02 ())

let fun_cbi03 () =
  Alcotest.(check bool) "fun_cbi03" true (To_test_conv3d_back_input.fun03 ())

let fun_cbi04 () =
  Alcotest.(check bool) "fun_cbi04" true (To_test_conv3d_back_input.fun04 ())

let fun_cbi05 () =
  Alcotest.(check bool) "fun_cbi05" true (To_test_conv3d_back_input.fun05 ())

let fun_cbi06 () =
  Alcotest.(check bool) "fun_cbi06" true (To_test_conv3d_back_input.fun06 ())

let fun_cbi07 () =
  Alcotest.(check bool) "fun_cbi07" true (To_test_conv3d_back_input.fun07 ())

(* tests for conv3d kernel backward operation *)

let fun_cbk00 () =
  Alcotest.(check bool) "fun_cbk00" true (To_test_conv3d_back_kernel.fun00 ())

let fun_cbk01 () =
  Alcotest.(check bool) "fun_cbk01" true (To_test_conv3d_back_kernel.fun01 ())

let fun_cbk02 () =
  Alcotest.(check bool) "fun_cbk02" true (To_test_conv3d_back_kernel.fun02 ())

let fun_cbk03 () =
  Alcotest.(check bool) "fun_cbk03" true (To_test_conv3d_back_kernel.fun03 ())

let fun_cbk04 () =
  Alcotest.(check bool) "fun_cbk04" true (To_test_conv3d_back_kernel.fun04 ())

let fun_cbk05 () =
  Alcotest.(check bool) "fun_cbk05" true (To_test_conv3d_back_kernel.fun05 ())

let fun_cbk06 () =
  Alcotest.(check bool) "fun_cbk06" true (To_test_conv3d_back_kernel.fun06 ())

let fun_cbk07 () =
  Alcotest.(check bool) "fun_cbk07" true (To_test_conv3d_back_kernel.fun07 ())


let test_set = [
  "fun_conv00", `Slow, fun_conv00;
  "fun_conv01", `Slow, fun_conv01;
  "fun_conv02", `Slow, fun_conv02;
  "fun_conv03", `Slow, fun_conv03;
  "fun_conv04", `Slow, fun_conv04;
  "fun_conv05", `Slow, fun_conv05;
  "fun_conv06", `Slow, fun_conv06;
  "fun_conv07", `Slow, fun_conv07;
  "fun_conv08", `Slow, fun_conv08;
  "fun_conv09", `Slow, fun_conv09;
  "fun_conv10", `Slow, fun_conv10;
  "fun_conv11", `Slow, fun_conv11;
  "fun_cbi00", `Slow, fun_cbi00;
  "fun_cbi01", `Slow, fun_cbi01;
  "fun_cbi02", `Slow, fun_cbi02;
  "fun_cbi03", `Slow, fun_cbi03;
  "fun_cbi04", `Slow, fun_cbi04;
  "fun_cbi05", `Slow, fun_cbi05;
  "fun_cbi06", `Slow, fun_cbi06;
  "fun_cbi07", `Slow, fun_cbi07;
  "fun_cbk00", `Slow, fun_cbk00;
  "fun_cbk01", `Slow, fun_cbk01;
  "fun_cbk02", `Slow, fun_cbk02;
  "fun_cbk03", `Slow, fun_cbk03;
  "fun_cbk04", `Slow, fun_cbk04;
  "fun_cbk05", `Slow, fun_cbk05;
  "fun_cbk06", `Slow, fun_cbk06;
  "fun_cbk07", `Slow, fun_cbk07;
]
