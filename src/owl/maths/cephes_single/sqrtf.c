/*							sqrtf.c
 *
 *	Square root
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, y, sqrtf();
 *
 * y = sqrtf( x );
 *
 *
 *
 * DESCRIPTION:
 *
 * Returns the square root of x.
 *
 * Range reduction involves isolating the power of two of the
 * argument and using a polynomial approximation to obtain
 * a rough value for the square root.  Then Heron's iteration
 * is used three times to converge to an accurate value.
 *
 *
 *
 * ACCURACY:
 *
 *
 *                      Relative error:
 * arithmetic   domain     # trials      peak         rms
 *    IEEE      0,1.e38     100000       8.7e-8     2.9e-8
 *
 *
 * ERROR MESSAGES:
 *
 *   message         condition      value returned
 * sqrtf domain        x < 0            0.0
 *
 */

/*
Cephes Math Library Release 2.2:  June, 1992
Copyright 1984, 1987, 1988, 1992 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/

/* Single precision square root
 * test interval: [sqrt(2)/2, sqrt(2)]
 * trials: 30000
 * peak relative error: 8.8e-8
 * rms relative error: 3.3e-8
 *
 * test interval: [0.01, 100.0]
 * trials: 50000
 * peak relative error: 8.7e-8
 * rms relative error: 3.3e-8
 *
 * Copyright (C) 1989 by Stephen L. Moshier.  All rights reserved.
 */
#include "cephes_single_mconf.h"

#ifdef ANSIC
float frexpf( float, int * );
float ldexpf( float, int );

float sqrtf( float xx )
#else
float frexpf(), ldexpf();

float sqrtf(xx)
float xx;
#endif
{
float f, x, y;
int e;

f = xx;
if( f <= 0.0 )
	{
	if( f < 0.0 )
		mtherr( "sqrtf", DOMAIN );
	return( 0.0 );
	}

x = frexpf( f, &e );	/* f = x * 2**e,   0.5 <= x < 1.0 */
/* If power of 2 is odd, double x and decrement the power of 2. */
if( e & 1 )
	{
	x = x + x;
	e -= 1;
	}

e >>= 1;	/* The power of 2 of the square root. */

if( x > 1.41421356237 )
	{
/* x is between sqrt(2) and 2. */
	x = x - 2.0;
	y =
	((((( -9.8843065718E-4 * x
	  + 7.9479950957E-4) * x
	  - 3.5890535377E-3) * x
	  + 1.1028809744E-2) * x
	  - 4.4195203560E-2) * x
	  + 3.5355338194E-1) * x
	  + 1.41421356237E0;
	goto sqdon;
	}

if( x > 0.707106781187 )
	{
/* x is between sqrt(2)/2 and sqrt(2). */
	x = x - 1.0;
	y =
	((((( 1.35199291026E-2 * x
	  - 2.26657767832E-2) * x
	  + 2.78720776889E-2) * x
	  - 3.89582788321E-2) * x
	  + 6.24811144548E-2) * x
	  - 1.25001503933E-1) * x * x
	  + 0.5 * x
	  + 1.0;
	goto sqdon;
	}

/* x is between 0.5 and sqrt(2)/2. */
x = x - 0.5;
y =
((((( -3.9495006054E-1 * x
  + 5.1743034569E-1) * x
  - 4.3214437330E-1) * x
  + 3.5310730460E-1) * x
  - 3.5354581892E-1) * x
  + 7.0710676017E-1) * x
  + 7.07106781187E-1;

sqdon:
y = ldexpf( y, e );  /* y = y * 2**e */
return( y);
}
