/*							i1f.c
 *
 *	Modified Bessel function of order one
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, i1f();
 *
 * y = i1f( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns modified Bessel function of order one of the
 * argument.
 *
 * The function is defined as i1(x) = -i j1( ix ).
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
 *    IEEE      0, 30       100000      1.5e-6      1.6e-7
 *
 *
 */
/*							i1ef.c
 *
 *	Modified Bessel function of order one,
 *	exponentially scaled
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, i1ef();
 *
 * y = i1ef( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns exponentially scaled modified Bessel function
 * of order one of the argument.
 *
 * The function is defined as i1(x) = -i exp(-|x|) j1( ix ).
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0, 30       30000       1.5e-6      1.5e-7
 * See i1().
 *
 */

/*							i1.c 2		*/


/*
Cephes Math Library Release 2.0:  March, 1987
Copyright 1985, 1987 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/

#include "cephes_single_mconf.h"

/* Chebyshev coefficients for exp(-x) I1(x) / x
 * in the interval [0,8].
 *
 * lim(x->0){ exp(-x) I1(x) / x } = 1/2.
 */

static float A[] =
{
 9.38153738649577178388E-9f,
-4.44505912879632808065E-8f,
 2.00329475355213526229E-7f,
-8.56872026469545474066E-7f,
 3.47025130813767847674E-6f,
-1.32731636560394358279E-5f,
 4.78156510755005422638E-5f,
-1.61760815825896745588E-4f,
 5.12285956168575772895E-4f,
-1.51357245063125314899E-3f,
 4.15642294431288815669E-3f,
-1.05640848946261981558E-2f,
 2.47264490306265168283E-2f,
-5.29459812080949914269E-2f,
 1.02643658689847095384E-1f,
-1.76416518357834055153E-1f,
 2.52587186443633654823E-1f
};


/* Chebyshev coefficients for exp(-x) sqrt(x) I1(x)
 * in the inverted interval [8,infinity].
 *
 * lim(x->inf){ exp(-x) sqrt(x) I1(x) } = 1/sqrt(2pi).
 */

static float B[] =
{
-3.83538038596423702205E-9f,
-2.63146884688951950684E-8f,
-2.51223623787020892529E-7f,
-3.88256480887769039346E-6f,
-1.10588938762623716291E-4f,
-9.76109749136146840777E-3f,
 7.78576235018280120474E-1f
};

/*							i1.c	*/

#define fabsf(x) ( (x) < 0 ? -(x) : (x) )

#ifdef ANSIC
float chbevlf(float, float *, int);
float expf(float), sqrtf(float);
#else
float chbevlf(), expf(), sqrtf();
#endif


#ifdef ANSIC
float i1f(float xx)
#else
float i1f(xx)
double xx;
#endif
{ 
float x, y, z;

x = xx;
z = fabsf(x);
if( z <= 8.0f )
	{
	y = 0.5f*z - 2.0f;
	z = chbevlf( y, A, 17 ) * z * expf(z);
	}
else
	{
	z = expf(z) * chbevlf( 32.0f/z - 2.0f, B, 7 ) / sqrtf(z);
	}
if( x < 0.0f )
	z = -z;
return( z );
}

/*							i1e()	*/

#ifdef ANSIC
float i1ef( float xx )
#else
float i1ef( xx )
double xx;
#endif
{ 
float x, y, z;

x = xx;
z = fabsf(x);
if( z <= 8.0f )
	{
	y = 0.5f*z - 2.0f;
	z = chbevlf( y, A, 17 ) * z;
	}
else
	{
	z = chbevlf( 32.0f/z - 2.0f, B, 7 ) / sqrtf(z);
	}
if( x < 0.0f )
	z = -z;
return( z );
}
