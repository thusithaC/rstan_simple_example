data {
  int<lower=0> N;
  vector[N] y;
  vector[N] mu;
  vector[N] x;
}
parameters {
  real p;
  real q;
  real r;
  vector<lower=0>[N] sigma;
  real<lower=0> sigma_lm;
}
transformed parameters {
  vector[N] alpha;
  vector[N] beta;
  alpha = (mu .* mu) ./ (sigma .* sigma);
  beta = mu ./ (sigma .* sigma);
}
model {
  y ~ gamma(alpha, beta);
  sigma ~ normal(p*mu + q*x + r, sigma_lm);
}

