/*							k0f.c
 *
 *	Modified Bessel function, third kind, order zero
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, k0f();
 *
 * y = k0f( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns modified Bessel function of the third kind
 * of order zero of the argument.
 *
 * The range is partitioned into the two intervals [0,8] and
 * (8, infinity).  Chebyshev polynomial expansions are employed
 * in each interval.
 *
 *
 *
 * ACCURACY:
 *
 * Tested at 2000 random points between 0 and 8.  Peak absolute
 * error (relative when K0 > 1) was 1.46e-14; rms, 4.26e-15.
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0, 30       30000       7.8e-7      8.5e-8
 *
 * ERROR MESSAGES:
 *
 *   message         condition      value returned
 *  K0 domain          x <= 0          MAXNUM
 *
 */
/*							k0ef()
 *
 *	Modified Bessel function, third kind, order zero,
 *	exponentially scaled
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, k0ef();
 *
 * y = k0ef( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns exponentially scaled modified Bessel function
 * of the third kind of order zero of the argument.
 *
 *
 *
 * ACCURACY:
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0, 30       30000       8.1e-7      7.8e-8
 * See k0().
 *
 */

/*
Cephes Math Library Release 2.0:  April, 1987
Copyright 1984, 1987 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/

#include "cephes_single_mconf.h"

/* Chebyshev coefficients for K0(x) + log(x/2) I0(x)
 * in the interval [0,2].  The odd order coefficients are all
 * zero; only the even order coefficients are listed.
 * 
 * lim(x->0){ K0(x) + log(x/2) I0(x) } = -EUL.
 */

static float A[] =
{
 1.90451637722020886025E-9f,
 2.53479107902614945675E-7f,
 2.28621210311945178607E-5f,
 1.26461541144692592338E-3f,
 3.59799365153615016266E-2f,
 3.44289899924628486886E-1f,
-5.35327393233902768720E-1f
};



/* Chebyshev coefficients for exp(x) sqrt(x) K0(x)
 * in the inverted interval [2,infinity].
 * 
 * lim(x->inf){ exp(x) sqrt(x) K0(x) } = sqrt(pi/2).
 */

static float B[] = {
-1.69753450938905987466E-9f,
 8.57403401741422608519E-9f,
-4.66048989768794782956E-8f,
 2.76681363944501510342E-7f,
-1.83175552271911948767E-6f,
 1.39498137188764993662E-5f,
-1.28495495816278026384E-4f,
 1.56988388573005337491E-3f,
-3.14481013119645005427E-2f,
 2.44030308206595545468E0f
};

/*							k0.c	*/
 
extern float MAXNUMF;

#ifdef ANSIC
float chbevlf(float, float *, int);
float expf(float), i0f(float), logf(float), sqrtf(float);
#else
float chbevlf(), expf(), i0f(), logf(), sqrtf();
#endif


#ifdef ANSIC
float k0f( float xx )
#else
float k0f(xx)
double xx;
#endif
{
float x, y, z;

x = xx;
if( x <= 0.0f )
	{
	mtherr( "k0f", DOMAIN );
	return( MAXNUMF );
	}

if( x <= 2.0f )
	{
	y = x * x - 2.0f;
	y = chbevlf( y, A, 7 ) - logf( 0.5f * x ) * i0f(x);
	return( y );
	}
z = 8.0f/x - 2.0f;
y = expf(-x) * chbevlf( z, B, 10 ) / sqrtf(x);
return(y);
}



#ifdef ANSIC
float k0ef( float xx )
#else
float k0ef( xx )
double xx;
#endif
{
float x, y;


x = xx;
if( x <= 0.0f )
	{
	mtherr( "k0ef", DOMAIN );
	return( MAXNUMF );
	}

if( x <= 2.0f )
	{
	y = x * x - 2.0f;
	y = chbevlf( y, A, 7 ) - logf( 0.5f * x ) * i0f(x);
	return( y * expf(x) );
	}

y = chbevlf( 8.0f/x - 2.0f, B, 10 ) / sqrtf(x);
return(y);
}
