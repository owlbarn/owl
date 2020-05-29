/*							ynf.c
 *
 *	Bessel function of second kind of integer order
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, ynf();
 * int n;
 *
 * y = ynf( n, x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns Bessel function of order n, where n is a
 * (possibly negative) integer.
 *
 * The function is evaluated by forward recurrence on
 * n, starting with values computed by the routines
 * y0() and y1().
 *
 * If n = 0 or 1 the routine for y0 or y1 is called
 * directly.
 *
 *
 *
 * ACCURACY:
 *
 *
 *  Absolute error, except relative when y > 1:
 *                      
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0, 30       10000       2.3e-6      3.4e-7
 *
 *
 * ERROR MESSAGES:
 *
 *   message         condition      value returned
 * yn singularity   x = 0              MAXNUMF
 * yn overflow                         MAXNUMF
 *
 * Spot checked against tables for x, n between 0 and 100.
 *
 */

/*
Cephes Math Library Release 2.2: June, 1992
Copyright 1984, 1987, 1992 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/

#include "cephes_single_mconf.h"
extern float MAXNUMF, MAXLOGF;

#ifdef ANSIC
float y0f(float), y1f(float), logf(float);

float ynf( int nn, float xx )
#else
float y0f(), y1f(), logf();

float ynf( nn, xx )
int nn;
double xx;
#endif
{
float x, an, anm1, anm2, r, xinv;
int k, n, sign;

x = xx;
n = nn;
if( n < 0 )
	{
	n = -n;
	if( (n & 1) == 0 )	/* -1**n */
		sign = 1;
	else
		sign = -1;
	}
else
	sign = 1;


if( n == 0 )
	return( sign * y0f(x) );
if( n == 1 )
	return( sign * y1f(x) );

/* test for overflow */
if( x <= 0.0 )
	{
	mtherr( "ynf", SING );
	return( -MAXNUMF );
	}
if( (x < 1.0) || (n > 29) )
	{
	an = (float )n;
	r = an * logf( an/x );
	if( r > MAXLOGF )
		{
		mtherr( "ynf", OVERFLOW );
		return( -MAXNUMF );
		}
	}

/* forward recurrence on n */

anm2 = y0f(x);
anm1 = y1f(x);
k = 1;
r = 2 * k;
xinv = 1.0/x;
do
	{
	an = r * anm1 * xinv  -  anm2;
	anm2 = anm1;
	anm1 = an;
	r += 2.0;
	++k;
	}
while( k < n );


return( sign * an );
}
