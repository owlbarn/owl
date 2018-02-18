# Execute this file from the toplevel owl directory with:
# python test/stats_scipy_get_distributions.py
#
# to generate piecewise distribution data to be included in source 
# for stats rv tests


import scipy.stats
import math

class base:
    dut_pdf = "fun _ -> 0."
    dut_cdf = "fun _ -> 0."
    has_ppf = True
    ofs = (0.0000001,0.0000001) # How close to get to 0,1 for CDF
    lx = -1000.0
    rx = 1000.0
    imprecision = 1.0 # Hack because some have fat tails that this does not work too well for
    num_points = 64
    def __init__(self, num_points=None):
        if num_points is not None:
            self.num_points = num_points

class uniform(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, a, b, **kwargs):
        base.__init__(self, **kwargs)
        a = a + 0.
        b = b + 0.
        self.lx = a-1
        self.rx = b+1
        self.a = a
        self.b = b
        self.dist = self
        self.name = "uniform"
        self.dut_base_fn = "uniform_%%s ~a:(%f) ~b:(%f)" % (a, b)
        pass
    def __str__(self):
        return "uniform_a_%f_b_%f" % (self.a,self.b)
    def pdf(self,x):
        if x<self.a:
            return 0
        elif x>self.b:
            return 0
        else:
            return 1/(self.b-self.a)
    def cdf(self,x):
        if x<self.a:
            return 0
        elif x>self.b:
            return 1
        else:
            return (x-self.a)/(self.b-self.a)

class norm(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, mean, sd, **kwargs):
        base.__init__(self, **kwargs)
        self.mean = mean
        self.sd = sd
        self.dist = scipy.stats.norm(mean,sd)
        self.name = "norm"
        self.dut_base_fn = "gaussian_%%s ~mu:(%f) ~sigma:(%f)" % (mean, sd)
        pass
    def __str__(self):
        return "gaussian_u_%f_sd_%f" % (self.mean, self.sd)

class beta(base):
    lx = 0.0
    rx = 1.0
    def __init__(self, alpha, beta, **kwargs):
        base.__init__(self, **kwargs)
        self.alpha = alpha
        self.beta = beta
        self.dist = scipy.stats.beta(alpha,beta)
        self.name = "beta"
        self.dut_base_fn = "beta_%%s ~a:(%f) ~b:(%f)" % (alpha, beta)
        pass
    def __str__(self):
        return "beta_a_%f_b_%f" % (self.alpha, self.beta)

class exponential(base):
    lx = 0.0
    rx = 1000.0
    def __init__(self, lamb, **kwargs):
        base.__init__(self, **kwargs)
        self.lamb = lamb
        self.dist = scipy.stats.expon(scale=1/lamb)
        self.name = "exponential"
        self.dut_base_fn = "exponential_%%s ~lambda:(%f)" % (lamb)
        pass
    def __str__(self):
        return "exponential_%f" % (self.lamb)

class cauchy(base):
    lx = -1E8
    rx = 1E8
    def __init__(self, loc, scale, **kwargs):
        base.__init__(self, **kwargs)
        self.loc = loc
        self.scale = scale
        self.dist = scipy.stats.cauchy(loc=loc,scale=scale)
        self.name = "cauchy"
        self.dut_base_fn = "cauchy_%%s ~loc:(%f) ~scale:(%f)" % (loc, scale)
        pass
    def __str__(self):
        return "cauchy_loc_%f_scale_%f" % (self.loc, self.scale)

class chi2(base):
    lx = 0.0
    rx = 1000.0
    def __init__(self, df, **kwargs):
        base.__init__(self, **kwargs)
        self.df = df
        self.dist = scipy.stats.chi2(df)
        self.name = "chi2"
        self.dut_base_fn = "chi2_%%s ~df:(%f)" % (df)
        pass
    def __str__(self):
        return "chi2_%f" % (self.df)

class gamma(base):
    lx = 1E-10
    rx = 1E8
    def __init__(self, shape, scale, **kwargs):
        base.__init__(self, **kwargs)
        self.shape = shape
        self.scale = scale
        self.dist = scipy.stats.gamma(a=shape,scale=scale)
        self.name = "gamma"
        self.dut_base_fn = "gamma_%%s ~shape:(%f) ~scale:(%f)" % (shape, scale)
        pass
    def __str__(self):
        return "gamma_shape_%f_scale_%f" % (self.shape, self.scale)

class laplace(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, loc, scale, **kwargs):
        base.__init__(self, **kwargs)
        self.loc = loc
        self.scale = scale
        self.dist = scipy.stats.laplace(loc=loc,scale=scale)
        self.name = "laplace"
        self.dut_base_fn = "laplace_%%s ~loc:(%f) ~scale:(%f)" % (loc, scale)
        pass
    def __str__(self):
        return "laplace_loc_%f_scale_%f" % (self.loc, self.scale)

class lomax(base):
    lx = 1E-10
    rx = 1E8
    def __init__(self, shape, scale, **kwargs):
        base.__init__(self, **kwargs)
        self.shape = shape
        self.scale = scale
        self.dist = scipy.stats.lomax(c=shape,scale=scale,loc=1.)
        if scale!=1.0: raise Exception("Lomax scipy scale != lomax ocaml scale")
        self.name = "lomax"
        self.dut_base_fn = "lomax_%%s ~shape:(%f) ~scale:(%f)" % (shape,scale)
        pass
    def __str__(self):
        return "lomax_shape_%f_scale_%f" % (self.shape,self.scale)

class lognormal(base):
    lx = 1E-10
    rx = 1E8
    def __init__(self, mean, sd, **kwargs):
        base.__init__(self, **kwargs)
        self.mean = mean
        self.sd = sd
        self.dist = scipy.stats.lognorm(scale=math.exp(mean),s=sd)
        self.name = "lognormal"
        self.dut_base_fn = "lognormal_%%s ~mu:(%f) ~sigma:(%f)" % (mean, sd)
        pass
    def __str__(self):
        return "lognormal_mu_%f_sd_%f" % (self.mean, self.sd)

class gumbel1(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, a, b, **kwargs):
        base.__init__(self, **kwargs)
        self.a = a
        self.b = b
        # Gumbel type 1 in wikipedia is pdf = ab.exp(-(ax+b.exp(-ax)))
        # Scipy gumbel_r is             pdf =    exp(-(x+exp(-x))
        # applying scale and loc (1/s,l) (scipy x = s.x-s.l)
        # Scipy gumbel_r is             pdf =  s.exp(-(sx+-sl+exp(-sx+sl))
        #                                   =  s.exp(ls-(sx+exp(-sx)*exp(ls))
        #                                   = s.exp(ls).exp(-(sx+exp(ls).exp(-sx))
        # Hence a=s, b=exp(ls), or s=a, l=log(b)/s = log(b)/a
        # and note that scale = 1/s = 1/a
        self.dist = scipy.stats.gumbel_r(loc=math.log(b)/a,scale=1.0/a)
        self.name = "gumbel1"
        self.dut_base_fn = "gumbel1_%%s ~a:(%f) ~b:(%f)" % (a, b)
        pass
    def __str__(self):
        return "gumbel1_a_%f_b_%f" % (self.a, self.b)

class gumbel2(base):
    lx = 1E-10
    rx = 1E8
    def __init__(self, a, b, **kwargs):
        base.__init__(self, **kwargs)
        self.a = a
        self.b = b
        # There is no current scipy variant
        self.dist = self
        self.name = "gumbel2"
        self.dut_base_fn = "gumbel2_%%s ~a:(%f) ~b:(%f)" % (a, b)
        pass
    def __str__(self):
        return "gumbel2_a_%f_b_%f" % (self.a, self.b)
    def pdf(self,x):
        if x<=0:
            return 0
        else:
            return self.a * self.b * math.pow(x,(-self.a-1)) * math.exp(-self.b*math.pow(x,-self.a))
    def cdf(self,x):
        if x<=0:
            return 0
        else:
            return math.exp(-self.b*math.pow(x,-self.a))

class logistic(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, loc, scale, **kwargs):
        base.__init__(self, **kwargs)
        self.loc = loc
        self.scale = scale
        self.dist = scipy.stats.logistic(loc=loc,scale=scale)
        self.name = "logistic"
        self.dut_base_fn = "logistic_%%s ~loc:(%f) ~scale:(%f)" % (loc, scale)
        pass
    def __str__(self):
        return "logistic_loc_%f_scale_%f" % (self.loc, self.scale)

class rayleigh(base):
    lx = 0.0
    rx = 1000
    def __init__(self, sigma, **kwargs):
        base.__init__(self, **kwargs)
        self.sigma = sigma
        self.dist = scipy.stats.rayleigh(scale=sigma)
        self.name = "rayleigh"
        self.dut_base_fn = "rayleigh_%%s ~sigma:(%f)" % (sigma)
        pass
    def __str__(self):
        return "rayleigh_%f" % (self.sigma)

class vonmises(base):
    has_ppf = False
    def __init__(self, mu, kappa, **kwargs):
        base.__init__(self, **kwargs)
        self.lx = mu-math.pi+1E-10
        self.rx = mu+math.pi-1E-10
        self.mu = mu
        self.kappa = kappa
        self.dist = scipy.stats.vonmises(kappa=kappa, loc=mu)
        self.dut_base_fn = "vonmises_%%s ~mu:(%f) ~kappa:(%f)" % (mu, kappa)
        self.name = "vonmises"
        pass
    def __str__(self):
        return "vonmises_mu_%f_kappa_%f" % (self.mu, self.kappa)

class students(base):
    lx = -1E8
    rx = 1E8
    def __init__(self, df, loc, scale, **kwargs):
        base.__init__(self, **kwargs)
        self.df = df
        self.loc = loc
        self.scale = scale
        self.dist = scipy.stats.t(df=df,loc=loc,scale=scale)
        self.name = "students"
        self.dut_base_fn = "t_%%s ~df:(%f) ~loc:(%f) ~scale:(%f)" % (df, loc, scale)
        pass
    def __str__(self):
        return "students_%f_loc_%f_scale_%f" % (self.df,self.loc,self.scale)


class snecdor(base):
    lx = 0
    rx = 1E12
    ofs = (0.000001,0.001) # How close to get to 0 or 1 for CDF
    imprecision = 100
    def __init__(self, dfnum, dfden, **kwargs):
        base.__init__(self, **kwargs)
        self.dfnum = dfnum
        self.dfden = dfden
        self.dist = scipy.stats.f(dfn=dfnum,dfd=dfden)
        self.name = "snecdor"
        self.dut_base_fn = "f_%%s ~dfnum:(%f) ~dfden:(%f)" % (dfnum, dfden)
        pass
    def __str__(self):
        return "snecdor_dfnum_%f_dfden_%f" % (self.dfnum, self.dfden)

class weibull(base):
    lx = 1E-10
    rx = 1E8
    def __init__(self, shape, scale, **kwargs):
        base.__init__(self, **kwargs)
        self.shape = shape
        self.scale = scale
        self.dist = scipy.stats.weibull_min(c=shape,scale=scale,loc=0.)
        self.name = "weibull"
        self.dut_base_fn = "weibull_%%s ~shape:(%f) ~scale:(%f)" % (shape,scale)
        pass
    def __str__(self):
        return "weibull_shape_%f_scale_%f" % (self.shape,self.scale)




def find_value(cdf, lx, rx, y, n=0, delta=1E-8):
  vl = cdf(lx)
  vr = cdf(rx)
  mx = (lx+rx)/2
  vm = cdf(mx)
  #print "lx %f rx %f mx %f vm %f y %f delta %g vm-y %g" % (lx,rx,mx,vm,y,delta,vm-y)
  if (n>80):
      return None
  if (vm<y-delta):
    return find_value(cdf, mx,rx,y,n+1,delta)
  elif (vm>y+delta):
    return find_value(cdf, lx,mx,y,n+1,delta)
  else:
    return (lx+rx)/2

def show_dist(d):
    dist = d.dist
    offsets = d.ofs
    n = d.num_points
    lx = d.lx
    rx = d.rx
    cdf = dist.cdf
    pdf = dist.pdf
    cdf_x_of_p = []
    pdf_of_p = []
    for i in range(n+1):
       v = offsets[0] + i*(1-(offsets[0]+offsets[1]))/n
       x = find_value(cdf, lx, rx, v)
       if x is None:
           raise Exception("Failed to find CDF probability %12.10f between X of %f and %f"%(v,lx,rx))
       #print "Find ",v," got ",x
       cdf_x_of_p.append(x)
       pdf_of_p.append(pdf(x))
       pass
    ppf_name = "Some ("+ (d.dut_base_fn % "ppf"+")")
    isf_name = "Some ("+ (d.dut_base_fn % "isf"+")")
    if not d.has_ppf:
        ppf_name = "None"
        isf_name = "None"
        pass
    result = '( "%s", (%f), (%s),\n   (%s),\n   (%s),\n   (%s),\n   (%s),\n   (%s),\n   (%s),\n   (%s),\n' % (
        str(d),
         d.imprecision,
         d.dut_base_fn % "cdf",
         d.dut_base_fn % "pdf",
         d.dut_base_fn % "logcdf",
         d.dut_base_fn % "logpdf",
         ppf_name,
         d.dut_base_fn % "sf",
         d.dut_base_fn % "logsf",
         isf_name,
         )
    result += '[|'
    for v in cdf_x_of_p:
        result += "%f;"%v
        pass
    result +="|],\n"
    result += '[|'
    for v in pdf_of_p:
        result += "%f;"%v
        pass
    result +="|] \n"
    result +=");\n"
    print result
    pass

distributions = [
                  students(df=1.,loc=0.,scale=1.),
                  students(df=2.,loc=0.,scale=1.),
                  students(df=5.,loc=0.,scale=1.),
                  students(df=10.,loc=0.,scale=1.),
                  students(df=3.,loc=1.,scale=1.),
                  students(df=4.,loc=2.,scale=4.),
                  weibull(shape=1.,scale=1.),
                  weibull(shape=1.5,scale=1.),
                  weibull(shape=5.0,scale=1.),
                  weibull(shape=0.8,scale=1.),
                  weibull(shape=2.0,scale=2.),
                  snecdor(dfnum=1.,dfden=1.),
                  snecdor(dfnum=2.,dfden=1.),
                  snecdor(dfnum=5.,dfden=2.),
                  snecdor(dfnum=10.,dfden=1.),
                  gamma(shape=1.0,scale=1.0),
                  gamma(shape=1.0,scale=2.0),
                  gamma(shape=0.9,scale=1.0),
                  gamma(shape=1.5,scale=1.0),
                  gamma(shape=2.5,scale=1.0),
                  gamma(shape=3.,scale=2.0),
                  uniform(a=1.,b=2.),
                  uniform(a=100.,b=200.),
                  uniform(a=-10.,b=10.),
                  vonmises(mu=0.,kappa=1.),
                  vonmises(mu=0.,kappa=0.01),
                  vonmises(mu=0.,kappa=0.5),
                  vonmises(mu=0.,kappa=2.),
                  vonmises(mu=0.,kappa=4.),
                  vonmises(mu=2.,kappa=2.),
                  rayleigh(sigma=1.0),
                  rayleigh(sigma=1.5),
                  rayleigh(sigma=0.5),
                  rayleigh(sigma=2.0),
                #  logistic(loc=0.,scale=1.), - ppf does not work yet
                #  logistic(loc=-1.,scale=1.),
                #  logistic(loc=0.,scale=0.5),
                #  logistic(loc=0.,scale=1.5),
                  gumbel2(a=3.,b=1.),
                  gumbel2(a=1.,b=1.),
                  gumbel2(a=1.,b=0.9),
                  gumbel2(a=4,b=0.9),
                  gumbel2(a=0.9,b=1.),
                  gumbel1(a=0.5,b=0.5),
                  gumbel1(a=0.5,b=0.9),
                  gumbel1(a=0.5,b=1.),
                  gumbel1(a=1.,b=0.5),
                  gumbel1(a=1.,b=1.),
                  lognormal(mean=0.,sd=2.5),
                  lognormal(mean=0.,sd=0.25),
                  lognormal(mean=0.,sd=0.5),
                  lognormal(mean=0.,sd=0.75),
                  lognormal(mean=0.,sd=1.0),
                  lognormal(mean=0.,sd=1.5),
                  lognormal(mean=2.,sd=1.5),
                  cauchy(loc=0.,scale=0.5,num_points=64),
                  cauchy(loc=0.,scale=1.0,num_points=64),
                  cauchy(loc=0.,scale=2.0,num_points=64),
                  cauchy(loc=-1.,scale=3.0,num_points=64),
                  lomax(shape=2,scale=1,num_points=64),
                  lomax(shape=1,scale=1,num_points=64),
                  lomax(shape=4,scale=1,num_points=64),
                  laplace(loc=0.0,scale=0.5,num_points=64),
                  laplace(loc=-1.0,scale=0.7,num_points=64),
                  laplace(loc=1.0,scale=3.0,num_points=64),
                  norm(1.0,2.0),
                  norm(1.0,1.0),
                  norm(0.0,1.0),
                  beta(0.5,0.7,num_points=128),
                  beta(1.0,1.0),
                  beta(2.0,1.0),
                  beta(3.0,1.0),
                  beta(1.0,2.0),
                  beta(2.0,3.0),
                  beta(3.0,4.0),
                  beta(2.0,5.0),
                  exponential(0.5),
                  exponential(1.0),
                  exponential(1.5),
                  exponential(2.0),
                  exponential(3.0),
                  exponential(3.5),
                  exponential(4.0),
                  chi2(df=1.),
                  chi2(df=2.),
                  chi2(df=4.),
                  chi2(df=6.),
                  chi2(df=8.),
                  chi2(df=30.),
                 ]

print "module M = Owl_stats"
print "let cdf_approximations = M.["
for d in distributions:
  show_dist(d)
  pass
print "]"

