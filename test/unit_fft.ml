(** Unit test for functions in fft *)

open Owl_dense_ndarray_generic
open Owl_fft_generic

(* Helpers & error *)
let eps = 1e-6

let close a b = (sub a b |> abs |> sum') < eps

let close_complex a b =
  let d = (sub a b) in
  let d = (abs d) in
  let d = (sum' d) in
  Complex.(d.re) < eps && Complex.(d.im) < eps

(* Test functions *)
module To_test = struct
  let test_fft_8_backward () =
    let input =
      [| Complex.{re= 0.37454012; im= 0.60111499}
       ; Complex.{re= 0.95071429; im= 0.70807260}
       ; Complex.{re= 0.73199391; im= 0.02058449}
       ; Complex.{re= 0.59865850; im= 0.96990985}
       ; Complex.{re= 0.15601864; im= 0.83244264}
       ; Complex.{re= 0.15599452; im= 0.21233912}
       ; Complex.{re= 0.05808361; im= 0.18182497}
       ; Complex.{re= 0.86617613; im= 0.18340451} |]
    in
    let x = of_array Bigarray.Complex64 input [|8|] in
    let expected =
      [| Complex.{re= 3.89217973; im= 3.70969343}
       ; Complex.{re= 1.71507597; im= -1.48363292}
       ; Complex.{re= -0.49242139; im= 1.58927405}
       ; Complex.{re= 0.53532648; im= 0.27540120}
       ; Complex.{re= -1.25090718; im= -0.43775904}
       ; Complex.{re= -1.60051394; im= -0.32684302}
       ; Complex.{re= -0.02661610; im= 0.87302220}
       ; Complex.{re= 0.22419742; im= 0.60976410} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|8|] in
    let result = fft ~norm:Backward x in
    close_complex result expected

  let test_fft_8_ortho () =
    let input =
      [| Complex.{re= 0.30424225; im= 0.45606998}
       ; Complex.{re= 0.52475643; im= 0.78517598}
       ; Complex.{re= 0.43194503; im= 0.19967379}
       ; Complex.{re= 0.29122913; im= 0.51423442}
       ; Complex.{re= 0.61185288; im= 0.59241456}
       ; Complex.{re= 0.13949387; im= 0.04645041}
       ; Complex.{re= 0.29214466; im= 0.60754484}
       ; Complex.{re= 0.36636186; im= 0.17052412} |]
    in
    let x = of_array Bigarray.Complex64 input [|8|] in
    let expected =
      [| Complex.{re= 1.04723442; im= 1.19221306}
       ; Complex.{re= 0.13274679; im= -0.07641063}
       ; Complex.{re= 0.11980981; im= 0.08294597}
       ; Complex.{re= 0.19095755; im= -0.17506446}
       ; Complex.{re= 0.11255147; im= 0.11996708}
       ; Complex.{re= -0.63866872; im= -0.11885333}
       ; Complex.{re= 0.01595855; im= 0.08765482}
       ; Complex.{re= -0.12006272; im= 0.17750807} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|8|] in
    let result = fft ~norm:Ortho x in
    close_complex result expected

  let test_fft_8_forward () =
    let input =
      [| Complex.{re= 0.06505159; im= 0.12203824}
       ; Complex.{re= 0.94888556; im= 0.49517691}
       ; Complex.{re= 0.96563202; im= 0.03438852}
       ; Complex.{re= 0.80839735; im= 0.90932041}
       ; Complex.{re= 0.30461377; im= 0.25877997}
       ; Complex.{re= 0.09767211; im= 0.66252226}
       ; Complex.{re= 0.68423301; im= 0.31171107}
       ; Complex.{re= 0.44015250; im= 0.52006805} |]
    in
    let x = of_array Bigarray.Complex64 input [|8|] in
    let expected =
      [| Complex.{re= 0.53932971; im= 0.41425067}
       ; Complex.{re= -0.00230779; im= -0.20925026}
       ; Complex.{re= -0.19398613; im= 0.02958885}
       ; Complex.{re= -0.01835475; im= -0.04050700}
       ; Complex.{re= -0.03444713; im= -0.23252124}
       ; Complex.{re= -0.12691340; im= 0.10471506}
       ; Complex.{re= -0.12606378; im= -0.02090919}
       ; Complex.{re= 0.02779485; im= 0.07667132} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|8|] in
    let result = fft ~norm:Forward x in
    close_complex result expected

  let test_fft_4x4_backward () =
    let input =
      [| Complex.{re= 0.54671025; im= 0.28093451}
       ; Complex.{re= 0.18485446; im= 0.54269606}
       ; Complex.{re= 0.96958464; im= 0.14092423}
       ; Complex.{re= 0.77513283; im= 0.80219698}
       ; Complex.{re= 0.93949896; im= 0.07455064}
       ; Complex.{re= 0.89482737; im= 0.98688692}
       ; Complex.{re= 0.59789997; im= 0.77224475}
       ; Complex.{re= 0.92187423; im= 0.19871569}
       ; Complex.{re= 0.08849251; im= 0.00552212}
       ; Complex.{re= 0.19598286; im= 0.81546146}
       ; Complex.{re= 0.04522729; im= 0.70685732}
       ; Complex.{re= 0.32533032; im= 0.72900718}
       ; Complex.{re= 0.38867730; im= 0.77127033}
       ; Complex.{re= 0.27134904; im= 0.07404465}
       ; Complex.{re= 0.82873750; im= 0.35846573}
       ; Complex.{re= 0.35675332; im= 0.11586906} |]
    in
    let x = of_array Bigarray.Complex64 input [|4; 4|] in
    let expected =
      [| Complex.{re= 2.47628212; im= 1.76675177}
       ; Complex.{re= -0.68237531; im= 0.73028868}
       ; Complex.{re= 0.55630767; im= -0.92303425}
       ; Complex.{re= -0.16337347; im= -0.45026809}
       ; Complex.{re= 3.35410070; im= 2.03239799}
       ; Complex.{re= 1.12977028; im= -0.67064726}
       ; Complex.{re= -0.27930272; im= -0.33880728}
       ; Complex.{re= -0.44657224; im= -0.72474098}
       ; Complex.{re= 0.65503299; im= 2.25684810}
       ; Complex.{re= 0.12971950; im= -0.57198775}
       ; Complex.{re= -0.38759339; im= -0.83208919}
       ; Complex.{re= -0.04318906; im= -0.83068264}
       ; Complex.{re= 1.84551716; im= 1.31964982}
       ; Complex.{re= -0.48188460; im= 0.49820888}
       ; Complex.{re= 0.58931249; im= 0.93982232}
       ; Complex.{re= -0.39823580; im= 0.32740033} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|4; 4|] in
    let result = fft ~norm:Backward x in
    close_complex result expected

  let test_fft_4x4_ortho () =
    let input =
      [| Complex.{re= 0.86310345; im= 0.52273285}
       ; Complex.{re= 0.62329811; im= 0.42754102}
       ; Complex.{re= 0.33089802; im= 0.02541913}
       ; Complex.{re= 0.06355835; im= 0.10789143}
       ; Complex.{re= 0.31098232; im= 0.03142919}
       ; Complex.{re= 0.32518333; im= 0.63641042}
       ; Complex.{re= 0.72960615; im= 0.31435597}
       ; Complex.{re= 0.63755745; im= 0.50857067}
       ; Complex.{re= 0.88721275; im= 0.90756649}
       ; Complex.{re= 0.47221494; im= 0.24929222}
       ; Complex.{re= 0.11959425; im= 0.41038293}
       ; Complex.{re= 0.71324480; im= 0.75555116}
       ; Complex.{re= 0.76078504; im= 0.22879817}
       ; Complex.{re= 0.56127721; im= 0.07697991}
       ; Complex.{re= 0.77096719; im= 0.28975144}
       ; Complex.{re= 0.49379560; im= 0.16122128} |]
    in
    let x = of_array Bigarray.Complex64 input [|4; 4|] in
    let expected =
      [| Complex.{re= 0.94042897; im= 0.54179221}
       ; Complex.{re= 0.42592752; im= -0.03121302}
       ; Complex.{re= 0.25357249; im= 0.00635976}
       ; Complex.{re= 0.10627794; im= 0.52852678}
       ; Complex.{re= 1.00166464; im= 0.74538314}
       ; Complex.{re= -0.14539205; im= 0.01472366}
       ; Complex.{re= 0.03892386; im= -0.39959800}
       ; Complex.{re= -0.27323180; im= -0.29765046}
       ; Complex.{re= 1.09613335; im= 1.16139638}
       ; Complex.{re= 0.13067979; im= 0.36910671}
       ; Complex.{re= -0.08932638; im= 0.15655303}
       ; Complex.{re= 0.63693875; im= 0.12807685}
       ; Complex.{re= 1.29341245; im= 0.37837541}
       ; Complex.{re= -0.04721176; im= -0.06421744}
       ; Complex.{re= 0.23833972; im= 0.14017421}
       ; Complex.{re= 0.03702961; im= 0.00326417} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|4; 4|] in
    let result = fft ~norm:Ortho x in
    close_complex result expected

  let test_fft_4x4_forward () =
    let input =
      [| Complex.{re= 0.92969763; im= 0.00695213}
       ; Complex.{re= 0.80812037; im= 0.51074731}
       ; Complex.{re= 0.63340378; im= 0.41741100}
       ; Complex.{re= 0.87146062; im= 0.22210781}
       ; Complex.{re= 0.80367208; im= 0.11986537}
       ; Complex.{re= 0.18657006; im= 0.33761516}
       ; Complex.{re= 0.89255899; im= 0.94290972}
       ; Complex.{re= 0.53934222; im= 0.32320294}
       ; Complex.{re= 0.80744016; im= 0.51879060}
       ; Complex.{re= 0.89609128; im= 0.70301896}
       ; Complex.{re= 0.31800348; im= 0.36362961}
       ; Complex.{re= 0.11005192; im= 0.97178209}
       ; Complex.{re= 0.22793517; im= 0.96244729}
       ; Complex.{re= 0.42710778; im= 0.25178230}
       ; Complex.{re= 0.81801474; im= 0.49724850}
       ; Complex.{re= 0.86073059; im= 0.30087832} |]
    in
    let x = of_array Bigarray.Complex64 input [|4; 4|] in
    let expected =
      [| Complex.{re= 0.81067061; im= 0.28930455}
       ; Complex.{re= 0.14623334; im= -0.08677965}
       ; Complex.{re= -0.02911988; im= -0.07712300}
       ; Complex.{re= 0.00191359; im= -0.11844978}
       ; Complex.{re= 0.60553586; im= 0.43089831}
       ; Complex.{re= -0.01861867; im= -0.11756805}
       ; Complex.{re= 0.24257971; im= 0.10048926}
       ; Complex.{re= -0.02582479; im= -0.29395413}
       ; Complex.{re= 0.53289676; im= 0.63930535}
       ; Complex.{re= 0.05516839; im= -0.15771958}
       ; Complex.{re= 0.02982512; im= -0.19809523}
       ; Complex.{re= 0.18954995; im= 0.23530009}
       ; Complex.{re= 0.58344710; im= 0.50308907}
       ; Complex.{re= -0.15979388; im= 0.22470540}
       ; Complex.{re= -0.06047210; im= 0.22675881}
       ; Complex.{re= -0.13524589; im= 0.00789399} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|4; 4|] in
    let result = fft ~norm:Forward x in
    close_complex result expected

  let test_fft_3x4_backward () =
    let input =
      [| Complex.{re= 0.28484049; im= 0.67213553}
       ; Complex.{re= 0.03688695; im= 0.76161963}
       ; Complex.{re= 0.60956430; im= 0.23763755}
       ; Complex.{re= 0.50267905; im= 0.72821635}
       ; Complex.{re= 0.05147875; im= 0.36778313}
       ; Complex.{re= 0.27864647; im= 0.63230580}
       ; Complex.{re= 0.90826589; im= 0.63352972}
       ; Complex.{re= 0.23956189; im= 0.53577471}
       ; Complex.{re= 0.14489487; im= 0.09028977}
       ; Complex.{re= 0.48945275; im= 0.83530247}
       ; Complex.{re= 0.98565048; im= 0.32078007}
       ; Complex.{re= 0.24205527; im= 0.18651851} |]
    in
    let x = of_array Bigarray.Complex64 input [|3; 4|] in
    let expected =
      [| Complex.{re= 1.43397069; im= 2.39960909}
       ; Complex.{re= -0.29132053; im= 0.90029007}
       ; Complex.{re= 0.35483879; im= -0.58006287}
       ; Complex.{re= -0.35812709; im= -0.03129411}
       ; Complex.{re= 1.47795296; im= 2.16939354}
       ; Complex.{re= -0.76025605; im= -0.30483118}
       ; Complex.{re= 0.44153625; im= -0.16676772}
       ; Complex.{re= -0.95331824; im= -0.22666201}
       ; Complex.{re= 1.86205339; im= 1.43289089}
       ; Complex.{re= -0.19197160; im= -0.47788778}
       ; Complex.{re= 0.39903736; im= -0.61075115}
       ; Complex.{re= -1.48953962; im= 0.01690719} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|3; 4|] in
    let result = fft ~norm:Backward x in
    close_complex result expected

  let test_fft_3x4_ortho () =
    let input =
      [| Complex.{re= 0.04077514; im= 0.34106636}
       ; Complex.{re= 0.59089297; im= 0.11347352}
       ; Complex.{re= 0.67756438; im= 0.92469364}
       ; Complex.{re= 0.01658783; im= 0.87733936}
       ; Complex.{re= 0.51209307; im= 0.25794163}
       ; Complex.{re= 0.22649577; im= 0.65998405}
       ; Complex.{re= 0.64517277; im= 0.81722218}
       ; Complex.{re= 0.17436643; im= 0.55520082}
       ; Complex.{re= 0.69093776; im= 0.52965057}
       ; Complex.{re= 0.38673535; im= 0.24185228}
       ; Complex.{re= 0.93672997; im= 0.09310277}
       ; Complex.{re= 0.13752094; im= 0.89721578} |]
    in
    let x = of_array Bigarray.Complex64 input [|3; 4|] in
    let expected =
      [| Complex.{re= 0.66291016; im= 1.12828636}
       ; Complex.{re= -0.70032752; im= -0.57896620}
       ; Complex.{re= 0.05542934; im= 0.13747352}
       ; Complex.{re= 0.06353828; im= -0.00466108}
       ; Complex.{re= 0.77906406; im= 1.14517438}
       ; Complex.{re= -0.01414824; im= -0.30570492}
       ; Complex.{re= 0.37820184; im= -0.07001054}
       ; Complex.{re= -0.11893147; im= -0.25357559}
       ; Complex.{re= 1.07596195; im= 0.88091075}
       ; Complex.{re= -0.45057786; im= 0.09366670}
       ; Complex.{re= 0.55170572; im= -0.25815740}
       ; Complex.{re= 0.20478565; im= 0.34288111} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|3; 4|] in
    let result = fft ~norm:Ortho x in
    close_complex result expected

  let test_fft_3x4_forward () =
    let input =
      [| Complex.{re= 0.90041804; im= 0.60642904}
       ; Complex.{re= 0.63310146; im= 0.00919705}
       ; Complex.{re= 0.33902979; im= 0.10147154}
       ; Complex.{re= 0.34920958; im= 0.66350174}
       ; Complex.{re= 0.72595567; im= 0.00506158}
       ; Complex.{re= 0.89711028; im= 0.16080806}
       ; Complex.{re= 0.88708645; im= 0.54873377}
       ; Complex.{re= 0.77987552; im= 0.69189519}
       ; Complex.{re= 0.64203167; im= 0.65196127}
       ; Complex.{re= 0.08413997; im= 0.22426932}
       ; Complex.{re= 0.16162871; im= 0.71217924}
       ; Complex.{re= 0.89855421; im= 0.23724909} |]
    in
    let x = of_array Bigarray.Complex64 input [|3; 4|] in
    let expected =
      [| Complex.{re= 0.55543971; im= 0.34514984}
       ; Complex.{re= -0.02322911; im= 0.05526640}
       ; Complex.{re= 0.06428421; im= 0.00880045}
       ; Complex.{re= 0.30392325; im= 0.19721234}
       ; Complex.{re= 0.82250696; im= 0.35162464}
       ; Complex.{re= -0.17305449; im= -0.16522674}
       ; Complex.{re= -0.01598591; im= -0.07472697}
       ; Complex.{re= 0.09248909; im= -0.10660936}
       ; Complex.{re= 0.44658864; im= 0.45641473}
       ; Complex.{re= 0.11685579; im= 0.18854907}
       ; Complex.{re= -0.04475844; im= 0.22565553}
       ; Complex.{re= 0.12334568; im= -0.21865806} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|3; 4|] in
    let result = fft ~norm:Forward x in
    close_complex result expected

  let test_fft_inverse () =
    let input =
      [| 0.32539970
       ; 0.74649143
       ; 0.64963287
       ; 0.84922343
       ; 0.65761292
       ; 0.56830859
       ; 0.09367477
       ; 0.36771581 |]
    in
    let x = cast_d2z (of_array Bigarray.Float64 input [|8|]) in
    let forward = fft x in
    let result = ifft forward in
    let expected =
      [| Complex.{re= 0.32539970; im= 0.}
       ; Complex.{re= 0.74649143; im= 0.}
       ; Complex.{re= 0.64963281; im= 0.}
       ; Complex.{re= 0.84922343; im= 0.}
       ; Complex.{re= 0.65761292; im= 0.}
       ; Complex.{re= 0.56830859; im= 0.}
       ; Complex.{re= 0.09367481; im= 0.}
       ; Complex.{re= 0.36771578; im= 0.} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|8|] in
    close_complex result expected

  let test_rfft_8_backward () =
    let input =
      [| 0.57690388
       ; 0.49251768
       ; 0.19524299
       ; 0.72245210
       ; 0.28077236
       ; 0.02431597
       ; 0.64547229
       ; 0.17711067 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| Complex.{re= 3.11478806; im= 0.00000000}
       ; Complex.{re= 0.24158551; im= -0.26645392}
       ; Complex.{re= 0.01696096; im= 0.38272914}
       ; Complex.{re= 0.35067752; im= -1.16691256}
       ; Complex.{re= 0.28199509; im= 0.00000000} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|5|] in
    let result = rfft ~otyp:Bigarray.Complex64 ~norm:Backward x in
    close_complex result expected

  let test_rfft_8_ortho () =
    let input =
      [| 0.94045860
       ; 0.95392859
       ; 0.91486436
       ; 0.37015870
       ; 0.01545662
       ; 0.92831856
       ; 0.42818415
       ; 0.96665484 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| Complex.{re= 1.95091629; im= 0.00000000}
       ; Complex.{re= 0.48256412; im= -0.02934592}
       ; Complex.{re= -0.13687231; im= -0.19283991}
       ; Complex.{re= 0.17151105; im= 0.31478897}
       ; Complex.{re= -0.32530338; im= 0.00000000} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|5|] in
    let result = rfft ~otyp:Bigarray.Complex64 ~norm:Ortho x in
    close_complex result expected

  let test_rfft_8_forward () =
    let input =
      [| 0.96361995
       ; 0.85300946
       ; 0.29444888
       ; 0.38509774
       ; 0.85113668
       ; 0.31692201
       ; 0.16949275
       ; 0.55680126 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| Complex.{re= 0.54881608; im= 0.00000000}
       ; Complex.{re= 0.07662089; im= -0.04782681}
       ; Complex.{re= 0.16885188; im= -0.02850406}
       ; Complex.{re= -0.04850006; im= -0.01658777}
       ; Complex.{re= 0.02085848; im= 0.00000000} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|5|] in
    let result = rfft ~otyp:Bigarray.Complex64 ~norm:Forward x in
    close_complex result expected

  let test_rfft_4x4_backward () =
    let input =
      [| 0.93615478
       ; 0.69602978
       ; 0.57006115
       ; 0.09717649
       ; 0.61500722
       ; 0.99005383
       ; 0.14008401
       ; 0.51832968
       ; 0.87737310
       ; 0.74076861
       ; 0.69701576
       ; 0.70248407
       ; 0.35949114
       ; 0.29359186
       ; 0.80936116
       ; 0.81011337 |]
    in
    let x = of_array Bigarray.Float64 input [|4; 4|] in
    let expected =
      [| Complex.{re= 2.29942226; im= 0.00000000}
       ; Complex.{re= 0.36609361; im= -0.59885329}
       ; Complex.{re= 0.71300966; im= 0.00000000}
       ; Complex.{re= 2.26347470; im= 0.00000000}
       ; Complex.{re= 0.47492322; im= -0.47172421}
       ; Complex.{re= -0.75329226; im= 0.00000000}
       ; Complex.{re= 3.01764154; im= 0.00000000}
       ; Complex.{re= 0.18035734; im= -0.03828453}
       ; Complex.{re= 0.13113610; im= 0.00000000}
       ; Complex.{re= 2.27255750; im= 0.00000000}
       ; Complex.{re= -0.44986999; im= 0.51652157}
       ; Complex.{re= 0.06514706; im= 0.00000000} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|4; 3|] in
    let result = rfft ~otyp:Bigarray.Complex64 ~norm:Backward x in
    close_complex result expected

  let test_rfft_4x4_ortho () =
    let input =
      [| 0.86707234
       ; 0.91324055
       ; 0.51134241
       ; 0.50151628
       ; 0.79829520
       ; 0.64996392
       ; 0.70196688
       ; 0.79579270
       ; 0.89000535
       ; 0.33799517
       ; 0.37558296
       ; 0.09398194
       ; 0.57828015
       ; 0.03594228
       ; 0.46559802
       ; 0.54264462 |]
    in
    let x = of_array Bigarray.Float64 input [|4; 4|] in
    let expected =
      [| Complex.{re= 1.39658582; im= 0.00000000}
       ; Complex.{re= 0.17786495; im= -0.20586213}
       ; Complex.{re= -0.01817106; im= 0.00000000}
       ; Complex.{re= 1.47300935; im= 0.00000000}
       ; Complex.{re= 0.04816415; im= 0.07291437}
       ; Complex.{re= 0.02725273; im= 0.00000000}
       ; Complex.{re= 0.84878272; im= 0.00000000}
       ; Complex.{re= 0.25721121; im= -0.12200661}
       ; Complex.{re= 0.41680560; im= 0.00000000}
       ; Complex.{re= 0.81123251; im= 0.00000000}
       ; Complex.{re= 0.05634106; im= 0.25335118}
       ; Complex.{re= 0.23264563; im= 0.00000000} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|4; 3|] in
    let result = rfft ~otyp:Bigarray.Complex64 ~norm:Ortho x in
    close_complex result expected

  let test_rfft_4x4_forward () =
    let input =
      [| 0.28654125
       ; 0.59083325
       ; 0.03050025
       ; 0.03734819
       ; 0.82260054
       ; 0.36019063
       ; 0.12706052
       ; 0.52224326
       ; 0.76999354
       ; 0.21582103
       ; 0.62289047
       ; 0.08534747
       ; 0.05168172
       ; 0.53135461
       ; 0.54063511
       ; 0.63742989 |]
    in
    let x = of_array Bigarray.Float64 input [|4; 4|] in
    let expected =
      [| Complex.{re= 0.23630574; im= 0.00000000}
       ; Complex.{re= 0.06401025; im= -0.13837127}
       ; Complex.{re= -0.07778499; im= 0.00000000}
       ; Complex.{re= 0.45802376; im= 0.00000000}
       ; Complex.{re= 0.17388502; im= 0.04051315}
       ; Complex.{re= 0.01680679; im= 0.00000000}
       ; Complex.{re= 0.42351314; im= 0.00000000}
       ; Complex.{re= 0.03677577; im= -0.03261839}
       ; Complex.{re= 0.27292889; im= 0.00000000}
       ; Complex.{re= 0.44027534; im= 0.00000000}
       ; Complex.{re= -0.12223835; im= 0.02651882}
       ; Complex.{re= -0.14411692; im= 0.00000000} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|4; 3|] in
    let result = rfft ~otyp:Bigarray.Complex64 ~norm:Forward x in
    close_complex result expected

  let test_rfft_3x4_backward () =
    let input =
      [| 0.72609133
       ; 0.97585207
       ; 0.51630032
       ; 0.32295647
       ; 0.79518622
       ; 0.27083224
       ; 0.43897143
       ; 0.07845638
       ; 0.02535074
       ; 0.96264839
       ; 0.83598012
       ; 0.69597423 |]
    in
    let x = of_array Bigarray.Float64 input [|3; 4|] in
    let expected =
      [| Complex.{re= 2.54120016; im= 0.00000000}
       ; Complex.{re= 0.20979099; im= -0.65289563}
       ; Complex.{re= -0.05641687; im= 0.00000000}
       ; Complex.{re= 1.58344626; im= 0.00000000}
       ; Complex.{re= 0.35621476; im= -0.19237587}
       ; Complex.{re= 0.88486898; im= 0.00000000}
       ; Complex.{re= 2.51995349; im= 0.00000000}
       ; Complex.{re= -0.81062937; im= -0.26667422}
       ; Complex.{re= -0.79729176; im= 0.00000000} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|3; 3|] in
    let result = rfft ~otyp:Bigarray.Complex64 ~norm:Backward x in
    close_complex result expected

  let test_rfft_3x4_ortho () =
    let input =
      [| 0.40895295
       ; 0.17329432
       ; 0.15643704
       ; 0.25024289
       ; 0.54922664
       ; 0.71459591
       ; 0.66019738
       ; 0.27993390
       ; 0.95486528
       ; 0.73789692
       ; 0.55435407
       ; 0.61172074 |]
    in
    let x = of_array Bigarray.Float64 input [|3; 4|] in
    let expected =
      [| Complex.{re= 0.49446359; im= 0.00000000}
       ; Complex.{re= 0.12625796; im= 0.03847429}
       ; Complex.{re= 0.07092638; im= 0.00000000}
       ; Complex.{re= 1.10197687; im= 0.00000000}
       ; Complex.{re= -0.05548536; im= -0.21733101}
       ; Complex.{re= 0.10744711; im= 0.00000000}
       ; Complex.{re= 1.42941844; im= 0.00000000}
       ; Complex.{re= 0.20025562; im= -0.06308808}
       ; Complex.{re= 0.07980084; im= 0.00000000} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|3; 3|] in
    let result = rfft ~otyp:Bigarray.Complex64 ~norm:Ortho x in
    close_complex result expected

  let test_rfft_3x4_forward () =
    let input =
      [| 0.41960007
       ; 0.24773099
       ; 0.35597268
       ; 0.75784612
       ; 0.01439349
       ; 0.11607264
       ; 0.04600264
       ; 0.04072880
       ; 0.85546058
       ; 0.70365787
       ; 0.47417384
       ; 0.09783416 |]
    in
    let x = of_array Bigarray.Float64 input [|3; 4|] in
    let expected =
      [| Complex.{re= 0.44528747; im= 0.00000000}
       ; Complex.{re= 0.01590685; im= 0.12752879}
       ; Complex.{re= -0.05750109; im= 0.00000000}
       ; Complex.{re= 0.05429939; im= 0.00000000}
       ; Complex.{re= -0.00790229; im= -0.01883596}
       ; Complex.{re= -0.02410133; im= 0.00000000}
       ; Complex.{re= 0.53278160; im= 0.00000000}
       ; Complex.{re= 0.09532169; im= -0.15145592}
       ; Complex.{re= 0.13203560; im= 0.00000000} |]
    in
    let expected = of_array Bigarray.Complex64 expected [|3; 3|] in
    let result = rfft ~otyp:Bigarray.Complex64 ~norm:Forward x in
    close_complex result expected

  let test_rfft_inverse () =
    let input =
      [| 0.49161586
       ; 0.47347176
       ; 0.17320187
       ; 0.43385166
       ; 0.39850473
       ; 0.61585009
       ; 0.63509363
       ; 0.04530401 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let forward = rfft ~otyp:Bigarray.Complex64 x in
    let result = irfft ~otyp:Bigarray.Float64 forward in
    let expected =
      [| 0.49161588
       ; 0.47347177
       ; 0.17320187
       ; 0.43385165
       ; 0.39850473
       ; 0.61585010
       ; 0.63509365
       ; 0.04530401 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    close result expected

  let test_dct_1_backward () =
    let input =
      [| 0.37461263
       ; 0.62585992
       ; 0.50313628
       ; 0.85648984
       ; 0.65869361
       ; 0.16293442
       ; 0.07056875
       ; 0.64241928 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 6.77239752
       ; 1.24504578
       ; -1.14123142
       ; -0.88034922
       ; 1.39627695
       ; -0.75523102
       ; -0.08163272
       ; -1.09357774 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Backward ~ttype:I x in
    close result expected

  let test_dct_1_ortho () =
    let input =
      [| 0.02651131
       ; 0.58577555
       ; 0.94023025
       ; 0.57547420
       ; 0.38816991
       ; 0.64328820
       ; 0.45825288
       ; 0.54561681 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 1.51025033
       ; -0.01354993
       ; -0.08824035
       ; -0.38646209
       ; -0.34938586
       ; -0.18381834
       ; 0.12657233
       ; -0.14549664 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Ortho ~ttype:I x in
    close result expected

  let test_dct_1_forward () =
    let input =
      [| 0.94146478
       ; 0.38610265
       ; 0.96119058
       ; 0.90535063
       ; 0.19579114
       ; 0.06936130
       ; 0.10077800
       ; 0.01822183 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 0.44263110
       ; 0.20466121
       ; -0.06257220
       ; -0.10297162
       ; 0.01850824
       ; 0.10350926
       ; 0.06267007
       ; 0.05122380 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Forward ~ttype:I x in
    close result expected

  let test_dct_2_backward () =
    let input =
      [| 0.09444296
       ; 0.68300676
       ; 0.07118865
       ; 0.31897563
       ; 0.84487534
       ; 0.02327194
       ; 0.81446850
       ; 0.28185478 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 6.26416922
       ; -0.73818803
       ; -0.38138762
       ; 0.22999576
       ; -0.07323811
       ; -0.80621248
       ; -3.19520020
       ; 1.18421984 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Backward ~ttype:II x in
    close result expected

  let test_dct_2_ortho () =
    let input =
      [| 0.11816483
       ; 0.69673717
       ; 0.62894285
       ; 0.87747204
       ; 0.73507106
       ; 0.80348092
       ; 0.28203458
       ; 0.17743954 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 1.52711833
       ; 0.10874486
       ; -0.69514889
       ; -0.01905947
       ; -0.17785436
       ; -0.17765704
       ; -0.04242539
       ; -0.26337412 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Ortho ~ttype:II x in
    close result expected

  let test_dct_2_forward () =
    let input =
      [| 0.75061476
       ; 0.80683476
       ; 0.99050516
       ; 0.41261768
       ; 0.37201810
       ; 0.77641296
       ; 0.34080353
       ; 0.93075734 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 0.67257053
       ; 0.04220918
       ; 0.07393602
       ; -0.05915445
       ; -0.03964647
       ; -0.06020422
       ; 0.11441326
       ; -0.01948318 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Forward ~ttype:II x in
    close result expected

  let test_dct_3_backward () =
    let input =
      [| 0.85841274
       ; 0.42899403
       ; 0.75087106
       ; 0.75454289
       ; 0.10312387
       ; 0.90255290
       ; 0.50525236
       ; 0.82645744 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 6.19997597
       ; -1.91606784
       ; 1.79455709
       ; -1.56116223
       ; 0.02140164
       ; 0.34837565
       ; 2.62342930
       ; -0.64320761 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Backward ~ttype:III x in
    close result expected

  let test_dct_3_ortho () =
    let input =
      [| 0.32004961
       ; 0.89552325
       ; 0.38920167
       ; 0.01083765
       ; 0.90538198
       ; 0.09128667
       ; 0.31931365
       ; 0.95006198 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 1.23583686
       ; -0.21741576
       ; 0.51341361
       ; -0.15123919
       ; 0.53597867
       ; -0.78123981
       ; -0.34254304
       ; 0.11244562 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Ortho ~ttype:III x in
    close result expected

  let test_dct_3_forward () =
    let input =
      [| 0.95060712
       ; 0.57343787
       ; 0.63183719
       ; 0.44844553
       ; 0.29321077
       ; 0.32866454
       ; 0.67251843
       ; 0.75237453 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 0.34855044
       ; -0.05782470
       ; 0.15199459
       ; -0.09504779
       ; 0.05543073
       ; 0.00988157
       ; 0.02993466
       ; 0.03238407 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Forward ~ttype:III x in
    close result expected

  let test_dct_4_backward () =
    let input =
      [| 0.79157907
       ; 0.78961813
       ; 0.09120610
       ; 0.49442029
       ; 0.05755876
       ; 0.54952890
       ; 0.44153050
       ; 0.88770419 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 5.03350830
       ; -0.32469130
       ; 2.84329343
       ; -1.06977797
       ; 1.26837552
       ; -1.16236269
       ; -0.15100092
       ; -2.64669466 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Backward ~ttype:IV x in
    close result expected

  let test_dct_4_ortho () =
    let input =
      [| 0.35091501
       ; 0.11706702
       ; 0.14299168
       ; 0.76151061
       ; 0.61821806
       ; 0.10112268
       ; 0.08410680
       ; 0.70096916 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 0.85449934
       ; -0.42461908
       ; -0.10973582
       ; 0.13980620
       ; 0.62992477
       ; -0.38134995
       ; 0.20042425
       ; -0.32184014 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Ortho ~ttype:IV x in
    close result expected

  let test_dct_4_forward () =
    let input =
      [| 0.07276300
       ; 0.82186007
       ; 0.70624220
       ; 0.08134878
       ; 0.08483771
       ; 0.98663956
       ; 0.37427080
       ; 0.37064216 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 0.27606383
       ; -0.10396589
       ; 0.08367845
       ; -0.14917605
       ; -0.16153003
       ; 0.00991914
       ; 0.03385765
       ; -0.09567360 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dct ~norm:Forward ~ttype:IV x in
    close result expected

  let test_dct_inverse_1 () =
    let input =
      [| 0.81279957
       ; 0.94724858
       ; 0.98600107
       ; 0.75337821
       ; 0.37625960
       ; 0.08350071
       ; 0.77714694
       ; 0.55840427 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let forward = dct ~ttype:I x in
    let result = idct ~ttype:I forward in
    let expected =
      [| 0.81279957
       ; 0.94724858
       ; 0.98600106
       ; 0.75337819
       ; 0.37625959
       ; 0.08350072
       ; 0.77714692
       ; 0.55840425 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    close result expected

  let test_dct_inverse_2 () =
    let input =
      [| 0.42422202
       ; 0.90635437
       ; 0.11119748
       ; 0.49262512
       ; 0.01135364
       ; 0.46866065
       ; 0.05630327
       ; 0.11881792 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let forward = dct ~ttype:II x in
    let result = idct ~ttype:II forward in
    let expected =
      [| 0.42422201
       ; 0.90635439
       ; 0.11119748
       ; 0.49262510
       ; 0.01135364
       ; 0.46866064
       ; 0.05630328
       ; 0.11881792 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    close result expected

  let test_dct_inverse_3 () =
    let input =
      [| 0.11752625
       ; 0.64921027
       ; 0.74604487
       ; 0.58336878
       ; 0.96217257
       ; 0.37487057
       ; 0.28571209
       ; 0.86859912 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let forward = dct ~ttype:III x in
    let result = idct ~ttype:III forward in
    let expected =
      [| 0.11752625
       ; 0.64921030
       ; 0.74604488
       ; 0.58336877
       ; 0.96217255
       ; 0.37487058
       ; 0.28571209
       ; 0.86859913 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    close result expected

  let test_dct_inverse_4 () =
    let input =
      [| 0.22359584
       ; 0.96322256
       ; 0.01215447
       ; 0.96987885
       ; 0.04315991
       ; 0.89114314
       ; 0.52770108
       ; 0.99296480 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let forward = dct ~ttype:IV x in
    let result = idct ~ttype:IV forward in
    let expected =
      [| 0.22359584
       ; 0.96322254
       ; 0.01215447
       ; 0.96987883
       ; 0.04315991
       ; 0.89114311
       ; 0.52770111
       ; 0.99296480 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    close result expected

  let test_dst_1_backward () =
    let input =
      [| 0.07379656
       ; 0.55385429
       ; 0.96930254
       ; 0.52309787
       ; 0.62939864
       ; 0.69574869
       ; 0.45454106
       ; 0.62755805 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 6.93005133
       ; -0.11519809
       ; 0.96519142
       ; -1.35991454
       ; -0.71071649
       ; -1.31527698
       ; 1.01109231
       ; 0.17671105 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Backward ~ttype:I x in
    close result expected

  let test_dst_1_ortho () =
    let input =
      [| 0.58431429
       ; 0.90115803
       ; 0.04544638
       ; 0.28096318
       ; 0.95041150
       ; 0.89026380
       ; 0.45565677
       ; 0.62013263 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 1.55898416
       ; -0.25686294
       ; 0.54292411
       ; 0.60294652
       ; 0.33151725
       ; -0.46979901
       ; -0.08146074
       ; -0.17487633 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Ortho ~ttype:I x in
    close result expected

  let test_dst_1_forward () =
    let input =
      [| 0.27738118
       ; 0.18812115
       ; 0.46369842
       ; 0.35335222
       ; 0.58365613
       ; 0.07773463
       ; 0.97439480
       ; 0.98621076 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 0.28567696
       ; -0.10827438
       ; 0.14328867
       ; -0.12813336
       ; 0.10891043
       ; -0.01470894
       ; -0.02046827
       ; 0.09155916 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Forward ~ttype:I x in
    close result expected

  let test_dst_2_backward () =
    let input =
      [| 0.69816172
       ; 0.53609639
       ; 0.30952761
       ; 0.81379503
       ; 0.68473119
       ; 0.16261694
       ; 0.91092718
       ; 0.82253724 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 5.92580652
       ; -0.41755322
       ; 2.22041273
       ; -1.09627128
       ; 3.83235884
       ; 0.18310541
       ; 0.51656908
       ; 0.53660423 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Backward ~ttype:II x in
    close result expected

  let test_dst_2_ortho () =
    let input =
      [| 0.94979990
       ; 0.72571951
       ; 0.61341518
       ; 0.41824305
       ; 0.93272847
       ; 0.86606389
       ; 0.04521867
       ; 0.02636698 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 1.58695292
       ; 0.27589065
       ; 0.23189719
       ; 0.83829910
       ; 0.13078196
       ; 0.10704315
       ; 0.43739575
       ; 0.17846274 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Ortho ~ttype:II x in
    close result expected

  let test_dst_2_forward () =
    let input =
      [| 0.37646335
       ; 0.81055331
       ; 0.98727614
       ; 0.15041690
       ; 0.59413069
       ; 0.38089085
       ; 0.96991438
       ; 0.84211892 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 0.38684240
       ; 0.00812449
       ; 0.25888899
       ; -0.06962245
       ; 0.05404207
       ; -0.12640207
       ; 0.04120270
       ; 0.09297558 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Forward ~ttype:II x in
    close result expected

  let test_dst_3_backward () =
    let input =
      [| 0.83832872
       ; 0.46869317
       ; 0.41481951
       ; 0.27340707
       ; 0.05637550
       ; 0.86472237
       ; 0.81290102
       ; 0.99971765 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 5.81922865
       ; 0.00653082
       ; 3.16587067
       ; 1.27023125
       ; 0.12993698
       ; 1.53134310
       ; 0.82424980
       ; -0.86656040 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Backward ~ttype:III x in
    close result expected

  let test_dst_3_ortho () =
    let input =
      [| 0.99663681
       ; 0.55543172
       ; 0.76898742
       ; 0.94476575
       ; 0.84964740
       ; 0.24734810
       ; 0.45054415
       ; 0.12915942 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 1.48522890
       ; 1.04713714
       ; 0.11872885
       ; 0.20196684
       ; 0.52027225
       ; 0.27695364
       ; 0.05192040
       ; 0.28477481 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Ortho ~ttype:III x in
    close result expected

  let test_dst_3_forward () =
    let input =
      [| 0.95405102
       ; 0.60617465
       ; 0.22864281
       ; 0.67170066
       ; 0.61812824
       ; 0.35816273
       ; 0.11355759
       ; 0.67157322 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 0.28901333
       ; 0.16782624
       ; 0.07231256
       ; 0.10237385
       ; 0.16434348
       ; 0.00136459
       ; 0.02728951
       ; -0.05439240 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Forward ~ttype:III x in
    close result expected

  let test_dst_4_backward () =
    let input =
      [| 0.52030772
       ; 0.77231836
       ; 0.52016348
       ; 0.85218149
       ; 0.55190682
       ; 0.56093800
       ; 0.87665361
       ; 0.40348285 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 6.44558191
       ; 2.56039333
       ; 1.15299642
       ; 1.19234645
       ; 0.10844552
       ; 1.92546284
       ; -0.05677728
       ; -0.24125953 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Backward ~ttype:IV x in
    close result expected

  let test_dst_4_ortho () =
    let input =
      [| 0.13401523
       ; 0.02878268
       ; 0.75513726
       ; 0.62030953
       ; 0.70407975
       ; 0.21296416
       ; 0.13637148
       ; 0.01454467 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 0.82401651
       ; 0.78515619
       ; -0.21069290
       ; -0.26915047
       ; -0.06921585
       ; -0.04269409
       ; -0.01689269
       ; 0.33836311 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Ortho ~ttype:IV x in
    close result expected

  let test_dst_4_forward () =
    let input =
      [| 0.35058755
       ; 0.58991766
       ; 0.39224404
       ; 0.43747494
       ; 0.90415871
       ; 0.34825546
       ; 0.51398951
       ; 0.78365302 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let expected =
      [| 0.36822951
       ; 0.08125728
       ; 0.06015708
       ; 0.00932478
       ; 0.12167707
       ; 0.00318824
       ; -0.05184158
       ; 0.03424457 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    let result = dst ~norm:Forward ~ttype:IV x in
    close result expected

  let test_dst_inverse_1 () =
    let input =
      [| 0.39654279
       ; 0.62208670
       ; 0.86236370
       ; 0.94952065
       ; 0.14707348
       ; 0.92658764
       ; 0.49211630
       ; 0.25824440 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let forward = dst ~ttype:I x in
    let result = idst ~ttype:I forward in
    let expected =
      [| 0.39654278
       ; 0.62208670
       ; 0.86236371
       ; 0.94952062
       ; 0.14707348
       ; 0.92658763
       ; 0.49211629
       ; 0.25824439 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    close result expected

  let test_dst_inverse_2 () =
    let input =
      [| 0.45913577
       ; 0.98003256
       ; 0.49261808
       ; 0.32875162
       ; 0.63340086
       ; 0.24014562
       ; 0.07586333
       ; 0.12887973 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let forward = dst ~ttype:II x in
    let result = idst ~ttype:II forward in
    let expected =
      [| 0.45913576
       ; 0.98003258
       ; 0.49261809
       ; 0.32875161
       ; 0.63340085
       ; 0.24014562
       ; 0.07586333
       ; 0.12887972 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    close result expected

  let test_dst_inverse_3 () =
    let input =
      [| 0.12804584
       ; 0.15190269
       ; 0.13882717
       ; 0.64087474
       ; 0.18188009
       ; 0.34566727
       ; 0.89678842
       ; 0.47396165 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let forward = dst ~ttype:III x in
    let result = idst ~ttype:III forward in
    let expected =
      [| 0.12804584
       ; 0.15190269
       ; 0.13882717
       ; 0.64087474
       ; 0.18188008
       ; 0.34566728
       ; 0.89678841
       ; 0.47396164 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    close result expected

  let test_dst_inverse_4 () =
    let input =
      [| 0.66755772
       ; 0.17231987
       ; 0.19228902
       ; 0.04086862
       ; 0.16893506
       ; 0.27859035
       ; 0.17701049
       ; 0.08870254 |]
    in
    let x = of_array Bigarray.Float64 input [|8|] in
    let forward = dst ~ttype:IV x in
    let result = idst ~ttype:IV forward in
    let expected =
      [| 0.66755774
       ; 0.17231987
       ; 0.19228902
       ; 0.04086862
       ; 0.16893506
       ; 0.27859034
       ; 0.17701048
       ; 0.08870253 |]
    in
    let expected = of_array Bigarray.Float64 expected [|8|] in
    close result expected
end

(* The actual tests *)
let test_fft_8_backward () =
  Alcotest.(check bool)
    "test_fft_8_backward" true
    (To_test.test_fft_8_backward ())

let test_fft_8_ortho () =
  Alcotest.(check bool) "test_fft_8_ortho" true (To_test.test_fft_8_ortho ())

let test_fft_8_forward () =
  Alcotest.(check bool)
    "test_fft_8_forward" true
    (To_test.test_fft_8_forward ())

let test_fft_4x4_backward () =
  Alcotest.(check bool)
    "test_fft_4x4_backward" true
    (To_test.test_fft_4x4_backward ())

let test_fft_4x4_ortho () =
  Alcotest.(check bool)
    "test_fft_4x4_ortho" true
    (To_test.test_fft_4x4_ortho ())

let test_fft_4x4_forward () =
  Alcotest.(check bool)
    "test_fft_4x4_forward" true
    (To_test.test_fft_4x4_forward ())

let test_fft_3x4_backward () =
  Alcotest.(check bool)
    "test_fft_3x4_backward" true
    (To_test.test_fft_3x4_backward ())

let test_fft_3x4_ortho () =
  Alcotest.(check bool)
    "test_fft_3x4_ortho" true
    (To_test.test_fft_3x4_ortho ())

let test_fft_3x4_forward () =
  Alcotest.(check bool)
    "test_fft_3x4_forward" true
    (To_test.test_fft_3x4_forward ())

let test_fft_inverse () =
  Alcotest.(check bool) "test_fft_inverse" true (To_test.test_fft_inverse ())

let test_rfft_8_backward () =
  Alcotest.(check bool)
    "test_rfft_8_backward" true
    (To_test.test_rfft_8_backward ())

let test_rfft_8_ortho () =
  Alcotest.(check bool) "test_rfft_8_ortho" true (To_test.test_rfft_8_ortho ())

let test_rfft_8_forward () =
  Alcotest.(check bool)
    "test_rfft_8_forward" true
    (To_test.test_rfft_8_forward ())

let test_rfft_4x4_backward () =
  Alcotest.(check bool)
    "test_rfft_4x4_backward" true
    (To_test.test_rfft_4x4_backward ())

let test_rfft_4x4_ortho () =
  Alcotest.(check bool)
    "test_rfft_4x4_ortho" true
    (To_test.test_rfft_4x4_ortho ())

let test_rfft_4x4_forward () =
  Alcotest.(check bool)
    "test_rfft_4x4_forward" true
    (To_test.test_rfft_4x4_forward ())

let test_rfft_3x4_backward () =
  Alcotest.(check bool)
    "test_rfft_3x4_backward" true
    (To_test.test_rfft_3x4_backward ())

let test_rfft_3x4_ortho () =
  Alcotest.(check bool)
    "test_rfft_3x4_ortho" true
    (To_test.test_rfft_3x4_ortho ())

let test_rfft_3x4_forward () =
  Alcotest.(check bool)
    "test_rfft_3x4_forward" true
    (To_test.test_rfft_3x4_forward ())

let test_rfft_inverse () =
  Alcotest.(check bool) "test_rfft_inverse" true (To_test.test_rfft_inverse ())

let test_dct_1_backward () =
  Alcotest.(check bool)
    "test_dct_1_backward" true
    (To_test.test_dct_1_backward ())

let test_dct_1_ortho () =
  Alcotest.(check bool) "test_dct_1_ortho" true (To_test.test_dct_1_ortho ())

let test_dct_1_forward () =
  Alcotest.(check bool)
    "test_dct_1_forward" true
    (To_test.test_dct_1_forward ())

let test_dct_2_backward () =
  Alcotest.(check bool)
    "test_dct_2_backward" true
    (To_test.test_dct_2_backward ())

let test_dct_2_ortho () =
  Alcotest.(check bool) "test_dct_2_ortho" true (To_test.test_dct_2_ortho ())

let test_dct_2_forward () =
  Alcotest.(check bool)
    "test_dct_2_forward" true
    (To_test.test_dct_2_forward ())

let test_dct_3_backward () =
  Alcotest.(check bool)
    "test_dct_3_backward" true
    (To_test.test_dct_3_backward ())

let test_dct_3_ortho () =
  Alcotest.(check bool) "test_dct_3_ortho" true (To_test.test_dct_3_ortho ())

let test_dct_3_forward () =
  Alcotest.(check bool)
    "test_dct_3_forward" true
    (To_test.test_dct_3_forward ())

let test_dct_4_backward () =
  Alcotest.(check bool)
    "test_dct_4_backward" true
    (To_test.test_dct_4_backward ())

let test_dct_4_ortho () =
  Alcotest.(check bool) "test_dct_4_ortho" true (To_test.test_dct_4_ortho ())

let test_dct_4_forward () =
  Alcotest.(check bool)
    "test_dct_4_forward" true
    (To_test.test_dct_4_forward ())

let test_dct_inverse_1 () =
  Alcotest.(check bool)
    "test_dct_inverse_1" true
    (To_test.test_dct_inverse_1 ())

let test_dct_inverse_2 () =
  Alcotest.(check bool)
    "test_dct_inverse_2" true
    (To_test.test_dct_inverse_2 ())

let test_dct_inverse_3 () =
  Alcotest.(check bool)
    "test_dct_inverse_3" true
    (To_test.test_dct_inverse_3 ())

let test_dct_inverse_4 () =
  Alcotest.(check bool)
    "test_dct_inverse_4" true
    (To_test.test_dct_inverse_4 ())

let test_dst_1_backward () =
  Alcotest.(check bool)
    "test_dst_1_backward" true
    (To_test.test_dst_1_backward ())

let test_dst_1_ortho () =
  Alcotest.(check bool) "test_dst_1_ortho" true (To_test.test_dst_1_ortho ())

let test_dst_1_forward () =
  Alcotest.(check bool)
    "test_dst_1_forward" true
    (To_test.test_dst_1_forward ())

let test_dst_2_backward () =
  Alcotest.(check bool)
    "test_dst_2_backward" true
    (To_test.test_dst_2_backward ())

let test_dst_2_ortho () =
  Alcotest.(check bool) "test_dst_2_ortho" true (To_test.test_dst_2_ortho ())

let test_dst_2_forward () =
  Alcotest.(check bool)
    "test_dst_2_forward" true
    (To_test.test_dst_2_forward ())

let test_dst_3_backward () =
  Alcotest.(check bool)
    "test_dst_3_backward" true
    (To_test.test_dst_3_backward ())

let test_dst_3_ortho () =
  Alcotest.(check bool) "test_dst_3_ortho" true (To_test.test_dst_3_ortho ())

let test_dst_3_forward () =
  Alcotest.(check bool)
    "test_dst_3_forward" true
    (To_test.test_dst_3_forward ())

let test_dst_4_backward () =
  Alcotest.(check bool)
    "test_dst_4_backward" true
    (To_test.test_dst_4_backward ())

let test_dst_4_ortho () =
  Alcotest.(check bool) "test_dst_4_ortho" true (To_test.test_dst_4_ortho ())

let test_dst_4_forward () =
  Alcotest.(check bool)
    "test_dst_4_forward" true
    (To_test.test_dst_4_forward ())

let test_dst_inverse_1 () =
  Alcotest.(check bool)
    "test_dst_inverse_1" true
    (To_test.test_dst_inverse_1 ())

let test_dst_inverse_2 () =
  Alcotest.(check bool)
    "test_dst_inverse_2" true
    (To_test.test_dst_inverse_2 ())

let test_dst_inverse_3 () =
  Alcotest.(check bool)
    "test_dst_inverse_3" true
    (To_test.test_dst_inverse_3 ())

let test_dst_inverse_4 () =
  Alcotest.(check bool)
    "test_dst_inverse_4" true
    (To_test.test_dst_inverse_4 ())

let test_set =
  [ ("test_fft_8_backward", `Slow, test_fft_8_backward)
  ; ("test_fft_8_ortho", `Slow, test_fft_8_ortho)
  ; ("test_fft_8_forward", `Slow, test_fft_8_forward)
  ; ("test_fft_4x4_backward", `Slow, test_fft_4x4_backward)
  ; ("test_fft_4x4_ortho", `Slow, test_fft_4x4_ortho)
  ; ("test_fft_4x4_forward", `Slow, test_fft_4x4_forward)
  ; ("test_fft_3x4_backward", `Slow, test_fft_3x4_backward)
  ; ("test_fft_3x4_ortho", `Slow, test_fft_3x4_ortho)
  ; ("test_fft_3x4_forward", `Slow, test_fft_3x4_forward)
  ; ("test_fft_inverse", `Slow, test_fft_inverse)
  ; ("test_rfft_8_backward", `Slow, test_rfft_8_backward)
  ; ("test_rfft_8_ortho", `Slow, test_rfft_8_ortho)
  ; ("test_rfft_8_forward", `Slow, test_rfft_8_forward)
  ; ("test_rfft_4x4_backward", `Slow, test_rfft_4x4_backward)
  ; ("test_rfft_4x4_ortho", `Slow, test_rfft_4x4_ortho)
  ; ("test_rfft_4x4_forward", `Slow, test_rfft_4x4_forward)
  ; ("test_rfft_3x4_backward", `Slow, test_rfft_3x4_backward)
  ; ("test_rfft_3x4_ortho", `Slow, test_rfft_3x4_ortho)
  ; ("test_rfft_3x4_forward", `Slow, test_rfft_3x4_forward)
  ; ("test_rfft_inverse", `Slow, test_rfft_inverse)
  ; ("test_dct_1_backward", `Slow, test_dct_1_backward)
  ; ("test_dct_1_ortho", `Slow, test_dct_1_ortho)
  ; ("test_dct_1_forward", `Slow, test_dct_1_forward)
  ; ("test_dct_2_backward", `Slow, test_dct_2_backward)
  ; ("test_dct_2_ortho", `Slow, test_dct_2_ortho)
  ; ("test_dct_2_forward", `Slow, test_dct_2_forward)
  ; ("test_dct_3_backward", `Slow, test_dct_3_backward)
  ; ("test_dct_3_ortho", `Slow, test_dct_3_ortho)
  ; ("test_dct_3_forward", `Slow, test_dct_3_forward)
  ; ("test_dct_4_backward", `Slow, test_dct_4_backward)
  ; ("test_dct_4_ortho", `Slow, test_dct_4_ortho)
  ; ("test_dct_4_forward", `Slow, test_dct_4_forward)
  ; ("test_dct_inverse_1", `Slow, test_dct_inverse_1)
  ; ("test_dct_inverse_2", `Slow, test_dct_inverse_2)
  ; ("test_dct_inverse_3", `Slow, test_dct_inverse_3)
  ; ("test_dct_inverse_4", `Slow, test_dct_inverse_4)
  ; ("test_dst_1_backward", `Slow, test_dst_1_backward)
  ; ("test_dst_1_ortho", `Slow, test_dst_1_ortho)
  ; ("test_dst_1_forward", `Slow, test_dst_1_forward)
  ; ("test_dst_2_backward", `Slow, test_dst_2_backward)
  ; ("test_dst_2_ortho", `Slow, test_dst_2_ortho)
  ; ("test_dst_2_forward", `Slow, test_dst_2_forward)
  ; ("test_dst_3_backward", `Slow, test_dst_3_backward)
  ; ("test_dst_3_ortho", `Slow, test_dst_3_ortho)
  ; ("test_dst_3_forward", `Slow, test_dst_3_forward)
  ; ("test_dst_4_backward", `Slow, test_dst_4_backward)
  ; ("test_dst_4_ortho", `Slow, test_dst_4_ortho)
  ; ("test_dst_4_forward", `Slow, test_dst_4_forward)
  ; ("test_dst_inverse_1", `Slow, test_dst_inverse_1)
  ; ("test_dst_inverse_2", `Slow, test_dst_inverse_2)
  ; ("test_dst_inverse_3", `Slow, test_dst_inverse_3)
  ; ("test_dst_inverse_4", `Slow, test_dst_inverse_4) ]
