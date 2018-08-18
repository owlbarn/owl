/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <math.h>
#include <stdlib.h>
#include "owl_stats.h"

static uint32_t kn[128], ke[256];
static double wn[128], fn[128], we[256], fe[256];


// init the internal state for exponential prng
inline double std_exponential_rvs ( ) {
  float value, x;
  uint32_t jz = sfmt_rand32;
  uint32_t iz = ( jz & 255 );

  if ( jz < ke[iz] )
    value = jz * we[iz];
  else {
    for ( ; ; ) {
      if ( iz == 0 ) {
        value = 7.69711 - log ( sfmt_f64_1 );
        break;
      }

      x = jz * we[iz];

      if ( fe[iz] + sfmt_f64_1 * ( fe[iz-1] - fe[iz] ) < exp ( - x ) ) {
        value = x;
        break;
      }

      jz = sfmt_rand32;
      iz = ( jz & 255 );

      if ( jz < ke[iz] ) {
        value = jz * we[iz];
        break;
      }
    }
  }
  return value;
}


inline double exponential_rvs (double lambda) {
  return (lambda * std_exponential_rvs());
}


// init the internal state for exponential prng
void std_exponential_rvs_init ( ) {
  double de = 7.697117470131487;
  const double m2 = 2147483648.0;
  double te = 7.697117470131487;
  const double ve = 3.949659822581572E-03;

  double q = ve / exp ( - de );

  ke[0] = ( uint32_t ) ( ( de / q ) * m2 );
  ke[1] = 0;

  we[0] = q / m2;
  we[255] = de / m2;

  fe[0] = 1.0;
  fe[255] =exp ( - de );

  for ( int i = 254; 1 <= i; i-- ) {
    de = - log ( ve / de + exp ( - de ) );
    ke[i+1] = ( uint32_t ) ( ( de / te ) * m2 );
    te = de;
    fe[i] = exp ( - de );
    we[i] = de / m2;
  }
}

// generate a prng of gaussian distribution
inline double std_gaussian_rvs ( ) {
  const double r = 3.442620;
  double value, x, y;

  int hz = ( int ) sfmt_rand32;
  uint32_t iz = ( hz & 127 );

  if ( abs ( hz ) < kn[iz] )
    value = hz * wn[iz];
  else {
    for ( ; ; ) {
      if ( iz == 0 ) {
        for ( ; ; ) {
          x = - 0.2904764 * log ( sfmt_f64_1 );
          y = - log ( sfmt_f64_1 );
          if ( x * x <= y + y )
            break;
        }
        value = ( hz > 0 ) ? (+ r + x) : (- r - x);
        break;
      }

      x = hz * wn[iz];

      if ( fn[iz] + ( sfmt_f64_1 ) * ( fn[iz-1] - fn[iz] ) < exp ( - 0.5 * x * x ) ) {
        value = x;
        break;
      }

      hz = ( int ) sfmt_rand32;
      iz = ( hz & 127 );

      if ( abs ( hz ) < kn[iz] ) {
        value = hz * wn[iz];
        break;
      }
    }
  }

  return value;
}


inline double gaussian_rvs (double mu, double sigma) {
  return (mu + sigma * std_gaussian_rvs());
}


// init the internal state for gaussian prng
void std_gaussian_rvs_init ( ) {
  double dn = 3.442619855899;
  const double m1 = 2147483648.0;
  double tn = 3.442619855899;
  const double vn = 9.91256303526217E-03;

  double q = vn / exp ( - 0.5 * dn * dn );

  kn[0] = ( uint32_t ) ( ( dn / q ) * m1 );
  kn[1] = 0;

  wn[0] = q / m1;
  wn[127] = dn / m1;

  fn[0] = 1.0;
  fn[127] = exp ( - 0.5 * dn * dn );

  for ( int i = 126; 1 <= i; i-- ) {
    dn = sqrt ( - 2.0 * log ( vn / dn + exp ( - 0.5 * dn * dn ) ) );
    kn[i+1] = ( uint32_t ) ( ( dn / tn ) * m1 );
    tn = dn;
    fn[i] = exp ( - 0.5 * dn * dn );
    wn[i] = dn / m1;
  }
}


// init the internal table of ziggurat module
void ziggurat_init ( ) {
  std_exponential_rvs_init();
  std_gaussian_rvs_init();
}
