data {
  int<lower=0> N;
  vector[N] x;
  vector[N] y;
}
parameters {
  real a; // Intercept
  real b; // Linear coefficient
  real<lower=0> sigma; // Noise
}
model {
  // Priors
  a ~ normal(0, 2);
  b ~ normal(0, 2);
  sigma ~ exponential(1);
}
generated quantities {
  vector[N] y_rep;

  for (n in 1:N) {
    // Generate new data using posterior draws of parameters
    y_rep[n] = normal_rng(a + b * x[n], sigma);
  }
}