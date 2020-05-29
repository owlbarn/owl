/*							hypergf.c
 *
 *	Confluent hypergeometric function
 *
 *
 *
 * SYNOPSIS:
 *
 * float a, b, x, y, hypergf();
 *
 * y = hypergf( a, b, x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Computes the confluent hypergeometric function
 *
 *                          1           2
 *                       a x    a(a+1) x
 *   F ( a,b;x )  =  1 + ---- + --------- + ...
 *  1 1                  b 1!   b(b+1) 2!
 *
 * Many higher transcendental functions are special cases of
 * this power series.
 *
 * As is evident from the formula, b must not be a negative
 * integer or zero unless a is an integer with 0 >= a > b.
 *
 * The routine attempts both a direct summation of the series
 * and an asymptotic expansion.  In each case error due to
 * roundoff, cancellation, and nonconvergence is estimated.
 * The result with smaller estimated error is returned.
 *
 *
 *
 * ACCURACY:
 *
 * Tested at random points (a, b, x), all three variables
 * ranging from 0 to 30.
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0,5         10000       6.6e-7      1.3e-7
 *    IEEE      0,30        30000       1.1e-5      6.5e-7
 *
 * Larger errors can be observed when b is near a negative
 * integer or zero.  Certain combinations of arguments yield
 * serious cancellation error in the power series summation
 * and also are not in the region of near convergence of the
 * asymptotic series.  An error message is printed if the
 * self-estimated relative error is greater than 1.0e-3.
 *
 */

/*							hyperg.c */


/*
Cephes Math Library Release 2.1:  November, 1988
Copyright 1984, 1987, 1988 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/

#include "cephes_single_mconf.h"

extern float MAXNUMF, MACHEPF;

#define fabsf(x) ( (x) < 0 ? -(x) : (x) )

#ifdef ANSIC
float expf(float);
float hyp2f0f(float, float, float, int, float *);
static float hy1f1af(float, float, float, float *);
static float hy1f1pf(float, float, float, float *);
float logf(float), gammaf(float), lgamf(float);
#else
float expf(), hyp2f0f();
float logf(), gammaf(), lgamf();
static float hy1f1pf(), hy1f1af();
#endif

#ifdef ANSIC
float hypergf( float aa, float bb, float xx )
#else
float hypergf( aa, bb, xx)
double aa, bb, xx;
#endif
{
float a, b, x, asum, psum, acanc, pcanc, temp;


a = aa;
b = bb;
x = xx;
/* See if a Kummer transformation will help */
temp = b - a;
if( fabsf(temp) < 0.001 * fabsf(a) )
	return( expf(x) * hypergf( temp, b, -x )  );

psum = hy1f1pf( a, b, x, &pcanc );
if( pcanc < 1.0e-6 )
	goto done;


/* try asymptotic series */

asum = hy1f1af( a, b, x, &acanc );


/* Pick the result with less estimated error */

if( acanc < pcanc )
	{
	pcanc = acanc;
	psum = asum;
	}

done:
if( pcanc > 1.0e-3 )
	mtherr( "hyperg", PLOSS );

return( psum );
}




/* Power series summation for confluent hypergeometric function		*/


#ifdef ANSIC
static float hy1f1pf( float aa, float bb, float xx, float *err )
#else
static float hy1f1pf( aa, bb, xx, err )
double aa, bb, xx;
float *err;
#endif
{
float a, b, x, n, a0, sum, t, u, temp;
float an, bn, maxt, pcanc;

a = aa;
b = bb;
x = xx;
/* set up for power series summation */
an = a;
bn = b;
a0 = 1.0;
sum = 1.0;
n = 1.0;
t = 1.0;
maxt = 0.0;


while( t > MACHEPF )
	{
	if( bn == 0 )			/* check bn first since if both	*/
		{
		mtherr( "hypergf", SING );
		return( MAXNUMF );	/* an and bn are zero it is	*/
		}
	if( an == 0 )			/* a singularity		*/
		return( sum );
	if( n > 200 )
		goto pdone;
	u = x * ( an / (bn * n) );

	/* check for blowup */
	temp = fabsf(u);
	if( (temp > 1.0 ) && (maxt > (MAXNUMF/temp)) )
		{
		pcanc = 1.0;	/* estimate 100% error */
		goto blowup;
		}

	a0 *= u;
	sum += a0;
	t = fabsf(a0);
	if( t > maxt )
		maxt = t;
/*
	if( (maxt/fabsf(sum)) > 1.0e17 )
		{
		pcanc = 1.0;
		goto blowup;
		}
*/
	an += 1.0;
	bn += 1.0;
	n += 1.0;
	}

pdone:

/* estimate error due to roundoff and cancellation */
if( sum != 0.0 )
	maxt /= fabsf(sum);
maxt *= MACHEPF; 	/* this way avoids multiply overflow */
pcanc = fabsf( MACHEPF * n  +  maxt );

blowup:

*err = pcanc;

return( sum );
}


/*							hy1f1a()	*/
/* asymptotic formula for hypergeometric function:
 *
 *        (    -a                         
 *  --    ( |z|                           
 * |  (b) ( -------- 2f0( a, 1+a-b, -1/x )
 *        (  --                           
 *        ( |  (b-a)                      
 *
 *
 *                                x    a-b                     )
 *                               e  |x|                        )
 *                             + -------- 2f0( b-a, 1-a, 1/x ) )
 *                                --                           )
 *                               |  (a)                        )
 */

#ifdef ANSIC
static float hy1f1af( float aa, float bb, float xx, float *err )
#else
static float hy1f1af( aa, bb, xx, err )
double aa, bb, xx;
float *err;
#endif
{
float a, b, x, h1, h2, t, u, temp, acanc, asum, err1, err2;

a = aa;
b = bb;
x = xx;
if( x == 0 )
	{
	acanc = 1.0;
	asum = MAXNUMF;
	goto adone;
	}
temp = logf( fabsf(x) );
t = x + temp * (a-b);
u = -temp * a;

if( b > 0 )
	{
	temp = lgamf(b);
	t += temp;
	u += temp;
	}

h1 = hyp2f0f( a, a-b+1, -1.0/x, 1, &err1 );

temp = expf(u) / gammaf(b-a);
h1 *= temp;
err1 *= temp;

h2 = hyp2f0f( b-a, 1.0-a, 1.0/x, 2, &err2 );

if( a < 0 )
	temp = expf(t) / gammaf(a);
else
	temp = expf( t - lgamf(a) );

h2 *= temp;
err2 *= temp;

if( x < 0.0 )
	asum = h1;
else
	asum = h2;

acanc = fabsf(err1) + fabsf(err2);


if( b < 0 )
	{
	temp = gammaf(b);
	asum *= temp;
	acanc *= fabsf(temp);
	}


if( asum != 0.0 )
	acanc /= fabsf(asum);

acanc *= 30.0;	/* fudge factor, since error of asymptotic formula
		 * often seems this much larger than advertised */

adone:


*err = acanc;
return( asum );
}

/*							hyp2f0()	*/

#ifdef ANSIC
float hyp2f0f(float aa, float bb, float xx, int type, float *err)
#else
float hyp2f0f( aa, bb, xx, type, err )
double aa, bb, xx;
int type;	/* determines what converging factor to use */
float *err;
#endif
{
float a, b, x, a0, alast, t, tlast, maxt;
float n, an, bn, u, sum, temp;

a = aa;
b = bb;
x = xx;
an = a;
bn = b;
a0 = 1.0;
alast = 1.0;
sum = 0.0;
n = 1.0;
t = 1.0;
tlast = 1.0e9;
maxt = 0.0;

do
	{
	if( an == 0 )
		goto pdone;
	if( bn == 0 )
		goto pdone;

	u = an * (bn * x / n);

	/* check for blowup */
	temp = fabsf(u);
	if( (temp > 1.0 ) && (maxt > (MAXNUMF/temp)) )
		goto error;

	a0 *= u;
	t = fabsf(a0);

	/* terminating condition for asymptotic series */
	if( t > tlast )
		goto ndone;

	tlast = t;
	sum += alast;	/* the sum is one term behind */
	alast = a0;

	if( n > 200 )
		goto ndone;

	an += 1.0;
	bn += 1.0;
	n += 1.0;
	if( t > maxt )
		maxt = t;
	}
while( t > MACHEPF );


pdone:	/* series converged! */

/* estimate error due to roundoff and cancellation */
*err = fabsf(  MACHEPF * (n + maxt)  );

alast = a0;
goto done;

ndone:	/* series did not converge */

/* The following "Converging factors" are supposed to improve accuracy,
 * but do not actually seem to accomplish very much. */

n -= 1.0;
x = 1.0/x;

switch( type )	/* "type" given as subroutine argument */
{
case 1:
	alast *= ( 0.5 + (0.125 + 0.25*b - 0.5*a + 0.25*x - 0.25*n)/x );
	break;

case 2:
	alast *= 2.0/3.0 - b + 2.0*a + x - n;
	break;

default:
	;
}

/* estimate error due to roundoff, cancellation, and nonconvergence */
*err = MACHEPF * (n + maxt)  +  fabsf( a0 );


done:
sum += alast;
return( sum );

/* series blew up: */
error:
*err = MAXNUMF;
mtherr( "hypergf", TLOSS );
return( sum );
}
