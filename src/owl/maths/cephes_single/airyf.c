/*							airy.c
 *
 *	Airy function
 *
 *
 *
 * SYNOPSIS:
 *
 * float x, ai, aip, bi, bip;
 * int airyf();
 *
 * airyf( x, _&ai, _&aip, _&bi, _&bip );
 *
 *
 *
 * DESCRIPTION:
 *
 * Solution of the differential equation
 *
 *	y"(x) = xy.
 *
 * The function returns the two independent solutions Ai, Bi
 * and their first derivatives Ai'(x), Bi'(x).
 *
 * Evaluation is by power series summation for small x,
 * by rational minimax approximations for large x.
 *
 *
 *
 * ACCURACY:
 * Error criterion is absolute when function <= 1, relative
 * when function > 1, except * denotes relative error criterion.
 * For large negative x, the absolute error increases as x^1.5.
 * For large positive x, the relative error increases as x^1.5.
 *
 * Arithmetic  domain   function  # trials      peak         rms
 * IEEE        -10, 0     Ai        50000       7.0e-7      1.2e-7
 * IEEE          0, 10    Ai        50000       9.9e-6*     6.8e-7*
 * IEEE        -10, 0     Ai'       50000       2.4e-6      3.5e-7
 * IEEE          0, 10    Ai'       50000       8.7e-6*     6.2e-7*
 * IEEE        -10, 10    Bi       100000       2.2e-6      2.6e-7
 * IEEE        -10, 10    Bi'       50000       2.2e-6      3.5e-7
 *
 */
/*							airy.c */

/*
Cephes Math Library Release 2.2: June, 1992
Copyright 1984, 1987, 1989, 1992 by Stephen L. Moshier
Direct inquiries to 30 Frost Street, Cambridge, MA 02140
*/

#include "cephes_single_mconf.h"

static float c1 = 0.35502805388781723926;
static float c2 = 0.258819403792806798405;
static float sqrt3 = 1.732050807568877293527;
static float sqpii = 5.64189583547756286948E-1;
extern float PIF;

extern float MAXNUMF, MACHEPF;
#define MAXAIRY 25.77

/* Note, these expansions are for double precision accuracy;
 * they have not yet been redesigned for single precision.
 */
static float AN[8] = {
  3.46538101525629032477e-1,
  1.20075952739645805542e1,
  7.62796053615234516538e1,
  1.68089224934630576269e2,
  1.59756391350164413639e2,
  7.05360906840444183113e1,
  1.40264691163389668864e1,
  9.99999999999999995305e-1,
};
static float AD[8] = {
  5.67594532638770212846e-1,
  1.47562562584847203173e1,
  8.45138970141474626562e1,
  1.77318088145400459522e2,
  1.64234692871529701831e2,
  7.14778400825575695274e1,
  1.40959135607834029598e1,
  1.00000000000000000470e0,
};


static float APN[8] = {
  6.13759184814035759225e-1,
  1.47454670787755323881e1,
  8.20584123476060982430e1,
  1.71184781360976385540e2,
  1.59317847137141783523e2,
  6.99778599330103016170e1,
  1.39470856980481566958e1,
  1.00000000000000000550e0,
};
static float APD[8] = {
  3.34203677749736953049e-1,
  1.11810297306158156705e1,
  7.11727352147859965283e1,
  1.58778084372838313640e2,
  1.53206427475809220834e2,
  6.86752304592780337944e1,
  1.38498634758259442477e1,
  9.99999999999999994502e-1,
};

static float BN16[5] = {
-2.53240795869364152689e-1,
 5.75285167332467384228e-1,
-3.29907036873225371650e-1,
 6.44404068948199951727e-2,
-3.82519546641336734394e-3,
};
static float BD16[5] = {
/* 1.00000000000000000000e0,*/
-7.15685095054035237902e0,
 1.06039580715664694291e1,
-5.23246636471251500874e0,
 9.57395864378383833152e-1,
-5.50828147163549611107e-2,
};

static float BPPN[5] = {
 4.65461162774651610328e-1,
-1.08992173800493920734e0,
 6.38800117371827987759e-1,
-1.26844349553102907034e-1,
 7.62487844342109852105e-3,
};
static float BPPD[5] = {
/* 1.00000000000000000000e0,*/
-8.70622787633159124240e0,
 1.38993162704553213172e1,
-7.14116144616431159572e0,
 1.34008595960680518666e0,
-7.84273211323341930448e-2,
};

static float AFN[9] = {
-1.31696323418331795333e-1,
-6.26456544431912369773e-1,
-6.93158036036933542233e-1,
-2.79779981545119124951e-1,
-4.91900132609500318020e-2,
-4.06265923594885404393e-3,
-1.59276496239262096340e-4,
-2.77649108155232920844e-6,
-1.67787698489114633780e-8,
};
static float AFD[9] = {
/* 1.00000000000000000000e0,*/
 1.33560420706553243746e1,
 3.26825032795224613948e1,
 2.67367040941499554804e1,
 9.18707402907259625840e0,
 1.47529146771666414581e0,
 1.15687173795188044134e-1,
 4.40291641615211203805e-3,
 7.54720348287414296618e-5,
 4.51850092970580378464e-7,
};

static float AGN[11] = {
  1.97339932091685679179e-2,
  3.91103029615688277255e-1,
  1.06579897599595591108e0,
  9.39169229816650230044e-1,
  3.51465656105547619242e-1,
  6.33888919628925490927e-2,
  5.85804113048388458567e-3,
  2.82851600836737019778e-4,
  6.98793669997260967291e-6,
  8.11789239554389293311e-8,
  3.41551784765923618484e-10,
};
static float AGD[10] = {
/*  1.00000000000000000000e0,*/
  9.30892908077441974853e0,
  1.98352928718312140417e1,
  1.55646628932864612953e1,
  5.47686069422975497931e0,
  9.54293611618961883998e-1,
  8.64580826352392193095e-2,
  4.12656523824222607191e-3,
  1.01259085116509135510e-4,
  1.17166733214413521882e-6,
  4.91834570062930015649e-9,
};

static float APFN[9] = {
  1.85365624022535566142e-1,
  8.86712188052584095637e-1,
  9.87391981747398547272e-1,
  4.01241082318003734092e-1,
  7.10304926289631174579e-2,
  5.90618657995661810071e-3,
  2.33051409401776799569e-4,
  4.08718778289035454598e-6,
  2.48379932900442457853e-8,
};
static float APFD[9] = {
/*  1.00000000000000000000e0,*/
  1.47345854687502542552e1,
  3.75423933435489594466e1,
  3.14657751203046424330e1,
  1.09969125207298778536e1,
  1.78885054766999417817e0,
  1.41733275753662636873e-1,
  5.44066067017226003627e-3,
  9.39421290654511171663e-5,
  5.65978713036027009243e-7,
};

static float APGN[11] = {
-3.55615429033082288335e-2,
-6.37311518129435504426e-1,
-1.70856738884312371053e0,
-1.50221872117316635393e0,
-5.63606665822102676611e-1,
-1.02101031120216891789e-1,
-9.48396695961445269093e-3,
-4.60325307486780994357e-4,
-1.14300836484517375919e-5,
-1.33415518685547420648e-7,
-5.63803833958893494476e-10,
};
static float APGD[11] = {
/*  1.00000000000000000000e0,*/
  9.85865801696130355144e0,
  2.16401867356585941885e1,
  1.73130776389749389525e1,
  6.17872175280828766327e0,
  1.08848694396321495475e0,
  9.95005543440888479402e-2,
  4.78468199683886610842e-3,
  1.18159633322838625562e-4,
  1.37480673554219441465e-6,
  5.79912514929147598821e-9,
};

#define fabsf(x) ( (x) < 0 ? -(x) : (x) )

#ifdef ANSIC
float polevlf(float, float *, int);
float p1evlf(float, float *, int);
float sinf(float), cosf(float), expf(float), sqrtf(float);

int airyf( float xx, float *ai, float *aip, float *bi, float *bip )

#else
float polevlf(), p1evlf(), sinf(), cosf(), expf(), sqrtf();

int airyf( xx, ai, aip, bi, bip )
double xx;
float *ai, *aip, *bi, *bip;
#endif
{
float x, z, zz, t, f, g, uf, ug, k, zeta, theta;
int domflg;

x = xx;
domflg = 0;
if( x > MAXAIRY )
	{
	*ai = 0;
	*aip = 0;
	*bi = MAXNUMF;
	*bip = MAXNUMF;
	return(-1);
	}

if( x < -2.09 )
	{
	domflg = 15;
	t = sqrtf(-x);
	zeta = -2.0 * x * t / 3.0;
	t = sqrtf(t);
	k = sqpii / t;
	z = 1.0/zeta;
	zz = z * z;
	uf = 1.0 + zz * polevlf( zz, AFN, 8 ) / p1evlf( zz, AFD, 9 );
	ug = z * polevlf( zz, AGN, 10 ) / p1evlf( zz, AGD, 10 );
	theta = zeta + 0.25 * PIF;
	f = sinf( theta );
	g = cosf( theta );
	*ai = k * (f * uf - g * ug);
	*bi = k * (g * uf + f * ug);
	uf = 1.0 + zz * polevlf( zz, APFN, 8 ) / p1evlf( zz, APFD, 9 );
	ug = z * polevlf( zz, APGN, 10 ) / p1evlf( zz, APGD, 10 );
	k = sqpii * t;
	*aip = -k * (g * uf + f * ug);
	*bip = k * (f * uf - g * ug);
	return(0);
	}

if( x >= 2.09 )	/* cbrt(9) */
	{
	domflg = 5;
	t = sqrtf(x);
	zeta = 2.0 * x * t / 3.0;
	g = expf( zeta );
	t = sqrtf(t);
	k = 2.0 * t * g;
	z = 1.0/zeta;
	f = polevlf( z, AN, 7 ) / polevlf( z, AD, 7 );
	*ai = sqpii * f / k;
	k = -0.5 * sqpii * t / g;
	f = polevlf( z, APN, 7 ) / polevlf( z, APD, 7 );
	*aip = f * k;

	if( x > 8.3203353 )	/* zeta > 16 */
		{
		f = z * polevlf( z, BN16, 4 ) / p1evlf( z, BD16, 5 );
		k = sqpii * g;
		*bi = k * (1.0 + f) / t;
		f = z * polevlf( z, BPPN, 4 ) / p1evlf( z, BPPD, 5 );
		*bip = k * t * (1.0 + f);
		return(0);
		}
	}

f = 1.0;
g = x;
t = 1.0;
uf = 1.0;
ug = x;
k = 1.0;
z = x * x * x;
while( t > MACHEPF )
	{
	uf *= z;
	k += 1.0;
	uf /=k;
	ug *= z;
	k += 1.0;
	ug /=k;
	uf /=k;
	f += uf;
	k += 1.0;
	ug /=k;
	g += ug;
	t = fabsf(uf/f);
	}
uf = c1 * f;
ug = c2 * g;
if( (domflg & 1) == 0 )
	*ai = uf - ug;
if( (domflg & 2) == 0 )
	*bi = sqrt3 * (uf + ug);

/* the deriviative of ai */
k = 4.0;
uf = x * x/2.0;
ug = z/3.0;
f = uf;
g = 1.0 + ug;
uf /= 3.0;
t = 1.0;

while( t > MACHEPF )
	{
	uf *= z;
	ug /=k;
	k += 1.0;
	ug *= z;
	uf /=k;
	f += uf;
	k += 1.0;
	ug /=k;
	uf /=k;
	g += ug;
	k += 1.0;
	t = fabsf(ug/g);
	}

uf = c1 * f;
ug = c2 * g;
if( (domflg & 4) == 0 )
	*aip = uf - ug;
if( (domflg & 8) == 0 )
	*bip = sqrt3 * (uf + ug);
return(0);
}
