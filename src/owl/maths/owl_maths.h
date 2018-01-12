/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_MATHS_H
#define OWL_MATHS_H

#ifdef __cplusplus
extern "C" {
#endif

#include <math.h>
#include <assert.h>

#include "owl_cephes.h"

#define OWL_POSINF INFINITY
#define OWL_NEGINF -INFINITY
#define OWL_NAN NAN


/* Useful constants */

#define OWL_E         2.718281828459045235360287471352662498  /* e */
#define OWL_LOG2E     1.442695040888963407359924681001892137  /* log_2 e */
#define OWL_LOG10E    0.434294481903251827651128918916605082  /* log_10 e */
#define OWL_LOGE2     0.693147180559945309417232121458176568  /* log_e 2 */
#define OWL_LOGE10    2.302585092994045684017991454684364208  /* log_e 10 */
#define OWL_LOGEPI    1.144729885849400174143427351353058711  /* log_e pi */
#define OWL_PI        3.141592653589793238462643383279502884  /* pi */
#define OWL_2PI       6.283185307179586476925286766559005768  /* 2*pi */
#define OWL_4PI       12.56637061435917295385057353311801153  /* 4*pi */
#define OWL_PI_2      1.570796326794896619231321691639751442  /* pi/2 */
#define OWL_PI_4      0.785398163397448309615660845819875721  /* pi/4 */
#define OWL_1_PI      0.318309886183790671537767526745028724  /* 1/pi */
#define OWL_2_PI      0.636619772367581343075535053490057448  /* 2/pi */
#define OWL_EULER     0.577215664901532860606512090082402431  /* Euler constant */
#define OWL_SQRT2     1.414213562373095048801688724209698079  /* sqrt(2) */
#define OWL_SQRT1_2   0.707106781186547524400844362104849039  /* 1/sqrt(2) */

#define OWL_Ef        2.718281828459045235360287471352662498F /* e */
#define OWL_LOG2Ef    1.442695040888963407359924681001892137F /* log_2 e */
#define OWL_LOG10Ef   0.434294481903251827651128918916605082F /* log_10 e */
#define OWL_LOGE2f    0.693147180559945309417232121458176568F /* log_e 2 */
#define OWL_LOGE10f   2.302585092994045684017991454684364208F /* log_e 10 */
#define OWL_LOGEPIf   1.144729885849400174143427351353058711F /* log_e pi */
#define OWL_PIf       3.141592653589793238462643383279502884F /* pi */
#define OWL_2PIf      6.283185307179586476925286766559005768F /* 2*pi */
#define OWL_4PIf      12.56637061435917295385057353311801153F /* 4*pi */
#define OWL_PI_2f     1.570796326794896619231321691639751442F /* pi/2 */
#define OWL_PI_4f     0.785398163397448309615660845819875721F /* pi/4 */
#define OWL_1_PIf     0.318309886183790671537767526745028724F /* 1/pi */
#define OWL_2_PIf     0.636619772367581343075535053490057448F /* 2/pi */
#define OWL_EULERf    0.577215664901532860606512090082402431F /* Euler constant */
#define OWL_SQRT2f    1.414213562373095048801688724209698079F /* sqrt(2) */
#define OWL_SQRT1_2f  0.707106781186547524400844362104849039F /* 1/sqrt(2) */

#define OWL_El        2.718281828459045235360287471352662498L /* e */
#define OWL_LOG2El    1.442695040888963407359924681001892137L /* log_2 e */
#define OWL_LOG10El   0.434294481903251827651128918916605082L /* log_10 e */
#define OWL_LOGE2l    0.693147180559945309417232121458176568L /* log_e 2 */
#define OWL_LOGE10l   2.302585092994045684017991454684364208L /* log_e 10 */
#define OWL_LOGEPIl   1.144729885849400174143427351353058711L /* log_e pi */
#define OWL_PIl       3.141592653589793238462643383279502884L /* pi */
#define OWL_2PIl      6.283185307179586476925286766559005768L /* 2*pi */
#define OWL_4PIl      12.56637061435917295385057353311801153L /* 4*pi */
#define OWL_PI_2l     1.570796326794896619231321691639751442L /* pi/2 */
#define OWL_PI_4l     0.785398163397448309615660845819875721L /* pi/4 */
#define OWL_1_PIl     0.318309886183790671537767526745028724L /* 1/pi */
#define OWL_2_PIl     0.636619772367581343075535053490057448L /* 2/pi */
#define OWL_EULERl    0.577215664901532860606512090082402431L /* Euler constant */
#define OWL_SQRT2l    1.414213562373095048801688724209698079L /* sqrt(2) */
#define OWL_SQRT1_2l  0.707106781186547524400844362104849039L /* 1/sqrt(2) */


/*
 * IEEE 754 fpu handling. Those are guaranteed to be macros
 */

/* use builtins to avoid function calls in tight loops
 * only available if npy_config.h is available (= numpys own build) */
#if HAVE___BUILTIN_ISNAN
  #define owl_isnan(x) __builtin_isnan(x)
#else
  #ifndef OWL_HAVE_DECL_ISNAN
    #define owl_isnan(x) ((x) != (x))
  #else
    #if defined(_MSC_VER) && (_MSC_VER < 1900)
      #define owl_isnan(x) _isnan((x))
    #else
      #define owl_isnan(x) isnan(x)
    #endif
  #endif
#endif

/* only available if npy_config.h is available (= numpys own build) */
#if HAVE___BUILTIN_ISFINITE
  #define owl_isfinite(x) __builtin_isfinite(x)
#else
  #ifndef OWL_HAVE_DECL_ISFINITE
    #ifdef _MSC_VER
      #define owl_isfinite(x) _finite((x))
    #else
      #define owl_isfinite(x) !owl_isnan((x) + (-x))
    #endif
  #else
    #define owl_isfinite(x) isfinite((x))
  #endif
#endif

/* only available if npy_config.h is available (= numpys own build) */
#if HAVE___BUILTIN_ISINF
  #define owl_isinf(x) __builtin_isinf(x)
#else
  #ifndef OWL_HAVE_DECL_ISINF
    #define owl_isinf(x) (!owl_isfinite(x) && !owl_isnan(x))
  #else
    #if defined(_MSC_VER) && (_MSC_VER < 1900)
      #define owl_isinf(x) (!_finite((x)) && !_isnan((x)))
    #else
      #define owl_isinf(x) isinf((x))
    #endif
  #endif
#endif

#ifndef OWL_HAVE_DECL_SIGNBIT
  int _owl_signbit_f(float x);
  int _owl_signbit_d(double x);
  int _owl_signbit_ld(long double x);
  #define owl_signbit(x) \
    (sizeof (x) == sizeof (long double) ? _owl_signbit_ld (x) \
    : sizeof (x) == sizeof (double) ? _owl_signbit_d (x) \
    : _owl_signbit_f (x))
#else
  #define owl_signbit(x) signbit((x))
#endif

#if defined(_MSC_VER)
  #define OWL_INLINE __inline
#elif defined(__GNUC__)
	#if defined(__STRICT_ANSI__)
		#define OWL_INLINE __inline__
	#else
		#define OWL_INLINE inline
	#endif
#else
  #define OWL_INLINE
#endif


/*
 * Special functions
 */

extern double xlogy(double x, double y);

extern double xlog1py(double x, double y);

extern double expit(double x);

extern double logit(double x);

extern double logabs(double x);

extern double sinc(double x);


#ifdef __cplusplus
}
#endif


#endif // OWL_MATHS_H
