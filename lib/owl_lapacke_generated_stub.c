#include "lapacke.h"
#include "ctypes_cstubs_internals.h"
value owl_stub_1_LAPACKE_sbdsdc(value x12, value x11, value x10, value x9,
                                value x8, value x7, value x6, value x5,
                                value x4, value x3, value x2, value x1)
{
   int x13 = Long_val(x12);
   int x16 = Int_val(x11);
   int x19 = Int_val(x10);
   int x22 = Long_val(x9);
   float* x25 = CTYPES_ADDR_OF_FATPTR(x8);
   float* x26 = CTYPES_ADDR_OF_FATPTR(x7);
   float* x27 = CTYPES_ADDR_OF_FATPTR(x6);
   int x28 = Long_val(x5);
   float* x31 = CTYPES_ADDR_OF_FATPTR(x4);
   int x32 = Long_val(x3);
   float* x35 = CTYPES_ADDR_OF_FATPTR(x2);
   int* x36 = CTYPES_ADDR_OF_FATPTR(x1);
   int x37 =
   LAPACKE_sbdsdc(x13, (char)x16, (char)x19, x22, x25, x26, x27, x28, 
                  x31, x32, x35, x36);
   return Val_long(x37);
}
value owl_stub_1_LAPACKE_sbdsdc_byte12(value* argv, int argc)
{
   value x38 = argv[11];
   value x39 = argv[10];
   value x40 = argv[9];
   value x41 = argv[8];
   value x42 = argv[7];
   value x43 = argv[6];
   value x44 = argv[5];
   value x45 = argv[4];
   value x46 = argv[3];
   value x47 = argv[2];
   value x48 = argv[1];
   value x49 = argv[0];
   return
     owl_stub_1_LAPACKE_sbdsdc(x49, x48, x47, x46, x45, x44, x43, x42, 
                               x41, x40, x39, x38);
}
value owl_stub_2_LAPACKE_dbdsdc(value x61, value x60, value x59, value x58,
                                value x57, value x56, value x55, value x54,
                                value x53, value x52, value x51, value x50)
{
   int x62 = Long_val(x61);
   int x65 = Int_val(x60);
   int x68 = Int_val(x59);
   int x71 = Long_val(x58);
   double* x74 = CTYPES_ADDR_OF_FATPTR(x57);
   double* x75 = CTYPES_ADDR_OF_FATPTR(x56);
   double* x76 = CTYPES_ADDR_OF_FATPTR(x55);
   int x77 = Long_val(x54);
   double* x80 = CTYPES_ADDR_OF_FATPTR(x53);
   int x81 = Long_val(x52);
   double* x84 = CTYPES_ADDR_OF_FATPTR(x51);
   int* x85 = CTYPES_ADDR_OF_FATPTR(x50);
   int x86 =
   LAPACKE_dbdsdc(x62, (char)x65, (char)x68, x71, x74, x75, x76, x77, 
                  x80, x81, x84, x85);
   return Val_long(x86);
}
value owl_stub_2_LAPACKE_dbdsdc_byte12(value* argv, int argc)
{
   value x87 = argv[11];
   value x88 = argv[10];
   value x89 = argv[9];
   value x90 = argv[8];
   value x91 = argv[7];
   value x92 = argv[6];
   value x93 = argv[5];
   value x94 = argv[4];
   value x95 = argv[3];
   value x96 = argv[2];
   value x97 = argv[1];
   value x98 = argv[0];
   return
     owl_stub_2_LAPACKE_dbdsdc(x98, x97, x96, x95, x94, x93, x92, x91, 
                               x90, x89, x88, x87);
}
value owl_stub_3_LAPACKE_sbdsqr(value x112, value x111, value x110,
                                value x109, value x108, value x107,
                                value x106, value x105, value x104,
                                value x103, value x102, value x101,
                                value x100, value x99)
{
   int x113 = Long_val(x112);
   int x116 = Int_val(x111);
   int x119 = Long_val(x110);
   int x122 = Long_val(x109);
   int x125 = Long_val(x108);
   int x128 = Long_val(x107);
   float* x131 = CTYPES_ADDR_OF_FATPTR(x106);
   float* x132 = CTYPES_ADDR_OF_FATPTR(x105);
   float* x133 = CTYPES_ADDR_OF_FATPTR(x104);
   int x134 = Long_val(x103);
   float* x137 = CTYPES_ADDR_OF_FATPTR(x102);
   int x138 = Long_val(x101);
   float* x141 = CTYPES_ADDR_OF_FATPTR(x100);
   int x142 = Long_val(x99);
   int x145 =
   LAPACKE_sbdsqr(x113, (char)x116, x119, x122, x125, x128, x131, x132, 
                  x133, x134, x137, x138, x141, x142);
   return Val_long(x145);
}
value owl_stub_3_LAPACKE_sbdsqr_byte14(value* argv, int argc)
{
   value x146 = argv[13];
   value x147 = argv[12];
   value x148 = argv[11];
   value x149 = argv[10];
   value x150 = argv[9];
   value x151 = argv[8];
   value x152 = argv[7];
   value x153 = argv[6];
   value x154 = argv[5];
   value x155 = argv[4];
   value x156 = argv[3];
   value x157 = argv[2];
   value x158 = argv[1];
   value x159 = argv[0];
   return
     owl_stub_3_LAPACKE_sbdsqr(x159, x158, x157, x156, x155, x154, x153,
                               x152, x151, x150, x149, x148, x147, x146);
}
value owl_stub_4_LAPACKE_dbdsqr(value x173, value x172, value x171,
                                value x170, value x169, value x168,
                                value x167, value x166, value x165,
                                value x164, value x163, value x162,
                                value x161, value x160)
{
   int x174 = Long_val(x173);
   int x177 = Int_val(x172);
   int x180 = Long_val(x171);
   int x183 = Long_val(x170);
   int x186 = Long_val(x169);
   int x189 = Long_val(x168);
   double* x192 = CTYPES_ADDR_OF_FATPTR(x167);
   double* x193 = CTYPES_ADDR_OF_FATPTR(x166);
   double* x194 = CTYPES_ADDR_OF_FATPTR(x165);
   int x195 = Long_val(x164);
   double* x198 = CTYPES_ADDR_OF_FATPTR(x163);
   int x199 = Long_val(x162);
   double* x202 = CTYPES_ADDR_OF_FATPTR(x161);
   int x203 = Long_val(x160);
   int x206 =
   LAPACKE_dbdsqr(x174, (char)x177, x180, x183, x186, x189, x192, x193, 
                  x194, x195, x198, x199, x202, x203);
   return Val_long(x206);
}
value owl_stub_4_LAPACKE_dbdsqr_byte14(value* argv, int argc)
{
   value x207 = argv[13];
   value x208 = argv[12];
   value x209 = argv[11];
   value x210 = argv[10];
   value x211 = argv[9];
   value x212 = argv[8];
   value x213 = argv[7];
   value x214 = argv[6];
   value x215 = argv[5];
   value x216 = argv[4];
   value x217 = argv[3];
   value x218 = argv[2];
   value x219 = argv[1];
   value x220 = argv[0];
   return
     owl_stub_4_LAPACKE_dbdsqr(x220, x219, x218, x217, x216, x215, x214,
                               x213, x212, x211, x210, x209, x208, x207);
}
value owl_stub_5_LAPACKE_cbdsqr(value x234, value x233, value x232,
                                value x231, value x230, value x229,
                                value x228, value x227, value x226,
                                value x225, value x224, value x223,
                                value x222, value x221)
{
   int x235 = Long_val(x234);
   int x238 = Int_val(x233);
   int x241 = Long_val(x232);
   int x244 = Long_val(x231);
   int x247 = Long_val(x230);
   int x250 = Long_val(x229);
   float* x253 = CTYPES_ADDR_OF_FATPTR(x228);
   float* x254 = CTYPES_ADDR_OF_FATPTR(x227);
   float _Complex* x255 = CTYPES_ADDR_OF_FATPTR(x226);
   int x256 = Long_val(x225);
   float _Complex* x259 = CTYPES_ADDR_OF_FATPTR(x224);
   int x260 = Long_val(x223);
   float _Complex* x263 = CTYPES_ADDR_OF_FATPTR(x222);
   int x264 = Long_val(x221);
   int x267 =
   LAPACKE_cbdsqr(x235, (char)x238, x241, x244, x247, x250, x253, x254, 
                  x255, x256, x259, x260, x263, x264);
   return Val_long(x267);
}
value owl_stub_5_LAPACKE_cbdsqr_byte14(value* argv, int argc)
{
   value x268 = argv[13];
   value x269 = argv[12];
   value x270 = argv[11];
   value x271 = argv[10];
   value x272 = argv[9];
   value x273 = argv[8];
   value x274 = argv[7];
   value x275 = argv[6];
   value x276 = argv[5];
   value x277 = argv[4];
   value x278 = argv[3];
   value x279 = argv[2];
   value x280 = argv[1];
   value x281 = argv[0];
   return
     owl_stub_5_LAPACKE_cbdsqr(x281, x280, x279, x278, x277, x276, x275,
                               x274, x273, x272, x271, x270, x269, x268);
}
value owl_stub_6_LAPACKE_zbdsqr(value x295, value x294, value x293,
                                value x292, value x291, value x290,
                                value x289, value x288, value x287,
                                value x286, value x285, value x284,
                                value x283, value x282)
{
   int x296 = Long_val(x295);
   int x299 = Int_val(x294);
   int x302 = Long_val(x293);
   int x305 = Long_val(x292);
   int x308 = Long_val(x291);
   int x311 = Long_val(x290);
   double* x314 = CTYPES_ADDR_OF_FATPTR(x289);
   double* x315 = CTYPES_ADDR_OF_FATPTR(x288);
   double _Complex* x316 = CTYPES_ADDR_OF_FATPTR(x287);
   int x317 = Long_val(x286);
   double _Complex* x320 = CTYPES_ADDR_OF_FATPTR(x285);
   int x321 = Long_val(x284);
   double _Complex* x324 = CTYPES_ADDR_OF_FATPTR(x283);
   int x325 = Long_val(x282);
   int x328 =
   LAPACKE_zbdsqr(x296, (char)x299, x302, x305, x308, x311, x314, x315, 
                  x316, x317, x320, x321, x324, x325);
   return Val_long(x328);
}
value owl_stub_6_LAPACKE_zbdsqr_byte14(value* argv, int argc)
{
   value x329 = argv[13];
   value x330 = argv[12];
   value x331 = argv[11];
   value x332 = argv[10];
   value x333 = argv[9];
   value x334 = argv[8];
   value x335 = argv[7];
   value x336 = argv[6];
   value x337 = argv[5];
   value x338 = argv[4];
   value x339 = argv[3];
   value x340 = argv[2];
   value x341 = argv[1];
   value x342 = argv[0];
   return
     owl_stub_6_LAPACKE_zbdsqr(x342, x341, x340, x339, x338, x337, x336,
                               x335, x334, x333, x332, x331, x330, x329);
}
value owl_stub_7_LAPACKE_sbdsvdx(value x358, value x357, value x356,
                                 value x355, value x354, value x353,
                                 value x352, value x351, value x350,
                                 value x349, value x348, value x347,
                                 value x346, value x345, value x344,
                                 value x343)
{
   int x359 = Long_val(x358);
   int x362 = Int_val(x357);
   int x365 = Int_val(x356);
   int x368 = Int_val(x355);
   int x371 = Long_val(x354);
   float* x374 = CTYPES_ADDR_OF_FATPTR(x353);
   float* x375 = CTYPES_ADDR_OF_FATPTR(x352);
   double x376 = Double_val(x351);
   double x379 = Double_val(x350);
   int x382 = Long_val(x349);
   int x385 = Long_val(x348);
   int* x388 = CTYPES_ADDR_OF_FATPTR(x347);
   float* x389 = CTYPES_ADDR_OF_FATPTR(x346);
   float* x390 = CTYPES_ADDR_OF_FATPTR(x345);
   int x391 = Long_val(x344);
   int* x394 = CTYPES_ADDR_OF_FATPTR(x343);
   int x395 =
   LAPACKE_sbdsvdx(x359, (char)x362, (char)x365, (char)x368, x371, x374,
                   x375, (float)x376, (float)x379, x382, x385, x388, 
                   x389, x390, x391, x394);
   return Val_long(x395);
}
value owl_stub_7_LAPACKE_sbdsvdx_byte16(value* argv, int argc)
{
   value x396 = argv[15];
   value x397 = argv[14];
   value x398 = argv[13];
   value x399 = argv[12];
   value x400 = argv[11];
   value x401 = argv[10];
   value x402 = argv[9];
   value x403 = argv[8];
   value x404 = argv[7];
   value x405 = argv[6];
   value x406 = argv[5];
   value x407 = argv[4];
   value x408 = argv[3];
   value x409 = argv[2];
   value x410 = argv[1];
   value x411 = argv[0];
   return
     owl_stub_7_LAPACKE_sbdsvdx(x411, x410, x409, x408, x407, x406, x405,
                                x404, x403, x402, x401, x400, x399, x398,
                                x397, x396);
}
value owl_stub_8_LAPACKE_dbdsvdx(value x427, value x426, value x425,
                                 value x424, value x423, value x422,
                                 value x421, value x420, value x419,
                                 value x418, value x417, value x416,
                                 value x415, value x414, value x413,
                                 value x412)
{
   int x428 = Long_val(x427);
   int x431 = Int_val(x426);
   int x434 = Int_val(x425);
   int x437 = Int_val(x424);
   int x440 = Long_val(x423);
   double* x443 = CTYPES_ADDR_OF_FATPTR(x422);
   double* x444 = CTYPES_ADDR_OF_FATPTR(x421);
   double x445 = Double_val(x420);
   double x448 = Double_val(x419);
   int x451 = Long_val(x418);
   int x454 = Long_val(x417);
   int* x457 = CTYPES_ADDR_OF_FATPTR(x416);
   double* x458 = CTYPES_ADDR_OF_FATPTR(x415);
   double* x459 = CTYPES_ADDR_OF_FATPTR(x414);
   int x460 = Long_val(x413);
   int* x463 = CTYPES_ADDR_OF_FATPTR(x412);
   int x464 =
   LAPACKE_dbdsvdx(x428, (char)x431, (char)x434, (char)x437, x440, x443,
                   x444, x445, x448, x451, x454, x457, x458, x459, x460,
                   x463);
   return Val_long(x464);
}
value owl_stub_8_LAPACKE_dbdsvdx_byte16(value* argv, int argc)
{
   value x465 = argv[15];
   value x466 = argv[14];
   value x467 = argv[13];
   value x468 = argv[12];
   value x469 = argv[11];
   value x470 = argv[10];
   value x471 = argv[9];
   value x472 = argv[8];
   value x473 = argv[7];
   value x474 = argv[6];
   value x475 = argv[5];
   value x476 = argv[4];
   value x477 = argv[3];
   value x478 = argv[2];
   value x479 = argv[1];
   value x480 = argv[0];
   return
     owl_stub_8_LAPACKE_dbdsvdx(x480, x479, x478, x477, x476, x475, x474,
                                x473, x472, x471, x470, x469, x468, x467,
                                x466, x465);
}
value owl_stub_9_LAPACKE_sdisna(value x485, value x484, value x483,
                                value x482, value x481)
{
   int x486 = Int_val(x485);
   int x489 = Long_val(x484);
   int x492 = Long_val(x483);
   float* x495 = CTYPES_ADDR_OF_FATPTR(x482);
   float* x496 = CTYPES_ADDR_OF_FATPTR(x481);
   int x497 = LAPACKE_sdisna((char)x486, x489, x492, x495, x496);
   return Val_long(x497);
}
value owl_stub_10_LAPACKE_ddisna(value x502, value x501, value x500,
                                 value x499, value x498)
{
   int x503 = Int_val(x502);
   int x506 = Long_val(x501);
   int x509 = Long_val(x500);
   double* x512 = CTYPES_ADDR_OF_FATPTR(x499);
   double* x513 = CTYPES_ADDR_OF_FATPTR(x498);
   int x514 = LAPACKE_ddisna((char)x503, x506, x509, x512, x513);
   return Val_long(x514);
}
value owl_stub_11_LAPACKE_sgbbrd(value x531, value x530, value x529,
                                 value x528, value x527, value x526,
                                 value x525, value x524, value x523,
                                 value x522, value x521, value x520,
                                 value x519, value x518, value x517,
                                 value x516, value x515)
{
   int x532 = Long_val(x531);
   int x535 = Int_val(x530);
   int x538 = Long_val(x529);
   int x541 = Long_val(x528);
   int x544 = Long_val(x527);
   int x547 = Long_val(x526);
   int x550 = Long_val(x525);
   float* x553 = CTYPES_ADDR_OF_FATPTR(x524);
   int x554 = Long_val(x523);
   float* x557 = CTYPES_ADDR_OF_FATPTR(x522);
   float* x558 = CTYPES_ADDR_OF_FATPTR(x521);
   float* x559 = CTYPES_ADDR_OF_FATPTR(x520);
   int x560 = Long_val(x519);
   float* x563 = CTYPES_ADDR_OF_FATPTR(x518);
   int x564 = Long_val(x517);
   float* x567 = CTYPES_ADDR_OF_FATPTR(x516);
   int x568 = Long_val(x515);
   int x571 =
   LAPACKE_sgbbrd(x532, (char)x535, x538, x541, x544, x547, x550, x553, 
                  x554, x557, x558, x559, x560, x563, x564, x567, x568);
   return Val_long(x571);
}
value owl_stub_11_LAPACKE_sgbbrd_byte17(value* argv, int argc)
{
   value x572 = argv[16];
   value x573 = argv[15];
   value x574 = argv[14];
   value x575 = argv[13];
   value x576 = argv[12];
   value x577 = argv[11];
   value x578 = argv[10];
   value x579 = argv[9];
   value x580 = argv[8];
   value x581 = argv[7];
   value x582 = argv[6];
   value x583 = argv[5];
   value x584 = argv[4];
   value x585 = argv[3];
   value x586 = argv[2];
   value x587 = argv[1];
   value x588 = argv[0];
   return
     owl_stub_11_LAPACKE_sgbbrd(x588, x587, x586, x585, x584, x583, x582,
                                x581, x580, x579, x578, x577, x576, x575,
                                x574, x573, x572);
}
value owl_stub_12_LAPACKE_dgbbrd(value x605, value x604, value x603,
                                 value x602, value x601, value x600,
                                 value x599, value x598, value x597,
                                 value x596, value x595, value x594,
                                 value x593, value x592, value x591,
                                 value x590, value x589)
{
   int x606 = Long_val(x605);
   int x609 = Int_val(x604);
   int x612 = Long_val(x603);
   int x615 = Long_val(x602);
   int x618 = Long_val(x601);
   int x621 = Long_val(x600);
   int x624 = Long_val(x599);
   double* x627 = CTYPES_ADDR_OF_FATPTR(x598);
   int x628 = Long_val(x597);
   double* x631 = CTYPES_ADDR_OF_FATPTR(x596);
   double* x632 = CTYPES_ADDR_OF_FATPTR(x595);
   double* x633 = CTYPES_ADDR_OF_FATPTR(x594);
   int x634 = Long_val(x593);
   double* x637 = CTYPES_ADDR_OF_FATPTR(x592);
   int x638 = Long_val(x591);
   double* x641 = CTYPES_ADDR_OF_FATPTR(x590);
   int x642 = Long_val(x589);
   int x645 =
   LAPACKE_dgbbrd(x606, (char)x609, x612, x615, x618, x621, x624, x627, 
                  x628, x631, x632, x633, x634, x637, x638, x641, x642);
   return Val_long(x645);
}
value owl_stub_12_LAPACKE_dgbbrd_byte17(value* argv, int argc)
{
   value x646 = argv[16];
   value x647 = argv[15];
   value x648 = argv[14];
   value x649 = argv[13];
   value x650 = argv[12];
   value x651 = argv[11];
   value x652 = argv[10];
   value x653 = argv[9];
   value x654 = argv[8];
   value x655 = argv[7];
   value x656 = argv[6];
   value x657 = argv[5];
   value x658 = argv[4];
   value x659 = argv[3];
   value x660 = argv[2];
   value x661 = argv[1];
   value x662 = argv[0];
   return
     owl_stub_12_LAPACKE_dgbbrd(x662, x661, x660, x659, x658, x657, x656,
                                x655, x654, x653, x652, x651, x650, x649,
                                x648, x647, x646);
}
value owl_stub_13_LAPACKE_cgbbrd(value x679, value x678, value x677,
                                 value x676, value x675, value x674,
                                 value x673, value x672, value x671,
                                 value x670, value x669, value x668,
                                 value x667, value x666, value x665,
                                 value x664, value x663)
{
   int x680 = Long_val(x679);
   int x683 = Int_val(x678);
   int x686 = Long_val(x677);
   int x689 = Long_val(x676);
   int x692 = Long_val(x675);
   int x695 = Long_val(x674);
   int x698 = Long_val(x673);
   float _Complex* x701 = CTYPES_ADDR_OF_FATPTR(x672);
   int x702 = Long_val(x671);
   float* x705 = CTYPES_ADDR_OF_FATPTR(x670);
   float* x706 = CTYPES_ADDR_OF_FATPTR(x669);
   float _Complex* x707 = CTYPES_ADDR_OF_FATPTR(x668);
   int x708 = Long_val(x667);
   float _Complex* x711 = CTYPES_ADDR_OF_FATPTR(x666);
   int x712 = Long_val(x665);
   float _Complex* x715 = CTYPES_ADDR_OF_FATPTR(x664);
   int x716 = Long_val(x663);
   int x719 =
   LAPACKE_cgbbrd(x680, (char)x683, x686, x689, x692, x695, x698, x701, 
                  x702, x705, x706, x707, x708, x711, x712, x715, x716);
   return Val_long(x719);
}
value owl_stub_13_LAPACKE_cgbbrd_byte17(value* argv, int argc)
{
   value x720 = argv[16];
   value x721 = argv[15];
   value x722 = argv[14];
   value x723 = argv[13];
   value x724 = argv[12];
   value x725 = argv[11];
   value x726 = argv[10];
   value x727 = argv[9];
   value x728 = argv[8];
   value x729 = argv[7];
   value x730 = argv[6];
   value x731 = argv[5];
   value x732 = argv[4];
   value x733 = argv[3];
   value x734 = argv[2];
   value x735 = argv[1];
   value x736 = argv[0];
   return
     owl_stub_13_LAPACKE_cgbbrd(x736, x735, x734, x733, x732, x731, x730,
                                x729, x728, x727, x726, x725, x724, x723,
                                x722, x721, x720);
}
value owl_stub_14_LAPACKE_zgbbrd(value x753, value x752, value x751,
                                 value x750, value x749, value x748,
                                 value x747, value x746, value x745,
                                 value x744, value x743, value x742,
                                 value x741, value x740, value x739,
                                 value x738, value x737)
{
   int x754 = Long_val(x753);
   int x757 = Int_val(x752);
   int x760 = Long_val(x751);
   int x763 = Long_val(x750);
   int x766 = Long_val(x749);
   int x769 = Long_val(x748);
   int x772 = Long_val(x747);
   double _Complex* x775 = CTYPES_ADDR_OF_FATPTR(x746);
   int x776 = Long_val(x745);
   double* x779 = CTYPES_ADDR_OF_FATPTR(x744);
   double* x780 = CTYPES_ADDR_OF_FATPTR(x743);
   double _Complex* x781 = CTYPES_ADDR_OF_FATPTR(x742);
   int x782 = Long_val(x741);
   double _Complex* x785 = CTYPES_ADDR_OF_FATPTR(x740);
   int x786 = Long_val(x739);
   double _Complex* x789 = CTYPES_ADDR_OF_FATPTR(x738);
   int x790 = Long_val(x737);
   int x793 =
   LAPACKE_zgbbrd(x754, (char)x757, x760, x763, x766, x769, x772, x775, 
                  x776, x779, x780, x781, x782, x785, x786, x789, x790);
   return Val_long(x793);
}
value owl_stub_14_LAPACKE_zgbbrd_byte17(value* argv, int argc)
{
   value x794 = argv[16];
   value x795 = argv[15];
   value x796 = argv[14];
   value x797 = argv[13];
   value x798 = argv[12];
   value x799 = argv[11];
   value x800 = argv[10];
   value x801 = argv[9];
   value x802 = argv[8];
   value x803 = argv[7];
   value x804 = argv[6];
   value x805 = argv[5];
   value x806 = argv[4];
   value x807 = argv[3];
   value x808 = argv[2];
   value x809 = argv[1];
   value x810 = argv[0];
   return
     owl_stub_14_LAPACKE_zgbbrd(x810, x809, x808, x807, x806, x805, x804,
                                x803, x802, x801, x800, x799, x798, x797,
                                x796, x795, x794);
}
value owl_stub_15_LAPACKE_sgbcon(value x820, value x819, value x818,
                                 value x817, value x816, value x815,
                                 value x814, value x813, value x812,
                                 value x811)
{
   int x821 = Long_val(x820);
   int x824 = Int_val(x819);
   int x827 = Long_val(x818);
   int x830 = Long_val(x817);
   int x833 = Long_val(x816);
   float* x836 = CTYPES_ADDR_OF_FATPTR(x815);
   int x837 = Long_val(x814);
   int* x840 = CTYPES_ADDR_OF_FATPTR(x813);
   double x841 = Double_val(x812);
   float* x844 = CTYPES_ADDR_OF_FATPTR(x811);
   int x845 =
   LAPACKE_sgbcon(x821, (char)x824, x827, x830, x833, x836, x837, x840,
                  (float)x841, x844);
   return Val_long(x845);
}
value owl_stub_15_LAPACKE_sgbcon_byte10(value* argv, int argc)
{
   value x846 = argv[9];
   value x847 = argv[8];
   value x848 = argv[7];
   value x849 = argv[6];
   value x850 = argv[5];
   value x851 = argv[4];
   value x852 = argv[3];
   value x853 = argv[2];
   value x854 = argv[1];
   value x855 = argv[0];
   return
     owl_stub_15_LAPACKE_sgbcon(x855, x854, x853, x852, x851, x850, x849,
                                x848, x847, x846);
}
value owl_stub_16_LAPACKE_dgbcon(value x865, value x864, value x863,
                                 value x862, value x861, value x860,
                                 value x859, value x858, value x857,
                                 value x856)
{
   int x866 = Long_val(x865);
   int x869 = Int_val(x864);
   int x872 = Long_val(x863);
   int x875 = Long_val(x862);
   int x878 = Long_val(x861);
   double* x881 = CTYPES_ADDR_OF_FATPTR(x860);
   int x882 = Long_val(x859);
   int* x885 = CTYPES_ADDR_OF_FATPTR(x858);
   double x886 = Double_val(x857);
   double* x889 = CTYPES_ADDR_OF_FATPTR(x856);
   int x890 =
   LAPACKE_dgbcon(x866, (char)x869, x872, x875, x878, x881, x882, x885, 
                  x886, x889);
   return Val_long(x890);
}
value owl_stub_16_LAPACKE_dgbcon_byte10(value* argv, int argc)
{
   value x891 = argv[9];
   value x892 = argv[8];
   value x893 = argv[7];
   value x894 = argv[6];
   value x895 = argv[5];
   value x896 = argv[4];
   value x897 = argv[3];
   value x898 = argv[2];
   value x899 = argv[1];
   value x900 = argv[0];
   return
     owl_stub_16_LAPACKE_dgbcon(x900, x899, x898, x897, x896, x895, x894,
                                x893, x892, x891);
}
value owl_stub_17_LAPACKE_cgbcon(value x910, value x909, value x908,
                                 value x907, value x906, value x905,
                                 value x904, value x903, value x902,
                                 value x901)
{
   int x911 = Long_val(x910);
   int x914 = Int_val(x909);
   int x917 = Long_val(x908);
   int x920 = Long_val(x907);
   int x923 = Long_val(x906);
   float _Complex* x926 = CTYPES_ADDR_OF_FATPTR(x905);
   int x927 = Long_val(x904);
   int* x930 = CTYPES_ADDR_OF_FATPTR(x903);
   double x931 = Double_val(x902);
   float* x934 = CTYPES_ADDR_OF_FATPTR(x901);
   int x935 =
   LAPACKE_cgbcon(x911, (char)x914, x917, x920, x923, x926, x927, x930,
                  (float)x931, x934);
   return Val_long(x935);
}
value owl_stub_17_LAPACKE_cgbcon_byte10(value* argv, int argc)
{
   value x936 = argv[9];
   value x937 = argv[8];
   value x938 = argv[7];
   value x939 = argv[6];
   value x940 = argv[5];
   value x941 = argv[4];
   value x942 = argv[3];
   value x943 = argv[2];
   value x944 = argv[1];
   value x945 = argv[0];
   return
     owl_stub_17_LAPACKE_cgbcon(x945, x944, x943, x942, x941, x940, x939,
                                x938, x937, x936);
}
value owl_stub_18_LAPACKE_zgbcon(value x955, value x954, value x953,
                                 value x952, value x951, value x950,
                                 value x949, value x948, value x947,
                                 value x946)
{
   int x956 = Long_val(x955);
   int x959 = Int_val(x954);
   int x962 = Long_val(x953);
   int x965 = Long_val(x952);
   int x968 = Long_val(x951);
   double _Complex* x971 = CTYPES_ADDR_OF_FATPTR(x950);
   int x972 = Long_val(x949);
   int* x975 = CTYPES_ADDR_OF_FATPTR(x948);
   double x976 = Double_val(x947);
   double* x979 = CTYPES_ADDR_OF_FATPTR(x946);
   int x980 =
   LAPACKE_zgbcon(x956, (char)x959, x962, x965, x968, x971, x972, x975, 
                  x976, x979);
   return Val_long(x980);
}
value owl_stub_18_LAPACKE_zgbcon_byte10(value* argv, int argc)
{
   value x981 = argv[9];
   value x982 = argv[8];
   value x983 = argv[7];
   value x984 = argv[6];
   value x985 = argv[5];
   value x986 = argv[4];
   value x987 = argv[3];
   value x988 = argv[2];
   value x989 = argv[1];
   value x990 = argv[0];
   return
     owl_stub_18_LAPACKE_zgbcon(x990, x989, x988, x987, x986, x985, x984,
                                x983, x982, x981);
}
value owl_stub_19_LAPACKE_sgbequ(value x1002, value x1001, value x1000,
                                 value x999, value x998, value x997,
                                 value x996, value x995, value x994,
                                 value x993, value x992, value x991)
{
   int x1003 = Long_val(x1002);
   int x1006 = Long_val(x1001);
   int x1009 = Long_val(x1000);
   int x1012 = Long_val(x999);
   int x1015 = Long_val(x998);
   float* x1018 = CTYPES_ADDR_OF_FATPTR(x997);
   int x1019 = Long_val(x996);
   float* x1022 = CTYPES_ADDR_OF_FATPTR(x995);
   float* x1023 = CTYPES_ADDR_OF_FATPTR(x994);
   float* x1024 = CTYPES_ADDR_OF_FATPTR(x993);
   float* x1025 = CTYPES_ADDR_OF_FATPTR(x992);
   float* x1026 = CTYPES_ADDR_OF_FATPTR(x991);
   int x1027 =
   LAPACKE_sgbequ(x1003, x1006, x1009, x1012, x1015, x1018, x1019, x1022,
                  x1023, x1024, x1025, x1026);
   return Val_long(x1027);
}
value owl_stub_19_LAPACKE_sgbequ_byte12(value* argv, int argc)
{
   value x1028 = argv[11];
   value x1029 = argv[10];
   value x1030 = argv[9];
   value x1031 = argv[8];
   value x1032 = argv[7];
   value x1033 = argv[6];
   value x1034 = argv[5];
   value x1035 = argv[4];
   value x1036 = argv[3];
   value x1037 = argv[2];
   value x1038 = argv[1];
   value x1039 = argv[0];
   return
     owl_stub_19_LAPACKE_sgbequ(x1039, x1038, x1037, x1036, x1035, x1034,
                                x1033, x1032, x1031, x1030, x1029, x1028);
}
value owl_stub_20_LAPACKE_dgbequ(value x1051, value x1050, value x1049,
                                 value x1048, value x1047, value x1046,
                                 value x1045, value x1044, value x1043,
                                 value x1042, value x1041, value x1040)
{
   int x1052 = Long_val(x1051);
   int x1055 = Long_val(x1050);
   int x1058 = Long_val(x1049);
   int x1061 = Long_val(x1048);
   int x1064 = Long_val(x1047);
   double* x1067 = CTYPES_ADDR_OF_FATPTR(x1046);
   int x1068 = Long_val(x1045);
   double* x1071 = CTYPES_ADDR_OF_FATPTR(x1044);
   double* x1072 = CTYPES_ADDR_OF_FATPTR(x1043);
   double* x1073 = CTYPES_ADDR_OF_FATPTR(x1042);
   double* x1074 = CTYPES_ADDR_OF_FATPTR(x1041);
   double* x1075 = CTYPES_ADDR_OF_FATPTR(x1040);
   int x1076 =
   LAPACKE_dgbequ(x1052, x1055, x1058, x1061, x1064, x1067, x1068, x1071,
                  x1072, x1073, x1074, x1075);
   return Val_long(x1076);
}
value owl_stub_20_LAPACKE_dgbequ_byte12(value* argv, int argc)
{
   value x1077 = argv[11];
   value x1078 = argv[10];
   value x1079 = argv[9];
   value x1080 = argv[8];
   value x1081 = argv[7];
   value x1082 = argv[6];
   value x1083 = argv[5];
   value x1084 = argv[4];
   value x1085 = argv[3];
   value x1086 = argv[2];
   value x1087 = argv[1];
   value x1088 = argv[0];
   return
     owl_stub_20_LAPACKE_dgbequ(x1088, x1087, x1086, x1085, x1084, x1083,
                                x1082, x1081, x1080, x1079, x1078, x1077);
}
value owl_stub_21_LAPACKE_cgbequ(value x1100, value x1099, value x1098,
                                 value x1097, value x1096, value x1095,
                                 value x1094, value x1093, value x1092,
                                 value x1091, value x1090, value x1089)
{
   int x1101 = Long_val(x1100);
   int x1104 = Long_val(x1099);
   int x1107 = Long_val(x1098);
   int x1110 = Long_val(x1097);
   int x1113 = Long_val(x1096);
   float _Complex* x1116 = CTYPES_ADDR_OF_FATPTR(x1095);
   int x1117 = Long_val(x1094);
   float* x1120 = CTYPES_ADDR_OF_FATPTR(x1093);
   float* x1121 = CTYPES_ADDR_OF_FATPTR(x1092);
   float* x1122 = CTYPES_ADDR_OF_FATPTR(x1091);
   float* x1123 = CTYPES_ADDR_OF_FATPTR(x1090);
   float* x1124 = CTYPES_ADDR_OF_FATPTR(x1089);
   int x1125 =
   LAPACKE_cgbequ(x1101, x1104, x1107, x1110, x1113, x1116, x1117, x1120,
                  x1121, x1122, x1123, x1124);
   return Val_long(x1125);
}
value owl_stub_21_LAPACKE_cgbequ_byte12(value* argv, int argc)
{
   value x1126 = argv[11];
   value x1127 = argv[10];
   value x1128 = argv[9];
   value x1129 = argv[8];
   value x1130 = argv[7];
   value x1131 = argv[6];
   value x1132 = argv[5];
   value x1133 = argv[4];
   value x1134 = argv[3];
   value x1135 = argv[2];
   value x1136 = argv[1];
   value x1137 = argv[0];
   return
     owl_stub_21_LAPACKE_cgbequ(x1137, x1136, x1135, x1134, x1133, x1132,
                                x1131, x1130, x1129, x1128, x1127, x1126);
}
value owl_stub_22_LAPACKE_zgbequ(value x1149, value x1148, value x1147,
                                 value x1146, value x1145, value x1144,
                                 value x1143, value x1142, value x1141,
                                 value x1140, value x1139, value x1138)
{
   int x1150 = Long_val(x1149);
   int x1153 = Long_val(x1148);
   int x1156 = Long_val(x1147);
   int x1159 = Long_val(x1146);
   int x1162 = Long_val(x1145);
   double _Complex* x1165 = CTYPES_ADDR_OF_FATPTR(x1144);
   int x1166 = Long_val(x1143);
   double* x1169 = CTYPES_ADDR_OF_FATPTR(x1142);
   double* x1170 = CTYPES_ADDR_OF_FATPTR(x1141);
   double* x1171 = CTYPES_ADDR_OF_FATPTR(x1140);
   double* x1172 = CTYPES_ADDR_OF_FATPTR(x1139);
   double* x1173 = CTYPES_ADDR_OF_FATPTR(x1138);
   int x1174 =
   LAPACKE_zgbequ(x1150, x1153, x1156, x1159, x1162, x1165, x1166, x1169,
                  x1170, x1171, x1172, x1173);
   return Val_long(x1174);
}
value owl_stub_22_LAPACKE_zgbequ_byte12(value* argv, int argc)
{
   value x1175 = argv[11];
   value x1176 = argv[10];
   value x1177 = argv[9];
   value x1178 = argv[8];
   value x1179 = argv[7];
   value x1180 = argv[6];
   value x1181 = argv[5];
   value x1182 = argv[4];
   value x1183 = argv[3];
   value x1184 = argv[2];
   value x1185 = argv[1];
   value x1186 = argv[0];
   return
     owl_stub_22_LAPACKE_zgbequ(x1186, x1185, x1184, x1183, x1182, x1181,
                                x1180, x1179, x1178, x1177, x1176, x1175);
}
value owl_stub_23_LAPACKE_sgbequb(value x1198, value x1197, value x1196,
                                  value x1195, value x1194, value x1193,
                                  value x1192, value x1191, value x1190,
                                  value x1189, value x1188, value x1187)
{
   int x1199 = Long_val(x1198);
   int x1202 = Long_val(x1197);
   int x1205 = Long_val(x1196);
   int x1208 = Long_val(x1195);
   int x1211 = Long_val(x1194);
   float* x1214 = CTYPES_ADDR_OF_FATPTR(x1193);
   int x1215 = Long_val(x1192);
   float* x1218 = CTYPES_ADDR_OF_FATPTR(x1191);
   float* x1219 = CTYPES_ADDR_OF_FATPTR(x1190);
   float* x1220 = CTYPES_ADDR_OF_FATPTR(x1189);
   float* x1221 = CTYPES_ADDR_OF_FATPTR(x1188);
   float* x1222 = CTYPES_ADDR_OF_FATPTR(x1187);
   int x1223 =
   LAPACKE_sgbequb(x1199, x1202, x1205, x1208, x1211, x1214, x1215, x1218,
                   x1219, x1220, x1221, x1222);
   return Val_long(x1223);
}
value owl_stub_23_LAPACKE_sgbequb_byte12(value* argv, int argc)
{
   value x1224 = argv[11];
   value x1225 = argv[10];
   value x1226 = argv[9];
   value x1227 = argv[8];
   value x1228 = argv[7];
   value x1229 = argv[6];
   value x1230 = argv[5];
   value x1231 = argv[4];
   value x1232 = argv[3];
   value x1233 = argv[2];
   value x1234 = argv[1];
   value x1235 = argv[0];
   return
     owl_stub_23_LAPACKE_sgbequb(x1235, x1234, x1233, x1232, x1231, x1230,
                                 x1229, x1228, x1227, x1226, x1225, x1224);
}
value owl_stub_24_LAPACKE_dgbequb(value x1247, value x1246, value x1245,
                                  value x1244, value x1243, value x1242,
                                  value x1241, value x1240, value x1239,
                                  value x1238, value x1237, value x1236)
{
   int x1248 = Long_val(x1247);
   int x1251 = Long_val(x1246);
   int x1254 = Long_val(x1245);
   int x1257 = Long_val(x1244);
   int x1260 = Long_val(x1243);
   double* x1263 = CTYPES_ADDR_OF_FATPTR(x1242);
   int x1264 = Long_val(x1241);
   double* x1267 = CTYPES_ADDR_OF_FATPTR(x1240);
   double* x1268 = CTYPES_ADDR_OF_FATPTR(x1239);
   double* x1269 = CTYPES_ADDR_OF_FATPTR(x1238);
   double* x1270 = CTYPES_ADDR_OF_FATPTR(x1237);
   double* x1271 = CTYPES_ADDR_OF_FATPTR(x1236);
   int x1272 =
   LAPACKE_dgbequb(x1248, x1251, x1254, x1257, x1260, x1263, x1264, x1267,
                   x1268, x1269, x1270, x1271);
   return Val_long(x1272);
}
value owl_stub_24_LAPACKE_dgbequb_byte12(value* argv, int argc)
{
   value x1273 = argv[11];
   value x1274 = argv[10];
   value x1275 = argv[9];
   value x1276 = argv[8];
   value x1277 = argv[7];
   value x1278 = argv[6];
   value x1279 = argv[5];
   value x1280 = argv[4];
   value x1281 = argv[3];
   value x1282 = argv[2];
   value x1283 = argv[1];
   value x1284 = argv[0];
   return
     owl_stub_24_LAPACKE_dgbequb(x1284, x1283, x1282, x1281, x1280, x1279,
                                 x1278, x1277, x1276, x1275, x1274, x1273);
}
value owl_stub_25_LAPACKE_cgbequb(value x1296, value x1295, value x1294,
                                  value x1293, value x1292, value x1291,
                                  value x1290, value x1289, value x1288,
                                  value x1287, value x1286, value x1285)
{
   int x1297 = Long_val(x1296);
   int x1300 = Long_val(x1295);
   int x1303 = Long_val(x1294);
   int x1306 = Long_val(x1293);
   int x1309 = Long_val(x1292);
   float _Complex* x1312 = CTYPES_ADDR_OF_FATPTR(x1291);
   int x1313 = Long_val(x1290);
   float* x1316 = CTYPES_ADDR_OF_FATPTR(x1289);
   float* x1317 = CTYPES_ADDR_OF_FATPTR(x1288);
   float* x1318 = CTYPES_ADDR_OF_FATPTR(x1287);
   float* x1319 = CTYPES_ADDR_OF_FATPTR(x1286);
   float* x1320 = CTYPES_ADDR_OF_FATPTR(x1285);
   int x1321 =
   LAPACKE_cgbequb(x1297, x1300, x1303, x1306, x1309, x1312, x1313, x1316,
                   x1317, x1318, x1319, x1320);
   return Val_long(x1321);
}
value owl_stub_25_LAPACKE_cgbequb_byte12(value* argv, int argc)
{
   value x1322 = argv[11];
   value x1323 = argv[10];
   value x1324 = argv[9];
   value x1325 = argv[8];
   value x1326 = argv[7];
   value x1327 = argv[6];
   value x1328 = argv[5];
   value x1329 = argv[4];
   value x1330 = argv[3];
   value x1331 = argv[2];
   value x1332 = argv[1];
   value x1333 = argv[0];
   return
     owl_stub_25_LAPACKE_cgbequb(x1333, x1332, x1331, x1330, x1329, x1328,
                                 x1327, x1326, x1325, x1324, x1323, x1322);
}
value owl_stub_26_LAPACKE_zgbequb(value x1345, value x1344, value x1343,
                                  value x1342, value x1341, value x1340,
                                  value x1339, value x1338, value x1337,
                                  value x1336, value x1335, value x1334)
{
   int x1346 = Long_val(x1345);
   int x1349 = Long_val(x1344);
   int x1352 = Long_val(x1343);
   int x1355 = Long_val(x1342);
   int x1358 = Long_val(x1341);
   double _Complex* x1361 = CTYPES_ADDR_OF_FATPTR(x1340);
   int x1362 = Long_val(x1339);
   double* x1365 = CTYPES_ADDR_OF_FATPTR(x1338);
   double* x1366 = CTYPES_ADDR_OF_FATPTR(x1337);
   double* x1367 = CTYPES_ADDR_OF_FATPTR(x1336);
   double* x1368 = CTYPES_ADDR_OF_FATPTR(x1335);
   double* x1369 = CTYPES_ADDR_OF_FATPTR(x1334);
   int x1370 =
   LAPACKE_zgbequb(x1346, x1349, x1352, x1355, x1358, x1361, x1362, x1365,
                   x1366, x1367, x1368, x1369);
   return Val_long(x1370);
}
value owl_stub_26_LAPACKE_zgbequb_byte12(value* argv, int argc)
{
   value x1371 = argv[11];
   value x1372 = argv[10];
   value x1373 = argv[9];
   value x1374 = argv[8];
   value x1375 = argv[7];
   value x1376 = argv[6];
   value x1377 = argv[5];
   value x1378 = argv[4];
   value x1379 = argv[3];
   value x1380 = argv[2];
   value x1381 = argv[1];
   value x1382 = argv[0];
   return
     owl_stub_26_LAPACKE_zgbequb(x1382, x1381, x1380, x1379, x1378, x1377,
                                 x1376, x1375, x1374, x1373, x1372, x1371);
}
value owl_stub_27_LAPACKE_sgbrfs(value x1399, value x1398, value x1397,
                                 value x1396, value x1395, value x1394,
                                 value x1393, value x1392, value x1391,
                                 value x1390, value x1389, value x1388,
                                 value x1387, value x1386, value x1385,
                                 value x1384, value x1383)
{
   int x1400 = Long_val(x1399);
   int x1403 = Int_val(x1398);
   int x1406 = Long_val(x1397);
   int x1409 = Long_val(x1396);
   int x1412 = Long_val(x1395);
   int x1415 = Long_val(x1394);
   float* x1418 = CTYPES_ADDR_OF_FATPTR(x1393);
   int x1419 = Long_val(x1392);
   float* x1422 = CTYPES_ADDR_OF_FATPTR(x1391);
   int x1423 = Long_val(x1390);
   int* x1426 = CTYPES_ADDR_OF_FATPTR(x1389);
   float* x1427 = CTYPES_ADDR_OF_FATPTR(x1388);
   int x1428 = Long_val(x1387);
   float* x1431 = CTYPES_ADDR_OF_FATPTR(x1386);
   int x1432 = Long_val(x1385);
   float* x1435 = CTYPES_ADDR_OF_FATPTR(x1384);
   float* x1436 = CTYPES_ADDR_OF_FATPTR(x1383);
   int x1437 =
   LAPACKE_sgbrfs(x1400, (char)x1403, x1406, x1409, x1412, x1415, x1418,
                  x1419, x1422, x1423, x1426, x1427, x1428, x1431, x1432,
                  x1435, x1436);
   return Val_long(x1437);
}
value owl_stub_27_LAPACKE_sgbrfs_byte17(value* argv, int argc)
{
   value x1438 = argv[16];
   value x1439 = argv[15];
   value x1440 = argv[14];
   value x1441 = argv[13];
   value x1442 = argv[12];
   value x1443 = argv[11];
   value x1444 = argv[10];
   value x1445 = argv[9];
   value x1446 = argv[8];
   value x1447 = argv[7];
   value x1448 = argv[6];
   value x1449 = argv[5];
   value x1450 = argv[4];
   value x1451 = argv[3];
   value x1452 = argv[2];
   value x1453 = argv[1];
   value x1454 = argv[0];
   return
     owl_stub_27_LAPACKE_sgbrfs(x1454, x1453, x1452, x1451, x1450, x1449,
                                x1448, x1447, x1446, x1445, x1444, x1443,
                                x1442, x1441, x1440, x1439, x1438);
}
value owl_stub_28_LAPACKE_dgbrfs(value x1471, value x1470, value x1469,
                                 value x1468, value x1467, value x1466,
                                 value x1465, value x1464, value x1463,
                                 value x1462, value x1461, value x1460,
                                 value x1459, value x1458, value x1457,
                                 value x1456, value x1455)
{
   int x1472 = Long_val(x1471);
   int x1475 = Int_val(x1470);
   int x1478 = Long_val(x1469);
   int x1481 = Long_val(x1468);
   int x1484 = Long_val(x1467);
   int x1487 = Long_val(x1466);
   double* x1490 = CTYPES_ADDR_OF_FATPTR(x1465);
   int x1491 = Long_val(x1464);
   double* x1494 = CTYPES_ADDR_OF_FATPTR(x1463);
   int x1495 = Long_val(x1462);
   int* x1498 = CTYPES_ADDR_OF_FATPTR(x1461);
   double* x1499 = CTYPES_ADDR_OF_FATPTR(x1460);
   int x1500 = Long_val(x1459);
   double* x1503 = CTYPES_ADDR_OF_FATPTR(x1458);
   int x1504 = Long_val(x1457);
   double* x1507 = CTYPES_ADDR_OF_FATPTR(x1456);
   double* x1508 = CTYPES_ADDR_OF_FATPTR(x1455);
   int x1509 =
   LAPACKE_dgbrfs(x1472, (char)x1475, x1478, x1481, x1484, x1487, x1490,
                  x1491, x1494, x1495, x1498, x1499, x1500, x1503, x1504,
                  x1507, x1508);
   return Val_long(x1509);
}
value owl_stub_28_LAPACKE_dgbrfs_byte17(value* argv, int argc)
{
   value x1510 = argv[16];
   value x1511 = argv[15];
   value x1512 = argv[14];
   value x1513 = argv[13];
   value x1514 = argv[12];
   value x1515 = argv[11];
   value x1516 = argv[10];
   value x1517 = argv[9];
   value x1518 = argv[8];
   value x1519 = argv[7];
   value x1520 = argv[6];
   value x1521 = argv[5];
   value x1522 = argv[4];
   value x1523 = argv[3];
   value x1524 = argv[2];
   value x1525 = argv[1];
   value x1526 = argv[0];
   return
     owl_stub_28_LAPACKE_dgbrfs(x1526, x1525, x1524, x1523, x1522, x1521,
                                x1520, x1519, x1518, x1517, x1516, x1515,
                                x1514, x1513, x1512, x1511, x1510);
}
value owl_stub_29_LAPACKE_cgbrfs(value x1543, value x1542, value x1541,
                                 value x1540, value x1539, value x1538,
                                 value x1537, value x1536, value x1535,
                                 value x1534, value x1533, value x1532,
                                 value x1531, value x1530, value x1529,
                                 value x1528, value x1527)
{
   int x1544 = Long_val(x1543);
   int x1547 = Int_val(x1542);
   int x1550 = Long_val(x1541);
   int x1553 = Long_val(x1540);
   int x1556 = Long_val(x1539);
   int x1559 = Long_val(x1538);
   float _Complex* x1562 = CTYPES_ADDR_OF_FATPTR(x1537);
   int x1563 = Long_val(x1536);
   float _Complex* x1566 = CTYPES_ADDR_OF_FATPTR(x1535);
   int x1567 = Long_val(x1534);
   int* x1570 = CTYPES_ADDR_OF_FATPTR(x1533);
   float _Complex* x1571 = CTYPES_ADDR_OF_FATPTR(x1532);
   int x1572 = Long_val(x1531);
   float _Complex* x1575 = CTYPES_ADDR_OF_FATPTR(x1530);
   int x1576 = Long_val(x1529);
   float* x1579 = CTYPES_ADDR_OF_FATPTR(x1528);
   float* x1580 = CTYPES_ADDR_OF_FATPTR(x1527);
   int x1581 =
   LAPACKE_cgbrfs(x1544, (char)x1547, x1550, x1553, x1556, x1559, x1562,
                  x1563, x1566, x1567, x1570, x1571, x1572, x1575, x1576,
                  x1579, x1580);
   return Val_long(x1581);
}
value owl_stub_29_LAPACKE_cgbrfs_byte17(value* argv, int argc)
{
   value x1582 = argv[16];
   value x1583 = argv[15];
   value x1584 = argv[14];
   value x1585 = argv[13];
   value x1586 = argv[12];
   value x1587 = argv[11];
   value x1588 = argv[10];
   value x1589 = argv[9];
   value x1590 = argv[8];
   value x1591 = argv[7];
   value x1592 = argv[6];
   value x1593 = argv[5];
   value x1594 = argv[4];
   value x1595 = argv[3];
   value x1596 = argv[2];
   value x1597 = argv[1];
   value x1598 = argv[0];
   return
     owl_stub_29_LAPACKE_cgbrfs(x1598, x1597, x1596, x1595, x1594, x1593,
                                x1592, x1591, x1590, x1589, x1588, x1587,
                                x1586, x1585, x1584, x1583, x1582);
}
value owl_stub_30_LAPACKE_zgbrfs(value x1615, value x1614, value x1613,
                                 value x1612, value x1611, value x1610,
                                 value x1609, value x1608, value x1607,
                                 value x1606, value x1605, value x1604,
                                 value x1603, value x1602, value x1601,
                                 value x1600, value x1599)
{
   int x1616 = Long_val(x1615);
   int x1619 = Int_val(x1614);
   int x1622 = Long_val(x1613);
   int x1625 = Long_val(x1612);
   int x1628 = Long_val(x1611);
   int x1631 = Long_val(x1610);
   double _Complex* x1634 = CTYPES_ADDR_OF_FATPTR(x1609);
   int x1635 = Long_val(x1608);
   double _Complex* x1638 = CTYPES_ADDR_OF_FATPTR(x1607);
   int x1639 = Long_val(x1606);
   int* x1642 = CTYPES_ADDR_OF_FATPTR(x1605);
   double _Complex* x1643 = CTYPES_ADDR_OF_FATPTR(x1604);
   int x1644 = Long_val(x1603);
   double _Complex* x1647 = CTYPES_ADDR_OF_FATPTR(x1602);
   int x1648 = Long_val(x1601);
   double* x1651 = CTYPES_ADDR_OF_FATPTR(x1600);
   double* x1652 = CTYPES_ADDR_OF_FATPTR(x1599);
   int x1653 =
   LAPACKE_zgbrfs(x1616, (char)x1619, x1622, x1625, x1628, x1631, x1634,
                  x1635, x1638, x1639, x1642, x1643, x1644, x1647, x1648,
                  x1651, x1652);
   return Val_long(x1653);
}
value owl_stub_30_LAPACKE_zgbrfs_byte17(value* argv, int argc)
{
   value x1654 = argv[16];
   value x1655 = argv[15];
   value x1656 = argv[14];
   value x1657 = argv[13];
   value x1658 = argv[12];
   value x1659 = argv[11];
   value x1660 = argv[10];
   value x1661 = argv[9];
   value x1662 = argv[8];
   value x1663 = argv[7];
   value x1664 = argv[6];
   value x1665 = argv[5];
   value x1666 = argv[4];
   value x1667 = argv[3];
   value x1668 = argv[2];
   value x1669 = argv[1];
   value x1670 = argv[0];
   return
     owl_stub_30_LAPACKE_zgbrfs(x1670, x1669, x1668, x1667, x1666, x1665,
                                x1664, x1663, x1662, x1661, x1660, x1659,
                                x1658, x1657, x1656, x1655, x1654);
}
value owl_stub_31_LAPACKE_sgbrfsx(value x1695, value x1694, value x1693,
                                  value x1692, value x1691, value x1690,
                                  value x1689, value x1688, value x1687,
                                  value x1686, value x1685, value x1684,
                                  value x1683, value x1682, value x1681,
                                  value x1680, value x1679, value x1678,
                                  value x1677, value x1676, value x1675,
                                  value x1674, value x1673, value x1672,
                                  value x1671)
{
   int x1696 = Long_val(x1695);
   int x1699 = Int_val(x1694);
   int x1702 = Int_val(x1693);
   int x1705 = Long_val(x1692);
   int x1708 = Long_val(x1691);
   int x1711 = Long_val(x1690);
   int x1714 = Long_val(x1689);
   float* x1717 = CTYPES_ADDR_OF_FATPTR(x1688);
   int x1718 = Long_val(x1687);
   float* x1721 = CTYPES_ADDR_OF_FATPTR(x1686);
   int x1722 = Long_val(x1685);
   int* x1725 = CTYPES_ADDR_OF_FATPTR(x1684);
   float* x1726 = CTYPES_ADDR_OF_FATPTR(x1683);
   float* x1727 = CTYPES_ADDR_OF_FATPTR(x1682);
   float* x1728 = CTYPES_ADDR_OF_FATPTR(x1681);
   int x1729 = Long_val(x1680);
   float* x1732 = CTYPES_ADDR_OF_FATPTR(x1679);
   int x1733 = Long_val(x1678);
   float* x1736 = CTYPES_ADDR_OF_FATPTR(x1677);
   float* x1737 = CTYPES_ADDR_OF_FATPTR(x1676);
   int x1738 = Long_val(x1675);
   float* x1741 = CTYPES_ADDR_OF_FATPTR(x1674);
   float* x1742 = CTYPES_ADDR_OF_FATPTR(x1673);
   int x1743 = Long_val(x1672);
   float* x1746 = CTYPES_ADDR_OF_FATPTR(x1671);
   int x1747 =
   LAPACKE_sgbrfsx(x1696, (char)x1699, (char)x1702, x1705, x1708, x1711,
                   x1714, x1717, x1718, x1721, x1722, x1725, x1726, x1727,
                   x1728, x1729, x1732, x1733, x1736, x1737, x1738, x1741,
                   x1742, x1743, x1746);
   return Val_long(x1747);
}
value owl_stub_31_LAPACKE_sgbrfsx_byte25(value* argv, int argc)
{
   value x1748 = argv[24];
   value x1749 = argv[23];
   value x1750 = argv[22];
   value x1751 = argv[21];
   value x1752 = argv[20];
   value x1753 = argv[19];
   value x1754 = argv[18];
   value x1755 = argv[17];
   value x1756 = argv[16];
   value x1757 = argv[15];
   value x1758 = argv[14];
   value x1759 = argv[13];
   value x1760 = argv[12];
   value x1761 = argv[11];
   value x1762 = argv[10];
   value x1763 = argv[9];
   value x1764 = argv[8];
   value x1765 = argv[7];
   value x1766 = argv[6];
   value x1767 = argv[5];
   value x1768 = argv[4];
   value x1769 = argv[3];
   value x1770 = argv[2];
   value x1771 = argv[1];
   value x1772 = argv[0];
   return
     owl_stub_31_LAPACKE_sgbrfsx(x1772, x1771, x1770, x1769, x1768, x1767,
                                 x1766, x1765, x1764, x1763, x1762, x1761,
                                 x1760, x1759, x1758, x1757, x1756, x1755,
                                 x1754, x1753, x1752, x1751, x1750, x1749,
                                 x1748);
}
value owl_stub_32_LAPACKE_dgbrfsx(value x1797, value x1796, value x1795,
                                  value x1794, value x1793, value x1792,
                                  value x1791, value x1790, value x1789,
                                  value x1788, value x1787, value x1786,
                                  value x1785, value x1784, value x1783,
                                  value x1782, value x1781, value x1780,
                                  value x1779, value x1778, value x1777,
                                  value x1776, value x1775, value x1774,
                                  value x1773)
{
   int x1798 = Long_val(x1797);
   int x1801 = Int_val(x1796);
   int x1804 = Int_val(x1795);
   int x1807 = Long_val(x1794);
   int x1810 = Long_val(x1793);
   int x1813 = Long_val(x1792);
   int x1816 = Long_val(x1791);
   double* x1819 = CTYPES_ADDR_OF_FATPTR(x1790);
   int x1820 = Long_val(x1789);
   double* x1823 = CTYPES_ADDR_OF_FATPTR(x1788);
   int x1824 = Long_val(x1787);
   int* x1827 = CTYPES_ADDR_OF_FATPTR(x1786);
   double* x1828 = CTYPES_ADDR_OF_FATPTR(x1785);
   double* x1829 = CTYPES_ADDR_OF_FATPTR(x1784);
   double* x1830 = CTYPES_ADDR_OF_FATPTR(x1783);
   int x1831 = Long_val(x1782);
   double* x1834 = CTYPES_ADDR_OF_FATPTR(x1781);
   int x1835 = Long_val(x1780);
   double* x1838 = CTYPES_ADDR_OF_FATPTR(x1779);
   double* x1839 = CTYPES_ADDR_OF_FATPTR(x1778);
   int x1840 = Long_val(x1777);
   double* x1843 = CTYPES_ADDR_OF_FATPTR(x1776);
   double* x1844 = CTYPES_ADDR_OF_FATPTR(x1775);
   int x1845 = Long_val(x1774);
   double* x1848 = CTYPES_ADDR_OF_FATPTR(x1773);
   int x1849 =
   LAPACKE_dgbrfsx(x1798, (char)x1801, (char)x1804, x1807, x1810, x1813,
                   x1816, x1819, x1820, x1823, x1824, x1827, x1828, x1829,
                   x1830, x1831, x1834, x1835, x1838, x1839, x1840, x1843,
                   x1844, x1845, x1848);
   return Val_long(x1849);
}
value owl_stub_32_LAPACKE_dgbrfsx_byte25(value* argv, int argc)
{
   value x1850 = argv[24];
   value x1851 = argv[23];
   value x1852 = argv[22];
   value x1853 = argv[21];
   value x1854 = argv[20];
   value x1855 = argv[19];
   value x1856 = argv[18];
   value x1857 = argv[17];
   value x1858 = argv[16];
   value x1859 = argv[15];
   value x1860 = argv[14];
   value x1861 = argv[13];
   value x1862 = argv[12];
   value x1863 = argv[11];
   value x1864 = argv[10];
   value x1865 = argv[9];
   value x1866 = argv[8];
   value x1867 = argv[7];
   value x1868 = argv[6];
   value x1869 = argv[5];
   value x1870 = argv[4];
   value x1871 = argv[3];
   value x1872 = argv[2];
   value x1873 = argv[1];
   value x1874 = argv[0];
   return
     owl_stub_32_LAPACKE_dgbrfsx(x1874, x1873, x1872, x1871, x1870, x1869,
                                 x1868, x1867, x1866, x1865, x1864, x1863,
                                 x1862, x1861, x1860, x1859, x1858, x1857,
                                 x1856, x1855, x1854, x1853, x1852, x1851,
                                 x1850);
}
value owl_stub_33_LAPACKE_cgbrfsx(value x1899, value x1898, value x1897,
                                  value x1896, value x1895, value x1894,
                                  value x1893, value x1892, value x1891,
                                  value x1890, value x1889, value x1888,
                                  value x1887, value x1886, value x1885,
                                  value x1884, value x1883, value x1882,
                                  value x1881, value x1880, value x1879,
                                  value x1878, value x1877, value x1876,
                                  value x1875)
{
   int x1900 = Long_val(x1899);
   int x1903 = Int_val(x1898);
   int x1906 = Int_val(x1897);
   int x1909 = Long_val(x1896);
   int x1912 = Long_val(x1895);
   int x1915 = Long_val(x1894);
   int x1918 = Long_val(x1893);
   float _Complex* x1921 = CTYPES_ADDR_OF_FATPTR(x1892);
   int x1922 = Long_val(x1891);
   float _Complex* x1925 = CTYPES_ADDR_OF_FATPTR(x1890);
   int x1926 = Long_val(x1889);
   int* x1929 = CTYPES_ADDR_OF_FATPTR(x1888);
   float* x1930 = CTYPES_ADDR_OF_FATPTR(x1887);
   float* x1931 = CTYPES_ADDR_OF_FATPTR(x1886);
   float _Complex* x1932 = CTYPES_ADDR_OF_FATPTR(x1885);
   int x1933 = Long_val(x1884);
   float _Complex* x1936 = CTYPES_ADDR_OF_FATPTR(x1883);
   int x1937 = Long_val(x1882);
   float* x1940 = CTYPES_ADDR_OF_FATPTR(x1881);
   float* x1941 = CTYPES_ADDR_OF_FATPTR(x1880);
   int x1942 = Long_val(x1879);
   float* x1945 = CTYPES_ADDR_OF_FATPTR(x1878);
   float* x1946 = CTYPES_ADDR_OF_FATPTR(x1877);
   int x1947 = Long_val(x1876);
   float* x1950 = CTYPES_ADDR_OF_FATPTR(x1875);
   int x1951 =
   LAPACKE_cgbrfsx(x1900, (char)x1903, (char)x1906, x1909, x1912, x1915,
                   x1918, x1921, x1922, x1925, x1926, x1929, x1930, x1931,
                   x1932, x1933, x1936, x1937, x1940, x1941, x1942, x1945,
                   x1946, x1947, x1950);
   return Val_long(x1951);
}
value owl_stub_33_LAPACKE_cgbrfsx_byte25(value* argv, int argc)
{
   value x1952 = argv[24];
   value x1953 = argv[23];
   value x1954 = argv[22];
   value x1955 = argv[21];
   value x1956 = argv[20];
   value x1957 = argv[19];
   value x1958 = argv[18];
   value x1959 = argv[17];
   value x1960 = argv[16];
   value x1961 = argv[15];
   value x1962 = argv[14];
   value x1963 = argv[13];
   value x1964 = argv[12];
   value x1965 = argv[11];
   value x1966 = argv[10];
   value x1967 = argv[9];
   value x1968 = argv[8];
   value x1969 = argv[7];
   value x1970 = argv[6];
   value x1971 = argv[5];
   value x1972 = argv[4];
   value x1973 = argv[3];
   value x1974 = argv[2];
   value x1975 = argv[1];
   value x1976 = argv[0];
   return
     owl_stub_33_LAPACKE_cgbrfsx(x1976, x1975, x1974, x1973, x1972, x1971,
                                 x1970, x1969, x1968, x1967, x1966, x1965,
                                 x1964, x1963, x1962, x1961, x1960, x1959,
                                 x1958, x1957, x1956, x1955, x1954, x1953,
                                 x1952);
}
value owl_stub_34_LAPACKE_zgbrfsx(value x2001, value x2000, value x1999,
                                  value x1998, value x1997, value x1996,
                                  value x1995, value x1994, value x1993,
                                  value x1992, value x1991, value x1990,
                                  value x1989, value x1988, value x1987,
                                  value x1986, value x1985, value x1984,
                                  value x1983, value x1982, value x1981,
                                  value x1980, value x1979, value x1978,
                                  value x1977)
{
   int x2002 = Long_val(x2001);
   int x2005 = Int_val(x2000);
   int x2008 = Int_val(x1999);
   int x2011 = Long_val(x1998);
   int x2014 = Long_val(x1997);
   int x2017 = Long_val(x1996);
   int x2020 = Long_val(x1995);
   double _Complex* x2023 = CTYPES_ADDR_OF_FATPTR(x1994);
   int x2024 = Long_val(x1993);
   double _Complex* x2027 = CTYPES_ADDR_OF_FATPTR(x1992);
   int x2028 = Long_val(x1991);
   int* x2031 = CTYPES_ADDR_OF_FATPTR(x1990);
   double* x2032 = CTYPES_ADDR_OF_FATPTR(x1989);
   double* x2033 = CTYPES_ADDR_OF_FATPTR(x1988);
   double _Complex* x2034 = CTYPES_ADDR_OF_FATPTR(x1987);
   int x2035 = Long_val(x1986);
   double _Complex* x2038 = CTYPES_ADDR_OF_FATPTR(x1985);
   int x2039 = Long_val(x1984);
   double* x2042 = CTYPES_ADDR_OF_FATPTR(x1983);
   double* x2043 = CTYPES_ADDR_OF_FATPTR(x1982);
   int x2044 = Long_val(x1981);
   double* x2047 = CTYPES_ADDR_OF_FATPTR(x1980);
   double* x2048 = CTYPES_ADDR_OF_FATPTR(x1979);
   int x2049 = Long_val(x1978);
   double* x2052 = CTYPES_ADDR_OF_FATPTR(x1977);
   int x2053 =
   LAPACKE_zgbrfsx(x2002, (char)x2005, (char)x2008, x2011, x2014, x2017,
                   x2020, x2023, x2024, x2027, x2028, x2031, x2032, x2033,
                   x2034, x2035, x2038, x2039, x2042, x2043, x2044, x2047,
                   x2048, x2049, x2052);
   return Val_long(x2053);
}
value owl_stub_34_LAPACKE_zgbrfsx_byte25(value* argv, int argc)
{
   value x2054 = argv[24];
   value x2055 = argv[23];
   value x2056 = argv[22];
   value x2057 = argv[21];
   value x2058 = argv[20];
   value x2059 = argv[19];
   value x2060 = argv[18];
   value x2061 = argv[17];
   value x2062 = argv[16];
   value x2063 = argv[15];
   value x2064 = argv[14];
   value x2065 = argv[13];
   value x2066 = argv[12];
   value x2067 = argv[11];
   value x2068 = argv[10];
   value x2069 = argv[9];
   value x2070 = argv[8];
   value x2071 = argv[7];
   value x2072 = argv[6];
   value x2073 = argv[5];
   value x2074 = argv[4];
   value x2075 = argv[3];
   value x2076 = argv[2];
   value x2077 = argv[1];
   value x2078 = argv[0];
   return
     owl_stub_34_LAPACKE_zgbrfsx(x2078, x2077, x2076, x2075, x2074, x2073,
                                 x2072, x2071, x2070, x2069, x2068, x2067,
                                 x2066, x2065, x2064, x2063, x2062, x2061,
                                 x2060, x2059, x2058, x2057, x2056, x2055,
                                 x2054);
}
value owl_stub_35_LAPACKE_sgbsv(value x2088, value x2087, value x2086,
                                value x2085, value x2084, value x2083,
                                value x2082, value x2081, value x2080,
                                value x2079)
{
   int x2089 = Long_val(x2088);
   int x2092 = Long_val(x2087);
   int x2095 = Long_val(x2086);
   int x2098 = Long_val(x2085);
   int x2101 = Long_val(x2084);
   float* x2104 = CTYPES_ADDR_OF_FATPTR(x2083);
   int x2105 = Long_val(x2082);
   int* x2108 = CTYPES_ADDR_OF_FATPTR(x2081);
   float* x2109 = CTYPES_ADDR_OF_FATPTR(x2080);
   int x2110 = Long_val(x2079);
   int x2113 =
   LAPACKE_sgbsv(x2089, x2092, x2095, x2098, x2101, x2104, x2105, x2108,
                 x2109, x2110);
   return Val_long(x2113);
}
value owl_stub_35_LAPACKE_sgbsv_byte10(value* argv, int argc)
{
   value x2114 = argv[9];
   value x2115 = argv[8];
   value x2116 = argv[7];
   value x2117 = argv[6];
   value x2118 = argv[5];
   value x2119 = argv[4];
   value x2120 = argv[3];
   value x2121 = argv[2];
   value x2122 = argv[1];
   value x2123 = argv[0];
   return
     owl_stub_35_LAPACKE_sgbsv(x2123, x2122, x2121, x2120, x2119, x2118,
                               x2117, x2116, x2115, x2114);
}
value owl_stub_36_LAPACKE_dgbsv(value x2133, value x2132, value x2131,
                                value x2130, value x2129, value x2128,
                                value x2127, value x2126, value x2125,
                                value x2124)
{
   int x2134 = Long_val(x2133);
   int x2137 = Long_val(x2132);
   int x2140 = Long_val(x2131);
   int x2143 = Long_val(x2130);
   int x2146 = Long_val(x2129);
   double* x2149 = CTYPES_ADDR_OF_FATPTR(x2128);
   int x2150 = Long_val(x2127);
   int* x2153 = CTYPES_ADDR_OF_FATPTR(x2126);
   double* x2154 = CTYPES_ADDR_OF_FATPTR(x2125);
   int x2155 = Long_val(x2124);
   int x2158 =
   LAPACKE_dgbsv(x2134, x2137, x2140, x2143, x2146, x2149, x2150, x2153,
                 x2154, x2155);
   return Val_long(x2158);
}
value owl_stub_36_LAPACKE_dgbsv_byte10(value* argv, int argc)
{
   value x2159 = argv[9];
   value x2160 = argv[8];
   value x2161 = argv[7];
   value x2162 = argv[6];
   value x2163 = argv[5];
   value x2164 = argv[4];
   value x2165 = argv[3];
   value x2166 = argv[2];
   value x2167 = argv[1];
   value x2168 = argv[0];
   return
     owl_stub_36_LAPACKE_dgbsv(x2168, x2167, x2166, x2165, x2164, x2163,
                               x2162, x2161, x2160, x2159);
}
value owl_stub_37_LAPACKE_cgbsv(value x2178, value x2177, value x2176,
                                value x2175, value x2174, value x2173,
                                value x2172, value x2171, value x2170,
                                value x2169)
{
   int x2179 = Long_val(x2178);
   int x2182 = Long_val(x2177);
   int x2185 = Long_val(x2176);
   int x2188 = Long_val(x2175);
   int x2191 = Long_val(x2174);
   float _Complex* x2194 = CTYPES_ADDR_OF_FATPTR(x2173);
   int x2195 = Long_val(x2172);
   int* x2198 = CTYPES_ADDR_OF_FATPTR(x2171);
   float _Complex* x2199 = CTYPES_ADDR_OF_FATPTR(x2170);
   int x2200 = Long_val(x2169);
   int x2203 =
   LAPACKE_cgbsv(x2179, x2182, x2185, x2188, x2191, x2194, x2195, x2198,
                 x2199, x2200);
   return Val_long(x2203);
}
value owl_stub_37_LAPACKE_cgbsv_byte10(value* argv, int argc)
{
   value x2204 = argv[9];
   value x2205 = argv[8];
   value x2206 = argv[7];
   value x2207 = argv[6];
   value x2208 = argv[5];
   value x2209 = argv[4];
   value x2210 = argv[3];
   value x2211 = argv[2];
   value x2212 = argv[1];
   value x2213 = argv[0];
   return
     owl_stub_37_LAPACKE_cgbsv(x2213, x2212, x2211, x2210, x2209, x2208,
                               x2207, x2206, x2205, x2204);
}
value owl_stub_38_LAPACKE_zgbsv(value x2223, value x2222, value x2221,
                                value x2220, value x2219, value x2218,
                                value x2217, value x2216, value x2215,
                                value x2214)
{
   int x2224 = Long_val(x2223);
   int x2227 = Long_val(x2222);
   int x2230 = Long_val(x2221);
   int x2233 = Long_val(x2220);
   int x2236 = Long_val(x2219);
   double _Complex* x2239 = CTYPES_ADDR_OF_FATPTR(x2218);
   int x2240 = Long_val(x2217);
   int* x2243 = CTYPES_ADDR_OF_FATPTR(x2216);
   double _Complex* x2244 = CTYPES_ADDR_OF_FATPTR(x2215);
   int x2245 = Long_val(x2214);
   int x2248 =
   LAPACKE_zgbsv(x2224, x2227, x2230, x2233, x2236, x2239, x2240, x2243,
                 x2244, x2245);
   return Val_long(x2248);
}
value owl_stub_38_LAPACKE_zgbsv_byte10(value* argv, int argc)
{
   value x2249 = argv[9];
   value x2250 = argv[8];
   value x2251 = argv[7];
   value x2252 = argv[6];
   value x2253 = argv[5];
   value x2254 = argv[4];
   value x2255 = argv[3];
   value x2256 = argv[2];
   value x2257 = argv[1];
   value x2258 = argv[0];
   return
     owl_stub_38_LAPACKE_zgbsv(x2258, x2257, x2256, x2255, x2254, x2253,
                               x2252, x2251, x2250, x2249);
}
value owl_stub_39_LAPACKE_sgbsvx(value x2281, value x2280, value x2279,
                                 value x2278, value x2277, value x2276,
                                 value x2275, value x2274, value x2273,
                                 value x2272, value x2271, value x2270,
                                 value x2269, value x2268, value x2267,
                                 value x2266, value x2265, value x2264,
                                 value x2263, value x2262, value x2261,
                                 value x2260, value x2259)
{
   int x2282 = Long_val(x2281);
   int x2285 = Int_val(x2280);
   int x2288 = Int_val(x2279);
   int x2291 = Long_val(x2278);
   int x2294 = Long_val(x2277);
   int x2297 = Long_val(x2276);
   int x2300 = Long_val(x2275);
   float* x2303 = CTYPES_ADDR_OF_FATPTR(x2274);
   int x2304 = Long_val(x2273);
   float* x2307 = CTYPES_ADDR_OF_FATPTR(x2272);
   int x2308 = Long_val(x2271);
   int* x2311 = CTYPES_ADDR_OF_FATPTR(x2270);
   char* x2312 = CTYPES_ADDR_OF_FATPTR(x2269);
   float* x2313 = CTYPES_ADDR_OF_FATPTR(x2268);
   float* x2314 = CTYPES_ADDR_OF_FATPTR(x2267);
   float* x2315 = CTYPES_ADDR_OF_FATPTR(x2266);
   int x2316 = Long_val(x2265);
   float* x2319 = CTYPES_ADDR_OF_FATPTR(x2264);
   int x2320 = Long_val(x2263);
   float* x2323 = CTYPES_ADDR_OF_FATPTR(x2262);
   float* x2324 = CTYPES_ADDR_OF_FATPTR(x2261);
   float* x2325 = CTYPES_ADDR_OF_FATPTR(x2260);
   float* x2326 = CTYPES_ADDR_OF_FATPTR(x2259);
   int x2327 =
   LAPACKE_sgbsvx(x2282, (char)x2285, (char)x2288, x2291, x2294, x2297,
                  x2300, x2303, x2304, x2307, x2308, x2311, x2312, x2313,
                  x2314, x2315, x2316, x2319, x2320, x2323, x2324, x2325,
                  x2326);
   return Val_long(x2327);
}
value owl_stub_39_LAPACKE_sgbsvx_byte23(value* argv, int argc)
{
   value x2328 = argv[22];
   value x2329 = argv[21];
   value x2330 = argv[20];
   value x2331 = argv[19];
   value x2332 = argv[18];
   value x2333 = argv[17];
   value x2334 = argv[16];
   value x2335 = argv[15];
   value x2336 = argv[14];
   value x2337 = argv[13];
   value x2338 = argv[12];
   value x2339 = argv[11];
   value x2340 = argv[10];
   value x2341 = argv[9];
   value x2342 = argv[8];
   value x2343 = argv[7];
   value x2344 = argv[6];
   value x2345 = argv[5];
   value x2346 = argv[4];
   value x2347 = argv[3];
   value x2348 = argv[2];
   value x2349 = argv[1];
   value x2350 = argv[0];
   return
     owl_stub_39_LAPACKE_sgbsvx(x2350, x2349, x2348, x2347, x2346, x2345,
                                x2344, x2343, x2342, x2341, x2340, x2339,
                                x2338, x2337, x2336, x2335, x2334, x2333,
                                x2332, x2331, x2330, x2329, x2328);
}
value owl_stub_40_LAPACKE_dgbsvx(value x2373, value x2372, value x2371,
                                 value x2370, value x2369, value x2368,
                                 value x2367, value x2366, value x2365,
                                 value x2364, value x2363, value x2362,
                                 value x2361, value x2360, value x2359,
                                 value x2358, value x2357, value x2356,
                                 value x2355, value x2354, value x2353,
                                 value x2352, value x2351)
{
   int x2374 = Long_val(x2373);
   int x2377 = Int_val(x2372);
   int x2380 = Int_val(x2371);
   int x2383 = Long_val(x2370);
   int x2386 = Long_val(x2369);
   int x2389 = Long_val(x2368);
   int x2392 = Long_val(x2367);
   double* x2395 = CTYPES_ADDR_OF_FATPTR(x2366);
   int x2396 = Long_val(x2365);
   double* x2399 = CTYPES_ADDR_OF_FATPTR(x2364);
   int x2400 = Long_val(x2363);
   int* x2403 = CTYPES_ADDR_OF_FATPTR(x2362);
   char* x2404 = CTYPES_ADDR_OF_FATPTR(x2361);
   double* x2405 = CTYPES_ADDR_OF_FATPTR(x2360);
   double* x2406 = CTYPES_ADDR_OF_FATPTR(x2359);
   double* x2407 = CTYPES_ADDR_OF_FATPTR(x2358);
   int x2408 = Long_val(x2357);
   double* x2411 = CTYPES_ADDR_OF_FATPTR(x2356);
   int x2412 = Long_val(x2355);
   double* x2415 = CTYPES_ADDR_OF_FATPTR(x2354);
   double* x2416 = CTYPES_ADDR_OF_FATPTR(x2353);
   double* x2417 = CTYPES_ADDR_OF_FATPTR(x2352);
   double* x2418 = CTYPES_ADDR_OF_FATPTR(x2351);
   int x2419 =
   LAPACKE_dgbsvx(x2374, (char)x2377, (char)x2380, x2383, x2386, x2389,
                  x2392, x2395, x2396, x2399, x2400, x2403, x2404, x2405,
                  x2406, x2407, x2408, x2411, x2412, x2415, x2416, x2417,
                  x2418);
   return Val_long(x2419);
}
value owl_stub_40_LAPACKE_dgbsvx_byte23(value* argv, int argc)
{
   value x2420 = argv[22];
   value x2421 = argv[21];
   value x2422 = argv[20];
   value x2423 = argv[19];
   value x2424 = argv[18];
   value x2425 = argv[17];
   value x2426 = argv[16];
   value x2427 = argv[15];
   value x2428 = argv[14];
   value x2429 = argv[13];
   value x2430 = argv[12];
   value x2431 = argv[11];
   value x2432 = argv[10];
   value x2433 = argv[9];
   value x2434 = argv[8];
   value x2435 = argv[7];
   value x2436 = argv[6];
   value x2437 = argv[5];
   value x2438 = argv[4];
   value x2439 = argv[3];
   value x2440 = argv[2];
   value x2441 = argv[1];
   value x2442 = argv[0];
   return
     owl_stub_40_LAPACKE_dgbsvx(x2442, x2441, x2440, x2439, x2438, x2437,
                                x2436, x2435, x2434, x2433, x2432, x2431,
                                x2430, x2429, x2428, x2427, x2426, x2425,
                                x2424, x2423, x2422, x2421, x2420);
}
value owl_stub_41_LAPACKE_cgbsvx(value x2465, value x2464, value x2463,
                                 value x2462, value x2461, value x2460,
                                 value x2459, value x2458, value x2457,
                                 value x2456, value x2455, value x2454,
                                 value x2453, value x2452, value x2451,
                                 value x2450, value x2449, value x2448,
                                 value x2447, value x2446, value x2445,
                                 value x2444, value x2443)
{
   int x2466 = Long_val(x2465);
   int x2469 = Int_val(x2464);
   int x2472 = Int_val(x2463);
   int x2475 = Long_val(x2462);
   int x2478 = Long_val(x2461);
   int x2481 = Long_val(x2460);
   int x2484 = Long_val(x2459);
   float _Complex* x2487 = CTYPES_ADDR_OF_FATPTR(x2458);
   int x2488 = Long_val(x2457);
   float _Complex* x2491 = CTYPES_ADDR_OF_FATPTR(x2456);
   int x2492 = Long_val(x2455);
   int* x2495 = CTYPES_ADDR_OF_FATPTR(x2454);
   char* x2496 = CTYPES_ADDR_OF_FATPTR(x2453);
   float* x2497 = CTYPES_ADDR_OF_FATPTR(x2452);
   float* x2498 = CTYPES_ADDR_OF_FATPTR(x2451);
   float _Complex* x2499 = CTYPES_ADDR_OF_FATPTR(x2450);
   int x2500 = Long_val(x2449);
   float _Complex* x2503 = CTYPES_ADDR_OF_FATPTR(x2448);
   int x2504 = Long_val(x2447);
   float* x2507 = CTYPES_ADDR_OF_FATPTR(x2446);
   float* x2508 = CTYPES_ADDR_OF_FATPTR(x2445);
   float* x2509 = CTYPES_ADDR_OF_FATPTR(x2444);
   float* x2510 = CTYPES_ADDR_OF_FATPTR(x2443);
   int x2511 =
   LAPACKE_cgbsvx(x2466, (char)x2469, (char)x2472, x2475, x2478, x2481,
                  x2484, x2487, x2488, x2491, x2492, x2495, x2496, x2497,
                  x2498, x2499, x2500, x2503, x2504, x2507, x2508, x2509,
                  x2510);
   return Val_long(x2511);
}
value owl_stub_41_LAPACKE_cgbsvx_byte23(value* argv, int argc)
{
   value x2512 = argv[22];
   value x2513 = argv[21];
   value x2514 = argv[20];
   value x2515 = argv[19];
   value x2516 = argv[18];
   value x2517 = argv[17];
   value x2518 = argv[16];
   value x2519 = argv[15];
   value x2520 = argv[14];
   value x2521 = argv[13];
   value x2522 = argv[12];
   value x2523 = argv[11];
   value x2524 = argv[10];
   value x2525 = argv[9];
   value x2526 = argv[8];
   value x2527 = argv[7];
   value x2528 = argv[6];
   value x2529 = argv[5];
   value x2530 = argv[4];
   value x2531 = argv[3];
   value x2532 = argv[2];
   value x2533 = argv[1];
   value x2534 = argv[0];
   return
     owl_stub_41_LAPACKE_cgbsvx(x2534, x2533, x2532, x2531, x2530, x2529,
                                x2528, x2527, x2526, x2525, x2524, x2523,
                                x2522, x2521, x2520, x2519, x2518, x2517,
                                x2516, x2515, x2514, x2513, x2512);
}
value owl_stub_42_LAPACKE_zgbsvx(value x2557, value x2556, value x2555,
                                 value x2554, value x2553, value x2552,
                                 value x2551, value x2550, value x2549,
                                 value x2548, value x2547, value x2546,
                                 value x2545, value x2544, value x2543,
                                 value x2542, value x2541, value x2540,
                                 value x2539, value x2538, value x2537,
                                 value x2536, value x2535)
{
   int x2558 = Long_val(x2557);
   int x2561 = Int_val(x2556);
   int x2564 = Int_val(x2555);
   int x2567 = Long_val(x2554);
   int x2570 = Long_val(x2553);
   int x2573 = Long_val(x2552);
   int x2576 = Long_val(x2551);
   double _Complex* x2579 = CTYPES_ADDR_OF_FATPTR(x2550);
   int x2580 = Long_val(x2549);
   double _Complex* x2583 = CTYPES_ADDR_OF_FATPTR(x2548);
   int x2584 = Long_val(x2547);
   int* x2587 = CTYPES_ADDR_OF_FATPTR(x2546);
   char* x2588 = CTYPES_ADDR_OF_FATPTR(x2545);
   double* x2589 = CTYPES_ADDR_OF_FATPTR(x2544);
   double* x2590 = CTYPES_ADDR_OF_FATPTR(x2543);
   double _Complex* x2591 = CTYPES_ADDR_OF_FATPTR(x2542);
   int x2592 = Long_val(x2541);
   double _Complex* x2595 = CTYPES_ADDR_OF_FATPTR(x2540);
   int x2596 = Long_val(x2539);
   double* x2599 = CTYPES_ADDR_OF_FATPTR(x2538);
   double* x2600 = CTYPES_ADDR_OF_FATPTR(x2537);
   double* x2601 = CTYPES_ADDR_OF_FATPTR(x2536);
   double* x2602 = CTYPES_ADDR_OF_FATPTR(x2535);
   int x2603 =
   LAPACKE_zgbsvx(x2558, (char)x2561, (char)x2564, x2567, x2570, x2573,
                  x2576, x2579, x2580, x2583, x2584, x2587, x2588, x2589,
                  x2590, x2591, x2592, x2595, x2596, x2599, x2600, x2601,
                  x2602);
   return Val_long(x2603);
}
value owl_stub_42_LAPACKE_zgbsvx_byte23(value* argv, int argc)
{
   value x2604 = argv[22];
   value x2605 = argv[21];
   value x2606 = argv[20];
   value x2607 = argv[19];
   value x2608 = argv[18];
   value x2609 = argv[17];
   value x2610 = argv[16];
   value x2611 = argv[15];
   value x2612 = argv[14];
   value x2613 = argv[13];
   value x2614 = argv[12];
   value x2615 = argv[11];
   value x2616 = argv[10];
   value x2617 = argv[9];
   value x2618 = argv[8];
   value x2619 = argv[7];
   value x2620 = argv[6];
   value x2621 = argv[5];
   value x2622 = argv[4];
   value x2623 = argv[3];
   value x2624 = argv[2];
   value x2625 = argv[1];
   value x2626 = argv[0];
   return
     owl_stub_42_LAPACKE_zgbsvx(x2626, x2625, x2624, x2623, x2622, x2621,
                                x2620, x2619, x2618, x2617, x2616, x2615,
                                x2614, x2613, x2612, x2611, x2610, x2609,
                                x2608, x2607, x2606, x2605, x2604);
}
value owl_stub_43_LAPACKE_sgbsvxx(value x2653, value x2652, value x2651,
                                  value x2650, value x2649, value x2648,
                                  value x2647, value x2646, value x2645,
                                  value x2644, value x2643, value x2642,
                                  value x2641, value x2640, value x2639,
                                  value x2638, value x2637, value x2636,
                                  value x2635, value x2634, value x2633,
                                  value x2632, value x2631, value x2630,
                                  value x2629, value x2628, value x2627)
{
   int x2654 = Long_val(x2653);
   int x2657 = Int_val(x2652);
   int x2660 = Int_val(x2651);
   int x2663 = Long_val(x2650);
   int x2666 = Long_val(x2649);
   int x2669 = Long_val(x2648);
   int x2672 = Long_val(x2647);
   float* x2675 = CTYPES_ADDR_OF_FATPTR(x2646);
   int x2676 = Long_val(x2645);
   float* x2679 = CTYPES_ADDR_OF_FATPTR(x2644);
   int x2680 = Long_val(x2643);
   int* x2683 = CTYPES_ADDR_OF_FATPTR(x2642);
   char* x2684 = CTYPES_ADDR_OF_FATPTR(x2641);
   float* x2685 = CTYPES_ADDR_OF_FATPTR(x2640);
   float* x2686 = CTYPES_ADDR_OF_FATPTR(x2639);
   float* x2687 = CTYPES_ADDR_OF_FATPTR(x2638);
   int x2688 = Long_val(x2637);
   float* x2691 = CTYPES_ADDR_OF_FATPTR(x2636);
   int x2692 = Long_val(x2635);
   float* x2695 = CTYPES_ADDR_OF_FATPTR(x2634);
   float* x2696 = CTYPES_ADDR_OF_FATPTR(x2633);
   float* x2697 = CTYPES_ADDR_OF_FATPTR(x2632);
   int x2698 = Long_val(x2631);
   float* x2701 = CTYPES_ADDR_OF_FATPTR(x2630);
   float* x2702 = CTYPES_ADDR_OF_FATPTR(x2629);
   int x2703 = Long_val(x2628);
   float* x2706 = CTYPES_ADDR_OF_FATPTR(x2627);
   int x2707 =
   LAPACKE_sgbsvxx(x2654, (char)x2657, (char)x2660, x2663, x2666, x2669,
                   x2672, x2675, x2676, x2679, x2680, x2683, x2684, x2685,
                   x2686, x2687, x2688, x2691, x2692, x2695, x2696, x2697,
                   x2698, x2701, x2702, x2703, x2706);
   return Val_long(x2707);
}
value owl_stub_43_LAPACKE_sgbsvxx_byte27(value* argv, int argc)
{
   value x2708 = argv[26];
   value x2709 = argv[25];
   value x2710 = argv[24];
   value x2711 = argv[23];
   value x2712 = argv[22];
   value x2713 = argv[21];
   value x2714 = argv[20];
   value x2715 = argv[19];
   value x2716 = argv[18];
   value x2717 = argv[17];
   value x2718 = argv[16];
   value x2719 = argv[15];
   value x2720 = argv[14];
   value x2721 = argv[13];
   value x2722 = argv[12];
   value x2723 = argv[11];
   value x2724 = argv[10];
   value x2725 = argv[9];
   value x2726 = argv[8];
   value x2727 = argv[7];
   value x2728 = argv[6];
   value x2729 = argv[5];
   value x2730 = argv[4];
   value x2731 = argv[3];
   value x2732 = argv[2];
   value x2733 = argv[1];
   value x2734 = argv[0];
   return
     owl_stub_43_LAPACKE_sgbsvxx(x2734, x2733, x2732, x2731, x2730, x2729,
                                 x2728, x2727, x2726, x2725, x2724, x2723,
                                 x2722, x2721, x2720, x2719, x2718, x2717,
                                 x2716, x2715, x2714, x2713, x2712, x2711,
                                 x2710, x2709, x2708);
}
value owl_stub_44_LAPACKE_dgbsvxx(value x2761, value x2760, value x2759,
                                  value x2758, value x2757, value x2756,
                                  value x2755, value x2754, value x2753,
                                  value x2752, value x2751, value x2750,
                                  value x2749, value x2748, value x2747,
                                  value x2746, value x2745, value x2744,
                                  value x2743, value x2742, value x2741,
                                  value x2740, value x2739, value x2738,
                                  value x2737, value x2736, value x2735)
{
   int x2762 = Long_val(x2761);
   int x2765 = Int_val(x2760);
   int x2768 = Int_val(x2759);
   int x2771 = Long_val(x2758);
   int x2774 = Long_val(x2757);
   int x2777 = Long_val(x2756);
   int x2780 = Long_val(x2755);
   double* x2783 = CTYPES_ADDR_OF_FATPTR(x2754);
   int x2784 = Long_val(x2753);
   double* x2787 = CTYPES_ADDR_OF_FATPTR(x2752);
   int x2788 = Long_val(x2751);
   int* x2791 = CTYPES_ADDR_OF_FATPTR(x2750);
   char* x2792 = CTYPES_ADDR_OF_FATPTR(x2749);
   double* x2793 = CTYPES_ADDR_OF_FATPTR(x2748);
   double* x2794 = CTYPES_ADDR_OF_FATPTR(x2747);
   double* x2795 = CTYPES_ADDR_OF_FATPTR(x2746);
   int x2796 = Long_val(x2745);
   double* x2799 = CTYPES_ADDR_OF_FATPTR(x2744);
   int x2800 = Long_val(x2743);
   double* x2803 = CTYPES_ADDR_OF_FATPTR(x2742);
   double* x2804 = CTYPES_ADDR_OF_FATPTR(x2741);
   double* x2805 = CTYPES_ADDR_OF_FATPTR(x2740);
   int x2806 = Long_val(x2739);
   double* x2809 = CTYPES_ADDR_OF_FATPTR(x2738);
   double* x2810 = CTYPES_ADDR_OF_FATPTR(x2737);
   int x2811 = Long_val(x2736);
   double* x2814 = CTYPES_ADDR_OF_FATPTR(x2735);
   int x2815 =
   LAPACKE_dgbsvxx(x2762, (char)x2765, (char)x2768, x2771, x2774, x2777,
                   x2780, x2783, x2784, x2787, x2788, x2791, x2792, x2793,
                   x2794, x2795, x2796, x2799, x2800, x2803, x2804, x2805,
                   x2806, x2809, x2810, x2811, x2814);
   return Val_long(x2815);
}
value owl_stub_44_LAPACKE_dgbsvxx_byte27(value* argv, int argc)
{
   value x2816 = argv[26];
   value x2817 = argv[25];
   value x2818 = argv[24];
   value x2819 = argv[23];
   value x2820 = argv[22];
   value x2821 = argv[21];
   value x2822 = argv[20];
   value x2823 = argv[19];
   value x2824 = argv[18];
   value x2825 = argv[17];
   value x2826 = argv[16];
   value x2827 = argv[15];
   value x2828 = argv[14];
   value x2829 = argv[13];
   value x2830 = argv[12];
   value x2831 = argv[11];
   value x2832 = argv[10];
   value x2833 = argv[9];
   value x2834 = argv[8];
   value x2835 = argv[7];
   value x2836 = argv[6];
   value x2837 = argv[5];
   value x2838 = argv[4];
   value x2839 = argv[3];
   value x2840 = argv[2];
   value x2841 = argv[1];
   value x2842 = argv[0];
   return
     owl_stub_44_LAPACKE_dgbsvxx(x2842, x2841, x2840, x2839, x2838, x2837,
                                 x2836, x2835, x2834, x2833, x2832, x2831,
                                 x2830, x2829, x2828, x2827, x2826, x2825,
                                 x2824, x2823, x2822, x2821, x2820, x2819,
                                 x2818, x2817, x2816);
}
value owl_stub_45_LAPACKE_cgbsvxx(value x2869, value x2868, value x2867,
                                  value x2866, value x2865, value x2864,
                                  value x2863, value x2862, value x2861,
                                  value x2860, value x2859, value x2858,
                                  value x2857, value x2856, value x2855,
                                  value x2854, value x2853, value x2852,
                                  value x2851, value x2850, value x2849,
                                  value x2848, value x2847, value x2846,
                                  value x2845, value x2844, value x2843)
{
   int x2870 = Long_val(x2869);
   int x2873 = Int_val(x2868);
   int x2876 = Int_val(x2867);
   int x2879 = Long_val(x2866);
   int x2882 = Long_val(x2865);
   int x2885 = Long_val(x2864);
   int x2888 = Long_val(x2863);
   float _Complex* x2891 = CTYPES_ADDR_OF_FATPTR(x2862);
   int x2892 = Long_val(x2861);
   float _Complex* x2895 = CTYPES_ADDR_OF_FATPTR(x2860);
   int x2896 = Long_val(x2859);
   int* x2899 = CTYPES_ADDR_OF_FATPTR(x2858);
   char* x2900 = CTYPES_ADDR_OF_FATPTR(x2857);
   float* x2901 = CTYPES_ADDR_OF_FATPTR(x2856);
   float* x2902 = CTYPES_ADDR_OF_FATPTR(x2855);
   float _Complex* x2903 = CTYPES_ADDR_OF_FATPTR(x2854);
   int x2904 = Long_val(x2853);
   float _Complex* x2907 = CTYPES_ADDR_OF_FATPTR(x2852);
   int x2908 = Long_val(x2851);
   float* x2911 = CTYPES_ADDR_OF_FATPTR(x2850);
   float* x2912 = CTYPES_ADDR_OF_FATPTR(x2849);
   float* x2913 = CTYPES_ADDR_OF_FATPTR(x2848);
   int x2914 = Long_val(x2847);
   float* x2917 = CTYPES_ADDR_OF_FATPTR(x2846);
   float* x2918 = CTYPES_ADDR_OF_FATPTR(x2845);
   int x2919 = Long_val(x2844);
   float* x2922 = CTYPES_ADDR_OF_FATPTR(x2843);
   int x2923 =
   LAPACKE_cgbsvxx(x2870, (char)x2873, (char)x2876, x2879, x2882, x2885,
                   x2888, x2891, x2892, x2895, x2896, x2899, x2900, x2901,
                   x2902, x2903, x2904, x2907, x2908, x2911, x2912, x2913,
                   x2914, x2917, x2918, x2919, x2922);
   return Val_long(x2923);
}
value owl_stub_45_LAPACKE_cgbsvxx_byte27(value* argv, int argc)
{
   value x2924 = argv[26];
   value x2925 = argv[25];
   value x2926 = argv[24];
   value x2927 = argv[23];
   value x2928 = argv[22];
   value x2929 = argv[21];
   value x2930 = argv[20];
   value x2931 = argv[19];
   value x2932 = argv[18];
   value x2933 = argv[17];
   value x2934 = argv[16];
   value x2935 = argv[15];
   value x2936 = argv[14];
   value x2937 = argv[13];
   value x2938 = argv[12];
   value x2939 = argv[11];
   value x2940 = argv[10];
   value x2941 = argv[9];
   value x2942 = argv[8];
   value x2943 = argv[7];
   value x2944 = argv[6];
   value x2945 = argv[5];
   value x2946 = argv[4];
   value x2947 = argv[3];
   value x2948 = argv[2];
   value x2949 = argv[1];
   value x2950 = argv[0];
   return
     owl_stub_45_LAPACKE_cgbsvxx(x2950, x2949, x2948, x2947, x2946, x2945,
                                 x2944, x2943, x2942, x2941, x2940, x2939,
                                 x2938, x2937, x2936, x2935, x2934, x2933,
                                 x2932, x2931, x2930, x2929, x2928, x2927,
                                 x2926, x2925, x2924);
}
value owl_stub_46_LAPACKE_zgbsvxx(value x2977, value x2976, value x2975,
                                  value x2974, value x2973, value x2972,
                                  value x2971, value x2970, value x2969,
                                  value x2968, value x2967, value x2966,
                                  value x2965, value x2964, value x2963,
                                  value x2962, value x2961, value x2960,
                                  value x2959, value x2958, value x2957,
                                  value x2956, value x2955, value x2954,
                                  value x2953, value x2952, value x2951)
{
   int x2978 = Long_val(x2977);
   int x2981 = Int_val(x2976);
   int x2984 = Int_val(x2975);
   int x2987 = Long_val(x2974);
   int x2990 = Long_val(x2973);
   int x2993 = Long_val(x2972);
   int x2996 = Long_val(x2971);
   double _Complex* x2999 = CTYPES_ADDR_OF_FATPTR(x2970);
   int x3000 = Long_val(x2969);
   double _Complex* x3003 = CTYPES_ADDR_OF_FATPTR(x2968);
   int x3004 = Long_val(x2967);
   int* x3007 = CTYPES_ADDR_OF_FATPTR(x2966);
   char* x3008 = CTYPES_ADDR_OF_FATPTR(x2965);
   double* x3009 = CTYPES_ADDR_OF_FATPTR(x2964);
   double* x3010 = CTYPES_ADDR_OF_FATPTR(x2963);
   double _Complex* x3011 = CTYPES_ADDR_OF_FATPTR(x2962);
   int x3012 = Long_val(x2961);
   double _Complex* x3015 = CTYPES_ADDR_OF_FATPTR(x2960);
   int x3016 = Long_val(x2959);
   double* x3019 = CTYPES_ADDR_OF_FATPTR(x2958);
   double* x3020 = CTYPES_ADDR_OF_FATPTR(x2957);
   double* x3021 = CTYPES_ADDR_OF_FATPTR(x2956);
   int x3022 = Long_val(x2955);
   double* x3025 = CTYPES_ADDR_OF_FATPTR(x2954);
   double* x3026 = CTYPES_ADDR_OF_FATPTR(x2953);
   int x3027 = Long_val(x2952);
   double* x3030 = CTYPES_ADDR_OF_FATPTR(x2951);
   int x3031 =
   LAPACKE_zgbsvxx(x2978, (char)x2981, (char)x2984, x2987, x2990, x2993,
                   x2996, x2999, x3000, x3003, x3004, x3007, x3008, x3009,
                   x3010, x3011, x3012, x3015, x3016, x3019, x3020, x3021,
                   x3022, x3025, x3026, x3027, x3030);
   return Val_long(x3031);
}
value owl_stub_46_LAPACKE_zgbsvxx_byte27(value* argv, int argc)
{
   value x3032 = argv[26];
   value x3033 = argv[25];
   value x3034 = argv[24];
   value x3035 = argv[23];
   value x3036 = argv[22];
   value x3037 = argv[21];
   value x3038 = argv[20];
   value x3039 = argv[19];
   value x3040 = argv[18];
   value x3041 = argv[17];
   value x3042 = argv[16];
   value x3043 = argv[15];
   value x3044 = argv[14];
   value x3045 = argv[13];
   value x3046 = argv[12];
   value x3047 = argv[11];
   value x3048 = argv[10];
   value x3049 = argv[9];
   value x3050 = argv[8];
   value x3051 = argv[7];
   value x3052 = argv[6];
   value x3053 = argv[5];
   value x3054 = argv[4];
   value x3055 = argv[3];
   value x3056 = argv[2];
   value x3057 = argv[1];
   value x3058 = argv[0];
   return
     owl_stub_46_LAPACKE_zgbsvxx(x3058, x3057, x3056, x3055, x3054, x3053,
                                 x3052, x3051, x3050, x3049, x3048, x3047,
                                 x3046, x3045, x3044, x3043, x3042, x3041,
                                 x3040, x3039, x3038, x3037, x3036, x3035,
                                 x3034, x3033, x3032);
}
value owl_stub_47_LAPACKE_sgbtrf(value x3066, value x3065, value x3064,
                                 value x3063, value x3062, value x3061,
                                 value x3060, value x3059)
{
   int x3067 = Long_val(x3066);
   int x3070 = Long_val(x3065);
   int x3073 = Long_val(x3064);
   int x3076 = Long_val(x3063);
   int x3079 = Long_val(x3062);
   float* x3082 = CTYPES_ADDR_OF_FATPTR(x3061);
   int x3083 = Long_val(x3060);
   int* x3086 = CTYPES_ADDR_OF_FATPTR(x3059);
   int x3087 =
   LAPACKE_sgbtrf(x3067, x3070, x3073, x3076, x3079, x3082, x3083, x3086);
   return Val_long(x3087);
}
value owl_stub_47_LAPACKE_sgbtrf_byte8(value* argv, int argc)
{
   value x3088 = argv[7];
   value x3089 = argv[6];
   value x3090 = argv[5];
   value x3091 = argv[4];
   value x3092 = argv[3];
   value x3093 = argv[2];
   value x3094 = argv[1];
   value x3095 = argv[0];
   return
     owl_stub_47_LAPACKE_sgbtrf(x3095, x3094, x3093, x3092, x3091, x3090,
                                x3089, x3088);
}
value owl_stub_48_LAPACKE_dgbtrf(value x3103, value x3102, value x3101,
                                 value x3100, value x3099, value x3098,
                                 value x3097, value x3096)
{
   int x3104 = Long_val(x3103);
   int x3107 = Long_val(x3102);
   int x3110 = Long_val(x3101);
   int x3113 = Long_val(x3100);
   int x3116 = Long_val(x3099);
   double* x3119 = CTYPES_ADDR_OF_FATPTR(x3098);
   int x3120 = Long_val(x3097);
   int* x3123 = CTYPES_ADDR_OF_FATPTR(x3096);
   int x3124 =
   LAPACKE_dgbtrf(x3104, x3107, x3110, x3113, x3116, x3119, x3120, x3123);
   return Val_long(x3124);
}
value owl_stub_48_LAPACKE_dgbtrf_byte8(value* argv, int argc)
{
   value x3125 = argv[7];
   value x3126 = argv[6];
   value x3127 = argv[5];
   value x3128 = argv[4];
   value x3129 = argv[3];
   value x3130 = argv[2];
   value x3131 = argv[1];
   value x3132 = argv[0];
   return
     owl_stub_48_LAPACKE_dgbtrf(x3132, x3131, x3130, x3129, x3128, x3127,
                                x3126, x3125);
}
value owl_stub_49_LAPACKE_cgbtrf(value x3140, value x3139, value x3138,
                                 value x3137, value x3136, value x3135,
                                 value x3134, value x3133)
{
   int x3141 = Long_val(x3140);
   int x3144 = Long_val(x3139);
   int x3147 = Long_val(x3138);
   int x3150 = Long_val(x3137);
   int x3153 = Long_val(x3136);
   float _Complex* x3156 = CTYPES_ADDR_OF_FATPTR(x3135);
   int x3157 = Long_val(x3134);
   int* x3160 = CTYPES_ADDR_OF_FATPTR(x3133);
   int x3161 =
   LAPACKE_cgbtrf(x3141, x3144, x3147, x3150, x3153, x3156, x3157, x3160);
   return Val_long(x3161);
}
value owl_stub_49_LAPACKE_cgbtrf_byte8(value* argv, int argc)
{
   value x3162 = argv[7];
   value x3163 = argv[6];
   value x3164 = argv[5];
   value x3165 = argv[4];
   value x3166 = argv[3];
   value x3167 = argv[2];
   value x3168 = argv[1];
   value x3169 = argv[0];
   return
     owl_stub_49_LAPACKE_cgbtrf(x3169, x3168, x3167, x3166, x3165, x3164,
                                x3163, x3162);
}
value owl_stub_50_LAPACKE_zgbtrf(value x3177, value x3176, value x3175,
                                 value x3174, value x3173, value x3172,
                                 value x3171, value x3170)
{
   int x3178 = Long_val(x3177);
   int x3181 = Long_val(x3176);
   int x3184 = Long_val(x3175);
   int x3187 = Long_val(x3174);
   int x3190 = Long_val(x3173);
   double _Complex* x3193 = CTYPES_ADDR_OF_FATPTR(x3172);
   int x3194 = Long_val(x3171);
   int* x3197 = CTYPES_ADDR_OF_FATPTR(x3170);
   int x3198 =
   LAPACKE_zgbtrf(x3178, x3181, x3184, x3187, x3190, x3193, x3194, x3197);
   return Val_long(x3198);
}
value owl_stub_50_LAPACKE_zgbtrf_byte8(value* argv, int argc)
{
   value x3199 = argv[7];
   value x3200 = argv[6];
   value x3201 = argv[5];
   value x3202 = argv[4];
   value x3203 = argv[3];
   value x3204 = argv[2];
   value x3205 = argv[1];
   value x3206 = argv[0];
   return
     owl_stub_50_LAPACKE_zgbtrf(x3206, x3205, x3204, x3203, x3202, x3201,
                                x3200, x3199);
}
value owl_stub_51_LAPACKE_sgbtrs(value x3217, value x3216, value x3215,
                                 value x3214, value x3213, value x3212,
                                 value x3211, value x3210, value x3209,
                                 value x3208, value x3207)
{
   int x3218 = Long_val(x3217);
   int x3221 = Int_val(x3216);
   int x3224 = Long_val(x3215);
   int x3227 = Long_val(x3214);
   int x3230 = Long_val(x3213);
   int x3233 = Long_val(x3212);
   float* x3236 = CTYPES_ADDR_OF_FATPTR(x3211);
   int x3237 = Long_val(x3210);
   int* x3240 = CTYPES_ADDR_OF_FATPTR(x3209);
   float* x3241 = CTYPES_ADDR_OF_FATPTR(x3208);
   int x3242 = Long_val(x3207);
   int x3245 =
   LAPACKE_sgbtrs(x3218, (char)x3221, x3224, x3227, x3230, x3233, x3236,
                  x3237, x3240, x3241, x3242);
   return Val_long(x3245);
}
value owl_stub_51_LAPACKE_sgbtrs_byte11(value* argv, int argc)
{
   value x3246 = argv[10];
   value x3247 = argv[9];
   value x3248 = argv[8];
   value x3249 = argv[7];
   value x3250 = argv[6];
   value x3251 = argv[5];
   value x3252 = argv[4];
   value x3253 = argv[3];
   value x3254 = argv[2];
   value x3255 = argv[1];
   value x3256 = argv[0];
   return
     owl_stub_51_LAPACKE_sgbtrs(x3256, x3255, x3254, x3253, x3252, x3251,
                                x3250, x3249, x3248, x3247, x3246);
}
value owl_stub_52_LAPACKE_dgbtrs(value x3267, value x3266, value x3265,
                                 value x3264, value x3263, value x3262,
                                 value x3261, value x3260, value x3259,
                                 value x3258, value x3257)
{
   int x3268 = Long_val(x3267);
   int x3271 = Int_val(x3266);
   int x3274 = Long_val(x3265);
   int x3277 = Long_val(x3264);
   int x3280 = Long_val(x3263);
   int x3283 = Long_val(x3262);
   double* x3286 = CTYPES_ADDR_OF_FATPTR(x3261);
   int x3287 = Long_val(x3260);
   int* x3290 = CTYPES_ADDR_OF_FATPTR(x3259);
   double* x3291 = CTYPES_ADDR_OF_FATPTR(x3258);
   int x3292 = Long_val(x3257);
   int x3295 =
   LAPACKE_dgbtrs(x3268, (char)x3271, x3274, x3277, x3280, x3283, x3286,
                  x3287, x3290, x3291, x3292);
   return Val_long(x3295);
}
value owl_stub_52_LAPACKE_dgbtrs_byte11(value* argv, int argc)
{
   value x3296 = argv[10];
   value x3297 = argv[9];
   value x3298 = argv[8];
   value x3299 = argv[7];
   value x3300 = argv[6];
   value x3301 = argv[5];
   value x3302 = argv[4];
   value x3303 = argv[3];
   value x3304 = argv[2];
   value x3305 = argv[1];
   value x3306 = argv[0];
   return
     owl_stub_52_LAPACKE_dgbtrs(x3306, x3305, x3304, x3303, x3302, x3301,
                                x3300, x3299, x3298, x3297, x3296);
}
value owl_stub_53_LAPACKE_cgbtrs(value x3317, value x3316, value x3315,
                                 value x3314, value x3313, value x3312,
                                 value x3311, value x3310, value x3309,
                                 value x3308, value x3307)
{
   int x3318 = Long_val(x3317);
   int x3321 = Int_val(x3316);
   int x3324 = Long_val(x3315);
   int x3327 = Long_val(x3314);
   int x3330 = Long_val(x3313);
   int x3333 = Long_val(x3312);
   float _Complex* x3336 = CTYPES_ADDR_OF_FATPTR(x3311);
   int x3337 = Long_val(x3310);
   int* x3340 = CTYPES_ADDR_OF_FATPTR(x3309);
   float _Complex* x3341 = CTYPES_ADDR_OF_FATPTR(x3308);
   int x3342 = Long_val(x3307);
   int x3345 =
   LAPACKE_cgbtrs(x3318, (char)x3321, x3324, x3327, x3330, x3333, x3336,
                  x3337, x3340, x3341, x3342);
   return Val_long(x3345);
}
value owl_stub_53_LAPACKE_cgbtrs_byte11(value* argv, int argc)
{
   value x3346 = argv[10];
   value x3347 = argv[9];
   value x3348 = argv[8];
   value x3349 = argv[7];
   value x3350 = argv[6];
   value x3351 = argv[5];
   value x3352 = argv[4];
   value x3353 = argv[3];
   value x3354 = argv[2];
   value x3355 = argv[1];
   value x3356 = argv[0];
   return
     owl_stub_53_LAPACKE_cgbtrs(x3356, x3355, x3354, x3353, x3352, x3351,
                                x3350, x3349, x3348, x3347, x3346);
}
value owl_stub_54_LAPACKE_zgbtrs(value x3367, value x3366, value x3365,
                                 value x3364, value x3363, value x3362,
                                 value x3361, value x3360, value x3359,
                                 value x3358, value x3357)
{
   int x3368 = Long_val(x3367);
   int x3371 = Int_val(x3366);
   int x3374 = Long_val(x3365);
   int x3377 = Long_val(x3364);
   int x3380 = Long_val(x3363);
   int x3383 = Long_val(x3362);
   double _Complex* x3386 = CTYPES_ADDR_OF_FATPTR(x3361);
   int x3387 = Long_val(x3360);
   int* x3390 = CTYPES_ADDR_OF_FATPTR(x3359);
   double _Complex* x3391 = CTYPES_ADDR_OF_FATPTR(x3358);
   int x3392 = Long_val(x3357);
   int x3395 =
   LAPACKE_zgbtrs(x3368, (char)x3371, x3374, x3377, x3380, x3383, x3386,
                  x3387, x3390, x3391, x3392);
   return Val_long(x3395);
}
value owl_stub_54_LAPACKE_zgbtrs_byte11(value* argv, int argc)
{
   value x3396 = argv[10];
   value x3397 = argv[9];
   value x3398 = argv[8];
   value x3399 = argv[7];
   value x3400 = argv[6];
   value x3401 = argv[5];
   value x3402 = argv[4];
   value x3403 = argv[3];
   value x3404 = argv[2];
   value x3405 = argv[1];
   value x3406 = argv[0];
   return
     owl_stub_54_LAPACKE_zgbtrs(x3406, x3405, x3404, x3403, x3402, x3401,
                                x3400, x3399, x3398, x3397, x3396);
}
value owl_stub_55_LAPACKE_sgebak(value x3416, value x3415, value x3414,
                                 value x3413, value x3412, value x3411,
                                 value x3410, value x3409, value x3408,
                                 value x3407)
{
   int x3417 = Long_val(x3416);
   int x3420 = Int_val(x3415);
   int x3423 = Int_val(x3414);
   int x3426 = Long_val(x3413);
   int x3429 = Long_val(x3412);
   int x3432 = Long_val(x3411);
   float* x3435 = CTYPES_ADDR_OF_FATPTR(x3410);
   int x3436 = Long_val(x3409);
   float* x3439 = CTYPES_ADDR_OF_FATPTR(x3408);
   int x3440 = Long_val(x3407);
   int x3443 =
   LAPACKE_sgebak(x3417, (char)x3420, (char)x3423, x3426, x3429, x3432,
                  x3435, x3436, x3439, x3440);
   return Val_long(x3443);
}
value owl_stub_55_LAPACKE_sgebak_byte10(value* argv, int argc)
{
   value x3444 = argv[9];
   value x3445 = argv[8];
   value x3446 = argv[7];
   value x3447 = argv[6];
   value x3448 = argv[5];
   value x3449 = argv[4];
   value x3450 = argv[3];
   value x3451 = argv[2];
   value x3452 = argv[1];
   value x3453 = argv[0];
   return
     owl_stub_55_LAPACKE_sgebak(x3453, x3452, x3451, x3450, x3449, x3448,
                                x3447, x3446, x3445, x3444);
}
value owl_stub_56_LAPACKE_dgebak(value x3463, value x3462, value x3461,
                                 value x3460, value x3459, value x3458,
                                 value x3457, value x3456, value x3455,
                                 value x3454)
{
   int x3464 = Long_val(x3463);
   int x3467 = Int_val(x3462);
   int x3470 = Int_val(x3461);
   int x3473 = Long_val(x3460);
   int x3476 = Long_val(x3459);
   int x3479 = Long_val(x3458);
   double* x3482 = CTYPES_ADDR_OF_FATPTR(x3457);
   int x3483 = Long_val(x3456);
   double* x3486 = CTYPES_ADDR_OF_FATPTR(x3455);
   int x3487 = Long_val(x3454);
   int x3490 =
   LAPACKE_dgebak(x3464, (char)x3467, (char)x3470, x3473, x3476, x3479,
                  x3482, x3483, x3486, x3487);
   return Val_long(x3490);
}
value owl_stub_56_LAPACKE_dgebak_byte10(value* argv, int argc)
{
   value x3491 = argv[9];
   value x3492 = argv[8];
   value x3493 = argv[7];
   value x3494 = argv[6];
   value x3495 = argv[5];
   value x3496 = argv[4];
   value x3497 = argv[3];
   value x3498 = argv[2];
   value x3499 = argv[1];
   value x3500 = argv[0];
   return
     owl_stub_56_LAPACKE_dgebak(x3500, x3499, x3498, x3497, x3496, x3495,
                                x3494, x3493, x3492, x3491);
}
value owl_stub_57_LAPACKE_cgebak(value x3510, value x3509, value x3508,
                                 value x3507, value x3506, value x3505,
                                 value x3504, value x3503, value x3502,
                                 value x3501)
{
   int x3511 = Long_val(x3510);
   int x3514 = Int_val(x3509);
   int x3517 = Int_val(x3508);
   int x3520 = Long_val(x3507);
   int x3523 = Long_val(x3506);
   int x3526 = Long_val(x3505);
   float* x3529 = CTYPES_ADDR_OF_FATPTR(x3504);
   int x3530 = Long_val(x3503);
   float _Complex* x3533 = CTYPES_ADDR_OF_FATPTR(x3502);
   int x3534 = Long_val(x3501);
   int x3537 =
   LAPACKE_cgebak(x3511, (char)x3514, (char)x3517, x3520, x3523, x3526,
                  x3529, x3530, x3533, x3534);
   return Val_long(x3537);
}
value owl_stub_57_LAPACKE_cgebak_byte10(value* argv, int argc)
{
   value x3538 = argv[9];
   value x3539 = argv[8];
   value x3540 = argv[7];
   value x3541 = argv[6];
   value x3542 = argv[5];
   value x3543 = argv[4];
   value x3544 = argv[3];
   value x3545 = argv[2];
   value x3546 = argv[1];
   value x3547 = argv[0];
   return
     owl_stub_57_LAPACKE_cgebak(x3547, x3546, x3545, x3544, x3543, x3542,
                                x3541, x3540, x3539, x3538);
}
value owl_stub_58_LAPACKE_zgebak(value x3557, value x3556, value x3555,
                                 value x3554, value x3553, value x3552,
                                 value x3551, value x3550, value x3549,
                                 value x3548)
{
   int x3558 = Long_val(x3557);
   int x3561 = Int_val(x3556);
   int x3564 = Int_val(x3555);
   int x3567 = Long_val(x3554);
   int x3570 = Long_val(x3553);
   int x3573 = Long_val(x3552);
   double* x3576 = CTYPES_ADDR_OF_FATPTR(x3551);
   int x3577 = Long_val(x3550);
   double _Complex* x3580 = CTYPES_ADDR_OF_FATPTR(x3549);
   int x3581 = Long_val(x3548);
   int x3584 =
   LAPACKE_zgebak(x3558, (char)x3561, (char)x3564, x3567, x3570, x3573,
                  x3576, x3577, x3580, x3581);
   return Val_long(x3584);
}
value owl_stub_58_LAPACKE_zgebak_byte10(value* argv, int argc)
{
   value x3585 = argv[9];
   value x3586 = argv[8];
   value x3587 = argv[7];
   value x3588 = argv[6];
   value x3589 = argv[5];
   value x3590 = argv[4];
   value x3591 = argv[3];
   value x3592 = argv[2];
   value x3593 = argv[1];
   value x3594 = argv[0];
   return
     owl_stub_58_LAPACKE_zgebak(x3594, x3593, x3592, x3591, x3590, x3589,
                                x3588, x3587, x3586, x3585);
}
value owl_stub_59_LAPACKE_sgebal(value x3602, value x3601, value x3600,
                                 value x3599, value x3598, value x3597,
                                 value x3596, value x3595)
{
   int x3603 = Long_val(x3602);
   int x3606 = Int_val(x3601);
   int x3609 = Long_val(x3600);
   float* x3612 = CTYPES_ADDR_OF_FATPTR(x3599);
   int x3613 = Long_val(x3598);
   int* x3616 = CTYPES_ADDR_OF_FATPTR(x3597);
   int* x3617 = CTYPES_ADDR_OF_FATPTR(x3596);
   float* x3618 = CTYPES_ADDR_OF_FATPTR(x3595);
   int x3619 =
   LAPACKE_sgebal(x3603, (char)x3606, x3609, x3612, x3613, x3616, x3617,
                  x3618);
   return Val_long(x3619);
}
value owl_stub_59_LAPACKE_sgebal_byte8(value* argv, int argc)
{
   value x3620 = argv[7];
   value x3621 = argv[6];
   value x3622 = argv[5];
   value x3623 = argv[4];
   value x3624 = argv[3];
   value x3625 = argv[2];
   value x3626 = argv[1];
   value x3627 = argv[0];
   return
     owl_stub_59_LAPACKE_sgebal(x3627, x3626, x3625, x3624, x3623, x3622,
                                x3621, x3620);
}
value owl_stub_60_LAPACKE_dgebal(value x3635, value x3634, value x3633,
                                 value x3632, value x3631, value x3630,
                                 value x3629, value x3628)
{
   int x3636 = Long_val(x3635);
   int x3639 = Int_val(x3634);
   int x3642 = Long_val(x3633);
   double* x3645 = CTYPES_ADDR_OF_FATPTR(x3632);
   int x3646 = Long_val(x3631);
   int* x3649 = CTYPES_ADDR_OF_FATPTR(x3630);
   int* x3650 = CTYPES_ADDR_OF_FATPTR(x3629);
   double* x3651 = CTYPES_ADDR_OF_FATPTR(x3628);
   int x3652 =
   LAPACKE_dgebal(x3636, (char)x3639, x3642, x3645, x3646, x3649, x3650,
                  x3651);
   return Val_long(x3652);
}
value owl_stub_60_LAPACKE_dgebal_byte8(value* argv, int argc)
{
   value x3653 = argv[7];
   value x3654 = argv[6];
   value x3655 = argv[5];
   value x3656 = argv[4];
   value x3657 = argv[3];
   value x3658 = argv[2];
   value x3659 = argv[1];
   value x3660 = argv[0];
   return
     owl_stub_60_LAPACKE_dgebal(x3660, x3659, x3658, x3657, x3656, x3655,
                                x3654, x3653);
}
value owl_stub_61_LAPACKE_cgebal(value x3668, value x3667, value x3666,
                                 value x3665, value x3664, value x3663,
                                 value x3662, value x3661)
{
   int x3669 = Long_val(x3668);
   int x3672 = Int_val(x3667);
   int x3675 = Long_val(x3666);
   float _Complex* x3678 = CTYPES_ADDR_OF_FATPTR(x3665);
   int x3679 = Long_val(x3664);
   int* x3682 = CTYPES_ADDR_OF_FATPTR(x3663);
   int* x3683 = CTYPES_ADDR_OF_FATPTR(x3662);
   float* x3684 = CTYPES_ADDR_OF_FATPTR(x3661);
   int x3685 =
   LAPACKE_cgebal(x3669, (char)x3672, x3675, x3678, x3679, x3682, x3683,
                  x3684);
   return Val_long(x3685);
}
value owl_stub_61_LAPACKE_cgebal_byte8(value* argv, int argc)
{
   value x3686 = argv[7];
   value x3687 = argv[6];
   value x3688 = argv[5];
   value x3689 = argv[4];
   value x3690 = argv[3];
   value x3691 = argv[2];
   value x3692 = argv[1];
   value x3693 = argv[0];
   return
     owl_stub_61_LAPACKE_cgebal(x3693, x3692, x3691, x3690, x3689, x3688,
                                x3687, x3686);
}
value owl_stub_62_LAPACKE_zgebal(value x3701, value x3700, value x3699,
                                 value x3698, value x3697, value x3696,
                                 value x3695, value x3694)
{
   int x3702 = Long_val(x3701);
   int x3705 = Int_val(x3700);
   int x3708 = Long_val(x3699);
   double _Complex* x3711 = CTYPES_ADDR_OF_FATPTR(x3698);
   int x3712 = Long_val(x3697);
   int* x3715 = CTYPES_ADDR_OF_FATPTR(x3696);
   int* x3716 = CTYPES_ADDR_OF_FATPTR(x3695);
   double* x3717 = CTYPES_ADDR_OF_FATPTR(x3694);
   int x3718 =
   LAPACKE_zgebal(x3702, (char)x3705, x3708, x3711, x3712, x3715, x3716,
                  x3717);
   return Val_long(x3718);
}
value owl_stub_62_LAPACKE_zgebal_byte8(value* argv, int argc)
{
   value x3719 = argv[7];
   value x3720 = argv[6];
   value x3721 = argv[5];
   value x3722 = argv[4];
   value x3723 = argv[3];
   value x3724 = argv[2];
   value x3725 = argv[1];
   value x3726 = argv[0];
   return
     owl_stub_62_LAPACKE_zgebal(x3726, x3725, x3724, x3723, x3722, x3721,
                                x3720, x3719);
}
value owl_stub_63_LAPACKE_sgebrd(value x3735, value x3734, value x3733,
                                 value x3732, value x3731, value x3730,
                                 value x3729, value x3728, value x3727)
{
   int x3736 = Long_val(x3735);
   int x3739 = Long_val(x3734);
   int x3742 = Long_val(x3733);
   float* x3745 = CTYPES_ADDR_OF_FATPTR(x3732);
   int x3746 = Long_val(x3731);
   float* x3749 = CTYPES_ADDR_OF_FATPTR(x3730);
   float* x3750 = CTYPES_ADDR_OF_FATPTR(x3729);
   float* x3751 = CTYPES_ADDR_OF_FATPTR(x3728);
   float* x3752 = CTYPES_ADDR_OF_FATPTR(x3727);
   int x3753 =
   LAPACKE_sgebrd(x3736, x3739, x3742, x3745, x3746, x3749, x3750, x3751,
                  x3752);
   return Val_long(x3753);
}
value owl_stub_63_LAPACKE_sgebrd_byte9(value* argv, int argc)
{
   value x3754 = argv[8];
   value x3755 = argv[7];
   value x3756 = argv[6];
   value x3757 = argv[5];
   value x3758 = argv[4];
   value x3759 = argv[3];
   value x3760 = argv[2];
   value x3761 = argv[1];
   value x3762 = argv[0];
   return
     owl_stub_63_LAPACKE_sgebrd(x3762, x3761, x3760, x3759, x3758, x3757,
                                x3756, x3755, x3754);
}
value owl_stub_64_LAPACKE_dgebrd(value x3771, value x3770, value x3769,
                                 value x3768, value x3767, value x3766,
                                 value x3765, value x3764, value x3763)
{
   int x3772 = Long_val(x3771);
   int x3775 = Long_val(x3770);
   int x3778 = Long_val(x3769);
   double* x3781 = CTYPES_ADDR_OF_FATPTR(x3768);
   int x3782 = Long_val(x3767);
   double* x3785 = CTYPES_ADDR_OF_FATPTR(x3766);
   double* x3786 = CTYPES_ADDR_OF_FATPTR(x3765);
   double* x3787 = CTYPES_ADDR_OF_FATPTR(x3764);
   double* x3788 = CTYPES_ADDR_OF_FATPTR(x3763);
   int x3789 =
   LAPACKE_dgebrd(x3772, x3775, x3778, x3781, x3782, x3785, x3786, x3787,
                  x3788);
   return Val_long(x3789);
}
value owl_stub_64_LAPACKE_dgebrd_byte9(value* argv, int argc)
{
   value x3790 = argv[8];
   value x3791 = argv[7];
   value x3792 = argv[6];
   value x3793 = argv[5];
   value x3794 = argv[4];
   value x3795 = argv[3];
   value x3796 = argv[2];
   value x3797 = argv[1];
   value x3798 = argv[0];
   return
     owl_stub_64_LAPACKE_dgebrd(x3798, x3797, x3796, x3795, x3794, x3793,
                                x3792, x3791, x3790);
}
value owl_stub_65_LAPACKE_cgebrd(value x3807, value x3806, value x3805,
                                 value x3804, value x3803, value x3802,
                                 value x3801, value x3800, value x3799)
{
   int x3808 = Long_val(x3807);
   int x3811 = Long_val(x3806);
   int x3814 = Long_val(x3805);
   float _Complex* x3817 = CTYPES_ADDR_OF_FATPTR(x3804);
   int x3818 = Long_val(x3803);
   float* x3821 = CTYPES_ADDR_OF_FATPTR(x3802);
   float* x3822 = CTYPES_ADDR_OF_FATPTR(x3801);
   float _Complex* x3823 = CTYPES_ADDR_OF_FATPTR(x3800);
   float _Complex* x3824 = CTYPES_ADDR_OF_FATPTR(x3799);
   int x3825 =
   LAPACKE_cgebrd(x3808, x3811, x3814, x3817, x3818, x3821, x3822, x3823,
                  x3824);
   return Val_long(x3825);
}
value owl_stub_65_LAPACKE_cgebrd_byte9(value* argv, int argc)
{
   value x3826 = argv[8];
   value x3827 = argv[7];
   value x3828 = argv[6];
   value x3829 = argv[5];
   value x3830 = argv[4];
   value x3831 = argv[3];
   value x3832 = argv[2];
   value x3833 = argv[1];
   value x3834 = argv[0];
   return
     owl_stub_65_LAPACKE_cgebrd(x3834, x3833, x3832, x3831, x3830, x3829,
                                x3828, x3827, x3826);
}
value owl_stub_66_LAPACKE_zgebrd(value x3843, value x3842, value x3841,
                                 value x3840, value x3839, value x3838,
                                 value x3837, value x3836, value x3835)
{
   int x3844 = Long_val(x3843);
   int x3847 = Long_val(x3842);
   int x3850 = Long_val(x3841);
   double _Complex* x3853 = CTYPES_ADDR_OF_FATPTR(x3840);
   int x3854 = Long_val(x3839);
   double* x3857 = CTYPES_ADDR_OF_FATPTR(x3838);
   double* x3858 = CTYPES_ADDR_OF_FATPTR(x3837);
   double _Complex* x3859 = CTYPES_ADDR_OF_FATPTR(x3836);
   double _Complex* x3860 = CTYPES_ADDR_OF_FATPTR(x3835);
   int x3861 =
   LAPACKE_zgebrd(x3844, x3847, x3850, x3853, x3854, x3857, x3858, x3859,
                  x3860);
   return Val_long(x3861);
}
value owl_stub_66_LAPACKE_zgebrd_byte9(value* argv, int argc)
{
   value x3862 = argv[8];
   value x3863 = argv[7];
   value x3864 = argv[6];
   value x3865 = argv[5];
   value x3866 = argv[4];
   value x3867 = argv[3];
   value x3868 = argv[2];
   value x3869 = argv[1];
   value x3870 = argv[0];
   return
     owl_stub_66_LAPACKE_zgebrd(x3870, x3869, x3868, x3867, x3866, x3865,
                                x3864, x3863, x3862);
}
value owl_stub_67_LAPACKE_sgecon(value x3877, value x3876, value x3875,
                                 value x3874, value x3873, value x3872,
                                 value x3871)
{
   int x3878 = Long_val(x3877);
   int x3881 = Int_val(x3876);
   int x3884 = Long_val(x3875);
   float* x3887 = CTYPES_ADDR_OF_FATPTR(x3874);
   int x3888 = Long_val(x3873);
   double x3891 = Double_val(x3872);
   float* x3894 = CTYPES_ADDR_OF_FATPTR(x3871);
   int x3895 =
   LAPACKE_sgecon(x3878, (char)x3881, x3884, x3887, x3888, (float)x3891,
                  x3894);
   return Val_long(x3895);
}
value owl_stub_67_LAPACKE_sgecon_byte7(value* argv, int argc)
{
   value x3896 = argv[6];
   value x3897 = argv[5];
   value x3898 = argv[4];
   value x3899 = argv[3];
   value x3900 = argv[2];
   value x3901 = argv[1];
   value x3902 = argv[0];
   return
     owl_stub_67_LAPACKE_sgecon(x3902, x3901, x3900, x3899, x3898, x3897,
                                x3896);
}
value owl_stub_68_LAPACKE_dgecon(value x3909, value x3908, value x3907,
                                 value x3906, value x3905, value x3904,
                                 value x3903)
{
   int x3910 = Long_val(x3909);
   int x3913 = Int_val(x3908);
   int x3916 = Long_val(x3907);
   double* x3919 = CTYPES_ADDR_OF_FATPTR(x3906);
   int x3920 = Long_val(x3905);
   double x3923 = Double_val(x3904);
   double* x3926 = CTYPES_ADDR_OF_FATPTR(x3903);
   int x3927 =
   LAPACKE_dgecon(x3910, (char)x3913, x3916, x3919, x3920, x3923, x3926);
   return Val_long(x3927);
}
value owl_stub_68_LAPACKE_dgecon_byte7(value* argv, int argc)
{
   value x3928 = argv[6];
   value x3929 = argv[5];
   value x3930 = argv[4];
   value x3931 = argv[3];
   value x3932 = argv[2];
   value x3933 = argv[1];
   value x3934 = argv[0];
   return
     owl_stub_68_LAPACKE_dgecon(x3934, x3933, x3932, x3931, x3930, x3929,
                                x3928);
}
value owl_stub_69_LAPACKE_cgecon(value x3941, value x3940, value x3939,
                                 value x3938, value x3937, value x3936,
                                 value x3935)
{
   int x3942 = Long_val(x3941);
   int x3945 = Int_val(x3940);
   int x3948 = Long_val(x3939);
   float _Complex* x3951 = CTYPES_ADDR_OF_FATPTR(x3938);
   int x3952 = Long_val(x3937);
   double x3955 = Double_val(x3936);
   float* x3958 = CTYPES_ADDR_OF_FATPTR(x3935);
   int x3959 =
   LAPACKE_cgecon(x3942, (char)x3945, x3948, x3951, x3952, (float)x3955,
                  x3958);
   return Val_long(x3959);
}
value owl_stub_69_LAPACKE_cgecon_byte7(value* argv, int argc)
{
   value x3960 = argv[6];
   value x3961 = argv[5];
   value x3962 = argv[4];
   value x3963 = argv[3];
   value x3964 = argv[2];
   value x3965 = argv[1];
   value x3966 = argv[0];
   return
     owl_stub_69_LAPACKE_cgecon(x3966, x3965, x3964, x3963, x3962, x3961,
                                x3960);
}
value owl_stub_70_LAPACKE_zgecon(value x3973, value x3972, value x3971,
                                 value x3970, value x3969, value x3968,
                                 value x3967)
{
   int x3974 = Long_val(x3973);
   int x3977 = Int_val(x3972);
   int x3980 = Long_val(x3971);
   double _Complex* x3983 = CTYPES_ADDR_OF_FATPTR(x3970);
   int x3984 = Long_val(x3969);
   double x3987 = Double_val(x3968);
   double* x3990 = CTYPES_ADDR_OF_FATPTR(x3967);
   int x3991 =
   LAPACKE_zgecon(x3974, (char)x3977, x3980, x3983, x3984, x3987, x3990);
   return Val_long(x3991);
}
value owl_stub_70_LAPACKE_zgecon_byte7(value* argv, int argc)
{
   value x3992 = argv[6];
   value x3993 = argv[5];
   value x3994 = argv[4];
   value x3995 = argv[3];
   value x3996 = argv[2];
   value x3997 = argv[1];
   value x3998 = argv[0];
   return
     owl_stub_70_LAPACKE_zgecon(x3998, x3997, x3996, x3995, x3994, x3993,
                                x3992);
}
value owl_stub_71_LAPACKE_sgeequ(value x4008, value x4007, value x4006,
                                 value x4005, value x4004, value x4003,
                                 value x4002, value x4001, value x4000,
                                 value x3999)
{
   int x4009 = Long_val(x4008);
   int x4012 = Long_val(x4007);
   int x4015 = Long_val(x4006);
   float* x4018 = CTYPES_ADDR_OF_FATPTR(x4005);
   int x4019 = Long_val(x4004);
   float* x4022 = CTYPES_ADDR_OF_FATPTR(x4003);
   float* x4023 = CTYPES_ADDR_OF_FATPTR(x4002);
   float* x4024 = CTYPES_ADDR_OF_FATPTR(x4001);
   float* x4025 = CTYPES_ADDR_OF_FATPTR(x4000);
   float* x4026 = CTYPES_ADDR_OF_FATPTR(x3999);
   int x4027 =
   LAPACKE_sgeequ(x4009, x4012, x4015, x4018, x4019, x4022, x4023, x4024,
                  x4025, x4026);
   return Val_long(x4027);
}
value owl_stub_71_LAPACKE_sgeequ_byte10(value* argv, int argc)
{
   value x4028 = argv[9];
   value x4029 = argv[8];
   value x4030 = argv[7];
   value x4031 = argv[6];
   value x4032 = argv[5];
   value x4033 = argv[4];
   value x4034 = argv[3];
   value x4035 = argv[2];
   value x4036 = argv[1];
   value x4037 = argv[0];
   return
     owl_stub_71_LAPACKE_sgeequ(x4037, x4036, x4035, x4034, x4033, x4032,
                                x4031, x4030, x4029, x4028);
}
value owl_stub_72_LAPACKE_dgeequ(value x4047, value x4046, value x4045,
                                 value x4044, value x4043, value x4042,
                                 value x4041, value x4040, value x4039,
                                 value x4038)
{
   int x4048 = Long_val(x4047);
   int x4051 = Long_val(x4046);
   int x4054 = Long_val(x4045);
   double* x4057 = CTYPES_ADDR_OF_FATPTR(x4044);
   int x4058 = Long_val(x4043);
   double* x4061 = CTYPES_ADDR_OF_FATPTR(x4042);
   double* x4062 = CTYPES_ADDR_OF_FATPTR(x4041);
   double* x4063 = CTYPES_ADDR_OF_FATPTR(x4040);
   double* x4064 = CTYPES_ADDR_OF_FATPTR(x4039);
   double* x4065 = CTYPES_ADDR_OF_FATPTR(x4038);
   int x4066 =
   LAPACKE_dgeequ(x4048, x4051, x4054, x4057, x4058, x4061, x4062, x4063,
                  x4064, x4065);
   return Val_long(x4066);
}
value owl_stub_72_LAPACKE_dgeequ_byte10(value* argv, int argc)
{
   value x4067 = argv[9];
   value x4068 = argv[8];
   value x4069 = argv[7];
   value x4070 = argv[6];
   value x4071 = argv[5];
   value x4072 = argv[4];
   value x4073 = argv[3];
   value x4074 = argv[2];
   value x4075 = argv[1];
   value x4076 = argv[0];
   return
     owl_stub_72_LAPACKE_dgeequ(x4076, x4075, x4074, x4073, x4072, x4071,
                                x4070, x4069, x4068, x4067);
}
value owl_stub_73_LAPACKE_cgeequ(value x4086, value x4085, value x4084,
                                 value x4083, value x4082, value x4081,
                                 value x4080, value x4079, value x4078,
                                 value x4077)
{
   int x4087 = Long_val(x4086);
   int x4090 = Long_val(x4085);
   int x4093 = Long_val(x4084);
   float _Complex* x4096 = CTYPES_ADDR_OF_FATPTR(x4083);
   int x4097 = Long_val(x4082);
   float* x4100 = CTYPES_ADDR_OF_FATPTR(x4081);
   float* x4101 = CTYPES_ADDR_OF_FATPTR(x4080);
   float* x4102 = CTYPES_ADDR_OF_FATPTR(x4079);
   float* x4103 = CTYPES_ADDR_OF_FATPTR(x4078);
   float* x4104 = CTYPES_ADDR_OF_FATPTR(x4077);
   int x4105 =
   LAPACKE_cgeequ(x4087, x4090, x4093, x4096, x4097, x4100, x4101, x4102,
                  x4103, x4104);
   return Val_long(x4105);
}
value owl_stub_73_LAPACKE_cgeequ_byte10(value* argv, int argc)
{
   value x4106 = argv[9];
   value x4107 = argv[8];
   value x4108 = argv[7];
   value x4109 = argv[6];
   value x4110 = argv[5];
   value x4111 = argv[4];
   value x4112 = argv[3];
   value x4113 = argv[2];
   value x4114 = argv[1];
   value x4115 = argv[0];
   return
     owl_stub_73_LAPACKE_cgeequ(x4115, x4114, x4113, x4112, x4111, x4110,
                                x4109, x4108, x4107, x4106);
}
value owl_stub_74_LAPACKE_zgeequ(value x4125, value x4124, value x4123,
                                 value x4122, value x4121, value x4120,
                                 value x4119, value x4118, value x4117,
                                 value x4116)
{
   int x4126 = Long_val(x4125);
   int x4129 = Long_val(x4124);
   int x4132 = Long_val(x4123);
   double _Complex* x4135 = CTYPES_ADDR_OF_FATPTR(x4122);
   int x4136 = Long_val(x4121);
   double* x4139 = CTYPES_ADDR_OF_FATPTR(x4120);
   double* x4140 = CTYPES_ADDR_OF_FATPTR(x4119);
   double* x4141 = CTYPES_ADDR_OF_FATPTR(x4118);
   double* x4142 = CTYPES_ADDR_OF_FATPTR(x4117);
   double* x4143 = CTYPES_ADDR_OF_FATPTR(x4116);
   int x4144 =
   LAPACKE_zgeequ(x4126, x4129, x4132, x4135, x4136, x4139, x4140, x4141,
                  x4142, x4143);
   return Val_long(x4144);
}
value owl_stub_74_LAPACKE_zgeequ_byte10(value* argv, int argc)
{
   value x4145 = argv[9];
   value x4146 = argv[8];
   value x4147 = argv[7];
   value x4148 = argv[6];
   value x4149 = argv[5];
   value x4150 = argv[4];
   value x4151 = argv[3];
   value x4152 = argv[2];
   value x4153 = argv[1];
   value x4154 = argv[0];
   return
     owl_stub_74_LAPACKE_zgeequ(x4154, x4153, x4152, x4151, x4150, x4149,
                                x4148, x4147, x4146, x4145);
}
value owl_stub_75_LAPACKE_sgeequb(value x4164, value x4163, value x4162,
                                  value x4161, value x4160, value x4159,
                                  value x4158, value x4157, value x4156,
                                  value x4155)
{
   int x4165 = Long_val(x4164);
   int x4168 = Long_val(x4163);
   int x4171 = Long_val(x4162);
   float* x4174 = CTYPES_ADDR_OF_FATPTR(x4161);
   int x4175 = Long_val(x4160);
   float* x4178 = CTYPES_ADDR_OF_FATPTR(x4159);
   float* x4179 = CTYPES_ADDR_OF_FATPTR(x4158);
   float* x4180 = CTYPES_ADDR_OF_FATPTR(x4157);
   float* x4181 = CTYPES_ADDR_OF_FATPTR(x4156);
   float* x4182 = CTYPES_ADDR_OF_FATPTR(x4155);
   int x4183 =
   LAPACKE_sgeequb(x4165, x4168, x4171, x4174, x4175, x4178, x4179, x4180,
                   x4181, x4182);
   return Val_long(x4183);
}
value owl_stub_75_LAPACKE_sgeequb_byte10(value* argv, int argc)
{
   value x4184 = argv[9];
   value x4185 = argv[8];
   value x4186 = argv[7];
   value x4187 = argv[6];
   value x4188 = argv[5];
   value x4189 = argv[4];
   value x4190 = argv[3];
   value x4191 = argv[2];
   value x4192 = argv[1];
   value x4193 = argv[0];
   return
     owl_stub_75_LAPACKE_sgeequb(x4193, x4192, x4191, x4190, x4189, x4188,
                                 x4187, x4186, x4185, x4184);
}
value owl_stub_76_LAPACKE_dgeequb(value x4203, value x4202, value x4201,
                                  value x4200, value x4199, value x4198,
                                  value x4197, value x4196, value x4195,
                                  value x4194)
{
   int x4204 = Long_val(x4203);
   int x4207 = Long_val(x4202);
   int x4210 = Long_val(x4201);
   double* x4213 = CTYPES_ADDR_OF_FATPTR(x4200);
   int x4214 = Long_val(x4199);
   double* x4217 = CTYPES_ADDR_OF_FATPTR(x4198);
   double* x4218 = CTYPES_ADDR_OF_FATPTR(x4197);
   double* x4219 = CTYPES_ADDR_OF_FATPTR(x4196);
   double* x4220 = CTYPES_ADDR_OF_FATPTR(x4195);
   double* x4221 = CTYPES_ADDR_OF_FATPTR(x4194);
   int x4222 =
   LAPACKE_dgeequb(x4204, x4207, x4210, x4213, x4214, x4217, x4218, x4219,
                   x4220, x4221);
   return Val_long(x4222);
}
value owl_stub_76_LAPACKE_dgeequb_byte10(value* argv, int argc)
{
   value x4223 = argv[9];
   value x4224 = argv[8];
   value x4225 = argv[7];
   value x4226 = argv[6];
   value x4227 = argv[5];
   value x4228 = argv[4];
   value x4229 = argv[3];
   value x4230 = argv[2];
   value x4231 = argv[1];
   value x4232 = argv[0];
   return
     owl_stub_76_LAPACKE_dgeequb(x4232, x4231, x4230, x4229, x4228, x4227,
                                 x4226, x4225, x4224, x4223);
}
value owl_stub_77_LAPACKE_cgeequb(value x4242, value x4241, value x4240,
                                  value x4239, value x4238, value x4237,
                                  value x4236, value x4235, value x4234,
                                  value x4233)
{
   int x4243 = Long_val(x4242);
   int x4246 = Long_val(x4241);
   int x4249 = Long_val(x4240);
   float _Complex* x4252 = CTYPES_ADDR_OF_FATPTR(x4239);
   int x4253 = Long_val(x4238);
   float* x4256 = CTYPES_ADDR_OF_FATPTR(x4237);
   float* x4257 = CTYPES_ADDR_OF_FATPTR(x4236);
   float* x4258 = CTYPES_ADDR_OF_FATPTR(x4235);
   float* x4259 = CTYPES_ADDR_OF_FATPTR(x4234);
   float* x4260 = CTYPES_ADDR_OF_FATPTR(x4233);
   int x4261 =
   LAPACKE_cgeequb(x4243, x4246, x4249, x4252, x4253, x4256, x4257, x4258,
                   x4259, x4260);
   return Val_long(x4261);
}
value owl_stub_77_LAPACKE_cgeequb_byte10(value* argv, int argc)
{
   value x4262 = argv[9];
   value x4263 = argv[8];
   value x4264 = argv[7];
   value x4265 = argv[6];
   value x4266 = argv[5];
   value x4267 = argv[4];
   value x4268 = argv[3];
   value x4269 = argv[2];
   value x4270 = argv[1];
   value x4271 = argv[0];
   return
     owl_stub_77_LAPACKE_cgeequb(x4271, x4270, x4269, x4268, x4267, x4266,
                                 x4265, x4264, x4263, x4262);
}
value owl_stub_78_LAPACKE_zgeequb(value x4281, value x4280, value x4279,
                                  value x4278, value x4277, value x4276,
                                  value x4275, value x4274, value x4273,
                                  value x4272)
{
   int x4282 = Long_val(x4281);
   int x4285 = Long_val(x4280);
   int x4288 = Long_val(x4279);
   double _Complex* x4291 = CTYPES_ADDR_OF_FATPTR(x4278);
   int x4292 = Long_val(x4277);
   double* x4295 = CTYPES_ADDR_OF_FATPTR(x4276);
   double* x4296 = CTYPES_ADDR_OF_FATPTR(x4275);
   double* x4297 = CTYPES_ADDR_OF_FATPTR(x4274);
   double* x4298 = CTYPES_ADDR_OF_FATPTR(x4273);
   double* x4299 = CTYPES_ADDR_OF_FATPTR(x4272);
   int x4300 =
   LAPACKE_zgeequb(x4282, x4285, x4288, x4291, x4292, x4295, x4296, x4297,
                   x4298, x4299);
   return Val_long(x4300);
}
value owl_stub_78_LAPACKE_zgeequb_byte10(value* argv, int argc)
{
   value x4301 = argv[9];
   value x4302 = argv[8];
   value x4303 = argv[7];
   value x4304 = argv[6];
   value x4305 = argv[5];
   value x4306 = argv[4];
   value x4307 = argv[3];
   value x4308 = argv[2];
   value x4309 = argv[1];
   value x4310 = argv[0];
   return
     owl_stub_78_LAPACKE_zgeequb(x4310, x4309, x4308, x4307, x4306, x4305,
                                 x4304, x4303, x4302, x4301);
}
value owl_stub_79_LAPACKE_sgees(value x4322, value x4321, value x4320,
                                value x4319, value x4318, value x4317,
                                value x4316, value x4315, value x4314,
                                value x4313, value x4312, value x4311)
{
   int x4323 = Long_val(x4322);
   int x4326 = Int_val(x4321);
   int x4329 = Int_val(x4320);
   void* x4332 = CTYPES_ADDR_OF_FATPTR(x4319);
   int x4333 = Long_val(x4318);
   float* x4336 = CTYPES_ADDR_OF_FATPTR(x4317);
   int x4337 = Long_val(x4316);
   int* x4340 = CTYPES_ADDR_OF_FATPTR(x4315);
   float* x4341 = CTYPES_ADDR_OF_FATPTR(x4314);
   float* x4342 = CTYPES_ADDR_OF_FATPTR(x4313);
   float* x4343 = CTYPES_ADDR_OF_FATPTR(x4312);
   int x4344 = Long_val(x4311);
   int x4347 =
   LAPACKE_sgees(x4323, (char)x4326, (char)x4329, x4332, x4333, x4336, 
                 x4337, x4340, x4341, x4342, x4343, x4344);
   return Val_long(x4347);
}
value owl_stub_79_LAPACKE_sgees_byte12(value* argv, int argc)
{
   value x4348 = argv[11];
   value x4349 = argv[10];
   value x4350 = argv[9];
   value x4351 = argv[8];
   value x4352 = argv[7];
   value x4353 = argv[6];
   value x4354 = argv[5];
   value x4355 = argv[4];
   value x4356 = argv[3];
   value x4357 = argv[2];
   value x4358 = argv[1];
   value x4359 = argv[0];
   return
     owl_stub_79_LAPACKE_sgees(x4359, x4358, x4357, x4356, x4355, x4354,
                               x4353, x4352, x4351, x4350, x4349, x4348);
}
value owl_stub_80_LAPACKE_dgees(value x4371, value x4370, value x4369,
                                value x4368, value x4367, value x4366,
                                value x4365, value x4364, value x4363,
                                value x4362, value x4361, value x4360)
{
   int x4372 = Long_val(x4371);
   int x4375 = Int_val(x4370);
   int x4378 = Int_val(x4369);
   void* x4381 = CTYPES_ADDR_OF_FATPTR(x4368);
   int x4382 = Long_val(x4367);
   double* x4385 = CTYPES_ADDR_OF_FATPTR(x4366);
   int x4386 = Long_val(x4365);
   int* x4389 = CTYPES_ADDR_OF_FATPTR(x4364);
   double* x4390 = CTYPES_ADDR_OF_FATPTR(x4363);
   double* x4391 = CTYPES_ADDR_OF_FATPTR(x4362);
   double* x4392 = CTYPES_ADDR_OF_FATPTR(x4361);
   int x4393 = Long_val(x4360);
   int x4396 =
   LAPACKE_dgees(x4372, (char)x4375, (char)x4378, x4381, x4382, x4385, 
                 x4386, x4389, x4390, x4391, x4392, x4393);
   return Val_long(x4396);
}
value owl_stub_80_LAPACKE_dgees_byte12(value* argv, int argc)
{
   value x4397 = argv[11];
   value x4398 = argv[10];
   value x4399 = argv[9];
   value x4400 = argv[8];
   value x4401 = argv[7];
   value x4402 = argv[6];
   value x4403 = argv[5];
   value x4404 = argv[4];
   value x4405 = argv[3];
   value x4406 = argv[2];
   value x4407 = argv[1];
   value x4408 = argv[0];
   return
     owl_stub_80_LAPACKE_dgees(x4408, x4407, x4406, x4405, x4404, x4403,
                               x4402, x4401, x4400, x4399, x4398, x4397);
}
value owl_stub_81_LAPACKE_cgees(value x4419, value x4418, value x4417,
                                value x4416, value x4415, value x4414,
                                value x4413, value x4412, value x4411,
                                value x4410, value x4409)
{
   int x4420 = Long_val(x4419);
   int x4423 = Int_val(x4418);
   int x4426 = Int_val(x4417);
   void* x4429 = CTYPES_ADDR_OF_FATPTR(x4416);
   int x4430 = Long_val(x4415);
   float _Complex* x4433 = CTYPES_ADDR_OF_FATPTR(x4414);
   int x4434 = Long_val(x4413);
   int* x4437 = CTYPES_ADDR_OF_FATPTR(x4412);
   float _Complex* x4438 = CTYPES_ADDR_OF_FATPTR(x4411);
   float _Complex* x4439 = CTYPES_ADDR_OF_FATPTR(x4410);
   int x4440 = Long_val(x4409);
   int x4443 =
   LAPACKE_cgees(x4420, (char)x4423, (char)x4426, x4429, x4430, x4433, 
                 x4434, x4437, x4438, x4439, x4440);
   return Val_long(x4443);
}
value owl_stub_81_LAPACKE_cgees_byte11(value* argv, int argc)
{
   value x4444 = argv[10];
   value x4445 = argv[9];
   value x4446 = argv[8];
   value x4447 = argv[7];
   value x4448 = argv[6];
   value x4449 = argv[5];
   value x4450 = argv[4];
   value x4451 = argv[3];
   value x4452 = argv[2];
   value x4453 = argv[1];
   value x4454 = argv[0];
   return
     owl_stub_81_LAPACKE_cgees(x4454, x4453, x4452, x4451, x4450, x4449,
                               x4448, x4447, x4446, x4445, x4444);
}
value owl_stub_82_LAPACKE_zgees(value x4465, value x4464, value x4463,
                                value x4462, value x4461, value x4460,
                                value x4459, value x4458, value x4457,
                                value x4456, value x4455)
{
   int x4466 = Long_val(x4465);
   int x4469 = Int_val(x4464);
   int x4472 = Int_val(x4463);
   void* x4475 = CTYPES_ADDR_OF_FATPTR(x4462);
   int x4476 = Long_val(x4461);
   double _Complex* x4479 = CTYPES_ADDR_OF_FATPTR(x4460);
   int x4480 = Long_val(x4459);
   int* x4483 = CTYPES_ADDR_OF_FATPTR(x4458);
   double _Complex* x4484 = CTYPES_ADDR_OF_FATPTR(x4457);
   double _Complex* x4485 = CTYPES_ADDR_OF_FATPTR(x4456);
   int x4486 = Long_val(x4455);
   int x4489 =
   LAPACKE_zgees(x4466, (char)x4469, (char)x4472, x4475, x4476, x4479, 
                 x4480, x4483, x4484, x4485, x4486);
   return Val_long(x4489);
}
value owl_stub_82_LAPACKE_zgees_byte11(value* argv, int argc)
{
   value x4490 = argv[10];
   value x4491 = argv[9];
   value x4492 = argv[8];
   value x4493 = argv[7];
   value x4494 = argv[6];
   value x4495 = argv[5];
   value x4496 = argv[4];
   value x4497 = argv[3];
   value x4498 = argv[2];
   value x4499 = argv[1];
   value x4500 = argv[0];
   return
     owl_stub_82_LAPACKE_zgees(x4500, x4499, x4498, x4497, x4496, x4495,
                               x4494, x4493, x4492, x4491, x4490);
}
value owl_stub_83_LAPACKE_sgeesx(value x4515, value x4514, value x4513,
                                 value x4512, value x4511, value x4510,
                                 value x4509, value x4508, value x4507,
                                 value x4506, value x4505, value x4504,
                                 value x4503, value x4502, value x4501)
{
   int x4516 = Long_val(x4515);
   int x4519 = Int_val(x4514);
   int x4522 = Int_val(x4513);
   void* x4525 = CTYPES_ADDR_OF_FATPTR(x4512);
   int x4526 = Int_val(x4511);
   int x4529 = Long_val(x4510);
   float* x4532 = CTYPES_ADDR_OF_FATPTR(x4509);
   int x4533 = Long_val(x4508);
   int* x4536 = CTYPES_ADDR_OF_FATPTR(x4507);
   float* x4537 = CTYPES_ADDR_OF_FATPTR(x4506);
   float* x4538 = CTYPES_ADDR_OF_FATPTR(x4505);
   float* x4539 = CTYPES_ADDR_OF_FATPTR(x4504);
   int x4540 = Long_val(x4503);
   float* x4543 = CTYPES_ADDR_OF_FATPTR(x4502);
   float* x4544 = CTYPES_ADDR_OF_FATPTR(x4501);
   int x4545 =
   LAPACKE_sgeesx(x4516, (char)x4519, (char)x4522, x4525, (char)x4526, 
                  x4529, x4532, x4533, x4536, x4537, x4538, x4539, x4540,
                  x4543, x4544);
   return Val_long(x4545);
}
value owl_stub_83_LAPACKE_sgeesx_byte15(value* argv, int argc)
{
   value x4546 = argv[14];
   value x4547 = argv[13];
   value x4548 = argv[12];
   value x4549 = argv[11];
   value x4550 = argv[10];
   value x4551 = argv[9];
   value x4552 = argv[8];
   value x4553 = argv[7];
   value x4554 = argv[6];
   value x4555 = argv[5];
   value x4556 = argv[4];
   value x4557 = argv[3];
   value x4558 = argv[2];
   value x4559 = argv[1];
   value x4560 = argv[0];
   return
     owl_stub_83_LAPACKE_sgeesx(x4560, x4559, x4558, x4557, x4556, x4555,
                                x4554, x4553, x4552, x4551, x4550, x4549,
                                x4548, x4547, x4546);
}
value owl_stub_84_LAPACKE_dgeesx(value x4575, value x4574, value x4573,
                                 value x4572, value x4571, value x4570,
                                 value x4569, value x4568, value x4567,
                                 value x4566, value x4565, value x4564,
                                 value x4563, value x4562, value x4561)
{
   int x4576 = Long_val(x4575);
   int x4579 = Int_val(x4574);
   int x4582 = Int_val(x4573);
   void* x4585 = CTYPES_ADDR_OF_FATPTR(x4572);
   int x4586 = Int_val(x4571);
   int x4589 = Long_val(x4570);
   double* x4592 = CTYPES_ADDR_OF_FATPTR(x4569);
   int x4593 = Long_val(x4568);
   int* x4596 = CTYPES_ADDR_OF_FATPTR(x4567);
   double* x4597 = CTYPES_ADDR_OF_FATPTR(x4566);
   double* x4598 = CTYPES_ADDR_OF_FATPTR(x4565);
   double* x4599 = CTYPES_ADDR_OF_FATPTR(x4564);
   int x4600 = Long_val(x4563);
   double* x4603 = CTYPES_ADDR_OF_FATPTR(x4562);
   double* x4604 = CTYPES_ADDR_OF_FATPTR(x4561);
   int x4605 =
   LAPACKE_dgeesx(x4576, (char)x4579, (char)x4582, x4585, (char)x4586, 
                  x4589, x4592, x4593, x4596, x4597, x4598, x4599, x4600,
                  x4603, x4604);
   return Val_long(x4605);
}
value owl_stub_84_LAPACKE_dgeesx_byte15(value* argv, int argc)
{
   value x4606 = argv[14];
   value x4607 = argv[13];
   value x4608 = argv[12];
   value x4609 = argv[11];
   value x4610 = argv[10];
   value x4611 = argv[9];
   value x4612 = argv[8];
   value x4613 = argv[7];
   value x4614 = argv[6];
   value x4615 = argv[5];
   value x4616 = argv[4];
   value x4617 = argv[3];
   value x4618 = argv[2];
   value x4619 = argv[1];
   value x4620 = argv[0];
   return
     owl_stub_84_LAPACKE_dgeesx(x4620, x4619, x4618, x4617, x4616, x4615,
                                x4614, x4613, x4612, x4611, x4610, x4609,
                                x4608, x4607, x4606);
}
value owl_stub_85_LAPACKE_cgeesx(value x4634, value x4633, value x4632,
                                 value x4631, value x4630, value x4629,
                                 value x4628, value x4627, value x4626,
                                 value x4625, value x4624, value x4623,
                                 value x4622, value x4621)
{
   int x4635 = Long_val(x4634);
   int x4638 = Int_val(x4633);
   int x4641 = Int_val(x4632);
   void* x4644 = CTYPES_ADDR_OF_FATPTR(x4631);
   int x4645 = Int_val(x4630);
   int x4648 = Long_val(x4629);
   float _Complex* x4651 = CTYPES_ADDR_OF_FATPTR(x4628);
   int x4652 = Long_val(x4627);
   int* x4655 = CTYPES_ADDR_OF_FATPTR(x4626);
   float _Complex* x4656 = CTYPES_ADDR_OF_FATPTR(x4625);
   float _Complex* x4657 = CTYPES_ADDR_OF_FATPTR(x4624);
   int x4658 = Long_val(x4623);
   float* x4661 = CTYPES_ADDR_OF_FATPTR(x4622);
   float* x4662 = CTYPES_ADDR_OF_FATPTR(x4621);
   int x4663 =
   LAPACKE_cgeesx(x4635, (char)x4638, (char)x4641, x4644, (char)x4645, 
                  x4648, x4651, x4652, x4655, x4656, x4657, x4658, x4661,
                  x4662);
   return Val_long(x4663);
}
value owl_stub_85_LAPACKE_cgeesx_byte14(value* argv, int argc)
{
   value x4664 = argv[13];
   value x4665 = argv[12];
   value x4666 = argv[11];
   value x4667 = argv[10];
   value x4668 = argv[9];
   value x4669 = argv[8];
   value x4670 = argv[7];
   value x4671 = argv[6];
   value x4672 = argv[5];
   value x4673 = argv[4];
   value x4674 = argv[3];
   value x4675 = argv[2];
   value x4676 = argv[1];
   value x4677 = argv[0];
   return
     owl_stub_85_LAPACKE_cgeesx(x4677, x4676, x4675, x4674, x4673, x4672,
                                x4671, x4670, x4669, x4668, x4667, x4666,
                                x4665, x4664);
}
value owl_stub_86_LAPACKE_zgeesx(value x4691, value x4690, value x4689,
                                 value x4688, value x4687, value x4686,
                                 value x4685, value x4684, value x4683,
                                 value x4682, value x4681, value x4680,
                                 value x4679, value x4678)
{
   int x4692 = Long_val(x4691);
   int x4695 = Int_val(x4690);
   int x4698 = Int_val(x4689);
   void* x4701 = CTYPES_ADDR_OF_FATPTR(x4688);
   int x4702 = Int_val(x4687);
   int x4705 = Long_val(x4686);
   double _Complex* x4708 = CTYPES_ADDR_OF_FATPTR(x4685);
   int x4709 = Long_val(x4684);
   int* x4712 = CTYPES_ADDR_OF_FATPTR(x4683);
   double _Complex* x4713 = CTYPES_ADDR_OF_FATPTR(x4682);
   double _Complex* x4714 = CTYPES_ADDR_OF_FATPTR(x4681);
   int x4715 = Long_val(x4680);
   double* x4718 = CTYPES_ADDR_OF_FATPTR(x4679);
   double* x4719 = CTYPES_ADDR_OF_FATPTR(x4678);
   int x4720 =
   LAPACKE_zgeesx(x4692, (char)x4695, (char)x4698, x4701, (char)x4702, 
                  x4705, x4708, x4709, x4712, x4713, x4714, x4715, x4718,
                  x4719);
   return Val_long(x4720);
}
value owl_stub_86_LAPACKE_zgeesx_byte14(value* argv, int argc)
{
   value x4721 = argv[13];
   value x4722 = argv[12];
   value x4723 = argv[11];
   value x4724 = argv[10];
   value x4725 = argv[9];
   value x4726 = argv[8];
   value x4727 = argv[7];
   value x4728 = argv[6];
   value x4729 = argv[5];
   value x4730 = argv[4];
   value x4731 = argv[3];
   value x4732 = argv[2];
   value x4733 = argv[1];
   value x4734 = argv[0];
   return
     owl_stub_86_LAPACKE_zgeesx(x4734, x4733, x4732, x4731, x4730, x4729,
                                x4728, x4727, x4726, x4725, x4724, x4723,
                                x4722, x4721);
}
value owl_stub_87_LAPACKE_sgeev(value x4746, value x4745, value x4744,
                                value x4743, value x4742, value x4741,
                                value x4740, value x4739, value x4738,
                                value x4737, value x4736, value x4735)
{
   int x4747 = Long_val(x4746);
   int x4750 = Int_val(x4745);
   int x4753 = Int_val(x4744);
   int x4756 = Long_val(x4743);
   float* x4759 = CTYPES_ADDR_OF_FATPTR(x4742);
   int x4760 = Long_val(x4741);
   float* x4763 = CTYPES_ADDR_OF_FATPTR(x4740);
   float* x4764 = CTYPES_ADDR_OF_FATPTR(x4739);
   float* x4765 = CTYPES_ADDR_OF_FATPTR(x4738);
   int x4766 = Long_val(x4737);
   float* x4769 = CTYPES_ADDR_OF_FATPTR(x4736);
   int x4770 = Long_val(x4735);
   int x4773 =
   LAPACKE_sgeev(x4747, (char)x4750, (char)x4753, x4756, x4759, x4760, 
                 x4763, x4764, x4765, x4766, x4769, x4770);
   return Val_long(x4773);
}
value owl_stub_87_LAPACKE_sgeev_byte12(value* argv, int argc)
{
   value x4774 = argv[11];
   value x4775 = argv[10];
   value x4776 = argv[9];
   value x4777 = argv[8];
   value x4778 = argv[7];
   value x4779 = argv[6];
   value x4780 = argv[5];
   value x4781 = argv[4];
   value x4782 = argv[3];
   value x4783 = argv[2];
   value x4784 = argv[1];
   value x4785 = argv[0];
   return
     owl_stub_87_LAPACKE_sgeev(x4785, x4784, x4783, x4782, x4781, x4780,
                               x4779, x4778, x4777, x4776, x4775, x4774);
}
value owl_stub_88_LAPACKE_dgeev(value x4797, value x4796, value x4795,
                                value x4794, value x4793, value x4792,
                                value x4791, value x4790, value x4789,
                                value x4788, value x4787, value x4786)
{
   int x4798 = Long_val(x4797);
   int x4801 = Int_val(x4796);
   int x4804 = Int_val(x4795);
   int x4807 = Long_val(x4794);
   double* x4810 = CTYPES_ADDR_OF_FATPTR(x4793);
   int x4811 = Long_val(x4792);
   double* x4814 = CTYPES_ADDR_OF_FATPTR(x4791);
   double* x4815 = CTYPES_ADDR_OF_FATPTR(x4790);
   double* x4816 = CTYPES_ADDR_OF_FATPTR(x4789);
   int x4817 = Long_val(x4788);
   double* x4820 = CTYPES_ADDR_OF_FATPTR(x4787);
   int x4821 = Long_val(x4786);
   int x4824 =
   LAPACKE_dgeev(x4798, (char)x4801, (char)x4804, x4807, x4810, x4811, 
                 x4814, x4815, x4816, x4817, x4820, x4821);
   return Val_long(x4824);
}
value owl_stub_88_LAPACKE_dgeev_byte12(value* argv, int argc)
{
   value x4825 = argv[11];
   value x4826 = argv[10];
   value x4827 = argv[9];
   value x4828 = argv[8];
   value x4829 = argv[7];
   value x4830 = argv[6];
   value x4831 = argv[5];
   value x4832 = argv[4];
   value x4833 = argv[3];
   value x4834 = argv[2];
   value x4835 = argv[1];
   value x4836 = argv[0];
   return
     owl_stub_88_LAPACKE_dgeev(x4836, x4835, x4834, x4833, x4832, x4831,
                               x4830, x4829, x4828, x4827, x4826, x4825);
}
value owl_stub_89_LAPACKE_cgeev(value x4847, value x4846, value x4845,
                                value x4844, value x4843, value x4842,
                                value x4841, value x4840, value x4839,
                                value x4838, value x4837)
{
   int x4848 = Long_val(x4847);
   int x4851 = Int_val(x4846);
   int x4854 = Int_val(x4845);
   int x4857 = Long_val(x4844);
   float _Complex* x4860 = CTYPES_ADDR_OF_FATPTR(x4843);
   int x4861 = Long_val(x4842);
   float _Complex* x4864 = CTYPES_ADDR_OF_FATPTR(x4841);
   float _Complex* x4865 = CTYPES_ADDR_OF_FATPTR(x4840);
   int x4866 = Long_val(x4839);
   float _Complex* x4869 = CTYPES_ADDR_OF_FATPTR(x4838);
   int x4870 = Long_val(x4837);
   int x4873 =
   LAPACKE_cgeev(x4848, (char)x4851, (char)x4854, x4857, x4860, x4861, 
                 x4864, x4865, x4866, x4869, x4870);
   return Val_long(x4873);
}
value owl_stub_89_LAPACKE_cgeev_byte11(value* argv, int argc)
{
   value x4874 = argv[10];
   value x4875 = argv[9];
   value x4876 = argv[8];
   value x4877 = argv[7];
   value x4878 = argv[6];
   value x4879 = argv[5];
   value x4880 = argv[4];
   value x4881 = argv[3];
   value x4882 = argv[2];
   value x4883 = argv[1];
   value x4884 = argv[0];
   return
     owl_stub_89_LAPACKE_cgeev(x4884, x4883, x4882, x4881, x4880, x4879,
                               x4878, x4877, x4876, x4875, x4874);
}
value owl_stub_90_LAPACKE_zgeev(value x4895, value x4894, value x4893,
                                value x4892, value x4891, value x4890,
                                value x4889, value x4888, value x4887,
                                value x4886, value x4885)
{
   int x4896 = Long_val(x4895);
   int x4899 = Int_val(x4894);
   int x4902 = Int_val(x4893);
   int x4905 = Long_val(x4892);
   double _Complex* x4908 = CTYPES_ADDR_OF_FATPTR(x4891);
   int x4909 = Long_val(x4890);
   double _Complex* x4912 = CTYPES_ADDR_OF_FATPTR(x4889);
   double _Complex* x4913 = CTYPES_ADDR_OF_FATPTR(x4888);
   int x4914 = Long_val(x4887);
   double _Complex* x4917 = CTYPES_ADDR_OF_FATPTR(x4886);
   int x4918 = Long_val(x4885);
   int x4921 =
   LAPACKE_zgeev(x4896, (char)x4899, (char)x4902, x4905, x4908, x4909, 
                 x4912, x4913, x4914, x4917, x4918);
   return Val_long(x4921);
}
value owl_stub_90_LAPACKE_zgeev_byte11(value* argv, int argc)
{
   value x4922 = argv[10];
   value x4923 = argv[9];
   value x4924 = argv[8];
   value x4925 = argv[7];
   value x4926 = argv[6];
   value x4927 = argv[5];
   value x4928 = argv[4];
   value x4929 = argv[3];
   value x4930 = argv[2];
   value x4931 = argv[1];
   value x4932 = argv[0];
   return
     owl_stub_90_LAPACKE_zgeev(x4932, x4931, x4930, x4929, x4928, x4927,
                               x4926, x4925, x4924, x4923, x4922);
}
value owl_stub_91_LAPACKE_sgeevx(value x4952, value x4951, value x4950,
                                 value x4949, value x4948, value x4947,
                                 value x4946, value x4945, value x4944,
                                 value x4943, value x4942, value x4941,
                                 value x4940, value x4939, value x4938,
                                 value x4937, value x4936, value x4935,
                                 value x4934, value x4933)
{
   int x4953 = Long_val(x4952);
   int x4956 = Int_val(x4951);
   int x4959 = Int_val(x4950);
   int x4962 = Int_val(x4949);
   int x4965 = Int_val(x4948);
   int x4968 = Long_val(x4947);
   float* x4971 = CTYPES_ADDR_OF_FATPTR(x4946);
   int x4972 = Long_val(x4945);
   float* x4975 = CTYPES_ADDR_OF_FATPTR(x4944);
   float* x4976 = CTYPES_ADDR_OF_FATPTR(x4943);
   float* x4977 = CTYPES_ADDR_OF_FATPTR(x4942);
   int x4978 = Long_val(x4941);
   float* x4981 = CTYPES_ADDR_OF_FATPTR(x4940);
   int x4982 = Long_val(x4939);
   int* x4985 = CTYPES_ADDR_OF_FATPTR(x4938);
   int* x4986 = CTYPES_ADDR_OF_FATPTR(x4937);
   float* x4987 = CTYPES_ADDR_OF_FATPTR(x4936);
   float* x4988 = CTYPES_ADDR_OF_FATPTR(x4935);
   float* x4989 = CTYPES_ADDR_OF_FATPTR(x4934);
   float* x4990 = CTYPES_ADDR_OF_FATPTR(x4933);
   int x4991 =
   LAPACKE_sgeevx(x4953, (char)x4956, (char)x4959, (char)x4962, (char)x4965,
                  x4968, x4971, x4972, x4975, x4976, x4977, x4978, x4981,
                  x4982, x4985, x4986, x4987, x4988, x4989, x4990);
   return Val_long(x4991);
}
value owl_stub_91_LAPACKE_sgeevx_byte20(value* argv, int argc)
{
   value x4992 = argv[19];
   value x4993 = argv[18];
   value x4994 = argv[17];
   value x4995 = argv[16];
   value x4996 = argv[15];
   value x4997 = argv[14];
   value x4998 = argv[13];
   value x4999 = argv[12];
   value x5000 = argv[11];
   value x5001 = argv[10];
   value x5002 = argv[9];
   value x5003 = argv[8];
   value x5004 = argv[7];
   value x5005 = argv[6];
   value x5006 = argv[5];
   value x5007 = argv[4];
   value x5008 = argv[3];
   value x5009 = argv[2];
   value x5010 = argv[1];
   value x5011 = argv[0];
   return
     owl_stub_91_LAPACKE_sgeevx(x5011, x5010, x5009, x5008, x5007, x5006,
                                x5005, x5004, x5003, x5002, x5001, x5000,
                                x4999, x4998, x4997, x4996, x4995, x4994,
                                x4993, x4992);
}
value owl_stub_92_LAPACKE_dgeevx(value x5031, value x5030, value x5029,
                                 value x5028, value x5027, value x5026,
                                 value x5025, value x5024, value x5023,
                                 value x5022, value x5021, value x5020,
                                 value x5019, value x5018, value x5017,
                                 value x5016, value x5015, value x5014,
                                 value x5013, value x5012)
{
   int x5032 = Long_val(x5031);
   int x5035 = Int_val(x5030);
   int x5038 = Int_val(x5029);
   int x5041 = Int_val(x5028);
   int x5044 = Int_val(x5027);
   int x5047 = Long_val(x5026);
   double* x5050 = CTYPES_ADDR_OF_FATPTR(x5025);
   int x5051 = Long_val(x5024);
   double* x5054 = CTYPES_ADDR_OF_FATPTR(x5023);
   double* x5055 = CTYPES_ADDR_OF_FATPTR(x5022);
   double* x5056 = CTYPES_ADDR_OF_FATPTR(x5021);
   int x5057 = Long_val(x5020);
   double* x5060 = CTYPES_ADDR_OF_FATPTR(x5019);
   int x5061 = Long_val(x5018);
   int* x5064 = CTYPES_ADDR_OF_FATPTR(x5017);
   int* x5065 = CTYPES_ADDR_OF_FATPTR(x5016);
   double* x5066 = CTYPES_ADDR_OF_FATPTR(x5015);
   double* x5067 = CTYPES_ADDR_OF_FATPTR(x5014);
   double* x5068 = CTYPES_ADDR_OF_FATPTR(x5013);
   double* x5069 = CTYPES_ADDR_OF_FATPTR(x5012);
   int x5070 =
   LAPACKE_dgeevx(x5032, (char)x5035, (char)x5038, (char)x5041, (char)x5044,
                  x5047, x5050, x5051, x5054, x5055, x5056, x5057, x5060,
                  x5061, x5064, x5065, x5066, x5067, x5068, x5069);
   return Val_long(x5070);
}
value owl_stub_92_LAPACKE_dgeevx_byte20(value* argv, int argc)
{
   value x5071 = argv[19];
   value x5072 = argv[18];
   value x5073 = argv[17];
   value x5074 = argv[16];
   value x5075 = argv[15];
   value x5076 = argv[14];
   value x5077 = argv[13];
   value x5078 = argv[12];
   value x5079 = argv[11];
   value x5080 = argv[10];
   value x5081 = argv[9];
   value x5082 = argv[8];
   value x5083 = argv[7];
   value x5084 = argv[6];
   value x5085 = argv[5];
   value x5086 = argv[4];
   value x5087 = argv[3];
   value x5088 = argv[2];
   value x5089 = argv[1];
   value x5090 = argv[0];
   return
     owl_stub_92_LAPACKE_dgeevx(x5090, x5089, x5088, x5087, x5086, x5085,
                                x5084, x5083, x5082, x5081, x5080, x5079,
                                x5078, x5077, x5076, x5075, x5074, x5073,
                                x5072, x5071);
}
value owl_stub_93_LAPACKE_cgeevx(value x5109, value x5108, value x5107,
                                 value x5106, value x5105, value x5104,
                                 value x5103, value x5102, value x5101,
                                 value x5100, value x5099, value x5098,
                                 value x5097, value x5096, value x5095,
                                 value x5094, value x5093, value x5092,
                                 value x5091)
{
   int x5110 = Long_val(x5109);
   int x5113 = Int_val(x5108);
   int x5116 = Int_val(x5107);
   int x5119 = Int_val(x5106);
   int x5122 = Int_val(x5105);
   int x5125 = Long_val(x5104);
   float _Complex* x5128 = CTYPES_ADDR_OF_FATPTR(x5103);
   int x5129 = Long_val(x5102);
   float _Complex* x5132 = CTYPES_ADDR_OF_FATPTR(x5101);
   float _Complex* x5133 = CTYPES_ADDR_OF_FATPTR(x5100);
   int x5134 = Long_val(x5099);
   float _Complex* x5137 = CTYPES_ADDR_OF_FATPTR(x5098);
   int x5138 = Long_val(x5097);
   int* x5141 = CTYPES_ADDR_OF_FATPTR(x5096);
   int* x5142 = CTYPES_ADDR_OF_FATPTR(x5095);
   float* x5143 = CTYPES_ADDR_OF_FATPTR(x5094);
   float* x5144 = CTYPES_ADDR_OF_FATPTR(x5093);
   float* x5145 = CTYPES_ADDR_OF_FATPTR(x5092);
   float* x5146 = CTYPES_ADDR_OF_FATPTR(x5091);
   int x5147 =
   LAPACKE_cgeevx(x5110, (char)x5113, (char)x5116, (char)x5119, (char)x5122,
                  x5125, x5128, x5129, x5132, x5133, x5134, x5137, x5138,
                  x5141, x5142, x5143, x5144, x5145, x5146);
   return Val_long(x5147);
}
value owl_stub_93_LAPACKE_cgeevx_byte19(value* argv, int argc)
{
   value x5148 = argv[18];
   value x5149 = argv[17];
   value x5150 = argv[16];
   value x5151 = argv[15];
   value x5152 = argv[14];
   value x5153 = argv[13];
   value x5154 = argv[12];
   value x5155 = argv[11];
   value x5156 = argv[10];
   value x5157 = argv[9];
   value x5158 = argv[8];
   value x5159 = argv[7];
   value x5160 = argv[6];
   value x5161 = argv[5];
   value x5162 = argv[4];
   value x5163 = argv[3];
   value x5164 = argv[2];
   value x5165 = argv[1];
   value x5166 = argv[0];
   return
     owl_stub_93_LAPACKE_cgeevx(x5166, x5165, x5164, x5163, x5162, x5161,
                                x5160, x5159, x5158, x5157, x5156, x5155,
                                x5154, x5153, x5152, x5151, x5150, x5149,
                                x5148);
}
value owl_stub_94_LAPACKE_zgeevx(value x5185, value x5184, value x5183,
                                 value x5182, value x5181, value x5180,
                                 value x5179, value x5178, value x5177,
                                 value x5176, value x5175, value x5174,
                                 value x5173, value x5172, value x5171,
                                 value x5170, value x5169, value x5168,
                                 value x5167)
{
   int x5186 = Long_val(x5185);
   int x5189 = Int_val(x5184);
   int x5192 = Int_val(x5183);
   int x5195 = Int_val(x5182);
   int x5198 = Int_val(x5181);
   int x5201 = Long_val(x5180);
   double _Complex* x5204 = CTYPES_ADDR_OF_FATPTR(x5179);
   int x5205 = Long_val(x5178);
   double _Complex* x5208 = CTYPES_ADDR_OF_FATPTR(x5177);
   double _Complex* x5209 = CTYPES_ADDR_OF_FATPTR(x5176);
   int x5210 = Long_val(x5175);
   double _Complex* x5213 = CTYPES_ADDR_OF_FATPTR(x5174);
   int x5214 = Long_val(x5173);
   int* x5217 = CTYPES_ADDR_OF_FATPTR(x5172);
   int* x5218 = CTYPES_ADDR_OF_FATPTR(x5171);
   double* x5219 = CTYPES_ADDR_OF_FATPTR(x5170);
   double* x5220 = CTYPES_ADDR_OF_FATPTR(x5169);
   double* x5221 = CTYPES_ADDR_OF_FATPTR(x5168);
   double* x5222 = CTYPES_ADDR_OF_FATPTR(x5167);
   int x5223 =
   LAPACKE_zgeevx(x5186, (char)x5189, (char)x5192, (char)x5195, (char)x5198,
                  x5201, x5204, x5205, x5208, x5209, x5210, x5213, x5214,
                  x5217, x5218, x5219, x5220, x5221, x5222);
   return Val_long(x5223);
}
value owl_stub_94_LAPACKE_zgeevx_byte19(value* argv, int argc)
{
   value x5224 = argv[18];
   value x5225 = argv[17];
   value x5226 = argv[16];
   value x5227 = argv[15];
   value x5228 = argv[14];
   value x5229 = argv[13];
   value x5230 = argv[12];
   value x5231 = argv[11];
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
     owl_stub_94_LAPACKE_zgeevx(x5242, x5241, x5240, x5239, x5238, x5237,
                                x5236, x5235, x5234, x5233, x5232, x5231,
                                x5230, x5229, x5228, x5227, x5226, x5225,
                                x5224);
}
value owl_stub_95_LAPACKE_sgehrd(value x5249, value x5248, value x5247,
                                 value x5246, value x5245, value x5244,
                                 value x5243)
{
   int x5250 = Long_val(x5249);
   int x5253 = Long_val(x5248);
   int x5256 = Long_val(x5247);
   int x5259 = Long_val(x5246);
   float* x5262 = CTYPES_ADDR_OF_FATPTR(x5245);
   int x5263 = Long_val(x5244);
   float* x5266 = CTYPES_ADDR_OF_FATPTR(x5243);
   int x5267 =
   LAPACKE_sgehrd(x5250, x5253, x5256, x5259, x5262, x5263, x5266);
   return Val_long(x5267);
}
value owl_stub_95_LAPACKE_sgehrd_byte7(value* argv, int argc)
{
   value x5268 = argv[6];
   value x5269 = argv[5];
   value x5270 = argv[4];
   value x5271 = argv[3];
   value x5272 = argv[2];
   value x5273 = argv[1];
   value x5274 = argv[0];
   return
     owl_stub_95_LAPACKE_sgehrd(x5274, x5273, x5272, x5271, x5270, x5269,
                                x5268);
}
value owl_stub_96_LAPACKE_dgehrd(value x5281, value x5280, value x5279,
                                 value x5278, value x5277, value x5276,
                                 value x5275)
{
   int x5282 = Long_val(x5281);
   int x5285 = Long_val(x5280);
   int x5288 = Long_val(x5279);
   int x5291 = Long_val(x5278);
   double* x5294 = CTYPES_ADDR_OF_FATPTR(x5277);
   int x5295 = Long_val(x5276);
   double* x5298 = CTYPES_ADDR_OF_FATPTR(x5275);
   int x5299 =
   LAPACKE_dgehrd(x5282, x5285, x5288, x5291, x5294, x5295, x5298);
   return Val_long(x5299);
}
value owl_stub_96_LAPACKE_dgehrd_byte7(value* argv, int argc)
{
   value x5300 = argv[6];
   value x5301 = argv[5];
   value x5302 = argv[4];
   value x5303 = argv[3];
   value x5304 = argv[2];
   value x5305 = argv[1];
   value x5306 = argv[0];
   return
     owl_stub_96_LAPACKE_dgehrd(x5306, x5305, x5304, x5303, x5302, x5301,
                                x5300);
}
value owl_stub_97_LAPACKE_cgehrd(value x5313, value x5312, value x5311,
                                 value x5310, value x5309, value x5308,
                                 value x5307)
{
   int x5314 = Long_val(x5313);
   int x5317 = Long_val(x5312);
   int x5320 = Long_val(x5311);
   int x5323 = Long_val(x5310);
   float _Complex* x5326 = CTYPES_ADDR_OF_FATPTR(x5309);
   int x5327 = Long_val(x5308);
   float _Complex* x5330 = CTYPES_ADDR_OF_FATPTR(x5307);
   int x5331 =
   LAPACKE_cgehrd(x5314, x5317, x5320, x5323, x5326, x5327, x5330);
   return Val_long(x5331);
}
value owl_stub_97_LAPACKE_cgehrd_byte7(value* argv, int argc)
{
   value x5332 = argv[6];
   value x5333 = argv[5];
   value x5334 = argv[4];
   value x5335 = argv[3];
   value x5336 = argv[2];
   value x5337 = argv[1];
   value x5338 = argv[0];
   return
     owl_stub_97_LAPACKE_cgehrd(x5338, x5337, x5336, x5335, x5334, x5333,
                                x5332);
}
value owl_stub_98_LAPACKE_zgehrd(value x5345, value x5344, value x5343,
                                 value x5342, value x5341, value x5340,
                                 value x5339)
{
   int x5346 = Long_val(x5345);
   int x5349 = Long_val(x5344);
   int x5352 = Long_val(x5343);
   int x5355 = Long_val(x5342);
   double _Complex* x5358 = CTYPES_ADDR_OF_FATPTR(x5341);
   int x5359 = Long_val(x5340);
   double _Complex* x5362 = CTYPES_ADDR_OF_FATPTR(x5339);
   int x5363 =
   LAPACKE_zgehrd(x5346, x5349, x5352, x5355, x5358, x5359, x5362);
   return Val_long(x5363);
}
value owl_stub_98_LAPACKE_zgehrd_byte7(value* argv, int argc)
{
   value x5364 = argv[6];
   value x5365 = argv[5];
   value x5366 = argv[4];
   value x5367 = argv[3];
   value x5368 = argv[2];
   value x5369 = argv[1];
   value x5370 = argv[0];
   return
     owl_stub_98_LAPACKE_zgehrd(x5370, x5369, x5368, x5367, x5366, x5365,
                                x5364);
}
value owl_stub_99_LAPACKE_sgejsv(value x5388, value x5387, value x5386,
                                 value x5385, value x5384, value x5383,
                                 value x5382, value x5381, value x5380,
                                 value x5379, value x5378, value x5377,
                                 value x5376, value x5375, value x5374,
                                 value x5373, value x5372, value x5371)
{
   int x5389 = Long_val(x5388);
   int x5392 = Int_val(x5387);
   int x5395 = Int_val(x5386);
   int x5398 = Int_val(x5385);
   int x5401 = Int_val(x5384);
   int x5404 = Int_val(x5383);
   int x5407 = Int_val(x5382);
   int x5410 = Long_val(x5381);
   int x5413 = Long_val(x5380);
   float* x5416 = CTYPES_ADDR_OF_FATPTR(x5379);
   int x5417 = Long_val(x5378);
   float* x5420 = CTYPES_ADDR_OF_FATPTR(x5377);
   float* x5421 = CTYPES_ADDR_OF_FATPTR(x5376);
   int x5422 = Long_val(x5375);
   float* x5425 = CTYPES_ADDR_OF_FATPTR(x5374);
   int x5426 = Long_val(x5373);
   float* x5429 = CTYPES_ADDR_OF_FATPTR(x5372);
   int* x5430 = CTYPES_ADDR_OF_FATPTR(x5371);
   int x5431 =
   LAPACKE_sgejsv(x5389, (char)x5392, (char)x5395, (char)x5398, (char)x5401,
                  (char)x5404, (char)x5407, x5410, x5413, x5416, x5417,
                  x5420, x5421, x5422, x5425, x5426, x5429, x5430);
   return Val_long(x5431);
}
value owl_stub_99_LAPACKE_sgejsv_byte18(value* argv, int argc)
{
   value x5432 = argv[17];
   value x5433 = argv[16];
   value x5434 = argv[15];
   value x5435 = argv[14];
   value x5436 = argv[13];
   value x5437 = argv[12];
   value x5438 = argv[11];
   value x5439 = argv[10];
   value x5440 = argv[9];
   value x5441 = argv[8];
   value x5442 = argv[7];
   value x5443 = argv[6];
   value x5444 = argv[5];
   value x5445 = argv[4];
   value x5446 = argv[3];
   value x5447 = argv[2];
   value x5448 = argv[1];
   value x5449 = argv[0];
   return
     owl_stub_99_LAPACKE_sgejsv(x5449, x5448, x5447, x5446, x5445, x5444,
                                x5443, x5442, x5441, x5440, x5439, x5438,
                                x5437, x5436, x5435, x5434, x5433, x5432);
}
value owl_stub_100_LAPACKE_dgejsv(value x5467, value x5466, value x5465,
                                  value x5464, value x5463, value x5462,
                                  value x5461, value x5460, value x5459,
                                  value x5458, value x5457, value x5456,
                                  value x5455, value x5454, value x5453,
                                  value x5452, value x5451, value x5450)
{
   int x5468 = Long_val(x5467);
   int x5471 = Int_val(x5466);
   int x5474 = Int_val(x5465);
   int x5477 = Int_val(x5464);
   int x5480 = Int_val(x5463);
   int x5483 = Int_val(x5462);
   int x5486 = Int_val(x5461);
   int x5489 = Long_val(x5460);
   int x5492 = Long_val(x5459);
   double* x5495 = CTYPES_ADDR_OF_FATPTR(x5458);
   int x5496 = Long_val(x5457);
   double* x5499 = CTYPES_ADDR_OF_FATPTR(x5456);
   double* x5500 = CTYPES_ADDR_OF_FATPTR(x5455);
   int x5501 = Long_val(x5454);
   double* x5504 = CTYPES_ADDR_OF_FATPTR(x5453);
   int x5505 = Long_val(x5452);
   double* x5508 = CTYPES_ADDR_OF_FATPTR(x5451);
   int* x5509 = CTYPES_ADDR_OF_FATPTR(x5450);
   int x5510 =
   LAPACKE_dgejsv(x5468, (char)x5471, (char)x5474, (char)x5477, (char)x5480,
                  (char)x5483, (char)x5486, x5489, x5492, x5495, x5496,
                  x5499, x5500, x5501, x5504, x5505, x5508, x5509);
   return Val_long(x5510);
}
value owl_stub_100_LAPACKE_dgejsv_byte18(value* argv, int argc)
{
   value x5511 = argv[17];
   value x5512 = argv[16];
   value x5513 = argv[15];
   value x5514 = argv[14];
   value x5515 = argv[13];
   value x5516 = argv[12];
   value x5517 = argv[11];
   value x5518 = argv[10];
   value x5519 = argv[9];
   value x5520 = argv[8];
   value x5521 = argv[7];
   value x5522 = argv[6];
   value x5523 = argv[5];
   value x5524 = argv[4];
   value x5525 = argv[3];
   value x5526 = argv[2];
   value x5527 = argv[1];
   value x5528 = argv[0];
   return
     owl_stub_100_LAPACKE_dgejsv(x5528, x5527, x5526, x5525, x5524, x5523,
                                 x5522, x5521, x5520, x5519, x5518, x5517,
                                 x5516, x5515, x5514, x5513, x5512, x5511);
}
