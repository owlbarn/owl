/*							j0f.c
 *
 *	Bessel function of order zero
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, j0f();
 *
 * y = j0f( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns Bessel function of order zero of the argument.
 *
 * The domain is divided into the intervals [0, 2] and
 * (2, infinity). In the first interval the following polynomial
 * approximation is used:
 *
 *
 *        2         2         2
 * (w - r  ) (w - r  ) (w - r  ) P(w)
 *       1         2         3   
 *
 *            2
 * where w = x  and the three r's are zeros of the function.
 *
 * In the second interval, the modulus and phase are approximated
 * by polynomials of the form Modulus(x) = sqrt(1/x) Q(1/x)
 * and Phase(x) = x + 1/x R(1/x^2) - pi/4.  The function is
 *
 *   j0(x) = Modulus(x) cos( Phase(x) ).
 *
 *
 *
 * ACCURACY:
 *
 *                      Absolute error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0, 2        100000      1.3e-7      3.6e-8
 *    IEEE      2, 32       100000      1.9e-7      5.4e-8
 *
 */
/*							y0f.c
 *
 *	Bessel function of the second kind, order zero
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, y0f();
 *
 * y = y0f( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns Bessel function of the second kind, of order
 * zero, of the argument.
 *
 * The domain is divided into the intervals [0, 2] and
 * (2, infinity). In the first interval a rational approximation
 * R(x) is employed to compute
 *
 *                  2         2         2
 * y0(x)  =  (w - r  ) (w - r  ) (w - r  ) R(x)  +  2/pi ln(x) j0(x).
 *                 1         2         3   
 *
 * Thus a call to j0() is required.  The three zeros are removed
 * from R(x) to improve its numerical stability.
 *
 * In the second interval, the modulus and phase are approximated
 * by polynomials of the form Modulus(x) = sqrt(1/x) Q(1/x)
 * and Phase(x) = x + 1/x S(1/x^2) - pi/4.  Then the function is
 *
 *   y0(x) = Modulus(x) sin( Phase(x) ).
 *
 *
 *
 *
 * ACCURACY:
 *
 *  Absolute error, when y0(x) < 1; else relative error:
 *
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0,  2       100000      2.4e-7      3.4e-8
 *    IEEE      2, 32       100000      1.8e-7      5.3e-8
 *
 */

/*
Cephes Math Library Release 2.2:  June, 1992
Copyright 1984, 1987, 1989, 1992 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/


#include "cephes_single_mconf.h"

static float MO[8] = {
-6.838999669318810E-002f,
 1.864949361379502E-001f,
-2.145007480346739E-001f,
 1.197549369473540E-001f,
-3.560281861530129E-003f,
-4.969382655296620E-002f,
-3.355424622293709E-006f,
 7.978845717621440E-001f
};

static float PH[8] = {
 3.242077816988247E+001f,
-3.630592630518434E+001f,
 1.756221482109099E+001f,
-4.974978466280903E+000f,
 1.001973420681837E+000f,
-1.939906941791308E-001f,
 6.490598792654666E-002f,
-1.249992184872738E-001f
};

static float YP[5] = {
 9.454583683980369E-008f,
-9.413212653797057E-006f,
 5.344486707214273E-004f,
-1.584289289821316E-002f,
 1.707584643733568E-001f
};

float YZ1 =  0.43221455686510834878f;
float YZ2 = 22.401876406482861405f;
float YZ3 = 64.130620282338755553f;

static float DR1 =  5.78318596294678452118f;
/*
static float DR2 = 30.4712623436620863991;
static float DR3 = 74.887006790695183444889;
*/

static float JP[5] = {
-6.068350350393235E-008f,
 6.388945720783375E-006f,
-3.969646342510940E-004f,
 1.332913422519003E-002f,
-1.729150680240724E-001f
};
extern float PIO4F;


#ifdef ANSIC
float polevlf(float, float *, int);
float logf(float), sinf(float), cosf(float), sqrtf(float);

float j0f( float xx )
#else
float polevlf(), logf(), sinf(), cosf(), sqrtf();

float j0f(xx)
double xx;
#endif
{
float x, w, z, p, q, xn;


if( xx < 0 )
	x = -xx;
else
	x = xx;

if( x <= 2.0f )
	{
	z = x * x;
	if( x < 1.0e-3f )
		return( 1.0f - 0.25f*z );

	p = (z-DR1) * polevlf( z, JP, 4);
	return( p );
	}

q = 1.0f/x;
w = sqrtf(q);

p = w * polevlf( q, MO, 7);
w = q*q;
xn = q * polevlf( w, PH, 7) - PIO4F;
p = p * cosf(xn + x);
return(p);
}

/*							y0() 2	*/
/* Bessel function of second kind, order zero	*/

/* Rational approximation coefficients YP[] are used for x < 6.5.
 * The function computed is  y0(x)  -  2 ln(x) j0(x) / pi,
 * whose value at x = 0 is  2 * ( log(0.5) + EUL ) / pi
 * = 0.073804295108687225 , EUL is Euler's constant.
 */

static float TWOOPI =  0.636619772367581343075535f; /* 2/pi */
extern float MAXNUMF;

#ifdef ANSIC
float y0f( float xx )
#else
float y0f(xx)
double xx;
#endif
{
float x, w, z, p, q, xn;


x = xx;
if( x <= 2.0f )
	{
	if( x <= 0.0f )
		{
		mtherr( "y0f", DOMAIN );
		return( -MAXNUMF );
		}
	z = x * x;
/*	w = (z-YZ1)*(z-YZ2)*(z-YZ3) * polevlf( z, YP, 4);*/
	w = (z-YZ1) * polevlf( z, YP, 4);
	w += TWOOPI * logf(x) * j0f(x);
	return( w );
	}

q = 1.0f/x;
w = sqrtf(q);

p = w * polevlf( q, MO, 7);
w = q*q;
xn = q * polevlf( w, PH, 7) - PIO4F;
p = p * sinf(xn + x);
return( p );
}
