#include "owl_cblas.h"
#include "ctypes_cstubs_internals.h"
value owl_stub_1_cblas_srotg(value x4, value x3, value x2, value x1)
{
   float* x5 = CTYPES_ADDR_OF_FATPTR(x4);
   float* x6 = CTYPES_ADDR_OF_FATPTR(x3);
   float* x7 = CTYPES_ADDR_OF_FATPTR(x2);
   float* x8 = CTYPES_ADDR_OF_FATPTR(x1);
   cblas_srotg(x5, x6, x7, x8);
   return Val_unit;
}
value owl_stub_2_cblas_drotg(value x13, value x12, value x11, value x10)
{
   double* x14 = CTYPES_ADDR_OF_FATPTR(x13);
   double* x15 = CTYPES_ADDR_OF_FATPTR(x12);
   double* x16 = CTYPES_ADDR_OF_FATPTR(x11);
   double* x17 = CTYPES_ADDR_OF_FATPTR(x10);
   cblas_drotg(x14, x15, x16, x17);
   return Val_unit;
}
value owl_stub_3_cblas_srotmg(value x23, value x22, value x21, value x20,
                              value x19)
{
   float* x24 = CTYPES_ADDR_OF_FATPTR(x23);
   float* x25 = CTYPES_ADDR_OF_FATPTR(x22);
   float* x26 = CTYPES_ADDR_OF_FATPTR(x21);
   double x27 = Double_val(x20);
   float* x30 = CTYPES_ADDR_OF_FATPTR(x19);
   cblas_srotmg(x24, x25, x26, (float)x27, x30);
   return Val_unit;
}
value owl_stub_4_cblas_drotmg(value x36, value x35, value x34, value x33,
                              value x32)
{
   double* x37 = CTYPES_ADDR_OF_FATPTR(x36);
   double* x38 = CTYPES_ADDR_OF_FATPTR(x35);
   double* x39 = CTYPES_ADDR_OF_FATPTR(x34);
   double x40 = Double_val(x33);
   double* x43 = CTYPES_ADDR_OF_FATPTR(x32);
   cblas_drotmg(x37, x38, x39, x40, x43);
   return Val_unit;
}
value owl_stub_5_cblas_srot(value x51, value x50, value x49, value x48,
                            value x47, value x46, value x45)
{
   int x52 = Long_val(x51);
   float* x55 = CTYPES_ADDR_OF_FATPTR(x50);
   int x56 = Long_val(x49);
   float* x59 = CTYPES_ADDR_OF_FATPTR(x48);
   int x60 = Long_val(x47);
   double x63 = Double_val(x46);
   double x66 = Double_val(x45);
   cblas_srot(x52, x55, x56, x59, x60, (float)x63, (float)x66);
   return Val_unit;
}
value owl_stub_5_cblas_srot_byte7(value* argv, int argc)
{
   value x70 = argv[6];
   value x71 = argv[5];
   value x72 = argv[4];
   value x73 = argv[3];
   value x74 = argv[2];
   value x75 = argv[1];
   value x76 = argv[0];
   return owl_stub_5_cblas_srot(x76, x75, x74, x73, x72, x71, x70);
}
value owl_stub_6_cblas_drot(value x83, value x82, value x81, value x80,
                            value x79, value x78, value x77)
{
   int x84 = Long_val(x83);
   double* x87 = CTYPES_ADDR_OF_FATPTR(x82);
   int x88 = Long_val(x81);
   double* x91 = CTYPES_ADDR_OF_FATPTR(x80);
   int x92 = Long_val(x79);
   double x95 = Double_val(x78);
   double x98 = Double_val(x77);
   cblas_drot(x84, x87, x88, x91, x92, x95, x98);
   return Val_unit;
}
value owl_stub_6_cblas_drot_byte7(value* argv, int argc)
{
   value x102 = argv[6];
   value x103 = argv[5];
   value x104 = argv[4];
   value x105 = argv[3];
   value x106 = argv[2];
   value x107 = argv[1];
   value x108 = argv[0];
   return owl_stub_6_cblas_drot(x108, x107, x106, x105, x104, x103, x102);
}
value owl_stub_7_cblas_sswap(value x113, value x112, value x111, value x110,
                             value x109)
{
   int x114 = Long_val(x113);
   float* x117 = CTYPES_ADDR_OF_FATPTR(x112);
   int x118 = Long_val(x111);
   float* x121 = CTYPES_ADDR_OF_FATPTR(x110);
   int x122 = Long_val(x109);
   cblas_sswap(x114, x117, x118, x121, x122);
   return Val_unit;
}
value owl_stub_8_cblas_dswap(value x130, value x129, value x128, value x127,
                             value x126)
{
   int x131 = Long_val(x130);
   double* x134 = CTYPES_ADDR_OF_FATPTR(x129);
   int x135 = Long_val(x128);
   double* x138 = CTYPES_ADDR_OF_FATPTR(x127);
   int x139 = Long_val(x126);
   cblas_dswap(x131, x134, x135, x138, x139);
   return Val_unit;
}
value owl_stub_9_cblas_cswap(value x147, value x146, value x145, value x144,
                             value x143)
{
   int x148 = Long_val(x147);
   float _Complex* x151 = CTYPES_ADDR_OF_FATPTR(x146);
   int x152 = Long_val(x145);
   float _Complex* x155 = CTYPES_ADDR_OF_FATPTR(x144);
   int x156 = Long_val(x143);
   cblas_cswap(x148, x151, x152, x155, x156);
   return Val_unit;
}
value owl_stub_10_cblas_zswap(value x164, value x163, value x162, value x161,
                              value x160)
{
   int x165 = Long_val(x164);
   double _Complex* x168 = CTYPES_ADDR_OF_FATPTR(x163);
   int x169 = Long_val(x162);
   double _Complex* x172 = CTYPES_ADDR_OF_FATPTR(x161);
   int x173 = Long_val(x160);
   cblas_zswap(x165, x168, x169, x172, x173);
   return Val_unit;
}
value owl_stub_11_cblas_sscal(value x180, value x179, value x178, value x177)
{
   int x181 = Long_val(x180);
   double x184 = Double_val(x179);
   float* x187 = CTYPES_ADDR_OF_FATPTR(x178);
   int x188 = Long_val(x177);
   cblas_sscal(x181, (float)x184, x187, x188);
   return Val_unit;
}
value owl_stub_12_cblas_dscal(value x195, value x194, value x193, value x192)
{
   int x196 = Long_val(x195);
   double x199 = Double_val(x194);
   double* x202 = CTYPES_ADDR_OF_FATPTR(x193);
   int x203 = Long_val(x192);
   cblas_dscal(x196, x199, x202, x203);
   return Val_unit;
}
value owl_stub_13_cblas_cscal(value x210, value x209, value x208, value x207)
{
   int x211 = Long_val(x210);
   float _Complex* x214 = CTYPES_ADDR_OF_FATPTR(x209);
   float _Complex* x215 = CTYPES_ADDR_OF_FATPTR(x208);
   int x216 = Long_val(x207);
   cblas_cscal(x211, x214, x215, x216);
   return Val_unit;
}
value owl_stub_14_cblas_zscal(value x223, value x222, value x221, value x220)
{
   int x224 = Long_val(x223);
   double _Complex* x227 = CTYPES_ADDR_OF_FATPTR(x222);
   double _Complex* x228 = CTYPES_ADDR_OF_FATPTR(x221);
   int x229 = Long_val(x220);
   cblas_zscal(x224, x227, x228, x229);
   return Val_unit;
}
value owl_stub_15_cblas_csscal(value x236, value x235, value x234,
                               value x233)
{
   int x237 = Long_val(x236);
   double x240 = Double_val(x235);
   float _Complex* x243 = CTYPES_ADDR_OF_FATPTR(x234);
   int x244 = Long_val(x233);
   cblas_csscal(x237, (float)x240, x243, x244);
   return Val_unit;
}
value owl_stub_16_cblas_zdscal(value x251, value x250, value x249,
                               value x248)
{
   int x252 = Long_val(x251);
   double x255 = Double_val(x250);
   double _Complex* x258 = CTYPES_ADDR_OF_FATPTR(x249);
   int x259 = Long_val(x248);
   cblas_zdscal(x252, x255, x258, x259);
   return Val_unit;
}
value owl_stub_17_cblas_scopy(value x267, value x266, value x265, value x264,
                              value x263)
{
   int x268 = Long_val(x267);
   float* x271 = CTYPES_ADDR_OF_FATPTR(x266);
   int x272 = Long_val(x265);
   float* x275 = CTYPES_ADDR_OF_FATPTR(x264);
   int x276 = Long_val(x263);
   cblas_scopy(x268, x271, x272, x275, x276);
   return Val_unit;
}
value owl_stub_18_cblas_dcopy(value x284, value x283, value x282, value x281,
                              value x280)
{
   int x285 = Long_val(x284);
   double* x288 = CTYPES_ADDR_OF_FATPTR(x283);
   int x289 = Long_val(x282);
   double* x292 = CTYPES_ADDR_OF_FATPTR(x281);
   int x293 = Long_val(x280);
   cblas_dcopy(x285, x288, x289, x292, x293);
   return Val_unit;
}
value owl_stub_19_cblas_ccopy(value x301, value x300, value x299, value x298,
                              value x297)
{
   int x302 = Long_val(x301);
   float _Complex* x305 = CTYPES_ADDR_OF_FATPTR(x300);
   int x306 = Long_val(x299);
   float _Complex* x309 = CTYPES_ADDR_OF_FATPTR(x298);
   int x310 = Long_val(x297);
   cblas_ccopy(x302, x305, x306, x309, x310);
   return Val_unit;
}
value owl_stub_20_cblas_zcopy(value x318, value x317, value x316, value x315,
                              value x314)
{
   int x319 = Long_val(x318);
   double _Complex* x322 = CTYPES_ADDR_OF_FATPTR(x317);
   int x323 = Long_val(x316);
   double _Complex* x326 = CTYPES_ADDR_OF_FATPTR(x315);
   int x327 = Long_val(x314);
   cblas_zcopy(x319, x322, x323, x326, x327);
   return Val_unit;
}
value owl_stub_21_cblas_saxpy(value x336, value x335, value x334, value x333,
                              value x332, value x331)
{
   int x337 = Long_val(x336);
   double x340 = Double_val(x335);
   float* x343 = CTYPES_ADDR_OF_FATPTR(x334);
   int x344 = Long_val(x333);
   float* x347 = CTYPES_ADDR_OF_FATPTR(x332);
   int x348 = Long_val(x331);
   cblas_saxpy(x337, (float)x340, x343, x344, x347, x348);
   return Val_unit;
}
value owl_stub_21_cblas_saxpy_byte6(value* argv, int argc)
{
   value x352 = argv[5];
   value x353 = argv[4];
   value x354 = argv[3];
   value x355 = argv[2];
   value x356 = argv[1];
   value x357 = argv[0];
   return owl_stub_21_cblas_saxpy(x357, x356, x355, x354, x353, x352);
}
value owl_stub_22_cblas_daxpy(value x363, value x362, value x361, value x360,
                              value x359, value x358)
{
   int x364 = Long_val(x363);
   double x367 = Double_val(x362);
   double* x370 = CTYPES_ADDR_OF_FATPTR(x361);
   int x371 = Long_val(x360);
   double* x374 = CTYPES_ADDR_OF_FATPTR(x359);
   int x375 = Long_val(x358);
   cblas_daxpy(x364, x367, x370, x371, x374, x375);
   return Val_unit;
}
value owl_stub_22_cblas_daxpy_byte6(value* argv, int argc)
{
   value x379 = argv[5];
   value x380 = argv[4];
   value x381 = argv[3];
   value x382 = argv[2];
   value x383 = argv[1];
   value x384 = argv[0];
   return owl_stub_22_cblas_daxpy(x384, x383, x382, x381, x380, x379);
}
value owl_stub_23_cblas_caxpy(value x390, value x389, value x388, value x387,
                              value x386, value x385)
{
   int x391 = Long_val(x390);
   float _Complex* x394 = CTYPES_ADDR_OF_FATPTR(x389);
   float _Complex* x395 = CTYPES_ADDR_OF_FATPTR(x388);
   int x396 = Long_val(x387);
   float _Complex* x399 = CTYPES_ADDR_OF_FATPTR(x386);
   int x400 = Long_val(x385);
   cblas_caxpy(x391, x394, x395, x396, x399, x400);
   return Val_unit;
}
value owl_stub_23_cblas_caxpy_byte6(value* argv, int argc)
{
   value x404 = argv[5];
   value x405 = argv[4];
   value x406 = argv[3];
   value x407 = argv[2];
   value x408 = argv[1];
   value x409 = argv[0];
   return owl_stub_23_cblas_caxpy(x409, x408, x407, x406, x405, x404);
}
value owl_stub_24_cblas_zaxpy(value x415, value x414, value x413, value x412,
                              value x411, value x410)
{
   int x416 = Long_val(x415);
   double _Complex* x419 = CTYPES_ADDR_OF_FATPTR(x414);
   double _Complex* x420 = CTYPES_ADDR_OF_FATPTR(x413);
   int x421 = Long_val(x412);
   double _Complex* x424 = CTYPES_ADDR_OF_FATPTR(x411);
   int x425 = Long_val(x410);
   cblas_zaxpy(x416, x419, x420, x421, x424, x425);
   return Val_unit;
}
value owl_stub_24_cblas_zaxpy_byte6(value* argv, int argc)
{
   value x429 = argv[5];
   value x430 = argv[4];
   value x431 = argv[3];
   value x432 = argv[2];
   value x433 = argv[1];
   value x434 = argv[0];
   return owl_stub_24_cblas_zaxpy(x434, x433, x432, x431, x430, x429);
}
value owl_stub_25_cblas_sdot(value x439, value x438, value x437, value x436,
                             value x435)
{
   int x440 = Long_val(x439);
   float* x443 = CTYPES_ADDR_OF_FATPTR(x438);
   int x444 = Long_val(x437);
   float* x447 = CTYPES_ADDR_OF_FATPTR(x436);
   int x448 = Long_val(x435);
   float x451 = cblas_sdot(x440, x443, x444, x447, x448);
   return caml_copy_double(x451);
}
value owl_stub_26_cblas_ddot(value x456, value x455, value x454, value x453,
                             value x452)
{
   int x457 = Long_val(x456);
   double* x460 = CTYPES_ADDR_OF_FATPTR(x455);
   int x461 = Long_val(x454);
   double* x464 = CTYPES_ADDR_OF_FATPTR(x453);
   int x465 = Long_val(x452);
   double x468 = cblas_ddot(x457, x460, x461, x464, x465);
   return caml_copy_double(x468);
}
value owl_stub_27_cblas_sdsdot(value x474, value x473, value x472,
                               value x471, value x470, value x469)
{
   int x475 = Long_val(x474);
   double x478 = Double_val(x473);
   float* x481 = CTYPES_ADDR_OF_FATPTR(x472);
   int x482 = Long_val(x471);
   float* x485 = CTYPES_ADDR_OF_FATPTR(x470);
   int x486 = Long_val(x469);
   float x489 = cblas_sdsdot(x475, (float)x478, x481, x482, x485, x486);
   return caml_copy_double(x489);
}
value owl_stub_27_cblas_sdsdot_byte6(value* argv, int argc)
{
   value x490 = argv[5];
   value x491 = argv[4];
   value x492 = argv[3];
   value x493 = argv[2];
   value x494 = argv[1];
   value x495 = argv[0];
   return owl_stub_27_cblas_sdsdot(x495, x494, x493, x492, x491, x490);
}
value owl_stub_28_cblas_dsdot(value x500, value x499, value x498, value x497,
                              value x496)
{
   int x501 = Long_val(x500);
   float* x504 = CTYPES_ADDR_OF_FATPTR(x499);
   int x505 = Long_val(x498);
   float* x508 = CTYPES_ADDR_OF_FATPTR(x497);
   int x509 = Long_val(x496);
   double x512 = cblas_dsdot(x501, x504, x505, x508, x509);
   return caml_copy_double(x512);
}
value owl_stub_29_cblas_cdotu_sub(value x518, value x517, value x516,
                                  value x515, value x514, value x513)
{
   int x519 = Long_val(x518);
   float _Complex* x522 = CTYPES_ADDR_OF_FATPTR(x517);
   int x523 = Long_val(x516);
   float _Complex* x526 = CTYPES_ADDR_OF_FATPTR(x515);
   int x527 = Long_val(x514);
   float _Complex* x530 = CTYPES_ADDR_OF_FATPTR(x513);
   cblas_cdotu_sub(x519, x522, x523, x526, x527, x530);
   return Val_unit;
}
value owl_stub_29_cblas_cdotu_sub_byte6(value* argv, int argc)
{
   value x532 = argv[5];
   value x533 = argv[4];
   value x534 = argv[3];
   value x535 = argv[2];
   value x536 = argv[1];
   value x537 = argv[0];
   return owl_stub_29_cblas_cdotu_sub(x537, x536, x535, x534, x533, x532);
}
value owl_stub_30_cblas_cdotc_sub(value x543, value x542, value x541,
                                  value x540, value x539, value x538)
{
   int x544 = Long_val(x543);
   float _Complex* x547 = CTYPES_ADDR_OF_FATPTR(x542);
   int x548 = Long_val(x541);
   float _Complex* x551 = CTYPES_ADDR_OF_FATPTR(x540);
   int x552 = Long_val(x539);
   float _Complex* x555 = CTYPES_ADDR_OF_FATPTR(x538);
   cblas_cdotc_sub(x544, x547, x548, x551, x552, x555);
   return Val_unit;
}
value owl_stub_30_cblas_cdotc_sub_byte6(value* argv, int argc)
{
   value x557 = argv[5];
   value x558 = argv[4];
   value x559 = argv[3];
   value x560 = argv[2];
   value x561 = argv[1];
   value x562 = argv[0];
   return owl_stub_30_cblas_cdotc_sub(x562, x561, x560, x559, x558, x557);
}
value owl_stub_31_cblas_zdotu_sub(value x568, value x567, value x566,
                                  value x565, value x564, value x563)
{
   int x569 = Long_val(x568);
   double _Complex* x572 = CTYPES_ADDR_OF_FATPTR(x567);
   int x573 = Long_val(x566);
   double _Complex* x576 = CTYPES_ADDR_OF_FATPTR(x565);
   int x577 = Long_val(x564);
   double _Complex* x580 = CTYPES_ADDR_OF_FATPTR(x563);
   cblas_zdotu_sub(x569, x572, x573, x576, x577, x580);
   return Val_unit;
}
value owl_stub_31_cblas_zdotu_sub_byte6(value* argv, int argc)
{
   value x582 = argv[5];
   value x583 = argv[4];
   value x584 = argv[3];
   value x585 = argv[2];
   value x586 = argv[1];
   value x587 = argv[0];
   return owl_stub_31_cblas_zdotu_sub(x587, x586, x585, x584, x583, x582);
}
value owl_stub_32_cblas_zdotc_sub(value x593, value x592, value x591,
                                  value x590, value x589, value x588)
{
   int x594 = Long_val(x593);
   double _Complex* x597 = CTYPES_ADDR_OF_FATPTR(x592);
   int x598 = Long_val(x591);
   double _Complex* x601 = CTYPES_ADDR_OF_FATPTR(x590);
   int x602 = Long_val(x589);
   double _Complex* x605 = CTYPES_ADDR_OF_FATPTR(x588);
   cblas_zdotc_sub(x594, x597, x598, x601, x602, x605);
   return Val_unit;
}
value owl_stub_32_cblas_zdotc_sub_byte6(value* argv, int argc)
{
   value x607 = argv[5];
   value x608 = argv[4];
   value x609 = argv[3];
   value x610 = argv[2];
   value x611 = argv[1];
   value x612 = argv[0];
   return owl_stub_32_cblas_zdotc_sub(x612, x611, x610, x609, x608, x607);
}
value owl_stub_33_cblas_snrm2(value x615, value x614, value x613)
{
   int x616 = Long_val(x615);
   float* x619 = CTYPES_ADDR_OF_FATPTR(x614);
   int x620 = Long_val(x613);
   float x623 = cblas_snrm2(x616, x619, x620);
   return caml_copy_double(x623);
}
value owl_stub_34_cblas_dnrm2(value x626, value x625, value x624)
{
   int x627 = Long_val(x626);
   double* x630 = CTYPES_ADDR_OF_FATPTR(x625);
   int x631 = Long_val(x624);
   double x634 = cblas_dnrm2(x627, x630, x631);
   return caml_copy_double(x634);
}
value owl_stub_35_cblas_scnrm2(value x637, value x636, value x635)
{
   int x638 = Long_val(x637);
   float _Complex* x641 = CTYPES_ADDR_OF_FATPTR(x636);
   int x642 = Long_val(x635);
   float x645 = cblas_scnrm2(x638, x641, x642);
   return caml_copy_double(x645);
}
value owl_stub_36_cblas_dznrm2(value x648, value x647, value x646)
{
   int x649 = Long_val(x648);
   double _Complex* x652 = CTYPES_ADDR_OF_FATPTR(x647);
   int x653 = Long_val(x646);
   double x656 = cblas_dznrm2(x649, x652, x653);
   return caml_copy_double(x656);
}
value owl_stub_37_cblas_sasum(value x659, value x658, value x657)
{
   int x660 = Long_val(x659);
   float* x663 = CTYPES_ADDR_OF_FATPTR(x658);
   int x664 = Long_val(x657);
   float x667 = cblas_sasum(x660, x663, x664);
   return caml_copy_double(x667);
}
value owl_stub_38_cblas_dasum(value x670, value x669, value x668)
{
   int x671 = Long_val(x670);
   double* x674 = CTYPES_ADDR_OF_FATPTR(x669);
   int x675 = Long_val(x668);
   double x678 = cblas_dasum(x671, x674, x675);
   return caml_copy_double(x678);
}
value owl_stub_39_cblas_scasum(value x681, value x680, value x679)
{
   int x682 = Long_val(x681);
   float _Complex* x685 = CTYPES_ADDR_OF_FATPTR(x680);
   int x686 = Long_val(x679);
   float x689 = cblas_scasum(x682, x685, x686);
   return caml_copy_double(x689);
}
value owl_stub_40_cblas_dzasum(value x692, value x691, value x690)
{
   int x693 = Long_val(x692);
   double _Complex* x696 = CTYPES_ADDR_OF_FATPTR(x691);
   int x697 = Long_val(x690);
   double x700 = cblas_dzasum(x693, x696, x697);
   return caml_copy_double(x700);
}
value owl_stub_41_cblas_isamax(value x703, value x702, value x701)
{
   int x704 = Long_val(x703);
   float* x707 = CTYPES_ADDR_OF_FATPTR(x702);
   int x708 = Long_val(x701);
   size_t x711 = cblas_isamax(x704, x707, x708);
   return ctypes_copy_size_t(x711);
}
value owl_stub_42_cblas_idamax(value x714, value x713, value x712)
{
   int x715 = Long_val(x714);
   double* x718 = CTYPES_ADDR_OF_FATPTR(x713);
   int x719 = Long_val(x712);
   size_t x722 = cblas_idamax(x715, x718, x719);
   return ctypes_copy_size_t(x722);
}
value owl_stub_43_cblas_icamax(value x725, value x724, value x723)
{
   int x726 = Long_val(x725);
   float _Complex* x729 = CTYPES_ADDR_OF_FATPTR(x724);
   int x730 = Long_val(x723);
   size_t x733 = cblas_icamax(x726, x729, x730);
   return ctypes_copy_size_t(x733);
}
value owl_stub_44_cblas_izamax(value x736, value x735, value x734)
{
   int x737 = Long_val(x736);
   double _Complex* x740 = CTYPES_ADDR_OF_FATPTR(x735);
   int x741 = Long_val(x734);
   size_t x744 = cblas_izamax(x737, x740, x741);
   return ctypes_copy_size_t(x744);
}
value owl_stub_45_cblas_sgemv(value x756, value x755, value x754, value x753,
                              value x752, value x751, value x750, value x749,
                              value x748, value x747, value x746, value x745)
{
   int x757 = Long_val(x756);
   int x760 = Long_val(x755);
   int x763 = Long_val(x754);
   int x766 = Long_val(x753);
   double x769 = Double_val(x752);
   float* x772 = CTYPES_ADDR_OF_FATPTR(x751);
   int x773 = Long_val(x750);
   float* x776 = CTYPES_ADDR_OF_FATPTR(x749);
   int x777 = Long_val(x748);
   double x780 = Double_val(x747);
   float* x783 = CTYPES_ADDR_OF_FATPTR(x746);
   int x784 = Long_val(x745);
   cblas_sgemv(x757, x760, x763, x766, (float)x769, x772, x773, x776, 
               x777, (float)x780, x783, x784);
   return Val_unit;
}
value owl_stub_45_cblas_sgemv_byte12(value* argv, int argc)
{
   value x788 = argv[11];
   value x789 = argv[10];
   value x790 = argv[9];
   value x791 = argv[8];
   value x792 = argv[7];
   value x793 = argv[6];
   value x794 = argv[5];
   value x795 = argv[4];
   value x796 = argv[3];
   value x797 = argv[2];
   value x798 = argv[1];
   value x799 = argv[0];
   return
     owl_stub_45_cblas_sgemv(x799, x798, x797, x796, x795, x794, x793, 
                             x792, x791, x790, x789, x788);
}
value owl_stub_46_cblas_dgemv(value x811, value x810, value x809, value x808,
                              value x807, value x806, value x805, value x804,
                              value x803, value x802, value x801, value x800)
{
   int x812 = Long_val(x811);
   int x815 = Long_val(x810);
   int x818 = Long_val(x809);
   int x821 = Long_val(x808);
   double x824 = Double_val(x807);
   double* x827 = CTYPES_ADDR_OF_FATPTR(x806);
   int x828 = Long_val(x805);
   double* x831 = CTYPES_ADDR_OF_FATPTR(x804);
   int x832 = Long_val(x803);
   double x835 = Double_val(x802);
   double* x838 = CTYPES_ADDR_OF_FATPTR(x801);
   int x839 = Long_val(x800);
   cblas_dgemv(x812, x815, x818, x821, x824, x827, x828, x831, x832, 
               x835, x838, x839);
   return Val_unit;
}
value owl_stub_46_cblas_dgemv_byte12(value* argv, int argc)
{
   value x843 = argv[11];
   value x844 = argv[10];
   value x845 = argv[9];
   value x846 = argv[8];
   value x847 = argv[7];
   value x848 = argv[6];
   value x849 = argv[5];
   value x850 = argv[4];
   value x851 = argv[3];
   value x852 = argv[2];
   value x853 = argv[1];
   value x854 = argv[0];
   return
     owl_stub_46_cblas_dgemv(x854, x853, x852, x851, x850, x849, x848, 
                             x847, x846, x845, x844, x843);
}
value owl_stub_47_cblas_cgemv(value x866, value x865, value x864, value x863,
                              value x862, value x861, value x860, value x859,
                              value x858, value x857, value x856, value x855)
{
   int x867 = Long_val(x866);
   int x870 = Long_val(x865);
   int x873 = Long_val(x864);
   int x876 = Long_val(x863);
   float _Complex* x879 = CTYPES_ADDR_OF_FATPTR(x862);
   float _Complex* x880 = CTYPES_ADDR_OF_FATPTR(x861);
   int x881 = Long_val(x860);
   float _Complex* x884 = CTYPES_ADDR_OF_FATPTR(x859);
   int x885 = Long_val(x858);
   float _Complex* x888 = CTYPES_ADDR_OF_FATPTR(x857);
   float _Complex* x889 = CTYPES_ADDR_OF_FATPTR(x856);
   int x890 = Long_val(x855);
   cblas_cgemv(x867, x870, x873, x876, x879, x880, x881, x884, x885, 
               x888, x889, x890);
   return Val_unit;
}
value owl_stub_47_cblas_cgemv_byte12(value* argv, int argc)
{
   value x894 = argv[11];
   value x895 = argv[10];
   value x896 = argv[9];
   value x897 = argv[8];
   value x898 = argv[7];
   value x899 = argv[6];
   value x900 = argv[5];
   value x901 = argv[4];
   value x902 = argv[3];
   value x903 = argv[2];
   value x904 = argv[1];
   value x905 = argv[0];
   return
     owl_stub_47_cblas_cgemv(x905, x904, x903, x902, x901, x900, x899, 
                             x898, x897, x896, x895, x894);
}
value owl_stub_48_cblas_zgemv(value x917, value x916, value x915, value x914,
                              value x913, value x912, value x911, value x910,
                              value x909, value x908, value x907, value x906)
{
   int x918 = Long_val(x917);
   int x921 = Long_val(x916);
   int x924 = Long_val(x915);
   int x927 = Long_val(x914);
   double _Complex* x930 = CTYPES_ADDR_OF_FATPTR(x913);
   double _Complex* x931 = CTYPES_ADDR_OF_FATPTR(x912);
   int x932 = Long_val(x911);
   double _Complex* x935 = CTYPES_ADDR_OF_FATPTR(x910);
   int x936 = Long_val(x909);
   double _Complex* x939 = CTYPES_ADDR_OF_FATPTR(x908);
   double _Complex* x940 = CTYPES_ADDR_OF_FATPTR(x907);
   int x941 = Long_val(x906);
   cblas_zgemv(x918, x921, x924, x927, x930, x931, x932, x935, x936, 
               x939, x940, x941);
   return Val_unit;
}
value owl_stub_48_cblas_zgemv_byte12(value* argv, int argc)
{
   value x945 = argv[11];
   value x946 = argv[10];
   value x947 = argv[9];
   value x948 = argv[8];
   value x949 = argv[7];
   value x950 = argv[6];
   value x951 = argv[5];
   value x952 = argv[4];
   value x953 = argv[3];
   value x954 = argv[2];
   value x955 = argv[1];
   value x956 = argv[0];
   return
     owl_stub_48_cblas_zgemv(x956, x955, x954, x953, x952, x951, x950, 
                             x949, x948, x947, x946, x945);
}
value owl_stub_49_cblas_sgbmv(value x970, value x969, value x968, value x967,
                              value x966, value x965, value x964, value x963,
                              value x962, value x961, value x960, value x959,
                              value x958, value x957)
{
   int x971 = Long_val(x970);
   int x974 = Long_val(x969);
   int x977 = Long_val(x968);
   int x980 = Long_val(x967);
   int x983 = Long_val(x966);
   int x986 = Long_val(x965);
   double x989 = Double_val(x964);
   float* x992 = CTYPES_ADDR_OF_FATPTR(x963);
   int x993 = Long_val(x962);
   float* x996 = CTYPES_ADDR_OF_FATPTR(x961);
   int x997 = Long_val(x960);
   double x1000 = Double_val(x959);
   float* x1003 = CTYPES_ADDR_OF_FATPTR(x958);
   int x1004 = Long_val(x957);
   cblas_sgbmv(x971, x974, x977, x980, x983, x986, (float)x989, x992, 
               x993, x996, x997, (float)x1000, x1003, x1004);
   return Val_unit;
}
value owl_stub_49_cblas_sgbmv_byte14(value* argv, int argc)
{
   value x1008 = argv[13];
   value x1009 = argv[12];
   value x1010 = argv[11];
   value x1011 = argv[10];
   value x1012 = argv[9];
   value x1013 = argv[8];
   value x1014 = argv[7];
   value x1015 = argv[6];
   value x1016 = argv[5];
   value x1017 = argv[4];
   value x1018 = argv[3];
   value x1019 = argv[2];
   value x1020 = argv[1];
   value x1021 = argv[0];
   return
     owl_stub_49_cblas_sgbmv(x1021, x1020, x1019, x1018, x1017, x1016, 
                             x1015, x1014, x1013, x1012, x1011, x1010, 
                             x1009, x1008);
}
value owl_stub_50_cblas_dgbmv(value x1035, value x1034, value x1033,
                              value x1032, value x1031, value x1030,
                              value x1029, value x1028, value x1027,
                              value x1026, value x1025, value x1024,
                              value x1023, value x1022)
{
   int x1036 = Long_val(x1035);
   int x1039 = Long_val(x1034);
   int x1042 = Long_val(x1033);
   int x1045 = Long_val(x1032);
   int x1048 = Long_val(x1031);
   int x1051 = Long_val(x1030);
   double x1054 = Double_val(x1029);
   double* x1057 = CTYPES_ADDR_OF_FATPTR(x1028);
   int x1058 = Long_val(x1027);
   double* x1061 = CTYPES_ADDR_OF_FATPTR(x1026);
   int x1062 = Long_val(x1025);
   double x1065 = Double_val(x1024);
   double* x1068 = CTYPES_ADDR_OF_FATPTR(x1023);
   int x1069 = Long_val(x1022);
   cblas_dgbmv(x1036, x1039, x1042, x1045, x1048, x1051, x1054, x1057, 
               x1058, x1061, x1062, x1065, x1068, x1069);
   return Val_unit;
}
value owl_stub_50_cblas_dgbmv_byte14(value* argv, int argc)
{
   value x1073 = argv[13];
   value x1074 = argv[12];
   value x1075 = argv[11];
   value x1076 = argv[10];
   value x1077 = argv[9];
   value x1078 = argv[8];
   value x1079 = argv[7];
   value x1080 = argv[6];
   value x1081 = argv[5];
   value x1082 = argv[4];
   value x1083 = argv[3];
   value x1084 = argv[2];
   value x1085 = argv[1];
   value x1086 = argv[0];
   return
     owl_stub_50_cblas_dgbmv(x1086, x1085, x1084, x1083, x1082, x1081, 
                             x1080, x1079, x1078, x1077, x1076, x1075, 
                             x1074, x1073);
}
value owl_stub_51_cblas_cgbmv(value x1100, value x1099, value x1098,
                              value x1097, value x1096, value x1095,
                              value x1094, value x1093, value x1092,
                              value x1091, value x1090, value x1089,
                              value x1088, value x1087)
{
   int x1101 = Long_val(x1100);
   int x1104 = Long_val(x1099);
   int x1107 = Long_val(x1098);
   int x1110 = Long_val(x1097);
   int x1113 = Long_val(x1096);
   int x1116 = Long_val(x1095);
   float _Complex* x1119 = CTYPES_ADDR_OF_FATPTR(x1094);
   float _Complex* x1120 = CTYPES_ADDR_OF_FATPTR(x1093);
   int x1121 = Long_val(x1092);
   float _Complex* x1124 = CTYPES_ADDR_OF_FATPTR(x1091);
   int x1125 = Long_val(x1090);
   float _Complex* x1128 = CTYPES_ADDR_OF_FATPTR(x1089);
   float _Complex* x1129 = CTYPES_ADDR_OF_FATPTR(x1088);
   int x1130 = Long_val(x1087);
   cblas_cgbmv(x1101, x1104, x1107, x1110, x1113, x1116, x1119, x1120, 
               x1121, x1124, x1125, x1128, x1129, x1130);
   return Val_unit;
}
value owl_stub_51_cblas_cgbmv_byte14(value* argv, int argc)
{
   value x1134 = argv[13];
   value x1135 = argv[12];
   value x1136 = argv[11];
   value x1137 = argv[10];
   value x1138 = argv[9];
   value x1139 = argv[8];
   value x1140 = argv[7];
   value x1141 = argv[6];
   value x1142 = argv[5];
   value x1143 = argv[4];
   value x1144 = argv[3];
   value x1145 = argv[2];
   value x1146 = argv[1];
   value x1147 = argv[0];
   return
     owl_stub_51_cblas_cgbmv(x1147, x1146, x1145, x1144, x1143, x1142, 
                             x1141, x1140, x1139, x1138, x1137, x1136, 
                             x1135, x1134);
}
value owl_stub_52_cblas_zgbmv(value x1161, value x1160, value x1159,
                              value x1158, value x1157, value x1156,
                              value x1155, value x1154, value x1153,
                              value x1152, value x1151, value x1150,
                              value x1149, value x1148)
{
   int x1162 = Long_val(x1161);
   int x1165 = Long_val(x1160);
   int x1168 = Long_val(x1159);
   int x1171 = Long_val(x1158);
   int x1174 = Long_val(x1157);
   int x1177 = Long_val(x1156);
   double _Complex* x1180 = CTYPES_ADDR_OF_FATPTR(x1155);
   double _Complex* x1181 = CTYPES_ADDR_OF_FATPTR(x1154);
   int x1182 = Long_val(x1153);
   double _Complex* x1185 = CTYPES_ADDR_OF_FATPTR(x1152);
   int x1186 = Long_val(x1151);
   double _Complex* x1189 = CTYPES_ADDR_OF_FATPTR(x1150);
   double _Complex* x1190 = CTYPES_ADDR_OF_FATPTR(x1149);
   int x1191 = Long_val(x1148);
   cblas_zgbmv(x1162, x1165, x1168, x1171, x1174, x1177, x1180, x1181, 
               x1182, x1185, x1186, x1189, x1190, x1191);
   return Val_unit;
}
value owl_stub_52_cblas_zgbmv_byte14(value* argv, int argc)
{
   value x1195 = argv[13];
   value x1196 = argv[12];
   value x1197 = argv[11];
   value x1198 = argv[10];
   value x1199 = argv[9];
   value x1200 = argv[8];
   value x1201 = argv[7];
   value x1202 = argv[6];
   value x1203 = argv[5];
   value x1204 = argv[4];
   value x1205 = argv[3];
   value x1206 = argv[2];
   value x1207 = argv[1];
   value x1208 = argv[0];
   return
     owl_stub_52_cblas_zgbmv(x1208, x1207, x1206, x1205, x1204, x1203, 
                             x1202, x1201, x1200, x1199, x1198, x1197, 
                             x1196, x1195);
}
value owl_stub_53_cblas_strmv(value x1217, value x1216, value x1215,
                              value x1214, value x1213, value x1212,
                              value x1211, value x1210, value x1209)
{
   int x1218 = Long_val(x1217);
   int x1221 = Long_val(x1216);
   int x1224 = Long_val(x1215);
   int x1227 = Long_val(x1214);
   int x1230 = Long_val(x1213);
   float* x1233 = CTYPES_ADDR_OF_FATPTR(x1212);
   int x1234 = Long_val(x1211);
   float* x1237 = CTYPES_ADDR_OF_FATPTR(x1210);
   int x1238 = Long_val(x1209);
   cblas_strmv(x1218, x1221, x1224, x1227, x1230, x1233, x1234, x1237, x1238);
   return Val_unit;
}
value owl_stub_53_cblas_strmv_byte9(value* argv, int argc)
{
   value x1242 = argv[8];
   value x1243 = argv[7];
   value x1244 = argv[6];
   value x1245 = argv[5];
   value x1246 = argv[4];
   value x1247 = argv[3];
   value x1248 = argv[2];
   value x1249 = argv[1];
   value x1250 = argv[0];
   return
     owl_stub_53_cblas_strmv(x1250, x1249, x1248, x1247, x1246, x1245, 
                             x1244, x1243, x1242);
}
value owl_stub_54_cblas_dtrmv(value x1259, value x1258, value x1257,
                              value x1256, value x1255, value x1254,
                              value x1253, value x1252, value x1251)
{
   int x1260 = Long_val(x1259);
   int x1263 = Long_val(x1258);
   int x1266 = Long_val(x1257);
   int x1269 = Long_val(x1256);
   int x1272 = Long_val(x1255);
   double* x1275 = CTYPES_ADDR_OF_FATPTR(x1254);
   int x1276 = Long_val(x1253);
   double* x1279 = CTYPES_ADDR_OF_FATPTR(x1252);
   int x1280 = Long_val(x1251);
   cblas_dtrmv(x1260, x1263, x1266, x1269, x1272, x1275, x1276, x1279, x1280);
   return Val_unit;
}
value owl_stub_54_cblas_dtrmv_byte9(value* argv, int argc)
{
   value x1284 = argv[8];
   value x1285 = argv[7];
   value x1286 = argv[6];
   value x1287 = argv[5];
   value x1288 = argv[4];
   value x1289 = argv[3];
   value x1290 = argv[2];
   value x1291 = argv[1];
   value x1292 = argv[0];
   return
     owl_stub_54_cblas_dtrmv(x1292, x1291, x1290, x1289, x1288, x1287, 
                             x1286, x1285, x1284);
}
value owl_stub_55_cblas_ctrmv(value x1301, value x1300, value x1299,
                              value x1298, value x1297, value x1296,
                              value x1295, value x1294, value x1293)
{
   int x1302 = Long_val(x1301);
   int x1305 = Long_val(x1300);
   int x1308 = Long_val(x1299);
   int x1311 = Long_val(x1298);
   int x1314 = Long_val(x1297);
   float _Complex* x1317 = CTYPES_ADDR_OF_FATPTR(x1296);
   int x1318 = Long_val(x1295);
   float _Complex* x1321 = CTYPES_ADDR_OF_FATPTR(x1294);
   int x1322 = Long_val(x1293);
   cblas_ctrmv(x1302, x1305, x1308, x1311, x1314, x1317, x1318, x1321, x1322);
   return Val_unit;
}
value owl_stub_55_cblas_ctrmv_byte9(value* argv, int argc)
{
   value x1326 = argv[8];
   value x1327 = argv[7];
   value x1328 = argv[6];
   value x1329 = argv[5];
   value x1330 = argv[4];
   value x1331 = argv[3];
   value x1332 = argv[2];
   value x1333 = argv[1];
   value x1334 = argv[0];
   return
     owl_stub_55_cblas_ctrmv(x1334, x1333, x1332, x1331, x1330, x1329, 
                             x1328, x1327, x1326);
}
value owl_stub_56_cblas_ztrmv(value x1343, value x1342, value x1341,
                              value x1340, value x1339, value x1338,
                              value x1337, value x1336, value x1335)
{
   int x1344 = Long_val(x1343);
   int x1347 = Long_val(x1342);
   int x1350 = Long_val(x1341);
   int x1353 = Long_val(x1340);
   int x1356 = Long_val(x1339);
   double _Complex* x1359 = CTYPES_ADDR_OF_FATPTR(x1338);
   int x1360 = Long_val(x1337);
   double _Complex* x1363 = CTYPES_ADDR_OF_FATPTR(x1336);
   int x1364 = Long_val(x1335);
   cblas_ztrmv(x1344, x1347, x1350, x1353, x1356, x1359, x1360, x1363, x1364);
   return Val_unit;
}
value owl_stub_56_cblas_ztrmv_byte9(value* argv, int argc)
{
   value x1368 = argv[8];
   value x1369 = argv[7];
   value x1370 = argv[6];
   value x1371 = argv[5];
   value x1372 = argv[4];
   value x1373 = argv[3];
   value x1374 = argv[2];
   value x1375 = argv[1];
   value x1376 = argv[0];
   return
     owl_stub_56_cblas_ztrmv(x1376, x1375, x1374, x1373, x1372, x1371, 
                             x1370, x1369, x1368);
}
value owl_stub_57_cblas_stbmv(value x1386, value x1385, value x1384,
                              value x1383, value x1382, value x1381,
                              value x1380, value x1379, value x1378,
                              value x1377)
{
   int x1387 = Long_val(x1386);
   int x1390 = Long_val(x1385);
   int x1393 = Long_val(x1384);
   int x1396 = Long_val(x1383);
   int x1399 = Long_val(x1382);
   int x1402 = Long_val(x1381);
   float* x1405 = CTYPES_ADDR_OF_FATPTR(x1380);
   int x1406 = Long_val(x1379);
   float* x1409 = CTYPES_ADDR_OF_FATPTR(x1378);
   int x1410 = Long_val(x1377);
   cblas_stbmv(x1387, x1390, x1393, x1396, x1399, x1402, x1405, x1406, 
               x1409, x1410);
   return Val_unit;
}
value owl_stub_57_cblas_stbmv_byte10(value* argv, int argc)
{
   value x1414 = argv[9];
   value x1415 = argv[8];
   value x1416 = argv[7];
   value x1417 = argv[6];
   value x1418 = argv[5];
   value x1419 = argv[4];
   value x1420 = argv[3];
   value x1421 = argv[2];
   value x1422 = argv[1];
   value x1423 = argv[0];
   return
     owl_stub_57_cblas_stbmv(x1423, x1422, x1421, x1420, x1419, x1418, 
                             x1417, x1416, x1415, x1414);
}
value owl_stub_58_cblas_dtbmv(value x1433, value x1432, value x1431,
                              value x1430, value x1429, value x1428,
                              value x1427, value x1426, value x1425,
                              value x1424)
{
   int x1434 = Long_val(x1433);
   int x1437 = Long_val(x1432);
   int x1440 = Long_val(x1431);
   int x1443 = Long_val(x1430);
   int x1446 = Long_val(x1429);
   int x1449 = Long_val(x1428);
   double* x1452 = CTYPES_ADDR_OF_FATPTR(x1427);
   int x1453 = Long_val(x1426);
   double* x1456 = CTYPES_ADDR_OF_FATPTR(x1425);
   int x1457 = Long_val(x1424);
   cblas_dtbmv(x1434, x1437, x1440, x1443, x1446, x1449, x1452, x1453, 
               x1456, x1457);
   return Val_unit;
}
value owl_stub_58_cblas_dtbmv_byte10(value* argv, int argc)
{
   value x1461 = argv[9];
   value x1462 = argv[8];
   value x1463 = argv[7];
   value x1464 = argv[6];
   value x1465 = argv[5];
   value x1466 = argv[4];
   value x1467 = argv[3];
   value x1468 = argv[2];
   value x1469 = argv[1];
   value x1470 = argv[0];
   return
     owl_stub_58_cblas_dtbmv(x1470, x1469, x1468, x1467, x1466, x1465, 
                             x1464, x1463, x1462, x1461);
}
value owl_stub_59_cblas_ctbmv(value x1480, value x1479, value x1478,
                              value x1477, value x1476, value x1475,
                              value x1474, value x1473, value x1472,
                              value x1471)
{
   int x1481 = Long_val(x1480);
   int x1484 = Long_val(x1479);
   int x1487 = Long_val(x1478);
   int x1490 = Long_val(x1477);
   int x1493 = Long_val(x1476);
   int x1496 = Long_val(x1475);
   float _Complex* x1499 = CTYPES_ADDR_OF_FATPTR(x1474);
   int x1500 = Long_val(x1473);
   float _Complex* x1503 = CTYPES_ADDR_OF_FATPTR(x1472);
   int x1504 = Long_val(x1471);
   cblas_ctbmv(x1481, x1484, x1487, x1490, x1493, x1496, x1499, x1500, 
               x1503, x1504);
   return Val_unit;
}
value owl_stub_59_cblas_ctbmv_byte10(value* argv, int argc)
{
   value x1508 = argv[9];
   value x1509 = argv[8];
   value x1510 = argv[7];
   value x1511 = argv[6];
   value x1512 = argv[5];
   value x1513 = argv[4];
   value x1514 = argv[3];
   value x1515 = argv[2];
   value x1516 = argv[1];
   value x1517 = argv[0];
   return
     owl_stub_59_cblas_ctbmv(x1517, x1516, x1515, x1514, x1513, x1512, 
                             x1511, x1510, x1509, x1508);
}
value owl_stub_60_cblas_ztbmv(value x1527, value x1526, value x1525,
                              value x1524, value x1523, value x1522,
                              value x1521, value x1520, value x1519,
                              value x1518)
{
   int x1528 = Long_val(x1527);
   int x1531 = Long_val(x1526);
   int x1534 = Long_val(x1525);
   int x1537 = Long_val(x1524);
   int x1540 = Long_val(x1523);
   int x1543 = Long_val(x1522);
   double _Complex* x1546 = CTYPES_ADDR_OF_FATPTR(x1521);
   int x1547 = Long_val(x1520);
   double _Complex* x1550 = CTYPES_ADDR_OF_FATPTR(x1519);
   int x1551 = Long_val(x1518);
   cblas_ztbmv(x1528, x1531, x1534, x1537, x1540, x1543, x1546, x1547, 
               x1550, x1551);
   return Val_unit;
}
value owl_stub_60_cblas_ztbmv_byte10(value* argv, int argc)
{
   value x1555 = argv[9];
   value x1556 = argv[8];
   value x1557 = argv[7];
   value x1558 = argv[6];
   value x1559 = argv[5];
   value x1560 = argv[4];
   value x1561 = argv[3];
   value x1562 = argv[2];
   value x1563 = argv[1];
   value x1564 = argv[0];
   return
     owl_stub_60_cblas_ztbmv(x1564, x1563, x1562, x1561, x1560, x1559, 
                             x1558, x1557, x1556, x1555);
}
value owl_stub_61_cblas_stpmv(value x1572, value x1571, value x1570,
                              value x1569, value x1568, value x1567,
                              value x1566, value x1565)
{
   int x1573 = Long_val(x1572);
   int x1576 = Long_val(x1571);
   int x1579 = Long_val(x1570);
   int x1582 = Long_val(x1569);
   int x1585 = Long_val(x1568);
   float* x1588 = CTYPES_ADDR_OF_FATPTR(x1567);
   float* x1589 = CTYPES_ADDR_OF_FATPTR(x1566);
   int x1590 = Long_val(x1565);
   cblas_stpmv(x1573, x1576, x1579, x1582, x1585, x1588, x1589, x1590);
   return Val_unit;
}
value owl_stub_61_cblas_stpmv_byte8(value* argv, int argc)
{
   value x1594 = argv[7];
   value x1595 = argv[6];
   value x1596 = argv[5];
   value x1597 = argv[4];
   value x1598 = argv[3];
   value x1599 = argv[2];
   value x1600 = argv[1];
   value x1601 = argv[0];
   return
     owl_stub_61_cblas_stpmv(x1601, x1600, x1599, x1598, x1597, x1596, 
                             x1595, x1594);
}
value owl_stub_62_cblas_dtpmv(value x1609, value x1608, value x1607,
                              value x1606, value x1605, value x1604,
                              value x1603, value x1602)
{
   int x1610 = Long_val(x1609);
   int x1613 = Long_val(x1608);
   int x1616 = Long_val(x1607);
   int x1619 = Long_val(x1606);
   int x1622 = Long_val(x1605);
   double* x1625 = CTYPES_ADDR_OF_FATPTR(x1604);
   double* x1626 = CTYPES_ADDR_OF_FATPTR(x1603);
   int x1627 = Long_val(x1602);
   cblas_dtpmv(x1610, x1613, x1616, x1619, x1622, x1625, x1626, x1627);
   return Val_unit;
}
value owl_stub_62_cblas_dtpmv_byte8(value* argv, int argc)
{
   value x1631 = argv[7];
   value x1632 = argv[6];
   value x1633 = argv[5];
   value x1634 = argv[4];
   value x1635 = argv[3];
   value x1636 = argv[2];
   value x1637 = argv[1];
   value x1638 = argv[0];
   return
     owl_stub_62_cblas_dtpmv(x1638, x1637, x1636, x1635, x1634, x1633, 
                             x1632, x1631);
}
value owl_stub_63_cblas_ctpmv(value x1646, value x1645, value x1644,
                              value x1643, value x1642, value x1641,
                              value x1640, value x1639)
{
   int x1647 = Long_val(x1646);
   int x1650 = Long_val(x1645);
   int x1653 = Long_val(x1644);
   int x1656 = Long_val(x1643);
   int x1659 = Long_val(x1642);
   float _Complex* x1662 = CTYPES_ADDR_OF_FATPTR(x1641);
   float _Complex* x1663 = CTYPES_ADDR_OF_FATPTR(x1640);
   int x1664 = Long_val(x1639);
   cblas_ctpmv(x1647, x1650, x1653, x1656, x1659, x1662, x1663, x1664);
   return Val_unit;
}
value owl_stub_63_cblas_ctpmv_byte8(value* argv, int argc)
{
   value x1668 = argv[7];
   value x1669 = argv[6];
   value x1670 = argv[5];
   value x1671 = argv[4];
   value x1672 = argv[3];
   value x1673 = argv[2];
   value x1674 = argv[1];
   value x1675 = argv[0];
   return
     owl_stub_63_cblas_ctpmv(x1675, x1674, x1673, x1672, x1671, x1670, 
                             x1669, x1668);
}
value owl_stub_64_cblas_ztpmv(value x1683, value x1682, value x1681,
                              value x1680, value x1679, value x1678,
                              value x1677, value x1676)
{
   int x1684 = Long_val(x1683);
   int x1687 = Long_val(x1682);
   int x1690 = Long_val(x1681);
   int x1693 = Long_val(x1680);
   int x1696 = Long_val(x1679);
   double _Complex* x1699 = CTYPES_ADDR_OF_FATPTR(x1678);
   double _Complex* x1700 = CTYPES_ADDR_OF_FATPTR(x1677);
   int x1701 = Long_val(x1676);
   cblas_ztpmv(x1684, x1687, x1690, x1693, x1696, x1699, x1700, x1701);
   return Val_unit;
}
value owl_stub_64_cblas_ztpmv_byte8(value* argv, int argc)
{
   value x1705 = argv[7];
   value x1706 = argv[6];
   value x1707 = argv[5];
   value x1708 = argv[4];
   value x1709 = argv[3];
   value x1710 = argv[2];
   value x1711 = argv[1];
   value x1712 = argv[0];
   return
     owl_stub_64_cblas_ztpmv(x1712, x1711, x1710, x1709, x1708, x1707, 
                             x1706, x1705);
}
value owl_stub_65_cblas_strsv(value x1721, value x1720, value x1719,
                              value x1718, value x1717, value x1716,
                              value x1715, value x1714, value x1713)
{
   int x1722 = Long_val(x1721);
   int x1725 = Long_val(x1720);
   int x1728 = Long_val(x1719);
   int x1731 = Long_val(x1718);
   int x1734 = Long_val(x1717);
   float* x1737 = CTYPES_ADDR_OF_FATPTR(x1716);
   int x1738 = Long_val(x1715);
   float* x1741 = CTYPES_ADDR_OF_FATPTR(x1714);
   int x1742 = Long_val(x1713);
   cblas_strsv(x1722, x1725, x1728, x1731, x1734, x1737, x1738, x1741, x1742);
   return Val_unit;
}
value owl_stub_65_cblas_strsv_byte9(value* argv, int argc)
{
   value x1746 = argv[8];
   value x1747 = argv[7];
   value x1748 = argv[6];
   value x1749 = argv[5];
   value x1750 = argv[4];
   value x1751 = argv[3];
   value x1752 = argv[2];
   value x1753 = argv[1];
   value x1754 = argv[0];
   return
     owl_stub_65_cblas_strsv(x1754, x1753, x1752, x1751, x1750, x1749, 
                             x1748, x1747, x1746);
}
value owl_stub_66_cblas_dtrsv(value x1763, value x1762, value x1761,
                              value x1760, value x1759, value x1758,
                              value x1757, value x1756, value x1755)
{
   int x1764 = Long_val(x1763);
   int x1767 = Long_val(x1762);
   int x1770 = Long_val(x1761);
   int x1773 = Long_val(x1760);
   int x1776 = Long_val(x1759);
   double* x1779 = CTYPES_ADDR_OF_FATPTR(x1758);
   int x1780 = Long_val(x1757);
   double* x1783 = CTYPES_ADDR_OF_FATPTR(x1756);
   int x1784 = Long_val(x1755);
   cblas_dtrsv(x1764, x1767, x1770, x1773, x1776, x1779, x1780, x1783, x1784);
   return Val_unit;
}
value owl_stub_66_cblas_dtrsv_byte9(value* argv, int argc)
{
   value x1788 = argv[8];
   value x1789 = argv[7];
   value x1790 = argv[6];
   value x1791 = argv[5];
   value x1792 = argv[4];
   value x1793 = argv[3];
   value x1794 = argv[2];
   value x1795 = argv[1];
   value x1796 = argv[0];
   return
     owl_stub_66_cblas_dtrsv(x1796, x1795, x1794, x1793, x1792, x1791, 
                             x1790, x1789, x1788);
}
value owl_stub_67_cblas_ctrsv(value x1805, value x1804, value x1803,
                              value x1802, value x1801, value x1800,
                              value x1799, value x1798, value x1797)
{
   int x1806 = Long_val(x1805);
   int x1809 = Long_val(x1804);
   int x1812 = Long_val(x1803);
   int x1815 = Long_val(x1802);
   int x1818 = Long_val(x1801);
   float _Complex* x1821 = CTYPES_ADDR_OF_FATPTR(x1800);
   int x1822 = Long_val(x1799);
   float _Complex* x1825 = CTYPES_ADDR_OF_FATPTR(x1798);
   int x1826 = Long_val(x1797);
   cblas_ctrsv(x1806, x1809, x1812, x1815, x1818, x1821, x1822, x1825, x1826);
   return Val_unit;
}
value owl_stub_67_cblas_ctrsv_byte9(value* argv, int argc)
{
   value x1830 = argv[8];
   value x1831 = argv[7];
   value x1832 = argv[6];
   value x1833 = argv[5];
   value x1834 = argv[4];
   value x1835 = argv[3];
   value x1836 = argv[2];
   value x1837 = argv[1];
   value x1838 = argv[0];
   return
     owl_stub_67_cblas_ctrsv(x1838, x1837, x1836, x1835, x1834, x1833, 
                             x1832, x1831, x1830);
}
value owl_stub_68_cblas_ztrsv(value x1847, value x1846, value x1845,
                              value x1844, value x1843, value x1842,
                              value x1841, value x1840, value x1839)
{
   int x1848 = Long_val(x1847);
   int x1851 = Long_val(x1846);
   int x1854 = Long_val(x1845);
   int x1857 = Long_val(x1844);
   int x1860 = Long_val(x1843);
   double _Complex* x1863 = CTYPES_ADDR_OF_FATPTR(x1842);
   int x1864 = Long_val(x1841);
   double _Complex* x1867 = CTYPES_ADDR_OF_FATPTR(x1840);
   int x1868 = Long_val(x1839);
   cblas_ztrsv(x1848, x1851, x1854, x1857, x1860, x1863, x1864, x1867, x1868);
   return Val_unit;
}
value owl_stub_68_cblas_ztrsv_byte9(value* argv, int argc)
{
   value x1872 = argv[8];
   value x1873 = argv[7];
   value x1874 = argv[6];
   value x1875 = argv[5];
   value x1876 = argv[4];
   value x1877 = argv[3];
   value x1878 = argv[2];
   value x1879 = argv[1];
   value x1880 = argv[0];
   return
     owl_stub_68_cblas_ztrsv(x1880, x1879, x1878, x1877, x1876, x1875, 
                             x1874, x1873, x1872);
}
value owl_stub_69_cblas_stbsv(value x1890, value x1889, value x1888,
                              value x1887, value x1886, value x1885,
                              value x1884, value x1883, value x1882,
                              value x1881)
{
   int x1891 = Long_val(x1890);
   int x1894 = Long_val(x1889);
   int x1897 = Long_val(x1888);
   int x1900 = Long_val(x1887);
   int x1903 = Long_val(x1886);
   int x1906 = Long_val(x1885);
   float* x1909 = CTYPES_ADDR_OF_FATPTR(x1884);
   int x1910 = Long_val(x1883);
   float* x1913 = CTYPES_ADDR_OF_FATPTR(x1882);
   int x1914 = Long_val(x1881);
   cblas_stbsv(x1891, x1894, x1897, x1900, x1903, x1906, x1909, x1910, 
               x1913, x1914);
   return Val_unit;
}
value owl_stub_69_cblas_stbsv_byte10(value* argv, int argc)
{
   value x1918 = argv[9];
   value x1919 = argv[8];
   value x1920 = argv[7];
   value x1921 = argv[6];
   value x1922 = argv[5];
   value x1923 = argv[4];
   value x1924 = argv[3];
   value x1925 = argv[2];
   value x1926 = argv[1];
   value x1927 = argv[0];
   return
     owl_stub_69_cblas_stbsv(x1927, x1926, x1925, x1924, x1923, x1922, 
                             x1921, x1920, x1919, x1918);
}
value owl_stub_70_cblas_dtbsv(value x1937, value x1936, value x1935,
                              value x1934, value x1933, value x1932,
                              value x1931, value x1930, value x1929,
                              value x1928)
{
   int x1938 = Long_val(x1937);
   int x1941 = Long_val(x1936);
   int x1944 = Long_val(x1935);
   int x1947 = Long_val(x1934);
   int x1950 = Long_val(x1933);
   int x1953 = Long_val(x1932);
   double* x1956 = CTYPES_ADDR_OF_FATPTR(x1931);
   int x1957 = Long_val(x1930);
   double* x1960 = CTYPES_ADDR_OF_FATPTR(x1929);
   int x1961 = Long_val(x1928);
   cblas_dtbsv(x1938, x1941, x1944, x1947, x1950, x1953, x1956, x1957, 
               x1960, x1961);
   return Val_unit;
}
value owl_stub_70_cblas_dtbsv_byte10(value* argv, int argc)
{
   value x1965 = argv[9];
   value x1966 = argv[8];
   value x1967 = argv[7];
   value x1968 = argv[6];
   value x1969 = argv[5];
   value x1970 = argv[4];
   value x1971 = argv[3];
   value x1972 = argv[2];
   value x1973 = argv[1];
   value x1974 = argv[0];
   return
     owl_stub_70_cblas_dtbsv(x1974, x1973, x1972, x1971, x1970, x1969, 
                             x1968, x1967, x1966, x1965);
}
value owl_stub_71_cblas_ctbsv(value x1984, value x1983, value x1982,
                              value x1981, value x1980, value x1979,
                              value x1978, value x1977, value x1976,
                              value x1975)
{
   int x1985 = Long_val(x1984);
   int x1988 = Long_val(x1983);
   int x1991 = Long_val(x1982);
   int x1994 = Long_val(x1981);
   int x1997 = Long_val(x1980);
   int x2000 = Long_val(x1979);
   float _Complex* x2003 = CTYPES_ADDR_OF_FATPTR(x1978);
   int x2004 = Long_val(x1977);
   float _Complex* x2007 = CTYPES_ADDR_OF_FATPTR(x1976);
   int x2008 = Long_val(x1975);
   cblas_ctbsv(x1985, x1988, x1991, x1994, x1997, x2000, x2003, x2004, 
               x2007, x2008);
   return Val_unit;
}
value owl_stub_71_cblas_ctbsv_byte10(value* argv, int argc)
{
   value x2012 = argv[9];
   value x2013 = argv[8];
   value x2014 = argv[7];
   value x2015 = argv[6];
   value x2016 = argv[5];
   value x2017 = argv[4];
   value x2018 = argv[3];
   value x2019 = argv[2];
   value x2020 = argv[1];
   value x2021 = argv[0];
   return
     owl_stub_71_cblas_ctbsv(x2021, x2020, x2019, x2018, x2017, x2016, 
                             x2015, x2014, x2013, x2012);
}
value owl_stub_72_cblas_ztbsv(value x2031, value x2030, value x2029,
                              value x2028, value x2027, value x2026,
                              value x2025, value x2024, value x2023,
                              value x2022)
{
   int x2032 = Long_val(x2031);
   int x2035 = Long_val(x2030);
   int x2038 = Long_val(x2029);
   int x2041 = Long_val(x2028);
   int x2044 = Long_val(x2027);
   int x2047 = Long_val(x2026);
   double _Complex* x2050 = CTYPES_ADDR_OF_FATPTR(x2025);
   int x2051 = Long_val(x2024);
   double _Complex* x2054 = CTYPES_ADDR_OF_FATPTR(x2023);
   int x2055 = Long_val(x2022);
   cblas_ztbsv(x2032, x2035, x2038, x2041, x2044, x2047, x2050, x2051, 
               x2054, x2055);
   return Val_unit;
}
value owl_stub_72_cblas_ztbsv_byte10(value* argv, int argc)
{
   value x2059 = argv[9];
   value x2060 = argv[8];
   value x2061 = argv[7];
   value x2062 = argv[6];
   value x2063 = argv[5];
   value x2064 = argv[4];
   value x2065 = argv[3];
   value x2066 = argv[2];
   value x2067 = argv[1];
   value x2068 = argv[0];
   return
     owl_stub_72_cblas_ztbsv(x2068, x2067, x2066, x2065, x2064, x2063, 
                             x2062, x2061, x2060, x2059);
}
value owl_stub_73_cblas_stpsv(value x2076, value x2075, value x2074,
                              value x2073, value x2072, value x2071,
                              value x2070, value x2069)
{
   int x2077 = Long_val(x2076);
   int x2080 = Long_val(x2075);
   int x2083 = Long_val(x2074);
   int x2086 = Long_val(x2073);
   int x2089 = Long_val(x2072);
   float* x2092 = CTYPES_ADDR_OF_FATPTR(x2071);
   float* x2093 = CTYPES_ADDR_OF_FATPTR(x2070);
   int x2094 = Long_val(x2069);
   cblas_stpsv(x2077, x2080, x2083, x2086, x2089, x2092, x2093, x2094);
   return Val_unit;
}
value owl_stub_73_cblas_stpsv_byte8(value* argv, int argc)
{
   value x2098 = argv[7];
   value x2099 = argv[6];
   value x2100 = argv[5];
   value x2101 = argv[4];
   value x2102 = argv[3];
   value x2103 = argv[2];
   value x2104 = argv[1];
   value x2105 = argv[0];
   return
     owl_stub_73_cblas_stpsv(x2105, x2104, x2103, x2102, x2101, x2100, 
                             x2099, x2098);
}
value owl_stub_74_cblas_dtpsv(value x2113, value x2112, value x2111,
                              value x2110, value x2109, value x2108,
                              value x2107, value x2106)
{
   int x2114 = Long_val(x2113);
   int x2117 = Long_val(x2112);
   int x2120 = Long_val(x2111);
   int x2123 = Long_val(x2110);
   int x2126 = Long_val(x2109);
   double* x2129 = CTYPES_ADDR_OF_FATPTR(x2108);
   double* x2130 = CTYPES_ADDR_OF_FATPTR(x2107);
   int x2131 = Long_val(x2106);
   cblas_dtpsv(x2114, x2117, x2120, x2123, x2126, x2129, x2130, x2131);
   return Val_unit;
}
value owl_stub_74_cblas_dtpsv_byte8(value* argv, int argc)
{
   value x2135 = argv[7];
   value x2136 = argv[6];
   value x2137 = argv[5];
   value x2138 = argv[4];
   value x2139 = argv[3];
   value x2140 = argv[2];
   value x2141 = argv[1];
   value x2142 = argv[0];
   return
     owl_stub_74_cblas_dtpsv(x2142, x2141, x2140, x2139, x2138, x2137, 
                             x2136, x2135);
}
value owl_stub_75_cblas_ctpsv(value x2150, value x2149, value x2148,
                              value x2147, value x2146, value x2145,
                              value x2144, value x2143)
{
   int x2151 = Long_val(x2150);
   int x2154 = Long_val(x2149);
   int x2157 = Long_val(x2148);
   int x2160 = Long_val(x2147);
   int x2163 = Long_val(x2146);
   float _Complex* x2166 = CTYPES_ADDR_OF_FATPTR(x2145);
   float _Complex* x2167 = CTYPES_ADDR_OF_FATPTR(x2144);
   int x2168 = Long_val(x2143);
   cblas_ctpsv(x2151, x2154, x2157, x2160, x2163, x2166, x2167, x2168);
   return Val_unit;
}
value owl_stub_75_cblas_ctpsv_byte8(value* argv, int argc)
{
   value x2172 = argv[7];
   value x2173 = argv[6];
   value x2174 = argv[5];
   value x2175 = argv[4];
   value x2176 = argv[3];
   value x2177 = argv[2];
   value x2178 = argv[1];
   value x2179 = argv[0];
   return
     owl_stub_75_cblas_ctpsv(x2179, x2178, x2177, x2176, x2175, x2174, 
                             x2173, x2172);
}
value owl_stub_76_cblas_ztpsv(value x2187, value x2186, value x2185,
                              value x2184, value x2183, value x2182,
                              value x2181, value x2180)
{
   int x2188 = Long_val(x2187);
   int x2191 = Long_val(x2186);
   int x2194 = Long_val(x2185);
   int x2197 = Long_val(x2184);
   int x2200 = Long_val(x2183);
   double _Complex* x2203 = CTYPES_ADDR_OF_FATPTR(x2182);
   double _Complex* x2204 = CTYPES_ADDR_OF_FATPTR(x2181);
   int x2205 = Long_val(x2180);
   cblas_ztpsv(x2188, x2191, x2194, x2197, x2200, x2203, x2204, x2205);
   return Val_unit;
}
value owl_stub_76_cblas_ztpsv_byte8(value* argv, int argc)
{
   value x2209 = argv[7];
   value x2210 = argv[6];
   value x2211 = argv[5];
   value x2212 = argv[4];
   value x2213 = argv[3];
   value x2214 = argv[2];
   value x2215 = argv[1];
   value x2216 = argv[0];
   return
     owl_stub_76_cblas_ztpsv(x2216, x2215, x2214, x2213, x2212, x2211, 
                             x2210, x2209);
}
value owl_stub_77_cblas_ssymv(value x2227, value x2226, value x2225,
                              value x2224, value x2223, value x2222,
                              value x2221, value x2220, value x2219,
                              value x2218, value x2217)
{
   int x2228 = Long_val(x2227);
   int x2231 = Long_val(x2226);
   int x2234 = Long_val(x2225);
   double x2237 = Double_val(x2224);
   float* x2240 = CTYPES_ADDR_OF_FATPTR(x2223);
   int x2241 = Long_val(x2222);
   float* x2244 = CTYPES_ADDR_OF_FATPTR(x2221);
   int x2245 = Long_val(x2220);
   double x2248 = Double_val(x2219);
   float* x2251 = CTYPES_ADDR_OF_FATPTR(x2218);
   int x2252 = Long_val(x2217);
   cblas_ssymv(x2228, x2231, x2234, (float)x2237, x2240, x2241, x2244, 
               x2245, (float)x2248, x2251, x2252);
   return Val_unit;
}
value owl_stub_77_cblas_ssymv_byte11(value* argv, int argc)
{
   value x2256 = argv[10];
   value x2257 = argv[9];
   value x2258 = argv[8];
   value x2259 = argv[7];
   value x2260 = argv[6];
   value x2261 = argv[5];
   value x2262 = argv[4];
   value x2263 = argv[3];
   value x2264 = argv[2];
   value x2265 = argv[1];
   value x2266 = argv[0];
   return
     owl_stub_77_cblas_ssymv(x2266, x2265, x2264, x2263, x2262, x2261, 
                             x2260, x2259, x2258, x2257, x2256);
}
value owl_stub_78_cblas_dsymv(value x2277, value x2276, value x2275,
                              value x2274, value x2273, value x2272,
                              value x2271, value x2270, value x2269,
                              value x2268, value x2267)
{
   int x2278 = Long_val(x2277);
   int x2281 = Long_val(x2276);
   int x2284 = Long_val(x2275);
   double x2287 = Double_val(x2274);
   double* x2290 = CTYPES_ADDR_OF_FATPTR(x2273);
   int x2291 = Long_val(x2272);
   double* x2294 = CTYPES_ADDR_OF_FATPTR(x2271);
   int x2295 = Long_val(x2270);
   double x2298 = Double_val(x2269);
   double* x2301 = CTYPES_ADDR_OF_FATPTR(x2268);
   int x2302 = Long_val(x2267);
   cblas_dsymv(x2278, x2281, x2284, x2287, x2290, x2291, x2294, x2295, 
               x2298, x2301, x2302);
   return Val_unit;
}
value owl_stub_78_cblas_dsymv_byte11(value* argv, int argc)
{
   value x2306 = argv[10];
   value x2307 = argv[9];
   value x2308 = argv[8];
   value x2309 = argv[7];
   value x2310 = argv[6];
   value x2311 = argv[5];
   value x2312 = argv[4];
   value x2313 = argv[3];
   value x2314 = argv[2];
   value x2315 = argv[1];
   value x2316 = argv[0];
   return
     owl_stub_78_cblas_dsymv(x2316, x2315, x2314, x2313, x2312, x2311, 
                             x2310, x2309, x2308, x2307, x2306);
}
value owl_stub_79_cblas_ssbmv(value x2328, value x2327, value x2326,
                              value x2325, value x2324, value x2323,
                              value x2322, value x2321, value x2320,
                              value x2319, value x2318, value x2317)
{
   int x2329 = Long_val(x2328);
   int x2332 = Long_val(x2327);
   int x2335 = Long_val(x2326);
   int x2338 = Long_val(x2325);
   double x2341 = Double_val(x2324);
   float* x2344 = CTYPES_ADDR_OF_FATPTR(x2323);
   int x2345 = Long_val(x2322);
   float* x2348 = CTYPES_ADDR_OF_FATPTR(x2321);
   int x2349 = Long_val(x2320);
   double x2352 = Double_val(x2319);
   float* x2355 = CTYPES_ADDR_OF_FATPTR(x2318);
   int x2356 = Long_val(x2317);
   cblas_ssbmv(x2329, x2332, x2335, x2338, (float)x2341, x2344, x2345, 
               x2348, x2349, (float)x2352, x2355, x2356);
   return Val_unit;
}
value owl_stub_79_cblas_ssbmv_byte12(value* argv, int argc)
{
   value x2360 = argv[11];
   value x2361 = argv[10];
   value x2362 = argv[9];
   value x2363 = argv[8];
   value x2364 = argv[7];
   value x2365 = argv[6];
   value x2366 = argv[5];
   value x2367 = argv[4];
   value x2368 = argv[3];
   value x2369 = argv[2];
   value x2370 = argv[1];
   value x2371 = argv[0];
   return
     owl_stub_79_cblas_ssbmv(x2371, x2370, x2369, x2368, x2367, x2366, 
                             x2365, x2364, x2363, x2362, x2361, x2360);
}
value owl_stub_80_cblas_dsbmv(value x2383, value x2382, value x2381,
                              value x2380, value x2379, value x2378,
                              value x2377, value x2376, value x2375,
                              value x2374, value x2373, value x2372)
{
   int x2384 = Long_val(x2383);
   int x2387 = Long_val(x2382);
   int x2390 = Long_val(x2381);
   int x2393 = Long_val(x2380);
   double x2396 = Double_val(x2379);
   double* x2399 = CTYPES_ADDR_OF_FATPTR(x2378);
   int x2400 = Long_val(x2377);
   double* x2403 = CTYPES_ADDR_OF_FATPTR(x2376);
   int x2404 = Long_val(x2375);
   double x2407 = Double_val(x2374);
   double* x2410 = CTYPES_ADDR_OF_FATPTR(x2373);
   int x2411 = Long_val(x2372);
   cblas_dsbmv(x2384, x2387, x2390, x2393, x2396, x2399, x2400, x2403, 
               x2404, x2407, x2410, x2411);
   return Val_unit;
}
value owl_stub_80_cblas_dsbmv_byte12(value* argv, int argc)
{
   value x2415 = argv[11];
   value x2416 = argv[10];
   value x2417 = argv[9];
   value x2418 = argv[8];
   value x2419 = argv[7];
   value x2420 = argv[6];
   value x2421 = argv[5];
   value x2422 = argv[4];
   value x2423 = argv[3];
   value x2424 = argv[2];
   value x2425 = argv[1];
   value x2426 = argv[0];
   return
     owl_stub_80_cblas_dsbmv(x2426, x2425, x2424, x2423, x2422, x2421, 
                             x2420, x2419, x2418, x2417, x2416, x2415);
}
value owl_stub_81_cblas_sspmv(value x2436, value x2435, value x2434,
                              value x2433, value x2432, value x2431,
                              value x2430, value x2429, value x2428,
                              value x2427)
{
   int x2437 = Long_val(x2436);
   int x2440 = Long_val(x2435);
   int x2443 = Long_val(x2434);
   double x2446 = Double_val(x2433);
   float* x2449 = CTYPES_ADDR_OF_FATPTR(x2432);
   float* x2450 = CTYPES_ADDR_OF_FATPTR(x2431);
   int x2451 = Long_val(x2430);
   double x2454 = Double_val(x2429);
   float* x2457 = CTYPES_ADDR_OF_FATPTR(x2428);
   int x2458 = Long_val(x2427);
   cblas_sspmv(x2437, x2440, x2443, (float)x2446, x2449, x2450, x2451,
               (float)x2454, x2457, x2458);
   return Val_unit;
}
value owl_stub_81_cblas_sspmv_byte10(value* argv, int argc)
{
   value x2462 = argv[9];
   value x2463 = argv[8];
   value x2464 = argv[7];
   value x2465 = argv[6];
   value x2466 = argv[5];
   value x2467 = argv[4];
   value x2468 = argv[3];
   value x2469 = argv[2];
   value x2470 = argv[1];
   value x2471 = argv[0];
   return
     owl_stub_81_cblas_sspmv(x2471, x2470, x2469, x2468, x2467, x2466, 
                             x2465, x2464, x2463, x2462);
}
value owl_stub_82_cblas_dspmv(value x2481, value x2480, value x2479,
                              value x2478, value x2477, value x2476,
                              value x2475, value x2474, value x2473,
                              value x2472)
{
   int x2482 = Long_val(x2481);
   int x2485 = Long_val(x2480);
   int x2488 = Long_val(x2479);
   double x2491 = Double_val(x2478);
   double* x2494 = CTYPES_ADDR_OF_FATPTR(x2477);
   double* x2495 = CTYPES_ADDR_OF_FATPTR(x2476);
   int x2496 = Long_val(x2475);
   double x2499 = Double_val(x2474);
   double* x2502 = CTYPES_ADDR_OF_FATPTR(x2473);
   int x2503 = Long_val(x2472);
   cblas_dspmv(x2482, x2485, x2488, x2491, x2494, x2495, x2496, x2499, 
               x2502, x2503);
   return Val_unit;
}
value owl_stub_82_cblas_dspmv_byte10(value* argv, int argc)
{
   value x2507 = argv[9];
   value x2508 = argv[8];
   value x2509 = argv[7];
   value x2510 = argv[6];
   value x2511 = argv[5];
   value x2512 = argv[4];
   value x2513 = argv[3];
   value x2514 = argv[2];
   value x2515 = argv[1];
   value x2516 = argv[0];
   return
     owl_stub_82_cblas_dspmv(x2516, x2515, x2514, x2513, x2512, x2511, 
                             x2510, x2509, x2508, x2507);
}
value owl_stub_83_cblas_sger(value x2526, value x2525, value x2524,
                             value x2523, value x2522, value x2521,
                             value x2520, value x2519, value x2518,
                             value x2517)
{
   int x2527 = Long_val(x2526);
   int x2530 = Long_val(x2525);
   int x2533 = Long_val(x2524);
   double x2536 = Double_val(x2523);
   float* x2539 = CTYPES_ADDR_OF_FATPTR(x2522);
   int x2540 = Long_val(x2521);
   float* x2543 = CTYPES_ADDR_OF_FATPTR(x2520);
   int x2544 = Long_val(x2519);
   float* x2547 = CTYPES_ADDR_OF_FATPTR(x2518);
   int x2548 = Long_val(x2517);
   cblas_sger(x2527, x2530, x2533, (float)x2536, x2539, x2540, x2543, 
              x2544, x2547, x2548);
   return Val_unit;
}
value owl_stub_83_cblas_sger_byte10(value* argv, int argc)
{
   value x2552 = argv[9];
   value x2553 = argv[8];
   value x2554 = argv[7];
   value x2555 = argv[6];
   value x2556 = argv[5];
   value x2557 = argv[4];
   value x2558 = argv[3];
   value x2559 = argv[2];
   value x2560 = argv[1];
   value x2561 = argv[0];
   return
     owl_stub_83_cblas_sger(x2561, x2560, x2559, x2558, x2557, x2556, 
                            x2555, x2554, x2553, x2552);
}
value owl_stub_84_cblas_dger(value x2571, value x2570, value x2569,
                             value x2568, value x2567, value x2566,
                             value x2565, value x2564, value x2563,
                             value x2562)
{
   int x2572 = Long_val(x2571);
   int x2575 = Long_val(x2570);
   int x2578 = Long_val(x2569);
   double x2581 = Double_val(x2568);
   double* x2584 = CTYPES_ADDR_OF_FATPTR(x2567);
   int x2585 = Long_val(x2566);
   double* x2588 = CTYPES_ADDR_OF_FATPTR(x2565);
   int x2589 = Long_val(x2564);
   double* x2592 = CTYPES_ADDR_OF_FATPTR(x2563);
   int x2593 = Long_val(x2562);
   cblas_dger(x2572, x2575, x2578, x2581, x2584, x2585, x2588, x2589, 
              x2592, x2593);
   return Val_unit;
}
value owl_stub_84_cblas_dger_byte10(value* argv, int argc)
{
   value x2597 = argv[9];
   value x2598 = argv[8];
   value x2599 = argv[7];
   value x2600 = argv[6];
   value x2601 = argv[5];
   value x2602 = argv[4];
   value x2603 = argv[3];
   value x2604 = argv[2];
   value x2605 = argv[1];
   value x2606 = argv[0];
   return
     owl_stub_84_cblas_dger(x2606, x2605, x2604, x2603, x2602, x2601, 
                            x2600, x2599, x2598, x2597);
}
value owl_stub_85_cblas_ssyr(value x2614, value x2613, value x2612,
                             value x2611, value x2610, value x2609,
                             value x2608, value x2607)
{
   int x2615 = Long_val(x2614);
   int x2618 = Long_val(x2613);
   int x2621 = Long_val(x2612);
   double x2624 = Double_val(x2611);
   float* x2627 = CTYPES_ADDR_OF_FATPTR(x2610);
   int x2628 = Long_val(x2609);
   float* x2631 = CTYPES_ADDR_OF_FATPTR(x2608);
   int x2632 = Long_val(x2607);
   cblas_ssyr(x2615, x2618, x2621, (float)x2624, x2627, x2628, x2631, x2632);
   return Val_unit;
}
value owl_stub_85_cblas_ssyr_byte8(value* argv, int argc)
{
   value x2636 = argv[7];
   value x2637 = argv[6];
   value x2638 = argv[5];
   value x2639 = argv[4];
   value x2640 = argv[3];
   value x2641 = argv[2];
   value x2642 = argv[1];
   value x2643 = argv[0];
   return
     owl_stub_85_cblas_ssyr(x2643, x2642, x2641, x2640, x2639, x2638, 
                            x2637, x2636);
}
value owl_stub_86_cblas_dsyr(value x2651, value x2650, value x2649,
                             value x2648, value x2647, value x2646,
                             value x2645, value x2644)
{
   int x2652 = Long_val(x2651);
   int x2655 = Long_val(x2650);
   int x2658 = Long_val(x2649);
   double x2661 = Double_val(x2648);
   double* x2664 = CTYPES_ADDR_OF_FATPTR(x2647);
   int x2665 = Long_val(x2646);
   double* x2668 = CTYPES_ADDR_OF_FATPTR(x2645);
   int x2669 = Long_val(x2644);
   cblas_dsyr(x2652, x2655, x2658, x2661, x2664, x2665, x2668, x2669);
   return Val_unit;
}
value owl_stub_86_cblas_dsyr_byte8(value* argv, int argc)
{
   value x2673 = argv[7];
   value x2674 = argv[6];
   value x2675 = argv[5];
   value x2676 = argv[4];
   value x2677 = argv[3];
   value x2678 = argv[2];
   value x2679 = argv[1];
   value x2680 = argv[0];
   return
     owl_stub_86_cblas_dsyr(x2680, x2679, x2678, x2677, x2676, x2675, 
                            x2674, x2673);
}
value owl_stub_87_cblas_sspr(value x2687, value x2686, value x2685,
                             value x2684, value x2683, value x2682,
                             value x2681)
{
   int x2688 = Long_val(x2687);
   int x2691 = Long_val(x2686);
   int x2694 = Long_val(x2685);
   double x2697 = Double_val(x2684);
   float* x2700 = CTYPES_ADDR_OF_FATPTR(x2683);
   int x2701 = Long_val(x2682);
   float* x2704 = CTYPES_ADDR_OF_FATPTR(x2681);
   cblas_sspr(x2688, x2691, x2694, (float)x2697, x2700, x2701, x2704);
   return Val_unit;
}
value owl_stub_87_cblas_sspr_byte7(value* argv, int argc)
{
   value x2706 = argv[6];
   value x2707 = argv[5];
   value x2708 = argv[4];
   value x2709 = argv[3];
   value x2710 = argv[2];
   value x2711 = argv[1];
   value x2712 = argv[0];
   return
     owl_stub_87_cblas_sspr(x2712, x2711, x2710, x2709, x2708, x2707, x2706);
}
value owl_stub_88_cblas_dspr(value x2719, value x2718, value x2717,
                             value x2716, value x2715, value x2714,
                             value x2713)
{
   int x2720 = Long_val(x2719);
   int x2723 = Long_val(x2718);
   int x2726 = Long_val(x2717);
   double x2729 = Double_val(x2716);
   double* x2732 = CTYPES_ADDR_OF_FATPTR(x2715);
   int x2733 = Long_val(x2714);
   double* x2736 = CTYPES_ADDR_OF_FATPTR(x2713);
   cblas_dspr(x2720, x2723, x2726, x2729, x2732, x2733, x2736);
   return Val_unit;
}
value owl_stub_88_cblas_dspr_byte7(value* argv, int argc)
{
   value x2738 = argv[6];
   value x2739 = argv[5];
   value x2740 = argv[4];
   value x2741 = argv[3];
   value x2742 = argv[2];
   value x2743 = argv[1];
   value x2744 = argv[0];
   return
     owl_stub_88_cblas_dspr(x2744, x2743, x2742, x2741, x2740, x2739, x2738);
}
value owl_stub_89_cblas_ssyr2(value x2754, value x2753, value x2752,
                              value x2751, value x2750, value x2749,
                              value x2748, value x2747, value x2746,
                              value x2745)
{
   int x2755 = Long_val(x2754);
   int x2758 = Long_val(x2753);
   int x2761 = Long_val(x2752);
   double x2764 = Double_val(x2751);
   float* x2767 = CTYPES_ADDR_OF_FATPTR(x2750);
   int x2768 = Long_val(x2749);
   float* x2771 = CTYPES_ADDR_OF_FATPTR(x2748);
   int x2772 = Long_val(x2747);
   float* x2775 = CTYPES_ADDR_OF_FATPTR(x2746);
   int x2776 = Long_val(x2745);
   cblas_ssyr2(x2755, x2758, x2761, (float)x2764, x2767, x2768, x2771, 
               x2772, x2775, x2776);
   return Val_unit;
}
value owl_stub_89_cblas_ssyr2_byte10(value* argv, int argc)
{
   value x2780 = argv[9];
   value x2781 = argv[8];
   value x2782 = argv[7];
   value x2783 = argv[6];
   value x2784 = argv[5];
   value x2785 = argv[4];
   value x2786 = argv[3];
   value x2787 = argv[2];
   value x2788 = argv[1];
   value x2789 = argv[0];
   return
     owl_stub_89_cblas_ssyr2(x2789, x2788, x2787, x2786, x2785, x2784, 
                             x2783, x2782, x2781, x2780);
}
value owl_stub_90_cblas_dsyr2(value x2799, value x2798, value x2797,
                              value x2796, value x2795, value x2794,
                              value x2793, value x2792, value x2791,
                              value x2790)
{
   int x2800 = Long_val(x2799);
   int x2803 = Long_val(x2798);
   int x2806 = Long_val(x2797);
   double x2809 = Double_val(x2796);
   double* x2812 = CTYPES_ADDR_OF_FATPTR(x2795);
   int x2813 = Long_val(x2794);
   double* x2816 = CTYPES_ADDR_OF_FATPTR(x2793);
   int x2817 = Long_val(x2792);
   double* x2820 = CTYPES_ADDR_OF_FATPTR(x2791);
   int x2821 = Long_val(x2790);
   cblas_dsyr2(x2800, x2803, x2806, x2809, x2812, x2813, x2816, x2817, 
               x2820, x2821);
   return Val_unit;
}
value owl_stub_90_cblas_dsyr2_byte10(value* argv, int argc)
{
   value x2825 = argv[9];
   value x2826 = argv[8];
   value x2827 = argv[7];
   value x2828 = argv[6];
   value x2829 = argv[5];
   value x2830 = argv[4];
   value x2831 = argv[3];
   value x2832 = argv[2];
   value x2833 = argv[1];
   value x2834 = argv[0];
   return
     owl_stub_90_cblas_dsyr2(x2834, x2833, x2832, x2831, x2830, x2829, 
                             x2828, x2827, x2826, x2825);
}
value owl_stub_91_cblas_sspr2(value x2843, value x2842, value x2841,
                              value x2840, value x2839, value x2838,
                              value x2837, value x2836, value x2835)
{
   int x2844 = Long_val(x2843);
   int x2847 = Long_val(x2842);
   int x2850 = Long_val(x2841);
   double x2853 = Double_val(x2840);
   float* x2856 = CTYPES_ADDR_OF_FATPTR(x2839);
   int x2857 = Long_val(x2838);
   float* x2860 = CTYPES_ADDR_OF_FATPTR(x2837);
   int x2861 = Long_val(x2836);
   float* x2864 = CTYPES_ADDR_OF_FATPTR(x2835);
   cblas_sspr2(x2844, x2847, x2850, (float)x2853, x2856, x2857, x2860, 
               x2861, x2864);
   return Val_unit;
}
value owl_stub_91_cblas_sspr2_byte9(value* argv, int argc)
{
   value x2866 = argv[8];
   value x2867 = argv[7];
   value x2868 = argv[6];
   value x2869 = argv[5];
   value x2870 = argv[4];
   value x2871 = argv[3];
   value x2872 = argv[2];
   value x2873 = argv[1];
   value x2874 = argv[0];
   return
     owl_stub_91_cblas_sspr2(x2874, x2873, x2872, x2871, x2870, x2869, 
                             x2868, x2867, x2866);
}
value owl_stub_92_cblas_dspr2(value x2883, value x2882, value x2881,
                              value x2880, value x2879, value x2878,
                              value x2877, value x2876, value x2875)
{
   int x2884 = Long_val(x2883);
   int x2887 = Long_val(x2882);
   int x2890 = Long_val(x2881);
   double x2893 = Double_val(x2880);
   double* x2896 = CTYPES_ADDR_OF_FATPTR(x2879);
   int x2897 = Long_val(x2878);
   double* x2900 = CTYPES_ADDR_OF_FATPTR(x2877);
   int x2901 = Long_val(x2876);
   double* x2904 = CTYPES_ADDR_OF_FATPTR(x2875);
   cblas_dspr2(x2884, x2887, x2890, x2893, x2896, x2897, x2900, x2901, x2904);
   return Val_unit;
}
value owl_stub_92_cblas_dspr2_byte9(value* argv, int argc)
{
   value x2906 = argv[8];
   value x2907 = argv[7];
   value x2908 = argv[6];
   value x2909 = argv[5];
   value x2910 = argv[4];
   value x2911 = argv[3];
   value x2912 = argv[2];
   value x2913 = argv[1];
   value x2914 = argv[0];
   return
     owl_stub_92_cblas_dspr2(x2914, x2913, x2912, x2911, x2910, x2909, 
                             x2908, x2907, x2906);
}
value owl_stub_93_cblas_chemv(value x2925, value x2924, value x2923,
                              value x2922, value x2921, value x2920,
                              value x2919, value x2918, value x2917,
                              value x2916, value x2915)
{
   int x2926 = Long_val(x2925);
   int x2929 = Long_val(x2924);
   int x2932 = Long_val(x2923);
   float _Complex* x2935 = CTYPES_ADDR_OF_FATPTR(x2922);
   float _Complex* x2936 = CTYPES_ADDR_OF_FATPTR(x2921);
   int x2937 = Long_val(x2920);
   float _Complex* x2940 = CTYPES_ADDR_OF_FATPTR(x2919);
   int x2941 = Long_val(x2918);
   float _Complex* x2944 = CTYPES_ADDR_OF_FATPTR(x2917);
   float _Complex* x2945 = CTYPES_ADDR_OF_FATPTR(x2916);
   int x2946 = Long_val(x2915);
   cblas_chemv(x2926, x2929, x2932, x2935, x2936, x2937, x2940, x2941, 
               x2944, x2945, x2946);
   return Val_unit;
}
value owl_stub_93_cblas_chemv_byte11(value* argv, int argc)
{
   value x2950 = argv[10];
   value x2951 = argv[9];
   value x2952 = argv[8];
   value x2953 = argv[7];
   value x2954 = argv[6];
   value x2955 = argv[5];
   value x2956 = argv[4];
   value x2957 = argv[3];
   value x2958 = argv[2];
   value x2959 = argv[1];
   value x2960 = argv[0];
   return
     owl_stub_93_cblas_chemv(x2960, x2959, x2958, x2957, x2956, x2955, 
                             x2954, x2953, x2952, x2951, x2950);
}
value owl_stub_94_cblas_zhemv(value x2971, value x2970, value x2969,
                              value x2968, value x2967, value x2966,
                              value x2965, value x2964, value x2963,
                              value x2962, value x2961)
{
   int x2972 = Long_val(x2971);
   int x2975 = Long_val(x2970);
   int x2978 = Long_val(x2969);
   double _Complex* x2981 = CTYPES_ADDR_OF_FATPTR(x2968);
   double _Complex* x2982 = CTYPES_ADDR_OF_FATPTR(x2967);
   int x2983 = Long_val(x2966);
   double _Complex* x2986 = CTYPES_ADDR_OF_FATPTR(x2965);
   int x2987 = Long_val(x2964);
   double _Complex* x2990 = CTYPES_ADDR_OF_FATPTR(x2963);
   double _Complex* x2991 = CTYPES_ADDR_OF_FATPTR(x2962);
   int x2992 = Long_val(x2961);
   cblas_zhemv(x2972, x2975, x2978, x2981, x2982, x2983, x2986, x2987, 
               x2990, x2991, x2992);
   return Val_unit;
}
value owl_stub_94_cblas_zhemv_byte11(value* argv, int argc)
{
   value x2996 = argv[10];
   value x2997 = argv[9];
   value x2998 = argv[8];
   value x2999 = argv[7];
   value x3000 = argv[6];
   value x3001 = argv[5];
   value x3002 = argv[4];
   value x3003 = argv[3];
   value x3004 = argv[2];
   value x3005 = argv[1];
   value x3006 = argv[0];
   return
     owl_stub_94_cblas_zhemv(x3006, x3005, x3004, x3003, x3002, x3001, 
                             x3000, x2999, x2998, x2997, x2996);
}
value owl_stub_95_cblas_chbmv(value x3018, value x3017, value x3016,
                              value x3015, value x3014, value x3013,
                              value x3012, value x3011, value x3010,
                              value x3009, value x3008, value x3007)
{
   int x3019 = Long_val(x3018);
   int x3022 = Long_val(x3017);
   int x3025 = Long_val(x3016);
   int x3028 = Long_val(x3015);
   float _Complex* x3031 = CTYPES_ADDR_OF_FATPTR(x3014);
   float _Complex* x3032 = CTYPES_ADDR_OF_FATPTR(x3013);
   int x3033 = Long_val(x3012);
   float _Complex* x3036 = CTYPES_ADDR_OF_FATPTR(x3011);
   int x3037 = Long_val(x3010);
   float _Complex* x3040 = CTYPES_ADDR_OF_FATPTR(x3009);
   float _Complex* x3041 = CTYPES_ADDR_OF_FATPTR(x3008);
   int x3042 = Long_val(x3007);
   cblas_chbmv(x3019, x3022, x3025, x3028, x3031, x3032, x3033, x3036, 
               x3037, x3040, x3041, x3042);
   return Val_unit;
}
value owl_stub_95_cblas_chbmv_byte12(value* argv, int argc)
{
   value x3046 = argv[11];
   value x3047 = argv[10];
   value x3048 = argv[9];
   value x3049 = argv[8];
   value x3050 = argv[7];
   value x3051 = argv[6];
   value x3052 = argv[5];
   value x3053 = argv[4];
   value x3054 = argv[3];
   value x3055 = argv[2];
   value x3056 = argv[1];
   value x3057 = argv[0];
   return
     owl_stub_95_cblas_chbmv(x3057, x3056, x3055, x3054, x3053, x3052, 
                             x3051, x3050, x3049, x3048, x3047, x3046);
}
value owl_stub_96_cblas_zhbmv(value x3069, value x3068, value x3067,
                              value x3066, value x3065, value x3064,
                              value x3063, value x3062, value x3061,
                              value x3060, value x3059, value x3058)
{
   int x3070 = Long_val(x3069);
   int x3073 = Long_val(x3068);
   int x3076 = Long_val(x3067);
   int x3079 = Long_val(x3066);
   double _Complex* x3082 = CTYPES_ADDR_OF_FATPTR(x3065);
   double _Complex* x3083 = CTYPES_ADDR_OF_FATPTR(x3064);
   int x3084 = Long_val(x3063);
   double _Complex* x3087 = CTYPES_ADDR_OF_FATPTR(x3062);
   int x3088 = Long_val(x3061);
   double _Complex* x3091 = CTYPES_ADDR_OF_FATPTR(x3060);
   double _Complex* x3092 = CTYPES_ADDR_OF_FATPTR(x3059);
   int x3093 = Long_val(x3058);
   cblas_zhbmv(x3070, x3073, x3076, x3079, x3082, x3083, x3084, x3087, 
               x3088, x3091, x3092, x3093);
   return Val_unit;
}
value owl_stub_96_cblas_zhbmv_byte12(value* argv, int argc)
{
   value x3097 = argv[11];
   value x3098 = argv[10];
   value x3099 = argv[9];
   value x3100 = argv[8];
   value x3101 = argv[7];
   value x3102 = argv[6];
   value x3103 = argv[5];
   value x3104 = argv[4];
   value x3105 = argv[3];
   value x3106 = argv[2];
   value x3107 = argv[1];
   value x3108 = argv[0];
   return
     owl_stub_96_cblas_zhbmv(x3108, x3107, x3106, x3105, x3104, x3103, 
                             x3102, x3101, x3100, x3099, x3098, x3097);
}
value owl_stub_97_cblas_chpmv(value x3118, value x3117, value x3116,
                              value x3115, value x3114, value x3113,
                              value x3112, value x3111, value x3110,
                              value x3109)
{
   int x3119 = Long_val(x3118);
   int x3122 = Long_val(x3117);
   int x3125 = Long_val(x3116);
   float _Complex* x3128 = CTYPES_ADDR_OF_FATPTR(x3115);
   float _Complex* x3129 = CTYPES_ADDR_OF_FATPTR(x3114);
   float _Complex* x3130 = CTYPES_ADDR_OF_FATPTR(x3113);
   int x3131 = Long_val(x3112);
   float _Complex* x3134 = CTYPES_ADDR_OF_FATPTR(x3111);
   float _Complex* x3135 = CTYPES_ADDR_OF_FATPTR(x3110);
   int x3136 = Long_val(x3109);
   cblas_chpmv(x3119, x3122, x3125, x3128, x3129, x3130, x3131, x3134, 
               x3135, x3136);
   return Val_unit;
}
value owl_stub_97_cblas_chpmv_byte10(value* argv, int argc)
{
   value x3140 = argv[9];
   value x3141 = argv[8];
   value x3142 = argv[7];
   value x3143 = argv[6];
   value x3144 = argv[5];
   value x3145 = argv[4];
   value x3146 = argv[3];
   value x3147 = argv[2];
   value x3148 = argv[1];
   value x3149 = argv[0];
   return
     owl_stub_97_cblas_chpmv(x3149, x3148, x3147, x3146, x3145, x3144, 
                             x3143, x3142, x3141, x3140);
}
value owl_stub_98_cblas_zhpmv(value x3159, value x3158, value x3157,
                              value x3156, value x3155, value x3154,
                              value x3153, value x3152, value x3151,
                              value x3150)
{
   int x3160 = Long_val(x3159);
   int x3163 = Long_val(x3158);
   int x3166 = Long_val(x3157);
   double _Complex* x3169 = CTYPES_ADDR_OF_FATPTR(x3156);
   double _Complex* x3170 = CTYPES_ADDR_OF_FATPTR(x3155);
   double _Complex* x3171 = CTYPES_ADDR_OF_FATPTR(x3154);
   int x3172 = Long_val(x3153);
   double _Complex* x3175 = CTYPES_ADDR_OF_FATPTR(x3152);
   double _Complex* x3176 = CTYPES_ADDR_OF_FATPTR(x3151);
   int x3177 = Long_val(x3150);
   cblas_zhpmv(x3160, x3163, x3166, x3169, x3170, x3171, x3172, x3175, 
               x3176, x3177);
   return Val_unit;
}
value owl_stub_98_cblas_zhpmv_byte10(value* argv, int argc)
{
   value x3181 = argv[9];
   value x3182 = argv[8];
   value x3183 = argv[7];
   value x3184 = argv[6];
   value x3185 = argv[5];
   value x3186 = argv[4];
   value x3187 = argv[3];
   value x3188 = argv[2];
   value x3189 = argv[1];
   value x3190 = argv[0];
   return
     owl_stub_98_cblas_zhpmv(x3190, x3189, x3188, x3187, x3186, x3185, 
                             x3184, x3183, x3182, x3181);
}
value owl_stub_99_cblas_cgeru(value x3200, value x3199, value x3198,
                              value x3197, value x3196, value x3195,
                              value x3194, value x3193, value x3192,
                              value x3191)
{
   int x3201 = Long_val(x3200);
   int x3204 = Long_val(x3199);
   int x3207 = Long_val(x3198);
   float _Complex* x3210 = CTYPES_ADDR_OF_FATPTR(x3197);
   float _Complex* x3211 = CTYPES_ADDR_OF_FATPTR(x3196);
   int x3212 = Long_val(x3195);
   float _Complex* x3215 = CTYPES_ADDR_OF_FATPTR(x3194);
   int x3216 = Long_val(x3193);
   float _Complex* x3219 = CTYPES_ADDR_OF_FATPTR(x3192);
   int x3220 = Long_val(x3191);
   cblas_cgeru(x3201, x3204, x3207, x3210, x3211, x3212, x3215, x3216, 
               x3219, x3220);
   return Val_unit;
}
value owl_stub_99_cblas_cgeru_byte10(value* argv, int argc)
{
   value x3224 = argv[9];
   value x3225 = argv[8];
   value x3226 = argv[7];
   value x3227 = argv[6];
   value x3228 = argv[5];
   value x3229 = argv[4];
   value x3230 = argv[3];
   value x3231 = argv[2];
   value x3232 = argv[1];
   value x3233 = argv[0];
   return
     owl_stub_99_cblas_cgeru(x3233, x3232, x3231, x3230, x3229, x3228, 
                             x3227, x3226, x3225, x3224);
}
value owl_stub_100_cblas_zgeru(value x3243, value x3242, value x3241,
                               value x3240, value x3239, value x3238,
                               value x3237, value x3236, value x3235,
                               value x3234)
{
   int x3244 = Long_val(x3243);
   int x3247 = Long_val(x3242);
   int x3250 = Long_val(x3241);
   double _Complex* x3253 = CTYPES_ADDR_OF_FATPTR(x3240);
   double _Complex* x3254 = CTYPES_ADDR_OF_FATPTR(x3239);
   int x3255 = Long_val(x3238);
   double _Complex* x3258 = CTYPES_ADDR_OF_FATPTR(x3237);
   int x3259 = Long_val(x3236);
   double _Complex* x3262 = CTYPES_ADDR_OF_FATPTR(x3235);
   int x3263 = Long_val(x3234);
   cblas_zgeru(x3244, x3247, x3250, x3253, x3254, x3255, x3258, x3259, 
               x3262, x3263);
   return Val_unit;
}
value owl_stub_100_cblas_zgeru_byte10(value* argv, int argc)
{
   value x3267 = argv[9];
   value x3268 = argv[8];
   value x3269 = argv[7];
   value x3270 = argv[6];
   value x3271 = argv[5];
   value x3272 = argv[4];
   value x3273 = argv[3];
   value x3274 = argv[2];
   value x3275 = argv[1];
   value x3276 = argv[0];
   return
     owl_stub_100_cblas_zgeru(x3276, x3275, x3274, x3273, x3272, x3271,
                              x3270, x3269, x3268, x3267);
}
value owl_stub_101_cblas_cgerc(value x3286, value x3285, value x3284,
                               value x3283, value x3282, value x3281,
                               value x3280, value x3279, value x3278,
                               value x3277)
{
   int x3287 = Long_val(x3286);
   int x3290 = Long_val(x3285);
   int x3293 = Long_val(x3284);
   float _Complex* x3296 = CTYPES_ADDR_OF_FATPTR(x3283);
   float _Complex* x3297 = CTYPES_ADDR_OF_FATPTR(x3282);
   int x3298 = Long_val(x3281);
   float _Complex* x3301 = CTYPES_ADDR_OF_FATPTR(x3280);
   int x3302 = Long_val(x3279);
   float _Complex* x3305 = CTYPES_ADDR_OF_FATPTR(x3278);
   int x3306 = Long_val(x3277);
   cblas_cgerc(x3287, x3290, x3293, x3296, x3297, x3298, x3301, x3302, 
               x3305, x3306);
   return Val_unit;
}
value owl_stub_101_cblas_cgerc_byte10(value* argv, int argc)
{
   value x3310 = argv[9];
   value x3311 = argv[8];
   value x3312 = argv[7];
   value x3313 = argv[6];
   value x3314 = argv[5];
   value x3315 = argv[4];
   value x3316 = argv[3];
   value x3317 = argv[2];
   value x3318 = argv[1];
   value x3319 = argv[0];
   return
     owl_stub_101_cblas_cgerc(x3319, x3318, x3317, x3316, x3315, x3314,
                              x3313, x3312, x3311, x3310);
}
value owl_stub_102_cblas_zgerc(value x3329, value x3328, value x3327,
                               value x3326, value x3325, value x3324,
                               value x3323, value x3322, value x3321,
                               value x3320)
{
   int x3330 = Long_val(x3329);
   int x3333 = Long_val(x3328);
   int x3336 = Long_val(x3327);
   double _Complex* x3339 = CTYPES_ADDR_OF_FATPTR(x3326);
   double _Complex* x3340 = CTYPES_ADDR_OF_FATPTR(x3325);
   int x3341 = Long_val(x3324);
   double _Complex* x3344 = CTYPES_ADDR_OF_FATPTR(x3323);
   int x3345 = Long_val(x3322);
   double _Complex* x3348 = CTYPES_ADDR_OF_FATPTR(x3321);
   int x3349 = Long_val(x3320);
   cblas_zgerc(x3330, x3333, x3336, x3339, x3340, x3341, x3344, x3345, 
               x3348, x3349);
   return Val_unit;
}
value owl_stub_102_cblas_zgerc_byte10(value* argv, int argc)
{
   value x3353 = argv[9];
   value x3354 = argv[8];
   value x3355 = argv[7];
   value x3356 = argv[6];
   value x3357 = argv[5];
   value x3358 = argv[4];
   value x3359 = argv[3];
   value x3360 = argv[2];
   value x3361 = argv[1];
   value x3362 = argv[0];
   return
     owl_stub_102_cblas_zgerc(x3362, x3361, x3360, x3359, x3358, x3357,
                              x3356, x3355, x3354, x3353);
}
value owl_stub_103_cblas_cher(value x3370, value x3369, value x3368,
                              value x3367, value x3366, value x3365,
                              value x3364, value x3363)
{
   int x3371 = Long_val(x3370);
   int x3374 = Long_val(x3369);
   int x3377 = Long_val(x3368);
   double x3380 = Double_val(x3367);
   float _Complex* x3383 = CTYPES_ADDR_OF_FATPTR(x3366);
   int x3384 = Long_val(x3365);
   float _Complex* x3387 = CTYPES_ADDR_OF_FATPTR(x3364);
   int x3388 = Long_val(x3363);
   cblas_cher(x3371, x3374, x3377, (float)x3380, x3383, x3384, x3387, x3388);
   return Val_unit;
}
value owl_stub_103_cblas_cher_byte8(value* argv, int argc)
{
   value x3392 = argv[7];
   value x3393 = argv[6];
   value x3394 = argv[5];
   value x3395 = argv[4];
   value x3396 = argv[3];
   value x3397 = argv[2];
   value x3398 = argv[1];
   value x3399 = argv[0];
   return
     owl_stub_103_cblas_cher(x3399, x3398, x3397, x3396, x3395, x3394, 
                             x3393, x3392);
}
value owl_stub_104_cblas_zher(value x3407, value x3406, value x3405,
                              value x3404, value x3403, value x3402,
                              value x3401, value x3400)
{
   int x3408 = Long_val(x3407);
   int x3411 = Long_val(x3406);
   int x3414 = Long_val(x3405);
   double x3417 = Double_val(x3404);
   double _Complex* x3420 = CTYPES_ADDR_OF_FATPTR(x3403);
   int x3421 = Long_val(x3402);
   double _Complex* x3424 = CTYPES_ADDR_OF_FATPTR(x3401);
   int x3425 = Long_val(x3400);
   cblas_zher(x3408, x3411, x3414, (float)x3417, x3420, x3421, x3424, x3425);
   return Val_unit;
}
value owl_stub_104_cblas_zher_byte8(value* argv, int argc)
{
   value x3429 = argv[7];
   value x3430 = argv[6];
   value x3431 = argv[5];
   value x3432 = argv[4];
   value x3433 = argv[3];
   value x3434 = argv[2];
   value x3435 = argv[1];
   value x3436 = argv[0];
   return
     owl_stub_104_cblas_zher(x3436, x3435, x3434, x3433, x3432, x3431, 
                             x3430, x3429);
}
value owl_stub_105_cblas_chpr(value x3443, value x3442, value x3441,
                              value x3440, value x3439, value x3438,
                              value x3437)
{
   int x3444 = Long_val(x3443);
   int x3447 = Long_val(x3442);
   int x3450 = Long_val(x3441);
   double x3453 = Double_val(x3440);
   float _Complex* x3456 = CTYPES_ADDR_OF_FATPTR(x3439);
   int x3457 = Long_val(x3438);
   float _Complex* x3460 = CTYPES_ADDR_OF_FATPTR(x3437);
   cblas_chpr(x3444, x3447, x3450, (float)x3453, x3456, x3457, x3460);
   return Val_unit;
}
value owl_stub_105_cblas_chpr_byte7(value* argv, int argc)
{
   value x3462 = argv[6];
   value x3463 = argv[5];
   value x3464 = argv[4];
   value x3465 = argv[3];
   value x3466 = argv[2];
   value x3467 = argv[1];
   value x3468 = argv[0];
   return
     owl_stub_105_cblas_chpr(x3468, x3467, x3466, x3465, x3464, x3463, x3462);
}
value owl_stub_106_cblas_zhpr(value x3475, value x3474, value x3473,
                              value x3472, value x3471, value x3470,
                              value x3469)
{
   int x3476 = Long_val(x3475);
   int x3479 = Long_val(x3474);
   int x3482 = Long_val(x3473);
   double x3485 = Double_val(x3472);
   double _Complex* x3488 = CTYPES_ADDR_OF_FATPTR(x3471);
   int x3489 = Long_val(x3470);
   double _Complex* x3492 = CTYPES_ADDR_OF_FATPTR(x3469);
   cblas_zhpr(x3476, x3479, x3482, (float)x3485, x3488, x3489, x3492);
   return Val_unit;
}
value owl_stub_106_cblas_zhpr_byte7(value* argv, int argc)
{
   value x3494 = argv[6];
   value x3495 = argv[5];
   value x3496 = argv[4];
   value x3497 = argv[3];
   value x3498 = argv[2];
   value x3499 = argv[1];
   value x3500 = argv[0];
   return
     owl_stub_106_cblas_zhpr(x3500, x3499, x3498, x3497, x3496, x3495, x3494);
}
value owl_stub_107_cblas_cher2(value x3510, value x3509, value x3508,
                               value x3507, value x3506, value x3505,
                               value x3504, value x3503, value x3502,
                               value x3501)
{
   int x3511 = Long_val(x3510);
   int x3514 = Long_val(x3509);
   int x3517 = Long_val(x3508);
   float _Complex* x3520 = CTYPES_ADDR_OF_FATPTR(x3507);
   float _Complex* x3521 = CTYPES_ADDR_OF_FATPTR(x3506);
   int x3522 = Long_val(x3505);
   float _Complex* x3525 = CTYPES_ADDR_OF_FATPTR(x3504);
   int x3526 = Long_val(x3503);
   float _Complex* x3529 = CTYPES_ADDR_OF_FATPTR(x3502);
   int x3530 = Long_val(x3501);
   cblas_cher2(x3511, x3514, x3517, x3520, x3521, x3522, x3525, x3526, 
               x3529, x3530);
   return Val_unit;
}
value owl_stub_107_cblas_cher2_byte10(value* argv, int argc)
{
   value x3534 = argv[9];
   value x3535 = argv[8];
   value x3536 = argv[7];
   value x3537 = argv[6];
   value x3538 = argv[5];
   value x3539 = argv[4];
   value x3540 = argv[3];
   value x3541 = argv[2];
   value x3542 = argv[1];
   value x3543 = argv[0];
   return
     owl_stub_107_cblas_cher2(x3543, x3542, x3541, x3540, x3539, x3538,
                              x3537, x3536, x3535, x3534);
}
value owl_stub_108_cblas_zher2(value x3553, value x3552, value x3551,
                               value x3550, value x3549, value x3548,
                               value x3547, value x3546, value x3545,
                               value x3544)
{
   int x3554 = Long_val(x3553);
   int x3557 = Long_val(x3552);
   int x3560 = Long_val(x3551);
   double _Complex* x3563 = CTYPES_ADDR_OF_FATPTR(x3550);
   double _Complex* x3564 = CTYPES_ADDR_OF_FATPTR(x3549);
   int x3565 = Long_val(x3548);
   double _Complex* x3568 = CTYPES_ADDR_OF_FATPTR(x3547);
   int x3569 = Long_val(x3546);
   double _Complex* x3572 = CTYPES_ADDR_OF_FATPTR(x3545);
   int x3573 = Long_val(x3544);
   cblas_zher2(x3554, x3557, x3560, x3563, x3564, x3565, x3568, x3569, 
               x3572, x3573);
   return Val_unit;
}
value owl_stub_108_cblas_zher2_byte10(value* argv, int argc)
{
   value x3577 = argv[9];
   value x3578 = argv[8];
   value x3579 = argv[7];
   value x3580 = argv[6];
   value x3581 = argv[5];
   value x3582 = argv[4];
   value x3583 = argv[3];
   value x3584 = argv[2];
   value x3585 = argv[1];
   value x3586 = argv[0];
   return
     owl_stub_108_cblas_zher2(x3586, x3585, x3584, x3583, x3582, x3581,
                              x3580, x3579, x3578, x3577);
}
value owl_stub_109_cblas_chpr2(value x3595, value x3594, value x3593,
                               value x3592, value x3591, value x3590,
                               value x3589, value x3588, value x3587)
{
   int x3596 = Long_val(x3595);
   int x3599 = Long_val(x3594);
   int x3602 = Long_val(x3593);
   float _Complex* x3605 = CTYPES_ADDR_OF_FATPTR(x3592);
   float _Complex* x3606 = CTYPES_ADDR_OF_FATPTR(x3591);
   int x3607 = Long_val(x3590);
   float _Complex* x3610 = CTYPES_ADDR_OF_FATPTR(x3589);
   int x3611 = Long_val(x3588);
   float _Complex* x3614 = CTYPES_ADDR_OF_FATPTR(x3587);
   cblas_chpr2(x3596, x3599, x3602, x3605, x3606, x3607, x3610, x3611, x3614);
   return Val_unit;
}
value owl_stub_109_cblas_chpr2_byte9(value* argv, int argc)
{
   value x3616 = argv[8];
   value x3617 = argv[7];
   value x3618 = argv[6];
   value x3619 = argv[5];
   value x3620 = argv[4];
   value x3621 = argv[3];
   value x3622 = argv[2];
   value x3623 = argv[1];
   value x3624 = argv[0];
   return
     owl_stub_109_cblas_chpr2(x3624, x3623, x3622, x3621, x3620, x3619,
                              x3618, x3617, x3616);
}
value owl_stub_110_cblas_zhpr2(value x3633, value x3632, value x3631,
                               value x3630, value x3629, value x3628,
                               value x3627, value x3626, value x3625)
{
   int x3634 = Long_val(x3633);
   int x3637 = Long_val(x3632);
   int x3640 = Long_val(x3631);
   double _Complex* x3643 = CTYPES_ADDR_OF_FATPTR(x3630);
   double _Complex* x3644 = CTYPES_ADDR_OF_FATPTR(x3629);
   int x3645 = Long_val(x3628);
   double _Complex* x3648 = CTYPES_ADDR_OF_FATPTR(x3627);
   int x3649 = Long_val(x3626);
   double _Complex* x3652 = CTYPES_ADDR_OF_FATPTR(x3625);
   cblas_zhpr2(x3634, x3637, x3640, x3643, x3644, x3645, x3648, x3649, x3652);
   return Val_unit;
}
value owl_stub_110_cblas_zhpr2_byte9(value* argv, int argc)
{
   value x3654 = argv[8];
   value x3655 = argv[7];
   value x3656 = argv[6];
   value x3657 = argv[5];
   value x3658 = argv[4];
   value x3659 = argv[3];
   value x3660 = argv[2];
   value x3661 = argv[1];
   value x3662 = argv[0];
   return
     owl_stub_110_cblas_zhpr2(x3662, x3661, x3660, x3659, x3658, x3657,
                              x3656, x3655, x3654);
}
value owl_stub_111_cblas_sgemm(value x3676, value x3675, value x3674,
                               value x3673, value x3672, value x3671,
                               value x3670, value x3669, value x3668,
                               value x3667, value x3666, value x3665,
                               value x3664, value x3663)
{
   int x3677 = Long_val(x3676);
   int x3680 = Long_val(x3675);
   int x3683 = Long_val(x3674);
   int x3686 = Long_val(x3673);
   int x3689 = Long_val(x3672);
   int x3692 = Long_val(x3671);
   double x3695 = Double_val(x3670);
   float* x3698 = CTYPES_ADDR_OF_FATPTR(x3669);
   int x3699 = Long_val(x3668);
   float* x3702 = CTYPES_ADDR_OF_FATPTR(x3667);
   int x3703 = Long_val(x3666);
   double x3706 = Double_val(x3665);
   float* x3709 = CTYPES_ADDR_OF_FATPTR(x3664);
   int x3710 = Long_val(x3663);
   cblas_sgemm(x3677, x3680, x3683, x3686, x3689, x3692, (float)x3695, 
               x3698, x3699, x3702, x3703, (float)x3706, x3709, x3710);
   return Val_unit;
}
value owl_stub_111_cblas_sgemm_byte14(value* argv, int argc)
{
   value x3714 = argv[13];
   value x3715 = argv[12];
   value x3716 = argv[11];
   value x3717 = argv[10];
   value x3718 = argv[9];
   value x3719 = argv[8];
   value x3720 = argv[7];
   value x3721 = argv[6];
   value x3722 = argv[5];
   value x3723 = argv[4];
   value x3724 = argv[3];
   value x3725 = argv[2];
   value x3726 = argv[1];
   value x3727 = argv[0];
   return
     owl_stub_111_cblas_sgemm(x3727, x3726, x3725, x3724, x3723, x3722,
                              x3721, x3720, x3719, x3718, x3717, x3716,
                              x3715, x3714);
}
value owl_stub_112_cblas_dgemm(value x3741, value x3740, value x3739,
                               value x3738, value x3737, value x3736,
                               value x3735, value x3734, value x3733,
                               value x3732, value x3731, value x3730,
                               value x3729, value x3728)
{
   int x3742 = Long_val(x3741);
   int x3745 = Long_val(x3740);
   int x3748 = Long_val(x3739);
   int x3751 = Long_val(x3738);
   int x3754 = Long_val(x3737);
   int x3757 = Long_val(x3736);
   double x3760 = Double_val(x3735);
   double* x3763 = CTYPES_ADDR_OF_FATPTR(x3734);
   int x3764 = Long_val(x3733);
   double* x3767 = CTYPES_ADDR_OF_FATPTR(x3732);
   int x3768 = Long_val(x3731);
   double x3771 = Double_val(x3730);
   double* x3774 = CTYPES_ADDR_OF_FATPTR(x3729);
   int x3775 = Long_val(x3728);
   cblas_dgemm(x3742, x3745, x3748, x3751, x3754, x3757, x3760, x3763, 
               x3764, x3767, x3768, x3771, x3774, x3775);
   return Val_unit;
}
value owl_stub_112_cblas_dgemm_byte14(value* argv, int argc)
{
   value x3779 = argv[13];
   value x3780 = argv[12];
   value x3781 = argv[11];
   value x3782 = argv[10];
   value x3783 = argv[9];
   value x3784 = argv[8];
   value x3785 = argv[7];
   value x3786 = argv[6];
   value x3787 = argv[5];
   value x3788 = argv[4];
   value x3789 = argv[3];
   value x3790 = argv[2];
   value x3791 = argv[1];
   value x3792 = argv[0];
   return
     owl_stub_112_cblas_dgemm(x3792, x3791, x3790, x3789, x3788, x3787,
                              x3786, x3785, x3784, x3783, x3782, x3781,
                              x3780, x3779);
}
value owl_stub_113_cblas_cgemm(value x3806, value x3805, value x3804,
                               value x3803, value x3802, value x3801,
                               value x3800, value x3799, value x3798,
                               value x3797, value x3796, value x3795,
                               value x3794, value x3793)
{
   int x3807 = Long_val(x3806);
   int x3810 = Long_val(x3805);
   int x3813 = Long_val(x3804);
   int x3816 = Long_val(x3803);
   int x3819 = Long_val(x3802);
   int x3822 = Long_val(x3801);
   float _Complex* x3825 = CTYPES_ADDR_OF_FATPTR(x3800);
   float _Complex* x3826 = CTYPES_ADDR_OF_FATPTR(x3799);
   int x3827 = Long_val(x3798);
   float _Complex* x3830 = CTYPES_ADDR_OF_FATPTR(x3797);
   int x3831 = Long_val(x3796);
   float _Complex* x3834 = CTYPES_ADDR_OF_FATPTR(x3795);
   float _Complex* x3835 = CTYPES_ADDR_OF_FATPTR(x3794);
   int x3836 = Long_val(x3793);
   cblas_cgemm(x3807, x3810, x3813, x3816, x3819, x3822, x3825, x3826, 
               x3827, x3830, x3831, x3834, x3835, x3836);
   return Val_unit;
}
value owl_stub_113_cblas_cgemm_byte14(value* argv, int argc)
{
   value x3840 = argv[13];
   value x3841 = argv[12];
   value x3842 = argv[11];
   value x3843 = argv[10];
   value x3844 = argv[9];
   value x3845 = argv[8];
   value x3846 = argv[7];
   value x3847 = argv[6];
   value x3848 = argv[5];
   value x3849 = argv[4];
   value x3850 = argv[3];
   value x3851 = argv[2];
   value x3852 = argv[1];
   value x3853 = argv[0];
   return
     owl_stub_113_cblas_cgemm(x3853, x3852, x3851, x3850, x3849, x3848,
                              x3847, x3846, x3845, x3844, x3843, x3842,
                              x3841, x3840);
}
value owl_stub_114_cblas_zgemm(value x3867, value x3866, value x3865,
                               value x3864, value x3863, value x3862,
                               value x3861, value x3860, value x3859,
                               value x3858, value x3857, value x3856,
                               value x3855, value x3854)
{
   int x3868 = Long_val(x3867);
   int x3871 = Long_val(x3866);
   int x3874 = Long_val(x3865);
   int x3877 = Long_val(x3864);
   int x3880 = Long_val(x3863);
   int x3883 = Long_val(x3862);
   double _Complex* x3886 = CTYPES_ADDR_OF_FATPTR(x3861);
   double _Complex* x3887 = CTYPES_ADDR_OF_FATPTR(x3860);
   int x3888 = Long_val(x3859);
   double _Complex* x3891 = CTYPES_ADDR_OF_FATPTR(x3858);
   int x3892 = Long_val(x3857);
   double _Complex* x3895 = CTYPES_ADDR_OF_FATPTR(x3856);
   double _Complex* x3896 = CTYPES_ADDR_OF_FATPTR(x3855);
   int x3897 = Long_val(x3854);
   cblas_zgemm(x3868, x3871, x3874, x3877, x3880, x3883, x3886, x3887, 
               x3888, x3891, x3892, x3895, x3896, x3897);
   return Val_unit;
}
value owl_stub_114_cblas_zgemm_byte14(value* argv, int argc)
{
   value x3901 = argv[13];
   value x3902 = argv[12];
   value x3903 = argv[11];
   value x3904 = argv[10];
   value x3905 = argv[9];
   value x3906 = argv[8];
   value x3907 = argv[7];
   value x3908 = argv[6];
   value x3909 = argv[5];
   value x3910 = argv[4];
   value x3911 = argv[3];
   value x3912 = argv[2];
   value x3913 = argv[1];
   value x3914 = argv[0];
   return
     owl_stub_114_cblas_zgemm(x3914, x3913, x3912, x3911, x3910, x3909,
                              x3908, x3907, x3906, x3905, x3904, x3903,
                              x3902, x3901);
}
value owl_stub_115_cblas_ssymm(value x3927, value x3926, value x3925,
                               value x3924, value x3923, value x3922,
                               value x3921, value x3920, value x3919,
                               value x3918, value x3917, value x3916,
                               value x3915)
{
   int x3928 = Long_val(x3927);
   int x3931 = Long_val(x3926);
   int x3934 = Long_val(x3925);
   int x3937 = Long_val(x3924);
   int x3940 = Long_val(x3923);
   double x3943 = Double_val(x3922);
   float* x3946 = CTYPES_ADDR_OF_FATPTR(x3921);
   int x3947 = Long_val(x3920);
   float* x3950 = CTYPES_ADDR_OF_FATPTR(x3919);
   int x3951 = Long_val(x3918);
   double x3954 = Double_val(x3917);
   float* x3957 = CTYPES_ADDR_OF_FATPTR(x3916);
   int x3958 = Long_val(x3915);
   cblas_ssymm(x3928, x3931, x3934, x3937, x3940, (float)x3943, x3946, 
               x3947, x3950, x3951, (float)x3954, x3957, x3958);
   return Val_unit;
}
value owl_stub_115_cblas_ssymm_byte13(value* argv, int argc)
{
   value x3962 = argv[12];
   value x3963 = argv[11];
   value x3964 = argv[10];
   value x3965 = argv[9];
   value x3966 = argv[8];
   value x3967 = argv[7];
   value x3968 = argv[6];
   value x3969 = argv[5];
   value x3970 = argv[4];
   value x3971 = argv[3];
   value x3972 = argv[2];
   value x3973 = argv[1];
   value x3974 = argv[0];
   return
     owl_stub_115_cblas_ssymm(x3974, x3973, x3972, x3971, x3970, x3969,
                              x3968, x3967, x3966, x3965, x3964, x3963,
                              x3962);
}
value owl_stub_116_cblas_dsymm(value x3987, value x3986, value x3985,
                               value x3984, value x3983, value x3982,
                               value x3981, value x3980, value x3979,
                               value x3978, value x3977, value x3976,
                               value x3975)
{
   int x3988 = Long_val(x3987);
   int x3991 = Long_val(x3986);
   int x3994 = Long_val(x3985);
   int x3997 = Long_val(x3984);
   int x4000 = Long_val(x3983);
   double x4003 = Double_val(x3982);
   double* x4006 = CTYPES_ADDR_OF_FATPTR(x3981);
   int x4007 = Long_val(x3980);
   double* x4010 = CTYPES_ADDR_OF_FATPTR(x3979);
   int x4011 = Long_val(x3978);
   double x4014 = Double_val(x3977);
   double* x4017 = CTYPES_ADDR_OF_FATPTR(x3976);
   int x4018 = Long_val(x3975);
   cblas_dsymm(x3988, x3991, x3994, x3997, x4000, x4003, x4006, x4007, 
               x4010, x4011, x4014, x4017, x4018);
   return Val_unit;
}
value owl_stub_116_cblas_dsymm_byte13(value* argv, int argc)
{
   value x4022 = argv[12];
   value x4023 = argv[11];
   value x4024 = argv[10];
   value x4025 = argv[9];
   value x4026 = argv[8];
   value x4027 = argv[7];
   value x4028 = argv[6];
   value x4029 = argv[5];
   value x4030 = argv[4];
   value x4031 = argv[3];
   value x4032 = argv[2];
   value x4033 = argv[1];
   value x4034 = argv[0];
   return
     owl_stub_116_cblas_dsymm(x4034, x4033, x4032, x4031, x4030, x4029,
                              x4028, x4027, x4026, x4025, x4024, x4023,
                              x4022);
}
value owl_stub_117_cblas_csymm(value x4047, value x4046, value x4045,
                               value x4044, value x4043, value x4042,
                               value x4041, value x4040, value x4039,
                               value x4038, value x4037, value x4036,
                               value x4035)
{
   int x4048 = Long_val(x4047);
   int x4051 = Long_val(x4046);
   int x4054 = Long_val(x4045);
   int x4057 = Long_val(x4044);
   int x4060 = Long_val(x4043);
   float _Complex* x4063 = CTYPES_ADDR_OF_FATPTR(x4042);
   float _Complex* x4064 = CTYPES_ADDR_OF_FATPTR(x4041);
   int x4065 = Long_val(x4040);
   float _Complex* x4068 = CTYPES_ADDR_OF_FATPTR(x4039);
   int x4069 = Long_val(x4038);
   float _Complex* x4072 = CTYPES_ADDR_OF_FATPTR(x4037);
   float _Complex* x4073 = CTYPES_ADDR_OF_FATPTR(x4036);
   int x4074 = Long_val(x4035);
   cblas_csymm(x4048, x4051, x4054, x4057, x4060, x4063, x4064, x4065, 
               x4068, x4069, x4072, x4073, x4074);
   return Val_unit;
}
value owl_stub_117_cblas_csymm_byte13(value* argv, int argc)
{
   value x4078 = argv[12];
   value x4079 = argv[11];
   value x4080 = argv[10];
   value x4081 = argv[9];
   value x4082 = argv[8];
   value x4083 = argv[7];
   value x4084 = argv[6];
   value x4085 = argv[5];
   value x4086 = argv[4];
   value x4087 = argv[3];
   value x4088 = argv[2];
   value x4089 = argv[1];
   value x4090 = argv[0];
   return
     owl_stub_117_cblas_csymm(x4090, x4089, x4088, x4087, x4086, x4085,
                              x4084, x4083, x4082, x4081, x4080, x4079,
                              x4078);
}
value owl_stub_118_cblas_zsymm(value x4103, value x4102, value x4101,
                               value x4100, value x4099, value x4098,
                               value x4097, value x4096, value x4095,
                               value x4094, value x4093, value x4092,
                               value x4091)
{
   int x4104 = Long_val(x4103);
   int x4107 = Long_val(x4102);
   int x4110 = Long_val(x4101);
   int x4113 = Long_val(x4100);
   int x4116 = Long_val(x4099);
   double _Complex* x4119 = CTYPES_ADDR_OF_FATPTR(x4098);
   double _Complex* x4120 = CTYPES_ADDR_OF_FATPTR(x4097);
   int x4121 = Long_val(x4096);
   double _Complex* x4124 = CTYPES_ADDR_OF_FATPTR(x4095);
   int x4125 = Long_val(x4094);
   double _Complex* x4128 = CTYPES_ADDR_OF_FATPTR(x4093);
   double _Complex* x4129 = CTYPES_ADDR_OF_FATPTR(x4092);
   int x4130 = Long_val(x4091);
   cblas_zsymm(x4104, x4107, x4110, x4113, x4116, x4119, x4120, x4121, 
               x4124, x4125, x4128, x4129, x4130);
   return Val_unit;
}
value owl_stub_118_cblas_zsymm_byte13(value* argv, int argc)
{
   value x4134 = argv[12];
   value x4135 = argv[11];
   value x4136 = argv[10];
   value x4137 = argv[9];
   value x4138 = argv[8];
   value x4139 = argv[7];
   value x4140 = argv[6];
   value x4141 = argv[5];
   value x4142 = argv[4];
   value x4143 = argv[3];
   value x4144 = argv[2];
   value x4145 = argv[1];
   value x4146 = argv[0];
   return
     owl_stub_118_cblas_zsymm(x4146, x4145, x4144, x4143, x4142, x4141,
                              x4140, x4139, x4138, x4137, x4136, x4135,
                              x4134);
}
value owl_stub_119_cblas_ssyrk(value x4157, value x4156, value x4155,
                               value x4154, value x4153, value x4152,
                               value x4151, value x4150, value x4149,
                               value x4148, value x4147)
{
   int x4158 = Long_val(x4157);
   int x4161 = Long_val(x4156);
   int x4164 = Long_val(x4155);
   int x4167 = Long_val(x4154);
   int x4170 = Long_val(x4153);
   double x4173 = Double_val(x4152);
   float* x4176 = CTYPES_ADDR_OF_FATPTR(x4151);
   int x4177 = Long_val(x4150);
   double x4180 = Double_val(x4149);
   float* x4183 = CTYPES_ADDR_OF_FATPTR(x4148);
   int x4184 = Long_val(x4147);
   cblas_ssyrk(x4158, x4161, x4164, x4167, x4170, (float)x4173, x4176, 
               x4177, (float)x4180, x4183, x4184);
   return Val_unit;
}
value owl_stub_119_cblas_ssyrk_byte11(value* argv, int argc)
{
   value x4188 = argv[10];
   value x4189 = argv[9];
   value x4190 = argv[8];
   value x4191 = argv[7];
   value x4192 = argv[6];
   value x4193 = argv[5];
   value x4194 = argv[4];
   value x4195 = argv[3];
   value x4196 = argv[2];
   value x4197 = argv[1];
   value x4198 = argv[0];
   return
     owl_stub_119_cblas_ssyrk(x4198, x4197, x4196, x4195, x4194, x4193,
                              x4192, x4191, x4190, x4189, x4188);
}
value owl_stub_120_cblas_dsyrk(value x4209, value x4208, value x4207,
                               value x4206, value x4205, value x4204,
                               value x4203, value x4202, value x4201,
                               value x4200, value x4199)
{
   int x4210 = Long_val(x4209);
   int x4213 = Long_val(x4208);
   int x4216 = Long_val(x4207);
   int x4219 = Long_val(x4206);
   int x4222 = Long_val(x4205);
   double x4225 = Double_val(x4204);
   double* x4228 = CTYPES_ADDR_OF_FATPTR(x4203);
   int x4229 = Long_val(x4202);
   double x4232 = Double_val(x4201);
   double* x4235 = CTYPES_ADDR_OF_FATPTR(x4200);
   int x4236 = Long_val(x4199);
   cblas_dsyrk(x4210, x4213, x4216, x4219, x4222, x4225, x4228, x4229, 
               x4232, x4235, x4236);
   return Val_unit;
}
value owl_stub_120_cblas_dsyrk_byte11(value* argv, int argc)
{
   value x4240 = argv[10];
   value x4241 = argv[9];
   value x4242 = argv[8];
   value x4243 = argv[7];
   value x4244 = argv[6];
   value x4245 = argv[5];
   value x4246 = argv[4];
   value x4247 = argv[3];
   value x4248 = argv[2];
   value x4249 = argv[1];
   value x4250 = argv[0];
   return
     owl_stub_120_cblas_dsyrk(x4250, x4249, x4248, x4247, x4246, x4245,
                              x4244, x4243, x4242, x4241, x4240);
}
value owl_stub_121_cblas_csyrk(value x4261, value x4260, value x4259,
                               value x4258, value x4257, value x4256,
                               value x4255, value x4254, value x4253,
                               value x4252, value x4251)
{
   int x4262 = Long_val(x4261);
   int x4265 = Long_val(x4260);
   int x4268 = Long_val(x4259);
   int x4271 = Long_val(x4258);
   int x4274 = Long_val(x4257);
   float _Complex* x4277 = CTYPES_ADDR_OF_FATPTR(x4256);
   float _Complex* x4278 = CTYPES_ADDR_OF_FATPTR(x4255);
   int x4279 = Long_val(x4254);
   float _Complex* x4282 = CTYPES_ADDR_OF_FATPTR(x4253);
   float _Complex* x4283 = CTYPES_ADDR_OF_FATPTR(x4252);
   int x4284 = Long_val(x4251);
   cblas_csyrk(x4262, x4265, x4268, x4271, x4274, x4277, x4278, x4279, 
               x4282, x4283, x4284);
   return Val_unit;
}
value owl_stub_121_cblas_csyrk_byte11(value* argv, int argc)
{
   value x4288 = argv[10];
   value x4289 = argv[9];
   value x4290 = argv[8];
   value x4291 = argv[7];
   value x4292 = argv[6];
   value x4293 = argv[5];
   value x4294 = argv[4];
   value x4295 = argv[3];
   value x4296 = argv[2];
   value x4297 = argv[1];
   value x4298 = argv[0];
   return
     owl_stub_121_cblas_csyrk(x4298, x4297, x4296, x4295, x4294, x4293,
                              x4292, x4291, x4290, x4289, x4288);
}
value owl_stub_122_cblas_zsyrk(value x4309, value x4308, value x4307,
                               value x4306, value x4305, value x4304,
                               value x4303, value x4302, value x4301,
                               value x4300, value x4299)
{
   int x4310 = Long_val(x4309);
   int x4313 = Long_val(x4308);
   int x4316 = Long_val(x4307);
   int x4319 = Long_val(x4306);
   int x4322 = Long_val(x4305);
   double _Complex* x4325 = CTYPES_ADDR_OF_FATPTR(x4304);
   double _Complex* x4326 = CTYPES_ADDR_OF_FATPTR(x4303);
   int x4327 = Long_val(x4302);
   double _Complex* x4330 = CTYPES_ADDR_OF_FATPTR(x4301);
   double _Complex* x4331 = CTYPES_ADDR_OF_FATPTR(x4300);
   int x4332 = Long_val(x4299);
   cblas_zsyrk(x4310, x4313, x4316, x4319, x4322, x4325, x4326, x4327, 
               x4330, x4331, x4332);
   return Val_unit;
}
value owl_stub_122_cblas_zsyrk_byte11(value* argv, int argc)
{
   value x4336 = argv[10];
   value x4337 = argv[9];
   value x4338 = argv[8];
   value x4339 = argv[7];
   value x4340 = argv[6];
   value x4341 = argv[5];
   value x4342 = argv[4];
   value x4343 = argv[3];
   value x4344 = argv[2];
   value x4345 = argv[1];
   value x4346 = argv[0];
   return
     owl_stub_122_cblas_zsyrk(x4346, x4345, x4344, x4343, x4342, x4341,
                              x4340, x4339, x4338, x4337, x4336);
}
value owl_stub_123_cblas_ssyr2k(value x4359, value x4358, value x4357,
                                value x4356, value x4355, value x4354,
                                value x4353, value x4352, value x4351,
                                value x4350, value x4349, value x4348,
                                value x4347)
{
   int x4360 = Long_val(x4359);
   int x4363 = Long_val(x4358);
   int x4366 = Long_val(x4357);
   int x4369 = Long_val(x4356);
   int x4372 = Long_val(x4355);
   double x4375 = Double_val(x4354);
   float* x4378 = CTYPES_ADDR_OF_FATPTR(x4353);
   int x4379 = Long_val(x4352);
   float* x4382 = CTYPES_ADDR_OF_FATPTR(x4351);
   int x4383 = Long_val(x4350);
   double x4386 = Double_val(x4349);
   float* x4389 = CTYPES_ADDR_OF_FATPTR(x4348);
   int x4390 = Long_val(x4347);
   cblas_ssyr2k(x4360, x4363, x4366, x4369, x4372, (float)x4375, x4378,
                x4379, x4382, x4383, (float)x4386, x4389, x4390);
   return Val_unit;
}
value owl_stub_123_cblas_ssyr2k_byte13(value* argv, int argc)
{
   value x4394 = argv[12];
   value x4395 = argv[11];
   value x4396 = argv[10];
   value x4397 = argv[9];
   value x4398 = argv[8];
   value x4399 = argv[7];
   value x4400 = argv[6];
   value x4401 = argv[5];
   value x4402 = argv[4];
   value x4403 = argv[3];
   value x4404 = argv[2];
   value x4405 = argv[1];
   value x4406 = argv[0];
   return
     owl_stub_123_cblas_ssyr2k(x4406, x4405, x4404, x4403, x4402, x4401,
                               x4400, x4399, x4398, x4397, x4396, x4395,
                               x4394);
}
value owl_stub_124_cblas_dsyr2k(value x4419, value x4418, value x4417,
                                value x4416, value x4415, value x4414,
                                value x4413, value x4412, value x4411,
                                value x4410, value x4409, value x4408,
                                value x4407)
{
   int x4420 = Long_val(x4419);
   int x4423 = Long_val(x4418);
   int x4426 = Long_val(x4417);
   int x4429 = Long_val(x4416);
   int x4432 = Long_val(x4415);
   double x4435 = Double_val(x4414);
   double* x4438 = CTYPES_ADDR_OF_FATPTR(x4413);
   int x4439 = Long_val(x4412);
   double* x4442 = CTYPES_ADDR_OF_FATPTR(x4411);
   int x4443 = Long_val(x4410);
   double x4446 = Double_val(x4409);
   double* x4449 = CTYPES_ADDR_OF_FATPTR(x4408);
   int x4450 = Long_val(x4407);
   cblas_dsyr2k(x4420, x4423, x4426, x4429, x4432, x4435, x4438, x4439,
                x4442, x4443, x4446, x4449, x4450);
   return Val_unit;
}
value owl_stub_124_cblas_dsyr2k_byte13(value* argv, int argc)
{
   value x4454 = argv[12];
   value x4455 = argv[11];
   value x4456 = argv[10];
   value x4457 = argv[9];
   value x4458 = argv[8];
   value x4459 = argv[7];
   value x4460 = argv[6];
   value x4461 = argv[5];
   value x4462 = argv[4];
   value x4463 = argv[3];
   value x4464 = argv[2];
   value x4465 = argv[1];
   value x4466 = argv[0];
   return
     owl_stub_124_cblas_dsyr2k(x4466, x4465, x4464, x4463, x4462, x4461,
                               x4460, x4459, x4458, x4457, x4456, x4455,
                               x4454);
}
value owl_stub_125_cblas_csyr2k(value x4479, value x4478, value x4477,
                                value x4476, value x4475, value x4474,
                                value x4473, value x4472, value x4471,
                                value x4470, value x4469, value x4468,
                                value x4467)
{
   int x4480 = Long_val(x4479);
   int x4483 = Long_val(x4478);
   int x4486 = Long_val(x4477);
   int x4489 = Long_val(x4476);
   int x4492 = Long_val(x4475);
   float _Complex* x4495 = CTYPES_ADDR_OF_FATPTR(x4474);
   float _Complex* x4496 = CTYPES_ADDR_OF_FATPTR(x4473);
   int x4497 = Long_val(x4472);
   float _Complex* x4500 = CTYPES_ADDR_OF_FATPTR(x4471);
   int x4501 = Long_val(x4470);
   float _Complex* x4504 = CTYPES_ADDR_OF_FATPTR(x4469);
   float _Complex* x4505 = CTYPES_ADDR_OF_FATPTR(x4468);
   int x4506 = Long_val(x4467);
   cblas_csyr2k(x4480, x4483, x4486, x4489, x4492, x4495, x4496, x4497,
                x4500, x4501, x4504, x4505, x4506);
   return Val_unit;
}
value owl_stub_125_cblas_csyr2k_byte13(value* argv, int argc)
{
   value x4510 = argv[12];
   value x4511 = argv[11];
   value x4512 = argv[10];
   value x4513 = argv[9];
   value x4514 = argv[8];
   value x4515 = argv[7];
   value x4516 = argv[6];
   value x4517 = argv[5];
   value x4518 = argv[4];
   value x4519 = argv[3];
   value x4520 = argv[2];
   value x4521 = argv[1];
   value x4522 = argv[0];
   return
     owl_stub_125_cblas_csyr2k(x4522, x4521, x4520, x4519, x4518, x4517,
                               x4516, x4515, x4514, x4513, x4512, x4511,
                               x4510);
}
value owl_stub_126_cblas_zsyr2k(value x4535, value x4534, value x4533,
                                value x4532, value x4531, value x4530,
                                value x4529, value x4528, value x4527,
                                value x4526, value x4525, value x4524,
                                value x4523)
{
   int x4536 = Long_val(x4535);
   int x4539 = Long_val(x4534);
   int x4542 = Long_val(x4533);
   int x4545 = Long_val(x4532);
   int x4548 = Long_val(x4531);
   double _Complex* x4551 = CTYPES_ADDR_OF_FATPTR(x4530);
   double _Complex* x4552 = CTYPES_ADDR_OF_FATPTR(x4529);
   int x4553 = Long_val(x4528);
   double _Complex* x4556 = CTYPES_ADDR_OF_FATPTR(x4527);
   int x4557 = Long_val(x4526);
   double _Complex* x4560 = CTYPES_ADDR_OF_FATPTR(x4525);
   double _Complex* x4561 = CTYPES_ADDR_OF_FATPTR(x4524);
   int x4562 = Long_val(x4523);
   cblas_zsyr2k(x4536, x4539, x4542, x4545, x4548, x4551, x4552, x4553,
                x4556, x4557, x4560, x4561, x4562);
   return Val_unit;
}
value owl_stub_126_cblas_zsyr2k_byte13(value* argv, int argc)
{
   value x4566 = argv[12];
   value x4567 = argv[11];
   value x4568 = argv[10];
   value x4569 = argv[9];
   value x4570 = argv[8];
   value x4571 = argv[7];
   value x4572 = argv[6];
   value x4573 = argv[5];
   value x4574 = argv[4];
   value x4575 = argv[3];
   value x4576 = argv[2];
   value x4577 = argv[1];
   value x4578 = argv[0];
   return
     owl_stub_126_cblas_zsyr2k(x4578, x4577, x4576, x4575, x4574, x4573,
                               x4572, x4571, x4570, x4569, x4568, x4567,
                               x4566);
}
value owl_stub_127_cblas_strmm(value x4590, value x4589, value x4588,
                               value x4587, value x4586, value x4585,
                               value x4584, value x4583, value x4582,
                               value x4581, value x4580, value x4579)
{
   int x4591 = Long_val(x4590);
   int x4594 = Long_val(x4589);
   int x4597 = Long_val(x4588);
   int x4600 = Long_val(x4587);
   int x4603 = Long_val(x4586);
   int x4606 = Long_val(x4585);
   int x4609 = Long_val(x4584);
   double x4612 = Double_val(x4583);
   float* x4615 = CTYPES_ADDR_OF_FATPTR(x4582);
   int x4616 = Long_val(x4581);
   float* x4619 = CTYPES_ADDR_OF_FATPTR(x4580);
   int x4620 = Long_val(x4579);
   cblas_strmm(x4591, x4594, x4597, x4600, x4603, x4606, x4609, (float)x4612,
               x4615, x4616, x4619, x4620);
   return Val_unit;
}
value owl_stub_127_cblas_strmm_byte12(value* argv, int argc)
{
   value x4624 = argv[11];
   value x4625 = argv[10];
   value x4626 = argv[9];
   value x4627 = argv[8];
   value x4628 = argv[7];
   value x4629 = argv[6];
   value x4630 = argv[5];
   value x4631 = argv[4];
   value x4632 = argv[3];
   value x4633 = argv[2];
   value x4634 = argv[1];
   value x4635 = argv[0];
   return
     owl_stub_127_cblas_strmm(x4635, x4634, x4633, x4632, x4631, x4630,
                              x4629, x4628, x4627, x4626, x4625, x4624);
}
value owl_stub_128_cblas_dtrmm(value x4647, value x4646, value x4645,
                               value x4644, value x4643, value x4642,
                               value x4641, value x4640, value x4639,
                               value x4638, value x4637, value x4636)
{
   int x4648 = Long_val(x4647);
   int x4651 = Long_val(x4646);
   int x4654 = Long_val(x4645);
   int x4657 = Long_val(x4644);
   int x4660 = Long_val(x4643);
   int x4663 = Long_val(x4642);
   int x4666 = Long_val(x4641);
   double x4669 = Double_val(x4640);
   double* x4672 = CTYPES_ADDR_OF_FATPTR(x4639);
   int x4673 = Long_val(x4638);
   double* x4676 = CTYPES_ADDR_OF_FATPTR(x4637);
   int x4677 = Long_val(x4636);
   cblas_dtrmm(x4648, x4651, x4654, x4657, x4660, x4663, x4666, x4669, 
               x4672, x4673, x4676, x4677);
   return Val_unit;
}
value owl_stub_128_cblas_dtrmm_byte12(value* argv, int argc)
{
   value x4681 = argv[11];
   value x4682 = argv[10];
   value x4683 = argv[9];
   value x4684 = argv[8];
   value x4685 = argv[7];
   value x4686 = argv[6];
   value x4687 = argv[5];
   value x4688 = argv[4];
   value x4689 = argv[3];
   value x4690 = argv[2];
   value x4691 = argv[1];
   value x4692 = argv[0];
   return
     owl_stub_128_cblas_dtrmm(x4692, x4691, x4690, x4689, x4688, x4687,
                              x4686, x4685, x4684, x4683, x4682, x4681);
}
value owl_stub_129_cblas_ctrmm(value x4704, value x4703, value x4702,
                               value x4701, value x4700, value x4699,
                               value x4698, value x4697, value x4696,
                               value x4695, value x4694, value x4693)
{
   int x4705 = Long_val(x4704);
   int x4708 = Long_val(x4703);
   int x4711 = Long_val(x4702);
   int x4714 = Long_val(x4701);
   int x4717 = Long_val(x4700);
   int x4720 = Long_val(x4699);
   int x4723 = Long_val(x4698);
   float _Complex* x4726 = CTYPES_ADDR_OF_FATPTR(x4697);
   float _Complex* x4727 = CTYPES_ADDR_OF_FATPTR(x4696);
   int x4728 = Long_val(x4695);
   float _Complex* x4731 = CTYPES_ADDR_OF_FATPTR(x4694);
   int x4732 = Long_val(x4693);
   cblas_ctrmm(x4705, x4708, x4711, x4714, x4717, x4720, x4723, x4726, 
               x4727, x4728, x4731, x4732);
   return Val_unit;
}
value owl_stub_129_cblas_ctrmm_byte12(value* argv, int argc)
{
   value x4736 = argv[11];
   value x4737 = argv[10];
   value x4738 = argv[9];
   value x4739 = argv[8];
   value x4740 = argv[7];
   value x4741 = argv[6];
   value x4742 = argv[5];
   value x4743 = argv[4];
   value x4744 = argv[3];
   value x4745 = argv[2];
   value x4746 = argv[1];
   value x4747 = argv[0];
   return
     owl_stub_129_cblas_ctrmm(x4747, x4746, x4745, x4744, x4743, x4742,
                              x4741, x4740, x4739, x4738, x4737, x4736);
}
value owl_stub_130_cblas_ztrmm(value x4759, value x4758, value x4757,
                               value x4756, value x4755, value x4754,
                               value x4753, value x4752, value x4751,
                               value x4750, value x4749, value x4748)
{
   int x4760 = Long_val(x4759);
   int x4763 = Long_val(x4758);
   int x4766 = Long_val(x4757);
   int x4769 = Long_val(x4756);
   int x4772 = Long_val(x4755);
   int x4775 = Long_val(x4754);
   int x4778 = Long_val(x4753);
   double _Complex* x4781 = CTYPES_ADDR_OF_FATPTR(x4752);
   double _Complex* x4782 = CTYPES_ADDR_OF_FATPTR(x4751);
   int x4783 = Long_val(x4750);
   double _Complex* x4786 = CTYPES_ADDR_OF_FATPTR(x4749);
   int x4787 = Long_val(x4748);
   cblas_ztrmm(x4760, x4763, x4766, x4769, x4772, x4775, x4778, x4781, 
               x4782, x4783, x4786, x4787);
   return Val_unit;
}
value owl_stub_130_cblas_ztrmm_byte12(value* argv, int argc)
{
   value x4791 = argv[11];
   value x4792 = argv[10];
   value x4793 = argv[9];
   value x4794 = argv[8];
   value x4795 = argv[7];
   value x4796 = argv[6];
   value x4797 = argv[5];
   value x4798 = argv[4];
   value x4799 = argv[3];
   value x4800 = argv[2];
   value x4801 = argv[1];
   value x4802 = argv[0];
   return
     owl_stub_130_cblas_ztrmm(x4802, x4801, x4800, x4799, x4798, x4797,
                              x4796, x4795, x4794, x4793, x4792, x4791);
}
value owl_stub_131_cblas_strsm(value x4814, value x4813, value x4812,
                               value x4811, value x4810, value x4809,
                               value x4808, value x4807, value x4806,
                               value x4805, value x4804, value x4803)
{
   int x4815 = Long_val(x4814);
   int x4818 = Long_val(x4813);
   int x4821 = Long_val(x4812);
   int x4824 = Long_val(x4811);
   int x4827 = Long_val(x4810);
   int x4830 = Long_val(x4809);
   int x4833 = Long_val(x4808);
   double x4836 = Double_val(x4807);
   float* x4839 = CTYPES_ADDR_OF_FATPTR(x4806);
   int x4840 = Long_val(x4805);
   float* x4843 = CTYPES_ADDR_OF_FATPTR(x4804);
   int x4844 = Long_val(x4803);
   cblas_strsm(x4815, x4818, x4821, x4824, x4827, x4830, x4833, (float)x4836,
               x4839, x4840, x4843, x4844);
   return Val_unit;
}
value owl_stub_131_cblas_strsm_byte12(value* argv, int argc)
{
   value x4848 = argv[11];
   value x4849 = argv[10];
   value x4850 = argv[9];
   value x4851 = argv[8];
   value x4852 = argv[7];
   value x4853 = argv[6];
   value x4854 = argv[5];
   value x4855 = argv[4];
   value x4856 = argv[3];
   value x4857 = argv[2];
   value x4858 = argv[1];
   value x4859 = argv[0];
   return
     owl_stub_131_cblas_strsm(x4859, x4858, x4857, x4856, x4855, x4854,
                              x4853, x4852, x4851, x4850, x4849, x4848);
}
value owl_stub_132_cblas_dtrsm(value x4871, value x4870, value x4869,
                               value x4868, value x4867, value x4866,
                               value x4865, value x4864, value x4863,
                               value x4862, value x4861, value x4860)
{
   int x4872 = Long_val(x4871);
   int x4875 = Long_val(x4870);
   int x4878 = Long_val(x4869);
   int x4881 = Long_val(x4868);
   int x4884 = Long_val(x4867);
   int x4887 = Long_val(x4866);
   int x4890 = Long_val(x4865);
   double x4893 = Double_val(x4864);
   double* x4896 = CTYPES_ADDR_OF_FATPTR(x4863);
   int x4897 = Long_val(x4862);
   double* x4900 = CTYPES_ADDR_OF_FATPTR(x4861);
   int x4901 = Long_val(x4860);
   cblas_dtrsm(x4872, x4875, x4878, x4881, x4884, x4887, x4890, x4893, 
               x4896, x4897, x4900, x4901);
   return Val_unit;
}
value owl_stub_132_cblas_dtrsm_byte12(value* argv, int argc)
{
   value x4905 = argv[11];
   value x4906 = argv[10];
   value x4907 = argv[9];
   value x4908 = argv[8];
   value x4909 = argv[7];
   value x4910 = argv[6];
   value x4911 = argv[5];
   value x4912 = argv[4];
   value x4913 = argv[3];
   value x4914 = argv[2];
   value x4915 = argv[1];
   value x4916 = argv[0];
   return
     owl_stub_132_cblas_dtrsm(x4916, x4915, x4914, x4913, x4912, x4911,
                              x4910, x4909, x4908, x4907, x4906, x4905);
}
value owl_stub_133_cblas_ctrsm(value x4928, value x4927, value x4926,
                               value x4925, value x4924, value x4923,
                               value x4922, value x4921, value x4920,
                               value x4919, value x4918, value x4917)
{
   int x4929 = Long_val(x4928);
   int x4932 = Long_val(x4927);
   int x4935 = Long_val(x4926);
   int x4938 = Long_val(x4925);
   int x4941 = Long_val(x4924);
   int x4944 = Long_val(x4923);
   int x4947 = Long_val(x4922);
   float _Complex* x4950 = CTYPES_ADDR_OF_FATPTR(x4921);
   float _Complex* x4951 = CTYPES_ADDR_OF_FATPTR(x4920);
   int x4952 = Long_val(x4919);
   float _Complex* x4955 = CTYPES_ADDR_OF_FATPTR(x4918);
   int x4956 = Long_val(x4917);
   cblas_ctrsm(x4929, x4932, x4935, x4938, x4941, x4944, x4947, x4950, 
               x4951, x4952, x4955, x4956);
   return Val_unit;
}
value owl_stub_133_cblas_ctrsm_byte12(value* argv, int argc)
{
   value x4960 = argv[11];
   value x4961 = argv[10];
   value x4962 = argv[9];
   value x4963 = argv[8];
   value x4964 = argv[7];
   value x4965 = argv[6];
   value x4966 = argv[5];
   value x4967 = argv[4];
   value x4968 = argv[3];
   value x4969 = argv[2];
   value x4970 = argv[1];
   value x4971 = argv[0];
   return
     owl_stub_133_cblas_ctrsm(x4971, x4970, x4969, x4968, x4967, x4966,
                              x4965, x4964, x4963, x4962, x4961, x4960);
}
value owl_stub_134_cblas_ztrsm(value x4983, value x4982, value x4981,
                               value x4980, value x4979, value x4978,
                               value x4977, value x4976, value x4975,
                               value x4974, value x4973, value x4972)
{
   int x4984 = Long_val(x4983);
   int x4987 = Long_val(x4982);
   int x4990 = Long_val(x4981);
   int x4993 = Long_val(x4980);
   int x4996 = Long_val(x4979);
   int x4999 = Long_val(x4978);
   int x5002 = Long_val(x4977);
   double _Complex* x5005 = CTYPES_ADDR_OF_FATPTR(x4976);
   double _Complex* x5006 = CTYPES_ADDR_OF_FATPTR(x4975);
   int x5007 = Long_val(x4974);
   double _Complex* x5010 = CTYPES_ADDR_OF_FATPTR(x4973);
   int x5011 = Long_val(x4972);
   cblas_ztrsm(x4984, x4987, x4990, x4993, x4996, x4999, x5002, x5005, 
               x5006, x5007, x5010, x5011);
   return Val_unit;
}
value owl_stub_134_cblas_ztrsm_byte12(value* argv, int argc)
{
   value x5015 = argv[11];
   value x5016 = argv[10];
   value x5017 = argv[9];
   value x5018 = argv[8];
   value x5019 = argv[7];
   value x5020 = argv[6];
   value x5021 = argv[5];
   value x5022 = argv[4];
   value x5023 = argv[3];
   value x5024 = argv[2];
   value x5025 = argv[1];
   value x5026 = argv[0];
   return
     owl_stub_134_cblas_ztrsm(x5026, x5025, x5024, x5023, x5022, x5021,
                              x5020, x5019, x5018, x5017, x5016, x5015);
}
value owl_stub_135_cblas_chemm(value x5039, value x5038, value x5037,
                               value x5036, value x5035, value x5034,
                               value x5033, value x5032, value x5031,
                               value x5030, value x5029, value x5028,
                               value x5027)
{
   int x5040 = Long_val(x5039);
   int x5043 = Long_val(x5038);
   int x5046 = Long_val(x5037);
   int x5049 = Long_val(x5036);
   int x5052 = Long_val(x5035);
   float _Complex* x5055 = CTYPES_ADDR_OF_FATPTR(x5034);
   float _Complex* x5056 = CTYPES_ADDR_OF_FATPTR(x5033);
   int x5057 = Long_val(x5032);
   float _Complex* x5060 = CTYPES_ADDR_OF_FATPTR(x5031);
   int x5061 = Long_val(x5030);
   float _Complex* x5064 = CTYPES_ADDR_OF_FATPTR(x5029);
   float _Complex* x5065 = CTYPES_ADDR_OF_FATPTR(x5028);
   int x5066 = Long_val(x5027);
   cblas_chemm(x5040, x5043, x5046, x5049, x5052, x5055, x5056, x5057, 
               x5060, x5061, x5064, x5065, x5066);
   return Val_unit;
}
value owl_stub_135_cblas_chemm_byte13(value* argv, int argc)
{
   value x5070 = argv[12];
   value x5071 = argv[11];
   value x5072 = argv[10];
   value x5073 = argv[9];
   value x5074 = argv[8];
   value x5075 = argv[7];
   value x5076 = argv[6];
   value x5077 = argv[5];
   value x5078 = argv[4];
   value x5079 = argv[3];
   value x5080 = argv[2];
   value x5081 = argv[1];
   value x5082 = argv[0];
   return
     owl_stub_135_cblas_chemm(x5082, x5081, x5080, x5079, x5078, x5077,
                              x5076, x5075, x5074, x5073, x5072, x5071,
                              x5070);
}
value owl_stub_136_cblas_zhemm(value x5095, value x5094, value x5093,
                               value x5092, value x5091, value x5090,
                               value x5089, value x5088, value x5087,
                               value x5086, value x5085, value x5084,
                               value x5083)
{
   int x5096 = Long_val(x5095);
   int x5099 = Long_val(x5094);
   int x5102 = Long_val(x5093);
   int x5105 = Long_val(x5092);
   int x5108 = Long_val(x5091);
   double _Complex* x5111 = CTYPES_ADDR_OF_FATPTR(x5090);
   double _Complex* x5112 = CTYPES_ADDR_OF_FATPTR(x5089);
   int x5113 = Long_val(x5088);
   double _Complex* x5116 = CTYPES_ADDR_OF_FATPTR(x5087);
   int x5117 = Long_val(x5086);
   double _Complex* x5120 = CTYPES_ADDR_OF_FATPTR(x5085);
   double _Complex* x5121 = CTYPES_ADDR_OF_FATPTR(x5084);
   int x5122 = Long_val(x5083);
   cblas_zhemm(x5096, x5099, x5102, x5105, x5108, x5111, x5112, x5113, 
               x5116, x5117, x5120, x5121, x5122);
   return Val_unit;
}
value owl_stub_136_cblas_zhemm_byte13(value* argv, int argc)
{
   value x5126 = argv[12];
   value x5127 = argv[11];
   value x5128 = argv[10];
   value x5129 = argv[9];
   value x5130 = argv[8];
   value x5131 = argv[7];
   value x5132 = argv[6];
   value x5133 = argv[5];
   value x5134 = argv[4];
   value x5135 = argv[3];
   value x5136 = argv[2];
   value x5137 = argv[1];
   value x5138 = argv[0];
   return
     owl_stub_136_cblas_zhemm(x5138, x5137, x5136, x5135, x5134, x5133,
                              x5132, x5131, x5130, x5129, x5128, x5127,
                              x5126);
}
value owl_stub_137_cblas_cherk(value x5149, value x5148, value x5147,
                               value x5146, value x5145, value x5144,
                               value x5143, value x5142, value x5141,
                               value x5140, value x5139)
{
   int x5150 = Long_val(x5149);
   int x5153 = Long_val(x5148);
   int x5156 = Long_val(x5147);
   int x5159 = Long_val(x5146);
   int x5162 = Long_val(x5145);
   double x5165 = Double_val(x5144);
   float _Complex* x5168 = CTYPES_ADDR_OF_FATPTR(x5143);
   int x5169 = Long_val(x5142);
   double x5172 = Double_val(x5141);
   float _Complex* x5175 = CTYPES_ADDR_OF_FATPTR(x5140);
   int x5176 = Long_val(x5139);
   cblas_cherk(x5150, x5153, x5156, x5159, x5162, (float)x5165, x5168, 
               x5169, (float)x5172, x5175, x5176);
   return Val_unit;
}
value owl_stub_137_cblas_cherk_byte11(value* argv, int argc)
{
   value x5180 = argv[10];
   value x5181 = argv[9];
   value x5182 = argv[8];
   value x5183 = argv[7];
   value x5184 = argv[6];
   value x5185 = argv[5];
   value x5186 = argv[4];
   value x5187 = argv[3];
   value x5188 = argv[2];
   value x5189 = argv[1];
   value x5190 = argv[0];
   return
     owl_stub_137_cblas_cherk(x5190, x5189, x5188, x5187, x5186, x5185,
                              x5184, x5183, x5182, x5181, x5180);
}
value owl_stub_138_cblas_zherk(value x5201, value x5200, value x5199,
                               value x5198, value x5197, value x5196,
                               value x5195, value x5194, value x5193,
                               value x5192, value x5191)
{
   int x5202 = Long_val(x5201);
   int x5205 = Long_val(x5200);
   int x5208 = Long_val(x5199);
   int x5211 = Long_val(x5198);
   int x5214 = Long_val(x5197);
   double x5217 = Double_val(x5196);
   double _Complex* x5220 = CTYPES_ADDR_OF_FATPTR(x5195);
   int x5221 = Long_val(x5194);
   double x5224 = Double_val(x5193);
   double _Complex* x5227 = CTYPES_ADDR_OF_FATPTR(x5192);
   int x5228 = Long_val(x5191);
   cblas_zherk(x5202, x5205, x5208, x5211, x5214, x5217, x5220, x5221, 
               x5224, x5227, x5228);
   return Val_unit;
}
value owl_stub_138_cblas_zherk_byte11(value* argv, int argc)
{
   value x5232 = argv[10];
   value x5233 = argv[9];
   value x5234 = argv[8];
   value x5235 = argv[7];
   value x5236 = argv[6];
   value x5237 = argv[5];
   value x5238 = argv[4];
   value x5239 = argv[3];
   value x5240 = argv[2];
   value x5241 = argv[1];
   value x5242 = argv[0];
   return
     owl_stub_138_cblas_zherk(x5242, x5241, x5240, x5239, x5238, x5237,
                              x5236, x5235, x5234, x5233, x5232);
}
value owl_stub_139_cblas_cher2k(value x5255, value x5254, value x5253,
                                value x5252, value x5251, value x5250,
                                value x5249, value x5248, value x5247,
                                value x5246, value x5245, value x5244,
                                value x5243)
{
   int x5256 = Long_val(x5255);
   int x5259 = Long_val(x5254);
   int x5262 = Long_val(x5253);
   int x5265 = Long_val(x5252);
   int x5268 = Long_val(x5251);
   float _Complex* x5271 = CTYPES_ADDR_OF_FATPTR(x5250);
   float _Complex* x5272 = CTYPES_ADDR_OF_FATPTR(x5249);
   int x5273 = Long_val(x5248);
   float _Complex* x5276 = CTYPES_ADDR_OF_FATPTR(x5247);
   int x5277 = Long_val(x5246);
   double x5280 = Double_val(x5245);
   float _Complex* x5283 = CTYPES_ADDR_OF_FATPTR(x5244);
   int x5284 = Long_val(x5243);
   cblas_cher2k(x5256, x5259, x5262, x5265, x5268, x5271, x5272, x5273,
                x5276, x5277, (float)x5280, x5283, x5284);
   return Val_unit;
}
value owl_stub_139_cblas_cher2k_byte13(value* argv, int argc)
{
   value x5288 = argv[12];
   value x5289 = argv[11];
   value x5290 = argv[10];
   value x5291 = argv[9];
   value x5292 = argv[8];
   value x5293 = argv[7];
   value x5294 = argv[6];
   value x5295 = argv[5];
   value x5296 = argv[4];
   value x5297 = argv[3];
   value x5298 = argv[2];
   value x5299 = argv[1];
   value x5300 = argv[0];
   return
     owl_stub_139_cblas_cher2k(x5300, x5299, x5298, x5297, x5296, x5295,
                               x5294, x5293, x5292, x5291, x5290, x5289,
                               x5288);
}
value owl_stub_140_cblas_zher2k(value x5313, value x5312, value x5311,
                                value x5310, value x5309, value x5308,
                                value x5307, value x5306, value x5305,
                                value x5304, value x5303, value x5302,
                                value x5301)
{
   int x5314 = Long_val(x5313);
   int x5317 = Long_val(x5312);
   int x5320 = Long_val(x5311);
   int x5323 = Long_val(x5310);
   int x5326 = Long_val(x5309);
   double _Complex* x5329 = CTYPES_ADDR_OF_FATPTR(x5308);
   double _Complex* x5330 = CTYPES_ADDR_OF_FATPTR(x5307);
   int x5331 = Long_val(x5306);
   double _Complex* x5334 = CTYPES_ADDR_OF_FATPTR(x5305);
   int x5335 = Long_val(x5304);
   double x5338 = Double_val(x5303);
   double _Complex* x5341 = CTYPES_ADDR_OF_FATPTR(x5302);
   int x5342 = Long_val(x5301);
   cblas_zher2k(x5314, x5317, x5320, x5323, x5326, x5329, x5330, x5331,
                x5334, x5335, (float)x5338, x5341, x5342);
   return Val_unit;
}
value owl_stub_140_cblas_zher2k_byte13(value* argv, int argc)
{
   value x5346 = argv[12];
   value x5347 = argv[11];
   value x5348 = argv[10];
   value x5349 = argv[9];
   value x5350 = argv[8];
   value x5351 = argv[7];
   value x5352 = argv[6];
   value x5353 = argv[5];
   value x5354 = argv[4];
   value x5355 = argv[3];
   value x5356 = argv[2];
   value x5357 = argv[1];
   value x5358 = argv[0];
   return
     owl_stub_140_cblas_zher2k(x5358, x5357, x5356, x5355, x5354, x5353,
                               x5352, x5351, x5350, x5349, x5348, x5347,
                               x5346);
}
