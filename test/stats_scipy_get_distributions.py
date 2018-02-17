import scipy.stats

class base:
    dut_pdf = "fun _ -> 0."
    dut_cdf = "fun _ -> 0."
    lx = -1000.0
    rx = 1000.0

class norm(base):
    def __init__(self, mean, sd):
        self.mean = mean
        self.sd = sd
        self.dist = scipy.stats.norm(mean,sd)
        self.name = "norm"
        self.dut_pdf = "gaussian_pdf ~mu:%f ~sigma:%f" % (mean, sd)
        self.dut_cdf = "gaussian_cdf ~mu:%f ~sigma:%f" % (mean, sd)
        pass
    def __str__(self):
        return "gaussian_u_%f_sd_%f" % (self.mean, self.sd)

class beta(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, alpha, beta):
        self.alpha = alpha
        self.beta = beta
        self.dist = scipy.stats.beta(alpha,beta)
        self.name = "beta"
        pass
    def __str__(self):
        return "beta_a_%f_b_%f" % (self.alpha, self.beta)

class exponential(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, lamb):
        self.lamb = lamb
        self.dist = scipy.stats.expon(lamb)
        self.name = "exponential"
        pass
    def __str__(self):
        return "exponential_%f" % (self.lamb)

class cauchy(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, lamb):
        self.lamb = lamb
        self.dist = scipy.stats.cauchy(lamb)
        self.name = "cauchy"
        pass
    def __str__(self):
        return "cauchy_%f" % (self.lamb)

class chi2(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.chi2(lamb)
        self.name = "chi2"
        pass
    def __str__(self):
        return "chi2_%f" % (self.df)

class laplace(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.laplace(lamb)
        self.name = "laplace"
        pass
    def __str__(self):
        return "laplace_%f" % (self.df)

class lomax(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.lomax(lamb)
        self.name = "lomax"
        pass
    def __str__(self):
        return "lomax_%f" % (self.df)

class lognormal(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.lognorm(lamb)
        self.name = "lognormal"
        pass
    def __str__(self):
        return "lognormal_%f" % (self.df)

class logistic(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.logistic(lamb)
        self.name = "logistic"
        pass
    def __str__(self):
        return "logistic_%f" % (self.df)

class gumbel1(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.gumbel1(lamb)
        self.name = "gumbel1"
        pass
    def __str__(self):
        return "gumbel1_%f" % (self.df)

class gumbel2(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.gumbel_r(lamb)
        self.name = "gumbel2"
        pass
    def __str__(self):
        return "gumbel2_%f" % (self.df)

class rayleigh(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.rayleigh(lamb)
        self.name = "rayleigh"
        pass
    def __str__(self):
        return "rayleigh_%f" % (self.df)

class vonmises(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.vonmises(lamb)
        self.name = "vonmises"
        pass
    def __str__(self):
        return "vonmises_%f" % (self.df)

class students(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.t(lamb)
        self.name = "students"
        pass
    def __str__(self):
        return "students_%f" % (self.df)


class snecdor(base):
    lx = -1000.0
    rx = 1000.0
    def __init__(self, df):
        self.df = df
        self.dist = scipy.stats.f(lamb)
        self.name = "snecdor"
        pass
    def __str__(self):
        return "snecdor_%f" % (self.df)




def find_value(cdf, lx, rx, y, n=0, delta=1E-8):
  vl = cdf(lx)
  vr = cdf(rx)
  mx = (lx+rx)/2
  vm = cdf(mx)
  #print "lx %f rx %f mx %f vm %f y %f" % (lx,rx,mx,vm,y)
  if (n>60):
      return None
  if (vm<y-delta):
    return find_value(cdf, mx,rx,y,n+1,delta)
  elif (vm>y+delta):
    return find_value(cdf, lx,mx,y,n+1,delta)
  else:
    return (lx+rx)/2

def show_dist(d):
    ofs = 0.0000001
    n = 32
    dist = d.dist
    lx = d.lx
    rx = d.rx
    cdf = dist.cdf
    pdf = dist.pdf
    cdf_x_of_p = []
    pdf_of_p = []
    for i in range(n+1):
       v = (ofs) + i*(1-2*ofs)/n
       x = find_value(cdf, lx, rx, v)
       if x is None:
           raise Exception("Banana")
       #print "Find ",v," got ",x
       cdf_x_of_p.append(x)
       pdf_of_p.append(pdf(x))
       pass
    result = '( "%s", (%s), (%s), \n' % (str(d), d.dut_cdf, d.dut_pdf)
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
    result +=")\n"
    print result
    pass

distributions = [ norm(1.0,2.0),
                  norm(1.0,1.0),
                  norm(0.0,1.0),
                  beta(0.5,0.7),
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
                 ]

for d in distributions:
  show_dist(d)

