/*							i0f.c
 *
 *	Modified Bessel function of order zero
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, i0();
 *
 * y = i0f( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns modified Bessel function of order zero of the
 * argument.
 *
 * The function is defined as i0(x) = j0( ix ).
 *
 * The range is partitioned into the two intervals [0,8] and
 * (8, infinity).  Chebyshev polynomial expansions are employed
 * in each interval.
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0,30        100000      4.0e-7      7.9e-8
 *
 */
/*							i0ef.c
 *
 *	Modified Bessel function of order zero,
 *	exponentially scaled
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, i0ef();
 *
 * y = i0ef( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns exponentially scaled modified Bessel function
 * of order zero of the argument.
 *
 * The function is defined as i0e(x) = exp(-|x|) j0( ix ).
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0,30        100000      3.7e-7      7.0e-8
 * See i0f().
 *
 */

/*							i0.c		*/


/*
Cephes Math Library Release 2.2:  June, 1992
Copyright 1984, 1987, 1992 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/

#include "cephes_single_mconf.h"

/* Chebyshev coefficients for exp(-x) I0(x)
 * in the interval [0,8].
 *
 * lim(x->0){ exp(-x) I0(x) } = 1.
 */

static float A[] =
{
-1.30002500998624804212E-8f,
 6.04699502254191894932E-8f,
-2.67079385394061173391E-7f,
 1.11738753912010371815E-6f,
-4.41673835845875056359E-6f,
 1.64484480707288970893E-5f,
-5.75419501008210370398E-5f,
 1.88502885095841655729E-4f,
-5.76375574538582365885E-4f,
 1.63947561694133579842E-3f,
-4.32430999505057594430E-3f,
 1.05464603945949983183E-2f,
-2.37374148058994688156E-2f,
 4.93052842396707084878E-2f,
-9.49010970480476444210E-2f,
 1.71620901522208775349E-1f,
-3.04682672343198398683E-1f,
 6.76795274409476084995E-1f
};


/* Chebyshev coefficients for exp(-x) sqrt(x) I0(x)
 * in the inverted interval [8,infinity].
 *
 * lim(x->inf){ exp(-x) sqrt(x) I0(x) } = 1/sqrt(2pi).
 */

static float B[] =
{
 3.39623202570838634515E-9f,
 2.26666899049817806459E-8f,
 2.04891858946906374183E-7f,
 2.89137052083475648297E-6f,
 6.88975834691682398426E-5f,
 3.36911647825569408990E-3f,
 8.04490411014108831608E-1f
};

 
#ifdef ANSIC
float chbevlf(float, float *, int), expf(float), sqrtf(float);

float i0f( float x )
#else
float chbevlf(), expf(), sqrtf();

float i0f(x)
double x;
#endif
{
float y;

if( x < 0 )
	x = -x;
if( x <= 8.0f )
	{
	y = 0.5f*x - 2.0f;
	return( expf(x) * chbevlf( y, A, 18 ) );
	}

return(  expf(x) * chbevlf( 32.0f/x - 2.0f, B, 7 ) / sqrtf(x) );
}



#ifdef ANSIC
float chbevlf(float, float *, int), expf(float), sqrtf(float);

float i0ef( float x )
#else
float chbevlf(), expf(), sqrtf();

float i0ef( x )
double x;
#endif
{
float y;

if( x < 0 )
	x = -x;
if( x <= 8.0f )
	{
	y = 0.5f*x - 2.0f;
	return( chbevlf( y, A, 18 ) );
	}

return(  chbevlf( 32.0f/x - 2.0f, B, 7 ) / sqrtf(x) );
}
