data {
  int<lower=0> N;
  vector[N] x;
  vector[N] y;
}
parameters {
  real a; // Intercept
  real b; // Linear coefficient
  real c; // Quadratic coefficient
  real<lower=0> sigma; // Noise
}
model {
  // Priors
  a ~ normal(0, 2);
  b ~ normal(0, 2);
  c ~ normal(0, 2);
  sigma ~ exponential(1);

  // Curvilinear (quadratic) model
  y ~ normal(a + b * x + c * square(x), sigma);
}
generated quantities {
  vector[N] y_rep;

  for (n in 1:N) {
    // Generate new data using posterior draws of parameters
    y_rep[n] = normal_rng(a + b * x[n] + c * square(x[n]), sigma);
  }
}