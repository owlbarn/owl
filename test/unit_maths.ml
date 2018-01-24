(** Unit test for Owl_maths module and special functions *)

module M = Owl_maths


(* define the test error *)
let eps = 1e-10


(* a module with functions to test *)
module To_test = struct

  let test_j0 () =
    M.j0 0.5 -. 0.93846980724081297 < eps

  let test_j1 () =
    M.j1 0.5 -. 0.24226845767487387 < eps

  let test_jv () =
    M.jv 0.1 0.3 -. 0.85180759557596664 < eps

  let test_y0 () =
    M.y0 0.5 -. (-0.44451873350670662) < eps

  let test_y1 () =
    M.y1 0.3 -. (-2.2931051383885293) < eps

  let test_yv () =
    M.yv 0.3 0.2 -. (-1.470298525261079) < eps

  let test_i0 () =
    M.i0 0.3 -. 1.0226268793515974 < eps

  let test_i0e () =
    M.i0e 0.3 -. 0.7575806251825481 < eps

  let test_i1 () =
    M.i1 0.3 -. 0.15169384000359282 < eps

  let test_i1e () =
    M.i1e 0.3 -. 0.11237756063983881 < eps

  let test_iv () =
    M.iv 0.3 0.1 -. 0.45447035229197424 < eps

  let test_k0 () =
    M.k0 0.3 -. 1.3724600605442983 < eps

  let test_k0e () =
    M.k0e 0.3 -. 1.8526273007720155 < eps

  let test_k1 () =
    M.k1 0.3 -. 3.0559920334573252 < eps

  let test_k1e () =
    M.k1e 0.3 -. 4.12515776224447 < eps

  let test_airy () =
    let a, b, c, d = M.airy 0.7 in
    a -. 0.18916240039814997 < eps &&
    b +. 0.19985119158228049 < eps &&
    c -. 0.97332865587816564 < eps &&
    d -. 0.65440591917213997 < eps

  let test_ellipj () =
    let a, b, c, d = M.ellipj 0.2 0.3 in
    a -. 0.19828063826280756 < eps &&
    b -. 0.98014528948013302 < eps &&
    c -. 0.99408522599776539 < eps &&
    d -. 0.19960341784106181 < eps

  let test_ellipk () =
    M.ellipk 0.3 -. 1.713889448178791 < eps

  let test_ellipkm1 () =
    M.ellipkm1 0.3 -. 2.0753631352924691 < eps

  let test_ellipkinc () =
    M.ellipkinc 0.2 0.3 -. 0.20039894647982787 < eps

  let test_ellipe () =
    M.ellipe 0.3 -. 1.4453630644126654 < eps

  let test_ellipeinc () =
    M.ellipeinc 0.2 0.3 -. 0.19960247841509551 < eps

  let test_gamma () =
    M.gamma 0.7 -. 1.2980553326475581 < eps

  let test_rgamma () =
    M.rgamma 0.7 -. 0.7703831838665659 < eps

  let test_loggamma () =
    M.loggamma 0.7 -. 0.26086724653166637 < eps

  let test_gammainc () =
    M.gammainc 0.2 0.7 -. 0.91521960195630503 < eps

  let test_gammaincinv () =
    M.gammaincinv 0.2 0.7 -. 0.12103758588873516 < eps

  let test_gammaincc () =
    M.gammaincc 0.2 0.7 -. 0.084780398043694499 < eps

  let test_gammainccinv () =
    M.gammainccinv 0.2 0.7 -. 0.0015877907243441165 < eps

  let test_psi () =
    M.psi 0.7 -. (-1.2200235536979349) < eps

  let test_beta () =
    M.beta 0.2 0.7 -. 5.5764636958498768 < eps

  let test_betainc () =
    M.betainc 0.1 0.2 0.7 -. 0.71632698299586095 < eps

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
]
