(** Unit test for Owl_maths module and special functions *)

module M = Owl_maths


(* define the test error *)
let eps = 1e-10

let approx_equal a b = Pervasives.(abs_float (a -. b) < eps)


(* a module with functions to test *)
module To_test = struct

  let test_j0 () =
    approx_equal (M.j0 0.5) 0.93846980724081297

  let test_j1 () =
    approx_equal (M.j1 0.5) 0.24226845767487387

  let test_jv () =
    approx_equal (M.jv 0.1 0.3) 0.85180759557596664

  let test_y0 () =
    approx_equal (M.y0 0.5) (-0.44451873350670662)

  let test_y1 () =
    approx_equal (M.y1 0.3) (-2.2931051383885293)

  let test_yv () =
    approx_equal (M.yv 0.3 0.2) (-1.470298525261079)

  let test_i0 () =
    approx_equal (M.i0 0.3) 1.0226268793515974

  let test_i0e () =
    approx_equal (M.i0e 0.3) 0.7575806251825481

  let test_i1 () =
    approx_equal (M.i1 0.3) 0.15169384000359282

  let test_i1e () =
    approx_equal (M.i1e 0.3) 0.11237756063983881

  let test_iv () =
    approx_equal (M.iv 0.3 0.1) 0.45447035229197424

  let test_k0 () =
    approx_equal (M.k0 0.3) 1.3724600605442983

  let test_k0e () =
    approx_equal (M.k0e 0.3) 1.8526273007720155

  let test_k1 () =
    approx_equal (M.k1 0.3) 3.0559920334573252

  let test_k1e () =
    approx_equal (M.k1e 0.3) 4.12515776224447

  let test_airy () =
    let a, b, c, d = M.airy 0.7 in
    approx_equal a 0.18916240039814997 &&
    approx_equal b (-0.19985119158228049) &&
    approx_equal c 0.97332865587816564 &&
    approx_equal d 0.65440591917213997

  let test_ellipj () =
    let a, b, c, d = M.ellipj 0.2 0.3 in
    approx_equal a 0.19828063826280756 &&
    approx_equal b 0.98014528948013302 &&
    approx_equal c 0.99408522599776539 &&
    approx_equal d 0.19960341784106181

  let test_ellipk () =
    approx_equal (M.ellipk 0.3) 1.713889448178791

  let test_ellipkm1 () =
    approx_equal (M.ellipkm1 0.3) 2.0753631352924691

  let test_ellipkinc () =
    approx_equal (M.ellipkinc 0.2 0.3) 0.20039894647982787

  let test_ellipe () =
    approx_equal (M.ellipe 0.3) 1.4453630644126654

  let test_ellipeinc () =
    approx_equal (M.ellipeinc 0.2 0.3) 0.19960247841509551

  let test_gamma () =
    approx_equal (M.gamma 0.7) 1.2980553326475581

  let test_rgamma () =
    approx_equal (M.rgamma 0.7) 0.7703831838665659

  let test_loggamma () =
    approx_equal (M.loggamma 0.7) 0.26086724653166637

  let test_gammainc () =
    approx_equal (M.gammainc 0.2 0.7) 0.91521960195630503

  let test_gammaincinv () =
    approx_equal (M.gammaincinv 0.2 0.7) 0.12103758588873516

  let test_gammaincc () =
    approx_equal (M.gammaincc 0.2 0.7) 0.084780398043694499

  let test_gammainccinv () =
    approx_equal (M.gammainccinv 0.2 0.7) 0.0015877907243441165

  let test_psi () =
    approx_equal (M.psi 0.7) (-1.2200235536979349)

  let test_beta () =
    approx_equal (M.beta 0.2 0.7) 5.5764636958498768

  let test_betainc () =
    approx_equal (M.betainc 0.1 0.2 0.7) 0.71632698299586095

  let test_bdtr () =
    approx_equal (M.bdtr 5 25 0.2) 0.6166894117793692

  let test_bdtrc () =
    approx_equal (M.bdtrc 5 25 0.2) 0.3833105882206313

  let test_bdtri () =
    approx_equal (M.bdtri 5 25 0.2) 0.29781277333188838

  let test_btdtr () =
    approx_equal (M.btdtr 5. 25. 0.2) 0.71605354811801325

  let test_btdtri () =
    approx_equal (M.btdtri 5. 25. 0.2) 0.10833617793798132

  let test_fact () =
    let x = [|0; 1; 10; 50; 100; 150; 170|] in
    let y = Array.map M.fact x in
    let z = [|1.; 1.; 3628800.; 3.04140932017133780436126081661e+64; 9.33262154439441526816992388563e+157; 5.71338395644585459047893286526e+262; 7.25741561530799896739672821113e+306|] in
    let z = Array.map2 approx_equal y z in
    Array.for_all (fun a -> a = true) z

  let test_log_fact () =
    let x = [|0; 1; 10; 50; 100; 150; 170|] in
    let y = Array.map M.log_fact x in
    let z = [|0.; 0.; 15.1044125730755159; 148.47776695177302; 363.73937555556347; 605.020105849423658; 706.573062245787355|] in
    let z = Array.map2 approx_equal y z in
    Array.for_all (fun a -> a = true) z

  let test_combination () =
    let n = 100 in
    let x = [|0; 1; 10; 30; 50; 80|] in
    let y = Array.map (M.combination_float n) x in
    let z = [|1.; 100.; 17310309456440.; 2.93723398216109426e+25; 1.0089134454556422e+29; 5.35983370403809657e+20|] in
    let z = Array.map2 (fun a b -> a -. b) y z in
    Array.for_all (fun a -> a < 1e-8) z

  let test_mulmod () =
    let i = max_int in
    let x = [|(0, 1, 2); (1, 2, 1); (2, 1, 2); (2, 2, 3); (4, 5, 3); (1847, 5516, 15268); (4549, 9581, 2679); (i - 1, i - 1, 2); (i - 1, i - 1, 10); (i - 1, i - 1, i)|] in
    let y = [|0; 0; 0; 1; 2; 4296; 1997; 0; 4; 1|] in
    let b = Array.map (fun (a, b, m) -> M.mulmod a b m) x in
    let t = Array.map2 (=) b y in
    Array.for_all (fun a -> a = true) t

  let test_powmod () =
    let i = max_int in
    let x = [|(0, 0, 1); (0, 0, 2); (0, 2, 2); (1, 2, 1); (2, 1, 2); (5, 3, 3); (1847, 5516, 15268); (4549, 9581, 2679); (i - 1, i - 1, 2); (i - 1, i - 1, 10); (i - 1, i - 1, i)|] in
    let y = [|0; 1; 0; 0; 0; 2; 4973; 1513; 0; 4; 1|] in
    let b = Array.map (fun (a, b, m) -> M.powmod a b m) x in
    let t = Array.map2 (=) b y in
    Array.for_all (fun a -> a = true) t

  let test_is_prime () =
    let x = [|-1; 0; 1; 2; 3; 4; 8191; 12345; 524287; 780865231; 1073741789|] in
    let y = [|false; false; false; true; true; false; true; false; true; false; true|] in
    let r = Array.map M.is_prime x in
    let t = Array.map2 (=) r y in
    Array.for_all (fun a -> a = true) t

end


(* the tests *)

let test_j0 () =
  Alcotest.(check bool) "test j0" true (To_test.test_j0 ())

let test_j1 () =
  Alcotest.(check bool) "test j1" true (To_test.test_j1 ())

let test_jv () =
  Alcotest.(check bool) "test jv" true (To_test.test_jv ())

let test_y0 () =
  Alcotest.(check bool) "test y0" true (To_test.test_y0 ())

let test_y1 () =
  Alcotest.(check bool) "test y1" true (To_test.test_y1 ())

let test_yv () =
  Alcotest.(check bool) "test yv" true (To_test.test_yv ())

let test_i0 () =
  Alcotest.(check bool) "test i0" true (To_test.test_i0 ())

let test_i0e () =
  Alcotest.(check bool) "test i0e" true (To_test.test_i0e ())

let test_i1 () =
  Alcotest.(check bool) "test i1" true (To_test.test_i1 ())

let test_i1e () =
  Alcotest.(check bool) "test i1e" true (To_test.test_i1e ())

let test_iv () =
  Alcotest.(check bool) "test iv" true (To_test.test_iv ())

let test_k0 () =
  Alcotest.(check bool) "test k0" true (To_test.test_k0 ())

let test_k0e () =
  Alcotest.(check bool) "test k0e" true (To_test.test_k0e ())

let test_k1 () =
  Alcotest.(check bool) "test k1" true (To_test.test_k1 ())

let test_k1e () =
  Alcotest.(check bool) "test k1e" true (To_test.test_k1e ())

let test_airy () =
  Alcotest.(check bool) "test airy" true (To_test.test_airy ())

let test_ellipj () =
  Alcotest.(check bool) "test ellipj" true (To_test.test_ellipj ())

let test_ellipk () =
  Alcotest.(check bool) "test ellipk" true (To_test.test_ellipk ())

let test_ellipkm1 () =
  Alcotest.(check bool) "test ellipkm1" true (To_test.test_ellipkm1 ())

let test_ellipkinc () =
  Alcotest.(check bool) "test ellipkinc" true (To_test.test_ellipkinc ())

let test_ellipe () =
  Alcotest.(check bool) "test ellipe" true (To_test.test_ellipe ())

let test_ellipeinc () =
  Alcotest.(check bool) "test ellipeinc" true (To_test.test_ellipeinc ())

let test_gamma () =
  Alcotest.(check bool) "test gamma" true (To_test.test_gamma ())

let test_rgamma () =
  Alcotest.(check bool) "test rgamma" true (To_test.test_rgamma ())

let test_loggamma () =
  Alcotest.(check bool) "test loggamma" true (To_test.test_loggamma ())

let test_gammainc () =
  Alcotest.(check bool) "test gammainc" true (To_test.test_gammainc ())

let test_gammaincinv () =
  Alcotest.(check bool) "test gammaincinv" true (To_test.test_gammaincinv ())

let test_gammaincc () =
  Alcotest.(check bool) "test gammaincc" true (To_test.test_gammaincc ())

let test_gammainccinv () =
  Alcotest.(check bool) "test gammainccinv" true (To_test.test_gammainccinv ())

let test_psi () =
  Alcotest.(check bool) "test psi" true (To_test.test_psi ())

let test_beta () =
  Alcotest.(check bool) "test beta" true (To_test.test_beta ())

let test_betainc () =
  Alcotest.(check bool) "test betainc" true (To_test.test_betainc ())

let test_bdtr () =
  Alcotest.(check bool) "test bdtr" true (To_test.test_bdtr ())

let test_bdtrc () =
  Alcotest.(check bool) "test bdtrc" true (To_test.test_bdtrc ())

let test_bdtri () =
  Alcotest.(check bool) "test bdtri" true (To_test.test_bdtri ())

let test_btdtr () =
  Alcotest.(check bool) "test btdtr" true (To_test.test_btdtr ())

let test_btdtri () =
  Alcotest.(check bool) "test btdtri" true (To_test.test_btdtri ())

let test_fact () =
  Alcotest.(check bool) "test fact" true (To_test.test_fact ())

let test_log_fact () =
  Alcotest.(check bool) "test log_fact" true (To_test.test_log_fact ())

let test_combination () =
  Alcotest.(check bool) "test combination" true (To_test.test_combination ())

let test_mulmod () =
  Alcotest.(check bool) "test mulmod" true (To_test.test_mulmod ())

let test_powmod () =
  Alcotest.(check bool) "test powmod" true (To_test.test_powmod ())

let test_is_prime () =
  Alcotest.(check bool) "test is_prime" true (To_test.test_is_prime ())

let test_set = [
  "test j0", `Slow, test_j0;
  "test j1", `Slow, test_j1;
  "test jv", `Slow, test_jv;
  "test y0", `Slow, test_y0;
  "test y1", `Slow, test_y1;
  "test yv", `Slow, test_yv;
  "test i0", `Slow, test_i0;
  "test i0e", `Slow, test_i0e;
  "test i1", `Slow, test_i1;
  "test i1e", `Slow, test_i1e;
  "test iv", `Slow, test_iv;
  "test k0", `Slow, test_k0;
  "test k0e", `Slow, test_k0e;
  "test k1", `Slow, test_k1;
  "test k1e", `Slow, test_k1e;
  "test ellipj", `Slow, test_ellipj;
  "test airy", `Slow, test_airy;
  "test ellipj", `Slow, test_ellipj;
  "test ellipk", `Slow, test_ellipk;
  "test ellipkm1", `Slow, test_ellipkm1;
  "test ellipkinc", `Slow, test_ellipkinc;
  "test ellipe", `Slow, test_ellipe;
  "test ellipeinc", `Slow, test_ellipeinc;
  "test gamma", `Slow, test_gamma;
  "test rgamma", `Slow, test_rgamma;
  "test loggamma", `Slow, test_loggamma;
  "test gammainc", `Slow, test_gammainc;
  "test gammaincc", `Slow, test_gammaincc;
  "test gammainccinv", `Slow, test_gammainccinv;
  "test psi", `Slow, test_psi;
  "test beta", `Slow, test_beta;
  "test betainc", `Slow, test_betainc;
  "test bdtr", `Slow, test_bdtr;
  "test bdtrc", `Slow, test_bdtrc;
  "test bdtri", `Slow, test_bdtri;
  "test btdtr", `Slow, test_btdtr;
  "test btdtri", `Slow, test_btdtri;
  "test fact", `Slow, test_fact;
  "test log_fact", `Slow, test_log_fact;
  "test combination", `Slow, test_combination;
  "test mulmod", `Slow, test_mulmod;
  "test powmod", `Slow, test_powmod;
  "test is_prime", `Slow, test_is_prime;
]
