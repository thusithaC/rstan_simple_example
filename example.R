library(data.table)
library(rstan)

options(mc.cores = parallel::detectCores())

# y ~ Gamma(a, b)
# a = mu^2/sigma^2
# b = mu/sigma^2 (rate)
# sigma = p*mu + q*x + r

# generate mu as randint , x rnorm

# params
p = 1.5
q = -0.2
r = 0.5

########### Data generaition #########################

N = 1000
x = rnorm(N, 0, 1)
mu = runif(N, 1, 50)

sigma = p*mu + q*x + r

a = mu^2/sigma^2
b = mu/sigma^2

y = rgamma(N, shape = a, rate = b)

dat = list(
  N = N,
  y = y,
  mu = mu,
  x = x
)

############# Fitting Stan model ##################

fit1 <- stan(
  file = "simple_model.stan",  # Stan program
  data = dat,    # named list of data
  chains = 4,             # number of Markov chains
  warmup = 1000,          # number of warmup iterations per chain
  iter = 2000,            # total number of iterations per chain
  cores = 4,              # number of cores (could use one per chain)
  refresh = 1             # no progress shown
)