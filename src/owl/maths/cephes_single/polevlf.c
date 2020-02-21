/*							polevlf.c
 *							p1evlf.c
 *
 *	Evaluate polynomial
 *
 *
 *
 * SYNOPSIS:
 *
 * int N;
 * float x, y, coef[N+1], polevlf[];
 *
 * y = polevlf( x, coef, N );
 *
 *
 *
 * DESCRIPTION:
 *
 * Evaluates polynomial of degree N:
 *
 *                     2          N
 * y  =  C  + C x + C x  +...+ C x
 *        0    1     2          N
 *
 * Coefficients are stored in reverse order:
 *
 * coef[0] = C  , ..., coef[N] = C  .
 *            N                   0
 *
 *  The function p1evl() assumes that coef[N] = 1.0 and is
 * omitted from the array.  Its calling arguments are
 * otherwise the same as polevl().
 *
 *
 * SPEED:
 *
 * In the interest of speed, there are no checks for out
 * of bounds arithmetic.  This routine is used by most of
 * the functions in the library.  Depending on available
 * equipment features, the user may wish to rewrite the
 * program in microcode or assembly language.
 *
 */


/*
Cephes Math Library Release 2.1:  December, 1988
Copyright 1984, 1987, 1988 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/

#include "cephes_single_mconf.h"

#ifdef ANSIC
float polevlf( float xx, float *coef, int N )
#else
float polevlf( xx, coef, N )
double xx;
float *coef;
int N;
#endif
{
float ans, x;
float *p;
int i;

x = xx;
p = coef;
ans = *p++;

/*
for( i=0; i<N; i++ )
	ans = ans * x  +  *p++;
*/

i = N;
do
	ans = ans * x  +  *p++;
while( --i );

return( ans );
}

/*							p1evl()	*/
/*                                          N
 * Evaluate polynomial when coefficient of x  is 1.0.
 * Otherwise same as polevl.
 */

#ifdef ANSIC
float p1evlf( float xx, float *coef, int N )
#else
float p1evlf( xx, coef, N )
double xx;
float *coef;
int N;
#endif
{
float ans, x;
float *p;
int i;

x = xx;
p = coef;
ans = x + *p++;
i = N-1;

do
	ans = ans * x  + *p++;
while( --i );

return( ans );
}
