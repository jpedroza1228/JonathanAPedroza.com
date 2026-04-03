data {
  int<lower=0> N;
  array[N] int<lower=0> y;
  vector[N] x;
}
parameters {
  real alpha_psi; 
  real beta_psi;
  real alpha_lam;
  real beta_lam;
}
model {
  // Priors
  alpha_psi ~ normal(0, 1);
  beta_psi  ~ normal(0, 1);
  alpha_lam ~ normal(0, 1);
  beta_lam  ~ normal(0, 1);
}
generated quantities {
  array[N] int y_rep;
  real psi;
  real lam;

  for (n in 1:N) {
    // 1. Calculate the probability of being in the "Always Zero" state
    psi = inv_logit(alpha_psi + beta_psi * x[n]);
    lam = exp(alpha_lam + beta_lam * x[n]);
    
    // 2. Generate y_rep using the mixture logic
    if (bernoulli_rng(psi)) {
      y_rep[n] = 0;
    } else {
      y_rep[n] = poisson_rng(lam);
    }
  }
}