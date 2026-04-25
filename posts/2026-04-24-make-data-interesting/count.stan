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
transformed parameters{
  real logit_psi;
  real log_lam;
  for (n in 1:N) {
    logit_psi = alpha_psi + beta_psi * x[n];
    log_lam = alpha_lam + beta_lam * x[n];
  }
}
model {
  // Priors
  alpha_psi ~ normal(0, 1);
  beta_psi  ~ normal(0, 1);
  alpha_lam ~ normal(0, 1);
  beta_lam  ~ normal(0, 1);

  // Likelihood
  for (n in 1:N) {
    if (y[n] == 0) {
      target += log_sum_exp(bernoulli_logit_lpmf(1 | logit_psi),
                            bernoulli_logit_lpmf(0 | logit_psi) + 
                            poisson_log_lpmf(0 | log_lam));
    } else {
      target += bernoulli_logit_lpmf(0 | logit_psi) + 
                poisson_log_lpmf(y[n] | log_lam);
    }
  }
}
generated quantities {
  array[N] int y_rep;
  vector[N] log_lik;
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
    
    // 3. Optional: Calculate log_likelihood for LOO/WAIC calculations
    if (y[n] == 0) {
      log_lik[n] = log_sum_exp(bernoulli_logit_lpmf(1 | alpha_psi + beta_psi * x[n]),
                               bernoulli_logit_lpmf(0 | alpha_psi + beta_psi * x[n]) + 
                               poisson_log_lpmf(0 | alpha_lam + beta_lam * x[n]));
    } else {
      log_lik[n] = bernoulli_logit_lpmf(0 | alpha_psi + beta_psi * x[n]) + 
                   poisson_log_lpmf(y[n] | alpha_lam + beta_lam * x[n]);
    }
  }
}