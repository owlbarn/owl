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
