/*							j1f.c
 *
 *	Bessel function of order one
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, j1f();
 *
 * y = j1f( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns Bessel function of order one of the argument.
 *
 * The domain is divided into the intervals [0, 2] and
 * (2, infinity). In the first interval a polynomial approximation
 *        2 
 * (w - r  ) x P(w)
 *       1  
 *                     2 
 * is used, where w = x  and r is the first zero of the function.
 *
 * In the second interval, the modulus and phase are approximated
 * by polynomials of the form Modulus(x) = sqrt(1/x) Q(1/x)
 * and Phase(x) = x + 1/x R(1/x^2) - 3pi/4.  The function is
 *
 *   j0(x) = Modulus(x) cos( Phase(x) ).
 *
 *
 *
 * ACCURACY:
 *
 *                      Absolute error:
 * arithmetic   domain      # trials      peak       rms
 *    IEEE      0,  2       100000       1.2e-7     2.5e-8
 *    IEEE      2, 32       100000       2.0e-7     5.3e-8
 *
 *
 */
/*							y1.c
 *
 *	Bessel function of second kind of order one
 *
 *
 *
 * SYNOPSIS:
 *
 * double x, y, y1();
 *
 * y = y1( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns Bessel function of the second kind of order one
 * of the argument.
 *
 * The domain is divided into the intervals [0, 2] and
 * (2, infinity). In the first interval a rational approximation
 * R(x) is employed to compute
 *
 *                  2
 * y0(x)  =  (w - r  ) x R(x^2)  +  2/pi (ln(x) j1(x) - 1/x) .
 *                 1
 *
 * Thus a call to j1() is required.
 *
 * In the second interval, the modulus and phase are approximated
 * by polynomials of the form Modulus(x) = sqrt(1/x) Q(1/x)
 * and Phase(x) = x + 1/x S(1/x^2) - 3pi/4.  Then the function is
 *
 *   y0(x) = Modulus(x) sin( Phase(x) ).
 *
 *
 *
 *
 * ACCURACY:
 *
 *                      Absolute error:
 * arithmetic   domain      # trials      peak         rms
 *    IEEE      0,  2       100000       2.2e-7     4.6e-8
 *    IEEE      2, 32       100000       1.9e-7     5.3e-8
 *
 * (error criterion relative when |y1| > 1).
 *
 */


/*
Cephes Math Library Release 2.2:  June, 1992
Copyright 1984, 1987, 1989, 1992 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/


#include "cephes_single_mconf.h"


static float JP[5] = {
-4.878788132172128E-009f,
 6.009061827883699E-007f,
-4.541343896997497E-005f,
 1.937383947804541E-003f,
-3.405537384615824E-002f
};

static float YP[5] = {
 8.061978323326852E-009f,
-9.496460629917016E-007f,
 6.719543806674249E-005f,
-2.641785726447862E-003f,
 4.202369946500099E-002f
};

static float MO1[8] = {
 6.913942741265801E-002f,
-2.284801500053359E-001f,
 3.138238455499697E-001f,
-2.102302420403875E-001f,
 5.435364690523026E-003f,
 1.493389585089498E-001f,
 4.976029650847191E-006f,
 7.978845453073848E-001f
};

static float PH1[8] = {
-4.497014141919556E+001f,
 5.073465654089319E+001f,
-2.485774108720340E+001f,
 7.222973196770240E+000f,
-1.544842782180211E+000f,
 3.503787691653334E-001f,
-1.637986776941202E-001f,
 3.749989509080821E-001f
};

static float YO1 =  4.66539330185668857532f;
static float Z1 = 1.46819706421238932572E1f;

static float THPIO4F =  2.35619449019234492885f;    /* 3*pi/4 */
static float TWOOPI =  0.636619772367581343075535f; /* 2/pi */
extern float PIO4;


#ifdef ANSIC
float polevlf(float, float *, int);
float logf(float), sinf(float), cosf(float), sqrtf(float);

float j1f( float xx )
#else
float polevlf(), logf(), sinf(), cosf(), sqrtf();

float j1f(xx)
double xx;
#endif
{
float x, w, z, p, q, xn;


x = xx;
if( x < 0 )
	x = -xx;

if( x <= 2.0f )
	{
	z = x * x;	
	p = (z-Z1) * x * polevlf( z, JP, 4 );
	return( p );
	}

q = 1.0f/x;
w = sqrtf(q);

p = w * polevlf( q, MO1, 7);
w = q*q;
xn = q * polevlf( w, PH1, 7) - THPIO4F;
p = p * cosf(xn + x);
return(p);
}




extern float MAXNUMF;

#ifdef ANSIC
float y1f( float xx )
#else
float y1f(xx)
double xx;
#endif
{
float x, w, z, p, q, xn;


x = xx;
if( x <= 2.0f )
	{
	if( x <= 0.0f )
		{
		mtherr( "y1f", DOMAIN );
		return( -MAXNUMF );
		}
	z = x * x;
	w = (z - YO1) * x * polevlf( z, YP, 4 );
	w += TWOOPI * ( j1f(x) * logf(x)  -  1.0f/x );
	return( w );
	}

q = 1.0f/x;
w = sqrtf(q);

p = w * polevlf( q, MO1, 7);
w = q*q;
xn = q * polevlf( w, PH1, 7) - THPIO4F;
p = p * sinf(xn + x);
return(p);
}
