module CI = Cstubs_internals

external owl_stub_1_cblas_srotg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_1_cblas_srotg" 

external owl_stub_2_cblas_drotg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_2_cblas_drotg" 

external owl_stub_3_cblas_srotmg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> unit
  = "owl_stub_3_cblas_srotmg" 

external owl_stub_4_cblas_drotmg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> unit
  = "owl_stub_4_cblas_drotmg" 

external owl_stub_5_cblas_srot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> unit
  = "owl_stub_5_cblas_srot_byte7" "owl_stub_5_cblas_srot" 

external owl_stub_6_cblas_drot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> unit
  = "owl_stub_6_cblas_drot_byte7" "owl_stub_6_cblas_drot" 

external owl_stub_7_cblas_sswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_7_cblas_sswap" 

external owl_stub_8_cblas_dswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_8_cblas_dswap" 

external owl_stub_9_cblas_cswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_9_cblas_cswap" 

external owl_stub_10_cblas_zswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_10_cblas_zswap" 

external owl_stub_11_cblas_sscal : int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_11_cblas_sscal" 

external owl_stub_12_cblas_dscal : int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_12_cblas_dscal" 

external owl_stub_13_cblas_cscal
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_13_cblas_cscal" 

external owl_stub_14_cblas_zscal
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_14_cblas_zscal" 

external owl_stub_15_cblas_csscal
  : int -> float -> _ CI.fatptr -> int -> unit = "owl_stub_15_cblas_csscal" 

external owl_stub_16_cblas_zdscal
  : int -> float -> _ CI.fatptr -> int -> unit = "owl_stub_16_cblas_zdscal" 

external owl_stub_17_cblas_scopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_17_cblas_scopy" 

external owl_stub_18_cblas_dcopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_18_cblas_dcopy" 

external owl_stub_19_cblas_ccopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_19_cblas_ccopy" 

external owl_stub_20_cblas_zcopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_20_cblas_zcopy" 

external owl_stub_21_cblas_saxpy
  : int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_21_cblas_saxpy_byte6" "owl_stub_21_cblas_saxpy" 

external owl_stub_22_cblas_daxpy
  : int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_22_cblas_daxpy_byte6" "owl_stub_22_cblas_daxpy" 

external owl_stub_23_cblas_caxpy
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_23_cblas_caxpy_byte6" "owl_stub_23_cblas_caxpy" 

external owl_stub_24_cblas_zaxpy
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_24_cblas_zaxpy_byte6" "owl_stub_24_cblas_zaxpy" 

external owl_stub_25_cblas_sdot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "owl_stub_25_cblas_sdot" 

external owl_stub_26_cblas_ddot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "owl_stub_26_cblas_ddot" 

external owl_stub_27_cblas_sdsdot
  : int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "owl_stub_27_cblas_sdsdot_byte6" "owl_stub_27_cblas_sdsdot" 

external owl_stub_28_cblas_dsdot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "owl_stub_28_cblas_dsdot" 

external owl_stub_29_cblas_cdotu_sub
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_29_cblas_cdotu_sub_byte6" "owl_stub_29_cblas_cdotu_sub" 

external owl_stub_30_cblas_cdotc_sub
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_30_cblas_cdotc_sub_byte6" "owl_stub_30_cblas_cdotc_sub" 

external owl_stub_31_cblas_zdotu_sub
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_31_cblas_zdotu_sub_byte6" "owl_stub_31_cblas_zdotu_sub" 

external owl_stub_32_cblas_zdotc_sub
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_32_cblas_zdotc_sub_byte6" "owl_stub_32_cblas_zdotc_sub" 

external owl_stub_33_cblas_snrm2 : int -> _ CI.fatptr -> int -> float
  = "owl_stub_33_cblas_snrm2" 

external owl_stub_34_cblas_dnrm2 : int -> _ CI.fatptr -> int -> float
  = "owl_stub_34_cblas_dnrm2" 

external owl_stub_35_cblas_scnrm2 : int -> _ CI.fatptr -> int -> float
  = "owl_stub_35_cblas_scnrm2" 

external owl_stub_36_cblas_dznrm2 : int -> _ CI.fatptr -> int -> float
  = "owl_stub_36_cblas_dznrm2" 

external owl_stub_37_cblas_sasum : int -> _ CI.fatptr -> int -> float
  = "owl_stub_37_cblas_sasum" 

external owl_stub_38_cblas_dasum : int -> _ CI.fatptr -> int -> float
  = "owl_stub_38_cblas_dasum" 

external owl_stub_39_cblas_scasum : int -> _ CI.fatptr -> int -> float
  = "owl_stub_39_cblas_scasum" 

external owl_stub_40_cblas_dzasum : int -> _ CI.fatptr -> int -> float
  = "owl_stub_40_cblas_dzasum" 

external owl_stub_41_cblas_isamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t = "owl_stub_41_cblas_isamax" 

external owl_stub_42_cblas_idamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t = "owl_stub_42_cblas_idamax" 

external owl_stub_43_cblas_icamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t = "owl_stub_43_cblas_icamax" 

external owl_stub_44_cblas_izamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t = "owl_stub_44_cblas_izamax" 

external owl_stub_45_cblas_sgemv
  : int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_45_cblas_sgemv_byte12" "owl_stub_45_cblas_sgemv" 

external owl_stub_46_cblas_dgemv
  : int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_46_cblas_dgemv_byte12" "owl_stub_46_cblas_dgemv" 

external owl_stub_47_cblas_cgemv
  : int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_47_cblas_cgemv_byte12" "owl_stub_47_cblas_cgemv" 

external owl_stub_48_cblas_zgemv
  : int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_48_cblas_zgemv_byte12" "owl_stub_48_cblas_zgemv" 

type 'a result = 'a
type 'a return = 'a
type 'a fn =
 | Returns  : 'a CI.typ   -> 'a return fn
 | Function : 'a CI.typ * 'b fn  -> ('a -> 'b) fn
let map_result f x = f x
let returning t = Returns t
let (@->) f p = Function (f, p)
let foreign : type a b. string -> (a -> b) fn -> (a -> b) =
  fun name t -> match t, name with
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x6,
                 Function
                   (CI.Pointer x8,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x11,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x14,
                                Function
                                  (CI.Pointer x16,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_zgemv" ->
  (fun x1 x2 x3 x4 x5 x7 x9 x10 x12 x13 x15 x17 ->
    owl_stub_48_cblas_zgemv x1 x2 x3 x4 (CI.cptr x5) (CI.cptr x7) x9
    (CI.cptr x10) x12 (CI.cptr x13) (CI.cptr x15) x17)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x23,
                 Function
                   (CI.Pointer x25,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x28,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x31,
                                Function
                                  (CI.Pointer x33,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_cgemv" ->
  (fun x18 x19 x20 x21 x22 x24 x26 x27 x29 x30 x32 x34 ->
    owl_stub_47_cblas_cgemv x18 x19 x20 x21 (CI.cptr x22) (CI.cptr x24) x26
    (CI.cptr x27) x29 (CI.cptr x30) (CI.cptr x32) x34)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Double,
                 Function
                   (CI.Pointer x41,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x44,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Double,
                                Function
                                  (CI.Pointer x48,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dgemv" ->
  (fun x35 x36 x37 x38 x39 x40 x42 x43 x45 x46 x47 x49 ->
    owl_stub_46_cblas_dgemv x35 x36 x37 x38 x39 (CI.cptr x40) x42
    (CI.cptr x43) x45 x46 (CI.cptr x47) x49)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Float,
                 Function
                   (CI.Pointer x56,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x59,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Float,
                                Function
                                  (CI.Pointer x63,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_sgemv" ->
  (fun x50 x51 x52 x53 x54 x55 x57 x58 x60 x61 x62 x64 ->
    owl_stub_45_cblas_sgemv x50 x51 x52 x53 x54 (CI.cptr x55) x57
    (CI.cptr x58) x60 x61 (CI.cptr x62) x64)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x67,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_izamax" ->
  (fun x65 x66 x68 -> owl_stub_44_cblas_izamax x65 (CI.cptr x66) x68)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x71,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_icamax" ->
  (fun x69 x70 x72 -> owl_stub_43_cblas_icamax x69 (CI.cptr x70) x72)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x75,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_idamax" ->
  (fun x73 x74 x76 -> owl_stub_42_cblas_idamax x73 (CI.cptr x74) x76)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x79,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_isamax" ->
  (fun x77 x78 x80 -> owl_stub_41_cblas_isamax x77 (CI.cptr x78) x80)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x83,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dzasum" ->
  (fun x81 x82 x84 -> owl_stub_40_cblas_dzasum x81 (CI.cptr x82) x84)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x87,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_scasum" ->
  (fun x85 x86 x88 -> owl_stub_39_cblas_scasum x85 (CI.cptr x86) x88)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x91,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dasum" ->
  (fun x89 x90 x92 -> owl_stub_38_cblas_dasum x89 (CI.cptr x90) x92)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x95,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_sasum" ->
  (fun x93 x94 x96 -> owl_stub_37_cblas_sasum x93 (CI.cptr x94) x96)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x99,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dznrm2" ->
  (fun x97 x98 x100 -> owl_stub_36_cblas_dznrm2 x97 (CI.cptr x98) x100)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x103,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_scnrm2" ->
  (fun x101 x102 x104 -> owl_stub_35_cblas_scnrm2 x101 (CI.cptr x102) x104)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x107,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dnrm2" ->
  (fun x105 x106 x108 -> owl_stub_34_cblas_dnrm2 x105 (CI.cptr x106) x108)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x111,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_snrm2" ->
  (fun x109 x110 x112 -> owl_stub_33_cblas_snrm2 x109 (CI.cptr x110) x112)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x115,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x118,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x121, Returns CI.Void)))))),
  "cblas_zdotc_sub" ->
  (fun x113 x114 x116 x117 x119 x120 ->
    owl_stub_32_cblas_zdotc_sub x113 (CI.cptr x114) x116 (CI.cptr x117) x119
    (CI.cptr x120))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x124,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x127,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x130, Returns CI.Void)))))),
  "cblas_zdotu_sub" ->
  (fun x122 x123 x125 x126 x128 x129 ->
    owl_stub_31_cblas_zdotu_sub x122 (CI.cptr x123) x125 (CI.cptr x126) x128
    (CI.cptr x129))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x133,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x136,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x139, Returns CI.Void)))))),
  "cblas_cdotc_sub" ->
  (fun x131 x132 x134 x135 x137 x138 ->
    owl_stub_30_cblas_cdotc_sub x131 (CI.cptr x132) x134 (CI.cptr x135) x137
    (CI.cptr x138))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x142,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x145,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x148, Returns CI.Void)))))),
  "cblas_cdotu_sub" ->
  (fun x140 x141 x143 x144 x146 x147 ->
    owl_stub_29_cblas_cdotu_sub x140 (CI.cptr x141) x143 (CI.cptr x144) x146
    (CI.cptr x147))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x151,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x154,
              Function
                (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))))),
  "cblas_dsdot" ->
  (fun x149 x150 x152 x153 x155 ->
    owl_stub_28_cblas_dsdot x149 (CI.cptr x150) x152 (CI.cptr x153) x155)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x159,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x162,
                 Function
                   (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float))))))),
  "cblas_sdsdot" ->
  (fun x156 x157 x158 x160 x161 x163 ->
    owl_stub_27_cblas_sdsdot x156 x157 (CI.cptr x158) x160 (CI.cptr x161)
    x163)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x166,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x169,
              Function
                (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))))),
  "cblas_ddot" ->
  (fun x164 x165 x167 x168 x170 ->
    owl_stub_26_cblas_ddot x164 (CI.cptr x165) x167 (CI.cptr x168) x170)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x173,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x176,
              Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))))),
  "cblas_sdot" ->
  (fun x171 x172 x174 x175 x177 ->
    owl_stub_25_cblas_sdot x171 (CI.cptr x172) x174 (CI.cptr x175) x177)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x180,
        Function
          (CI.Pointer x182,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x185,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_zaxpy" ->
  (fun x178 x179 x181 x183 x184 x186 ->
    owl_stub_24_cblas_zaxpy x178 (CI.cptr x179) (CI.cptr x181) x183
    (CI.cptr x184) x186)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x189,
        Function
          (CI.Pointer x191,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x194,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_caxpy" ->
  (fun x187 x188 x190 x192 x193 x195 ->
    owl_stub_23_cblas_caxpy x187 (CI.cptr x188) (CI.cptr x190) x192
    (CI.cptr x193) x195)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x199,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x202,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_daxpy" ->
  (fun x196 x197 x198 x200 x201 x203 ->
    owl_stub_22_cblas_daxpy x196 x197 (CI.cptr x198) x200 (CI.cptr x201) x203)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x207,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x210,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_saxpy" ->
  (fun x204 x205 x206 x208 x209 x211 ->
    owl_stub_21_cblas_saxpy x204 x205 (CI.cptr x206) x208 (CI.cptr x209) x211)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x214,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x217,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zcopy" ->
  (fun x212 x213 x215 x216 x218 ->
    owl_stub_20_cblas_zcopy x212 (CI.cptr x213) x215 (CI.cptr x216) x218)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x221,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x224,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_ccopy" ->
  (fun x219 x220 x222 x223 x225 ->
    owl_stub_19_cblas_ccopy x219 (CI.cptr x220) x222 (CI.cptr x223) x225)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x228,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x231,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dcopy" ->
  (fun x226 x227 x229 x230 x232 ->
    owl_stub_18_cblas_dcopy x226 (CI.cptr x227) x229 (CI.cptr x230) x232)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x235,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x238,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_scopy" ->
  (fun x233 x234 x236 x237 x239 ->
    owl_stub_17_cblas_scopy x233 (CI.cptr x234) x236 (CI.cptr x237) x239)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x243, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_zdscal" ->
  (fun x240 x241 x242 x244 ->
    owl_stub_16_cblas_zdscal x240 x241 (CI.cptr x242) x244)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x248, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_csscal" ->
  (fun x245 x246 x247 x249 ->
    owl_stub_15_cblas_csscal x245 x246 (CI.cptr x247) x249)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x252,
        Function
          (CI.Pointer x254, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_zscal" ->
  (fun x250 x251 x253 x255 ->
    owl_stub_14_cblas_zscal x250 (CI.cptr x251) (CI.cptr x253) x255)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x258,
        Function
          (CI.Pointer x260, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_cscal" ->
  (fun x256 x257 x259 x261 ->
    owl_stub_13_cblas_cscal x256 (CI.cptr x257) (CI.cptr x259) x261)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x265, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_dscal" ->
  (fun x262 x263 x264 x266 ->
    owl_stub_12_cblas_dscal x262 x263 (CI.cptr x264) x266)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x270, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_sscal" ->
  (fun x267 x268 x269 x271 ->
    owl_stub_11_cblas_sscal x267 x268 (CI.cptr x269) x271)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x274,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x277,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zswap" ->
  (fun x272 x273 x275 x276 x278 ->
    owl_stub_10_cblas_zswap x272 (CI.cptr x273) x275 (CI.cptr x276) x278)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x281,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x284,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_cswap" ->
  (fun x279 x280 x282 x283 x285 ->
    owl_stub_9_cblas_cswap x279 (CI.cptr x280) x282 (CI.cptr x283) x285)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x288,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x291,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dswap" ->
  (fun x286 x287 x289 x290 x292 ->
    owl_stub_8_cblas_dswap x286 (CI.cptr x287) x289 (CI.cptr x290) x292)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x295,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x298,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_sswap" ->
  (fun x293 x294 x296 x297 x299 ->
    owl_stub_7_cblas_sswap x293 (CI.cptr x294) x296 (CI.cptr x297) x299)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x302,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x305,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Double,
                    Function (CI.Primitive CI.Double, Returns CI.Void))))))),
  "cblas_drot" ->
  (fun x300 x301 x303 x304 x306 x307 x308 ->
    owl_stub_6_cblas_drot x300 (CI.cptr x301) x303 (CI.cptr x304) x306 x307
    x308)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x311,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x314,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Float,
                    Function (CI.Primitive CI.Float, Returns CI.Void))))))),
  "cblas_srot" ->
  (fun x309 x310 x312 x313 x315 x316 x317 ->
    owl_stub_5_cblas_srot x309 (CI.cptr x310) x312 (CI.cptr x313) x315 x316
    x317)
| Function
    (CI.Pointer x319,
     Function
       (CI.Pointer x321,
        Function
          (CI.Pointer x323,
           Function
             (CI.Primitive CI.Double,
              Function (CI.Pointer x326, Returns CI.Void))))),
  "cblas_drotmg" ->
  (fun x318 x320 x322 x324 x325 ->
    owl_stub_4_cblas_drotmg (CI.cptr x318) (CI.cptr x320) (CI.cptr x322) x324
    (CI.cptr x325))
| Function
    (CI.Pointer x328,
     Function
       (CI.Pointer x330,
        Function
          (CI.Pointer x332,
           Function
             (CI.Primitive CI.Float,
              Function (CI.Pointer x335, Returns CI.Void))))),
  "cblas_srotmg" ->
  (fun x327 x329 x331 x333 x334 ->
    owl_stub_3_cblas_srotmg (CI.cptr x327) (CI.cptr x329) (CI.cptr x331) x333
    (CI.cptr x334))
| Function
    (CI.Pointer x337,
     Function
       (CI.Pointer x339,
        Function
          (CI.Pointer x341, Function (CI.Pointer x343, Returns CI.Void)))),
  "cblas_drotg" ->
  (fun x336 x338 x340 x342 ->
    owl_stub_2_cblas_drotg (CI.cptr x336) (CI.cptr x338) (CI.cptr x340)
    (CI.cptr x342))
| Function
    (CI.Pointer x345,
     Function
       (CI.Pointer x347,
        Function
          (CI.Pointer x349, Function (CI.Pointer x351, Returns CI.Void)))),
  "cblas_srotg" ->
  (fun x344 x346 x348 x350 ->
    owl_stub_1_cblas_srotg (CI.cptr x344) (CI.cptr x346) (CI.cptr x348)
    (CI.cptr x350))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

